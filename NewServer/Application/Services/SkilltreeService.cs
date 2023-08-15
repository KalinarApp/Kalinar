using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Services
{
    internal class SkilltreeService : ISkilltreeService
    {
        private readonly ISkilltreeRepository skillreeRepository;
        private readonly ICharacterService characterService;
        private readonly IGroupService groupService;
        private readonly ISkillService skillService;

        public SkilltreeService(ISkilltreeRepository skilltreeRepository, ICharacterService characterService, IGroupService groupService, ISkillService skillService)
        {
            this.skillreeRepository = skilltreeRepository;
            this.characterService = characterService;
            this.groupService = groupService;
            this.skillService = skillService;
        }

        public async Task<IEnumerable<SkilltreeEntity>> ListAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.skillreeRepository.ListByGroupIdAsync(groupId, cancellationToken);
        }

        public async Task<IEnumerable<SkilltreeNodeEntity>> ListNodesAsync(Guid skilltreeId, CancellationToken cancellationToken = default)
        {
              return await this.skillreeRepository.ListNodesAsync(skilltreeId, cancellationToken);
        }

        public async Task<IEnumerable<SkilltreeEdgeEntity>> ListEdgesAsync(Guid skilltreeId, CancellationToken cancellationToken = default)
        {
            return await this.skillreeRepository.ListEdgesAsync(skilltreeId, cancellationToken);
        }

        public async Task<SkilltreeEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await this.skillreeRepository.FindByIdAsync(id, cancellationToken) ?? throw new SkilltreeNotFoundException(id);
        }

        public async Task<SkilltreeNodeEntity> GetNodeByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await this.skillreeRepository.FindNodeByIdAsync(id, cancellationToken) ?? throw new SkilltreeNodeNotFoundException(id);
        }

        public async Task<SkilltreeEdgeEntity> GetEdgeByStartAndEndIdAsync(Guid startId, Guid endId, CancellationToken cancellationToken = default)
        {
            return await this.skillreeRepository.FindEdgeByStartAndEndIdAsync(startId, endId, cancellationToken) ?? throw new SkilltreeEdgeNotFoundException(startId, endId);
        }

        public async Task<SkilltreeEntity> CreateAsync(SkilltreeCreateRequest request, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);
            CharacterEntity? character = null;
            if(request.CharacterId is not null) character = await this.characterService.GetByIdAsync(request.CharacterId.Value, cancellationToken);
            
            SkilltreeEntity skilltree = new()
            {
                Id = Guid.NewGuid(),
                Name = request.Name,
                CharacterId = request.CharacterId,
                Character = character,
                Edges = new List<SkilltreeEdgeEntity>(),
                Nodes = new List<SkilltreeNodeEntity>(),
                GroupId = request.GroupId,
                Group = group,
                IsActive = request.IsActive,
                Points = request.Points,
                CreatedAt = DateTime.UtcNow,
            };

            return await this.skillreeRepository.CreateAsync(skilltree, cancellationToken);
        }

        public async Task<SkilltreeNodeEntity> CreateNodeAsync(SkilltreeNodeCreateRequest request, CancellationToken cancellation = default)
        {
            SkilltreeEntity skilltree = await this.GetByIdAsync(request.SkilltreeId, cancellation);
            SkillEntity skill = await this.skillService.GetByIdAsync(request.SkillId, cancellation);

            if (skill.State != SuggestionState.Approved) throw new SkillNotApprovedException(skill.Name);

            SkilltreeNodeEntity node = new()
            {
                Id = Guid.NewGuid(),
                SkilltreeId = request.SkilltreeId,
                Skilltree = skilltree,
                SkillId = request.SkillId,
                Skill = skill,
                XPos = request.XPos,
                YPos = request.YPos,
                Color = request.Color,
                Cost = request.Cost,
                Importance = request.Importance,
                IsEasyReachable = request.IsEasyReachable,
                IsUnlocked = false,
            };

            return await this.skillreeRepository.CreateNodeAsync(node, cancellation);
        }

        public async Task<SkilltreeEdgeEntity> CreateEdgeAsync(Guid skilltreeId, SkilltreeEdgeRequest request, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.GetByIdAsync(skilltreeId, cancellationToken);
            SkilltreeNodeEntity start = await this.GetNodeByIdAsync(request.StartId, cancellationToken);
            SkilltreeNodeEntity end = await this.GetNodeByIdAsync(request.EndId, cancellationToken);

            SkilltreeEdgeEntity? existingEdge = await this.skillreeRepository.FindEdgeByStartAndEndIdAsync(request.StartId, request.EndId, cancellationToken);
            if (existingEdge is not null) throw new SkilltreeEdgeAlreadyExistsException(request.StartId, request.EndId);

            SkilltreeEdgeEntity? invertedExistingEdge = await this.skillreeRepository.FindEdgeByStartAndEndIdAsync(request.EndId, request.StartId, cancellationToken);
            if (invertedExistingEdge is not null) throw new SkilltreeEdgeAlreadyExistsException(request.StartId, request.EndId);

            SkilltreeEdgeEntity edge = new()
            {
                SkilltreeId = skilltreeId,
                StartId = request.StartId,
                EndId = request.EndId,
                Skilltree = skilltree,
                Start = start,
                End = end,
            };

            return await this.skillreeRepository.CreateEdgeAsync(edge, cancellationToken);
        }

        public async Task<SkilltreeEntity> CopyAsync(Guid skilltreeId, CancellationToken cancellationToken = default)
        {
            await this.GetByIdAsync(skilltreeId, cancellationToken);
            return await this.skillreeRepository.CopyByIdAsync(skilltreeId, cancellationToken);
        }

        public async Task<SkilltreeEntity> UpdateAsync(Guid id, SkilltreeUpdateRequest request, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.GetByIdAsync(id, cancellationToken: cancellationToken);
            CharacterEntity? character = null;
            if (request.CharacterId is not null) character = await this.characterService.GetByIdAsync(request.CharacterId.Value, cancellationToken);


            skilltree.Name = request.Name;
            skilltree.CharacterId = request.CharacterId;
            skilltree.Character = character;
            skilltree.IsActive = request.IsActive;
            skilltree.Points = request.Points;
            
            return await this.skillreeRepository.UpdateAsync(skilltree, cancellationToken);
        }

        public async Task<SkilltreeNodeEntity> UpdateNodeAsync(Guid id, SkilltreeNodeUpdateRequest request, CancellationToken cancellationToken = default)
        {
            SkilltreeNodeEntity node = await this.GetNodeByIdAsync(id, cancellationToken);
            SkillEntity skill = await this.skillService.GetByIdAsync(request.SkillId, cancellationToken);

            if (skill.State != SuggestionState.Approved) throw new SkillNotApprovedException(skill.Name);

            node.XPos = request.XPos;
            node.YPos = request.YPos;
            node.Color = request.Color;
            node.Cost = request.Cost;
            node.Importance = request.Importance;
            node.IsEasyReachable = request.IsEasyReachable;
            node.SkillId = request.SkillId;
            node.Skill = skill; 

            return await this.skillreeRepository.UpdateNodeAsync(node, cancellationToken);
        }

        public async Task ResetAsync(Guid id, CancellationToken cancellationToken = default)
        {
            IEnumerable<SkilltreeNodeEntity> nodes = await this.ListNodesAsync(id, cancellationToken);

            foreach (SkilltreeNodeEntity node in nodes)
            {
                node.IsUnlocked = false;
                await this.skillreeRepository.UpdateNodeAsync(node, cancellationToken);
            }
        }

        public async Task<SkilltreeNodeEntity> UnlockNodeAsync(Guid id, bool state, CancellationToken cancellationToken = default)
        {
            SkilltreeNodeEntity node = await this.GetNodeByIdAsync(id, cancellationToken);

            // ToDo: Create a view to get the remaining skillpoints for a skilltree to check if a node is unlockable or not

            node.IsUnlocked = state;

            return await this.skillreeRepository.UpdateNodeAsync(node, cancellationToken);
        }

        public async Task<SkilltreeEntity> CopyByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await this.skillreeRepository.CopyByIdAsync(id, cancellationToken);
        }

        public async Task DeleteAsync(Guid id, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.GetByIdAsync(id, cancellationToken: cancellationToken);
            await this.skillreeRepository.DeleteAsync(skilltree, cancellationToken);
        }

        public async Task DeleteNodeAsync(Guid id, CancellationToken cancellationToken = default)
        {
            SkilltreeNodeEntity node = await this.GetNodeByIdAsync(id, cancellationToken);
            await this.skillreeRepository.DeleteNodeAsync(node, cancellationToken);
        }

        public async Task DeleteEdgeAsync(Guid startId, Guid endId, CancellationToken cancellationToken = default)
        {
            SkilltreeEdgeEntity edge = await this.GetEdgeByStartAndEndIdAsync(startId, endId, cancellationToken);
            await this.skillreeRepository.DeleteEdgeAsync(edge, cancellationToken); 
        }
    }
}
