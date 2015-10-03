using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;
using InnoSoft.LS.Business.Facades;
using InnoSoft.LS.Models;
using SYLS.Controllers;
using SYLS.Helper;
using SYLS.Areas.chenxk.ViewModels;

namespace SYLS.Areas.chenxk.Controllers
{
    /// <summary>
    /// 统计管理控制器
    /// </summary>
    public class StatisticsController : BaseController
    {
        #region 统计办事处总产值

        /// <summary>
        /// GET统计办事处总产值页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult StatOrganTotalOutput()
        {
            string strErrText;

            //生成组织部门下拉列表项
            OrganizationSystem organ = new OrganizationSystem();
            List<Organization> listOrganization = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrganization == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListOrganization = new List<SelectListItem>();
            selectListOrganization.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListOrganization.AddRange(from o in listOrganization
                                            orderby o.FullName
                                            select new SelectListItem
                                            {
                                                Text = o.FullName,
                                                Value = o.Id.ToString()
                                            });
            ViewData["Organizations"] = new SelectList(selectListOrganization, "Value", "Text");

            return View();
        }

        /// <summary>
        /// GET办事处总产值表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="organId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadStatOrganTotalOutputGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string organId)
        {
            #region 读取明细数据

            string strErrText;
            StatisticsSystem stat = new StatisticsSystem();
            List<OrganTotalOutputDetail> listDetail = stat.LoadOrganTotalOutputDetailsByConditions(startTime, endTime, organId, LoginAccountId, LoginStaffName, out strErrText);
            if (listDetail == null)
            {
                throw new Exception(strErrText);
            }

            #endregion

            #region 根据结算公式计算运费
            {
                foreach (OrganTotalOutputDetail detail in listDetail)
                {
                    if (detail.CustomerTransportCharges == 0 && detail.CustomerSettlementExpression != null && detail.CustomerSettlementExpression != string.Empty)
                    {
                        try
                        {
                            EvaluatorHelper evaluator = new EvaluatorHelper();

                            evaluator.SetExpression(detail.CustomerSettlementExpression);

                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.KM, detail.KM == null || detail.KM == string.Empty ? "0" : detail.KM);
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Tunnages, detail.TotalTunnages.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Piles, detail.TotalPiles.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportPrice, detail.CustomerTransportPrice.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportCharges, "0");

                            string strTransportCharges = evaluator.EvaluateExpression();
                            detail.CustomerTransportCharges = decimal.Parse(strTransportCharges);
                        }
                        catch (Exception e)
                        {
                            throw e;
                        }
                    }
                }
            }
            #endregion

            #region 计算拼车费
            {
                var grpShipmentNos = listDetail.GroupBy(d => d.ShipmentNo).OrderBy(d => d.Key);
                foreach (var grpShipmentNo in grpShipmentNos)
                {
                    if (grpShipmentNo.Key != null && grpShipmentNo.Key != string.Empty)
                    {
                        List<OrganTotalOutputDetail> listShipmentNoDetail = grpShipmentNo.ToList<OrganTotalOutputDetail>();

                        int i = 0;
                        while (i < listShipmentNoDetail.Count)
                        {
                            if (i > 0)
                            {
                                int j = 0;
                                while (j < i)
                                {
                                    if (listShipmentNoDetail[i].ReceiverAddress == listShipmentNoDetail[j].ReceiverAddress)
                                    {
                                        break;
                                    }
                                    j++;
                                }
                                if (j >= i)
                                {
                                    listShipmentNoDetail[i].CustomerCarpoolFee = 100;
                                }
                            }
                            i++;
                        }
                    }
                }
            }
            #endregion

            #region 生成表格数据源

            List<StatOrganTotalOutput> listStat = new List<StatOrganTotalOutput>();
            {
                //按办事处分组
                var grpOrganNames = listDetail.GroupBy(d => d.OwnOrganName).OrderBy(d => d.Key);
                foreach (var grpOrganName in grpOrganNames)
                {
                    List<OrganTotalOutputDetail> listOrganNameDetail = grpOrganName.ToList<OrganTotalOutputDetail>();

                    //再按省份分组
                    var grpReceiverProvinces = listOrganNameDetail.GroupBy(d => d.ReceiverProvince).OrderBy(d => d.Key);
                    foreach (var grpReceiverProvince in grpReceiverProvinces)
                    {
                        List<OrganTotalOutputDetail> listReceiverProvinceDetail = grpReceiverProvince.ToList<OrganTotalOutputDetail>();

                        //生成表格数据行
                        StatOrganTotalOutput s = new StatOrganTotalOutput();
                        s.Id = listStat.Count + 1;
                        s.OrganName = grpOrganName.Key;
                        s.ProvinceName = grpReceiverProvince.Key;

                        s.JoinInTunnages = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalTunnages);
                        s.SelfSupportTunnages = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalTunnages);
                        s.PrestowageTunnages = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalTunnages);
                        s.SubtotalTunnages = listReceiverProvinceDetail.Sum(d => d.TotalTunnages);

