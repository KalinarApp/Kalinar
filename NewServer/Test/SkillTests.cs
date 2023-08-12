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
        [Fact, Category("Create")]
        public async Task OwnerCanCreateApprovedSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            SkillCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "TestSkill",
            };

            SkillResponse? response = await this.PostAsync<SkillCreateRequest, SkillResponse>($"/api/{ApiVersion}/skills", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Approved.ToString(), response.State);
        }

        [Fact, Category("Create")]
        public async Task MemberCanCreatePendingSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            SkillCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "TestSkill",
            };

            SkillResponse? response = await this.PostAsync<SkillCreateRequest, SkillResponse>($"/api/{ApiVersion}/skills", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Pending.ToString(), response.State);
        }

        [Fact, Category("Update")]
        public async Task GroupAdminCanUpdateApprovedSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            SkillResponse? response = await this.GetAsync<SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}", accessToken);

            Assert.NotNull(response);

            SkillUpdateRequest request = new()
            {
                Name = "Updated TestSkill",
                AbilityId = new Guid(Utilities.PendingAbilityId),
                Description = response!.Description,
                IconUrl = response!.IconUrl,
            };

            response = await this.PutAsync<SkillUpdateRequest, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(request.AbilityId, response.AbilityId);
            Assert.Equal(SuggestionState.Approved.ToString(), response.State);
        }

        [Fact, Category("Update")]
        public async Task CreatorCanNotUpdateApprovedSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            SkillUpdateRequest request = new()
            {
                Name = "Updated TestSkill",
            };

            SkillResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PutAsync<SkillUpdateRequest, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Update")]
        public async Task GroupMemberCanNotUpdateApprovedSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupMember2UserId)!;

            SkillUpdateRequest request = new()
            {
                Name = "Updated TestSkill",
            };

            SkillResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PutAsync<SkillUpdateRequest, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task GroupAdminCanUpdatePendingSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            SkillUpdateRequest request = new()
            {
                Name = "Updated TestSkill",
            };

            SkillResponse? response = await this.PutAsync<SkillUpdateRequest, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Pending.ToString(), response.State);
        }

        [Fact, Category("Update")]
        public async Task CreatorCanUpdatePendingSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            SkillResponse? response = await this.GetAsync<SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}", accessToken);

            Assert.NotNull(response);

            SkillUpdateRequest request = new()
            {
                Name = "Updated TestSkill",
                AbilityId = response!.AbilityId,
                Description = response!.Description,
                IconUrl = response!.IconUrl,
            };

            response = await this.PutAsync<SkillUpdateRequest, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Pending.ToString(), response.State);
        }

        [Fact, Category("Update")]
        public async Task GroupMemberCanNotUpdatePendingSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupMember2UserId)!;

            SkillUpdateRequest request = new()
            {
                Name = "Updated TestSkill",
            };

            SkillResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PutAsync<SkillUpdateRequest, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Update")]
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

        [Fact, Category("GetAttributes")]
        public async Task CanGetAbilityTags()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            List<AttributeValueResponse>? response = await this.GetAsync<List<AttributeValueResponse>>($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}/attributes", accessToken);

            Assert.NotNull(response);
            Assert.NotEmpty(response);
        }

        [Fact, Category("SetAttributes")]
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

        [Fact, Category("SetAttributes")]
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

        [Fact, Category("Approve")]
        public async Task GroupAdminCanApproveSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            SkillResponse? response = await this.PostAsync<object, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}/approve", new(), accessToken);

            Assert.NotNull(response);
            Assert.Equal(SuggestionState.Approved.ToString(), response.State);
            Assert.Equal(SuggestionState.Approved.ToString(), response.Ability!.State);
        }

        [Fact, Category("Approve")]
        public async Task CreatorCanNotApproveSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            SkillResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<object, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}/approve", new(), accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Approve")]
        public async Task GroupMemberCanNotApproveSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupMember2UserId)!;

            SkillResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<object, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}/approve", new(), accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Reject")]
        public async Task GroupAdminCanRejectSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            SkillResponse? response = await this.PostAsync<RejectRequest, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}/reject", request, accessToken);

            Assert.NotNull(response);
            Assert.NotNull(response.RejectedAt);
            Assert.Equal(request.Reason, response.RejectionReason);
            Assert.Equal(SuggestionState.Rejected.ToString(), response.State);
        }

        [Fact, Category("Reject")]
        public async Task CreatorCanNotRejectSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            SkillResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<RejectRequest, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}/reject", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Reject")]
        public async Task GroupMemberCanNotRejectSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupMember2UserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            SkillResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<object, SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}/reject", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Delete")]
        public async Task GroupAdminCanDeleteSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            await this.DeleteAsync($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}", accessToken);
            Exception? ex = await Record.ExceptionAsync(async () => await this.GetAsync<SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}", accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(SkillNotFoundException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Delete")]
        public async Task OwnerCanDeletePendingSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            await this.DeleteAsync($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}", accessToken);
            Exception? ex = await Record.ExceptionAsync(async () => await this.GetAsync<SkillResponse>($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}", accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(SkillNotFoundException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Delete")]
        public async Task OwnerCanNotDeleteApprovedSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            Exception? ex = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/skills/{Utilities.ApprovedSkillId}", accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Delete")]
        public async Task GroupMemberCanNotDeleteSkill()
        {
            string accessToken = this.GetToken(Utilities.GroupMember2UserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            Exception? ex = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/skills/{Utilities.PendingSkillId}", accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }
    }
}
