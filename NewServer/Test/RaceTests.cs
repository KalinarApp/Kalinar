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
    public class RaceTests : TestBase
    {
        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, SuggestionState.Approved)]
        [InlineData(Utilities.GroupMember1UserId, SuggestionState.Pending)]
        public async Task CanCreateRaceWithCorrectSuggestionState(string userId, SuggestionState expectedSuggestionState)
        {
            string accessToken = this.GetToken(userId)!;

            RaceCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "TestRace",
            };

            RaceResponse? response = await this.PostAsync<RaceCreateRequest, RaceResponse>($"/api/{ApiVersion}/races", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response!.Name);
            Assert.Equal(expectedSuggestionState.ToString(), response.State);
        }

        [Fact]
        public async Task UserNotInGroupCannotCreateRace()
        {
            string accessToken = this.GetToken(Utilities.GrouplessUserId)!;

            RaceCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "TestRace",
            };

            RaceResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<RaceCreateRequest, RaceResponse>($"/api/{ApiVersion}/races", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanUpdateApprovedRace(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            RaceResponse? response = await this.GetAsync<RaceResponse>($"/api/{ApiVersion}/races/{Utilities.ApprovedRaceId}", accessToken);

            Assert.NotNull(response);

            RaceUpdateRequest request = new()
            {
                Name = "Updated TestRace",
                Description = response!.Description,
            };

            RaceResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<RaceUpdateRequest, RaceResponse>($"/api/{ApiVersion}/races/{Utilities.ApprovedRaceId}", request, accessToken));

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
        public async Task CanUpdatePendingRace(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            RaceResponse? response = await this.GetAsync<RaceResponse>($"/api/{ApiVersion}/races/{Utilities.PendingRaceId}", accessToken);

            Assert.NotNull(response);

            RaceUpdateRequest request = new()
            {
                Name = "Updated TestRace",
                Description = response!.Description,
            };

            RaceResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<RaceUpdateRequest, RaceResponse>($"/api/{ApiVersion}/races/{Utilities.PendingRaceId}", request, accessToken));

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
        public async Task CanGetRaceAttributes()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            List<AttributeValueResponse>? response = await this.GetAsync<List<AttributeValueResponse>>($"/api/{ApiVersion}/races/{Utilities.ApprovedRaceId}/attributes", accessToken);

            Assert.NotNull(response);
            Assert.NotEmpty(response);
        }

        [Fact]
        public async Task CanSetRaceAttributes()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;
            List<RaceAttributeRequest> data = new()
            {
                new RaceAttributeRequest()
                {
                    AttributeId = new Guid(Utilities.ApprovedAttribute2Id),
                    Value = 1,
                },
            };

            Exception? ex = await Record.ExceptionAsync(async () => await this.PostAsync($"/api/{ApiVersion}/races/{Utilities.ApprovedRaceId}/attributes", data, accessToken: accessToken));

            Assert.Null(ex);

            List<AttributeValueResponse>? response = await this.GetAsync<List<AttributeValueResponse>>($"/api/{ApiVersion}/races/{Utilities.ApprovedRaceId}/attributes", accessToken);

            Assert.NotNull(response);
            Assert.Contains(response, item => item.AttributeId == data.First().AttributeId);
        }

        [Fact]
        public async Task CanNotSetRaceAttributeIfRaceIsApprovedButAttributeIsPending()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;
            List<RaceAttributeRequest> data = new()
            {
                new RaceAttributeRequest()
                {
                    AttributeId = new Guid(Utilities.PendingAttributeId),
                    Value = 1,
                },
            };

            Exception? ex = await Record.ExceptionAsync(async () => await this.PostAsync($"/api/{ApiVersion}/races/{Utilities.ApprovedRaceId}/attributes", data, accessToken: accessToken));

            Assert.NotNull(ex);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Conflict, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(AttributeNotApprovedException), ((HttpErrorException)ex!).Type);
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanApproveRace(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            RaceResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<object, RaceResponse>($"/api/{ApiVersion}/races/{Utilities.PendingRaceId}/approve", new(), accessToken));
            List<AttributeValueResponse>? attributesResponse = await this.GetAsync<List<AttributeValueResponse>>($"/api/{ApiVersion}/races/{Utilities.PendingRaceId}/attributes", accessToken);

            if (hasPermissions)
            {
                Assert.NotNull(response);
                Assert.Equal(SuggestionState.Approved.ToString(), response.State);
                Assert.Collection(attributesResponse, item => Assert.Equal(SuggestionState.Approved.ToString(), item.Attribute.State));
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
        public async Task CanRejectRace(string userId, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;

            RejectRequest request = new() { Reason = "Reason" };

            RaceResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<RejectRequest, RaceResponse>($"/api/{ApiVersion}/races/{Utilities.PendingRaceId}/reject", request, accessToken));

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
        public async Task CanDeleteRace(string userId, SuggestionState state, bool hasPermissions)
        {
            string accessToken = this.GetToken(userId)!;
            string RaceId = state switch
            {
                SuggestionState.Pending => Utilities.PendingRaceId,
                SuggestionState.Approved => Utilities.ApprovedRaceId,
                SuggestionState.Rejected => Utilities.RejectedRaceId,
                _ => throw new NotImplementedException(),
            };

            RaceResponse? response = default;
            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/races/{RaceId}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => response = await this.GetAsync<RaceResponse>($"/api/{ApiVersion}/races/{RaceId}", accessToken));

            if (hasPermissions)
            {
                Assert.IsType<HttpErrorException>(getException);
                Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
                Assert.Equal(nameof(RaceNotFoundException), ((HttpErrorException)getException!).Type);
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
