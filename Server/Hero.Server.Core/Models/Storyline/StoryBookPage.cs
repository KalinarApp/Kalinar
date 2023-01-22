namespace Hero.Server.Core.Models.Storyline
{
    public class StoryBookPage
    {
        public Guid Id { get; set; }
        public int PageNumber { get; set; }
        public Guid BookId { get; set; }
        public Guid GroupId { get; set; }
        public Group Group { get; set; }

        public string Title { get; set; }
        public string Content { get; set; }

        public bool IsWritten { get; set; }
        public DateTime UpdatedAt { get; set; }

        public void Update(StoryBookPage updated)
        {
            this.Title = updated.Title;
            this.Content = updated.Content;
            this.IsWritten = updated.IsWritten;
            this.UpdatedAt = DateTime.UtcNow;
        }
    }
}