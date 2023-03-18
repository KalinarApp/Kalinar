using Hero.Server.Messaging;

namespace Hero.Server.Services
{
    public class Notifications
    {
        private readonly IMessagingService service;

        public Notifications(IMessagingService service)
        {
            this.service = service;
        }

        public async void SendWelcomeMessageAsync(string deviceId, string username, CancellationToken cancellationToken = default)
        {
            Dictionary<string, string> message = new() { { "type", "welcome" }, { "user", username } };
            await this.service.SendMessageAsync(message, new() { deviceId }, cancellationToken);
        }
    }
}
