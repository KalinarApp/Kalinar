using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;
using Kalinar.Test.Seeding;

using System.Net;

using Xunit;

namespace Kalinar.Test
{
    public class AttributeTests : TestBase
    {
        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, SuggestionState.Approved)]
        [InlineData(Utilities.GroupMember1UserId, SuggestionState.Pending)]
        [InlineData(Utilities.GroupMember2UserId, SuggestionState.Pending)]
        public async Task CanCreateAttributeWithCorrectSuggestionState(string userId, SuggestionState expectedState)
        {
            string accessToken = this.GetToken(userId)!;

            AttributeCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "TestAttribute",
                MaxValue = 10,
                MinValue = 0,
                StepSize = 1,
            };

            AttributeResponse? response = await this.PostAsync<AttributeCreateRequest, AttributeResponse>($"/api/{ApiVersion}/attributes", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(expectedState.ToString(), response.State);
        }

        [Fact]
        public async Task UserNotInGroupCannotCreateAttribute()
        {
            string accessToken = this.GetToken(Utilities.GrouplessUserId)!;

            AttributeCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "TestAttribute",
                MaxValue = 10,
                MinValue = 0,
                StepSize = 1,
            };

            AttributeResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<AttributeCreateRequest, AttributeResponse>($"/api/{ApiVersion}/attributes", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanUpdateApprovedAttribute(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            AttributeUpdateRequest request = new()
            {
                Name = "Updated TestAttribute",
                MaxValue = 20,
                MinValue = 10,
                StepSize = 2,
            };
            AttributeResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<AttributeUpdateRequest, AttributeResponse>($"/api/{ApiVersion}/attributes/{Utilities.ApprovedAttribute1Id}", request, accessToken));

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
        public async Task GroupAdminCanUpdatePendingAttribute(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            AttributeUpdateRequest request = new()
            {
                Name = "Updated TestAttribute",
                MaxValue = 20,
                MinValue = 10,
                StepSize = 2,
            };

            AttributeResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<AttributeUpdateRequest, AttributeResponse>($"/api/{ApiVersion}/attributes/{Utilities.PendingAttributeId}", request, accessToken));

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

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanApproveAttribute(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            AttributeResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<object, AttributeResponse>($"/api/{ApiVersion}/attributes/{Utilities.PendingAttributeId}/approve", new(), accessToken));

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
        public async Task CanRejectAttribute(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            RejectRequest request = new() { Reason = "Reason" };

            AttributeResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<RejectRequest, AttributeResponse>($"/api/{ApiVersion}/attributes/{Utilities.PendingAttributeId}/reject", request, accessToken));

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
        public async Task CanDeleteAttribute(string userId, SuggestionState state, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            string AttributeId = state switch
            {
                SuggestionState.Pending => Utilities.PendingAttributeId,
                SuggestionState.Approved => Utilities.ApprovedAttribute1Id,
                SuggestionState.Rejected => Utilities.RejectedAttributeId,
                _ => throw new NotImplementedException(),
            };

            SkillResponse? response = default;
            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/attributes/{AttributeId}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => response = await this.GetAsync<SkillResponse>($"/api/{ApiVersion}/attributes/{AttributeId}", accessToken));

            if (hasPermissions)
            {
                Assert.IsType<HttpErrorException>(getException);
                Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
                Assert.Equal(nameof(AttributeNotFoundException), ((HttpErrorException)getException!).Type);
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
