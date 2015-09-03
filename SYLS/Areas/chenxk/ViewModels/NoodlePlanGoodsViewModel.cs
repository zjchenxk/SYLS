using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class NoodlePlanGoodsViewModel
    {
        /// <summary>
        /// 货物编码
        /// </summary>
        [Display(Name = "GoodsId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long GoodsId { get; set; }

        /// <summary>
        /// 货物编号
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "GoodsNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string GoodsNo { get; set; }

        /// <summary>
        /// 货物名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "GoodsName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string GoodsName { get; set; }

        /// <summary>
        /// 规格型号
        /// </summary>
        [Required]
        [StringLength(100)]
        [Display(Name = "Specification", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string SpecModel { get; set; }

        /// <summary>
        /// 箱数
        /// </summary>
        [Required]
        [RegularExpression(@"^[-+]?\d+$", ErrorMessageResourceName = "NotValidInteger", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [NotEqualZero(ErrorMessageResourceName = "BoxesCanNotEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "Boxes", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public int Packages { get; set; }

        /// <summary>
        /// 折算系数
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "ConvertCoefficientNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ConvertCoefficient", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal PieceWeight { get; set; }

        /// <summary>
        /// 吨数
        /// </summary>
        [Required]
        [RegularExpression(@"^[-+]?\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [NotEqualZero(ErrorMessageResourceName = "TunnagesCanNotEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "Tunnages", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal Tunnages { get; set; }

    }
}