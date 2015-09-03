using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class ModifyPasswordViewModel
    {
        /// <summary>
        /// 原密码
        /// </summary>
        [Required]
        [StringLength(18)]
        [DataType(DataType.Password)]
        [Display(Name = "OldPassword", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string OldPassword { get; set; }

        /// <summary>
        /// 新密码
        /// </summary>
        [Required]
        [StringLength(18)]
        [DataType(DataType.Password)]
        [RegularExpression(@"^[a-zA-Z]\w{5,17}$", ErrorMessageResourceName = "NotValidPassword", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "NewPassword", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string NewPassword { get; set; }

        /// <summary>
        /// 确认密码
        /// </summary>
        [Required]
        [StringLength(18)]
        [DataType(DataType.Password)]
        [RegularExpression(@"^[a-zA-Z]\w{5,17}$", ErrorMessageResourceName = "NotValidPassword", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Compare("NewPassword", ErrorMessageResourceName = "PasswordConfirmNotMatch", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ConfirmPassword", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ConfirmPassword { get; set; }
    }
}