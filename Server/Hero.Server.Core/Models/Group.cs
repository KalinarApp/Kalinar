using Hero.Server.Core.Models.Storyline;

namespace Hero.Server.Core.Models
{
    public class Group
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }
        public string InviteCode { get; set; }
        public string OwnerId { get; set; }
        public User Owner { get; set; }
        public List<User> Members { get; set; }
        public List<Ability> Abilities { get; set; }
        public List<Skill> Skills { get; set; }
        public List<Character> Characters { get; set; }
        public List<Skilltree> Skilltrees { get; set; }

        public List<StoryEntry> StoryEntries { get; set; }
    }
}
