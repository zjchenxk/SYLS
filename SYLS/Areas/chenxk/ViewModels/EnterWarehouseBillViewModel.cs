using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class EnterWarehouseBillViewModel
    {
        /// <summary>
        /// 入库单编码
        /// </summary>
        [Display(Name = "EnterWarehouseBillId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 入库单号
        /// </summary>
        [Display(Name = "EnterWarehouseBillNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string BillNo { get; set; }

        /// <summary>
        /// 计划编码
        /// </summary>
        [Display(Name = "PlanId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long PlanId { get; set; }

        /// <summary>
        /// 客户编码
        /// </summary>
        [Display(Name = "CustomerId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long CustomerId { get; set; }

        /// <summary>
        /// 客户名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "CustomerName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CustomerName { get; set; }

        /// <summary>
        /// 交货单号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "DeliveryNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DeliveryNo { get; set; }

        /// <summary>
        /// 入库类别
        /// </summary>
        [Required]
        [Display(Name = "EnterType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string EnterType { get; set; }

        /// <summary>
        /// 是否寄库标志
        /// </summary>
        [Required]
        [Display(Name = "IsConsigning", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public bool IsConsigning { get; set; }

        /// <summary>
        /// 仓库
        /// </summary>
        [Required]
        [Display(Name = "Warehouse", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Warehouse { get; set; }

        /// <summary>
        /// 下力资费价格
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanZero(ErrorMessageResourceName = "UnloadingForceFeePriceNotGreaterThanZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "UnloadingForceFeePrice", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal UnloadingForceFeePrice { get; set; }

        /// <summary>
        /// 力支费
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "ForceFeeNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ForceFee", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal ForceFee { get; set; }

        /// <summary>
        /// 仓储费价格
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanZero(ErrorMessageResourceName = "StorageFeePriceNotGreaterThanZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "StorageFeePrice", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal StorageFeePrice { get; set; }

        /// <summary>
        /// 是否有短驳费标志
        /// </summary>
        [Required]
        [Display(Name = "HasDrayage", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public bool HasDrayage { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(200)]
        [Display(Name = "Remark", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Remark { get; set; }

        /// <summary>
        /// 录入时间
        /// </summary>
        [Required]
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "CreateTime", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CreateTime { get; set; }

        /// <summary>
        /// 货物集合
        /// </summary>
        public List<EnterWarehouseBillGoodsViewModel> Goods { get; set; }

    }
}