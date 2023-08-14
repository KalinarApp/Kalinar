using Kalinar.Application.Contracts;
using Kalinar.Authorization;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Extensions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Kalinar.Controllers
{
    [ApiController]
    [Authorize(Policy = PolicyNames.IsValidUser)]
    [Route("api/v{version:apiVersion}/skilltrees"), ApiVersion("1.0")]
    public class SkilltreeController : ControllerBase
    {
        private readonly ISkilltreeService skilltreeService;
        private readonly IGroupService groupService;
        private readonly IAuthorizationService authorizationService;

        public SkilltreeController(ISkilltreeService skilltreeService, IGroupService groupService, IAuthorizationService authorizationService)
        {
            this.skilltreeService = skilltreeService;
            this.groupService = groupService;
            this.authorizationService = authorizationService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<SkilltreeResponse>>> ListAsync([FromQuery] Guid? groupId, CancellationToken cancellationToken = default)
        {
            // ToDo: Implement an overall administrator role which than can view all skilltrees.
            if (groupId is null) throw new ForbiddenAccessException("User is not allowed to view this resource");
            GroupEntity group = await this.groupService.GetByIdAsync(groupId.Value, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanListSkilltrees);

            IEnumerable<SkilltreeEntity> skilltrees = await this.skilltreeService.ListAsync(groupId.Value, cancellationToken);
            return this.Ok(skilltrees.Select(item => (SkilltreeResponse)item));
        }

        [HttpGet("{skilltreeId}/nodes")]
        public async Task<ActionResult<IEnumerable<SkilltreeNodeResponse>>> ListNodesAsync(Guid skilltreeId, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(skilltree.GroupId, true, cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanReadSkilltree);

            IEnumerable<SkilltreeNodeEntity> nodes = await this.skilltreeService.ListNodesAsync(skilltreeId, cancellationToken);
            return this.Ok(nodes.Select(item => (SkilltreeNodeResponse)item));
        }

        [HttpGet("{skilltreeId}/edges")]
        public async Task<ActionResult<IEnumerable<SkilltreeEdgeResponse>>> ListEdgesAsync(Guid skilltreeId, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(skilltree.GroupId, true, cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanReadSkilltree);

            IEnumerable<SkilltreeEdgeEntity> edges = await this.skilltreeService.ListEdgesAsync(skilltreeId, cancellationToken);
            return this.Ok(edges.Select(item => (SkilltreeEdgeResponse)item));
        }

        [HttpGet("{skilltreeId}")]
        public async Task<ActionResult<SkilltreeResponse>> GetAsync(Guid skilltreeId, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(skilltree.GroupId, true, cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanReadSkilltree);

            return this.Ok((SkilltreeResponse)skilltree);
        }

        [HttpGet("{skilltreeId}/nodes/{nodeId}")]
        public async Task<ActionResult<SkilltreeNodeResponse>> GetNodeAsync(Guid skilltreeId, Guid nodeId, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(skilltree.GroupId, true, cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanReadSkilltree);

            SkilltreeNodeResponse response = await this.skilltreeService.GetNodeByIdAsync(nodeId, cancellationToken);
            return this.Ok(response);
        }

        [HttpGet("{skilltreeId}/edges/start/{startId}/end/{endId}")]
        public async Task<ActionResult<SkilltreeEdgeResponse>> GetEdgeAsync(Guid skilltreeId, Guid startId, Guid endId, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(skilltree.GroupId, true, cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanReadSkilltree);

            SkilltreeEdgeResponse edge = await this.skilltreeService.GetEdgeByStartAndEndIdAsync(startId, endId, cancellationToken);
            return this.Ok(edge);
        }

        [HttpPost]
        public async Task<ActionResult<SkilltreeResponse>> CreateAsync([FromBody] SkilltreeCreateRequest request, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanCreateSkilltree);

            SkilltreeEntity skilltree = await this.skilltreeService.CreateAsync(request, cancellationToken);
            return this.CreatedAtAction("Get", new { skilltreeId = skilltree.Id }, (SkilltreeResponse)skilltree);
        }

        [HttpPost("{skilltreeId}/nodes")]
        public async Task<ActionResult<SkilltreeNodeResponse>> CreateNodeAsync(Guid skilltreeId, [FromBody] SkilltreeNodeCreateRequest request, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(skilltree.GroupId, true, cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanCreateSkilltree);

            SkilltreeNodeEntity node = await this.skilltreeService.CreateNodeAsync(request, cancellationToken);
            return this.CreatedAtAction("GetNode", new { skilltreeId = skilltree.Id, nodeId = node.Id }, (SkilltreeNodeResponse)node);
        }

        [HttpPost("{skilltreeId}/edges")]
        public async Task<ActionResult<SkilltreeEdgeResponse>> CreateEdgeAsync(Guid skilltreeId, [FromBody] SkilltreeEdgeRequest request, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(skilltree.GroupId, true, cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanCreateSkilltree);

            SkilltreeEdgeResponse response = await this.skilltreeService.CreateEdgeAsync(skilltreeId, request, cancellationToken);
            return this.CreatedAtAction("GetEdge", new { skilltreeId = skilltree.Id, startId = response.StartId, endId = response.EndId }, response);
        }

        [HttpPost("{skilltreeId}/copy")]
        public async Task<ActionResult<SkilltreeResponse>> CopyAsync(Guid skilltreeId, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(skilltree.GroupId, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanCreateSkilltree);

            SkilltreeResponse response = await this.skilltreeService.CopyAsync(skilltreeId, cancellationToken);

            return this.Ok(response);
        }


        [HttpPost("{skilltreeId}/nodes/{nodeId}/unlock")]
        public async Task<ActionResult<SkilltreeNodeResponse>> UnlockNodeAsync(Guid skilltreeId, Guid nodeId, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);

            if (this.User.GetId() != skilltree.Character?.UserId) throw new ForbiddenAccessException("User cannot unlock node");

            SkilltreeNodeResponse response = await this.skilltreeService.UnlockNodeAsync(nodeId, true, cancellationToken);
            return this.Ok(response);
        }

        // ToDo: Add reset endpoint

        [HttpPut("{skilltreeId}")]
        public async Task<ActionResult<SkilltreeResponse>> UpdateAsync(Guid skilltreeId, [FromBody] SkilltreeUpdateRequest request, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(skilltree.GroupId, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanUpdateSkilltree);

            SkilltreeResponse response = await this.skilltreeService.UpdateAsync(skilltreeId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpPut("{skilltreeId}/nodes/{nodeId}")]
        public async Task<ActionResult<SkilltreeNodeResponse>> UpdateNodeAsync(Guid skilltreeId, Guid nodeId, [FromBody] SkilltreeNodeUpdateRequest request, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(skilltree.GroupId, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanUpdateSkilltree);

            SkilltreeNodeResponse response = await this.skilltreeService.UpdateNodeAsync(nodeId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpDelete("{skilltreeId}")]
        public async Task<ActionResult> DeleteAsync(Guid skilltreeId, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(skilltree.GroupId, true, cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanDeleteSkilltree);

            await this.skilltreeService.DeleteAsync(skilltreeId, cancellationToken);

            return this.NoContent();
        }

        [HttpDelete("{skilltreeId}/nodes/{nodeId}")]
        public async Task<ActionResult> DeleteNodeAsync(Guid skilltreeId, Guid nodeId, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(skilltree.GroupId, true, cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanDeleteSkilltree);

            await this.skilltreeService.DeleteNodeAsync(nodeId, cancellationToken);

            return this.NoContent();
        }

        [HttpDelete("{skilltreeId}/edges/start/{startId}/end/{endId}")]
        public async Task<ActionResult> DeleteEdgeAsync(Guid skilltreeId, Guid startId, Guid endId, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.skilltreeService.GetByIdAsync(skilltreeId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(skilltree.GroupId, true, cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanDeleteSkilltree);

            await this.skilltreeService.DeleteEdgeAsync(startId, endId, cancellationToken);

            return this.NoContent();
        }
    }
}
