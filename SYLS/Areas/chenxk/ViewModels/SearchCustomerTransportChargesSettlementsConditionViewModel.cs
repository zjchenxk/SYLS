﻿using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class SearchCustomerTransportChargesSettlementsConditionViewModel
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
        /// 发票号码
        /// </summary>
        [StringLength(20)]
        [Display(Name = "InvoiceNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string InvoiceNo { get; set; }

        /// <summary>
        /// 送货单号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "DeliverBillNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string DeliverBillNo { get; set; }

        /// <summary>
        /// 客户名称
        /// </summary>
        [StringLength(50)]
        [Display(Name = "CustomerName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CustomerName { get; set; }

    }
}