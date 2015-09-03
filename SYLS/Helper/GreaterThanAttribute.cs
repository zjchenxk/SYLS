using System;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
using System.Collections.Generic;

namespace SYLS.Helper
{
    /// <summary>
    /// 大于比较自定义验证
    /// </summary>
    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = true)]
    public class GreaterThanAttribute : ValidationAttribute, IClientValidatable
    {
        public string OtherProperty { get; private set; }

        private const string defaultErrorMessage = "{0} not greater than {1}!";

        public GreaterThanAttribute(string otherProperty)
            : base(defaultErrorMessage)
        {
            if (string.IsNullOrEmpty(otherProperty))
            {
                throw new ArgumentNullException("otherProperty");
            }
            OtherProperty = otherProperty;
        }

        public override string FormatErrorMessage(string name)
        {
            return string.Format(ErrorMessageString, name, OtherProperty);
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (value != null)
            {
                var otherProperty = validationContext.ObjectInstance.GetType().GetProperty(OtherProperty);
                var otherPropertyValue = otherProperty.GetValue(validationContext.ObjectInstance, null);
                if (otherPropertyValue != null)
                {
                    if (decimal.Parse(value.ToString()) <= decimal.Parse(otherPropertyValue.ToString()))
                    {
                        return new ValidationResult(FormatErrorMessage(validationContext.DisplayName));
                    }
                }
            }
            return ValidationResult.Success;
        }

        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            var rule = new ModelClientValidationRule()
            {
                ValidationType = "greaterthan",
                ErrorMessage = FormatErrorMessage(metadata.GetDisplayName())
            };

            rule.ValidationParameters["otherproperty"] = OtherProperty;

            yield return rule;
        }

    }

}