using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class ContractViewModel
    {
        /// <summary>
        /// 合同编码
        /// </summary>
        [Display(Name = "ContractId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 调度单编码
        /// </summary>
        [Display(Name = "DispatchBillId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long DispatchBillId { get; set; }

        /// <summary>
        /// 合同编号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "ContractNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ContractNo { get; set; }

        /// <summary>
        /// 原始合同号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "OriginalContractNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string OriginalContractNo { get; set; }

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
        /// 货物名称
        /// </summary>
        [Required]
        [StringLength(500)]
        [Display(Name = "GoodsName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string GoodsName { get; set; }

        /// <summary>
        /// 包装样式
        /// </summary>
        [StringLength(50)]
        [Display(Name = "PackingStyle", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Packing { get; set; }

        /// <summary>
        /// 起点
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "StartPlace", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string StartPlace { get; set; }

        /// <summary>
        /// 讫点
        /// </summary>
        [Required]
        [StringLength(200)]
        [Display(Name = "DestPlace", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DestPlace { get; set; }

        /// <summary>
        /// 装运时间
        /// </summary>
        [Required]
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ShipmentTime", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ShipmentTime { get; set; }

        /// <summary>
        /// 到达时间
        /// </summary>
        [Required]
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ArrivalTime", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ArrivalTime { get; set; }

        /// <summary>
        /// 累计件数
        /// </summary>
        [RegularExpression(@"^[-+]?\d+$", ErrorMessageResourceName = "NotValidInteger", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "Pieces", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public int TotalPackages { get; set; }

        /// <summary>
        /// 累计吨数
        /// </summary>
        [RegularExpression(@"^[-+]?\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [DisplayFormat(DataFormatString = "{0:#0.######}", ApplyFormatInEditMode = true)]
        [Display(Name = "Tunnages", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TotalTunnages { get; set; }

        /// <summary>
        /// 累计垛数
        /// </summary>
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "PilesNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [DisplayFormat(DataFormatString = "{0:#0.######}", ApplyFormatInEditMode = true)]
        [Display(Name = "Piles", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TotalPiles { get; set; }

        /// <summary>
        /// 累计万只
        /// </summary>
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "TenThousandsNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [DisplayFormat(DataFormatString = "{0:#0.######}", ApplyFormatInEditMode = true)]
        [Display(Name = "TenThousands", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TotalTenThousands { get; set; }

        /// <summary>
        /// 累计运费
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[-+]?[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "TransportCharges", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TotalTransportCharges { get; set; }

        /// <summary>
        /// 预付运费
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[-+]?[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "PrepayTransportCharges", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal PrepayTransportCharges { get; set; }

        /// <summary>
        /// 剩余运费
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[-+]?[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ResidualTransportCharges", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal ResidualTransportCharges { get; set; }

        /// <summary>
        /// 发货计划集合
        /// </summary>
        public List<ContractDeliverPlanViewModel> DeliverPlans { get; set; }

    }
}