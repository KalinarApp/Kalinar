using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;
using Kalinar.Test.Integration.Seeding;

using System.Net;

using Xunit;

namespace Kalinar.Test.Integration
{
    public class StoryEventTests : TestBase
    {
        // write the integration tests for StoryEventsController here
        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        [InlineData(Utilities.GrouplessUserId, false)]
        public async Task CanCreateStoryEvent(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            StoryEventCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Title = "Test Story Event",
                Order = 1,
                Date = "Yersterday",
            };
            StoryEventResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<StoryEventCreateRequest, StoryEventResponse>($"/api/{ApiVersion}/story-events", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(response);
                Assert.Equal(request.Title, response.Title);
                Assert.Equal(request.Order, response.Order);
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
        public async Task CanUpdateStoryEvent(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            StoryEventResponse? response = await this.GetAsync<StoryEventResponse>($"/api/{ApiVersion}/story-events/{Utilities.StoryEventId}", accessToken);

            Assert.NotNull(response);

            StoryEventUpdateRequest request = new()
            {
                Title = "Test Story Event",
                Order = 2,
                Date = "Tomorrow",
            };

            StoryEventResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<StoryEventUpdateRequest, StoryEventResponse>($"/api/{ApiVersion}/story-events/{Utilities.StoryEventId}", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(updatedResponse);
                Assert.Equal(request.Title, updatedResponse!.Title);
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
        public async Task CanDeleteStoryEvent(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            StoryEventResponse? response = default;
            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/story-events/{Utilities.StoryEventId}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => response = await this.GetAsync<StoryEventResponse>($"/api/{ApiVersion}/story-events/{Utilities.StoryEventId}", accessToken));

            if (hasPermissions)
            {
                Assert.IsType<HttpErrorException>(getException);
                Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
                Assert.Equal(nameof(StoryEventNotFoundException), ((HttpErrorException)getException!).Type);
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
