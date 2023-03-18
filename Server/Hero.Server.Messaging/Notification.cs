namespace Hero.Server.Messaging
{
    public class Notification
    {
        public string Title { get; set; }
        public string Body { get; set; }
        public List<string> TitleArgs { get; set; }
        public List<string> BodyArgs { get; set; }
        public string? ClickAction { get; set; }
    }
}