                        s.JoinInPiles = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalPiles);
                        s.SelfSupportPiles = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalPiles);
                        s.PrestowagePiles = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalPiles);
                        s.SubtotalPiles = listReceiverProvinceDetail.Sum(d => d.TotalPiles);

                        s.JoinInTransportCharges = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.SelfSupportTransportCharges = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.PrestowageTransportCharges = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.SubtotalTransportCharges = listReceiverProvinceDetail.Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);

                        s.JoinInTransportChargesDifference = s.JoinInTransportCharges - listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CarrierTransportCharges);
                        s.SelfSupportTransportChargesDifference = s.SelfSupportTransportCharges - listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CarrierTransportCharges);
                        s.PrestowageTransportChargesDifference = s.PrestowageTransportCharges - listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CarrierTransportCharges);
                        s.SubtotalTransportChargesDifference = s.SubtotalTransportCharges - listReceiverProvinceDetail.Sum(d => d.CarrierTransportCharges);

                        s.JoinInGrossProfitRate = s.JoinInTransportCharges != 0 ? s.JoinInTransportChargesDifference / s.JoinInTransportCharges : 0;
                        s.SelfSupportGrossProfitRate = s.SelfSupportTransportCharges != 0 ? s.SelfSupportTransportChargesDifference / s.SelfSupportTransportCharges : 0;
                        s.PrestowageGrossProfitRate = s.PrestowageTransportCharges != 0 ? s.PrestowageTransportChargesDifference / s.PrestowageTransportCharges : 0;
                        s.SubtotalGrossProfitRate = s.SubtotalTransportCharges != 0 ? s.SubtotalTransportChargesDifference / s.SubtotalTransportCharges : 0;

                        listStat.Add(s);
                    }
                }
            }

            #endregion

            //提取当前页面数据
            int nTotalRows = listStat.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "ProvinceName") + " " + (sord ?? "ASC");
            var data = listStat.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from s in data
                      select new
                      {
                          id = s.Id,
                          cell = new string[] { 
                              s.Id.ToString(),
                              s.OrganName,
                              s.ProvinceName,
                              s.JoinInTunnages.ToString("#0.######"),
                              s.SelfSupportTunnages.ToString("#0.######"),
                              s.PrestowageTunnages.ToString("#0.######"),
                              s.SubtotalTunnages.ToString("#0.######"),
                              s.JoinInPiles.ToString("#0.######"),
                              s.SelfSupportPiles.ToString("#0.######"),
                              s.PrestowagePiles.ToString("#0.######"),
                              s.SubtotalPiles.ToString("#0.######"),
                              s.JoinInTransportCharges.ToString(),
                              s.SelfSupportTransportCharges.ToString(),
                              s.PrestowageTransportCharges.ToString(),
                              s.SubtotalTransportCharges.ToString(),
                              s.JoinInTransportChargesDifference.ToString(),
                              s.SelfSupportTransportChargesDifference.ToString(),
                              s.PrestowageTransportChargesDifference.ToString(),
                              s.SubtotalTransportChargesDifference.ToString(),
                              s.JoinInGrossProfitRate.ToString(),
                              s.SelfSupportGrossProfitRate.ToString(),
                              s.PrestowageGrossProfitRate.ToString(),
                              s.SubtotalGrossProfitRate.ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    OrganName = InnoSoft.LS.Resources.Labels.Total,
                    JoinInTunnages = data.Sum(s => s.JoinInTunnages),
                    SelfSupportTunnages = data.Sum(s => s.SelfSupportTunnages),
                    PrestowageTunnages = data.Sum(s => s.PrestowageTunnages),
                    SubtotalTunnages = data.Sum(s => s.SubtotalTunnages),
                    JoinInPiles = data.Sum(s => s.JoinInPiles),
                    SelfSupportPiles = data.Sum(s => s.SelfSupportPiles),
                    PrestowagePiles = data.Sum(s => s.PrestowagePiles),
                    SubtotalPiles = data.Sum(s => s.SubtotalPiles),
                    JoinInTransportCharges = data.Sum(s => s.JoinInTransportCharges),
                    SelfSupportTransportCharges = data.Sum(s => s.SelfSupportTransportCharges),
                    PrestowageTransportCharges = data.Sum(s => s.PrestowageTransportCharges),
                    SubtotalTransportCharges = data.Sum(s => s.SubtotalTransportCharges),
                    JoinInTransportChargesDifference = data.Sum(s => s.JoinInTransportChargesDifference),
                    SelfSupportTransportChargesDifference = data.Sum(s => s.SelfSupportTransportChargesDifference),
                    PrestowageTransportChargesDifference = data.Sum(s => s.PrestowageTransportChargesDifference),
                    SubtotalTransportChargesDifference = data.Sum(s => s.SubtotalTransportChargesDifference),
                    JoinInGrossProfitRate = data.Sum(s => s.JoinInTransportCharges) != 0 ? data.Sum(s => s.JoinInTransportChargesDifference) / data.Sum(s => s.JoinInTransportCharges) : 0,
                    SelfSupportGrossProfitRate = data.Sum(s => s.SelfSupportTransportCharges) != 0 ? data.Sum(s => s.SelfSupportTransportChargesDifference) / data.Sum(s => s.SelfSupportTransportCharges) : 0,
                    PrestowageGrossProfitRate = data.Sum(s => s.PrestowageTransportCharges) != 0 ? data.Sum(s => s.PrestowageTransportChargesDifference) / data.Sum(s => s.PrestowageTransportCharges) : 0,
                    SubtotalGrossProfitRate = data.Sum(s => s.SubtotalTransportCharges) != 0 ? data.Sum(s => s.SubtotalTransportChargesDifference) / data.Sum(s => s.SubtotalTransportCharges) : 0
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET导出办事处总产值数据
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportOrganTotalOutput()
        {
            string strErrText;

            #region 提取参数

            var request = HttpContext.Request;
            string strStartTime = request.QueryString["startTime"] ?? string.Empty;
            string strEndTime = request.QueryString["endTime"] ?? string.Empty;
            string strOrganId = request.QueryString["organId"] ?? string.Empty;

            #endregion

            #region 读取明细数据

            StatisticsSystem stat = new StatisticsSystem();
            List<OrganTotalOutputDetail> listDetail = stat.LoadOrganTotalOutputDetailsByConditions(strStartTime, strEndTime, strOrganId, LoginAccountId, LoginStaffName, out strErrText);
            if (listDetail == null)
            {
                throw new Exception(strErrText);
            }

            #endregion

            #region 根据结算公式计算运费
            {
                foreach (OrganTotalOutputDetail detail in listDetail)
                {
                    if (detail.CustomerTransportCharges == 0 && detail.CustomerSettlementExpression != null && detail.CustomerSettlementExpression != string.Empty)
                    {
                        try
                        {
                            EvaluatorHelper evaluator = new EvaluatorHelper();

                            evaluator.SetExpression(detail.CustomerSettlementExpression);

                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.KM, detail.KM == null || detail.KM == string.Empty ? "0" : detail.KM);
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Tunnages, detail.TotalTunnages.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Piles, detail.TotalPiles.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportPrice, detail.CustomerTransportPrice.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportCharges, "0");

                            string strTransportCharges = evaluator.EvaluateExpression();
                            detail.CustomerTransportCharges = decimal.Parse(strTransportCharges);
                        }
                        catch (Exception e)
                        {
                            throw e;
                        }
                    }
                }
            }
            #endregion

            #region 计算拼车费
            {
                var grpShipmentNos = listDetail.GroupBy(d => d.ShipmentNo).OrderBy(d => d.Key);
                foreach (var grpShipmentNo in grpShipmentNos)
                {
                    if (grpShipmentNo.Key != null && grpShipmentNo.Key != string.Empty)
                    {
                        List<OrganTotalOutputDetail> listShipmentNoDetail = grpShipmentNo.ToList<OrganTotalOutputDetail>();

                        int i = 0;
                        while (i < listShipmentNoDetail.Count)
                        {
                            if (i > 0)
                            {
                                int j = 0;
                                while (j < i)
                                {
                                    if (listShipmentNoDetail[i].ReceiverAddress == listShipmentNoDetail[j].ReceiverAddress)
                                    {
                                        break;
                                    }
                                    j++;
                                }
                                if (j >= i)
                                {
                                    listShipmentNoDetail[i].CustomerCarpoolFee = 100;
                                }
                            }
                            i++;
                        }
                    }
                }
            }
            #endregion

            #region 生成表格数据源

            List<StatOrganTotalOutput> listStat = new List<StatOrganTotalOutput>();
            {
                //按办事处分组
                var grpOrganNames = listDetail.GroupBy(d => d.OwnOrganName).OrderBy(d => d.Key);
                foreach (var grpOrganName in grpOrganNames)
                {
                    List<OrganTotalOutputDetail> listOrganNameDetail = grpOrganName.ToList<OrganTotalOutputDetail>();

                    //再按省份分组
                    var grpReceiverProvinces = listOrganNameDetail.GroupBy(d => d.ReceiverProvince).OrderBy(d => d.Key);
                    foreach (var grpReceiverProvince in grpReceiverProvinces)
                    {
                        List<OrganTotalOutputDetail> listReceiverProvinceDetail = grpReceiverProvince.ToList<OrganTotalOutputDetail>();

                        //生成表格数据行
                        StatOrganTotalOutput s = new StatOrganTotalOutput();
                        s.Id = listStat.Count + 1;
                        s.OrganName = grpOrganName.Key;
                        s.ProvinceName = grpReceiverProvince.Key;

                        s.JoinInTunnages = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalTunnages);
                        s.SelfSupportTunnages = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalTunnages);
                        s.PrestowageTunnages = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalTunnages);
                        s.SubtotalTunnages = listReceiverProvinceDetail.Sum(d => d.TotalTunnages);

                        s.JoinInPiles = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalPiles);
                        s.SelfSupportPiles = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalPiles);
                        s.PrestowagePiles = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalPiles);
                        s.SubtotalPiles = listReceiverProvinceDetail.Sum(d => d.TotalPiles);

                        s.JoinInTransportCharges = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.SelfSupportTransportCharges = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.PrestowageTransportCharges = listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.SubtotalTransportCharges = listReceiverProvinceDetail.Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);

                        s.JoinInTransportChargesDifference = s.JoinInTransportCharges - listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CarrierTransportCharges);
                        s.SelfSupportTransportChargesDifference = s.SelfSupportTransportCharges - listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CarrierTransportCharges);
                        s.PrestowageTransportChargesDifference = s.PrestowageTransportCharges - listReceiverProvinceDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CarrierTransportCharges);
                        s.SubtotalTransportChargesDifference = s.SubtotalTransportCharges - listReceiverProvinceDetail.Sum(d => d.CarrierTransportCharges);

                        s.JoinInGrossProfitRate = s.JoinInTransportCharges != 0 ? s.JoinInTransportChargesDifference / s.JoinInTransportCharges : 0;
                        s.SelfSupportGrossProfitRate = s.SelfSupportTransportCharges != 0 ? s.SelfSupportTransportChargesDifference / s.SelfSupportTransportCharges : 0;
                        s.PrestowageGrossProfitRate = s.PrestowageTransportCharges != 0 ? s.PrestowageTransportChargesDifference / s.PrestowageTransportCharges : 0;
                        s.SubtotalGrossProfitRate = s.SubtotalTransportCharges != 0 ? s.SubtotalTransportChargesDifference / s.SubtotalTransportCharges : 0;

                        listStat.Add(s);
                    }
                    //小计
                    {
                        StatOrganTotalOutput s = new StatOrganTotalOutput();
                        s.Id = listStat.Count + 1;
                        s.OrganName = InnoSoft.LS.Resources.Labels.Subtotal;
                        s.ProvinceName = string.Empty;

                        s.JoinInTunnages = listOrganNameDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalTunnages);
                        s.SelfSupportTunnages = listOrganNameDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalTunnages);
                        s.PrestowageTunnages = listOrganNameDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalTunnages);
                        s.SubtotalTunnages = listOrganNameDetail.Sum(d => d.TotalTunnages);

                        s.JoinInPiles = listOrganNameDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalPiles);
                        s.SelfSupportPiles = listOrganNameDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalPiles);
                        s.PrestowagePiles = listOrganNameDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalPiles);
                        s.SubtotalPiles = listOrganNameDetail.Sum(d => d.TotalPiles);

                        s.JoinInTransportCharges = listOrganNameDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.SelfSupportTransportCharges = listOrganNameDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.PrestowageTransportCharges = listOrganNameDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.SubtotalTransportCharges = listOrganNameDetail.Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);

                        s.JoinInTransportChargesDifference = s.JoinInTransportCharges - listOrganNameDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CarrierTransportCharges);
                        s.SelfSupportTransportChargesDifference = s.SelfSupportTransportCharges - listOrganNameDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CarrierTransportCharges);
                        s.PrestowageTransportChargesDifference = s.PrestowageTransportCharges - listOrganNameDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CarrierTransportCharges);
                        s.SubtotalTransportChargesDifference = s.SubtotalTransportCharges - listOrganNameDetail.Sum(d => d.CarrierTransportCharges);

                        s.JoinInGrossProfitRate = s.JoinInTransportCharges != 0 ? s.JoinInTransportChargesDifference / s.JoinInTransportCharges : 0;
                        s.SelfSupportGrossProfitRate = s.SelfSupportTransportCharges != 0 ? s.SelfSupportTransportChargesDifference / s.SelfSupportTransportCharges : 0;
                        s.PrestowageGrossProfitRate = s.PrestowageTransportCharges != 0 ? s.PrestowageTransportChargesDifference / s.PrestowageTransportCharges : 0;
                        s.SubtotalGrossProfitRate = s.SubtotalTransportCharges != 0 ? s.SubtotalTransportChargesDifference / s.SubtotalTransportCharges : 0;

                        listStat.Add(s);
                    }
                }
                //总计
                {
                    StatOrganTotalOutput s = new StatOrganTotalOutput();
                    s.Id = listStat.Count + 1;
                    s.OrganName = InnoSoft.LS.Resources.Labels.Total;
                    s.ProvinceName = string.Empty;

                    s.JoinInTunnages = listDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalTunnages);
                    s.SelfSupportTunnages = listDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalTunnages);
                    s.PrestowageTunnages = listDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalTunnages);
                    s.SubtotalTunnages = listDetail.Sum(d => d.TotalTunnages);

                    s.JoinInPiles = listDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalPiles);
                    s.SelfSupportPiles = listDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalPiles);
                    s.PrestowagePiles = listDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalPiles);
                    s.SubtotalPiles = listDetail.Sum(d => d.TotalPiles);

                    s.JoinInTransportCharges = listDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                    s.SelfSupportTransportCharges = listDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                    s.PrestowageTransportCharges = listDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                    s.SubtotalTransportCharges = listDetail.Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);

                    s.JoinInTransportChargesDifference = s.JoinInTransportCharges - listDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CarrierTransportCharges);
                    s.SelfSupportTransportChargesDifference = s.SelfSupportTransportCharges - listDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CarrierTransportCharges);
                    s.PrestowageTransportChargesDifference = s.PrestowageTransportCharges - listDetail.FindAll(delegate(OrganTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CarrierTransportCharges);
                    s.SubtotalTransportChargesDifference = s.SubtotalTransportCharges - listDetail.Sum(d => d.CarrierTransportCharges);

                    s.JoinInGrossProfitRate = s.JoinInTransportCharges != 0 ? s.JoinInTransportChargesDifference / s.JoinInTransportCharges : 0;
                    s.SelfSupportGrossProfitRate = s.SelfSupportTransportCharges != 0 ? s.SelfSupportTransportChargesDifference / s.SelfSupportTransportCharges : 0;
                    s.PrestowageGrossProfitRate = s.PrestowageTransportCharges != 0 ? s.PrestowageTransportChargesDifference / s.PrestowageTransportCharges : 0;
                    s.SubtotalGrossProfitRate = s.SubtotalTransportCharges != 0 ? s.SubtotalTransportChargesDifference / s.SubtotalTransportCharges : 0;

                    listStat.Add(s);
                }
            }

            #endregion

            #region 输出Excel

            //生成GridView
            BoundField colOrganName = new BoundField();
            colOrganName.HeaderText = InnoSoft.LS.Resources.Labels.OrganName;
            colOrganName.DataField = "OrganName";

            BoundField colProvinceName = new BoundField();
            colProvinceName.HeaderText = InnoSoft.LS.Resources.Labels.StateName;
            colProvinceName.DataField = "ProvinceName";

            BoundField colJoinInTunnages = new BoundField();
            colJoinInTunnages.HeaderText = InnoSoft.LS.Resources.Labels.JoinIn + "-" + InnoSoft.LS.Resources.Labels.Tunnages;
            colJoinInTunnages.DataField = "JoinInTunnages";

            BoundField colSelfSupportTunnages = new BoundField();
            colSelfSupportTunnages.HeaderText = InnoSoft.LS.Resources.Labels.SelfSupport + "-" + InnoSoft.LS.Resources.Labels.Tunnages;
            colSelfSupportTunnages.DataField = "SelfSupportTunnages";

            BoundField colPrestowageTunnages = new BoundField();
            colPrestowageTunnages.HeaderText = InnoSoft.LS.Resources.Labels.Prestowage + "-" + InnoSoft.LS.Resources.Labels.Tunnages;
            colPrestowageTunnages.DataField = "PrestowageTunnages";

            BoundField colSubtotalTunnages = new BoundField();
            colSubtotalTunnages.HeaderText = InnoSoft.LS.Resources.Labels.Subtotal + "-" + InnoSoft.LS.Resources.Labels.Tunnages;
            colSubtotalTunnages.DataField = "SubtotalTunnages";

            BoundField colJoinInPiles = new BoundField();
            colJoinInPiles.HeaderText = InnoSoft.LS.Resources.Labels.JoinIn + "-" + InnoSoft.LS.Resources.Labels.Piles;
            colJoinInPiles.DataField = "JoinInPiles";

            BoundField colSelfSupportPiles = new BoundField();
            colSelfSupportPiles.HeaderText = InnoSoft.LS.Resources.Labels.SelfSupport + "-" + InnoSoft.LS.Resources.Labels.Piles;
            colSelfSupportPiles.DataField = "SelfSupportPiles";

            BoundField colPrestowagePiles = new BoundField();
            colPrestowagePiles.HeaderText = InnoSoft.LS.Resources.Labels.Prestowage + "-" + InnoSoft.LS.Resources.Labels.Piles;
            colPrestowagePiles.DataField = "PrestowagePiles";

            BoundField colSubtotalPiles = new BoundField();
            colSubtotalPiles.HeaderText = InnoSoft.LS.Resources.Labels.Subtotal + "-" + InnoSoft.LS.Resources.Labels.Piles;
            colSubtotalPiles.DataField = "SubtotalPiles";

            BoundField colJoinInTransportCharges = new BoundField();
            colJoinInTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.JoinIn + "-" + InnoSoft.LS.Resources.Labels.TransportCharges;
            colJoinInTransportCharges.DataField = "JoinInTransportCharges";

            BoundField colSelfSupportTransportCharges = new BoundField();
            colSelfSupportTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.SelfSupport + "-" + InnoSoft.LS.Resources.Labels.TransportCharges;
            colSelfSupportTransportCharges.DataField = "SelfSupportTransportCharges";

            BoundField colPrestowageTransportCharges = new BoundField();
            colPrestowageTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.Prestowage + "-" + InnoSoft.LS.Resources.Labels.TransportCharges;
            colPrestowageTransportCharges.DataField = "PrestowageTransportCharges";

            BoundField colSubtotalTransportCharges = new BoundField();
            colSubtotalTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.Subtotal + "-" + InnoSoft.LS.Resources.Labels.TransportCharges;
            colSubtotalTransportCharges.DataField = "SubtotalTransportCharges";

            BoundField colJoinInTransportChargesDifference = new BoundField();
            colJoinInTransportChargesDifference.HeaderText = InnoSoft.LS.Resources.Labels.JoinIn + "-" + InnoSoft.LS.Resources.Labels.TransportChargesDifference;
            colJoinInTransportChargesDifference.DataField = "JoinInTransportChargesDifference";

            BoundField colSelfSupportTransportChargesDifference = new BoundField();
            colSelfSupportTransportChargesDifference.HeaderText = InnoSoft.LS.Resources.Labels.SelfSupport + "-" + InnoSoft.LS.Resources.Labels.TransportChargesDifference;
            colSelfSupportTransportChargesDifference.DataField = "SelfSupportTransportChargesDifference";

            BoundField colPrestowageTransportChargesDifference = new BoundField();
            colPrestowageTransportChargesDifference.HeaderText = InnoSoft.LS.Resources.Labels.Prestowage + "-" + InnoSoft.LS.Resources.Labels.TransportChargesDifference;
            colPrestowageTransportChargesDifference.DataField = "PrestowageTransportChargesDifference";

            BoundField colSubtotalTransportChargesDifference = new BoundField();
            colSubtotalTransportChargesDifference.HeaderText = InnoSoft.LS.Resources.Labels.Subtotal + "-" + InnoSoft.LS.Resources.Labels.TransportChargesDifference;
            colSubtotalTransportChargesDifference.DataField = "SubtotalTransportChargesDifference";

            BoundField colJoinInGrossProfitRate = new BoundField();
            colJoinInGrossProfitRate.HeaderText = InnoSoft.LS.Resources.Labels.JoinIn + "-" + InnoSoft.LS.Resources.Labels.GrossProfitRate;
            colJoinInGrossProfitRate.DataField = "JoinInGrossProfitRate";

            BoundField colSelfSupportGrossProfitRate = new BoundField();
            colSelfSupportGrossProfitRate.HeaderText = InnoSoft.LS.Resources.Labels.SelfSupport + "-" + InnoSoft.LS.Resources.Labels.GrossProfitRate;
            colSelfSupportGrossProfitRate.DataField = "SelfSupportGrossProfitRate";

            BoundField colPrestowageGrossProfitRate = new BoundField();
            colPrestowageGrossProfitRate.HeaderText = InnoSoft.LS.Resources.Labels.Prestowage + "-" + InnoSoft.LS.Resources.Labels.GrossProfitRate;
            colPrestowageGrossProfitRate.DataField = "PrestowageGrossProfitRate";

            BoundField colSubtotalGrossProfitRate = new BoundField();
            colSubtotalGrossProfitRate.HeaderText = InnoSoft.LS.Resources.Labels.Subtotal + "-" + InnoSoft.LS.Resources.Labels.GrossProfitRate;
            colSubtotalGrossProfitRate.DataField = "SubtotalGrossProfitRate";

            var grid = new GridView();
            grid.Columns.Add(colOrganName);
            grid.Columns.Add(colProvinceName);
            grid.Columns.Add(colJoinInTunnages);
            grid.Columns.Add(colSelfSupportTunnages);
            grid.Columns.Add(colPrestowageTunnages);
            grid.Columns.Add(colSubtotalTunnages);
            grid.Columns.Add(colJoinInPiles);
            grid.Columns.Add(colSelfSupportPiles);
            grid.Columns.Add(colPrestowagePiles);
            grid.Columns.Add(colSubtotalPiles);
            grid.Columns.Add(colJoinInTransportCharges);/*10*/
            grid.Columns.Add(colSelfSupportTransportCharges);
            grid.Columns.Add(colPrestowageTransportCharges);
            grid.Columns.Add(colSubtotalTransportCharges);
            grid.Columns.Add(colJoinInTransportChargesDifference);
            grid.Columns.Add(colSelfSupportTransportChargesDifference);
            grid.Columns.Add(colPrestowageTransportChargesDifference);
            grid.Columns.Add(colSubtotalTransportChargesDifference);/*17*/
            grid.Columns.Add(colJoinInGrossProfitRate);
            grid.Columns.Add(colSelfSupportGrossProfitRate);
            grid.Columns.Add(colPrestowageGrossProfitRate);
            grid.Columns.Add(colSubtotalGrossProfitRate);

            grid.AutoGenerateColumns = false;

            grid.RowDataBound += new GridViewRowEventHandler(OrganTotalOutputGrid_RowDataBound);
            grid.DataSource = from s in listStat
                              select new
                              {
                                  OrganName = s.OrganName,
                                  ProvinceName = s.ProvinceName,
                                  JoinInTunnages = s.JoinInTunnages != 0 ? s.JoinInTunnages.ToString("#0.######") : string.Empty,
                                  SelfSupportTunnages = s.SelfSupportTunnages != 0 ? s.SelfSupportTunnages.ToString("#0.######") : string.Empty,
                                  PrestowageTunnages = s.PrestowageTunnages != 0 ? s.PrestowageTunnages.ToString("#0.######") : string.Empty,
                                  SubtotalTunnages = s.SubtotalTunnages != 0 ? s.SubtotalTunnages.ToString("#0.######") : string.Empty,
                                  JoinInPiles = s.JoinInPiles != 0 ? s.JoinInPiles.ToString("#0.######") : string.Empty,
                                  SelfSupportPiles = s.SelfSupportPiles != 0 ? s.SelfSupportPiles.ToString("#0.######") : string.Empty,
                                  PrestowagePiles = s.PrestowagePiles != 0 ? s.PrestowagePiles.ToString("#0.######") : string.Empty,
                                  SubtotalPiles = s.SubtotalPiles != 0 ? s.SubtotalPiles.ToString("#0.######") : string.Empty,
                                  JoinInTransportCharges = s.JoinInTransportCharges != 0 ? s.JoinInTransportCharges.ToString("N") : string.Empty,
                                  SelfSupportTransportCharges = s.SelfSupportTransportCharges != 0 ? s.SelfSupportTransportCharges.ToString("N") : string.Empty,
                                  PrestowageTransportCharges = s.PrestowageTransportCharges != 0 ? s.PrestowageTransportCharges.ToString("N") : string.Empty,
                                  SubtotalTransportCharges = s.SubtotalTransportCharges != 0 ? s.SubtotalTransportCharges.ToString("N") : string.Empty,
                                  JoinInTransportChargesDifference = s.JoinInTransportChargesDifference != 0 ? s.JoinInTransportChargesDifference.ToString("N") : string.Empty,
                                  SelfSupportTransportChargesDifference = s.SelfSupportTransportChargesDifference != 0 ? s.SelfSupportTransportChargesDifference.ToString("N") : string.Empty,
                                  PrestowageTransportChargesDifference = s.PrestowageTransportChargesDifference != 0 ? s.PrestowageTransportChargesDifference.ToString("N") : string.Empty,
                                  SubtotalTransportChargesDifference = s.SubtotalTransportChargesDifference != 0 ? s.SubtotalTransportChargesDifference.ToString("N") : string.Empty,
                                  JoinInGrossProfitRate = s.JoinInGrossProfitRate != 0 ? s.JoinInGrossProfitRate.ToString("N") : string.Empty,
                                  SelfSupportGrossProfitRate = s.SelfSupportGrossProfitRate != 0 ? s.SelfSupportGrossProfitRate.ToString("N") : string.Empty,
                                  PrestowageGrossProfitRate = s.PrestowageGrossProfitRate != 0 ? s.PrestowageGrossProfitRate.ToString("N") : string.Empty,
                                  SubtotalGrossProfitRate = s.SubtotalGrossProfitRate != 0 ? s.SubtotalGrossProfitRate.ToString("N") : string.Empty
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=OrganTotalOutput.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

            #endregion

            return View("StatOrganTotalOutput");
        }

        private void OrganTotalOutputGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[10].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费被自动转换为整形
                e.Row.Cells[11].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费被自动转换为整形
                e.Row.Cells[12].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费被自动转换为整形
                e.Row.Cells[13].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费被自动转换为整形
                e.Row.Cells[14].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止价差被自动转换为整形
                e.Row.Cells[15].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止价差被自动转换为整形
                e.Row.Cells[16].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止价差被自动转换为整形
                e.Row.Cells[17].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止价差被自动转换为整形
            }
        }

        #endregion

        #region 统计办事处毛利率

        /// <summary>
        /// GET统计办事处毛利率页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult StatOrganGrossProfitRate()
        {
            string strErrText;

            //生成组织部门下拉列表项
            OrganizationSystem organ = new OrganizationSystem();
            List<Organization> listOrganization = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrganization == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListOrganization = new List<SelectListItem>();
            selectListOrganization.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListOrganization.AddRange(from o in listOrganization
                                            orderby o.FullName
                                            select new SelectListItem
                                            {
                                                Text = o.FullName,
                                                Value = o.Id.ToString()
                                            });
            ViewData["Organizations"] = new SelectList(selectListOrganization, "Value", "Text");

            return View();
        }

        /// <summary>
        /// GET统计办事处毛利率表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="organId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadStatOrganGrossProfitRateGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string organId)
        {
            #region 读取明细数据

            string strErrText;
            StatisticsSystem stat = new StatisticsSystem();
            List<OrganGrossProfitRateDetail> listDetail = stat.LoadOrganGrossProfitRateDetailsByConditions(startTime, endTime, organId, LoginAccountId, LoginStaffName, out strErrText);
            if (listDetail == null)
            {
                throw new Exception(strErrText);
            }

            #endregion

            #region 根据结算公式计算运费
            {
                foreach (OrganGrossProfitRateDetail detail in listDetail)
                {
                    if (detail.CustomerTransportCharges == 0 && detail.CustomerSettlementExpression != null && detail.CustomerSettlementExpression != string.Empty)
                    {
                        try
                        {
                            EvaluatorHelper evaluator = new EvaluatorHelper();

                            evaluator.SetExpression(detail.CustomerSettlementExpression);

                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.KM, detail.KM == null || detail.KM == string.Empty ? "0" : detail.KM);
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Tunnages, detail.TotalTunnages.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Piles, detail.TotalPiles.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportPrice, detail.CustomerTransportPrice.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportCharges, "0");

                            string strTransportCharges = evaluator.EvaluateExpression();
                            detail.CustomerTransportCharges = decimal.Parse(strTransportCharges);
                        }
                        catch (Exception e)
                        {
                            throw e;
                        }
                    }
                }
            }
            #endregion

            #region 计算拼车费
            {
                var grpShipmentNos = listDetail.GroupBy(d => d.ShipmentNo).OrderBy(d => d.Key);
                foreach (var grpShipmentNo in grpShipmentNos)
                {
                    if (grpShipmentNo.Key != null && grpShipmentNo.Key != string.Empty)
                    {
                        List<OrganGrossProfitRateDetail> listShipmentNoDetail = grpShipmentNo.ToList<OrganGrossProfitRateDetail>();

                        int i = 0;
                        while (i < listShipmentNoDetail.Count)
                        {
                            if (i > 0)
                            {
                                int j = 0;
                                while (j < i)
                                {
                                    if (listShipmentNoDetail[i].ReceiverAddress == listShipmentNoDetail[j].ReceiverAddress)
                                    {
                                        break;
                                    }
                                    j++;
                                }
                                if (j >= i)
                                {
                                    listShipmentNoDetail[i].CustomerCarpoolFee = 100;
                                }
                            }
                            i++;
                        }
                    }
                }
            }
            #endregion

            #region 生成表格数据源

            List<StatOrganGrossProfitRate> listStat = new List<StatOrganGrossProfitRate>();
            {
                //按办事处分组
                var grpOrganNames = listDetail.GroupBy(d => d.OwnOrganName).OrderBy(d => d.Key);
                foreach (var grpOrganName in grpOrganNames)
                {
                    List<OrganGrossProfitRateDetail> listOrganNameDetail = grpOrganName.ToList<OrganGrossProfitRateDetail>();

                    //再按起点分组
                    var grpStartPlaces = listOrganNameDetail.GroupBy(d => d.StartCity).OrderBy(d => d.Key);
                    foreach (var grpStartPlace in grpStartPlaces)
                    {
                        List<OrganGrossProfitRateDetail> listStartPlaceDetail = grpStartPlace.ToList<OrganGrossProfitRateDetail>();

                        //最后按讫点分组
                        var grpDestPlaces = listStartPlaceDetail.GroupBy(d => d.ReceiverCity).OrderBy(d => d.Key);
                        foreach (var grpDestPlace in grpDestPlaces)
                        {
                            List<OrganGrossProfitRateDetail> listDestPlaceDetail = grpDestPlace.ToList<OrganGrossProfitRateDetail>();

                            //生成表格数据行
                            StatOrganGrossProfitRate s = new StatOrganGrossProfitRate();
                            s.Id = listStat.Count + 1;
                            s.OrganName = grpOrganName.Key;
                            s.StartTime = startTime;
                            s.EndTime = endTime;
                            s.StartPlace = grpStartPlace.Key;
                            s.DestPlace = grpDestPlace.Key;
                            s.TotalCarrierTransportCharges = listDestPlaceDetail.Sum(d => d.CarrierTransportCharges);
                            s.TotalCustomerTransportCharges = listDestPlaceDetail.Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                            s.TotalTransportChargesDifference = s.TotalCustomerTransportCharges - s.TotalCarrierTransportCharges;
                            s.TotalGrossProfitRate = s.TotalCustomerTransportCharges != 0 ? s.TotalTransportChargesDifference / s.TotalCustomerTransportCharges : 0;

                            listStat.Add(s);
                        }
                    }
                }
            }

            #endregion

            //提取当前页面数据
            int nTotalRows = listStat.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "OrganName") + " " + (sord ?? "ASC");
            var data = listStat.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from s in data
                      select new
                      {
                          id = s.Id,
                          cell = new string[] { 
                              s.Id.ToString(),
                              s.OrganName,
                              s.StartTime,
                              s.EndTime,
                              s.StartPlace,
                              s.DestPlace,
                              s.TotalCarrierTransportCharges.ToString(),
                              s.TotalCustomerTransportCharges.ToString(),
                              s.TotalTransportChargesDifference.ToString(),
                              s.TotalGrossProfitRate.ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    OrganName = InnoSoft.LS.Resources.Labels.Total,
                    TotalCarrierTransportCharges = data.Sum(s => s.TotalCarrierTransportCharges),
                    TotalCustomerTransportCharges = data.Sum(s => s.TotalCustomerTransportCharges),
                    TotalTransportChargesDifference = data.Sum(s => s.TotalTransportChargesDifference),
                    TotalGrossProfitRate = data.Sum(s => s.TotalCustomerTransportCharges) != 0 ? data.Sum(s => s.TotalTransportChargesDifference) / data.Sum(s => s.TotalCustomerTransportCharges) : 0
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 导出办事处毛利率数据
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportOrganGrossProfitRate()
        {
            string strErrText;

            #region 提取参数

            var request = HttpContext.Request;
            string strStartTime = request.QueryString["startTime"] ?? string.Empty;
            string strEndTime = request.QueryString["endTime"] ?? string.Empty;
            string strOrganId = request.QueryString["organId"] ?? string.Empty;

            #endregion

            #region 读取明细数据

            StatisticsSystem stat = new StatisticsSystem();
            List<OrganGrossProfitRateDetail> listDetail = stat.LoadOrganGrossProfitRateDetailsByConditions(strStartTime, strEndTime, strOrganId, LoginAccountId, LoginStaffName, out strErrText);
            if (listDetail == null)
            {
                throw new Exception(strErrText);
            }

            #endregion

            #region 根据结算公式计算运费
            {
                foreach (OrganGrossProfitRateDetail detail in listDetail)
                {
                    if (detail.CustomerTransportCharges == 0 && detail.CustomerSettlementExpression != null && detail.CustomerSettlementExpression != string.Empty)
                    {
                        try
                        {
                            EvaluatorHelper evaluator = new EvaluatorHelper();

                            evaluator.SetExpression(detail.CustomerSettlementExpression);

                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.KM, detail.KM == null || detail.KM == string.Empty ? "0" : detail.KM);
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Tunnages, detail.TotalTunnages.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Piles, detail.TotalPiles.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportPrice, detail.CustomerTransportPrice.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportCharges, "0");

                            string strTransportCharges = evaluator.EvaluateExpression();
                            detail.CustomerTransportCharges = decimal.Parse(strTransportCharges);
                        }
                        catch (Exception e)
                        {
                            throw e;
                        }
                    }
                }
            }
            #endregion

            #region 计算拼车费
            {
                var grpShipmentNos = listDetail.GroupBy(d => d.ShipmentNo).OrderBy(d => d.Key);
                foreach (var grpShipmentNo in grpShipmentNos)
                {
                    if (grpShipmentNo.Key != null && grpShipmentNo.Key != string.Empty)
                    {
                        List<OrganGrossProfitRateDetail> listShipmentNoDetail = grpShipmentNo.ToList<OrganGrossProfitRateDetail>();

                        int i = 0;
                        while (i < listShipmentNoDetail.Count)
                        {
                            if (i > 0)
                            {
                                int j = 0;
                                while (j < i)
                                {
                                    if (listShipmentNoDetail[i].ReceiverAddress == listShipmentNoDetail[j].ReceiverAddress)
                                    {
                                        break;
                                    }
                                    j++;
                                }
                                if (j >= i)
                                {
                                    listShipmentNoDetail[i].CustomerCarpoolFee = 100;
                                }
                            }
                            i++;
                        }
                    }
                }
            }
            #endregion

            #region 生成表格数据源

            List<StatOrganGrossProfitRate> listStat = new List<StatOrganGrossProfitRate>();
            {
                //按办事处分组
                var grpOrganNames = listDetail.GroupBy(d => d.OwnOrganName).OrderBy(d => d.Key);
                foreach (var grpOrganName in grpOrganNames)
                {
                    List<OrganGrossProfitRateDetail> listOrganNameDetail = grpOrganName.ToList<OrganGrossProfitRateDetail>();

                    //再按起点分组
                    var grpStartPlaces = listOrganNameDetail.GroupBy(d => d.StartCity).OrderBy(d => d.Key);
                    foreach (var grpStartPlace in grpStartPlaces)
                    {
                        List<OrganGrossProfitRateDetail> listStartPlaceDetail = grpStartPlace.ToList<OrganGrossProfitRateDetail>();

                        //最后按讫点分组
                        var grpDestPlaces = listStartPlaceDetail.GroupBy(d => d.ReceiverCity).OrderBy(d => d.Key);
                        foreach (var grpDestPlace in grpDestPlaces)
                        {
                            List<OrganGrossProfitRateDetail> listDestPlaceDetail = grpDestPlace.ToList<OrganGrossProfitRateDetail>();

                            //生成表格数据行
                            StatOrganGrossProfitRate s = new StatOrganGrossProfitRate();
                            s.Id = listStat.Count + 1;
                            s.OrganName = grpOrganName.Key;
                            s.StartTime = strStartTime;
                            s.EndTime = strEndTime;
                            s.StartPlace = grpStartPlace.Key;
                            s.DestPlace = grpDestPlace.Key;
                            s.TotalCarrierTransportCharges = listDestPlaceDetail.Sum(d => d.CarrierTransportCharges);
                            s.TotalCustomerTransportCharges = listDestPlaceDetail.Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                            s.TotalTransportChargesDifference = s.TotalCustomerTransportCharges - s.TotalCarrierTransportCharges;
                            s.TotalGrossProfitRate = s.TotalCustomerTransportCharges != 0 ? s.TotalTransportChargesDifference / s.TotalCustomerTransportCharges : 0;

                            listStat.Add(s);
                        }
                    }
                }
            }

            #endregion

            #region 输出Excel

            //生成GridView
            BoundField colOrganName = new BoundField();
            colOrganName.HeaderText = InnoSoft.LS.Resources.Labels.OrganName;
            colOrganName.DataField = "OrganName";

            BoundField colStartTime = new BoundField();
            colStartTime.HeaderText = InnoSoft.LS.Resources.Labels.StartTime;
            colStartTime.DataField = "StartTime";

            BoundField colEndTime = new BoundField();
            colEndTime.HeaderText = InnoSoft.LS.Resources.Labels.EndTime;
            colEndTime.DataField = "EndTime";

            BoundField colStartPlace = new BoundField();
            colStartPlace.HeaderText = InnoSoft.LS.Resources.Labels.StartPlace;
            colStartPlace.DataField = "StartPlace";

            BoundField colDestPlace = new BoundField();
            colDestPlace.HeaderText = InnoSoft.LS.Resources.Labels.DestPlace;
            colDestPlace.DataField = "DestPlace";

            BoundField colTotalCarrierTransportCharges = new BoundField();
            colTotalCarrierTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.TotalCarrierTransportCharges;
            colTotalCarrierTransportCharges.DataField = "TotalCarrierTransportCharges";

            BoundField colTotalCustomerTransportCharges = new BoundField();
            colTotalCustomerTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.TotalCustomerTransportCharges;
            colTotalCustomerTransportCharges.DataField = "TotalCustomerTransportCharges";

            BoundField colTotalTransportChargesDifference = new BoundField();
            colTotalTransportChargesDifference.HeaderText = InnoSoft.LS.Resources.Labels.TotalTransportChargesDifference;
            colTotalTransportChargesDifference.DataField = "TotalTransportChargesDifference";

            BoundField colTotalGrossProfitRate = new BoundField();
            colTotalGrossProfitRate.HeaderText = InnoSoft.LS.Resources.Labels.TotalGrossProfitRate;
            colTotalGrossProfitRate.DataField = "TotalGrossProfitRate";

            var grid = new GridView();
            grid.Columns.Add(colOrganName);
            grid.Columns.Add(colStartTime);
            grid.Columns.Add(colEndTime);
            grid.Columns.Add(colStartPlace);
            grid.Columns.Add(colDestPlace);
            grid.Columns.Add(colTotalCarrierTransportCharges);
            grid.Columns.Add(colTotalCustomerTransportCharges);
            grid.Columns.Add(colTotalTransportChargesDifference);
            grid.Columns.Add(colTotalGrossProfitRate);

            grid.AutoGenerateColumns = false;

            grid.RowDataBound += new GridViewRowEventHandler(OrganGrossProfitRateGrid_RowDataBound);
            grid.DataSource = from s in listStat
                              select new
                              {
                                  OrganName = s.OrganName,
                                  StartTime = s.StartTime,
                                  EndTime = s.EndTime,
                                  StartPlace = s.StartPlace,
                                  DestPlace = s.DestPlace,
                                  TotalCarrierTransportCharges = s.TotalCarrierTransportCharges != 0 ? s.TotalCarrierTransportCharges.ToString("N") : string.Empty,
                                  TotalCustomerTransportCharges = s.TotalCustomerTransportCharges != 0 ? s.TotalCustomerTransportCharges.ToString("N") : string.Empty,
                                  TotalTransportChargesDifference = s.TotalTransportChargesDifference != 0 ? s.TotalTransportChargesDifference.ToString("N") : string.Empty,
                                  TotalGrossProfitRate = s.TotalGrossProfitRate != 0 ? s.TotalGrossProfitRate.ToString("N") : string.Empty
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=OrganGrossProfitRate.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

            #endregion

            return View("StatOrganGrossProfitRate");
        }

        private void OrganGrossProfitRateGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[5].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费被自动转换为整形
                e.Row.Cells[6].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费被自动转换为整形
                e.Row.Cells[7].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止价差被自动转换为整形
            }
        }

        #endregion

        #region 统计客户总产值

        /// <summary>
        /// GET统计客户总产值页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult StatCustomerTotalOutput()
        {
            return View();
        }

        /// <summary>
        /// GET客户总产值表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="customerName"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadStatCustomerTotalOutputGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string customerName)
        {
            #region 读取明细数据

            string strErrText;
            StatisticsSystem stat = new StatisticsSystem();
            List<CustomerTotalOutputDetail> listDetail = stat.LoadCustomerTotalOutputDetailsByConditions(startTime, endTime, customerName, LoginAccountId, LoginStaffName, out strErrText);
            if (listDetail == null)
            {
                throw new Exception(strErrText);
            }

            #endregion

            #region 根据结算公式计算运费
            {
                foreach (CustomerTotalOutputDetail detail in listDetail)
                {
                    if (detail.CustomerTransportCharges == 0 && detail.CustomerSettlementExpression != null && detail.CustomerSettlementExpression != string.Empty)
                    {
                        try
                        {
                            EvaluatorHelper evaluator = new EvaluatorHelper();

                            evaluator.SetExpression(detail.CustomerSettlementExpression);

                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.KM, detail.KM == null || detail.KM == string.Empty ? "0" : detail.KM);
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Tunnages, detail.TotalTunnages.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Piles, detail.TotalPiles.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportPrice, detail.CustomerTransportPrice.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportCharges, "0");

                            string strTransportCharges = evaluator.EvaluateExpression();
                            detail.CustomerTransportCharges = decimal.Parse(strTransportCharges);
                        }
                        catch (Exception e)
                        {
                            throw e;
                        }
                    }
                }
            }
            #endregion

            #region 计算拼车费
            {
                var grpShipmentNos = listDetail.GroupBy(d => d.ShipmentNo).OrderBy(d => d.Key);
                foreach (var grpShipmentNo in grpShipmentNos)
                {
                    if (grpShipmentNo.Key != null && grpShipmentNo.Key != string.Empty)
                    {
                        List<CustomerTotalOutputDetail> listShipmentNoDetail = grpShipmentNo.ToList<CustomerTotalOutputDetail>();

                        int i = 0;
                        while (i < listShipmentNoDetail.Count)
                        {
                            if (i > 0)
                            {
                                int j = 0;
                                while (j < i)
                                {
                                    if (listShipmentNoDetail[i].ReceiverAddress == listShipmentNoDetail[j].ReceiverAddress)
                                    {
                                        break;
                                    }
                                    j++;
                                }
                                if (j >= i)
                                {
                                    listShipmentNoDetail[i].CustomerCarpoolFee = 100;
                                }
                            }
                            i++;
                        }
                    }
                }
            }
            #endregion

            #region 生成表格数据源

            List<StatCustomerTotalOutput> listStat = new List<StatCustomerTotalOutput>();
            {
                //按客户分组
                var grpCustomerNames = listDetail.GroupBy(d => d.CustomerName).OrderBy(d => d.Key);
                foreach (var grpCustomerName in grpCustomerNames)
                {
                    List<CustomerTotalOutputDetail> listCustomerNameDetail = grpCustomerName.ToList<CustomerTotalOutputDetail>();

                    //再按省份分组
                    var grpReceiverProvinces = listCustomerNameDetail.GroupBy(d => d.ReceiverProvince).OrderBy(d => d.Key);
                    foreach (var grpReceiverProvince in grpReceiverProvinces)
                    {
                        List<CustomerTotalOutputDetail> listReceiverProvinceDetail = grpReceiverProvince.ToList<CustomerTotalOutputDetail>();

                        //生成表格数据行
                        StatCustomerTotalOutput s = new StatCustomerTotalOutput();
                        s.Id = listStat.Count + 1;
                        s.CustomerName = grpCustomerName.Key;
                        s.ProvinceName = grpReceiverProvince.Key;

                        s.JoinInTunnages = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalTunnages);
                        s.SelfSupportTunnages = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalTunnages);
                        s.PrestowageTunnages = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalTunnages);
                        s.SubtotalTunnages = listReceiverProvinceDetail.Sum(d => d.TotalTunnages);

                        s.JoinInPiles = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalPiles);
                        s.SelfSupportPiles = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalPiles);
                        s.PrestowagePiles = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalPiles);
                        s.SubtotalPiles = listReceiverProvinceDetail.Sum(d => d.TotalPiles);

                        s.JoinInTransportCharges = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.SelfSupportTransportCharges = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.PrestowageTransportCharges = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.SubtotalTransportCharges = listReceiverProvinceDetail.Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);

                        s.JoinInTransportChargesDifference = s.JoinInTransportCharges - listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CarrierTransportCharges);
                        s.SelfSupportTransportChargesDifference = s.SelfSupportTransportCharges - listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CarrierTransportCharges);
                        s.PrestowageTransportChargesDifference = s.PrestowageTransportCharges - listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CarrierTransportCharges);
                        s.SubtotalTransportChargesDifference = s.SubtotalTransportCharges - listReceiverProvinceDetail.Sum(d => d.CarrierTransportCharges);

                        s.JoinInGrossProfitRate = s.JoinInTransportCharges != 0 ? s.JoinInTransportChargesDifference / s.JoinInTransportCharges : 0;
                        s.SelfSupportGrossProfitRate = s.SelfSupportTransportCharges != 0 ? s.SelfSupportTransportChargesDifference / s.SelfSupportTransportCharges : 0;
                        s.PrestowageGrossProfitRate = s.PrestowageTransportCharges != 0 ? s.PrestowageTransportChargesDifference / s.PrestowageTransportCharges : 0;
                        s.SubtotalGrossProfitRate = s.SubtotalTransportCharges != 0 ? s.SubtotalTransportChargesDifference / s.SubtotalTransportCharges : 0;

                        listStat.Add(s);
                    }
                }
            }

            #endregion

            //提取当前页面数据
            int nTotalRows = listStat.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "ProvinceName") + " " + (sord ?? "ASC");
            var data = listStat.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from s in data
                      select new
                      {
                          id = s.Id,
                          cell = new string[] { 
                              s.Id.ToString(),
                              s.CustomerName,
                              s.ProvinceName,
                              s.JoinInTunnages.ToString("#0.######"),
                              s.SelfSupportTunnages.ToString("#0.######"),
                              s.PrestowageTunnages.ToString("#0.######"),
                              s.SubtotalTunnages.ToString("#0.######"),
                              s.JoinInPiles.ToString("#0.######"),
                              s.SelfSupportPiles.ToString("#0.######"),
                              s.PrestowagePiles.ToString("#0.######"),
                              s.SubtotalPiles.ToString("#0.######"),
                              s.JoinInTransportCharges.ToString(),
                              s.SelfSupportTransportCharges.ToString(),
                              s.PrestowageTransportCharges.ToString(),
                              s.SubtotalTransportCharges.ToString(),
                              s.JoinInTransportChargesDifference.ToString(),
                              s.SelfSupportTransportChargesDifference.ToString(),
                              s.PrestowageTransportChargesDifference.ToString(),
                              s.SubtotalTransportChargesDifference.ToString(),
                              s.JoinInGrossProfitRate.ToString(),
                              s.SelfSupportGrossProfitRate.ToString(),
                              s.PrestowageGrossProfitRate.ToString(),
                              s.SubtotalGrossProfitRate.ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    CustomerName = InnoSoft.LS.Resources.Labels.Total,
                    JoinInTunnages = data.Sum(s => s.JoinInTunnages),
                    SelfSupportTunnages = data.Sum(s => s.SelfSupportTunnages),
                    PrestowageTunnages = data.Sum(s => s.PrestowageTunnages),
                    SubtotalTunnages = data.Sum(s => s.SubtotalTunnages),
                    JoinInPiles = data.Sum(s => s.JoinInPiles),
                    SelfSupportPiles = data.Sum(s => s.SelfSupportPiles),
                    PrestowagePiles = data.Sum(s => s.PrestowagePiles),
                    SubtotalPiles = data.Sum(s => s.SubtotalPiles),
                    JoinInTransportCharges = data.Sum(s => s.JoinInTransportCharges),
                    SelfSupportTransportCharges = data.Sum(s => s.SelfSupportTransportCharges),
                    PrestowageTransportCharges = data.Sum(s => s.PrestowageTransportCharges),
                    SubtotalTransportCharges = data.Sum(s => s.SubtotalTransportCharges),
                    JoinInTransportChargesDifference = data.Sum(s => s.JoinInTransportChargesDifference),
                    SelfSupportTransportChargesDifference = data.Sum(s => s.SelfSupportTransportChargesDifference),
                    PrestowageTransportChargesDifference = data.Sum(s => s.PrestowageTransportChargesDifference),
                    SubtotalTransportChargesDifference = data.Sum(s => s.SubtotalTransportChargesDifference),
                    JoinInGrossProfitRate = data.Sum(s => s.JoinInTransportCharges) != 0 ? data.Sum(s => s.JoinInTransportChargesDifference) / data.Sum(s => s.JoinInTransportCharges) : 0,
                    SelfSupportGrossProfitRate = data.Sum(s => s.SelfSupportTransportCharges) != 0 ? data.Sum(s => s.SelfSupportTransportChargesDifference) / data.Sum(s => s.SelfSupportTransportCharges) : 0,
                    PrestowageGrossProfitRate = data.Sum(s => s.PrestowageTransportCharges) != 0 ? data.Sum(s => s.PrestowageTransportChargesDifference) / data.Sum(s => s.PrestowageTransportCharges) : 0,
                    SubtotalGrossProfitRate = data.Sum(s => s.SubtotalTransportCharges) != 0 ? data.Sum(s => s.SubtotalTransportChargesDifference) / data.Sum(s => s.SubtotalTransportCharges) : 0
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET导出客户总产值数据
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportCustomerTotalOutput()
        {
            string strErrText;

            #region 提取参数

            var request = HttpContext.Request;
            string strStartTime = request.QueryString["startTime"] ?? string.Empty;
            string strEndTime = request.QueryString["endTime"] ?? string.Empty;
            string strCustomerName = request.QueryString["customerName"] ?? string.Empty;

            #endregion

            #region 读取明细数据

            StatisticsSystem stat = new StatisticsSystem();
            List<CustomerTotalOutputDetail> listDetail = stat.LoadCustomerTotalOutputDetailsByConditions(strStartTime, strEndTime, strCustomerName, LoginAccountId, LoginStaffName, out strErrText);
            if (listDetail == null)
            {
                throw new Exception(strErrText);
            }

            #endregion

            #region 根据结算公式计算运费
            {
                foreach (CustomerTotalOutputDetail detail in listDetail)
                {
                    if (detail.CustomerTransportCharges == 0 && detail.CustomerSettlementExpression != null && detail.CustomerSettlementExpression != string.Empty)
                    {
                        try
                        {
                            EvaluatorHelper evaluator = new EvaluatorHelper();

                            evaluator.SetExpression(detail.CustomerSettlementExpression);

                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.KM, detail.KM == null || detail.KM == string.Empty ? "0" : detail.KM);
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Tunnages, detail.TotalTunnages.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Piles, detail.TotalPiles.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportPrice, detail.CustomerTransportPrice.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportCharges, "0");

                            string strTransportCharges = evaluator.EvaluateExpression();
                            detail.CustomerTransportCharges = decimal.Parse(strTransportCharges);
                        }
                        catch (Exception e)
                        {
                            throw e;
                        }
                    }
                }
            }
            #endregion

            #region 计算拼车费
            {
                var grpShipmentNos = listDetail.GroupBy(d => d.ShipmentNo).OrderBy(d => d.Key);
                foreach (var grpShipmentNo in grpShipmentNos)
                {
                    if (grpShipmentNo.Key != null && grpShipmentNo.Key != string.Empty)
                    {
                        List<CustomerTotalOutputDetail> listShipmentNoDetail = grpShipmentNo.ToList<CustomerTotalOutputDetail>();

                        int i = 0;
                        while (i < listShipmentNoDetail.Count)
                        {
                            if (i > 0)
                            {
                                int j = 0;
                                while (j < i)
                                {
                                    if (listShipmentNoDetail[i].ReceiverAddress == listShipmentNoDetail[j].ReceiverAddress)
                                    {
                                        break;
                                    }
                                    j++;
                                }
                                if (j >= i)
                                {
                                    listShipmentNoDetail[i].CustomerCarpoolFee = 100;
                                }
                            }
                            i++;
                        }
                    }
                }
            }
            #endregion

            #region 生成表格数据源

            List<StatCustomerTotalOutput> listStat = new List<StatCustomerTotalOutput>();
            {
                //按客户名称分组
                var grpCustomerNames = listDetail.GroupBy(d => d.CustomerName).OrderBy(d => d.Key);
                foreach (var grpCustomerName in grpCustomerNames)
                {
                    List<CustomerTotalOutputDetail> listCustomerNameDetail = grpCustomerName.ToList<CustomerTotalOutputDetail>();

                    //再按省份分组
                    var grpReceiverProvinces = listCustomerNameDetail.GroupBy(d => d.ReceiverProvince).OrderBy(d => d.Key);
                    foreach (var grpReceiverProvince in grpReceiverProvinces)
                    {
                        List<CustomerTotalOutputDetail> listReceiverProvinceDetail = grpReceiverProvince.ToList<CustomerTotalOutputDetail>();

                        //生成表格数据行
                        StatCustomerTotalOutput s = new StatCustomerTotalOutput();
                        s.Id = listStat.Count + 1;
                        s.CustomerName = grpCustomerName.Key;
                        s.ProvinceName = grpReceiverProvince.Key;

                        s.JoinInTunnages = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalTunnages);
                        s.SelfSupportTunnages = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalTunnages);
                        s.PrestowageTunnages = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalTunnages);
                        s.SubtotalTunnages = listReceiverProvinceDetail.Sum(d => d.TotalTunnages);

                        s.JoinInPiles = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalPiles);
                        s.SelfSupportPiles = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalPiles);
                        s.PrestowagePiles = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalPiles);
                        s.SubtotalPiles = listReceiverProvinceDetail.Sum(d => d.TotalPiles);

                        s.JoinInTransportCharges = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.SelfSupportTransportCharges = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.PrestowageTransportCharges = listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.SubtotalTransportCharges = listReceiverProvinceDetail.Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);

                        s.JoinInTransportChargesDifference = s.JoinInTransportCharges - listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CarrierTransportCharges);
                        s.SelfSupportTransportChargesDifference = s.SelfSupportTransportCharges - listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CarrierTransportCharges);
                        s.PrestowageTransportChargesDifference = s.PrestowageTransportCharges - listReceiverProvinceDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CarrierTransportCharges);
                        s.SubtotalTransportChargesDifference = s.SubtotalTransportCharges - listReceiverProvinceDetail.Sum(d => d.CarrierTransportCharges);

                        s.JoinInGrossProfitRate = s.JoinInTransportCharges != 0 ? s.JoinInTransportChargesDifference / s.JoinInTransportCharges : 0;
                        s.SelfSupportGrossProfitRate = s.SelfSupportTransportCharges != 0 ? s.SelfSupportTransportChargesDifference / s.SelfSupportTransportCharges : 0;
                        s.PrestowageGrossProfitRate = s.PrestowageTransportCharges != 0 ? s.PrestowageTransportChargesDifference / s.PrestowageTransportCharges : 0;
                        s.SubtotalGrossProfitRate = s.SubtotalTransportCharges != 0 ? s.SubtotalTransportChargesDifference / s.SubtotalTransportCharges : 0;

                        listStat.Add(s);
                    }
                    //小计
                    {
                        StatCustomerTotalOutput s = new StatCustomerTotalOutput();
                        s.Id = listStat.Count + 1;
                        s.CustomerName = InnoSoft.LS.Resources.Labels.Subtotal;
                        s.ProvinceName = string.Empty;

                        s.JoinInTunnages = listCustomerNameDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalTunnages);
                        s.SelfSupportTunnages = listCustomerNameDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalTunnages);
                        s.PrestowageTunnages = listCustomerNameDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalTunnages);
                        s.SubtotalTunnages = listCustomerNameDetail.Sum(d => d.TotalTunnages);

                        s.JoinInPiles = listCustomerNameDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalPiles);
                        s.SelfSupportPiles = listCustomerNameDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalPiles);
                        s.PrestowagePiles = listCustomerNameDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalPiles);
                        s.SubtotalPiles = listCustomerNameDetail.Sum(d => d.TotalPiles);

                        s.JoinInTransportCharges = listCustomerNameDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.SelfSupportTransportCharges = listCustomerNameDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.PrestowageTransportCharges = listCustomerNameDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                        s.SubtotalTransportCharges = listCustomerNameDetail.Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);

                        s.JoinInTransportChargesDifference = s.JoinInTransportCharges - listCustomerNameDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CarrierTransportCharges);
                        s.SelfSupportTransportChargesDifference = s.SelfSupportTransportCharges - listCustomerNameDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CarrierTransportCharges);
                        s.PrestowageTransportChargesDifference = s.PrestowageTransportCharges - listCustomerNameDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CarrierTransportCharges);
                        s.SubtotalTransportChargesDifference = s.SubtotalTransportCharges - listCustomerNameDetail.Sum(d => d.CarrierTransportCharges);

                        s.JoinInGrossProfitRate = s.JoinInTransportCharges != 0 ? s.JoinInTransportChargesDifference / s.JoinInTransportCharges : 0;
                        s.SelfSupportGrossProfitRate = s.SelfSupportTransportCharges != 0 ? s.SelfSupportTransportChargesDifference / s.SelfSupportTransportCharges : 0;
                        s.PrestowageGrossProfitRate = s.PrestowageTransportCharges != 0 ? s.PrestowageTransportChargesDifference / s.PrestowageTransportCharges : 0;
                        s.SubtotalGrossProfitRate = s.SubtotalTransportCharges != 0 ? s.SubtotalTransportChargesDifference / s.SubtotalTransportCharges : 0;

                        listStat.Add(s);
                    }
                }
                //总计
                {
                    StatCustomerTotalOutput s = new StatCustomerTotalOutput();
                    s.Id = listStat.Count + 1;
                    s.CustomerName = InnoSoft.LS.Resources.Labels.Total;
                    s.ProvinceName = string.Empty;

                    s.JoinInTunnages = listDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalTunnages);
                    s.SelfSupportTunnages = listDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalTunnages);
                    s.PrestowageTunnages = listDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalTunnages);
                    s.SubtotalTunnages = listDetail.Sum(d => d.TotalTunnages);

                    s.JoinInPiles = listDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.TotalPiles);
                    s.SelfSupportPiles = listDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.TotalPiles);
                    s.PrestowagePiles = listDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.TotalPiles);
                    s.SubtotalPiles = listDetail.Sum(d => d.TotalPiles);

                    s.JoinInTransportCharges = listDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                    s.SelfSupportTransportCharges = listDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                    s.PrestowageTransportCharges = listDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);
                    s.SubtotalTransportCharges = listDetail.Sum(d => d.CustomerTransportCharges + d.CustomerCarpoolFee + d.CustomerRiverCrossingCharges);

                    s.JoinInTransportChargesDifference = s.JoinInTransportCharges - listDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.JoinIn; }).Sum(d => d.CarrierTransportCharges);
                    s.SelfSupportTransportChargesDifference = s.SelfSupportTransportCharges - listDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.SelfSupport; }).Sum(d => d.CarrierTransportCharges);
                    s.PrestowageTransportChargesDifference = s.PrestowageTransportCharges - listDetail.FindAll(delegate(CustomerTotalOutputDetail d) { return d.CarrierBusinessType == InnoSoft.LS.Resources.Options.Prestowage; }).Sum(d => d.CarrierTransportCharges);
                    s.SubtotalTransportChargesDifference = s.SubtotalTransportCharges - listDetail.Sum(d => d.CarrierTransportCharges);

                    s.JoinInGrossProfitRate = s.JoinInTransportCharges != 0 ? s.JoinInTransportChargesDifference / s.JoinInTransportCharges : 0;
                    s.SelfSupportGrossProfitRate = s.SelfSupportTransportCharges != 0 ? s.SelfSupportTransportChargesDifference / s.SelfSupportTransportCharges : 0;
                    s.PrestowageGrossProfitRate = s.PrestowageTransportCharges != 0 ? s.PrestowageTransportChargesDifference / s.PrestowageTransportCharges : 0;
                    s.SubtotalGrossProfitRate = s.SubtotalTransportCharges != 0 ? s.SubtotalTransportChargesDifference / s.SubtotalTransportCharges : 0;

                    listStat.Add(s);
                }
            }

            #endregion

            #region 输出Excel

            //生成GridView
            BoundField colCustomerName = new BoundField();
            colCustomerName.HeaderText = InnoSoft.LS.Resources.Labels.CustomerName;
            colCustomerName.DataField = "CustomerName";

            BoundField colProvinceName = new BoundField();
            colProvinceName.HeaderText = InnoSoft.LS.Resources.Labels.StateName;
            colProvinceName.DataField = "ProvinceName";

            BoundField colJoinInTunnages = new BoundField();
            colJoinInTunnages.HeaderText = InnoSoft.LS.Resources.Labels.JoinIn + "-" + InnoSoft.LS.Resources.Labels.Tunnages;
            colJoinInTunnages.DataField = "JoinInTunnages";

            BoundField colSelfSupportTunnages = new BoundField();
            colSelfSupportTunnages.HeaderText = InnoSoft.LS.Resources.Labels.SelfSupport + "-" + InnoSoft.LS.Resources.Labels.Tunnages;
            colSelfSupportTunnages.DataField = "SelfSupportTunnages";

            BoundField colPrestowageTunnages = new BoundField();
            colPrestowageTunnages.HeaderText = InnoSoft.LS.Resources.Labels.Prestowage + "-" + InnoSoft.LS.Resources.Labels.Tunnages;
            colPrestowageTunnages.DataField = "PrestowageTunnages";

            BoundField colSubtotalTunnages = new BoundField();
            colSubtotalTunnages.HeaderText = InnoSoft.LS.Resources.Labels.Subtotal + "-" + InnoSoft.LS.Resources.Labels.Tunnages;
            colSubtotalTunnages.DataField = "SubtotalTunnages";

            BoundField colJoinInPiles = new BoundField();
            colJoinInPiles.HeaderText = InnoSoft.LS.Resources.Labels.JoinIn + "-" + InnoSoft.LS.Resources.Labels.Piles;
            colJoinInPiles.DataField = "JoinInPiles";

            BoundField colSelfSupportPiles = new BoundField();
            colSelfSupportPiles.HeaderText = InnoSoft.LS.Resources.Labels.SelfSupport + "-" + InnoSoft.LS.Resources.Labels.Piles;
            colSelfSupportPiles.DataField = "SelfSupportPiles";

            BoundField colPrestowagePiles = new BoundField();
            colPrestowagePiles.HeaderText = InnoSoft.LS.Resources.Labels.Prestowage + "-" + InnoSoft.LS.Resources.Labels.Piles;
            colPrestowagePiles.DataField = "PrestowagePiles";

            BoundField colSubtotalPiles = new BoundField();
            colSubtotalPiles.HeaderText = InnoSoft.LS.Resources.Labels.Subtotal + "-" + InnoSoft.LS.Resources.Labels.Piles;
            colSubtotalPiles.DataField = "SubtotalPiles";

            BoundField colJoinInTransportCharges = new BoundField();
            colJoinInTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.JoinIn + "-" + InnoSoft.LS.Resources.Labels.TransportCharges;
            colJoinInTransportCharges.DataField = "JoinInTransportCharges";

            BoundField colSelfSupportTransportCharges = new BoundField();
            colSelfSupportTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.SelfSupport + "-" + InnoSoft.LS.Resources.Labels.TransportCharges;
            colSelfSupportTransportCharges.DataField = "SelfSupportTransportCharges";

            BoundField colPrestowageTransportCharges = new BoundField();
            colPrestowageTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.Prestowage + "-" + InnoSoft.LS.Resources.Labels.TransportCharges;
            colPrestowageTransportCharges.DataField = "PrestowageTransportCharges";

            BoundField colSubtotalTransportCharges = new BoundField();
            colSubtotalTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.Subtotal + "-" + InnoSoft.LS.Resources.Labels.TransportCharges;
            colSubtotalTransportCharges.DataField = "SubtotalTransportCharges";

            BoundField colJoinInTransportChargesDifference = new BoundField();
            colJoinInTransportChargesDifference.HeaderText = InnoSoft.LS.Resources.Labels.JoinIn + "-" + InnoSoft.LS.Resources.Labels.TransportChargesDifference;
            colJoinInTransportChargesDifference.DataField = "JoinInTransportChargesDifference";

            BoundField colSelfSupportTransportChargesDifference = new BoundField();
            colSelfSupportTransportChargesDifference.HeaderText = InnoSoft.LS.Resources.Labels.SelfSupport + "-" + InnoSoft.LS.Resources.Labels.TransportChargesDifference;
            colSelfSupportTransportChargesDifference.DataField = "SelfSupportTransportChargesDifference";

            BoundField colPrestowageTransportChargesDifference = new BoundField();
            colPrestowageTransportChargesDifference.HeaderText = InnoSoft.LS.Resources.Labels.Prestowage + "-" + InnoSoft.LS.Resources.Labels.TransportChargesDifference;
            colPrestowageTransportChargesDifference.DataField = "PrestowageTransportChargesDifference";

            BoundField colSubtotalTransportChargesDifference = new BoundField();
            colSubtotalTransportChargesDifference.HeaderText = InnoSoft.LS.Resources.Labels.Subtotal + "-" + InnoSoft.LS.Resources.Labels.TransportChargesDifference;
            colSubtotalTransportChargesDifference.DataField = "SubtotalTransportChargesDifference";

            BoundField colJoinInGrossProfitRate = new BoundField();
            colJoinInGrossProfitRate.HeaderText = InnoSoft.LS.Resources.Labels.JoinIn + "-" + InnoSoft.LS.Resources.Labels.GrossProfitRate;
            colJoinInGrossProfitRate.DataField = "JoinInGrossProfitRate";

            BoundField colSelfSupportGrossProfitRate = new BoundField();
            colSelfSupportGrossProfitRate.HeaderText = InnoSoft.LS.Resources.Labels.SelfSupport + "-" + InnoSoft.LS.Resources.Labels.GrossProfitRate;
            colSelfSupportGrossProfitRate.DataField = "SelfSupportGrossProfitRate";

            BoundField colPrestowageGrossProfitRate = new BoundField();
            colPrestowageGrossProfitRate.HeaderText = InnoSoft.LS.Resources.Labels.Prestowage + "-" + InnoSoft.LS.Resources.Labels.GrossProfitRate;
            colPrestowageGrossProfitRate.DataField = "PrestowageGrossProfitRate";

            BoundField colSubtotalGrossProfitRate = new BoundField();
            colSubtotalGrossProfitRate.HeaderText = InnoSoft.LS.Resources.Labels.Subtotal + "-" + InnoSoft.LS.Resources.Labels.GrossProfitRate;
            colSubtotalGrossProfitRate.DataField = "SubtotalGrossProfitRate";

            var grid = new GridView();
            grid.Columns.Add(colCustomerName);
            grid.Columns.Add(colProvinceName);
            grid.Columns.Add(colJoinInTunnages);
            grid.Columns.Add(colSelfSupportTunnages);
            grid.Columns.Add(colPrestowageTunnages);
            grid.Columns.Add(colSubtotalTunnages);
            grid.Columns.Add(colJoinInPiles);
            grid.Columns.Add(colSelfSupportPiles);
            grid.Columns.Add(colPrestowagePiles);
            grid.Columns.Add(colSubtotalPiles);
            grid.Columns.Add(colJoinInTransportCharges);
            grid.Columns.Add(colSelfSupportTransportCharges);
            grid.Columns.Add(colPrestowageTransportCharges);
            grid.Columns.Add(colSubtotalTransportCharges);
            grid.Columns.Add(colJoinInTransportChargesDifference);
            grid.Columns.Add(colSelfSupportTransportChargesDifference);
            grid.Columns.Add(colPrestowageTransportChargesDifference);
            grid.Columns.Add(colSubtotalTransportChargesDifference);
            grid.Columns.Add(colJoinInGrossProfitRate);
            grid.Columns.Add(colSelfSupportGrossProfitRate);
            grid.Columns.Add(colPrestowageGrossProfitRate);
            grid.Columns.Add(colSubtotalGrossProfitRate);

            grid.AutoGenerateColumns = false;

            grid.RowDataBound += new GridViewRowEventHandler(CustomerTotalOutputGrid_RowDataBound);
            grid.DataSource = from s in listStat
                              select new
                              {
                                  CustomerName = s.CustomerName,
                                  ProvinceName = s.ProvinceName,
                                  JoinInTunnages = s.JoinInTunnages != 0 ? s.JoinInTunnages.ToString("#0.######") : string.Empty,
                                  SelfSupportTunnages = s.SelfSupportTunnages != 0 ? s.SelfSupportTunnages.ToString("#0.######") : string.Empty,
                                  PrestowageTunnages = s.PrestowageTunnages != 0 ? s.PrestowageTunnages.ToString("#0.######") : string.Empty,
                                  SubtotalTunnages = s.SubtotalTunnages != 0 ? s.SubtotalTunnages.ToString("#0.######") : string.Empty,
                                  JoinInPiles = s.JoinInPiles != 0 ? s.JoinInPiles.ToString("#0.######") : string.Empty,
                                  SelfSupportPiles = s.SelfSupportPiles != 0 ? s.SelfSupportPiles.ToString("#0.######") : string.Empty,
                                  PrestowagePiles = s.PrestowagePiles != 0 ? s.PrestowagePiles.ToString("#0.######") : string.Empty,
                                  SubtotalPiles = s.SubtotalPiles != 0 ? s.SubtotalPiles.ToString("#0.######") : string.Empty,
                                  JoinInTransportCharges = s.JoinInTransportCharges != 0 ? s.JoinInTransportCharges.ToString("N") : string.Empty,
                                  SelfSupportTransportCharges = s.SelfSupportTransportCharges != 0 ? s.SelfSupportTransportCharges.ToString("N") : string.Empty,
                                  PrestowageTransportCharges = s.PrestowageTransportCharges != 0 ? s.PrestowageTransportCharges.ToString("N") : string.Empty,
                                  SubtotalTransportCharges = s.SubtotalTransportCharges != 0 ? s.SubtotalTransportCharges.ToString("N") : string.Empty,
                                  JoinInTransportChargesDifference = s.JoinInTransportChargesDifference != 0 ? s.JoinInTransportChargesDifference.ToString("N") : string.Empty,
                                  SelfSupportTransportChargesDifference = s.SelfSupportTransportChargesDifference != 0 ? s.SelfSupportTransportChargesDifference.ToString("N") : string.Empty,
                                  PrestowageTransportChargesDifference = s.PrestowageTransportChargesDifference != 0 ? s.PrestowageTransportChargesDifference.ToString("N") : string.Empty,
                                  SubtotalTransportChargesDifference = s.SubtotalTransportChargesDifference != 0 ? s.SubtotalTransportChargesDifference.ToString("N") : string.Empty,
                                  JoinInGrossProfitRate = s.JoinInGrossProfitRate != 0 ? s.JoinInGrossProfitRate.ToString("N") : string.Empty,
                                  SelfSupportGrossProfitRate = s.SelfSupportGrossProfitRate != 0 ? s.SelfSupportGrossProfitRate.ToString("N") : string.Empty,
                                  PrestowageGrossProfitRate = s.PrestowageGrossProfitRate != 0 ? s.PrestowageGrossProfitRate.ToString("N") : string.Empty,
                                  SubtotalGrossProfitRate = s.SubtotalGrossProfitRate != 0 ? s.SubtotalGrossProfitRate.ToString("N") : string.Empty
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=CustomerTotalOutput.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

            #endregion

            return View("StatCustomerTotalOutput");
        }

        private void CustomerTotalOutputGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[10].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费被自动转换为整形
                e.Row.Cells[11].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费被自动转换为整形
                e.Row.Cells[12].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费被自动转换为整形
                e.Row.Cells[13].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费被自动转换为整形
                e.Row.Cells[14].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止价差被自动转换为整形
                e.Row.Cells[15].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止价差被自动转换为整形
                e.Row.Cells[16].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止价差被自动转换为整形
                e.Row.Cells[17].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止价差被自动转换为整形
            }
        }

        #endregion

        #region 综合查询

        /// <summary>
        /// GET综合查询页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SyntheticalSearch()
        {
            string strErrText;

            //生成空的付款单位下拉列表项
            List<SelectListItem> selectListPayer = new List<SelectListItem>();
            selectListPayer.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            ViewData["Customers"] = new SelectList(selectListPayer, "Value", "Text");

            //生成国家下拉列表项
            DDSystem dd = new DDSystem();
            List<Country> listCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListCountry = new List<SelectListItem>();
            selectListCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListCountry.AddRange(from c in listCountry
                                       select new SelectListItem
                                       {
                                           Text = c.Name,
                                           Value = c.Name
                                       });
            ViewData["Countrys"] = new SelectList(selectListCountry, "Value", "Text");

            //生成空的省份下拉列表项
            List<Province> listState = new List<Province>();
            List<SelectListItem> selectListState = new List<SelectListItem>();
            selectListState.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListState.AddRange(from s in listState
                                     select new SelectListItem
                                     {
                                         Text = s.Name,
                                         Value = s.Name
                                     });
            ViewData["Provinces"] = new SelectList(selectListState, "Value", "Text");

            //生成空的城市下拉列表项
            List<City> listCity = new List<City>();
            List<SelectListItem> selectListCity = new List<SelectListItem>();
            selectListCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListCity.AddRange(from ci in listCity
                                    select new SelectListItem
                                    {
                                        Text = ci.Name,
                                        Value = ci.Name
                                    });
            ViewData["Citys"] = new SelectList(selectListCity, "Value", "Text");

            //生成空的组织部门下拉列表项
            List<SelectListItem> selectListOrganization = new List<SelectListItem>();
            selectListOrganization.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            ViewData["Organizations"] = new SelectList(selectListOrganization, "Value", "Text");

            return View();
        }

        /// <summary>
        /// GET综合查询表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="payerName"></param>
        /// <param name="startCountry"></param>
        /// <param name="startProvince"></param>
        /// <param name="startCity"></param>
        /// <param name="destCountry"></param>
        /// <param name="destProvince"></param>
        /// <param name="destCity"></param>
        /// <param name="carNo"></param>
        /// <param name="organId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSyntheticalSearchGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string payerName, string startCountry, string startProvince, string startCity, string destCountry, string destProvince, string destCity, string carNo, string organId)
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<DeliverBill> listBill = deliver.LoadDeliverBillsByConditions(startTime, endTime, string.Empty, string.Empty, payerName, startCountry, startProvince, startCity, destCountry, destProvince, destCity, carNo, string.Empty, organId, string.Empty, LoginAccountId, LoginStaffName, out strErrText);
            if (listBill == null)
            {
                throw new Exception(strErrText);
            }

            //根据结算公式计算运费
            foreach (DeliverBill bill in listBill)
            {
                if (bill.CustomerTransportCharges == 0 && bill.SettlementExpression != null && bill.SettlementExpression != string.Empty)
                {
                    try
                    {
                        EvaluatorHelper evaluator = new EvaluatorHelper();

                        evaluator.SetExpression(bill.SettlementExpression);

                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.KM, bill.KM == null || bill.KM == string.Empty ? "0" : bill.KM);
                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Tunnages, bill.TotalTunnages.ToString());
                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Piles, bill.TotalPiles.ToString());
                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportPrice, bill.CustomerTransportPrice.ToString());
                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportCharges, "0");

                        string strTransportCharges = evaluator.EvaluateExpression();
                        bill.CustomerTransportCharges = decimal.Parse(strTransportCharges);
                    }
                    catch (Exception e)
                    {
                        throw e;
                    }
                }
            }

            //计算拼车费
            var grpShipmentNos = listBill.GroupBy(s => s.ShipmentNo).OrderBy(s => s.Key);
            foreach (var grpShipmentNo in grpShipmentNos)
            {
                if (grpShipmentNo.Key != null && grpShipmentNo.Key != string.Empty)
                {
                    List<DeliverBill> listShipmentNoDetail = grpShipmentNo.ToList<DeliverBill>();

                    int i = 0;
                    while (i < listShipmentNoDetail.Count)
                    {
                        if (i > 0)
                        {
                            int j = 0;
                            while (j < i)
                            {
                                if (listShipmentNoDetail[i].ReceiverAddress == listShipmentNoDetail[j].ReceiverAddress)
                                {
                                    break;
                                }
                                j++;
                            }
                            if (j >= i)
                            {
                                listShipmentNoDetail[i].CarpoolFee = 100;
                            }
                        }
                        i++;
                    }
                }
            }

            //提取当前页面数据
            int nTotalRows = listBill.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listBill.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from b in data
                      select new
                      {
                          id = b.Id,
                          cell = new string[] { 
                              b.Id.ToString(),
                              b.ShipmentBillId.ToString(),
                              b.PlanId.ToString(),
                              b.CreateTime.ToString("yyyy-MM-dd"),
                              b.PlanNo,
                              b.CustomerName,
                              b.PayerId.ToString(),
                              b.PayerName,
                              b.ShipmentNo,
                              b.DeliveryNo,
                              b.ReceiverName,
                              b.ReceiverCountry + b.ReceiverProvince + b.ReceiverCity + b.ReceiverAddress,
                              b.StartCity,
                              b.ReceiverCity,
                              b.ReceiveType,
                              b.GoodsName,
                              b.TotalPackages.ToString(),
                              b.TotalTunnages.ToString("#0.######"),
                              b.TotalPiles.ToString("#0.######"),
                              b.TotalTenThousands.ToString("#0.######"),
                              b.CarNo,
                              b.TrailerNo,
                              b.CarType,
                              b.BillNo,
                              b.ContractId.ToString(),
                              b.ContractNo,
                              b.OriginalContractNo,
                              b.TransportCharges.ToString(),
                              (b.CustomerTransportCharges + b.CarpoolFee + b.RiverCrossingCharges).ToString(),
                              (b.CustomerTransportCharges + b.CarpoolFee + b.RiverCrossingCharges - b.TransportCharges).ToString(),
                              b.IsCustomerTransportChargesSettled.ToString(),
                              b.IsCarrierTransportChargesSettled.ToString(),
                              b.IsDeliverBillReceiptReceived.ToString(),
                              b.IsDeliverBillReceiptReceived ? b.ReturnTime.ToString("yyyy-MM-dd") : string.Empty,
                              b.ReverseAmount.ToString(),
                              b.TransportChargesBalance.ToString(),
                              b.Remark
                          }
                      }).ToArray(),
                userdata = new
                {
                    CreateTime = InnoSoft.LS.Resources.Labels.Total,
                    TotalPackages = data.Sum(s => s.TotalPackages),
                    TotalTunnages = data.Sum(s => s.TotalTunnages),
                    TotalPiles = data.Sum(s => s.TotalPiles),
                    TotalTenThousands = data.Sum(s => s.TotalTenThousands),
                    TransportCharges = data.Sum(s => s.TransportCharges),
                    CustomerTransportCharges = data.Sum(s => s.CustomerTransportCharges + s.CarpoolFee + s.RiverCrossingCharges),
                    TransportChargesDifference = data.Sum(s => s.CustomerTransportCharges + s.CarpoolFee + s.RiverCrossingCharges - s.TransportCharges),
                    ReverseAmount = data.Sum(s => s.ReverseAmount),
                    TransportChargesBalance = data.Sum(s => s.TransportChargesBalance)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST修改综合查询数据
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult SyntheticalSearchModifyData(SyntheticalSearchModifyViewModel model)
        {
            if (ModelState.IsValid)
            {
                //保存数据
                string strErrText;
                StatisticsSystem stat = new StatisticsSystem();
                if (stat.SyntheticalSearchModifyData(model.PlanId, model.ShipmentNo, model.DeliveryNo, model.PayerId, model.PayerName, model.ContractId, model.OriginalContractNo, LoginAccountId, LoginStaffName, out strErrText))
                {
                    return Json(string.Empty);
                }
                else
                {
                    return Json(strErrText);
                }
            }
            return View(model);
        }

        /// <summary>
        /// 导出综合查询表格
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportSyntheticalSearch()
        {
            string strErrText;

            #region 提取参数

            var request = HttpContext.Request;
            string strStartTime = request.QueryString["startTime"] ?? string.Empty;
            string strEndTime = request.QueryString["endTime"] ?? string.Empty;
            string strPayerName = request.QueryString["payerName"] ?? string.Empty;
            string strStartCountry = request.QueryString["startCountry"] ?? string.Empty;
            string strStartProvince = request.QueryString["startProvince"] ?? string.Empty;
            string strStartCity = request.QueryString["startCity"] ?? string.Empty;
            string strDestCountry = request.QueryString["destCountry"] ?? string.Empty;
            string strDestProvince = request.QueryString["destProvince"] ?? string.Empty;
            string strDestCity = request.QueryString["destCity"] ?? string.Empty;
            string strCarNo = request.QueryString["carNo"] ?? string.Empty;
            string strOrganId = request.QueryString["organId"] ?? string.Empty;

            #endregion

            #region 读取明细数据

            DeliverSystem deliver = new DeliverSystem();
            List<DeliverBill> listBill = deliver.LoadDeliverBillsByConditions(strStartTime, strEndTime, string.Empty, string.Empty, strPayerName, strStartCountry, strStartProvince, strStartCity, strDestCountry, strDestProvince, strDestCity, strCarNo, string.Empty, strOrganId, string.Empty, LoginAccountId, LoginStaffName, out strErrText);
            if (listBill == null)
            {
                throw new Exception(strErrText);
            }

            #endregion

            #region 根据结算公式计算运费
            {
                foreach (DeliverBill bill in listBill)
                {
                    if (bill.CustomerTransportCharges == 0 && bill.SettlementExpression != null && bill.SettlementExpression != string.Empty)
                    {
                        try
                        {
                            EvaluatorHelper evaluator = new EvaluatorHelper();

                            evaluator.SetExpression(bill.SettlementExpression);

                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.KM, bill.KM == null || bill.KM == string.Empty ? "0" : bill.KM);
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Tunnages, bill.TotalTunnages.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Piles, bill.TotalPiles.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportPrice, bill.CustomerTransportPrice.ToString());
                            evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportCharges, "0");

                            string strTransportCharges = evaluator.EvaluateExpression();
                            bill.CustomerTransportCharges = decimal.Parse(strTransportCharges);
                        }
                        catch (Exception e)
                        {
                            throw e;
                        }
                    }
                }
            }
            #endregion

            #region 计算拼车费
            {
                var grpShipmentNos = listBill.GroupBy(s => s.ShipmentNo).OrderBy(s => s.Key);
                foreach (var grpShipmentNo in grpShipmentNos)
                {
                    if (grpShipmentNo.Key != null && grpShipmentNo.Key != string.Empty)
                    {
                        List<DeliverBill> listShipmentNoDetail = grpShipmentNo.ToList<DeliverBill>();

                        int i = 0;
                        while (i < listShipmentNoDetail.Count)
                        {
                            if (i > 0)
                            {
                                int j = 0;
                                while (j < i)
                                {
                                    if (listShipmentNoDetail[i].ReceiverAddress == listShipmentNoDetail[j].ReceiverAddress)
                                    {
                                        break;
                                    }
                                    j++;
                                }
                                if (j >= i)
                                {
                                    listShipmentNoDetail[i].CarpoolFee = 100;
                                }
                            }
                            i++;
                        }
                    }
                }
            }
            #endregion

            #region 输出Excel

            //生成GridView
            BoundField colCreateTime = new BoundField();
            colCreateTime.HeaderText = InnoSoft.LS.Resources.Labels.DeliverDate;
            colCreateTime.DataField = "CreateTime";

            BoundField colPlanNo = new BoundField();
            colPlanNo.HeaderText = InnoSoft.LS.Resources.Labels.PlanNo;
            colPlanNo.DataField = "PlanNo";

            BoundField colCustomerName = new BoundField();
            colCustomerName.HeaderText = InnoSoft.LS.Resources.Labels.CustomerName;
            colCustomerName.DataField = "CustomerName";

            BoundField colPayerName = new BoundField();
            colPayerName.HeaderText = InnoSoft.LS.Resources.Labels.PayerName;
            colPayerName.DataField = "PayerName";

            BoundField colShipmentNo = new BoundField();
            colShipmentNo.HeaderText = InnoSoft.LS.Resources.Labels.ShipmentNo;
            colShipmentNo.DataField = "ShipmentNo";

            BoundField colDeliveryNo = new BoundField();
            colDeliveryNo.HeaderText = InnoSoft.LS.Resources.Labels.DeliveryNo;
            colDeliveryNo.DataField = "DeliveryNo";

            BoundField colReceiverName = new BoundField();
            colReceiverName.HeaderText = InnoSoft.LS.Resources.Labels.ReceiverName;
            colReceiverName.DataField = "ReceiverName";

            BoundField colStartCity = new BoundField();
            colStartCity.HeaderText = InnoSoft.LS.Resources.Labels.StartPlace;
            colStartCity.DataField = "StartCity";

            BoundField colReceiverCity = new BoundField();
            colReceiverCity.HeaderText = InnoSoft.LS.Resources.Labels.DestPlace;
            colReceiverCity.DataField = "ReceiverCity";

            BoundField colReceiveType = new BoundField();
            colReceiveType.HeaderText = InnoSoft.LS.Resources.Labels.ReceiveType;
            colReceiveType.DataField = "ReceiveType";

            BoundField colGoodsName = new BoundField();
            colGoodsName.HeaderText = InnoSoft.LS.Resources.Labels.GoodsName;
            colGoodsName.DataField = "GoodsName";

            BoundField colTotalPackages = new BoundField();
            colTotalPackages.HeaderText = InnoSoft.LS.Resources.Labels.Pieces;
            colTotalPackages.DataField = "TotalPackages";

            BoundField colTotalTunnages = new BoundField();
            colTotalTunnages.HeaderText = InnoSoft.LS.Resources.Labels.Tunnages;
            colTotalTunnages.DataField = "TotalTunnages";

            BoundField colTotalPiles = new BoundField();
            colTotalPiles.HeaderText = InnoSoft.LS.Resources.Labels.Piles;
            colTotalPiles.DataField = "TotalPiles";

            BoundField colTotalTenThousands = new BoundField();
            colTotalTenThousands.HeaderText = InnoSoft.LS.Resources.Labels.TenThousands;
            colTotalTenThousands.DataField = "TotalTenThousands";

            BoundField colCarNo = new BoundField();
            colCarNo.HeaderText = InnoSoft.LS.Resources.Labels.CarNo;
            colCarNo.DataField = "CarNo";

            BoundField colTrailerNo = new BoundField();
            colTrailerNo.HeaderText = InnoSoft.LS.Resources.Labels.TrailerNo;
            colTrailerNo.DataField = "TrailerNo";

            BoundField colCarType = new BoundField();
            colCarType.HeaderText = InnoSoft.LS.Resources.Labels.CarType;
            colCarType.DataField = "CarType";

            BoundField colDeliverBillNo = new BoundField();
            colDeliverBillNo.HeaderText = InnoSoft.LS.Resources.Labels.DeliverBillNo;
            colDeliverBillNo.DataField = "BillNo";

            BoundField colContractNo = new BoundField();
            colContractNo.HeaderText = InnoSoft.LS.Resources.Labels.ContractNo;
            colContractNo.DataField = "ContractNo";

            BoundField colOriginalContractNo = new BoundField();
            colOriginalContractNo.HeaderText = InnoSoft.LS.Resources.Labels.OriginalContractNo;
            colOriginalContractNo.DataField = "OriginalContractNo";

            BoundField colCarrierTransportCharges = new BoundField();
            colCarrierTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.CarrierTransportCharges;
            colCarrierTransportCharges.DataField = "TransportCharges";

            BoundField colCustomerTransportCharges = new BoundField();
            colCustomerTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.CustomerTransportCharges;
            colCustomerTransportCharges.DataField = "CustomerTransportCharges";

            BoundField colTransportChargesDifference = new BoundField();
            colTransportChargesDifference.HeaderText = InnoSoft.LS.Resources.Labels.TransportChargesDifference;
            colTransportChargesDifference.DataField = "TransportChargesDifference";

            BoundField colIsCustomerTransportChargesSettled = new BoundField();
            colIsCustomerTransportChargesSettled.HeaderText = InnoSoft.LS.Resources.Labels.IsCustomerTransportChargesSettled;
            colIsCustomerTransportChargesSettled.DataField = "IsCustomerTransportChargesSettled";

            BoundField colIsCarrierTransportChargesSettled = new BoundField();
            colIsCarrierTransportChargesSettled.HeaderText = InnoSoft.LS.Resources.Labels.IsCarrierTransportChargesSettled;
            colIsCarrierTransportChargesSettled.DataField = "IsCarrierTransportChargesSettled";

            BoundField colIsDeliverBillReceiptReceived = new BoundField();
            colIsDeliverBillReceiptReceived.HeaderText = InnoSoft.LS.Resources.Labels.IsReceiptReceived;
            colIsDeliverBillReceiptReceived.DataField = "IsDeliverBillReceiptReceived";

            BoundField colReturnTime = new BoundField();
            colReturnTime.HeaderText = InnoSoft.LS.Resources.Labels.ReturnTime;
            colReturnTime.DataField = "ReturnTime";

            BoundField colReverseAmount = new BoundField();
            colReverseAmount.HeaderText = InnoSoft.LS.Resources.Labels.ReverseAmount;
            colReverseAmount.DataField = "ReverseAmount";

            BoundField colTransportChargesBalance = new BoundField();
            colTransportChargesBalance.HeaderText = InnoSoft.LS.Resources.Labels.TransportChargesBalance;
            colTransportChargesBalance.DataField = "TransportChargesBalance";

            BoundField colRemark = new BoundField();
            colRemark.HeaderText = InnoSoft.LS.Resources.Labels.Remark;
            colRemark.DataField = "Remark";

            var grid = new GridView();
            grid.Columns.Add(colCreateTime);
            grid.Columns.Add(colPlanNo);
            grid.Columns.Add(colCustomerName);
            grid.Columns.Add(colPayerName);
            grid.Columns.Add(colShipmentNo);
            grid.Columns.Add(colDeliveryNo);
            grid.Columns.Add(colReceiverName);
            grid.Columns.Add(colStartCity);
            grid.Columns.Add(colReceiverCity);
            grid.Columns.Add(colReceiveType);
            grid.Columns.Add(colGoodsName);
            grid.Columns.Add(colTotalPackages);
            grid.Columns.Add(colTotalTunnages);
            grid.Columns.Add(colTotalPiles);
            grid.Columns.Add(colTotalTenThousands);
            grid.Columns.Add(colCarNo);
            grid.Columns.Add(colTrailerNo);
            grid.Columns.Add(colCarType);
            grid.Columns.Add(colDeliverBillNo);
            grid.Columns.Add(colContractNo);
            grid.Columns.Add(colOriginalContractNo);
            grid.Columns.Add(colCarrierTransportCharges);
            grid.Columns.Add(colCustomerTransportCharges);
            grid.Columns.Add(colTransportChargesDifference);
            grid.Columns.Add(colIsCustomerTransportChargesSettled);
            grid.Columns.Add(colIsCarrierTransportChargesSettled);
            grid.Columns.Add(colIsDeliverBillReceiptReceived);
            grid.Columns.Add(colReturnTime);
            grid.Columns.Add(colReverseAmount);
            grid.Columns.Add(colTransportChargesBalance);
            grid.Columns.Add(colRemark);

            grid.AutoGenerateColumns = false;

            grid.RowDataBound += new GridViewRowEventHandler(SyntheticalSearchGrid_RowDataBound);
            grid.DataSource = from b in listBill
                              select new
                              {
                                  CreateTime = b.CreateTime.ToString("yyyy-MM-dd"),
                                  PlanNo = b.PlanNo,
                                  CustomerName = b.CustomerName,
                                  PayerName = b.PayerName,
                                  ShipmentNo = b.ShipmentNo,
                                  DeliveryNo = b.DeliveryNo,
                                  ReceiverName = b.ReceiverName,
                                  StartCity = b.StartCity,
                                  ReceiverCity = b.ReceiverCity,
                                  ReceiveType = b.ReceiveType,
                                  GoodsName = b.GoodsName,
                                  TotalPackages = b.TotalPackages != 0 ? b.TotalPackages.ToString() : string.Empty,
                                  TotalTunnages = b.TotalTunnages != 0 ? b.TotalTunnages.ToString("#0.######") : string.Empty,
                                  TotalPiles = b.TotalPiles != 0 ? b.TotalPiles.ToString("#0.######") : string.Empty,
                                  TotalTenThousands = b.TotalTenThousands != 0 ? b.TotalTenThousands.ToString("#0.######") : string.Empty,
                                  CarNo = b.CarNo,
                                  TrailerNo = b.TrailerNo,
                                  CarType = b.CarType,
                                  BillNo = b.BillNo,
                                  ContractNo = b.ContractNo,
                                  OriginalContractNo = b.OriginalContractNo,
                                  TransportCharges = b.TransportCharges != 0 ? b.TransportCharges.ToString("N") : string.Empty,
                                  CustomerTransportCharges = (b.CustomerTransportCharges + b.CarpoolFee + b.RiverCrossingCharges) != 0 ? (b.CustomerTransportCharges + b.CarpoolFee + b.RiverCrossingCharges).ToString("N") : string.Empty,
                                  TransportChargesDifference = (b.CustomerTransportCharges + b.CarpoolFee + b.RiverCrossingCharges - b.TransportCharges) != 0 ? (b.CustomerTransportCharges + b.CarpoolFee + b.RiverCrossingCharges - b.TransportCharges).ToString("N") : string.Empty,
                                  IsCustomerTransportChargesSettled = b.IsCustomerTransportChargesSettled ? InnoSoft.LS.Resources.Options.Yes : InnoSoft.LS.Resources.Options.No,
                                  IsCarrierTransportChargesSettled = b.IsCarrierTransportChargesSettled ? InnoSoft.LS.Resources.Options.Yes : InnoSoft.LS.Resources.Options.No,
                                  IsDeliverBillReceiptReceived = b.IsDeliverBillReceiptReceived ? InnoSoft.LS.Resources.Options.Yes : InnoSoft.LS.Resources.Options.No,
                                  ReturnTime = b.IsDeliverBillReceiptReceived ? b.ReturnTime.ToString("yyyy-MM-dd") : string.Empty,
                                  ReverseAmount = b.ReverseAmount != 0 ? b.ReverseAmount.ToString("N") : string.Empty,
                                  TransportChargesBalance = b.TransportChargesBalance != 0 ? b.TransportChargesBalance.ToString("N") : string.Empty,
                                  Remark = b.Remark
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=SyntheticalSearch.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

            #endregion

            return View("SyntheticalSearch");
        }

        private void SyntheticalSearchGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[5].Attributes.Add("style", @"mso-number-format:'\@';");//防止交货单号被自动转换为整形
                e.Row.Cells[20].Attributes.Add("style", @"mso-number-format:'\@';");//防止原始合同号被自动转换为整形
                e.Row.Cells[21].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费被自动转换为整形
                e.Row.Cells[22].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费被自动转换为整形
                e.Row.Cells[23].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止价差被自动转换为整形
                e.Row.Cells[28].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止冲帐金额被自动转换为整形
                e.Row.Cells[29].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费差额被自动转换为整形
            }
        }

        /// <summary>
        /// GET在送货单退回调度之前进行检查
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult CheckForReturnDispatch(string id)
        {
            string strMessage;
            StatisticsSystem stat = new StatisticsSystem();
            bool bSuccess = stat.CheckForReturnDispatch(long.Parse(id), LoginAccountId, LoginStaffName, out strMessage);

            var ret = new
            {
                Success = bSuccess,
                Message = strMessage
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST退回重新调度
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ReturnDispatch(string id)
        {
            string strMessage;
            StatisticsSystem stat = new StatisticsSystem();
            bool bSuccess = stat.ReturnDispatchDeliverBill(long.Parse(id), LoginAccountId, LoginStaffName, out strMessage);

            var ret = new
            {
                Success = bSuccess,
                Message = strMessage
            };
            return Json(ret);
        }

        #endregion

    }
}
