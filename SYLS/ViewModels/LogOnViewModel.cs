using System.ComponentModel.DataAnnotations;

namespace SYLS.ViewModels
{
    public class LogOnViewModel
    {
        /// <summary>
        /// 帐号
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "AccountName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string LoginAccount { get; set; }

        /// <summary>
        /// 密码
        /// </summary>
        [Required]
        [StringLength(16)]
        [DataType(DataType.Password)]
        [Display(Name = "AccountPassword", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Password { get; set; }

        /// <summary>
        /// 验证码
        /// </summary>
        [Required]
        [StringLength(4)]
        [Display(Name = "IndentifyCode", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string IndentifyCode { get; set; }
    }
}