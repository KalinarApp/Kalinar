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
    public class AbilityTests : TestBase
    {
        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, SuggestionState.Approved)]
        [InlineData(Utilities.GroupMember1UserId, SuggestionState.Pending)]
        [InlineData(Utilities.GroupMember2UserId, SuggestionState.Pending)]
        public async Task CanCreateAbilityWithCorrectSuggestionState(string userId, SuggestionState expectedState)
        {
            string accessToken = this.GetToken(userId)!;

            AbilityCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "Testability",
                IsPassive = true,
            };

            AbilityResponse? response = await this.PostAsync<AbilityCreateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(expectedState.ToString(), response.State);
        }

        [Fact]
        public async Task UserNotInGroupCannotCreateAbility()
        {
            string accessToken = this.GetToken(Utilities.GrouplessUserId)!;

            AbilityCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "Testability",
                IsPassive = true,
            };

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<AbilityCreateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanUpdateApprovedAbility(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
            };
            AbilityResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(updatedResponse);
                Assert.Equal(request.Name, updatedResponse!.Name);
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
        public async Task GroupAdminCanUpdatePendingAbility(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            AbilityUpdateRequest request = new()
            {
                Name = "Updated Testability",
                IsPassive = true,
            };
            AbilityResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<AbilityUpdateRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(updatedResponse);
                Assert.Equal(request.Name, updatedResponse!.Name);
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
        public async Task CanGetAbilityTags()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            List<string>? response = await this.GetAsync<List<string>>($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}/tags", accessToken);

            Assert.NotNull(response);
            Assert.Contains(response, tag => tag == Utilities.ApprovedAbilityTags.First());
        }

        [Fact]
        public async Task CanSetAbilityTags()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;
                List<string> data = new List<string> { "Test", "Tag" };

            Exception? ex = await Record.ExceptionAsync(async () => await this.PostAsync<List<string>>($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}/tags", data, accessToken: accessToken));
            List<string>? response = await this.GetAsync<List<string>>($"/api/{ApiVersion}/abilities/{Utilities.ApprovedAbilityId}/tags", accessToken);

            Assert.NotNull(response);

            Assert.Equal(data, response);
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanApproveAbility(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<object, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}/approve", new(), accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(response);
                Assert.Equal(SuggestionState.Approved.ToString(), response.State);
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
        public async Task CanRejectAbility(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            RejectRequest request = new() { Reason = "Reason" };

            AbilityResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<RejectRequest, AbilityResponse>($"/api/{ApiVersion}/abilities/{Utilities.PendingAbilityId}/reject", request, accessToken));

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
        public async Task CanDeleteAbility(string userId, SuggestionState state, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            string abilityId = state switch
            {
                SuggestionState.Pending => Utilities.PendingAbilityId,
                SuggestionState.Approved => Utilities.ApprovedAbilityId,
                SuggestionState.Rejected => Utilities.RejectedAbilityId,
                _ => throw new NotImplementedException(),
            };

            SkillResponse? response = default;
            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/abilities/{abilityId}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => response = await this.GetAsync<SkillResponse>($"/api/{ApiVersion}/abilities/{abilityId}", accessToken));

            if (hasPermissions)
            {
                Assert.IsType<HttpErrorException>(getException);
                Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
                Assert.Equal(nameof(AbilityNotFoundException), ((HttpErrorException)getException!).Type);
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
