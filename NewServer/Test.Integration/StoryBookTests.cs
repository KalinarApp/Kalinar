using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;
using Kalinar.Test.Integration.Seeding;

using System.Net;

using Xunit;

namespace Kalinar.Test.Integration
{
    public class StoryBookTests : TestBase
    {
        // write the integration tests for StoryBooksController here
        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        [InlineData(Utilities.GrouplessUserId, false)]
        public async Task CanCreateStoryBook(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            StoryBookCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Title = "Test Story Book",
            };
            StoryBookResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<StoryBookCreateRequest, StoryBookResponse>($"/api/{ApiVersion}/story-books", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(response);
                Assert.Equal(request.Title, response.Title);
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
        [InlineData(Utilities.GrouplessUserId, false)]
        public async Task CanCreateStoryBookPage(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            StoryBookPageCreateRequest request = new()
            {
                BookId = new Guid(Utilities.StoryBookId),
                Title = "Test Story Book Page",
                Content = "Test Story Book Page Content"
            };
            StoryBookPageResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<StoryBookPageCreateRequest, StoryBookPageResponse>($"/api/{ApiVersion}/story-books/{Utilities.StoryBookId}/pages", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(response);
                Assert.Equal(request.Title, response.Title);
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
        public async Task CanUpdateStoryBook(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            StoryBookResponse? response = await this.GetAsync<StoryBookResponse>($"/api/{ApiVersion}/story-books/{Utilities.StoryBookId}", accessToken);

            Assert.NotNull(response);

            StoryBookUpdateRequest request = new()
            {
                Title = "Test Story Book",
            };

            StoryBookResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<StoryBookUpdateRequest, StoryBookResponse>($"/api/{ApiVersion}/story-books/{Utilities.StoryBookId}", request, accessToken));

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
        public async Task CanUpdateStoryBookPage(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            StoryBookPageResponse response = await this.GetAsync<StoryBookPageResponse>($"/api/{ApiVersion}/story-books/{Utilities.StoryBookId}/pages/{Utilities.StoryBookPage1Id}", accessToken);

            Assert.NotNull(response);

            StoryBookPageUpdateRequest request = new()
            {
                Title = "Test Story Book",
                Content = "Test Story Book Content",
            };

            StoryBookPageResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<StoryBookPageUpdateRequest, StoryBookPageResponse>($"/api/{ApiVersion}/story-books/{Utilities.StoryBookId}/pages/{Utilities.StoryBookPage1Id}", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(updatedResponse);
                Assert.Equal(request.Title, updatedResponse.Title);
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
        public async Task CanDeleteStoryBook(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            StoryBookResponse? response = default;
            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/story-books/{Utilities.StoryBookId}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => response = await this.GetAsync<StoryBookResponse>($"/api/{ApiVersion}/story-books/{Utilities.StoryBookId}", accessToken));

            if (hasPermissions)
            {
                Assert.IsType<HttpErrorException>(getException);
                Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
                Assert.Equal(nameof(StoryBookNotFoundException), ((HttpErrorException)getException!).Type);
            }
            else
            {
                Assert.IsType<HttpErrorException>(deleteException);
                Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)deleteException!).StatusCode);
                Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)deleteException!).Type);
            }
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanDeleteStoryBookPage(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            StoryBookPageResponse? response = default;
            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/story-books/{Utilities.StoryBookId}/pages/{Utilities.StoryBookPage1Id}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => response = await this.GetAsync<StoryBookPageResponse>($"/api/{ApiVersion}/story-books/{Utilities.StoryBookId}/pages/{Utilities.StoryBookPage1Id}", accessToken));

            if (hasPermissions)
            {
                Assert.IsType<HttpErrorException>(getException);
                Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
                Assert.Equal(nameof(StoryBookPageNotFoundException), ((HttpErrorException)getException!).Type);
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
