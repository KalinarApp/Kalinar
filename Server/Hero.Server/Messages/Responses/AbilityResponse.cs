namespace Hero.Server.Messages.Responses
{
    public class AbilityResponse : SuggestableResponse
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public bool IsPassive { get; set; }
        public string? Description { get; set; }
        public List<string>? Tags { get; set; }
    }
}