using Hero.Server.Core.Database;
using Hero.Server.Core.Models;
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
const string KalinarConnectionString = "";
const string HeroConnectionString = "";

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