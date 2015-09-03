using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class MoveWarehouseBillViewModel
    {
        /// <summary>
        /// 移库单编码
        /// </summary>
        [Display(Name = "MoveWarehouseBillId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 移库单号
        /// </summary>
        [Display(Name = "MoveWarehouseBillNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string BillNo { get; set; }

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
        /// 仓库
        /// </summary>
        [Required]
        [Display(Name = "Warehouse", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Warehouse { get; set; }

        /// <summary>
        /// 寄库交货单号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "ConsignedDeliveryNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ConsignedDeliveryNo { get; set; }

        /// <summary>
        /// 货物编号
        /// </summary>
        [StringLength(20)]
        [Display(Name = "GoodsNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string GoodsNo { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(200)]
        [Display(Name = "Remark", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Remark { get; set; }

        /// <summary>
        /// 货物集合
        /// </summary>
        public List<MoveWarehouseBillGoodsViewModel> Goods { get; set; }
    }
}