using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class SearchOutWarehouseBillsConditionViewModel
    {
        /// <summary>
        /// 起始时间
        /// </summary>
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "StartTime", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string StartTime { get; set; }

        /// <summary>
        /// 截止时间
        /// </summary>
        [RegularExpression(@"^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$", ErrorMessageResourceName = "NotValidDate", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "EndTime", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string EndTime { get; set; }

        /// <summary>
        /// 客户名称
        /// </summary>
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
        /// 出库单号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "OutWarehouseBillNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string OutWarehouseBillNo { get; set; }

        /// <summary>
        /// 货物编号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "GoodsNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string GoodsNo { get; set; }

        /// <summary>
        /// 批次编号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "BatchNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string BatchNo { get; set; }

        /// <summary>
        /// 承运车号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "CarNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CarNo { get; set; }

        /// <summary>
        /// 提货单位名称
        /// </summary>
        [StringLength(50)]
        [Display(Name = "ReceiverName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ReceiverName { get; set; }

        /// <summary>
        /// 出库类别
        /// </summary>
        [Display(Name = "DeliverType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string OutType { get; set; }

        /// <summary>
        /// 仓库
        /// </summary>
        [Display(Name = "Warehouse", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Warehouse { get; set; }

        /// <summary>
        /// 提货方式
        /// </summary>
        [Display(Name = "ReceiveType", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ReceiveType { get; set; }

    }
}