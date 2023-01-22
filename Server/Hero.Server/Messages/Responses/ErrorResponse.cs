using Hero.Server.Core;

namespace Hero.Server.Messages.Responses
{
    public class ErrorResponse
    {
        public ErrorResponse(ErrorCode code, string message)
        {
            this.Errors = new()
            {
                { code.ToString(), message },
            };
        }

        public Dictionary<string, string> Errors { get; private set; }
    }
}