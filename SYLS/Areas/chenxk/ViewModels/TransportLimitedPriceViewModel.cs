using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class TransportLimitedPriceViewModel
    {
        /// <summary>
        /// 记录编码
        /// </summary>
        [Display(Name = "Id", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 计划类别
        /// </summary>
        [Required]
        [Display(Name = "PlanType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string PlanType { get; set; }

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
        /// 讫点国家
        /// </summary>
        [Required]
        [Display(Name = "DestCountry", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DestCountry { get; set; }

        /// <summary>
        /// 讫点省份
        /// </summary>
        [Required]
        [Display(Name = "DestProvince", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DestProvince { get; set; }

        /// <summary>
        /// 讫点城市
        /// </summary>
        [Required]
        [Display(Name = "DestCity", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DestCity { get; set; }

        /// <summary>
        /// 车型
        /// </summary>
        [Display(Name = "CarType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CarType { get; set; }

        /// <summary>
        /// 吨位（垛位）下限
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "MinTunnagesOrPilesNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [DisplayFormat(DataFormatString = "{0:#0.######}", ApplyFormatInEditMode = true)]
        [Display(Name = "MinTunnagesOrPiles", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal MinTunnagesOrPiles { get; set; }

        /// <summary>
        /// 吨位（垛位）上限
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanZero(ErrorMessageResourceName = "MaxTunnagesOrPilesNotGreaterThanZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThan("MinTunnagesOrPiles", ErrorMessageResourceName = "MaxTunnagesOrPilesCanNotLessThanMinTunnagesOrPiles", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [DisplayFormat(DataFormatString = "{0:#0.######}", ApplyFormatInEditMode = true)]
        [Display(Name = "MaxTunnagesOrPiles", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal MaxTunnagesOrPiles { get; set; }

        /// <summary>
        /// 起始时间
        /// </summary>
        [Required]
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "StartTime", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string StartTime { get; set; }

        /// <summary>
        /// 截止时间
        /// </summary>
        [Required]
        [RegularExpression(@"^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "EndTime", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string EndTime { get; set; }

        /// <summary>
        /// 限制单价
        /// </summary>
        [Required]
        [DisplayFormat(DataFormatString = "{0:#0.######}", ApplyFormatInEditMode = true)]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "LimitedTransportPriceNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "LimitedTransportPrice", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TransportPrice { get; set; }

        /// <summary>
        /// 限制总价
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[-+]?[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "LimitedTransportChargesNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "LimitedTransportCharges", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TransportCharges { get; set; }

    }
}