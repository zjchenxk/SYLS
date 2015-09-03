using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class DispatchBillViewModel
    {
        /// <summary>
        /// 调度单编码
        /// </summary>
        [Display(Name = "DispatchBillId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 车号
        /// </summary>
        [Required]
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
        /// 车型
        /// </summary>
        [StringLength(10)]
        [Display(Name = "CarType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CarType { get; set; }

        /// <summary>
        /// 驾驶员姓名
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "DriverName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DriverName { get; set; }

        /// <summary>
        /// 驾驶证号
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "LicenseNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DriverLicenseNo { get; set; }

        /// <summary>
        /// 驾驶员手机
        /// </summary>
        [Required]
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
        /// 承运单位编码
        /// </summary>
        [Display(Name = "CarrierId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long CarrierId { get; set; }

        /// <summary>
        /// 承运单位名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "CarrierName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CarrierName { get; set; }

        /// <summary>
        /// 载重
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+$", ErrorMessageResourceName = "NotValidInteger", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanZero(ErrorMessageResourceName = "CarryingCapacityNotGreaterThanZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "CarryingCapacity", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public int CarryingCapacity { get; set; }

        /// <summary>
        /// 经营性质
        /// </summary>
        [Required]
        [Display(Name = "BusinessType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string BusinessType { get; set; }

        /// <summary>
        /// 结算方式
        /// </summary>
        [Required]
        [Display(Name = "PaymentType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string PaymentType { get; set; }

        /// <summary>
        /// 录入时间
        /// </summary>
        [Required]
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "CreateTime", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CreateTime { get; set; }

        /// <summary>
        /// 发货计划集合
        /// </summary>
        public List<DispatchBillDeliverPlanViewModel> DeliverPlans { get; set; }

        /// <summary>
        /// 货物集合
        /// </summary>
        public List<DispatchBillGoodsViewModel> Goods { get; set; }

    }
}