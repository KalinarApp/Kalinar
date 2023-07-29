using System;
using System.Text.Json.Serialization;

using Hero.Server.Core.Models;

namespace Hero.Server.Messages.Responses
{
	public class SuggestableResponse
	{
        public required UserResponse Creator { get; set; }

        [JsonConverter(typeof(JsonStringEnumConverter))]
        public SuggestionState State { get; set; }
        public string? RejectionReason { get; set; }

        public DateTimeOffset CreatedAt { get; set; }
        public DateTimeOffset? LastUpdatedAt { get; set; }
        public DateTimeOffset? ApprovedAt { get; set; }
        public DateTimeOffset? RejectedAt { get; set; }
    }
}

