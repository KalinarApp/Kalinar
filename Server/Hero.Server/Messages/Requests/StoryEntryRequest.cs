namespace Hero.Server.Messages.Requests
{
    public class StoryEntryRequest
    {
        public string Type { get; set; }
        public string Title { get; set; }
        public string? Description { get; set; }
        public string? Date { get; set; }
        public string? ImageUrl { get; set; }

        public bool IsUnlocked { get; set; }
    }
}
