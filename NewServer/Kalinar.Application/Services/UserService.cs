using Kalinar.Application.Contracts;
using Kalinar.Application.Messages.Requests;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;

namespace Kalinar.Application.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;

        public UserService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<UserEntity> GetByIdAsync(string userId, CancellationToken cancellationToken = default)
        {
            return await _userRepository.FindByIdAsync(userId, cancellationToken) ?? throw new UserNotFoundException(userId);
        }

        public async Task<IEnumerable<UserEntity>> ListAsync(CancellationToken cancellationToken = default)
        {
            return await _userRepository.ListAsync(cancellationToken);
        }

        public async Task<UserEntity> CreateAsync(string userId, RegisterUserRequest request, CancellationToken cancellationToken = default)
        {
            UserEntity user = new()
            {
                Id = userId,
                Email = request.Email.ToLower(),
                Username = request.Username,
            };

            return await _userRepository.CreateAsync(user, cancellationToken);
        }

        public async Task<UserEntity> UpdateAsync(UserEntity user, CancellationToken cancellationToken = default)
        {
            return await _userRepository.UpdateAsync(user, cancellationToken);
        }

        public async Task DeleteAsync(UserEntity user, CancellationToken cancellationToken = default)
        {
            await _userRepository.DeleteAsync(user, cancellationToken);
        }

        public async Task JoinGroupAsync(string userId, Guid groupId, RoleEntity role, CancellationToken cancellationToken = default)
        {
            await _userRepository.JoinGroupAsync(userId, groupId, role, cancellationToken);
        }

        public async Task LeaveGroupAsync(string userId, Guid groupId, CancellationToken cancellationToken = default)
        {
            await _userRepository.LeaveGroupAsync(userId, groupId, cancellationToken);
        }
    }
}
