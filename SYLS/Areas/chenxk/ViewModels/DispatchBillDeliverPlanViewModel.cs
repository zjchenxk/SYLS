using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class DispatchBillDeliverPlanViewModel
    {
        /// <summary>
        /// 计划编码
        /// </summary>
        [Display(Name = "PlanId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long PlanId { get; set; }

        /// <summary>
        /// 件数
        /// </summary>
        [RegularExpression(@"^[-+]?\d+$", ErrorMessageResourceName = "NotValidInteger", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "Pieces", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public int Packages { get; set; }

        /// <summary>
        /// 吨数
        /// </summary>
        [RegularExpression(@"^[-+]?\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "Tunnages", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal Tunnages { get; set; }

        /// <summary>
        /// 垛数
        /// </summary>
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "PilesNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "Piles", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal Piles { get; set; }

        /// <summary>
        /// 万只
        /// </summary>
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "TenThousandsNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "TenThousands", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TenThousands { get; set; }

        /// <summary>
        /// 运费公式
        /// </summary>
        [StringLength(100)]
        [Display(Name = "TransportChargeExpression", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string TransportChargeExpression { get; set; }

        /// <summary>
        /// 单价公式
        /// </summary>
        [StringLength(100)]
        [Display(Name = "TransportPriceExpression", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string TransportPriceExpression { get; set; }

        /// <summary>
        /// 公里数
        /// </summary>
        [RegularExpression(@"^\d+$", ErrorMessageResourceName = "NotValidInteger", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "KMNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "KM", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public int KM { get; set; }

        /// <summary>
        /// 协议价格
        /// </summary>
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "AgreementTransportPriceNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "AgreementTransportPrice", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal AgreementTransportPrice { get; set; }

        /// <summary>
        /// 实际价格
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "ActualTransportPriceNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ActualTransportPrice", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal ActualTransportPrice { get; set; }

        /// <summary>
        /// 运费
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[-+]?[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "TransportCharges", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TransportCharges { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(500)]
        [Display(Name = "Remark", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Remark { get; set; }

        /// <summary>
        /// 提货方式
        /// </summary>
        [Display(Name = "ReceiveType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ReceiveType { get; set; }
    }
}