using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class CharacterResponse
    {
        public required Guid Id { get; init; }
        public required string UserId { get; init; }
        public required Guid RaceId { get; init; }
        public required RaceResponse Race { get; init; }
        public required string Name { get; init; }
        public string? Description { get; init; }
        public string? IconUrl { get; init; }
        public int? Age { get; init; }
        public string? Inventory { get; init; }
        public string? Religion { get; init; }
        public string? Relationship { get; init; }
        public string? Notes { get; init; }
        public string? Profession { get; init; }

        public static implicit operator CharacterResponse(CharacterEntity character)
        {
            return new()
            {
                Id = character.Id,
                UserId = character.UserId,
                RaceId = character.RaceId,
                Race = character.Race,
                Name = character.Name,
                Description = character.Description,
                IconUrl = character.IconUrl,
                Age = character.Age,
                Inventory = character.Inventory,
                Religion = character.Religion,
                Relationship = character.Relationship,
                Notes = character.Notes,
                Profession = character.Profession
            };
        }
    }
}
