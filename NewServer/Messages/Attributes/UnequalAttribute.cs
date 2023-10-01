using System.ComponentModel.DataAnnotations;
using System.Reflection;

namespace Kalinar.Messages.Attributes
{
    [AttributeUsage(AttributeTargets.Class, AllowMultiple = true)]
    public class UnequalAttribute : ValidationAttribute
    {
        private readonly string property1Name;
        private readonly string property2Name;

        public UnequalAttribute(string property1Name, string property2Name)
        {
            this.property1Name = property1Name;
            this.property2Name = property2Name;
        }

        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            PropertyInfo? property1 = validationContext.ObjectType.GetProperty(this.property1Name);
            PropertyInfo? property2 = validationContext.ObjectType.GetProperty(property2Name);

            if (property1 != null && property2 != null)
            {
                object? property1Value = property1.GetValue(validationContext.ObjectInstance);
                object? property2Value = property2.GetValue(validationContext.ObjectInstance);

                if (Equals(property1Value, property2Value))
                {
                    return new ValidationResult(this.ErrorMessage);
                }
            }

            return ValidationResult.Success;
        }
    }
}
