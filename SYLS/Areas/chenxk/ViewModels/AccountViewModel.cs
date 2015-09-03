using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class AccountViewModel
    {
        /// <summary>
        /// 帐号编码
        /// </summary>
        [Display(Name = "AccountId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 帐号名称
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "AccountName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Name { get; set; }

        /// <summary>
        /// 帐号密码（不接受输入，只用于数据缓存）
        /// </summary>
        [Display(Name = "AccountPassword", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Password { get; set; }

        /// <summary>
        /// 帐号类别
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "AccountType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string AccountType { get; set; }

        /// <summary>
        /// 所属组织部门的名称
        /// </summary>
        [Display(Name = "OrganName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long OrganId { get; set; }

        /// <summary>
        /// 所属员工的姓名
        /// </summary>
        [Display(Name = "StaffName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long StaffId { get; set; }

        /// <summary>
        /// 所属客户的名称
        /// </summary>
        [Display(Name = "CustomerName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long CustomerId { get; set; }

        /// <summary>
        /// 客户联络人的姓名
        /// </summary>
        [StringLength(50)]
        [Display(Name = "ContactName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ContactName { get; set; }

        /// <summary>
        /// 是否注销标志
        /// </summary>
        [Display(Name = "IsCancel", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public bool IsCancel { get; set; }
    }
}