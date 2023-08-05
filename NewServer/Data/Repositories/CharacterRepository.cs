using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

namespace Kalinar.Data.Repositories
{
    public class CharacterRepository : BaseGroupRepository<CharacterEntity>, ICharacterRepository
    {
        public CharacterRepository(Context context) : base(context) { }
    }
}
