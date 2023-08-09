using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository userRepository;

        public UserService(IUserRepository userRepository)
        {
            this.userRepository = userRepository;
        }

        public async Task<IEnumerable<UserEntity>> ListAsync(CancellationToken cancellationToken = default)
        {
            return await userRepository.ListAsync(cancellationToken);
        }

        public async Task<IEnumerable<UserEntity>> ListByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await userRepository.ListByGroupIdAsync(groupId, cancellationToken);
        }

        public async Task<UserEntity> GetByIdAsync(string userId, CancellationToken cancellationToken = default)
        {
            return await userRepository.FindByIdAsync(userId, cancellationToken) ?? throw new UserNotFoundException(userId);
        }

        public async Task<UserEntity> CreateAsync(string userId, UserCreateRequest request, CancellationToken cancellationToken = default)
        {
            UserEntity? existing = await this.userRepository.FindByIdAsync(userId, cancellationToken);

            if (existing is not null) throw new UserAlreadyExistsException(existing.Id);

            UserEntity user = new()
            {
                Id = userId,
                Username = request.Username,
                Devices = new(),
                Groups = new(),
            };

            return await userRepository.CreateAsync(user, cancellationToken);
        }

        public async Task<UserEntity> UpdateAsync(string userId, UserUpdateRequest request, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.GetByIdAsync(userId, cancellationToken);

            user.Username = request.Username;

            return await userRepository.UpdateAsync(user, cancellationToken);
        }

        public async Task AddDeviceIdAsync(string userId, string deviceId, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.GetByIdAsync(userId, cancellationToken);

            if (user.Devices.Any(device => device.Id == deviceId)) throw new DeviceIdAlreadyRegisteredException(user.Username, deviceId);

            user.Devices.Add(new() { Id = deviceId, UserId = userId});

            await userRepository.UpdateAsync(user, cancellationToken);
        }

        public async Task RemoveDeviceIdAsync(string userId, string deviceId, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.GetByIdAsync(userId, cancellationToken);

            if(!user.Devices.Any(device => device.Id == deviceId)) throw new DeviceIdNotFoundException(user.Username, deviceId);

            user.Devices.Remove(user.Devices.First(device => device.Id == deviceId));

            await userRepository.UpdateAsync(user, cancellationToken);
        }

        public async Task DeleteAsync(string id, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.GetByIdAsync(id, cancellationToken);
            await userRepository.DeleteAsync(user, cancellationToken);
        }
    }
}
