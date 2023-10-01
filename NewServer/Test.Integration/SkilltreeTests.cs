using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;
using Kalinar.Test.Integration.Seeding;

using System.ComponentModel.DataAnnotations;
using System.Net;

using Xunit;

namespace Kalinar.Test.Integration
{
    public class SkilltreeTests : TestBase
    {
        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        [InlineData(Utilities.GrouplessUserId, false)]
        public async Task CanCreateSkilltree(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            SkilltreeCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "TestSkilltree",
                IsActive = true,
                Points = 0, 
            };
            SkilltreeResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () =>  response = await this.PostAsync<SkilltreeCreateRequest, SkilltreeResponse>($"/api/{ApiVersion}/skilltrees", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(response);
                Assert.Equal(request.Name, response.Name);
            }
            else
            {
                Assert.Null(response);
                Assert.IsType<HttpErrorException>(ex);
                Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
                Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
            }
        }

        [Fact]
        public async Task CanCreateNode()
        {
            string accessToken = GetToken(Utilities.GroupOwnerUserId)!;
            SkilltreeNodeCreateRequest request = new()
            {
                SkilltreeId = new Guid(Utilities.SkilltreeId),
                SkillId = new Guid(Utilities.ApprovedSkillId),
                Color = "#000000",
                Cost = 1,
                Importance = 1,
                IsEasyReachable = true,
                XPos = 0,
                YPos = 0,
            };

            SkilltreeNodeResponse? response = await this.PostAsync<SkilltreeNodeCreateRequest, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.SkillId, response.SkillId);
            Assert.NotNull(response.Skill);
        }

        [Fact]
        public async Task CannotCreateNoteIfSkillIsNotApproved()
        {
            string accessToken = GetToken(Utilities.GroupOwnerUserId)!;
            SkilltreeNodeCreateRequest request = new()
            {
                SkilltreeId = new Guid(Utilities.SkilltreeId),
                SkillId = new Guid(Utilities.PendingSkillId),
                Color = "#000000",
                Cost = 1,
                Importance = 1,
                IsEasyReachable = true,
                XPos = 0,
                YPos = 0,
            };

            SkilltreeNodeResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<SkilltreeNodeCreateRequest, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Conflict, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(SkillNotApprovedException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task CanCreateEdge()
        {
            string accessToken = GetToken(Utilities.GroupOwnerUserId)!;
            SkilltreeEdgeRequest request = new()
            {
                StartId = new Guid(Utilities.SkilltreeNode1Id),
                EndId = new Guid(Utilities.SkilltreeNode3Id),
            };

            SkilltreeEdgeResponse? response = await this.PostAsync<SkilltreeEdgeRequest, SkilltreeEdgeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/edges", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.StartId, response.StartId);
            Assert.Equal(request.EndId, response.EndId);
        }

        [Fact]
        public async Task CannotCreateExistingEdge()
        {
            string accessToken = GetToken(Utilities.GroupOwnerUserId)!;
            SkilltreeEdgeRequest request = new()
            {
                StartId = new Guid(Utilities.SkilltreeNode1Id),
                EndId = new Guid(Utilities.SkilltreeNode2Id),
            };

            SkilltreeEdgeResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<SkilltreeEdgeRequest, SkilltreeEdgeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/edges", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Conflict, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(SkilltreeEdgeAlreadyExistsException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task CannotCreateSelfReferencingEdge()
        {
            string accessToken = GetToken(Utilities.GroupOwnerUserId)!;
            SkilltreeEdgeRequest request = new()
            {
                StartId = new Guid(Utilities.SkilltreeNode1Id),
                EndId = new Guid(Utilities.SkilltreeNode1Id),
            };

            SkilltreeEdgeResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<SkilltreeEdgeRequest, SkilltreeEdgeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/edges", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.BadRequest, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ValidationException), ((HttpErrorException)ex!).Type);
        }
        [Fact]
        public async Task CanCopySkilltree()
        {
            string accessToken = GetToken(Utilities.GroupOwnerUserId)!;

            SkilltreeResponse? response = await this.PostAsync<object, SkilltreeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/copy", new {}, accessToken);
            List<SkilltreeNodeResponse> nodes = await this.GetAsync<List<SkilltreeNodeResponse>>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes", accessToken);

            Assert.NotNull(response);
            Assert.NotEqual(Utilities.SkilltreeId, response.Id.ToString());
            Assert.Null(response.CharacterId);
            Assert.NotNull(nodes);
            Assert.NotEmpty(nodes);
            Assert.Equal(3, nodes.Count);
        }

        [Fact]
        public async Task CanUnlockNode()
        {
            string accessToken = GetToken(Utilities.GroupMember1UserId)!;

            SkilltreeNodeResponse? response = await this.PutAsync<object, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode1Id}/unlock", new {}, accessToken);

            Assert.NotNull(response);
            Assert.True(response.IsUnlocked);
        }

        [Fact]
        public async Task CanNotUnlockNotReachableNode()
        {
            string accessToken = GetToken(Utilities.GroupMember1UserId)!;

            SkilltreeNodeResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PutAsync<object, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode2Id}/unlock", new { }, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(SkilltreeNodeNotUnlockableException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task CanNotUnlockNodeWithoutSkillpoints()
        {
            string accessToken = GetToken(Utilities.GroupOwnerUserId)!;

            SkilltreeNodeResponse? response = default;
            
            response = await this.GetAsync<SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode1Id}", accessToken);
            
            SkilltreeNodeUpdateRequest request = new()
            {
                Color = response.Color,
                Cost = response.Cost + 1,
                Importance = response.Importance,
                IsEasyReachable = response.IsEasyReachable,
                SkillId = response.SkillId,
                XPos = response.XPos,
                YPos = response.YPos,
            };

            response = await this.PutAsync<SkilltreeNodeUpdateRequest, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode1Id}", request, accessToken);

            accessToken = GetToken(Utilities.GroupMember1UserId)!;

            SkilltreeNodeResponse? response2 = default;
            Exception? ex = await Record.ExceptionAsync(async () => response2 = await this.PutAsync<object, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode1Id}/unlock", new { }, accessToken));

            Assert.Null(response2);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(SkilltreeNotEnoughPointsException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task CanResetNodeAfterUnlocking()
        {
            string accessToken = GetToken(Utilities.GroupMember1UserId)!;

            await this.PutAsync<object, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode1Id}/unlock", new { }, accessToken);
            SkilltreeNodeResponse? response2 = await this.PutAsync<object, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode1Id}/reset", new { }, accessToken);

            Assert.NotNull(response2);
            Assert.False(response2.IsUnlocked);
        }

        [Fact]
        public async Task CanNotResetNodeAfterNodeIsUnlockedForMoreThanFiveMinutes()
        {
            string accessToken = GetToken(Utilities.GroupMember1UserId)!;

            Exception? ex  = await Record.ExceptionAsync(async() => await this.PutAsync<object, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode3Id}/reset", new { }, accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task CanNotResetNodeWithUnlockedSuccessors()
        {
            string accessToken = GetToken(Utilities.GroupMember1UserId)!;

            await this.PutAsync<object, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode1Id}/unlock", new { }, accessToken);
            await this.PutAsync<object, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode2Id}/unlock", new { }, accessToken);
            Exception? ex = await Record.ExceptionAsync(async () => await this.PutAsync<object, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode1Id}/reset", new { }, accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Conflict, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(SkilltreeNodeNotResetableException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task CanResetSkilltree()
        {
            string accessToken = GetToken(Utilities.GroupOwnerUserId)!;

            await this.PutAsync<object, SkilltreeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/reset", new { }, accessToken);
            List<SkilltreeNodeResponse> response = await this.GetAsync<List<SkilltreeNodeResponse>>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes", accessToken);

            Assert.All(response, node => Assert.False(node.IsUnlocked));
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanUpdateSkilltree(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            SkilltreeResponse? response = await this.GetAsync<SkilltreeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}", accessToken);

            Assert.NotNull(response);

            SkilltreeUpdateRequest request = new()
            {
                Name = "Updated TestSkilltree",
                IsActive = false,
                Points = 1,
            };

            SkilltreeResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<SkilltreeUpdateRequest, SkilltreeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(updatedResponse);
                Assert.Equal(request.Name, updatedResponse!.Name);
            }
            else
            {
                Assert.Null(updatedResponse);
                Assert.IsType<HttpErrorException>(ex);
                Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
                Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
            }
        }

        [Fact]
        public async Task CanUpdateNode()
        {
            string accessToken = GetToken(Utilities.GroupOwnerUserId)!;
            SkilltreeNodeUpdateRequest request = new()
            {
                SkillId = new Guid(Utilities.ApprovedSkillId),
                Color = "#000000",
                Cost = 1,
                Importance = 1,
                IsEasyReachable = true,
                XPos = 0,
                YPos = 0,
            };

            SkilltreeNodeResponse? response = await this.PutAsync<SkilltreeNodeUpdateRequest, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode1Id}", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.SkillId, response.SkillId);
            Assert.NotNull(response.Skill);
        }

        [Fact]
        public async Task CannotUpdateNoteIfSkillIsNotApproved()
        {
            string accessToken = GetToken(Utilities.GroupOwnerUserId)!;
            SkilltreeNodeUpdateRequest request = new()
            {
                SkillId = new Guid(Utilities.PendingSkillId),
                Color = "#000000",
                Cost = 1,
                Importance = 1,
                IsEasyReachable = true,
                XPos = 0,
                YPos = 0,
            };

            SkilltreeNodeResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PutAsync<SkilltreeNodeUpdateRequest, SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode1Id}", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Conflict, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(SkillNotApprovedException), ((HttpErrorException)ex!).Type);
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanDeleteSkilltree(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            SkilltreeResponse? response = default;
            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => response = await this.GetAsync<SkilltreeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}", accessToken));

            if (hasPermissions)
            {
                Assert.IsType<HttpErrorException>(getException);
                Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
                Assert.Equal(nameof(SkilltreeNotFoundException), ((HttpErrorException)getException!).Type);
            }
            else
            {
                Assert.IsType<HttpErrorException>(deleteException);
                Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)deleteException!).StatusCode);
                Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)deleteException!).Type);
            }
        }

        [Fact]
        public async Task CanDeleteNode()
        {
            string accessToken = GetToken(Utilities.GroupOwnerUserId)!;

            SkilltreeNodeResponse? response = default;
            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode1Id}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => response = await this.GetAsync<SkilltreeNodeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/nodes/{Utilities.SkilltreeNode1Id}", accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(getException);
            Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
            Assert.Equal(nameof(SkilltreeNodeNotFoundException), ((HttpErrorException)getException!).Type);
        }

        [Fact]
        public async Task CanDeleteEdge()
        {
            string accessToken = GetToken(Utilities.GroupOwnerUserId)!;

            SkilltreeEdgeResponse? response = default;
            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/edges/start/{Utilities.SkilltreeNode1Id}/end/{Utilities.SkilltreeNode2Id}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => response = await this.GetAsync<SkilltreeEdgeResponse>($"/api/{ApiVersion}/skilltrees/{Utilities.SkilltreeId}/edges/start/{Utilities.SkilltreeNode1Id}/end/{Utilities.SkilltreeNode2Id}", accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(getException);
            Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
            Assert.Equal(nameof(SkilltreeEdgeNotFoundException), ((HttpErrorException)getException!).Type);
        }
    }
}
