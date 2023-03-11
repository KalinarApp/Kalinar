using System.Runtime.Serialization;

namespace Hero.Server.Core.Exceptions
{

    [Serializable]
    public class AccessForbiddenException : HeroException
    {
        public AccessForbiddenException(string message) : base(message)
        { }

        public AccessForbiddenException(string message, Exception inner) : base(message, inner)
        { }

        protected AccessForbiddenException(SerializationInfo info, StreamingContext context) : base(info, context)
        { }
    }
}
