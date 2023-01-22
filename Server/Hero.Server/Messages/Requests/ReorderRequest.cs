namespace Hero.Server.Messages.Requests
{
    public class ReorderRequest
    {
        public Guid EntityId { get; set; }
        public int Position { get; set; }
    }
}
