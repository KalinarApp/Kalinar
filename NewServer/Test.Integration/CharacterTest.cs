using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;
using Kalinar.Test.Integration.Seeding;

using System.Net;

using Xunit;

namespace Kalinar.Test.Integration
{
    public class CharacterTests : TestBase
    {
        [Theory]
        [InlineData(Utilities.GroupOwnerUserId)]
        [InlineData(Utilities.GroupMember1UserId)]
        [InlineData(Utilities.GroupMember2UserId)]
        public async Task CanCreateCharacter(string userId)
        {
            string accessToken = GetToken(userId)!;

            CharacterCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "TestCharacter",
                RaceId = new Guid(Utilities.ApprovedRaceId),
            };

            CharacterResponse? response = await this.PostAsync<CharacterCreateRequest, CharacterResponse>($"/api/{ApiVersion}/characters", request, accessToken);

            Assert.NotNull(response);
            Assert.Equal(request.Name, response.Name);
            Assert.Equal(userId, response.UserId);
        }

        [Fact]
        public async Task CannotCreateCharacterWithPendingRace()
        {
            string accessToken = GetToken(Utilities.GroupMember1UserId)!;

            CharacterCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Name = "TestCharacter",
                RaceId = new Guid(Utilities.PendingRaceId)
            };

            CharacterResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<CharacterCreateRequest, CharacterResponse>($"/api/{ApiVersion}/characters", request, accessToken));

            Assert.Null(response);
            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Conflict, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(RaceNotApprovedException), ((HttpErrorException)ex!).Type);
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, false)]
        [InlineData(Utilities.GroupMember1UserId, true)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanUpdateCharacter(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            CharacterResponse? response = await this.GetAsync<CharacterResponse>($"/api/{ApiVersion}/characters/{Utilities.CharacterId}", accessToken);

            Assert.NotNull(response);

            CharacterUpdateRequest request = new()
            {
                Name = "Updated TestCharacter",
                Description = response!.Description,
                IconUrl = response!.IconUrl,
            };

            CharacterResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<CharacterUpdateRequest, CharacterResponse>($"/api/{ApiVersion}/characters/{Utilities.CharacterId}", request, accessToken));

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

        [Fact]
        public async Task CanFavorizeSkills()
        {
            string accessToken = GetToken(Utilities.GroupMember1UserId)!;

            await this.PostAsync<CharacterSkillRequest>($"/api/{ApiVersion}/characters/{Utilities.CharacterId}/skills/{Utilities.ApprovedSkillId}", new() { IsFavorite = true }, accessToken);
            List<SkillResponse> favoriteSkills = await this.GetAsync<List<SkillResponse>>($"/api/{ApiVersion}/characters/{Utilities.CharacterId}/skills?isFavorite=true", accessToken);

            Assert.Contains(favoriteSkills, s => s.Id == new Guid(Utilities.ApprovedSkillId));
        }

        [Fact]
        public async Task CanUnFavorizeSkills()
        {
            string accessToken = GetToken(Utilities.GroupMember1UserId)!;

            await this.PostAsync<CharacterSkillRequest>($"/api/{ApiVersion}/characters/{Utilities.CharacterId}/skills/{Utilities.ApprovedSkillId}", new() { IsFavorite = false }, accessToken);
            List<SkillResponse> favoriteSkills = await this.GetAsync<List<SkillResponse>>($"/api/{ApiVersion}/characters/{Utilities.CharacterId}/skills?isFavorite=true", accessToken);

            Assert.DoesNotContain(favoriteSkills, s => s.Id == new Guid(Utilities.ApprovedSkillId));
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, false)]
        [InlineData(Utilities.GroupMember1UserId, true)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanDeleteCharacter(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            CharacterResponse? response = default;
            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/characters/{Utilities.CharacterId}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => response = await this.GetAsync<CharacterResponse>($"/api/{ApiVersion}/characters/{Utilities.CharacterId}", accessToken));

            if (hasPermissions)
            {
                Assert.IsType<HttpErrorException>(getException);
                Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
                Assert.Equal(nameof(CharacterNotFoundException), ((HttpErrorException)getException!).Type);
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
