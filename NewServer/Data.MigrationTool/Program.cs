using Hero.Server.Core.Database;
using Hero.Server.Core.Models;
using Hero.Server.Core.Models.Storyline;
using Hero.Server.DataAccess.Database;
using Hero.Server.DataAccess.Extensions;

using Kalinar.Application.Contracts;
using Kalinar.Application.Extensions;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;
using Kalinar.Data.Extensions;
using Kalinar.Messages.Requests;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

using Attribute = Hero.Server.Core.Models.Attribute;
using HeroSuggestionState = Hero.Server.Core.Models.SuggestionState;

const string KalinarGroup = "5e4e945c-dffd-43a2-9604-45e5f03d777f";
string KalinarConnectionString = Environment.GetEnvironmentVariable("ConnectionStrings__Database")!;
string HeroConnectionString = Environment.GetEnvironmentVariable("ConnectionStrings__Default__Production")!;

ServiceCollection services = new();

services.AddApplicationLayer();
services.AddDataLayer(KalinarConnectionString);

services.AddDataAccessLayer(HeroConnectionString);

IServiceProvider provider = services.BuildServiceProvider();

IGroupContextBuilder groupContext = provider.GetRequiredService<IGroupContextBuilder>();

groupContext.Apply(new Guid(KalinarGroup));

HeroDbContext heroContext = provider.GetRequiredService<HeroDbContext>();
Context context = provider.GetRequiredService<Context>();

await context.Database.MigrateAsync();

// Users
Dictionary<string, UserEntity> migratedUsers = new();
IUserService userService = provider.GetRequiredService<IUserService>();
foreach (User user in await heroContext.Users.ToListAsync())
{
    UserEntity migratedUser = await userService.CreateAsync(user.Id, new() { Username = user.Username });
    migratedUsers.Add(user.Id, migratedUser);
}

// Groups
Dictionary<Guid, GroupEntity> migratedGroups = new();
Dictionary<Guid, AttributeEntity> migratedAttributes = new();
IGroupService groupService = provider.GetRequiredService<IGroupService>();
IGroupMemberService groupMemberService = provider.GetRequiredService<IGroupMemberService>();
IAttributeService attributeService = provider.GetRequiredService<IAttributeService>();
foreach (Group group in await heroContext.Groups.Include(group => group.Members).ToListAsync())
{
    GroupRequest request = new() { Name = group.Name, Description = group.Description };
    GroupEntity migratedGroup = await groupService.CreateAsync(request);

    migratedGroups.Add(group.Id, migratedGroup);

    await groupMemberService.CreateAsync(migratedUsers[group.OwnerId].Id, migratedGroup.Id, Role.Owner);
    IEnumerable<AttributeEntity> defaultAttributes = await attributeService.CreateDefaultAttributesAsync(migratedUsers[group.OwnerId].Id, migratedGroup.Id);

    defaultAttributes.ToList().ForEach(item => migratedAttributes.Add(item.Id, item));

    foreach (User member in group.Members)
    {
        await groupMemberService.CreateAsync(migratedUsers[member.Id].Id, migratedGroup.Id, Role.Member);
    }
}

// Abilities
Dictionary<Guid, AbilityEntity> migratedAbilities = new();
IAbilityService abilityService = provider.GetRequiredService<IAbilityService>();
foreach (Ability ability in await heroContext.Abilities.ToListAsync())
{
    AbilityCreateRequest request = new()
    {
        GroupId = migratedGroups[ability.GroupId].Id,
        Name = ability.Name,
        Description = ability.Description,
        IsPassive = ability.IsPassive,
    };

    AbilityEntity migratedAbility = await abilityService.CreateAsync(migratedUsers[ability.CreatorId].Id, request);
    if (ability.Tags is not null) await abilityService.SetTagsAsync(migratedAbility.Id, ability.Tags.Distinct());

    switch(ability.State)
    {
        case HeroSuggestionState.Approved: 
        {
            await abilityService.ApproveAsync(migratedAbility.Id);
            break;
        }
        case HeroSuggestionState.Rejected: 
        {
            await abilityService.RejectAsync(migratedAbility.Id, new() { Reason = ability.RejectionReason ?? "" });
            break;
        }
        default: break; 
    };

    migratedAbilities.Add(ability.Id, migratedAbility);
}

