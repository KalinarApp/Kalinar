using System.Runtime.Serialization;

namespace Hero.Server.Core.Exceptions
{

    [Serializable]
    public class HeroException : Exception
    {
        public HeroException(string message) : base(message)
        { }

        public HeroException(string message, Exception inner) : base(message, inner)
        { }

        protected HeroException(SerializationInfo info, StreamingContext context) : base(info, context) { }
    }
}
