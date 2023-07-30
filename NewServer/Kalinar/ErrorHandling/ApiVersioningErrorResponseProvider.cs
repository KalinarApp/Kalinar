using Kalinar.Messages.Responses;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Versioning;

using System.Net;

namespace Kalinar.ErrorHandling
{
    public class ApiVersioningErrorResponseProvider : DefaultErrorResponseProvider
    {
        public override IActionResult CreateResponse(ErrorResponseContext context)
        {
            List<string> errors = new() { "Selected api version does not exist" };
            ErrorResponse errorResponse = new() { Type = "VersioningError", Errors = errors };

            return new ObjectResult(errorResponse)
            {
                StatusCode = (int)HttpStatusCode.BadRequest
            };
        }
    }
}
