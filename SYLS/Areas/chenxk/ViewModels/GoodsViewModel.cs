using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class GoodsViewModel
    {
        /// <summary>
        /// 货物编码
        /// </summary>
        [Display(Name = "Id", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 货物名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "GoodsName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Name { get; set; }

        /// <summary>
        /// 类别编码
        /// </summary>
        [Required]
        [Display(Name = "TypeName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long TypeId { get; set; }

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
        /// 品牌
        /// </summary>
        [StringLength(20)]
        [Display(Name = "Brand", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Brand { get; set; }

        /// <summary>
        /// 件重/折算系数
        /// </summary>
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "PieceWeightOrConvertCoefficient", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string PieceWeight { get; set; }

        /// <summary>
        /// 包装
        /// </summary>
        [StringLength(10)]
        [Display(Name = "PackingSpecification", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Packing { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(100)]
        [Display(Name = "Remark", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Remark { get; set; }
    }
}