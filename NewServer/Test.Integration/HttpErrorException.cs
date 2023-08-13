using System.Net;

namespace Kalinar.Test
{
    public class HttpErrorException : Exception
    {
        public HttpStatusCode StatusCode { get; init; }
        public string Type { get; init; }

        public HttpErrorException(HttpStatusCode statusCode, string type)
        {
            this.StatusCode = statusCode;
            this.Type = type;
        }
    }
}
