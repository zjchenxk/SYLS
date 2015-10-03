using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class PrintStocktakingConditionViewModel
    {
        /// <summary>
        /// 仓库
        /// </summary>
        [Display(Name = "Warehouse", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Warehouse { get; set; }

        /// <summary>
        /// 货位
        /// </summary>
        [StringLength(10)]
        [Display(Name = "Location", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Location { get; set; }
    }
}