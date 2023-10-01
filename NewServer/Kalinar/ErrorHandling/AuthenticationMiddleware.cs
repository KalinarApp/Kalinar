using Kalinar.Application.Messages.Responses;

using System.Net;
using System.Text.Json;

namespace Kalinar.ErrorHandling
{
    public class AuthenticationMiddleware
    {
        private readonly RequestDelegate next;

        public AuthenticationMiddleware(RequestDelegate next)
        {
            this.next = next;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            await this.next(context);

            if (context.Response.StatusCode == (int)HttpStatusCode.Unauthorized)
            {
                context.Response.ContentType = "application/json";
                List<string> errors = new() { "User is not authenticated"};
                ErrorResponse errorResponse = new() { Type = "AuthenticationError", Errors = errors };
                await context.Response.WriteAsync(JsonSerializer.Serialize(errorResponse));
            }
        }
    }
}
