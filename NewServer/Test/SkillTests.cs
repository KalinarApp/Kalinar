using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;
using Kalinar.Test.Seeding;

using System.ComponentModel;
using System.Net;

using Xunit;

namespace Kalinar.Test
{
    [Category("Skill")]
    public class SkillTests : TestBase
    {
        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, SuggestionState.Approved)]
        [InlineData(Utilities.GroupMember1UserId, SuggestionState.Pending)]
        public async Task CanCreateSkillWithCorrectSuggestionState(string userId, SuggestionState expectedSuggestionState)
        {
            string accessToken = this.GetToken(userId)!;

            SkillCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "TestSkill",
            };

            SkillResponse? response = await this.PostAsync<SkillCreateRequest, SkillResponse>($"/api/{ApiVersion}/skills", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(expectedSuggestionState.ToString(), response.State);
        }

        [Fact]
        public async Task UserNotInGroupCannotCreateSkill()
        {
            string accessToken = this.GetToken(Utilities.GrouplessUserId)!;

            SkillCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "TestSkill",
            };

            SkillResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<SkillCreateRequest, SkillResponse>($"/api/{ApiVersion}/skills", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanUpdateApprovedSkill(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            SkillResponse? response = await this.GetAsync<SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}", accessToken);

            Assert.NotNull(response);

            SkillUpdateRequest request = new()
            {
                Name = "Updated TestSkill",
                AbilityId = response.AbilityId,
                Description = response!.Description,
                IconUrl = response!.IconUrl,
            };

            SkillResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<SkillUpdateRequest, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(updatedResponse);
                Assert.Equal(request.Name, updatedResponse!.Name);
                Assert.Equal(request.AbilityId, updatedResponse.AbilityId);
                Assert.Equal(SuggestionState.Approved.ToString(), updatedResponse.State);
            }
            else
            {
                Assert.Null(updatedResponse);
                Assert.IsType<HttpErrorException>(ex);
                Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
                Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
            }
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, true)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanUpdatePendingSkill(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            SkillResponse? response = await this.GetAsync<SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}", accessToken);

            Assert.NotNull(response);

            SkillUpdateRequest request = new()
            {
                Name = "Updated TestSkill",
                AbilityId = response.AbilityId,
                Description = response!.Description,
                IconUrl = response!.IconUrl,
            };

            SkillResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<SkillUpdateRequest, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(updatedResponse);
                Assert.Equal(request.Name, updatedResponse!.Name);
                Assert.Equal(request.AbilityId, updatedResponse.AbilityId);
                Assert.Equal(SuggestionState.Pending.ToString(), updatedResponse.State);
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
        public async Task CanNotUpdateApprovedSkillIfAbilityIsPending()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            SkillUpdateRequest request = new()
            {
                Name = "Updated TestSkill",
                AbilityId = new Guid(Utilities.PendingAbilityId),
            };

            SkillResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PutAsync<SkillUpdateRequest, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Conflict, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(AbilityNotApprovedException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task CanGetAbilityTags()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            List<AttributeValueResponse>? response = await this.GetAsync<List<AttributeValueResponse>>($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}/attributes", accessToken);

            Assert.NotNull(response);
            Assert.NotEmpty(response);
        }

        [Fact]
        public async Task CanSetSkillAttributes()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;
            List<SkillAttributeRequest> data = new()
            {
                new SkillAttributeRequest()
                {
                    AttributeId = new Guid(Utilities.ApprovedAttribute2Id),
                    Value = 1,
                },
            };

            Exception? ex = await Record.ExceptionAsync(async () => await this.PostAsync($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}/attributes", data, accessToken: accessToken));

            Assert.Null(ex);

            List<AttributeValueResponse>? response = await this.GetAsync<List<AttributeValueResponse>>($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}/attributes", accessToken);

            Assert.NotNull(response);
            Assert.Contains(response, item => item.AttributeId == data.First().AttributeId);
        }

        [Fact]
        public async Task CanNotSetSkillAttributeIfSkillIsApprovedButAttributeIsPending()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;
            List<SkillAttributeRequest> data = new()
            {
                new SkillAttributeRequest()
                {
                    AttributeId = new Guid(Utilities.PendingAttributeId),
                    Value = 1,
                },
            };

            Exception? ex = await Record.ExceptionAsync(async () => await this.PostAsync($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}/attributes", data, accessToken: accessToken));

            Assert.NotNull(ex);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Conflict, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(AttributeNotApprovedException), ((HttpErrorException)ex!).Type);
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanApproveSkill(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            SkillResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<object, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}/approve", new(), accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(response);
                Assert.Equal(SuggestionState.Approved.ToString(), response.State);
                Assert.Equal(SuggestionState.Approved.ToString(), response.Ability!.State);
            }
            else
            {
                Assert.Null(response);
                Assert.IsType<HttpErrorException>(ex);
                Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
                Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
            }
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanRejectSkill(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            RejectRequest request = new() { Reason = "Reason" };

            SkillResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<RejectRequest, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}/reject", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(response);
                Assert.NotNull(response.RejectedAt);
                Assert.Equal(request.Reason, response.RejectionReason);
                Assert.Equal(SuggestionState.Rejected.ToString(), response.State);
            }
            else
            {
                Assert.Null(response);
                Assert.IsType<HttpErrorException>(ex);
                Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
                Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
            }
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, SuggestionState.Pending, true)]
        [InlineData(Utilities.GroupMember1UserId, SuggestionState.Pending, true)]
        [InlineData(Utilities.GroupMember2UserId, SuggestionState.Pending, false)]

        [InlineData(Utilities.GroupOwnerUserId, SuggestionState.Approved, true)]
        [InlineData(Utilities.GroupMember1UserId, SuggestionState.Approved, false)]
        [InlineData(Utilities.GroupMember2UserId, SuggestionState.Approved, false)]

        [InlineData(Utilities.GroupOwnerUserId, SuggestionState.Rejected, true)]
        [InlineData(Utilities.GroupMember1UserId, SuggestionState.Rejected, false)]
        [InlineData(Utilities.GroupMember2UserId, SuggestionState.Rejected, false)]
        public async Task CanDeleteSkill(string userId, SuggestionState state, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;
            string skillId = state switch
            {
                SuggestionState.Pending => Utilities.PendingSkillId,
                SuggestionState.Approved => Utilities.ApprovedSkillId,
                SuggestionState.Rejected => Utilities.RejectedSkillId,
                _ => throw new NotImplementedException(),
            };

            SkillResponse? response = default;
            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/skills/{skillId}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => response = await this.GetAsync<SkillResponse>($"/api/{ApiVersion}/skills/{skillId}", accessToken));

            if (hasPermissions)
            {
                Assert.IsType<HttpErrorException>(getException);
                Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
                Assert.Equal(nameof(SkillNotFoundException), ((HttpErrorException)getException!).Type);
            }
            else
            {
                Assert.IsType<HttpErrorException>(deleteException);
                Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)deleteException!).StatusCode);
                Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)deleteException!).Type);
            }
        }
    }
}
