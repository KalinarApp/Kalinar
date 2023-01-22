namespace Hero.Server.Messages.Responses
{
    public class NodeResponse
    {
        public Guid Id { get; set; }
        public Guid? SkillId { get; set; }
        public int Importance { get; set; }
        public SkillResponse Skill { get; set; }
        public int Cost { get; set; }
        public double XPos { get; set; }
        public double YPos { get; set; }
        public string Color { get; set; }
        public bool IsEasyReachable { get; set; }
        public List<Guid> Precessors { get; set; }
        public List<Guid> Successors { get; set; }
    }

    public class SkilltreeNodeResponse : NodeResponse
    {
        public bool IsUnlocked { get; set; }
        public DateTime? UnlockedAt { get; set; }
    }

    public class BlueprintNodeResponse : NodeResponse
    { }
}