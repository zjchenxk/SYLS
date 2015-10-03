using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class SyntheticalSearchModifyViewModel
    {
        /// <summary>
        /// 计划编码
        /// </summary>
        [Display(Name = "PlanId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long PlanId { get; set; }

        /// <summary>
        /// 装运单号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "ShipmentNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ShipmentNo { get; set; }

        /// <summary>
        /// 交货单号
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "DeliveryNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DeliveryNo { get; set; }

        /// <summary>
        /// 结算付款单位编码
        /// </summary>
        [Display(Name = "PayerId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long PayerId { get; set; }

        /// <summary>
        /// 结算付款单位名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "PayerName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string PayerName { get; set; }

        /// <summary>
        /// 合同编码
        /// </summary>
        [Display(Name = "ContractId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long ContractId { get; set; }

        /// <summary>
        /// 原始合同号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "OriginalContractNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string OriginalContractNo { get; set; }

    }
}