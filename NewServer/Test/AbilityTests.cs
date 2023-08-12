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
    [Category("Ability")]
    public class AbilityTests : TestBase
    {
        [Fact, Category("Create")]
        public async Task OwnerCanCreateApprovedAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            AbilityCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "Testability",
                IsPassive = true,
            };

            AbilityResponse? response = await this.PostAsync<AbilityCreateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Approved.ToString(), response.State);
        }

        [Fact, Category("Create")]
        public async Task MemberCanCreatePendingAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            AbilityCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "Testability",
                IsPassive = true,
            };

            AbilityResponse? response = await this.PostAsync<AbilityCreateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Pending.ToString(), response.State);
        }

        [Fact, Category("Update")]
        public async Task GroupAdminCanUpdateApprovedAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
            };

            AbilityResponse? response = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Approved.ToString(), response.State);
        }

        [Fact, Category("Update")]
        public async Task CreatorCanNotUpdateApprovedAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
            };

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Update")]
        public async Task GroupMemberCanNotUpdateApprovedAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupMember2UserId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
            };

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Update")]
        public async Task GroupAdminCanUpdatePendingAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
            };

            AbilityResponse? response = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Pending.ToString(), response.State);
        }

        [Fact, Category("Update")]
        public async Task CreatorCanUpdatePendingAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
            };

            AbilityResponse? response = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Pending.ToString(), response.State);
        }

        [Fact, Category("Update")]
        public async Task GroupMemberCanNotUpdatePendingAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupMember2UserId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
            };

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("GetTags")]
        public async Task CanGetAbilityTags()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            List<string>? response = await this.GetAsync<List<string>>($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}/tags", accessToken);

            Assert.NotNull(response);
            Assert.Contains(response, tag => tag == Utilities.ApprovedAbilityTags.First());
        }

        [Fact, Category("SetTags")]
        public async Task CanSetAbilityTags()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;
                List<string> data = new List<string> { "Test", "Tag" };

            Exception? ex = await Record.ExceptionAsync(async () => await this.PostAsync<List<string>>($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}/tags", data, accessToken: accessToken));
            List<string>? response = await this.GetAsync<List<string>>($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}/tags", accessToken);

            Assert.NotNull(response);

            Assert.Equal(data, response);
        }

        [Fact, Category("Approve")]
        public async Task GroupAdminCanApproveAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            AbilityResponse? response = await this.PostAsync<object, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}/approve", new(), accessToken);

            Assert.NotNull(response);
            Assert.Equal(SuggestionState.Approved.ToString(), response.State);
        }

        [Fact, Category("Approve")]
        public async Task CreatorCanNotApproveAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<object, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}/approve", new(), accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Approve")]
        public async Task GroupMemberCanNotApproveAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupMember2UserId)!;

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<object, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}/approve", new(), accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Reject")]
        public async Task GroupAdminCanRejectAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            AbilityResponse? response = await this.PostAsync<RejectRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}/reject", request, accessToken);

            Assert.NotNull(response);
            Assert.NotNull(response.RejectedAt);
            Assert.Equal(request.Reason, response.RejectionReason);
            Assert.Equal(SuggestionState.Rejected.ToString(), response.State);
        }

        [Fact, Category("Reject")]
        public async Task CreatorCanNotRejectAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<RejectRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}/reject", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Reject")]
        public async Task GroupMemberCanNotRejectAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupMember2UserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<object, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}/reject", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Delete")]
        public async Task GroupAdminCanDeleteAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            await this.DeleteAsync($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}", accessToken);
            Exception? ex = await Record.ExceptionAsync(async () => await this.GetAsync<AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}", accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(AbilityNotFoundException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Delete")]
        public async Task OwnerCanDeletePendingAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            await this.DeleteAsync($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}", accessToken);
            Exception? ex = await Record.ExceptionAsync(async () => await this.GetAsync<AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}", accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(AbilityNotFoundException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Delete")]
        public async Task OwnerCanNotDeleteApprovedAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            Exception? ex = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}", accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact, Category("Delete")]
        public async Task GroupMemberCanNotDeleteAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupMember2UserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            Exception? ex = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}", accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }
    }
}