// Attributes
foreach (Attribute attribute in await heroContext.Attributes.Where(item => item.GroupId != Guid.Empty).ToListAsync())
{

    AttributeCreateRequest request = new() 
    {
        GroupId = migratedGroups[attribute.GroupId].Id, 
        Name = attribute.Name,
        Description = attribute.Description,
        Category = attribute.Category,
        IconData = attribute.IconData,
        MinValue = attribute.MinValue,
        MaxValue = attribute.MaxValue,
        StepSize = attribute.StepSize,
    };

    AttributeEntity migratedAttribute = await attributeService.CreateAsync(migratedUsers[attribute.CreatorId].Id, request);

    switch (attribute.State)
    {
        case HeroSuggestionState.Approved:
            {
                await attributeService.ApproveAsync(migratedAttribute.Id);
                break;
            }
        case HeroSuggestionState.Rejected:
            {
                await attributeService.RejectAsync(migratedAttribute.Id, new() { Reason = attribute.RejectionReason ?? "" });
                break;
            }
        default: break;
    };

    migratedAttributes.Add(attribute.Id, migratedAttribute);
}

// Skills
Dictionary<Guid, SkillEntity> migratedSkills = new();
ISkillService skillService =  provider.GetRequiredService<ISkillService>();
foreach (Skill skill in await heroContext.Skills.Include(item => item.Attributes).ToListAsync())
{
    SkillCreateRequest request = new()
    {
        GroupId = migratedGroups[skill.GroupId].Id,
        Name = skill.Name,
        Description = skill.Description,
        IconUrl = skill.IconUrl,
        AbilityId = skill.AbilityId.HasValue ? migratedAbilities[skill.AbilityId.Value].Id : null,
    };

    SkillEntity migratedSkill = await skillService.CreateAsync(migratedUsers[skill.CreatorId].Id, request);
    migratedSkills.Add(skill.Id, migratedSkill);

    IEnumerable<SkillAttributeRequest> skillAttributeRequests = skill.Attributes.Select(item => new SkillAttributeRequest() { AttributeId = migratedAttributes[item.AttributeId].Id, Value = item.Value });

    await skillService.SetAttributesAsync(migratedSkill.Id, skillAttributeRequests);

    switch (skill.State)
    {
        case HeroSuggestionState.Approved:
            {
                await skillService.ApproveAsync(migratedSkill.Id);
                break;
            }
        case HeroSuggestionState.Rejected:
            {
                await skillService.RejectAsync(migratedSkill.Id, new() { Reason = skill.RejectionReason ?? "" });
                break;
            }
        default: break;
    };
}

// Races
Dictionary<Guid, RaceEntity> migratedRaces = new();
IRaceService raceService = provider.GetRequiredService<IRaceService>();
foreach (Race race in await heroContext.Races.Include(item => item.Attributes).ToListAsync())
{
    RaceCreateRequest request = new()
    {
        GroupId = migratedGroups[race.GroupId].Id,
        Name = race.Name,
        Description = race.Description,
    };

    RaceEntity migratedRace = await raceService.CreateAsync(migratedUsers[race.CreatorId].Id, request);

    IEnumerable<RaceAttributeRequest> raceAttributeRequests = race.Attributes.Select(item => new RaceAttributeRequest() { AttributeId = migratedAttributes[item.AttributeId].Id, Value = item.Value });
    migratedRaces.Add(race.Id, migratedRace);

    await raceService.SetAttributesAsync(migratedRace.Id, raceAttributeRequests);

    switch (race.State)
    {
        case HeroSuggestionState.Approved:
            {
                await raceService.ApproveAsync(migratedRace.Id);
                break;
            }
        case HeroSuggestionState.Rejected:
            {
                await raceService.RejectAsync(migratedRace.Id, new() { Reason = race.RejectionReason ?? "" });
                break;
            }
        default: break;
    };
}

// Characters
Dictionary<Guid, CharacterEntity> migratedCharacters = new();
ICharacterService characterService = provider.GetRequiredService<ICharacterService>();
foreach (Character character in await heroContext.Characters.ToListAsync())
{
    CharacterCreateRequest request = new()
    {
        GroupId = migratedGroups[character.GroupId].Id,
        Name = character.Name,
        Description = character.Description,
        IconUrl = character.IconUrl,
        RaceId = migratedRaces[character.RaceId!.Value].Id,
        Age = character.Age,
        Inventory = character.Inventory,
        Notes = character.Notes,
        Profession = character.Profession,
        Relationship = character.Relationship,
        Religion = character.Religion,
    };

    CharacterEntity migratedCharacter = await characterService.CreateAsync(migratedUsers[character.UserId].Id, request);
    migratedCharacters.Add(character.Id, migratedCharacter);
}

// Skilltrees
Dictionary<Guid, SkilltreeEntity> migratedSkilltrees = new();
ISkilltreeService skilltreeService = provider.GetRequiredService<ISkilltreeService>();
foreach (Skilltree skilltree in await heroContext.Skilltrees.ToListAsync())
{
    SkilltreeCreateRequest request = new()
    {
        GroupId = migratedGroups[skilltree.GroupId].Id,
        Name = skilltree.Name,
        IsActive = skilltree.IsActiveTree,
        Points = skilltree.Points,
        CharacterId = skilltree.CharacterId.HasValue ? migratedCharacters[skilltree.CharacterId.Value].Id : null,
    };

    SkilltreeEntity migratedSkilltree = await skilltreeService.CreateAsync(request);
    migratedSkilltrees.Add(skilltree.Id, migratedSkilltree);
}

