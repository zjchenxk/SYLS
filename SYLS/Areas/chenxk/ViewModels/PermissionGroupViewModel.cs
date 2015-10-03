using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using InnoSoft.LS.Models;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class PermissionGroupViewModel
    {
        /// <summary>
        /// 组编码
        /// </summary>
        [Display(Name = "GroupId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 组名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "GroupName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Name { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(100)]
        [Display(Name = "Remark", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Remark { get; set; }

        /// <summary>
        /// 功能权限集合
        /// </summary>
        public List<SysFunction> Functions { get; set; }
    }
}