namespace Hero.Server.Messaging
{
    public interface IMessagingService
    {
        Task<List<string>> SendMessageAsync(Dictionary<string, string> message, List<string> devices, CancellationToken cancellationToken = default);
        Task<List<string>> SendNotificationAsync(Notification message, List<string> devices, CancellationToken cancellationToken = default);
    }
}
