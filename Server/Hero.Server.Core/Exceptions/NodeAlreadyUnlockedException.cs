using System.Runtime.Serialization;

namespace Hero.Server.Core.Exceptions
{

	[Serializable]
	public class NodeAlreadyUnlockedException : HeroException
	{
		public NodeAlreadyUnlockedException(string message) : base(message) { }
		public NodeAlreadyUnlockedException(string message, Exception inner) : base(message, inner) { }
		protected NodeAlreadyUnlockedException(SerializationInfo info, StreamingContext context) : base(info, context) { }
	}
}