// Skilltree Nodes
Dictionary<Guid, SkilltreeNodeEntity> migratedNodes = new();
ISkilltreeService skilltreeNodeService = provider.GetRequiredService<ISkilltreeService>();
foreach (SkilltreeNode node in await heroContext.SkilltreeNodes.ToListAsync())
{
    if (!migratedSkilltrees.ContainsKey(node.ParentId!.Value)) continue;
    SkilltreeNodeCreateRequest request = new()
    {
        SkilltreeId = migratedSkilltrees[node.ParentId!.Value].Id,
        Color = node.Color,
        Cost = node.Cost,
        Importance = node.Importance,
        IsEasyReachable = node.IsEasyReachable,
        SkillId = migratedSkills[node.SkillId!.Value].Id,
        XPos = node.XPos,
        YPos = node.YPos
    };

    SkilltreeNodeEntity migratedSkilltreeNode = await skilltreeNodeService.CreateNodeAsync(request);

    if(node.IsUnlocked) await skilltreeNodeService.UnlockNodeAsync(migratedSkilltreeNode.Id);

    migratedNodes.Add(node.Id, migratedSkilltreeNode);
}

// Skilltree Edges
List<SkilltreeEdgeEntity> migratedEdges = new();
foreach (SkilltreeNode node in await heroContext.SkilltreeNodes.ToListAsync())
{
    if (!migratedSkilltrees.ContainsKey(node.ParentId!.Value)) continue;
    foreach (Guid successor in node.Successors)
    {
        if (!migratedNodes.ContainsKey(successor)) continue;
        SkilltreeEdgeRequest request = new()
        {
            StartId = migratedNodes[node.Id].Id,
            EndId = migratedNodes[successor].Id,
        };

        if (!migratedEdges.Any(edge => edge.StartId == request.StartId && edge.EndId == request.EndId))
        {
            SkilltreeEdgeEntity migratedEdge = await skilltreeNodeService.CreateEdgeAsync(migratedSkilltrees[node.ParentId!.Value].Id, request);
            migratedEdges.Add(migratedEdge);
        }
    }
    foreach (Guid precessor in node.Precessors)
    {

        if (!migratedNodes.ContainsKey(precessor)) continue;
        SkilltreeEdgeRequest request = new()
        {
            StartId = migratedNodes[precessor].Id,
            EndId = migratedNodes[node.Id].Id,
        };

        if (!migratedEdges.Any(edge => edge.StartId == request.StartId && edge.EndId == request.EndId))
        {
            SkilltreeEdgeEntity migratedEdge = await skilltreeNodeService.CreateEdgeAsync(migratedSkilltrees[node.ParentId!.Value].Id, request);
            migratedEdges.Add(migratedEdge);
        }
    }
}

// Story events
IStoryEventService storyEventService = provider.GetRequiredService<IStoryEventService>();
IStoryBookService storyBookService = provider.GetRequiredService<IStoryBookService>();
IStoryImageService storyImageService = provider.GetRequiredService<IStoryImageService>();
foreach (StoryEntry entry in await heroContext.StoryEntries.Include(item => ((StoryBook)item).Pages).ToListAsync())
{
    if (entry is StoryBook book)
    {
        StoryBookCreateRequest request = new()
        {
            GroupId = migratedGroups[book.GroupId].Id,
            Title = book.Title,
            Description = book.Description,
            ImageUrl = book.ImageUrl,
            IsUnlocked = book.IsUnlocked
        };

        StoryBookEntity migratedBook = await storyBookService.CreateAsync(request);
        foreach (StoryBookPage page in book.Pages.OrderBy(item => item.PageNumber))
        {
            StoryBookPageCreateRequest pageRequest = new()
            {
                BookId = migratedBook.Id,
                Title = page.Title,
                Content = page.Content,
                IsUnlocked = page.IsWritten,
            };

            await storyBookService.CreatePageAsync(pageRequest);
        }
    }
    else if(entry is StoryImage image)
    {
        StoryImageCreateRequest request = new()
        {
            GroupId = migratedGroups[image.GroupId].Id,
            Title = image.Title,
            ImageUrl = image.ImageUrl!,
            IsUnlocked = image.IsUnlocked
        };

        await storyImageService.CreateAsync(request);
    }
    else
    {
        StoryEventCreateRequest request = new()
        {
            GroupId = migratedGroups[entry.GroupId].Id,
            Title = entry.Title,
            Description = entry.Description,
            Order = entry.Order,
            IsUnlocked = entry.IsUnlocked
        };

        await storyEventService.CreateAsync(request);
    }
}
