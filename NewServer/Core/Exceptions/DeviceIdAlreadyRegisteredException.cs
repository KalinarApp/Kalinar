namespace Kalinar.Core.Exceptions
{
    public class DeviceIdAlreadyRegisteredException : Exception
    {
        public string DeviceId { get; init; }

        public DeviceIdAlreadyRegisteredException(string username, string deviceId)
            : base($"Device id '{deviceId}' is already registered for user '{username}'")
        => this.DeviceId = deviceId;
    }
}
