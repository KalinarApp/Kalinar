using Kalinar.Core.Entities;

namespace Kalinar.Application.Constants
{
    internal class DefaultAttributeEntities
    {
        public static IEnumerable<AttributeEntity> Get(UserEntity user, GroupEntity group)
        {
            return new List<AttributeEntity>()
            {
                new()
                {
                    Id = Guid.NewGuid(),
                    GroupId = group.Id,
                    Group = group,
                    CreatorId = user.Id,
                    Creator = user,
                    Name = "Lebenspunkte",
                    IconData = "{\"pack\":\"fontAwesomeIcons\",\"key\":\"solidHeart\"}",
                    Description = "Die Lebenspunkte beschreiben die Vitalität des Charakters. Fallen diese auf 10 wird ein Charakter Kampfunfähig. Fallen sie auf 0 stirbt der Charakter.",
                    MinValue = Int32.MinValue,
                    MaxValue = Int32.MaxValue,
                    StepSize = 1,
                    State = SuggestionState.Approved,
                    CreatedAt = DateTime.UtcNow,
                    IsDefault = true,
                },
                new()
                {
                    Id = Guid.NewGuid(),
                    GroupId = group.Id,
                    Group = group,
                    CreatorId = user.Id,
                    Creator = user,
                    Name = "Parade",
                    IconData = "{\"pack\":\"material\",\"key\":\"shield_outlined\"}",
                    Description = "Wird ein Charakter angegriffen kann er versuchen den Angriff zu parrieren. Ist dies erfolgreich, so blockiert er den Angriff.",
                    MinValue = Int32.MinValue,
                    MaxValue = Int32.MaxValue,
                    StepSize = 1,
                    State = SuggestionState.Approved,
                    CreatedAt = DateTime.UtcNow,
                    IsDefault = true,
                },
                new()
                {
                    Id = Guid.NewGuid(),
                    GroupId = group.Id,
                    Group = group,
                    CreatorId = user.Id,
                    Creator = user,
                    Name = "Ausweichen",
                    IconData = "{\"pack\":\"fontAwesomeIcons\",\"key\":\"swift\"}",
                    Description = "Wird ein Charakter angegriffen, kann er versuchen dem Angriff auszuweichen. Ist er erfolgreich, so geht der Angriff daneben.",
                    MinValue = Int32.MinValue,
                    MaxValue = Int32.MaxValue,
                    StepSize = 1,
                    State = SuggestionState.Approved,
                    CreatedAt = DateTime.UtcNow,
                    IsDefault = true,
                },
                new()
                {
                    Id = Guid.NewGuid(),
                    GroupId = group.Id,
                    Group = group,
                    CreatorId = user.Id,
                    Creator = user,
                    Name = "Bewegungsreichweite",
                    IconData = "{\"pack\":\"material\",\"key\":\"arrow_circle_right_outlined\"}",
                    Description = "Die Anzahl an Metern, die ein Charakter pro Zug zurücklegen kann.",
                    MinValue = -5,
                    MaxValue = 20,
                    StepSize = 0.5,
                    State = SuggestionState.Approved,
                    CreatedAt = DateTime.UtcNow,
                    IsDefault = true,
                },
                new()
                {
                    Id = Guid.NewGuid(),
                    GroupId = group.Id,
                    Group = group,
                    CreatorId = user.Id,
                    Creator = user,
                    Name = "Initiative",
                    IconData = "{\"pack\":\"material\",\"key\":\"speed\"}",
                    Description = "Je höher die Inititative, desto früher ist ein Charakter im Kampf am Zug.",
                    MinValue = -5,
                    MaxValue = 20,
                    StepSize = 0.5,
                    State = SuggestionState.Approved,
                    CreatedAt = DateTime.UtcNow,
                    IsDefault = true,
                }
            };
        }
    }
}
