namespace Kalinar.Core.Exceptions
{
    public class DeviceIdNotFoundException : Exception
    {
        public string DeviceId { get; init; }

        public DeviceIdNotFoundException(string username, string deviceId)
            : base($"Device id '{deviceId}' does not exist for user '{username}'")
        => this.DeviceId = deviceId;
    }
}
