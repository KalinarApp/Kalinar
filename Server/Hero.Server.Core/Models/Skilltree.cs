namespace Hero.Server.Core.Models
{
    public class Skilltree
    {
        public Guid Id { get; set; }
        public Guid GroupId { get; set; }
        public Guid? CharacterId { get; set; }
        public string Name { get; set; }
        public bool IsActiveTree { get; set; }
        public int Points { get; set; }
        public List<SkilltreeNode> Nodes { get; set; }
        public Character? Character { get; set; }

        public void Update(Skilltree tree)
        {
            this.Name = tree.Name;
            this.Points = tree.Points;
            this.IsActiveTree = tree.IsActiveTree;
            this.Nodes = tree.Nodes;
        }
    }
}
