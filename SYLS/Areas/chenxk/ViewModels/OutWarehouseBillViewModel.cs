using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using SYLS.Helper;
using System;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class OutWarehouseBillViewModel
    {
        /// <summary>
        /// 记录编码
        /// </summary>
        [Display(Name = "OutWarehouseBillId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 出库单号
        /// </summary>
        [Display(Name = "OutWarehouseBillNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
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
        /// 出库类别
        /// </summary>
        [Required]
        [Display(Name = "DeliverType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string OutType { get; set; }

        /// <summary>
        /// 提货单位名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "ReceiverName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ReceiverName { get; set; }

        /// <summary>
        /// 提货单位所在国家
        /// </summary>
        [Required]
        [Display(Name = "ReceiverCountry", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ReceiverCountry { get; set; }

        /// <summary>
        /// 提货单位所在省份
        /// </summary>
        [Required]
        [Display(Name = "ReceiverProvince", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ReceiverProvince { get; set; }

        /// <summary>
        /// 收货单位所在城市
        /// </summary>
        [Required]
        [Display(Name = "ReceiverCity", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ReceiverCity { get; set; }

        /// <summary>
        /// 收货单位地址
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "ReceiverAddress", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ReceiverAddress { get; set; }

        /// <summary>
        /// 收货单位联系人姓名
        /// </summary>
        [StringLength(20)]
        [Display(Name = "ReceiverContact", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ReceiverContact { get; set; }

        /// <summary>
        /// 收货单位联系人电话
        /// </summary>
        [StringLength(20)]
        [Display(Name = "ReceiverContactTel", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ReceiverContactTel { get; set; }

        /// <summary>
        /// 提货方式
        /// </summary>
        [Required]
        [Display(Name = "ReceiveType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ReceiveType { get; set; }

        /// <summary>
        /// 车号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "CarNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CarNo { get; set; }

        /// <summary>
        /// 挂车号
        /// </summary>
        [StringLength(10)]
        [Display(Name = "TrailerNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string TrailerNo { get; set; }

        /// <summary>
        /// 承运单位编码
        /// </summary>
        [Display(Name = "CarrierId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long CarrierId { get; set; }

        /// <summary>
        /// 承运单位名称
        /// </summary>
        [StringLength(50)]
        [Display(Name = "CarrierName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CarrierName { get; set; }

        /// <summary>
        /// 结算付款单位编码
        /// </summary>
        [Display(Name = "PayerId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long PayerId { get; set; }

        /// <summary>
        /// 结算付款单位名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "PayerName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string PayerName { get; set; }

        /// <summary>
        /// 是否寄库
        /// </summary>
        [Required]
        [Display(Name = "IsConsigning", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public bool IsConsigning { get; set; }

        /// <summary>
        /// 寄库交货单号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "ConsignedDeliveryNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ConsignedDeliveryNo { get; set; }

        /// <summary>
        /// 发货仓库
        /// </summary>
        [Required]
        [Display(Name = "Warehouse", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Warehouse { get; set; }

        /// <summary>
        /// 上力支费价格
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanZero(ErrorMessageResourceName = "LoadingForceFeePriceNotGreaterThanZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "LoadingForceFeePrice", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal LoadingForceFeePrice { get; set; }

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
        public List<OutWarehouseBillGoodsViewModel> Goods { get; set; }
    }
}