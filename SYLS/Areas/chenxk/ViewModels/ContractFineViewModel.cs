using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class ContractFineViewModel
    {
        /// <summary>
        /// 合同编码
        /// </summary>
        [Display(Name = "ContractId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long ContractId { get; set; }

        /// <summary>
        /// 罚款金额
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanZero(ErrorMessageResourceName = "FineAmountNotGreaterThanZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "FineAmount", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal FineAmount { get; set; }

    }
}