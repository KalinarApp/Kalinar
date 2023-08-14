using Kalinar.Application.Messages.Responses;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;

using System.ComponentModel.DataAnnotations;

namespace Kalinar.ErrorHandling
{
    public class InvalidModelStateResponseFactory
    {
        public static IActionResult GenerateErrorResponse(ActionContext context)
        {
            List<string> errors = new();
            foreach (KeyValuePair<string, ModelStateEntry?> modelStatePair in context.ModelState.AsEnumerable())
            {
                if (modelStatePair.Value is not null)
                {
                    errors.AddRange(modelStatePair.Value.Errors.Select(e => e.ErrorMessage));
                }
            }

            ErrorResponse response = new() { Type = nameof(ValidationException), Errors = errors };
            return new BadRequestObjectResult(response);
        }
    }
}
