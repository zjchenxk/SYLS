using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class CustomerTransportChargesSettlementDetailViewModel
    {
        /// <summary>
        /// 结算记录编码
        /// </summary>
        [Display(Name = "CustomerTransportChargesSettlementId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long CustomerTransportChargesSettlementId { get; set; }

        /// <summary>
        /// 送货单编码
        /// </summary>
        [Display(Name = "DeliverBillId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long DeliverBillId { get; set; }

        /// <summary>
        /// 单价
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "TransportPriceNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "TransportPrice", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TransportPrice { get; set; }

        /// <summary>
        /// 运费
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[-+]?[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "TransportCharges", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TransportCharges { get; set; }

        /// <summary>
        /// 拼车费
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "CarpoolFeeNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "CarpoolFee", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal CarpoolFee { get; set; }

        /// <summary>
        /// 过江费
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "RiverCrossingChargesNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "RiverCrossingCharges", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal RiverCrossingCharges { get; set; }

    }
}