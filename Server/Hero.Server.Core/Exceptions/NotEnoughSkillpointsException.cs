using System.Runtime.Serialization;

namespace Hero.Server.Core.Exceptions
{

	[Serializable]
	public class NotEnoughSkillpointsException : HeroException
	{
		public NotEnoughSkillpointsException(string message) : base(message) { }
		public NotEnoughSkillpointsException(string message, Exception inner) : base(message, inner) { }
		protected NotEnoughSkillpointsException(SerializationInfo info, StreamingContext context) : base(info, context) { }
	}
}
