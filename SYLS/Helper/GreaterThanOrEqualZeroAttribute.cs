using System;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
using System.Collections.Generic;

namespace SYLS.Helper
{
    /// <summary>
    /// 大于或等于0验证器
    /// </summary>
    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = true)]
    public class GreaterThanOrEqualZeroAttribute : ValidationAttribute, IClientValidatable
    {
        private const string defaultErrorMessage = "{0} not greater than or equal zero!";

        public GreaterThanOrEqualZeroAttribute()
            : base(defaultErrorMessage)
        {
        }

        public override string FormatErrorMessage(string name)
        {
            return string.Format(ErrorMessageString, name);
        }

        public override bool IsValid(object value)
        {
            if (value == null)
            {
                return false;
            }
            return (decimal.Parse(value.ToString()) >= 0);
        }

        public IEnumerable<System.Web.Mvc.ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            var rule = new ModelClientValidationRule()
            {
                ValidationType = "greaterthanorequalzero",
                ErrorMessage = FormatErrorMessage(metadata.GetDisplayName())
            };

            yield return rule;
        }
    }
}