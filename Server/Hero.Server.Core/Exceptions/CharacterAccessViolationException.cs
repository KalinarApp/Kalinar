using System.Runtime.Serialization;

namespace Hero.Server.Core.Exceptions
{

	[Serializable]
	public class CharacterAccessViolationException : HeroException
	{
		public CharacterAccessViolationException(string message) : base(message) { }
		public CharacterAccessViolationException(string message, Exception inner) : base(message, inner) { }
		protected CharacterAccessViolationException(SerializationInfo info, StreamingContext context) : base(info, context) { }
	}
}
