using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class SearchGoodsConditionViewModel
    {
        /// <summary>
        /// 货物名称
        /// </summary>
        [StringLength(50)]
        [Display(Name = "GoodsName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string GoodsName { get; set; }

        /// <summary>
        /// 货物编号
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "GoodsNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string GoodsNo { get; set; }

        /// <summary>
        /// 规格型号
        /// </summary>
        [Required]
        [StringLength(100)]
        [Display(Name = "Specification", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string SpecModel { get; set; }

        /// <summary>
        /// 克重
        /// </summary>
        [StringLength(20)]
        [Display(Name = "GrammeWeight", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string GWeight { get; set; }

        /// <summary>
        /// 等级
        /// </summary>
        [StringLength(10)]
        [Display(Name = "Grade", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Grade { get; set; }

        /// <summary>
        /// 包装
        /// </summary>
        [StringLength(10)]
        [Display(Name = "PackingSpecification", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Packing { get; set; }
    }
}