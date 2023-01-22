namespace Hero.Server.Messages.Responses
{
    public class StoryBookPageResponse
    {
        public Guid Id { get; set; }
        public int PageNumber { get; set; }
        public Guid BookId { get; set; }

        public string Title { get; set; }
        public string Content { get; set; }

        public bool IsWritten { get; set; }
    }
}