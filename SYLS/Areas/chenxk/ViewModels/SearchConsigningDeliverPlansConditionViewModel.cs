using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class SearchConsigningDeliverPlansConditionViewModel
    {
        /// <summary>
        /// 交货单号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "DeliveryNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DeliveryNo { get; set; }
    }
}