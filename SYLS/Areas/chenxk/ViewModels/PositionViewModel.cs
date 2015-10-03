using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class PositionViewModel
    {
        /// <summary>
        /// 岗位编码
        /// </summary>
        [Display(Name = "PositionId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 岗位名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "PositionName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Name { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(100)]
        [Display(Name = "Remark", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Remark { get; set; }
    }
}