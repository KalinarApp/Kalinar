using System.Runtime.Serialization;

namespace Hero.Server.Core.Exceptions
{

	[Serializable]
	public class GroupAccessForbiddenException : HeroException
	{
		public GroupAccessForbiddenException(string message) : base(message) { }
		public GroupAccessForbiddenException(string message, Exception inner) : base(message, inner) { }
		protected GroupAccessForbiddenException(SerializationInfo info, StreamingContext context) : base(info, context) { }
	}
}
