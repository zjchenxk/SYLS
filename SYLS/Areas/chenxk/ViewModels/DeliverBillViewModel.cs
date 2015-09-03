using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class DeliverBillViewModel
    {
        /// <summary>
        /// 送货单编码
        /// </summary>
        public long Id { get; set; }

        /// <summary>
        /// 送货单号
        /// </summary>
        public string BillNo { get; set; }

        /// <summary>
        /// 调度单编码
        /// </summary>
        public long DispatchBillId { get; set; }

        /// <summary>
        /// 计划编码
        /// </summary>
        public long PlanId { get; set; }

        /// <summary>
        /// 计划类别
        /// </summary>
        public string PlanType { get; set; }

        /// <summary>
        /// 客户编码
        /// </summary>
        public long CustomerId { get; set; }

        /// <summary>
        /// 客户名称
        /// </summary>
        public string CustomerName { get; set; }

        /// <summary>
        /// 交货单号
        /// </summary>
        public string DeliveryNo { get; set; }

        /// <summary>
        /// 提货单位名称
        /// </summary>
        public string ReceiverName { get; set; }

        /// <summary>
        /// 提货单位所在国家
        /// </summary>
        public string ReceiverCountry { get; set; }

        /// <summary>
        /// 提货单位所在省份
        /// </summary>
        public string ReceiverProvince { get; set; }

        /// <summary>
        /// 收货单位所在城市
        /// </summary>
        public string ReceiverCity { get; set; }

        /// <summary>
        /// 收货单位地址
        /// </summary>
        public string ReceiverAddress { get; set; }

        /// <summary>
        /// 收货单位联系人姓名
        /// </summary>
        public string ReceiverContact { get; set; }

        /// <summary>
        /// 收货单位联系人电话
        /// </summary>
        public string ReceiverContactTel { get; set; }

        /// <summary>
        /// 收货方式
        /// </summary>
        public string ReceiveType { get; set; }

        /// <summary>
        /// 订单号
        /// </summary>
        public string OrderNo { get; set; }

        /// <summary>
        /// 车号
        /// </summary>
        public string CarNo { get; set; }

        /// <summary>
        /// 挂车号
        /// </summary>
        public string TrailerNo { get; set; }

        /// <summary>
        /// 承运单位编码
        /// </summary>
        public long CarrierId { get; set; }

        /// <summary>
        /// 承运单位名称
        /// </summary>
        public string CarrierName { get; set; }

        /// <summary>
        /// 发货仓库
        /// </summary>
        public string Warehouse { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// 创建日期
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 累计件数
        /// </summary>
        public int TotalPackages { get; set; }

        /// <summary>
        /// 累计吨数
        /// </summary>
        public decimal TotalTunnages { get; set; }

        /// <summary>
        /// 累计垛数
        /// </summary>
        public decimal TotalPiles { get; set; }

        /// <summary>
        /// 累计万只
        /// </summary>
        public decimal TotalTenThousands { get; set; }

        /// <summary>
        /// 运费公式
        /// </summary>
        [StringLength(100)]
        [Display(Name = "TransportChargeExpression", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string TransportChargeExpression { get; set; }

        /// <summary>
        /// 单价公式
        /// </summary>
        [StringLength(100)]
        [Display(Name = "TransportPriceExpression", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string TransportPriceExpression { get; set; }

        /// <summary>
        /// 协议价格
        /// </summary>
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "AgreementTransportPriceNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "AgreementTransportPrice", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal AgreementTransportPrice { get; set; }

        /// <summary>
        /// 实际价格
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+(\.\d+)?$", ErrorMessageResourceName = "NotValidNumeric", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "ActualTransportPriceNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "ActualTransportPrice", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal ActualTransportPrice { get; set; }

        /// <summary>
        /// 运费
        /// </summary>
        [Required]
        [DataType(DataType.Currency)]
        [RegularExpression(@"^[0-9]+(\.[0-9]{1,2})?$", ErrorMessageResourceName = "NotValidCurrency", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "TransportChargesNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "TransportCharges", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public decimal TransportCharges { get; set; }

        /// <summary>
        /// 货物集合
        /// </summary>
        public List<DeliverBillGoodsViewModel> Goods { get; set; }
    }
}