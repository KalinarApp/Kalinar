namespace Hero.Server.Core.Models
{
    public class Ability
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public Guid GroupId { get; set; }
        /// <summary>
        /// Indicates if the Ability is a passive Ability or one that can be actively used.
        /// </summary>
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
