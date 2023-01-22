namespace Hero.Server.Messages.Responses
{
    public class BlueprintResponse
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public List<BlueprintNodeResponse> Nodes { get; set; }
    }
}
