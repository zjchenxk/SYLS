using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using InnoSoft.LS.Models;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class CarrierSettlementExpressionViewModel
    {
        /// <summary>
        /// 承运单位编码
        /// </summary>
        [Display(Name = "CarrierId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long CarrierId { get; set; }

        /// <summary>
        /// 计划类别
        /// </summary>
        [Required]
        [Display(Name = "PlanType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string PlanType { get; set; }

        /// <summary>
        /// 运费公式
        /// </summary>
        [Required]
        [StringLength(100)]
        [Display(Name = "TransportChargeExpression", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string TransportChargeExpression { get; set; }

        /// <summary>
        /// 单价公式
        /// </summary>
        [Required]
        [StringLength(100)]
        [Display(Name = "TransportPriceExpression", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string TransportPriceExpression { get; set; }
    }
}