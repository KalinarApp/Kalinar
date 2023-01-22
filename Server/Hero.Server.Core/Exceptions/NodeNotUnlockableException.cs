using System.Runtime.Serialization;

namespace Hero.Server.Core.Exceptions
{

	[Serializable]
	public class NodeNotUnlockableException : HeroException
	{
		public NodeNotUnlockableException(string message) : base(message) { }
		public NodeNotUnlockableException(string message, Exception inner) : base(message, inner) { }
		protected NodeNotUnlockableException(SerializationInfo info, StreamingContext context) : base(info, context) { }
	}
}
