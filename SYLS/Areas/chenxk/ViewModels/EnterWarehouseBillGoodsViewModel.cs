using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class EnterWarehouseBillGoodsViewModel
    {
        /// <summary>
        /// 记录编码
        /// </summary>
        [Display(Name = "Id", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 入库单编码
        /// </summary>
        [Display(Name = "EnterWarehouseBillId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long EnterWarehouseBillId { get; set; }

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
        /// 品牌
        /// </summary>
        [StringLength(20)]
        [Display(Name = "Brand", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Brand { get; set; }

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
        /// 件重
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "PieceWeightNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "PieceWeight", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal PieceWeight { get; set; }

        /// <summary>
        /// 包装
        /// </summary>
        [StringLength(10)]
        [Display(Name = "PackingSpecification", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Packing { get; set; }

        /// <summary>
        /// 批次编号
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "BatchNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string BatchNo { get; set; }

        /// <summary>
        /// 货位
        /// </summary>
        [Required]
        [StringLength(10)]
        [Display(Name = "Location", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Location { get; set; }

        /// <summary>
        /// 件数
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+$", ErrorMessageResourceName = "NotValidInteger", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "PackagesNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "Pieces", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public int Packages { get; set; }

        /// <summary>
        /// 吨数
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "TunnagesNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "Tunnages", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal Tunnages { get; set; }

        /// <summary>
        /// 垛数
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "PilesNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "Piles", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal Piles { get; set; }

        /// <summary>
        /// 万只
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "TenThousandsNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "TenThousands", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TenThousands { get; set; }

        /// <summary>
        /// 生产日期
        /// </summary>
        [Required]
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ProductionDate", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ProductionDate { get; set; }

        /// <summary>
        /// 对应划拨出仓单编码
        /// </summary>
        [Display(Name = "ShipmentBillGoodsIds", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ShipmentBillGoodsIds { get; set; }
    }
}