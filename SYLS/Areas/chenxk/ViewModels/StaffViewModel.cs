using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace SYLS.Areas.chenxk.ViewModels
{
    [Bind(Exclude = "OrganName,OrganFullName,PositionName,BossStaffName")]
    public class StaffViewModel
    {
        /// <summary>
        /// 员工编码
        /// </summary>
        [Display(Name = "StaffId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 姓氏
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "LastName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string FamilyName { get; set; }

        /// <summary>
        /// 名子
        /// </summary>
        [StringLength(20)]
        [Display(Name = "FirstName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Name { get; set; }

        /// <summary>
        /// 性别
        /// </summary>
        [Required]
        [StringLength(1)]
        [Display(Name = "Sex", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Sex { get; set; }

        /// <summary>
        /// 所在组织部门编码
        /// </summary>
        [Required]
        [Display(Name = "OrganName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long OrganId { get; set; }

        /// <summary>
        /// 所在组织部门名称
        /// </summary>
        public string OrganName { get; set; }

        /// <summary>
        /// 所在组织部门全名称
        /// </summary>
        public string OrganFullName { get; set; }

        /// <summary>
        /// 工作岗位编码
        /// </summary>
        [Required]
        [Display(Name = "PositionName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long PositionId { get; set; }

        /// <summary>
        /// 工作岗位名称
        /// </summary>
        public string PositionName { get; set; }

        /// <summary>
        /// 办公电话
        /// </summary>
        [StringLength(20)]
        [DataType(DataType.PhoneNumber)]
        [RegularExpression(@"0\d{2,3}-\d{5,9}|0\d{2,3}-\d{5,9}", ErrorMessageResourceName = "NotValidTel", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "Tel", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string OfficeTel { get; set; }

        /// <summary>
        /// 分机
        /// </summary>
        [StringLength(4)]
        [RegularExpression(@"^\d{4}$", ErrorMessageResourceName = "NotValidTelExt", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "TelExt", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string TelExt { get; set; }

        /// <summary>
        /// 传真
        /// </summary>
        [StringLength(20)]
        [DataType(DataType.PhoneNumber)]
        [RegularExpression(@"0\d{2,3}-\d{5,9}|0\d{2,3}-\d{5,9}", ErrorMessageResourceName = "NotValidTel", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "Fax", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Fax { get; set; }

        /// <summary>
        /// 手机1
        /// </summary>
        [Required]
        [StringLength(20)]
        [DataType(DataType.PhoneNumber)]
        [RegularExpression(@"^(13[0-9]|14[7]|15[0-9]|18[0-9])\d{8}$", ErrorMessageResourceName = "NotValidMobileTel", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "MobileTel", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string MobileTel1 { get; set; }

        /// <summary>
        /// 手机2
        /// </summary>
        [StringLength(20)]
        [DataType(DataType.PhoneNumber)]
        [RegularExpression(@"^(13[0-9]|14[7]|15[0-9]|18[0-9])\d{8}$", ErrorMessageResourceName = "NotValidMobileTel", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "MobileTel", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string MobileTel2 { get; set; }

        /// <summary>
        /// 手机3
        /// </summary>
        [StringLength(20)]
        [DataType(DataType.PhoneNumber)]
        [RegularExpression(@"^(13[0-9]|14[7]|15[0-9]|18[0-9])\d{8}$", ErrorMessageResourceName = "NotValidMobileTel", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "MobileTel", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string MobileTel3 { get; set; }

        /// <summary>
        /// 电子邮件
        /// </summary>
        [StringLength(255)]
        [DataType(DataType.EmailAddress)]
        [RegularExpression(@"^(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*$", ErrorMessageResourceName = "NotValidEmail", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "EMail", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string EMail { get; set; }

        /// <summary>
        /// QQ
        /// </summary>
        [StringLength(20)]
        [RegularExpression(@"[1-9][0-9]{4,}", ErrorMessageResourceName = "NotValidQQ", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "QQ", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string QQ { get; set; }

        /// <summary>
        /// 上司编码
        /// </summary>
        [Required]
        [Display(Name = "BossName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long BossStaffId { get; set; }

        /// <summary>
        /// 上司姓名
        /// </summary>
        public string BossStaffName { get; set; }

        /// <summary>
        /// 是否为组织部门管理人员标志
        /// </summary>
        [Required]
        [Display(Name = "IsOrganManager", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public bool IsOrganManager { get; set; }

        /// <summary>
        /// 是否为组织部门负责人标志
        /// </summary>
        [Required]
        [Display(Name = "IsOrganLeader", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public bool IsOrganLeader { get; set; }
    }
}