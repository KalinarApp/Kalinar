using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace Kalinar.Messages.Attributes
{
    public class IsHexColorAttribute : ValidationAttribute
    {
        private const string HexColorPattern = @"^#?([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$";

        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            if (value == null || value is not string colorCode)
            {
                return ValidationResult.Success;
            }

            if (!Regex.IsMatch(colorCode, HexColorPattern))
            {
                return new ValidationResult("Invalid hex color format. It should be either a 3-digit or 6-digit hexadecimal value.");
            }

            return ValidationResult.Success;
        }
    }
}
