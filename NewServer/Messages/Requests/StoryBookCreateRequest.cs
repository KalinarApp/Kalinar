﻿using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    public class StoryBookCreateRequest
    {
        [Required]
        public required Guid GroupId { get; init; }
        [Required]

        [MaxLength(128, ErrorMessage = $"{nameof(Title)} cannot be longer than 128 characters")]
        public required string Title { get; init; }

        [MaxLength(2048, ErrorMessage = $"{nameof(Description)} cannot be longer than 128 characters")]
        public string? Description { get; init; }
        public string? ImageUrl { get; init; }
        [Required]
        public bool IsUnlocked { get; init; }
    }
}
