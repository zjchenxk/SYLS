using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class OtherPlanViewModel
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
        public List<OtherPlanGoodsViewModel> Goods { get; set; }
    }
}