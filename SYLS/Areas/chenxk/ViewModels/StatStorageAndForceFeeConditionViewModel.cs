using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class StatStorageAndForceFeeConditionViewModel
    {
        /// <summary>
        /// 起始时间
        /// </summary>
        [Required]
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "StartTime", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string StartTime { get; set; }

        /// <summary>
        /// 截止时间
        /// </summary>
        [Required]
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "EndTime", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string EndTime { get; set; }

        /// <summary>
        /// 客户名称
        /// </summary>
        [StringLength(50)]
        [Display(Name = "CustomerName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CustomerName { get; set; }

        /// <summary>
        /// 仓库
        /// </summary>
        [Display(Name = "Warehouse", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Warehouse { get; set; }

        /// <summary>
        /// 是否寄库
        /// </summary>
        [Display(Name = "IsConsigning", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public bool IsConsigning { get; set; }
    }
}