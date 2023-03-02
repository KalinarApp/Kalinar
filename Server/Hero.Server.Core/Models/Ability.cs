namespace Hero.Server.Core.Models
{
    public class Ability : Suggestable
    {
        public string Name { get; set; }
        public bool IsPassive { get; set; }
        public string? Description { get; set; }

        public void Update(Ability ability)
        {
            this.Name = ability.Name;
            this.IsPassive= ability.IsPassive;
            this.Description= ability.Description;
        }
    }
}
