using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class CarrierTransportChargesSettlementDetailViewModel
    {
        /// <summary>
        /// 结算记录编码
        /// </summary>
        [Display(Name = "CarrierTransportChargesSettlementId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long CarrierTransportChargesSettlementId { get; set; }

        /// <summary>
        /// 送货单编码
        /// </summary>
        [Display(Name = "DeliverBillId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long DeliverBillId { get; set; }

        /// <summary>
        /// 运费
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[-+]?[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "TransportCharges", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TransportCharges { get; set; }
    }
}