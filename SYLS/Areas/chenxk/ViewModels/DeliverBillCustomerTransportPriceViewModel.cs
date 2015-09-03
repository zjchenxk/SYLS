using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class DeliverBillCustomerTransportPriceViewModel
    {
        /// <summary>
        /// 送货单编码
        /// </summary>
        [Required]
        [Display(Name = "DeliverBillId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long DeliverBillId { get; set; }

        /// <summary>
        /// 送货单号
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "DeliverBillNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DeliverBillNo { get; set; }

        /// <summary>
        /// 实际结算单价
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "ActualTransportPriceNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ActualTransportPrice", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal ActualTransportPrice { get; set; }

        /// <summary>
        /// 实际结算运费
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[-+]?[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ActualTransportCharges", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal ActualTransportCharges { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(100)]
        [Display(Name = "Remark", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Remark { get; set; }

    }
}