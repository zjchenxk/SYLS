using System;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
using System.Collections.Generic;

namespace SYLS.Helper
{
    /// <summary>
    /// 大于零比较自定义验证
    /// </summary>
    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = true)]
    public class GreaterThanZeroAttribute : ValidationAttribute, IClientValidatable
    {
        private const string defaultErrorMessage = "{0} not greater than zero!";

        public GreaterThanZeroAttribute()
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
            return (decimal.Parse(value.ToString()) > 0);
        }

        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            var rule = new ModelClientValidationRule()
            {
                ValidationType = "greaterthanzero",
                ErrorMessage = FormatErrorMessage(metadata.GetDisplayName())
            };

            yield return rule;
        }
    }
}