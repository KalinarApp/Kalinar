﻿using Kalinar.Application.Messages.Responses;
using Kalinar.Core.Exceptions;

using System.Net;
using System.Text.Json;

namespace Kalinar.ErrorHandling
{
    public class ExceptionMIddleware
    {
        private readonly ILogger<ExceptionMIddleware> logger;
        private readonly RequestDelegate next;

        public ExceptionMIddleware(ILogger<ExceptionMIddleware> logger, RequestDelegate next)
        {
            this.logger = logger;
            this.next = next;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await this.next(context);
            }
            catch (Exception ex)
            {
                this.logger.LogError(ex, "Exception occured");
                await this.HandleExceptionAsync(context, ex);
            }
        }

        private async Task HandleExceptionAsync(HttpContext context, Exception ex)
        {
            context.Response.ContentType = "application/json";
            context.Response.StatusCode = ex switch
            {
                GroupNotFoundException => (int)HttpStatusCode.NotFound,
                GroupMemberNotFoundException => (int)HttpStatusCode.NotFound, 
                UserNotFoundException => (int)HttpStatusCode.NotFound,
                UserAlreadyExistsException => (int)HttpStatusCode.Conflict,
                DeviceIdNotFoundException => (int)HttpStatusCode.NotFound,
                DeviceIdAlreadyRegisteredException => (int)HttpStatusCode.Conflict,
                AbilityNotFoundException => (int)HttpStatusCode.NotFound,
                ForbiddenAccessException => (int)HttpStatusCode.Forbidden,
                AttributeNotFoundException => (int)HttpStatusCode.NotFound,
                SkillNotFoundException => (int)HttpStatusCode.NotFound,
                _ => (int)HttpStatusCode.InternalServerError,
            };

            List<string> errors = new() {  ex.Message };
            ErrorResponse response = new() { Type = ex.GetType().Name, Errors = errors };
            await context.Response.WriteAsync(JsonSerializer.Serialize(response));
        }
    }
}
