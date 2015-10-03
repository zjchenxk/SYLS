using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class CarrierTransportChargesSettlementViewModel
    {
        /// <summary>
        /// 承运单位编码
        /// </summary>
        [Display(Name = "CarrierId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long CarrierId { get; set; }

        /// <summary>
        /// 承运单位名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "CarrierName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CarrierName { get; set; }

        /// <summary>
        /// 结算金额
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[-+]?[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "SettlementAmount", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal SettlementAmount { get; set; }

        /// <summary>
        /// 扣款金额
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "WithholdAmountNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "WithholdAmount", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal WithholdAmount { get; set; }

        /// <summary>
        /// 实付金额
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[-+]?[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "FactpaymentAmount", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal FactpaymentAmount { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(100)]
        [Display(Name = "Remark", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Remark { get; set; }

        /// <summary>
        /// 结算明细集合
        /// </summary>
        public List<CarrierTransportChargesSettlementDetailViewModel> Details { get; set; }
    }
}