using System.Runtime.Serialization;

namespace Hero.Server.Core.Exceptions
{

	[Serializable]
	public class ObjectNotFoundException : HeroException
	{
		public ObjectNotFoundException(string message) : base(message) { }
		public ObjectNotFoundException(string message, Exception inner) : base(message, inner) { }
		protected ObjectNotFoundException(SerializationInfo info, StreamingContext context) : base(info, context) { }
	}
}
