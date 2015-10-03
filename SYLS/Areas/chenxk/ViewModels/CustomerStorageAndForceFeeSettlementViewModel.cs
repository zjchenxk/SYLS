using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class CustomerStorageAndForceFeeSettlementViewModel
    {
        /// <summary>
        /// 起始时间
        /// </summary>
        [Required]
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "StartTime", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string StartTime { get; set; }

        /// <summary>
        /// 截止时间
        /// </summary>
        [Required]
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "EndTime", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string EndTime { get; set; }

        /// <summary>
        /// 发票号码
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "InvoiceNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string InvoiceNo { get; set; }

        /// <summary>
        /// 客户编码
        /// </summary>
        [Display(Name = "CustomerId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long CustomerId { get; set; }

        /// <summary>
        /// 客户名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "CustomerName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CustomerName { get; set; }

        /// <summary>
        /// 发票类别
        /// </summary>
        [Required]
        [StringLength(10)]
        [Display(Name = "InvoiceType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string InvoiceType { get; set; }

        /// <summary>
        /// 发票金额
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanZero(ErrorMessageResourceName = "InvoiceAmountNotGreaterThanZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "InvoiceAmount", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal InvoiceAmount { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(100)]
        [Display(Name = "Remark", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Remark { get; set; }
    }
}