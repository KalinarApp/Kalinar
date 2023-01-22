namespace Hero.Server.Core
{
    public class GlobalAttribute
    {
        public static readonly List<Models.Attribute> Attributes = new()
        {
            new()
            {
                Id = new Guid("9993f283-ef4f-4962-a0e5-58b47fb53342"),
                GroupId = new Guid(),
                Name = "Lebenspunkte",
                IconData = "{\"pack\":\"fontAwesomeIcons\",\"key\":\"solidHeart\"}",
                Description = "Die Lebenspunkte beschreiben die Vitalität des Charakters. Fallen diese auf 10 wird ein Charakter Kampfunfähig. Fallen sie auf 0 stirbt der Charakter.",
                MinValue = Int32.MinValue,
                MaxValue = Int32.MaxValue,
                StepSize = 1,
            },
            new()
            {
                Id = new Guid("8b818921-0e01-421b-918d-6f56ebf3d75d"),
                GroupId = new Guid(),
                Name = "Parade",
                IconData = "{\"pack\":\"material\",\"key\":\"shield_outlined\"}",
                Description = "Wird ein Charakter angegriffen kann er versuchen den Angriff zu parrieren. Ist dies erfolgreich, so blockiert er den Angriff.",
                MinValue = Int32.MinValue,
                MaxValue = Int32.MaxValue,
                StepSize = 1,
            },
            new()
            {
                Id = new Guid("67feb40a-63d2-481a-abe6-5ca2afb9abb7"),
                GroupId = new Guid(),
                Name = "Ausweichen",
                IconData = "{\"pack\":\"fontAwesomeIcons\",\"key\":\"swift\"}",
                Description = "Wird ein Charakter angegriffen, kann er versuchen dem Angriff auszuweichen. Ist er erfolgreich, so geht der Angriff daneben.",
                MinValue = Int32.MinValue,
                MaxValue = Int32.MaxValue,
                StepSize = 1,
            },
            new()
            {
                Id = new Guid("fcc65e2d-9197-4931-94eb-308c5bc4e0da"),
                GroupId = new Guid(),
                Name = "Bewegungsreichweite",
                IconData = "{\"pack\":\"material\",\"key\":\"arrow_circle_right_outlined\"}",
                Description = "Die Anzahl an Metern, die ein Charakter pro Zug zurücklegen kann.",
                MinValue = -5,
                MaxValue = 20,
                StepSize = 0.5,
            },
            new()
            {
                Id = new Guid("7ba1a685-8a19-47df-850a-aa871a9def71"),
                GroupId = new Guid(),
                Name = "Initiative",
                IconData = "{\"pack\":\"material\",\"key\":\"speed\"}",
                Description = "Je höher die Inititative, desto früher ist ein Charakter im Kampf am Zug.",
                MinValue = -5,
                MaxValue = 20,
                StepSize = 0.5,
            }
        };
    }
}
