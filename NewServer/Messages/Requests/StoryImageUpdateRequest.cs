﻿using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    public class StoryImageUpdateRequest
    {
        [Required]

        [MaxLength(128, ErrorMessage = $"{nameof(Title)} cannot be longer than 128 characters")]
        public required string Title { get; init; }
        [Required]
        public required string ImageUrl { get; init; }
        [Required]
        public bool IsUnlocked { get; init; }
    }
}
