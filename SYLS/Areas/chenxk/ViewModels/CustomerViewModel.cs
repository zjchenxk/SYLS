using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class CustomerViewModel
    {
        /// <summary>
        /// 客户编码
        /// </summary>
        [Display(Name = "CustomerId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 客户名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "CustomerName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Name { get; set; }

        /// <summary>
        /// 客户全称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "CustomerFullName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string FullName { get; set; }

        /// <summary>
        /// 预警库存
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+$", ErrorMessageResourceName = "NotValidInteger", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "WarningStockNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "WarningStock", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public int WarningStock { get; set; }

        /// <summary>
        /// 停止发货库存
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+$", ErrorMessageResourceName = "NotValidInteger", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "StopStockNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "StopStock", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public int StopStock { get; set; }

        /// <summary>
        /// 结算价格公式
        /// </summary>
        [Required]
        [StringLength(100)]
        [Display(Name = "SettlementExpression", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string SettlementExpression { get; set; }

        /// <summary>
        /// 计价模式
        /// </summary>
        [Required]
        [Display(Name = "ValuationMode", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ValuationMode { get; set; }

        /// <summary>
        /// 毛重率
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanZero(ErrorMessageResourceName = "GrossWeightRateNotGreaterThanZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "GrossWeightRate", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string GrossWeightRate { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(500)]
        [Display(Name = "Remark", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Remark { get; set; }

        /// <summary>
        /// 所属组织部门编码
        /// </summary>
        [Required]
        [Display(Name = "OwnOrganName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long OwnOrganId { get; set; }

        /// <summary>
        /// 结算价格集合
        /// </summary>
        public List<CustomerTransportPriceViewModel> TransportPrices { get; set; }

        /// <summary>
        /// 力支费价格集合
        /// </summary>
        public List<CustomerForceFeePriceViewModel> ForceFeePrices { get; set; }

        /// <summary>
        /// 仓储费价格集合
        /// </summary>
        public List<CustomerStorageFeePriceViewModel> StorageFeePrices { get; set; }
    }
}