﻿using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class CanPlanGoodsViewModel
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
        /// 批次编号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "BatchNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string BatchNo { get; set; }

        /// <summary>
        /// 发货仓库
        /// </summary>
        [StringLength(20)]
        [Display(Name = "Warehouse", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Warehouse { get; set; }

        /// <summary>
        /// 货位
        /// </summary>
        [StringLength(10)]
        [Display(Name = "Location", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Location { get; set; }

        /// <summary>
        /// 垛数
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanZero(ErrorMessageResourceName = "PilesNotGreaterThanZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "Piles", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal Piles { get; set; }

        /// <summary>
        /// 万只
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanZero(ErrorMessageResourceName = "TenThousandsNotGreaterThanZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "TenThousands", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TenThousands { get; set; }

        /// <summary>
        /// 生产日期
        /// </summary>
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ProductionDate", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ProductionDate { get; set; }

        /// <summary>
        /// 入库单编码
        /// </summary>
        [Display(Name = "EnterWarehouseBillId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long EnterWarehouseBillId { get; set; }

        /// <summary>
        /// 入库单号
        /// </summary>
        [Display(Name = "EnterWarehouseBillNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string EnterWarehouseBillNo { get; set; }
    }
}