﻿namespace InnoSoft.LS.Models
{
    public class ContractDeliverPlan
    {
        /// <summary>
        /// 记录编码
        /// </summary>
        public long Id { get; set; }

        /// <summary>
        /// 合同编码
        /// </summary>
        public long ContractId { get; set; }

        /// <summary>
        /// 调度单编码
        /// </summary>
        public long DispatchBillId { get; set; }

        /// <summary>
        /// 计划编码
        /// </summary>
        public long PlanId { get; set; }

        /// <summary>
        /// 计划单号
        /// </summary>
        public string PlanNo { get; set; }

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
        /// 装运单号
        /// </summary>
        public string ShipmentNo { get; set; }

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
        /// 提货方式
        /// </summary>
        public string ReceiveType { get; set; }

        /// <summary>
        /// 件数
        /// </summary>
        public int Packages { get; set; }

        /// <summary>
        /// 吨数
        /// </summary>
        public decimal Tunnages { get; set; }

        /// <summary>
        /// 垛数
        /// </summary>
        public decimal Piles { get; set; }

        /// <summary>
        /// 万只
        /// </summary>
        public decimal TenThousands { get; set; }

        /// <summary>
        /// 运费公式
        /// </summary>
        public string TransportChargeExpression { get; set; }

        /// <summary>
        /// 单价公式
        /// </summary>
        public string TransportPriceExpression { get; set; }

        /// <summary>
        /// 公里数
        /// </summary>
        public int KM { get; set; }

        /// <summary>
        /// 协议单价
        /// </summary>
        public decimal AgreementTransportPrice { get; set; }

        /// <summary>
        /// 调度单价
        /// </summary>
        public decimal TransportPrice { get; set; }

        /// <summary>
        /// 调度运费
        /// </summary>
        public decimal TransportCharges { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// 起点所在国家
        /// </summary>
        public string StartCountry { get; set; }

        /// <summary>
        /// 起点所在省份
        /// </summary>
        public string StartProvince { get; set; }

        /// <summary>
        /// 起点所在城市
        /// </summary>
        public string StartCity { get; set; }

        /// <summary>
        /// 限制单价
        /// </summary>
        public decimal LimitedTransportPrice { get; set; }

        /// <summary>
        /// 限制总价
        /// </summary>
        public decimal LimitedTransportCharges { get; set; }

        /// <summary>
        /// 审批单价
        /// </summary>
        public decimal ApprovedTransportPrice { get; set; }

        /// <summary>
        /// 审批运费
        /// </summary>
        public decimal ApprovedTransportCharges { get; set; }

        /// <summary>
        /// 送货单回单已收标志
        /// </summary>
        public bool DeliverBillReceiptReceived { get; set; }

        /// <summary>
        /// 货损信息
        /// </summary>
        public string DamageInfo { get; set; }

        /// <summary>
        /// 特殊承运单价
        /// </summary>
        public decimal DeliverBillCarrierTransportPrice { get; set; }

        /// <summary>
        /// 特殊承运运费
        /// </summary>
        public decimal DeliverBillCarrierTransportCharges { get; set; }

        /// <summary>
        /// 最终单价
        /// </summary>
        public decimal FinalTransportPrice { get; set; }

        /// <summary>
        /// 最终运费
        /// </summary>
        public decimal FinalTransportCharges { get; set; }

    }
}
