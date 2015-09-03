using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using InnoSoft.LS.Models;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class CarrierViewModel
    {
        /// <summary>
        /// 承运单位编码
        /// </summary>
        [Display(Name = "CarrierId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 承运单位名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "CarrierName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Name { get; set; }

        /// <summary>
        /// 经营性质
        /// </summary>
        [Required]
        [Display(Name = "BusinessType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string BusinessType { get; set; }

        /// <summary>
        /// 结算方式
        /// </summary>
        [Required]
        [Display(Name = "PaymentType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string PaymentType { get; set; }

        /// <summary>
        /// 车辆集合
        /// </summary>
        public List<CarrierCarViewModel> Cars { get; set; }

        /// <summary>
        /// 驾驶员集合
        /// </summary>
        public List<CarrierDriverViewModel> Drivers { get; set; }

        /// <summary>
        /// 结算公式集合
        /// </summary>
        public List<CarrierSettlementExpressionViewModel> SettlementExpressions { get; set; }

        /// <summary>
        /// 运费价格集合
        /// </summary>
        public List<CarrierTransportPriceViewModel> TransportPrices { get; set; }
    }
}