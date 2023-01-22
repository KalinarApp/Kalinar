using Hero.Server.Core.Models;
using Hero.Server.Core.Models.Storyline;

using Microsoft.EntityFrameworkCore;
using Attribute = Hero.Server.Core.Models.Attribute;

namespace Hero.Server.DataAccess.Database
{
    public class HeroDbContext : DbContext
    {
        internal HeroDbContext(DbContextOptions<HeroDbContext> options) : base(options) { }

        public HeroDbContext(GroupContext currentGroup, DbContextOptions<HeroDbContext> options) : base(options)
        {
            this.CurrentGroup = currentGroup;
        }

        public GroupContext CurrentGroup { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Character> Characters { get; set; }
        public DbSet<Ability> Abilities { get; set; }
        public DbSet<Skill> Skills { get; set; }
        public DbSet<BlueprintNode> BlueprintNodes { get; set; }
        public DbSet<SkilltreeNode> SkilltreeNodes { get; set; }
        public DbSet<Skilltree> Skilltrees { get; set; }
        public DbSet<Blueprint> Blueprints { get; set; }
        public DbSet<Group> Groups { get; set; }
        public DbSet<Attribute> Attributes { get; set; }
        public DbSet<Race> Races { get; set; }
        public DbSet<AttributeRace> AttributeRaces { get; set; }
        public DbSet<AttributeSkill> AttributeSkills { get; set; }

        public DbSet<StoryEntry> StoryEntries { get; set; }
        public DbSet<StoryBookPage> StoryBookPages { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.HasDefaultSchema(HeroDbResources.Schema);
            builder.ApplyConfigurationsFromAssembly(typeof(HeroDbContext).Assembly);

            builder.Entity<Group>().HasQueryFilter(g => g.Id == this.CurrentGroup.Id);
            builder.Entity<Character>().HasQueryFilter(c => c.GroupId == this.CurrentGroup.Id);
            builder.Entity<Ability>().HasQueryFilter(a => a.GroupId == this.CurrentGroup.Id);
            builder.Entity<Skill>().HasQueryFilter(s => s.GroupId == this.CurrentGroup.Id);
            builder.Entity<Skilltree>().HasQueryFilter(s => s.GroupId == this.CurrentGroup.Id);
            builder.Entity<Attribute>().HasQueryFilter(a => a.GroupId == this.CurrentGroup.Id || a.GroupId == new Guid());
            builder.Entity<Race>().HasQueryFilter(r => r.GroupId == this.CurrentGroup.Id);
            builder.Entity<Blueprint>().HasQueryFilter(b => b.GroupId == this.CurrentGroup.Id);
            builder.Entity<StoryBookPage>().HasQueryFilter(b => b.GroupId == this.CurrentGroup.Id);
            builder.Entity<StoryEntry>().HasQueryFilter(b => b.GroupId == this.CurrentGroup.Id);
        }
    }
}
