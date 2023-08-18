using Xunit;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Kalinar.Application.Messages.Responses;
using Kalinar.Test.Integration.Factories;

namespace Kalinar.Test.Integration
{
    public class TestBase : IClassFixture<KalinarWebApplicationFactory<Program>>, IDisposable
    {
        protected const string ApiVersion = "v1";
        private readonly KalinarWebApplicationFactory<Program> factory;
        private readonly HttpClient client;

        // This is a hack to get around the fact that the test server is not disposed of after each test
        public TestBase()
        {
            this.factory = new KalinarWebApplicationFactory<Program>();
            this.client = this.factory.CreateClient();
        }

        public static string? GetToken(string userId)
        {
            return JwtTokenProvider.JwtSecurityTokenHandler.WriteToken(new JwtSecurityToken(
                JwtTokenProvider.Issuer,
                JwtTokenProvider.Issuer,
                new List<Claim> { new(ClaimTypes.NameIdentifier, userId), },
                expires: DateTime.Now.AddMinutes(30),
                signingCredentials: JwtTokenProvider.SigningCredentials
            ));
        }

        public async Task<T> GetAsync<T>(string endpoint, string? accessToken = default)
            where T : class
        {
            if (accessToken is not null)
                this.client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);

            HttpResponseMessage response = await this.client.GetAsync(endpoint);

            if (response.IsSuccessStatusCode)
            {
                T responseData = await response.Content.ReadFromJsonAsync<T>() ?? throw new Exception("Failed to deserialize response");
                return responseData;
            }
            else
            {
                ErrorResponse errorResponse = await response.Content.ReadFromJsonAsync<ErrorResponse>() ?? throw new Exception("Failed to deserialize response");
                throw new HttpErrorException(response.StatusCode, errorResponse.Type);
            }
        }

        public async Task<TResponse?> PostAsync<TRequest, TResponse>(string endpoint, TRequest? data = default, string? accessToken = default)
            where TRequest : class
            where TResponse : class
        {
            if (accessToken is not null)
                this.client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);

            HttpResponseMessage response = await this.client.PostAsJsonAsync(endpoint, data);

            if (response.IsSuccessStatusCode)
            {
                TResponse? responseData = await response.Content.ReadFromJsonAsync<TResponse>() ?? throw new Exception("Failed to deserialize response");
                return responseData;
            }
            else
            {
                ErrorResponse errorResponse = await response.Content.ReadFromJsonAsync<ErrorResponse>() ?? throw new Exception("Failed to deserialize response");
                throw new HttpErrorException(response.StatusCode, errorResponse.Type);
            }
        }

        public async Task PostAsync<TRequest>(string endpoint, TRequest? data = default, string? accessToken = default)
            where TRequest : class
        {
            if (accessToken is not null)
                this.client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);

            HttpResponseMessage response = await this.client.PostAsJsonAsync(endpoint, data);

            if (!response.IsSuccessStatusCode)
            {
                ErrorResponse errorResponse = await response.Content.ReadFromJsonAsync<ErrorResponse>() ?? throw new Exception("Failed to deserialize response");
                throw new HttpErrorException(response.StatusCode, errorResponse.Type);
            }
        }

        public async Task<TResponse> PutAsync<TRequest, TResponse>(string endpoint, TRequest? data = default, string? accessToken = default)
            where TRequest : class
            where TResponse : class
        {
            if (accessToken is not null)
                this.client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);

            HttpResponseMessage response = await this.client.PutAsJsonAsync(endpoint, data);

            if (response.IsSuccessStatusCode)
            {
                TResponse? responseData = await response.Content.ReadFromJsonAsync<TResponse>() ?? throw new Exception("Failed to deserialize response");
                return responseData;
            }
            else
            {
                ErrorResponse errorResponse = await response.Content.ReadFromJsonAsync<ErrorResponse>() ?? throw new Exception("Failed to deserialize response");
                throw new HttpErrorException(response.StatusCode, errorResponse.Type);
            }
        }

        public async Task DeleteAsync(string endpoint, string? accessToken = default)
        {
            if (accessToken is not null)
                this.client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);

            HttpResponseMessage response = await this.client.DeleteAsync(endpoint);

            if (!response.IsSuccessStatusCode)
            {
                ErrorResponse errorResponse = await response.Content.ReadFromJsonAsync<ErrorResponse>() ?? throw new Exception("Failed to deserialize response");
                throw new HttpErrorException(response.StatusCode, errorResponse.Type);
            }
        }

        public void Dispose()
        {
            GC.SuppressFinalize(this);
        }
    }

    public class FirebaseResponse
    {
        public required string IdToken { get; init; }
    }
}
