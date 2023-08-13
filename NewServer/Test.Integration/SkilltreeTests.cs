using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;
using Kalinar.Test.Integration.Seeding;

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
    }
}
