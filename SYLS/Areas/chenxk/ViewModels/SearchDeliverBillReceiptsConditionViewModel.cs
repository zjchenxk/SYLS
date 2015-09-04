using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class SearchDeliverBillReceiptsConditionViewModel
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
        /// 承运车号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "CarNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CarNo { get; set; }

        /// <summary>
        /// 讫点国家
        /// </summary>
        [Display(Name = "DestCountry", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DestCountry { get; set; }

        /// <summary>
        /// 讫点省份
        /// </summary>
        [Display(Name = "DestProvince", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DestProvince { get; set; }

        /// <summary>
        /// 讫点城市
        /// </summary>
        [Display(Name = "DestCity", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DestCity { get; set; }

        /// <summary>
        /// 组织部门名称
        /// </summary>
        [Display(Name = "OrganName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string OrganId { get; set; }

    }
}