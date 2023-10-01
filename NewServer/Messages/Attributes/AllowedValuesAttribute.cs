using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Attributes
{
    public class AllowedValuesAttribute : ValidationAttribute
    {
        private readonly object[] _allowedValues;

        public AllowedValuesAttribute(params object[] allowedValues)
        {
            _allowedValues = allowedValues;
        }

        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            if (_allowedValues.Contains(value?.ToString()))
            {
                return ValidationResult.Success;
            }

            string allowedValuesString = string.Join(", ", _allowedValues);
            return new ValidationResult($"The field {validationContext.DisplayName} must be one of the following values: {allowedValuesString}.");
        }
    }
}
