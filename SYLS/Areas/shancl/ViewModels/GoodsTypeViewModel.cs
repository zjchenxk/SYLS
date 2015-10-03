using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.shancl.ViewModels
{
    public class GoodsTypeViewModel
    {
        /// <summary>
        /// 货物类别编码
        /// </summary>
        [Display(Name = "Id", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 上级货物类别
        /// </summary>
        [Display(Name = "ParentTypeName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long ParentId { get; set; }

        /// <summary>
        /// 货物类别名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "Name", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Name { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(100)]
        [Display(Name = "Remark", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Remark { get; set; }
    }
}