using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;
using InnoSoft.LS.Business.Facades;
using InnoSoft.LS.Models;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.SS.Util;
using SYLS.Areas.chenxk.ViewModels;
using SYLS.Controllers;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.Controllers
{
    /// <summary>
    /// 结算管理控制器
    /// </summary>
    public class SettlementController : BaseController
    {
        #region 客户对帐

        /// <summary>
        /// GET统计客户对帐单页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult StatCustomerStatement()
        {
            string strErrText;

            //生成空付款单位下拉列表项
            List<Customer> listCustomer = new List<Customer>();
            List<SelectListItem> selectListCustomer = new List<SelectListItem>();
            selectListCustomer.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListCustomer.AddRange(from c in listCustomer
                                        select new SelectListItem
                                        {
                                            Text = c.Name,
                                            Value = c.Name
                                        });
            ViewData["Customers"] = new SelectList(selectListCustomer, "Value", "Text");

            //生成空的提货单位下拉列表项
            List<Receiver> listReceiver = new List<Receiver>();
            List<SelectListItem> selectListReceiver = new List<SelectListItem>();
            selectListReceiver.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListReceiver.AddRange(from r in listReceiver
                                        select new SelectListItem
                                        {
                                            Text = r.Name,
                                            Value = r.Name
                                        });
            ViewData["Receivers"] = new SelectList(selectListReceiver, "Value", "Text");

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

            return View();
        }

        /// <summary>
        /// GET客户对帐单表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="payerName"></param>
        /// <param name="receiverName"></param>
        /// <param name="startCountry"></param>
        /// <param name="startProvince"></param>
        /// <param name="startCity"></param>
        /// <param name="destCountry"></param>
        /// <param name="destProvince"></param>
        /// <param name="destCity"></param>
        /// <param name="carrierName"></param>
        /// <param name="carNo"></param>
        /// <param name="goodsName"></param>
        /// <param name="invoiceNo"></param>
        /// <param name="allowStatementWhenConsignedDeliverPlanNotCompleted"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadStatCustomerStatementGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string payerName, string receiverName, string startCountry, string startProvince, string startCity, string destCountry, string destProvince, string destCity, string carrierName, string carNo, string goodsName, string allowStatementWhenConsignedDeliverPlanNotCompleted)
        {
            //读取数据
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            List<CustomerStatement> listStatement = settlement.LoadCustomerStatementByConditions(startTime, endTime, payerName, receiverName, startCountry, startProvince, startCity, destCountry, destProvince, destCity, carrierName, carNo, goodsName, allowStatementWhenConsignedDeliverPlanNotCompleted, LoginAccountId, LoginStaffName, out strErrText);
            if (listStatement == null)
            {
                throw new Exception(strErrText);
            }

            //根据结算公式计算运费
            foreach (CustomerStatement statement in listStatement)
            {
                if (statement.TransportCharges == 0 && statement.SettlementExpression != null && statement.SettlementExpression != string.Empty)
                {
                    try
                    {
                        EvaluatorHelper evaluator = new EvaluatorHelper();

                        evaluator.SetExpression(statement.SettlementExpression);

                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.KM, statement.KM == null || statement.KM == string.Empty ? "0" : statement.KM);
                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Tunnages, statement.TotalTunnages.ToString());
                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Piles, statement.TotalPiles.ToString());
                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportPrice, statement.TransportPrice.ToString());
                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportCharges, "0");

                        string strTransportCharges = evaluator.EvaluateExpression();
                        statement.TransportCharges = decimal.Parse(strTransportCharges);
                    }
                    catch (Exception e)
                    {
                        throw e;
                    }
                }
            }

            //计算拼车费
            var grpShipmentNos = listStatement.GroupBy(s => s.ShipmentNo).OrderBy(s => s.Key);
            foreach (var grpShipmentNo in grpShipmentNos)
            {
                if (grpShipmentNo.Key != null && grpShipmentNo.Key != string.Empty)
                {
                    List<CustomerStatement> listShipmentNoDetail = grpShipmentNo.ToList<CustomerStatement>();

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
            int nTotalRows = listStatement.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listStatement.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              s.CreateTime,
                              s.PlanNo,
                              s.DeliverBillNo,
                              s.ShipmentNo,
                              s.DeliveryNo,
                              s.ReceiverName,
                              s.ReceiverAddress,
                              s.StartCity,
                              s.ReceiverCity,
                              s.KM,
                              s.CarNo,
                              s.GoodsName,
                              s.TotalPackages.ToString(),
                              s.TotalTunnages.ToString("#0.######"),
                              s.TotalPiles.ToString("#0.######"),
                              s.TotalTenThousands.ToString("#0.######"),
                              s.TransportPrice.ToString("#0.######"),
                              s.SettlementExpression,
                              s.TransportCharges.ToString(),
                              s.CarpoolFee.ToString(),
                              s.RiverCrossingCharges.ToString(),
                              s.Remark,
                              s.Remark2,
                              s.DeliverBillReceiptReceived.ToString(),
                              s.InvoiceNo
                          }
                      }).ToArray(),
                userdata = new
                {
                    CustomerName = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.TotalPackages),
                    Tunnages = data.Sum(s => s.TotalTunnages),
                    Piles = data.Sum(s => s.TotalPiles),
                    TenThousands = data.Sum(s => s.TotalTenThousands),
                    TransportCharges = data.Sum(s => s.TransportCharges),
                    CarpoolFee = data.Sum(s => s.CarpoolFee),
                    RiverCrossingCharges = data.Sum(s => s.RiverCrossingCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET导出客户对帐单
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportCustomerStatement()
        {
            #region 生成数据源

            string strErrText;

            var request = HttpContext.Request;

            string strStartTime = request.QueryString["startTime"] ?? string.Empty;
            string strEndTime = request.QueryString["endTime"] ?? string.Empty;
            string strPayerName = request.QueryString["payerName"] ?? string.Empty;
            string strReceiverName = request.QueryString["receiverName"] ?? string.Empty;
            string strStartCountry = request.QueryString["startCountry"] ?? string.Empty;
            string strStartProvince = request.QueryString["startProvince"] ?? string.Empty;
            string strStartCity = request.QueryString["startCity"] ?? string.Empty;
            string strDestCountry = request.QueryString["destCountry"] ?? string.Empty;
            string strDestProvince = request.QueryString["destProvince"] ?? string.Empty;
            string strDestCity = request.QueryString["destCity"] ?? string.Empty;
            string strCarrierName = request.QueryString["carrierName"] ?? string.Empty;
            string strCarNo = request.QueryString["carNo"] ?? string.Empty;
            string strGoodsName = request.QueryString["goodsName"] ?? string.Empty;
            string strAllowStatementWhenConsignedDeliverPlanNotCompleted = request.QueryString["allowStatementWhenConsignedDeliverPlanNotCompleted"] ?? "false";

            //读取数据
            SettlementSystem settlement = new SettlementSystem();
            List<CustomerStatement> listStatement = settlement.LoadCustomerStatementByConditions(strStartTime, strEndTime, strPayerName, strReceiverName, strStartCountry, strStartProvince, strStartCity, strDestCountry, strDestProvince, strDestCity, strCarrierName, strCarNo, strGoodsName, strAllowStatementWhenConsignedDeliverPlanNotCompleted, LoginAccountId, LoginStaffName, out strErrText);
            if (listStatement == null)
            {
                throw new Exception(strErrText);
            }

            //根据结算公式计算运费
            foreach (CustomerStatement statement in listStatement)
            {
                if (statement.TransportCharges == 0 && statement.SettlementExpression != null && statement.SettlementExpression != string.Empty)
                {
                    try
                    {
                        EvaluatorHelper evaluator = new EvaluatorHelper();

                        evaluator.SetExpression(statement.SettlementExpression);

                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.KM, statement.KM == null || statement.KM == string.Empty ? "0" : statement.KM);
                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Tunnages, statement.TotalTunnages.ToString());
                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.Piles, statement.TotalPiles.ToString());
                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportPrice, statement.TransportPrice.ToString());
                        evaluator.AddVariable(InnoSoft.LS.Resources.Labels.TransportCharges, "0");

                        string strTransportCharges = evaluator.EvaluateExpression();
                        statement.TransportCharges = decimal.Parse(strTransportCharges);
                    }
                    catch (Exception e)
                    {
                        throw e;
                    }
                }
            }

            //计算拼车费
            var grpShipmentNos = listStatement.GroupBy(s => s.ShipmentNo).OrderBy(s => s.Key);
            foreach (var grpShipmentNo in grpShipmentNos)
            {
                if (grpShipmentNo.Key != null && grpShipmentNo.Key != string.Empty)
                {
                    List<CustomerStatement> listShipmentNoDetail = grpShipmentNo.ToList<CustomerStatement>();

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

            //生成结果数据
            List<CustomerStatement> listRet = new List<CustomerStatement>();
            {
                //按客户分组
                var grpCustomerNames = listStatement.GroupBy(f => f.CustomerName).OrderBy(f => f.Key);
                foreach (var grpCustomerName in grpCustomerNames)
                {
                    List<CustomerStatement> data = grpCustomerName.ToList<CustomerStatement>();
                    listRet.AddRange(data);

                    //生成小计行
                    CustomerStatement subtotal = new CustomerStatement();
                    subtotal.CustomerName = grpCustomerName.Key;
                    subtotal.CreateTime = InnoSoft.LS.Resources.Labels.Subtotal;
                    subtotal.TotalPackages = data.Sum(s => s.TotalPackages);
                    subtotal.TotalTunnages = data.Sum(s => s.TotalTunnages);
                    subtotal.TotalPiles = data.Sum(s => s.TotalPiles);
                    subtotal.TotalTenThousands = data.Sum(s => s.TotalTenThousands);
                    subtotal.TransportCharges = data.Sum(s => s.TransportCharges);
                    subtotal.CarpoolFee = data.Sum(s => s.CarpoolFee);
                    subtotal.RiverCrossingCharges = data.Sum(s => s.RiverCrossingCharges);
                    listRet.Add(subtotal);
                }

                //生成合计行
                CustomerStatement total = new CustomerStatement();
                total.CustomerName = InnoSoft.LS.Resources.Labels.Total;
                total.TotalPackages = listStatement.Sum(s => s.TotalPackages);
                total.TotalTunnages = listStatement.Sum(s => s.TotalTunnages);
                total.TotalPiles = listStatement.Sum(s => s.TotalPiles);
                total.TotalTenThousands = listStatement.Sum(s => s.TotalTenThousands);
                total.TransportCharges = listStatement.Sum(s => s.TransportCharges);
                total.CarpoolFee = listStatement.Sum(s => s.CarpoolFee);
                total.RiverCrossingCharges = listStatement.Sum(s => s.RiverCrossingCharges);
                listRet.Add(total);
            }

            #endregion

            #region 导出Excel

            #region 创建Excel工作簿

            var workbook = new HSSFWorkbook();
            var sheet = workbook.CreateSheet();

            #endregion

            #region 设置列宽度

            int iCol = 0;
            sheet.SetColumnWidth(iCol++, 15 * 256);//客户名称
            sheet.SetColumnWidth(iCol++, 10 * 256);//发货日期
            sheet.SetColumnWidth(iCol++, 13 * 256);//计划单号
            sheet.SetColumnWidth(iCol++, 11 * 256);//交货单号
            if (listRet.FindAll(delegate(CustomerStatement cs) { return cs.ShipmentNo != null && cs.ShipmentNo != string.Empty; }).Count() > 0)
            {
                sheet.SetColumnWidth(iCol++, 11 * 256);//装运单号
            }
            sheet.SetColumnWidth(iCol++, 15 * 256);//收货单位名称
            sheet.SetColumnWidth(iCol++, 20 * 256);//收货单位地址
            sheet.SetColumnWidth(iCol++, 6 * 256);//起点
            sheet.SetColumnWidth(iCol++, 6 * 256);//讫点
            sheet.SetColumnWidth(iCol++, 10 * 256);//车号
            sheet.SetColumnWidth(iCol++, 10 * 256);//货物名称
            if (listRet.Sum(cs => cs.TotalPackages) != 0)
            {
                sheet.SetColumnWidth(iCol++, 4 * 256);//件数
            }
            if (listRet.Sum(cs => cs.TotalTunnages) != 0)
            {
                sheet.SetColumnWidth(iCol++, 9 * 256);//吨数
            }
            if (listRet.Sum(cs => cs.TotalPiles) > 0)
            {
                sheet.SetColumnWidth(iCol++, 8 * 256);//垛数
            }
            if (listRet.Sum(cs => cs.TotalTenThousands) > 0)
            {
                sheet.SetColumnWidth(iCol++, 8 * 256);//万只
            }
            sheet.SetColumnWidth(iCol++, 6 * 256);//运费单价
            sheet.SetColumnWidth(iCol++, 10 * 256);//运费金额
            if (listRet.Sum(cs => cs.CarpoolFee) > 0)
            {
                sheet.SetColumnWidth(iCol++, 8 * 256);//拼车费
            }
            if (listRet.Sum(cs => cs.RiverCrossingCharges) > 0)
            {
                sheet.SetColumnWidth(iCol++, 8 * 256);//过江费
            }
            if (listRet.FindAll(delegate(CustomerStatement cs) { return cs.Remark != null && cs.Remark != string.Empty; }).Count() > 0)
            {
                sheet.SetColumnWidth(iCol++, 15 * 256);//备注
            }
            if (listRet.FindAll(delegate(CustomerStatement cs) { return cs.Remark2 != null && cs.Remark2 != string.Empty; }).Count() > 0)
            {
                sheet.SetColumnWidth(iCol++, 15 * 256);//备注2
            }
            sheet.SetColumnWidth(iCol++, 6 * 256);//回单标志

            #endregion

            #region 创建表头

            //标题
            var rowTitle = sheet.CreateRow(0);
            rowTitle.HeightInPoints = 30;
            rowTitle.CreateCell(0).SetCellValue(strPayerName + InnoSoft.LS.Resources.Titles.CustomerTransportChargesStatement);

            ICellStyle styleTitle = workbook.CreateCellStyle();
            styleTitle.Alignment = HorizontalAlignment.CENTER;
            IFont fontTitle = workbook.CreateFont();
            fontTitle.FontHeightInPoints = 20;
            styleTitle.SetFont(fontTitle);
            rowTitle.GetCell(0).CellStyle = styleTitle;

            var rowTitle2 = sheet.CreateRow(1);
            rowTitle2.HeightInPoints = 22;
            rowTitle2.CreateCell(0).SetCellValue(strStartTime + InnoSoft.LS.Resources.Labels.Separator1 + strEndTime);

            ICellStyle styleTitle2 = workbook.CreateCellStyle();
            styleTitle2.Alignment = HorizontalAlignment.CENTER;
            IFont fontTitle2 = workbook.CreateFont();
            fontTitle2.FontHeightInPoints = 12;
            styleTitle2.SetFont(fontTitle2);
            rowTitle2.GetCell(0).CellStyle = styleTitle2;

            //表头
            ICellStyle styleLeft = workbook.CreateCellStyle();
            styleLeft.Alignment = HorizontalAlignment.LEFT;
            styleLeft.BorderBottom = CellBorderType.THIN;
            styleLeft.BorderLeft = CellBorderType.THIN;
            styleLeft.BorderRight = CellBorderType.THIN;
            styleLeft.BorderTop = CellBorderType.THIN;

            ICellStyle styleCenter = workbook.CreateCellStyle();
            styleCenter.Alignment = HorizontalAlignment.CENTER;
            styleCenter.BorderBottom = CellBorderType.THIN;
            styleCenter.BorderLeft = CellBorderType.THIN;
            styleCenter.BorderRight = CellBorderType.THIN;
            styleCenter.BorderTop = CellBorderType.THIN;

            ICellStyle styleRight = workbook.CreateCellStyle();
            styleRight.Alignment = HorizontalAlignment.RIGHT;
            styleRight.BorderBottom = CellBorderType.THIN;
            styleRight.BorderLeft = CellBorderType.THIN;
            styleRight.BorderRight = CellBorderType.THIN;
            styleRight.BorderTop = CellBorderType.THIN;

            var rowHeader = sheet.CreateRow(2);

            iCol = 0;

            rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.CustomerName);//客户名称
            rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;

            rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.DeliverDate);//发货日期
            rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;

            rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.PlanNo);//计划单号
            rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;

            rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.DeliveryNo);//交货单号
            rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;

            if (listRet.FindAll(delegate(CustomerStatement cs) { return cs.ShipmentNo != null && cs.ShipmentNo != string.Empty; }).Count() > 0)
            {
                rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.ShipmentNo);//装运单号
                rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;
            }

            rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.ReceiverName);//收货单位名称
            rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;

            rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.ReceiverAddress);//收货单位地址
            rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;

            rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.StartPlace);//起点
            rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;

            rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.DestPlace);//讫点
            rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;

            rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.CarNo);//车号
            rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;

            rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.GoodsName);//货物名称
            rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;

            if (listRet.Sum(cs => cs.TotalPackages) != 0)
            {
                rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.Pieces);//件数
                rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;
            }

            if (listRet.Sum(cs => cs.TotalTunnages) != 0)
            {
                rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.Tunnages);//吨数
                rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;
            }

            if (listRet.Sum(cs => cs.TotalPiles) > 0)
            {
                rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.Piles);//垛数
                rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;
            }

            if (listRet.Sum(cs => cs.TotalTenThousands) > 0)
            {
                rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.TenThousands);//万只
                rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;
            }

            rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.TransportPrice);//运费单价
            rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;

            rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.TransportCharges);//运费金额
            rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;

            if (listRet.Sum(cs => cs.CarpoolFee) > 0)
            {
                rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.CarpoolFee);//拼车费
                rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;
            }

            if (listRet.Sum(cs => cs.RiverCrossingCharges) > 0)
            {
                rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.RiverCrossingCharges);//过江费
                rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;
            }

            if (listRet.FindAll(delegate(CustomerStatement cs) { return cs.Remark != null && cs.Remark != string.Empty; }).Count() > 0)
            {
                rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.Remark);//备注
                rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;
            }

            if (listRet.FindAll(delegate(CustomerStatement cs) { return cs.Remark2 != null && cs.Remark2 != string.Empty; }).Count() > 0)
            {
                rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.Remark + "2");//备注
                rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;
            }

            rowHeader.CreateCell(iCol++).SetCellValue(InnoSoft.LS.Resources.Labels.ReceiptReceived);//回单标志
            rowHeader.GetCell(iCol - 1).CellStyle = styleCenter;

            sheet.AddMergedRegion(new CellRangeAddress(0, 0, 0, iCol - 1));
            sheet.AddMergedRegion(new CellRangeAddress(1, 1, 0, iCol - 1));

            #endregion

            #region 创建表体

            int iRow = 3;
            foreach (var ret in listRet)
            {
                var rowBody = sheet.CreateRow(iRow++);

                iCol = 0;

                rowBody.CreateCell(iCol++).SetCellValue(ret.CustomerName);//客户名称
                rowBody.GetCell(iCol - 1).CellStyle = styleLeft;

                rowBody.CreateCell(iCol++).SetCellValue(ret.CreateTime);//发货日期
                rowBody.GetCell(iCol - 1).CellStyle = styleLeft;

                rowBody.CreateCell(iCol++).SetCellValue(ret.PlanNo);//计划单号
                rowBody.GetCell(iCol - 1).CellStyle = styleLeft;

                rowBody.CreateCell(iCol++).SetCellValue(ret.DeliveryNo);//交货单号
                rowBody.GetCell(iCol - 1).CellStyle = styleLeft;

                if (listRet.FindAll(delegate(CustomerStatement cs) { return cs.ShipmentNo != null && cs.ShipmentNo != string.Empty; }).Count() > 0)
                {
                    rowBody.CreateCell(iCol++).SetCellValue(ret.ShipmentNo);//装运单号
                    rowBody.GetCell(iCol - 1).CellStyle = styleLeft;
                }

                rowBody.CreateCell(iCol++).SetCellValue(ret.ReceiverName);//收货单位名称
                rowBody.GetCell(iCol - 1).CellStyle = styleLeft;

                rowBody.CreateCell(iCol++).SetCellValue(ret.ReceiverAddress);//收货单位地址
                rowBody.GetCell(iCol - 1).CellStyle = styleLeft;

                rowBody.CreateCell(iCol++).SetCellValue(ret.StartCity);//起点
                rowBody.GetCell(iCol - 1).CellStyle = styleLeft;

                rowBody.CreateCell(iCol++).SetCellValue(ret.ReceiverCity);//讫点
                rowBody.GetCell(iCol - 1).CellStyle = styleLeft;

                rowBody.CreateCell(iCol++).SetCellValue(ret.CarNo);//车号
                rowBody.GetCell(iCol - 1).CellStyle = styleLeft;

                rowBody.CreateCell(iCol++).SetCellValue(ret.GoodsName);//货物名称
                rowBody.GetCell(iCol - 1).CellStyle = styleLeft;

                if (listRet.Sum(cs => cs.TotalPackages) != 0)
                {
                    rowBody.CreateCell(iCol++).SetCellValue(ret.TotalPackages != 0 ? ret.TotalPackages.ToString() : string.Empty);//件数
                    rowBody.GetCell(iCol - 1).CellStyle = styleCenter;
                }

                if (listRet.Sum(cs => cs.TotalTunnages) != 0)
                {
                    rowBody.CreateCell(iCol++).SetCellValue(ret.TotalTunnages != 0 ? ret.TotalTunnages.ToString("#0.######") : string.Empty);//吨数
                    rowBody.GetCell(iCol - 1).CellStyle = styleCenter;
                }

                if (listRet.Sum(cs => cs.TotalPiles) > 0)
                {
                    rowBody.CreateCell(iCol++).SetCellValue(ret.TotalPiles > 0 ? ret.TotalPiles.ToString("#0.######") : string.Empty);//垛数
                    rowBody.GetCell(iCol - 1).CellStyle = styleCenter;
                }

                if (listRet.Sum(cs => cs.TotalTenThousands) > 0)
                {
                    rowBody.CreateCell(iCol++).SetCellValue(ret.TotalTenThousands > 0 ? ret.TotalTenThousands.ToString("#0.######") : string.Empty);//万只
                    rowBody.GetCell(iCol - 1).CellStyle = styleCenter;
                }

                rowBody.CreateCell(iCol++).SetCellValue(ret.TransportPrice > 0 ? ret.TransportPrice.ToString("#0.00####") : string.Empty);//运费单价
                rowBody.GetCell(iCol - 1).CellStyle = styleRight;

                rowBody.CreateCell(iCol++).SetCellValue(ret.TransportCharges != 0 ? ret.TransportCharges.ToString("N2") : string.Empty);//运费金额
                rowBody.GetCell(iCol - 1).CellStyle = styleRight;

                if (listRet.Sum(cs => cs.CarpoolFee) > 0)
                {
                    rowBody.CreateCell(iCol++).SetCellValue(ret.CarpoolFee > 0 ? ret.CarpoolFee.ToString("N2") : string.Empty);//拼车费
                    rowBody.GetCell(iCol - 1).CellStyle = styleRight;
                }

                if (listRet.Sum(cs => cs.RiverCrossingCharges) > 0)
                {
                    rowBody.CreateCell(iCol++).SetCellValue(ret.RiverCrossingCharges > 0 ? ret.RiverCrossingCharges.ToString("N2") : string.Empty);//过江费
                    rowBody.GetCell(iCol - 1).CellStyle = styleRight;
                }

                if (listRet.FindAll(delegate(CustomerStatement cs) { return cs.Remark != null && cs.Remark != string.Empty; }).Count() > 0)
                {
                    rowBody.CreateCell(iCol++).SetCellValue(ret.Remark);//备注
                    rowBody.GetCell(iCol - 1).CellStyle = styleLeft;
                }

                if (listRet.FindAll(delegate(CustomerStatement cs) { return cs.Remark2 != null && cs.Remark2 != string.Empty; }).Count() > 0)
                {
                    rowBody.CreateCell(iCol++).SetCellValue(ret.Remark2);//备注
                    rowBody.GetCell(iCol - 1).CellStyle = styleLeft;
                }

                rowBody.CreateCell(iCol++).SetCellValue(ret.DeliverBillReceiptReceived ? InnoSoft.LS.Resources.Options.Yes : InnoSoft.LS.Resources.Options.No);//回单标志
                rowBody.GetCell(iCol - 1).CellStyle = styleCenter;
            }
            #endregion

            #region 输出Excel文件

            MemoryStream output = new MemoryStream();
            workbook.Write(output);

            return File(output.ToArray(), "application/vnd.ms-excel", "CustomerStatement.xls");

            #endregion

            #endregion
        }

        /// <summary>
        /// POST新增发票
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewCustomerTransportChargesSettlement(CustomerTransportChargesSettlementViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                CustomerTransportChargesSettlement data = new CustomerTransportChargesSettlement();
                data.InvoiceNo = model.InvoiceNo;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.InvoiceType = model.InvoiceType;
                data.InvoiceAmount = model.InvoiceAmount;
                data.Remark = model.Remark;

                List<CustomerTransportChargesSettlementDetail> listDetail = new List<CustomerTransportChargesSettlementDetail>();
                foreach (CustomerTransportChargesSettlementDetailViewModel m in model.Details)
                {
                    CustomerTransportChargesSettlementDetail d = new CustomerTransportChargesSettlementDetail();
                    d.CustomerTransportChargesSettlementId = m.CustomerTransportChargesSettlementId;
                    d.DeliverBillId = m.DeliverBillId;
                    d.TransportPrice = m.TransportPrice;
                    d.TransportCharges = m.TransportCharges;
                    d.CarpoolFee = m.CarpoolFee;
                    d.RiverCrossingCharges = m.RiverCrossingCharges;
                    listDetail.Add(d);
                }

                //保存数据
                string strErrText;
                SettlementSystem settlement = new SettlementSystem();
                if (settlement.InsertCustomerTransportChargesSettlement(data, listDetail, LoginAccountId, LoginStaffName, out strErrText) > 0)
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

        #endregion

        #region 查询客户运费结算记录

        /// <summary>
        /// GET查询发票页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchCustomerTransportChargesSettlements()
        {
            return View();
        }

        /// <summary>
        /// GET查询发票表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="invoiceNo"></param>
        /// <param name="deliverBillNo"></param>
        /// <param name="customerName"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchCustomerTransportChargesSettlementsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string invoiceNo, string deliverBillNo, string customerName)
        {
            //读取数据
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            List<CustomerTransportChargesSettlement> listCustomerTransportChargesSettlement = settlement.LoadCustomerTransportChargesSettlementsByConditions(startTime, endTime, invoiceNo, deliverBillNo, customerName, LoginAccountId, LoginStaffName, out strErrText);
            if (listCustomerTransportChargesSettlement == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listCustomerTransportChargesSettlement.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listCustomerTransportChargesSettlement.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from i in data
                      select new
                      {
                          id = i.Id,
                          cell = new string[] { 
                              i.Id.ToString(),
                              i.CreateTime.ToString("yyyy-MM-dd"),
                              i.InvoiceNo,
                              i.CustomerName,
                              i.InvoiceType,
                              i.InvoiceAmount.ToString(),
                              i.Remark
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET发票明细表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="customerTransportChargesSettlementId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCustomerTransportChargesSettlementDetailsGrid(string sidx, string sord, int page, int rows, string customerTransportChargesSettlementId)
        {
            //读取数据
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            List<CustomerTransportChargesSettlementDetail> listDetail = settlement.LoadCustomerTransportChargesSettlementDetails(long.Parse(customerTransportChargesSettlementId), LoginAccountId, LoginStaffName, out strErrText);
            if (listDetail == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listDetail.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "DeliverBillNo") + " " + (sord ?? "ASC");
            var data = listDetail.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from d in data
                      select new
                      {
                          id = d.Id,
                          cell = new string[] { 
                              d.Id.ToString(),
                              d.DeliverBillNo,
                              d.CustomerName,
                              d.ShipmentNo,
                              d.DeliveryNo,
                              d.CreateTime,
                              d.ReceiverName,
                              d.ReceiverAddress,
                              d.StartCity,
                              d.ReceiverCity,
                              d.CarNo,
                              d.GoodsName,
                              d.Packages.ToString(),
                              d.Tunnages.ToString("#0.######"),
                              d.Piles.ToString("#0.######"),
                              d.TenThousands.ToString("#0.######"),
                              d.TransportPrice.ToString("#0.######"),
                              d.TransportCharges.ToString(),
                              d.CarpoolFee.ToString(),
                              d.RiverCrossingCharges.ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    DeliverBillNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands),
                    TransportCharges = data.Sum(s => s.TransportCharges),
                    CarpoolFee = data.Sum(s => s.CarpoolFee),
                    RiverCrossingCharges = data.Sum(s => s.RiverCrossingCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST删除开票记录
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteCustomerTransportChargesSettlement(string id)
        {
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            if (settlement.DeleteCustomerTransportChargesSettlement(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 承运单位对帐

        /// <summary>
        /// GET承运单位对帐页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult StatCarrierStatement()
        {
            string strErrText;

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

            return View();
        }

        /// <summary>
        /// GET承运单位送货记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="startCountry"></param>
        /// <param name="startProvince"></param>
        /// <param name="startCity"></param>
        /// <param name="destCountry"></param>
        /// <param name="destProvince"></param>
        /// <param name="destCity"></param>
        /// <param name="carrierName"></param>
        /// <param name="carNo"></param>
        /// <param name="deliverBillReceiptReceived"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadStatCarrierStatementGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string startCountry, string startProvince, string startCity, string destCountry, string destProvince, string destCity, string carrierName, string carNo, string deliverBillReceiptReceived)
        {
            //读取数据
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            List<CarrierStatement> listStatement = settlement.LoadCarrierStatementByConditions(startTime, endTime, startCountry, startProvince, startCity, destCountry, destProvince, destCity, carrierName, carNo, deliverBillReceiptReceived, LoginAccountId, LoginStaffName, out strErrText);
            if (listStatement == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listStatement.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listStatement.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              s.CarrierName,
                              s.DeliverBillNo,
                              s.DeliveryNo,
                              s.CreateTime,
                              s.CarNo,
                              s.StartCity,
                              s.ReceiverCity,
                              s.TotalPackages.ToString(),
                              s.TotalTunnages.ToString("#0.######"),
                              s.TotalPiles.ToString("#0.######"),
                              s.TotalTenThousands.ToString("#0.######"),
                              s.TransportCharges.ToString(),
                              s.Remark,
                              s.Remark2,
                              s.DeliverBillReceiptReceived.ToString(),
                              s.DamageInfo
                          }
                      }).ToArray(),
                userdata = new
                {
                    CarrierName = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.TotalPackages),
                    Tunnages = data.Sum(s => s.TotalTunnages),
                    Piles = data.Sum(s => s.TotalPiles),
                    TenThousands = data.Sum(s => s.TotalTenThousands),
                    TransportCharges = data.Sum(s => s.TransportCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET导出承运单位对帐单
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportCarrierStatement()
        {
            string strErrText;

            var request = HttpContext.Request;

            string strStartTime = request.QueryString["startTime"] ?? string.Empty;
            string strEndTime = request.QueryString["endTime"] ?? string.Empty;
            string strStartCountry = request.QueryString["startCountry"] ?? string.Empty;
            string strStartProvince = request.QueryString["startProvince"] ?? string.Empty;
            string strStartCity = request.QueryString["startCity"] ?? string.Empty;
            string strDestCountry = request.QueryString["destCountry"] ?? string.Empty;
            string strDestProvince = request.QueryString["destProvince"] ?? string.Empty;
            string strDestCity = request.QueryString["destCity"] ?? string.Empty;
            string strCarrierName = request.QueryString["carrierName"] ?? string.Empty;
            string strCarNo = request.QueryString["carNo"] ?? string.Empty;
            string strDeliverBillReceiptReceived = request.QueryString["deliverBillReceiptReceived"] ?? "false";

            //读取数据
            SettlementSystem settlement = new SettlementSystem();
            List<CarrierStatement> listStatement = settlement.LoadCarrierStatementByConditions(strStartTime, strEndTime, strStartCountry, strStartProvince, strStartCity, strDestCountry, strDestProvince, strDestCity, strCarrierName, strCarNo, strDeliverBillReceiptReceived, LoginAccountId, LoginStaffName, out strErrText);
            if (listStatement == null)
            {
                throw new Exception(strErrText);
            }

            //汇总
            List<CarrierStatement> listStat = new List<CarrierStatement>();
            {
                //按承运单位分组
                var grpCarrierNames = listStatement.GroupBy(s => s.CarrierName).OrderBy(s => s.Key);
                foreach (var grpCarrierName in grpCarrierNames)
                {
                    List<CarrierStatement> listCarrierNameDetail = grpCarrierName.OrderBy(s => s.CreateTime).ToList<CarrierStatement>();

                    listStat.AddRange(listCarrierNameDetail);

                    //小计
                    CarrierStatement subTotal = new CarrierStatement();
                    subTotal.CarrierName = InnoSoft.LS.Resources.Labels.Subtotal;
                    subTotal.TotalPackages = listCarrierNameDetail.Sum(s => s.TotalPackages);
                    subTotal.TotalTunnages = listCarrierNameDetail.Sum(s => s.TotalTunnages);
                    subTotal.TotalPiles = listCarrierNameDetail.Sum(s => s.TotalPiles);
                    subTotal.TotalTenThousands = listCarrierNameDetail.Sum(s => s.TotalTenThousands);
                    subTotal.TransportCharges = listCarrierNameDetail.Sum(s => s.TransportCharges);

                    listStat.Add(subTotal);
                }

                //总计
                CarrierStatement total = new CarrierStatement();
                total.CarrierName = InnoSoft.LS.Resources.Labels.Total;
                total.TotalPackages = listStatement.Sum(s => s.TotalPackages);
                total.TotalTunnages = listStatement.Sum(s => s.TotalTunnages);
                total.TotalPiles = listStatement.Sum(s => s.TotalPiles);
                total.TotalTenThousands = listStatement.Sum(s => s.TotalTenThousands);
                total.TransportCharges = listStatement.Sum(s => s.TransportCharges);

                listStat.Add(total);
            }

            //生成GridView
            BoundField colCarrierName = new BoundField();
            colCarrierName.HeaderText = InnoSoft.LS.Resources.Labels.CustomerName;
            colCarrierName.DataField = "CarrierName";

            BoundField colDeliverBillNo = new BoundField();
            colDeliverBillNo.HeaderText = InnoSoft.LS.Resources.Labels.DeliverBillNo;
            colDeliverBillNo.DataField = "DeliverBillNo";

            BoundField colDeliveryNo = new BoundField();
            colDeliveryNo.HeaderText = InnoSoft.LS.Resources.Labels.DeliveryNo;
            colDeliveryNo.DataField = "DeliveryNo";

            BoundField colCreateTime = new BoundField();
            colCreateTime.HeaderText = InnoSoft.LS.Resources.Labels.DeliverDate;
            colCreateTime.DataField = "CreateTime";

            BoundField colCarNo = new BoundField();
            colCarNo.HeaderText = InnoSoft.LS.Resources.Labels.CarNo;
            colCarNo.DataField = "CarNo";

            BoundField colStartCity = new BoundField();
            colStartCity.HeaderText = InnoSoft.LS.Resources.Labels.StartPlace;
            colStartCity.DataField = "StartCity";

            BoundField colReceiverCity = new BoundField();
            colReceiverCity.HeaderText = InnoSoft.LS.Resources.Labels.DestPlace;
            colReceiverCity.DataField = "ReceiverCity";

            BoundField colPackages = new BoundField();
            colPackages.HeaderText = InnoSoft.LS.Resources.Labels.Pieces;
            colPackages.DataField = "Packages";

            BoundField colTunnages = new BoundField();
            colTunnages.HeaderText = InnoSoft.LS.Resources.Labels.Tunnages;
            colTunnages.DataField = "Tunnages";

            BoundField colPiles = new BoundField();
            colPiles.HeaderText = InnoSoft.LS.Resources.Labels.Piles;
            colPiles.DataField = "Piles";

            BoundField colTenThousands = new BoundField();
            colTenThousands.HeaderText = InnoSoft.LS.Resources.Labels.TenThousands;
            colTenThousands.DataField = "TenThousands";

            BoundField colTransportCharges = new BoundField();
            colTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.TransportCharges;
            colTransportCharges.DataField = "TransportCharges";

            BoundField colRemark = new BoundField();
            colRemark.HeaderText = InnoSoft.LS.Resources.Labels.Remark;
            colRemark.DataField = "Remark";

            BoundField colRemark2 = new BoundField();
            colRemark2.HeaderText = InnoSoft.LS.Resources.Labels.Remark + "2";
            colRemark2.DataField = "Remark2";

            BoundField colDeliverBillReceiptReceived = new BoundField();
            colDeliverBillReceiptReceived.HeaderText = InnoSoft.LS.Resources.Labels.ReceiptReceived;
            colDeliverBillReceiptReceived.DataField = "DeliverBillReceiptReceived";

            BoundField colDamageInfo = new BoundField();
            colDamageInfo.HeaderText = InnoSoft.LS.Resources.Labels.DamageInfo;
            colDamageInfo.DataField = "DamageInfo";

            var grid = new GridView();
            grid.Columns.Add(colCarrierName);
            grid.Columns.Add(colDeliverBillNo);
            grid.Columns.Add(colDeliveryNo);
            grid.Columns.Add(colCreateTime);
            grid.Columns.Add(colCarNo);
            grid.Columns.Add(colStartCity);
            grid.Columns.Add(colReceiverCity);
            grid.Columns.Add(colPackages);
            grid.Columns.Add(colTunnages);
            grid.Columns.Add(colPiles);
            grid.Columns.Add(colTenThousands);
            grid.Columns.Add(colTransportCharges);
            grid.Columns.Add(colRemark);
            grid.Columns.Add(colRemark2);
            grid.Columns.Add(colDeliverBillReceiptReceived);
            grid.Columns.Add(colDamageInfo);

            grid.AutoGenerateColumns = false;

            grid.RowDataBound += new GridViewRowEventHandler(StatCarrierStatementGrid_RowDataBound);
            grid.DataSource = from s in listStat
                              select new
                              {
                                  CarrierName = s.CarrierName,
                                  DeliverBillNo = s.DeliverBillNo,
                                  DeliveryNo = s.DeliveryNo,
                                  CreateTime = s.CreateTime,
                                  CarNo = s.CarNo,
                                  StartCity = s.StartCity,
                                  ReceiverCity = s.ReceiverCity,
                                  Packages = s.TotalPackages != 0 ? s.TotalPackages.ToString() : string.Empty,
                                  Tunnages = s.TotalTunnages != 0 ? s.TotalTunnages.ToString("#0.######") : string.Empty,
                                  Piles = s.TotalPiles > 0 ? s.TotalPiles.ToString("#0.######") : string.Empty,
                                  TenThousands = s.TotalTenThousands > 0 ? s.TotalTenThousands.ToString("#0.######") : string.Empty,
                                  TransportCharges = s.TransportCharges != 0 ? s.TransportCharges.ToString("N2") : string.Empty,
                                  Remark = s.Remark,
                                  Remark2 = s.Remark2,
                                  DeliverBillReceiptReceived = s.DeliverBillReceiptReceived ? InnoSoft.LS.Resources.Options.Yes : InnoSoft.LS.Resources.Options.No,
                                  DamageInfo = s.DamageInfo
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=CarrierStatement.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

            return View("StatCarrierStatement");
        }

        private void StatCarrierStatementGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[2].Attributes.Add("style", @"mso-number-format:'\@';");//防止交货单号被自动转换为整形
                e.Row.Cells[11].Attributes.Add("style", @"mso-number-format:'\@'; text-align:right;");//防止运费被自动转换为整形
            }
        }

        /// <summary>
        /// POST新增承运单位结算记录
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewCarrierTransportChargesSettlement(CarrierTransportChargesSettlementViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                CarrierTransportChargesSettlement data = new CarrierTransportChargesSettlement();
                data.CarrierId = model.CarrierId;
                data.CarrierName = model.CarrierName;
                data.SettlementAmount = model.SettlementAmount;
                data.WithholdAmount = model.WithholdAmount;
                data.FactpaymentAmount = model.FactpaymentAmount;
                data.Remark = model.Remark;

                List<CarrierTransportChargesSettlementDetail> listDetail = new List<CarrierTransportChargesSettlementDetail>();
                foreach (CarrierTransportChargesSettlementDetailViewModel m in model.Details)
                {
                    CarrierTransportChargesSettlementDetail d = new CarrierTransportChargesSettlementDetail();
                    d.CarrierTransportChargesSettlementId = m.CarrierTransportChargesSettlementId;
                    d.DeliverBillId = m.DeliverBillId;
                    d.TransportCharges = m.TransportCharges;
                    listDetail.Add(d);
                }

                //保存数据
                string strErrText;
                SettlementSystem settlement = new SettlementSystem();
                if (settlement.InsertCarrierTransportChargesSettlement(data, listDetail, LoginAccountId, LoginStaffName, out strErrText) > 0)
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

        #endregion

        #region 查询承运单位结算记录

        /// <summary>
        /// GET查询承运单位结算记录页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchCarrierTransportChargesSettlements()
        {
            return View();
        }

        /// <summary>
        /// GET查询承运单位结算记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="carrierName"></param>
        /// <param name="carNo"></param>
        /// <param name="deliverBillNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchCarrierTransportChargesSettlementsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string carrierName, string carNo, string deliverBillNo)
        {
            //读取数据
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            List<CarrierTransportChargesSettlement> listSettlement = settlement.LoadCarrierTransportChargesSettlementsByConditions(startTime, endTime, carrierName, carNo, deliverBillNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listSettlement == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listSettlement.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listSettlement.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              s.CreateTime.ToString("yyyy-MM-dd"),
                              s.CarrierName,
                              s.SettlementAmount.ToString(),
                              s.WithholdAmount.ToString(),
                              s.FactpaymentAmount.ToString(),
                              s.Remark
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET承运单位结算记录明细表格
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="carrierTransportChargesSettlementId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarrierTransportChargesSettlementDetailsGrid(string sidx, string sord, int page, int rows, string carrierTransportChargesSettlementId)
        {
            //读取数据
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            List<CarrierTransportChargesSettlementDetail> listDetail = settlement.LoadCarrierTransportChargesSettlementDetails(long.Parse(carrierTransportChargesSettlementId), LoginAccountId, LoginStaffName, out strErrText);
            if (listDetail == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listDetail.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "DeliverBillNo") + " " + (sord ?? "ASC");
            var data = listDetail.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from d in data
                      select new
                      {
                          id = d.Id,
                          cell = new string[] { 
                              d.Id.ToString(),
                              d.CarrierName,
                              d.DeliverBillNo,
                              d.CreateTime,
                              d.CarNo,
                              d.StartCity,
                              d.ReceiverCity,
                              d.Packages.ToString(),
                              d.Tunnages.ToString("#0.######"),
                              d.Piles.ToString("#0.######"),
                              d.TenThousands.ToString("#0.######"),
                              d.TransportCharges.ToString(),
                              d.DamageInfo
                          }
                      }).ToArray(),
                userdata = new
                {
                    CarrierName = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands),
                    TransportCharges = data.Sum(s => s.TransportCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST删除承运单位结算记录
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteCarrierTransportChargesSettlement(string id)
        {
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            if (settlement.DeleteCarrierTransportChargesSettlement(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 录入特殊结算价格

        /// <summary>
        /// GET录入特殊结算价格页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewDeliverBillCustomerTransportPrice()
        {
            return View();
        }

        /// <summary>
        /// GET指定送货单编码的特殊结算价格记录
        /// </summary>
        /// <param name="deliverBillId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDeliverBillCustomerTransportPriceByDeliverBillId(string deliverBillId)
        {
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            DeliverBillCustomerTransportPrice data = settlement.LoadDeliverBillCustomerTransportPriceByDeliverBillId(long.Parse(deliverBillId), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    Id = data.Id,
                    DeliverBillId = data.DeliverBillId,
                    TransportPrice = data.TransportPrice,
                    TransportCharges = data.TransportCharges,
                    Remark = data.Remark
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// POST录入特殊结算价格
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewDeliverBillCustomerTransportPrice(DeliverBillCustomerTransportPriceViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                DeliverBillCustomerTransportPrice data = new DeliverBillCustomerTransportPrice();
                data.Id = 0;
                data.DeliverBillId = model.DeliverBillId;
                data.TransportPrice = model.ActualTransportPrice;
                data.TransportCharges = model.ActualTransportCharges;
                data.Remark = model.Remark;

                //保存数据
                string strErrText;
                SettlementSystem settlement = new SettlementSystem();
                if (settlement.InsertDeliverBillCustomerTransportPrice(data, LoginAccountId, LoginStaffName, out strErrText))
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

        #endregion

        #region 查询特殊结算价格

        /// <summary>
        /// GET查询特殊结算价格页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchDeliverBillCustomerTransportPrices()
        {
            return View();
        }

        /// <summary>
        /// GET查询特殊结算价格表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="deliverBillNo"></param>
        /// <param name="customerName"></param>
        /// <param name="deliveryNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchDeliverBillCustomerTransportPricesGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string deliverBillNo, string customerName, string deliveryNo)
        {
            //读取数据
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            List<DeliverBillCustomerTransportPrice> listPrice = settlement.LoadDeliverBillCustomerTransportPricesByConditions(startTime, endTime, deliverBillNo, customerName, deliveryNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listPrice == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listPrice.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listPrice.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from p in data
                      select new
                      {
                          id = p.Id,
                          cell = new string[] { 
                              p.Id.ToString(),
                              p.CreateTime.ToString("yyyy-MM-dd"),
                              p.DeliverBillNo,
                              p.ShipmentNo,
                              p.DeliveryNo,
                              p.CustomerName,
                              p.ReceiverName,
                              p.AgreementTransportPrice.ToString("#0.######"),
                              p.TransportPrice.ToString("#0.######"),
                              p.TransportCharges.ToString(),
                              p.Remark,
                              p.CreatorName
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST删除特殊结算价格记录
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteDeliverBillCustomerTransportPrice(string id)
        {
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            if (settlement.DeleteDeliverBillCustomerTransportPrice(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 录入特殊承运价格

        /// <summary>
        /// GET录入特殊承运价格页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewDeliverBillCarrierTransportPrice()
        {
            return View();
        }

        /// <summary>
        /// GET指定送货单编码的特殊承运价格记录
        /// </summary>
        /// <param name="deliverBillId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDeliverBillCarrierTransportPriceByDeliverBillId(string deliverBillId)
        {
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            DeliverBillCarrierTransportPrice data = settlement.LoadDeliverBillCarrierTransportPriceByDeliverBillId(long.Parse(deliverBillId), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    Id = data.Id,
                    DeliverBillId = data.DeliverBillId,
                    TransportPrice = data.TransportPrice,
                    TransportCharges = data.TransportCharges,
                    Remark = data.Remark
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// POST录入特殊承运价格
        /// </summary>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewDeliverBillCarrierTransportPrice(DeliverBillCarrierTransportPriceViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                DeliverBillCarrierTransportPrice data = new DeliverBillCarrierTransportPrice();
                data.Id = 0;
                data.DeliverBillId = model.DeliverBillId;
                data.TransportPrice = model.ActualTransportPrice;
                data.TransportCharges = model.ActualTransportCharges;
                data.Remark = model.Remark;

                //保存数据
                string strErrText;
                SettlementSystem settlement = new SettlementSystem();
                if (settlement.InsertDeliverBillCarrierTransportPrice(data, LoginAccountId, LoginStaffName, out strErrText))
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

        #endregion

        #region 查询特殊承运价格

        /// <summary>
        /// GET查询特殊承运价格页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchDeliverBillCarrierTransportPrices()
        {
            return View();
        }

        /// <summary>
        /// GET查询特殊承运价格表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="deliverBillNo"></param>
        /// <param name="carNo"></param>
        /// <param name="deliveryNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchDeliverBillCarrierTransportPricesGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string deliverBillNo, string carNo, string deliveryNo)
        {
            //读取数据
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            List<DeliverBillCarrierTransportPrice> listPrice = settlement.LoadDeliverBillCarrierTransportPricesByConditions(startTime, endTime, deliverBillNo, carNo, deliveryNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listPrice == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listPrice.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listPrice.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from p in data
                      select new
                      {
                          id = p.Id,
                          cell = new string[] { 
                              p.Id.ToString(),
                              p.CreateTime.ToString("yyyy-MM-dd"),
                              p.DeliverBillNo,
                              p.DeliveryNo,
                              p.CarrierName,
                              p.CarNo,
                              p.DispatchedTransportPrice.ToString("#0.######"),
                              p.TransportPrice.ToString("#0.######"),
                              p.TransportCharges.ToString(),
                              p.Remark,
                              p.CreatorName
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST删除特殊承运价格记录
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteDeliverBillCarrierTransportPrice(string id)
        {
            string strErrText;
            SettlementSystem settlement = new SettlementSystem();
            if (settlement.DeleteDeliverBillCarrierTransportPrice(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

    }
}
