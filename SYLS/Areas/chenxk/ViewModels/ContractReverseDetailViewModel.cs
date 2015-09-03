using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class ContractReverseDetailViewModel
    {
        /// <summary>
        /// 记录编码
        /// </summary>
        [Display(Name = "Id", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 冲帐记录编码
        /// </summary>
        [Display(Name = "ReverseId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long ReverseId { get; set; }

        /// <summary>
        /// 合同编码
        /// </summary>
        [Display(Name = "ContractId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long ContractId { get; set; }

        /// <summary>
        /// 冲帐金额
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[-+]?[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [NotEqualZero(ErrorMessageResourceName = "ReverseAmountCanNotEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ReverseAmount", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal ReverseAmount { get; set; }

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

    }
}