﻿using AutoMapper.Execution;
using FirebaseAdmin.Auth;
using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Models;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;

namespace Hero.Server.Controllers
{
    public class HeroControllerBase : ControllerBase
    {
        protected readonly ILogger logger;

        public HeroControllerBase(ILogger logger)
        {
            this.logger = logger;
        }

        protected IActionResult HandleErrors()
        {
            IExceptionHandlerFeature ex = this.HttpContext.Features.Get<IExceptionHandlerFeature>()!;

            this.logger.LogUnknownErrorOccured(ex.Error);

            IActionResult response;
            if (ex.Error is GroupAccessForbiddenException || ex.Error is AccessForbiddenException)
            {
                response = this.Forbid();
            }
            else if(ex.Error is ObjectNotFoundException)
            {
                response = this.NotFound();
            }
            else
            {
                response = this.Problem(title: ex.Error.Message, type: ex.Error.GetType().Name);
            }

            return response;
        }
    }
}
