using System.Text.Json.Serialization;

namespace Hero.Server.Messages.Responses
{
    public class SharedCharacterDetailResponse : CharacterDetailResponse 
    {
        protected override List<AbilityResponse> GetUnlockedAbilities()
        {
            return this.ShareAbilities ?? false ? base.GetUnlockedAbilities() : new();
        }

        protected override List<AttributeValueResponse> GroupAttributes()
        {
            return this.ShareAttributes ?? false ? base.GroupAttributes() : new();
        }
    }

    public class CharacterDetailResponse
    {
        public Guid Id { get; set; }
        public string UserId { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }
        public string? IconUrl { get; set; }
        public int? Age { get; set; }
        public string? Inventory { get; set; }
        public string? Religion { get; set; }
        public string? Relationship { get; set; }
        public string? Notes { get; set; }
        public string? Profession { get; set; }
        public Guid RaceId { get; set; }
        public RaceResponse Race { get; set; }

        public bool IsPublic { get; set; }
        public bool? ShareSkilltree { get; set; }
        public bool? ShareNotes { get; set; }
        public bool? ShareInventory { get; set; }
        public bool? ShareAbilities { get; set; }
        public bool? ShareAttributes { get; set; }

        // The full trees are only needed to generate the attribute values, but should not be send over to the client to reduce overhead.
        [JsonIgnore]
        public List<SkilltreeResponse> FullSkilltrees { get; set; } = new();

        public List<SkilltreeOverviewResponse> Skilltrees { get; set; }

        public List<AttributeValueResponse> Attributes => this.GroupAttributes();

        public List<AbilityResponse> UnlockedAbilities => this.GetUnlockedAbilities();

        protected virtual List<AbilityResponse> GetUnlockedAbilities()
        {
            return this.FullSkilltrees.Where(s => s.IsActiveTree).SelectMany(tree => tree.Nodes.Where(node => node.IsUnlocked && null != node.Skill.Ability).Select(node => node.Skill.Ability)).ToList();
        }

        protected virtual List<AttributeValueResponse> GroupAttributes()
        {
            IEnumerable<AttributeValueResponse> skilltreeAttributes = 
                this.FullSkilltrees.Where(s => s.IsActiveTree).SelectMany(tree => tree.Nodes.Where(node => node.IsUnlocked).SelectMany(node => node.Skill.Attributes)).ToList();

            List<AttributeValueResponse> attributeValueResponses = this.Race.Attributes
                .Concat(skilltreeAttributes)
                .GroupBy(attribute => attribute.AttributeId)
                .Select(group => new AttributeValueResponse()
                {
                    AttributeId = group.Key,
                    Value = group.Sum(a => a.Value),
                    Attribute = group.First().Attribute,
                })
                .ToList();
            return attributeValueResponses; 
        }
    }
}
