using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;
using Kalinar.Test.Seeding;

using System.Net;

using Xunit;

namespace Kalinar.Test
{
    public class AbilityTests : TestBase
    {
        [Fact]
        public async Task TestOwnerCreateApprovedAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            AbilityCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "Testability",
                IsPassive = true,
                Tags = new(),
            };

            AbilityResponse? response = await this.PostAsync<AbilityCreateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Approved.ToString(), response.State);
        }

        [Fact]
        public async Task TestMemberCreatePendingAbility()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            AbilityCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "Testability",
                IsPassive = true,
                Tags = new(),
            };

            AbilityResponse? response = await this.PostAsync<AbilityCreateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Pending.ToString(), response.State);
        }

        [Fact]
        public async Task TestUpdateApprovedAbilityAsGroupAdmin()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
                Tags = new(),
            };

            AbilityResponse? response = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Approved.ToString(), response.State);
        }

        [Fact]
        public async Task TestUpdateApprovedAbilityAsCreator()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
                Tags = new(),
            };

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task TestUpdateApprovedAbilityAsGroupMember()
        {
            string accessToken = this.GetToken(Utilities.GroupMember2UserId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
                Tags = new(),
            };

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task TestUpdatePendingAbilityAsGroupAdmin()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
                Tags = new(),
            };

            AbilityResponse? response = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Pending.ToString(), response.State);
        }

        [Fact]
        public async Task TestUpdatePendingAbilityAsCreator()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
                Tags = new(),
            };

            AbilityResponse? response = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(SuggestionState.Pending.ToString(), response.State);
        }

        [Fact]
        public async Task TestUpdatePendingAbilityAsGroupMember()
        {
            string accessToken = this.GetToken(Utilities.GroupMember2UserId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
                Tags = new(),
            };

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task TestApproveAbilityAsGroupAdmin()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            AbilityResponse? response = await this.PostAsync<object, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}/approve", new(), accessToken);

            Assert.NotNull(response);
            Assert.Equal(SuggestionState.Approved.ToString(), response.State);
        }

        [Fact]
        public async Task TestApproveAbilityAsCreator()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<object, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}/approve", new(), accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task TestApproveAbilityAsGroupMember()
        {
            string accessToken = this.GetToken(Utilities.GroupMember2UserId)!;

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<object, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}/approve", new(), accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task TestRejectAbilityAsGroupAdmin()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            RejectRequest request = new() { Reason = "Reason" };

            AbilityResponse? response = await this.PostAsync<RejectRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}/reject", request, accessToken);

            Assert.NotNull(response);
            Assert.NotNull(response.RejectedAt);
            Assert.Equal(request.Reason, response.RejectionReason);
            Assert.Equal(SuggestionState.Rejected.ToString(), response.State);
        }

        [Fact]
        public async Task TestRejectAbilityAsCreator()
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

        [Fact]
        public async Task TestRejectAbilityAsGroupMember()
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
    }
}
