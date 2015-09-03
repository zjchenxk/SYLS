using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class SearchCarrierConditionViewModel
    {
        /// <summary>
        /// 承运单位名称
        /// </summary>
        [StringLength(50)]
        [Display(Name = "CarrierName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CarrierName { get; set; }

        /// <summary>
        /// 承运车号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "CarNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CarNo { get; set; }
    }
}