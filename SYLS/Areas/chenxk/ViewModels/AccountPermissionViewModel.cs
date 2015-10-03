using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using InnoSoft.LS.Models;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class AccountPermissionViewModel
    {
        /// <summary>
        /// 帐号编码
        /// </summary>
        [Display(Name = "AccountId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long AccountId { get; set; }

        /// <summary>
        /// 权限组集合
        /// </summary>
        public List<SysGroup> Groups { get; set; }
    }
}