using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class OrganizationViewModel
    {
        /// <summary>
        /// 组织部门编码
        /// </summary>
        [Display(Name = "OrganId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 组织部门名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "OrganName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Name { get; set; }

        /// <summary>
        /// 上级组织部门编码
        /// </summary>
        [Display(Name = "ParentOrgan", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long ParentId { get; set; }

        /// <summary>
        /// 所在国家
        /// </summary>
        [Required]
        [Display(Name = "CountryName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CountryName { get; set; }

        /// <summary>
        /// 所在省份
        /// </summary>
        [Required]
        [Display(Name = "StateName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string StateName { get; set; }

        /// <summary>
        /// 所在城市
        /// </summary>
        [Required]
        [Display(Name = "CityName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CityName { get; set; }

        /// <summary>
        /// 街道地址
        /// </summary>
        [StringLength(50)]
        [Display(Name = "Address", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Address { get; set; }

        /// <summary>
        /// 邮编
        /// </summary>
        [StringLength(6)]
        [RegularExpression(@"[1-9]\d{5}(?!\d)", ErrorMessageResourceName = "NotValidPostalCode", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "PostalCode", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string PostalCode { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(100)]
        [Display(Name = "Remark", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Remark { get; set; }
    }
}