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
                    Id = new Guid("9993f283-ef4f-4962-a0e5-58b47fb53342"),
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
                     Id = new Guid("8b818921-0e01-421b-918d-6f56ebf3d75d"),
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
                    Id = new Guid("67feb40a-63d2-481a-abe6-5ca2afb9abb7"),
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
                    Id = new Guid("fcc65e2d-9197-4931-94eb-308c5bc4e0da"),
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
                    Id = new Guid("7ba1a685-8a19-47df-850a-aa871a9def71"),
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
