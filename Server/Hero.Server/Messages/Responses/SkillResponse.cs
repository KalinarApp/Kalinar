namespace Hero.Server.Messages.Responses
{
    public class SkillResponse : SuggestableResponse
    {
        public required Guid Id { get; set; }
        public Guid? AbilityId { get; set; }
        public string? IconUrl { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
        public AbilityResponse? Ability { get; set; }
        public required List<AttributeValueResponse> Attributes { get; set; }
    }
}