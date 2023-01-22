using System.Runtime.Serialization;

namespace Hero.Server.Core.Exceptions
{

	[Serializable]
	public class NodeNotResettableException : HeroException
	{
		public NodeNotResettableException(string message) : base(message) { }
		public NodeNotResettableException(string message, Exception inner) : base(message, inner) { }
		protected NodeNotResettableException(SerializationInfo info, StreamingContext context) : base(info, context) { }
	}
}
