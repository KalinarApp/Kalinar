using Hero.Server.Core.Models;

namespace Hero.Server.Core.Repositories
{
    public interface ISkillRepository
    {
        Task<Skill?> GetSkillByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<List<Skill>> FilterSkillsAsync(string? query, SuggestionState[] allowedStates, CancellationToken cancellationToken = default);
        Task CreateSkillAsync(Skill skill, CancellationToken cancellationToken = default);
        Task<Skill> TryUpdateSkillAsync(Guid id, string userId, Skill updatedSkill, CancellationToken cancellationToken = default);
        Task TryDeleteSkillAsync(Guid id, string userId, CancellationToken cancellationToken = default);
        Task RejectSkillAsync(Guid id, string reason, CancellationToken cancellationToken = default);
    }
}
