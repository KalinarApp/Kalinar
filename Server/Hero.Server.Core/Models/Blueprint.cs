namespace Hero.Server.Core.Models
{
    public class Blueprint
    {
        public Guid Id { get; set; }
        public Guid GroupId { get; set; }
        public string Name { get; set; }
        public List<BlueprintNode> Nodes { get; set; } = new List<BlueprintNode>();

    }
}
