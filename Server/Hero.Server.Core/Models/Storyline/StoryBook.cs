namespace Hero.Server.Core.Models.Storyline
{
    public class StoryBook : StoryEntry
    {

        public StoryBook()
        {
            this.Pages = new();
        }

        public List<StoryBookPage> Pages { get; set; }

    }
}
