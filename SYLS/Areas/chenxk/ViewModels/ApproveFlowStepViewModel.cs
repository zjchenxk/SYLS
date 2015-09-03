using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class ApproveFlowStepViewModel
    {
        /// <summary>
        /// 记录编码
        /// </summary>
        [Display(Name = "StepId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 步骤序号
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+$", ErrorMessageResourceName = "NotValidInteger", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanZero(ErrorMessageResourceName = "StepNumNotGreaterThanZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "StepNum", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public int StepNum { get; set; }

        /// <summary>
        /// 步骤名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "StepName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string StepName { get; set; }

        /// <summary>
        /// 处理人编码
        /// </summary>
        [Required]
        [Display(Name = "DisposerName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long DisposerId { get; set; }

        /// <summary>
        /// 条件组合表达式
        /// </summary>
        [StringLength(100)]
        [Display(Name = "ConditionExpression", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ConditionExpression { get; set; }

        /// <summary>
        /// 条件集合
        /// </summary>
        public List<ApproveFlowStepConditionViewModel> Conditions { get; set; }
    }
}