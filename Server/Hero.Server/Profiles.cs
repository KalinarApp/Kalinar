using AutoMapper;

using Hero.Server.Core.Models;
using Hero.Server.Core.Models.Inventory;
using Hero.Server.Core.Models.Storyline;
using Hero.Server.Messages.Requests;
using Hero.Server.Messages.Responses;

using Attribute = Hero.Server.Core.Models.Attribute;

namespace Hero.Server
{
    public class Profiles : Profile
    {
        public Profiles()
        {
            this.CreateMap<CharacterRequest, Character>();
            this.CreateMap<Character, CreateCharacterResponse>();
            this.CreateMap<Character, CharacterOverviewResponse>();
            this.CreateMap<Character, ExtendedCharacterOverviewResponse>();

            this.CreateMap<Character, CharacterDetailResponse>()
                .ForMember(dst => dst.FullSkilltrees, src => src.MapFrom(character => character.Skilltrees));

            this.CreateMap<Character, SharedCharacterDetailResponse>()
                .ForMember(dst => dst.FullSkilltrees, src => src.MapFrom(character => character.Skilltrees))
                .ForMember(dst => dst.Skilltrees, src => src.MapFrom(character => character.ShareSkilltree ?? false ? character.Skilltrees : new()))
                .ForMember(dst => dst.Inventory, src => src.MapFrom(character => character.ShareInventory ?? false ? character.Inventory : null))
                .ForMember(dst => dst.Notes, src => src.MapFrom(character => character.ShareNotes ?? false ? character.Notes : null));

            this.CreateMap<Ability, AbilityResponse>();
            this.CreateMap<AbilityRequest, Ability>()
                .ForMember(dst => dst.Tags, opt => opt.MapFrom(src => src.Tags ?? new()));

            this.CreateMap<SkillRequest, Skill>()
                .ForMember(dst => dst.Attributes, src => src.MapFrom(req => req.Attributes));
            this.CreateMap<AttributeSkillValueRequest, AttributeSkill>();
            this.CreateMap<Skill, SkillResponse>();
            this.CreateMap<AttributeSkill, AttributeValueResponse>();
            this.CreateMap<SkillRequest, Skill>();

            this.CreateMap<Skilltree, SkilltreeResponse>();

            this.CreateMap<Skilltree, SkilltreeOverviewResponse>()
                .ForMember(dst => dst.NodeCount, src => src.MapFrom(tree => tree.Nodes.Count))
                .ForMember(dst => dst.UnlockedNodeCount, src => src.MapFrom(tree => tree.Nodes.Where(node => node.IsUnlocked).Count()))
                .ForMember(dst => dst.LeftPoints, src => src.MapFrom(tree => tree.Points - tree.Nodes.Where(node => node.IsUnlocked).Sum(node => node.Cost)));

            this.CreateMap<SkilltreeNode, SkilltreeNodeResponse>();
            this.CreateMap<SkilltreeNodeRequest, SkilltreeNode>();
            this.CreateMap<SkilltreeRequest, Skilltree>();
            this.CreateMap<Attribute, AttributeResponse>()
                .ForMember(dst => dst.IsGlobal, src => src.MapFrom(x => x.GroupId == new Guid()));

            this.CreateMap<AttributeRequest, Attribute>();

            this.CreateMap<RaceRequest, Race>()
                .ForMember(dst => dst.Attributes, src => src.MapFrom(req => req.Attributes));
            this.CreateMap<AttributeRaceValueRequest, AttributeRace>();
            this.CreateMap<AttributeRace, AttributeValueResponse>();
            this.CreateMap<Race, RaceResponse>();
            this.CreateMap<Race, RaceOverviewResponse>();

            this.CreateMap<BlueprintRequest, Blueprint>();
            this.CreateMap<Blueprint, BlueprintOverviewResponse>()
                .ForMember(dst => dst.NodeCount, src => src.MapFrom(print => print.Nodes.Count));
            this.CreateMap<Blueprint, BlueprintResponse>();
            this.CreateMap<BlueprintNode, BlueprintNodeResponse>();
            this.CreateMap<BlueprintNodeRequest, BlueprintNode>();

            this.CreateMap<User, UserResponse>();
            this.CreateMap<Group, GroupResponse>();

            this.CreateMap<StoryBook, StoryEntryOverviewResponse>()
                .IncludeBase<StoryEntry, StoryEntryOverviewResponse>()
                .ForMember(dst => dst.PageCount, src => src.MapFrom(entry => entry.Pages.Count));
            this.CreateMap<StoryImage, StoryEntryOverviewResponse>()
                .IncludeBase<StoryEntry, StoryEntryOverviewResponse>();
            this.CreateMap<StoryEntry, StoryEntryOverviewResponse>()
                .ForMember(dst => dst.Type, src => src.MapFrom(entry => entry.GetType().Name));

            this.CreateMap<StoryEntryRequest, StoryImage>();
            this.CreateMap<StoryEntryRequest, StoryBook>();
            this.CreateMap<StoryEntryRequest, StoryEntry>();
            this.CreateMap<StoryBookPageRequest, StoryBookPage>();

            this.CreateMap<StoryEntry, StoryEntryResponse>()
                .IncludeAllDerived()
                .ForMember(dst => dst.Type, src => src.MapFrom(entry => entry.GetType().Name));
            this.CreateMap<StoryImage, StoryImageResponse>();
            this.CreateMap<StoryBook, StoryBookResponse>();
            this.CreateMap<StoryBookPage, StoryBookPageResponse>();

            this.CreateMap<ItemRequest, Item>();

            this.CreateMap<Item, ItemResponse>().IncludeAllDerived();
            this.CreateMap<Weapon, WeaponResponse>();

            this.CreateMap<CharacterItem, CharacterItemResponse>();
        }
    }
}
