namespace Hero.Server.Core.Models.Storyline
{
    public class StoryEntry
    {
        public Guid Id { get; set; }
        public Guid GroupId { get; set; }

        public string Title { get; set; }
        public string? ImageUrl { get; set; }
        public string? Description { get; set; }
        public string? Date { get; set; }

        public bool IsUnlocked { get; set; }
        public DateTime UpdatedAt { get; set; }
        public int Order { get; set; }

        public virtual void Update(StoryEntry updated)
        {
            this.Title = updated.Title;
            this.ImageUrl = updated.ImageUrl;
            this.Description = updated.Description;
            this.IsUnlocked = updated.IsUnlocked;
            this.Date = updated.Date;
            this.UpdatedAt = DateTime.UtcNow;
        }
    }
}
