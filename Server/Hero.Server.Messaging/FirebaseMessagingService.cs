using FirebaseAdmin.Messaging;

namespace Hero.Server.Messaging
{
    public class FirebaseMessagingService : IMessagingService
    {
        public async Task<List<string>> SendNotificationAsync(Notification message, List<string> devices, CancellationToken cancellationToken = default)
        {
            MulticastMessage data = new() 
            {
                Tokens = devices,
                Android = new()
                {  
                    Notification = new()
                    {
                         TitleLocKey = message.Title,
                         TitleLocArgs = message.TitleArgs,
                         BodyLocKey = message.Body,
                         BodyLocArgs = message.BodyArgs,
                         ClickAction = message.ClickAction,
                    }
                },
                Apns = new()
                {
                    Aps = new()
                    {
                        Alert = new()
                        {
                            TitleLocKey  = message.Title,
                            TitleLocArgs = message.TitleArgs,
                            LocKey = message.Body,
                            LocArgs = message.BodyArgs,
                        }
                    }
                }
            };

            BatchResponse response = await FirebaseMessaging.DefaultInstance.SendMulticastAsync(data, cancellationToken);

            List<string> unavailableDevices = new();
            if (response.FailureCount > 0)
            {
                for (int i = 0; i < response.Responses.Count; i++)
                {
                    if (!response.Responses[i].IsSuccess)
                    {
                        unavailableDevices.Add(devices[i]);
                    }
                }
            }
            return unavailableDevices;
        }

        public async Task<List<string>> SendMessageAsync(Dictionary<string, string> message, List<string> devices, CancellationToken cancellationToken = default)
        {
            MulticastMessage data = new()
            {
                Tokens = devices,
                Data = message
            };

            BatchResponse response = await FirebaseMessaging.DefaultInstance.SendMulticastAsync(data);

            List<string> unavailableDevices = new();
            if (response.FailureCount > 0)
            {
                for (int i = 0; i < response.Responses.Count; i++)
                {
                    if (!response.Responses[i].IsSuccess)
                    {
                        unavailableDevices.Add(devices[i]);
                    }
                }
            }
            return unavailableDevices;
        }
    }
}
