using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class ContractReverseViewModel
    {
        /// <summary>
        /// 冲帐记录编码
        /// </summary>
        [Display(Name = "Id", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

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

        /// <summary>
        /// 冲帐人编码
        /// </summary>
        [Display(Name = "ReverserId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long CreatorId { get; set; }

        /// <summary>
        /// 冲帐人姓名
        /// </summary>
        [Required]
        [Display(Name = "ReverserName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CreatorName { get; set; }

        /// <summary>
        /// 明细记录集合
        /// </summary>
        public List<ContractReverseDetailViewModel> Details { get; set; }
    }
}