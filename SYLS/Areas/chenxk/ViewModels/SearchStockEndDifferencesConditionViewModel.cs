using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class SearchStockEndDifferencesConditionViewModel
    {
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