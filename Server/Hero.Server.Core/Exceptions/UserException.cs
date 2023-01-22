using System.Runtime.Serialization;

namespace Hero.Server.Core.Exceptions
{

    [Serializable]
    public class UserException : HeroException
    {
        public UserException(string message) : base(message)
        { }

        public UserException(string message, Exception inner) : base(message, inner)
        { }

        protected UserException(SerializationInfo info, StreamingContext context) : base(info, context)
        { }
    }
}
