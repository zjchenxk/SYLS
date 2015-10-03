using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class PriceApproveFlowStepConditionViewModel
    {
        /// <summary>
        /// 条件编码
        /// </summary>
        [Display(Name = "ConditionId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 条件序号
        /// </summary>
        [Display(Name = "ConditionNum", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public int ConditionNum { get; set; }

        /// <summary>
        /// 字段名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "FieldName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string FieldName { get; set; }

        /// <summary>
        /// 比较运算符
        /// </summary>
        [Required]
        [Display(Name = "CompareOperator", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CompareOperator { get; set; }

        /// <summary>
        /// 字段值
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "FieldValueNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "FieldValue", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string FieldValue { get; set; }
    }
}