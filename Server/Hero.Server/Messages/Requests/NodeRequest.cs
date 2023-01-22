namespace Hero.Server.Messages.Requests
{
    public class NodeRequest
    {
        public Guid Id { get; set; }
        public Guid SkillId { get; set; }
        public int Importance { get; set; }
        public int Cost { get; set; }
        public double XPos { get; set; }
        public double YPos { get; set; }
        public string Color { get; set; }
        public bool IsEasyReachable { get; set; }
        public List<Guid> Precessors { get; set; }
        public List<Guid> Successors { get; set; }
    }

    public class SkilltreeNodeRequest : NodeRequest
    { }

    public class BlueprintNodeRequest : NodeRequest
    { }
}