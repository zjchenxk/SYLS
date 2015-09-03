using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class CanPlanViewModel
    {
        /// <summary>
        /// 计划编码
        /// </summary>
        [Display(Name = "PlanId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

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
        /// 驾驶员姓名
        /// </summary>
        [StringLength(20)]
        [Display(Name = "DriverName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DriverName { get; set; }

        /// <summary>
        /// 驾驶证号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "LicenseNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DriverLicenseNo { get; set; }

        /// <summary>
        /// 驾驶员手机
        /// </summary>
        [StringLength(20)]
        [DataType(DataType.PhoneNumber)]
        [RegularExpression(@"^(13[0-9]|14[7]|15[0-9]|18[0-9])\d{8}$", ErrorMessageResourceName = "NotValidMobileTel", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "MobileTel", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DriverMobileTel { get; set; }

        /// <summary>
        /// 驾驶员住宅电话
        /// </summary>
        [StringLength(20)]
        [DataType(DataType.PhoneNumber)]
        [RegularExpression(@"0\d{2,3}-\d{5,9}|0\d{2,3}-\d{5,9}", ErrorMessageResourceName = "NotValidTel", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "HomeTel", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DriverHomeTel { get; set; }

        /// <summary>
        /// 发货仓库
        /// </summary>
        [StringLength(20)]
        [Display(Name = "Warehouse", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Warehouse { get; set; }

        /// <summary>
        /// 到货时间
        /// </summary>
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ArrivalTime", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ArrivalTime { get; set; }

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
        /// 起点国家
        /// </summary>
        [Required]
        [Display(Name = "StartCountry", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string StartCountry { get; set; }

        /// <summary>
        /// 起点省份
        /// </summary>
        [Required]
        [Display(Name = "StartProvince", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string StartProvince { get; set; }

        /// <summary>
        /// 起点城市
        /// </summary>
        [Required]
        [Display(Name = "StartCity", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string StartCity { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(500)]
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
        public List<CanPlanGoodsViewModel> Goods { get; set; }
    }
}