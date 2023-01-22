namespace Hero.Server.Messages.Responses
{
    public class AbilityResponse
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public bool IsPassive { get; set; }
        public string? Description { get; set; }
    }
}