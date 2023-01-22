namespace Hero.Server.Messages.Responses
{
    public class StoryEntryOverviewResponse
    {
        public Guid Id { get; set; }

        public string Title { get; set; }
        public string? ImageUrl { get; set; }
        public int? PageCount { get; set; }
        public string? Description { get; set; }
        public string? Date { get; set; }
        public int Order { get; set; }

        public bool IsUnlocked { get; set; }

        public string Type { get; set; }
    }
}
