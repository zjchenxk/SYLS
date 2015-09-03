using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
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
    /// 库存管理控制器
    /// </summary>
    public class StockController : BaseController
    {
        #region 货物入库

        /// <summary>
        /// GET货物入库页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult EnterWarehouse(string id)
        {
            string strErrText;

            //创建Model
            EnterWarehouseBillViewModel model = new EnterWarehouseBillViewModel();
            if (id != null && id != string.Empty)
            {
                //读取入库单数据
                StockSystem stock = new StockSystem();
                EnterWarehouseBill bill = stock.LoadEnterWarehouseBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
                if (bill == null)
                {
                    throw new Exception(strErrText);
                }

                model.Id = bill.Id;
                model.BillNo = bill.BillNo;
                model.PlanId = bill.PlanId;
                model.CustomerId = bill.CustomerId;
                model.CustomerName = bill.CustomerName;
                model.DeliveryNo = bill.DeliveryNo;
                model.EnterType = bill.EnterType;
                model.IsConsigning = bill.IsConsigning;
                model.Warehouse = bill.Warehouse;
                model.UnloadingForceFeePrice = bill.UnloadingForceFeePrice;
                model.ForceFee = bill.ForceFee;
                model.StorageFeePrice = bill.StorageFeePrice;
                model.HasDrayage = bill.HasDrayage;
                model.Remark = bill.Remark;
                model.CreateTime = bill.CreateTime.ToString("yyyy-MM-dd");
            }
            else
            {
                model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");
            }

            model.Goods = new List<EnterWarehouseBillGoodsViewModel>();
            model.Goods.Add(new EnterWarehouseBillGoodsViewModel());

            //生成入库类别下拉列表项
            List<SelectListItem> selectListEnterType = new List<SelectListItem>();
            selectListEnterType.Add(new SelectListItem { Text = InnoSoft.LS.Resources.Options.DeliverInStorage, Value = InnoSoft.LS.Resources.Options.DeliverInStorage });
            selectListEnterType.Add(new SelectListItem { Text = InnoSoft.LS.Resources.Options.AllocateInStorage, Value = InnoSoft.LS.Resources.Options.AllocateInStorage });
            ViewData["EnterTypes"] = new SelectList(selectListEnterType, "Value", "Text", model.EnterType);

            //生成仓库下拉列表项
            DDSystem dd = new DDSystem();
            List<Warehouse> listWarehouse = dd.LoadWarehouses(LoginAccountId, LoginStaffName, out strErrText);
            if (listWarehouse == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListWarehouse = new List<SelectListItem>();
            selectListWarehouse.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListWarehouse.AddRange(from w in listWarehouse
                                         select new SelectListItem
                                         {
                                             Text = w.Name,
                                             Value = w.Name
                                         });
            ViewData["Warehouses"] = new SelectList(selectListWarehouse, "Value", "Text", model.Warehouse);

            return View(model);
        }

        /// <summary>
        /// GET货物入库页面货物表格
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="enterWarehouseBillId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadEnterWarehouseBillAllGoodsGrid(string sidx, string sord, int page, int rows, string enterWarehouseBillId)
        {
            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<EnterWarehouseBillGoods> listGoods = stock.LoadEnterWarehouseBillAllGoods(long.Parse(enterWarehouseBillId), LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listGoods.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "GoodsNo") + " " + (sord ?? "ASC");
            var data = listGoods.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from g in data
                      select new
                      {
                          id = g.Id,
                          cell = new string[] { 
                              g.Id.ToString(),
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.Brand,
                              g.SpecModel,
                              g.GWeight,
                              g.Grade,
                              g.BatchNo,
                              g.Packing,
                              g.Location,
                              g.Packages.ToString(),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              g.Piles.ToString("#0.######"),
                              g.TenThousands.ToString("#0.######"),
                              g.ProductionDate,
                              g.ShipmentBillGoodsIds
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST货物入库
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult EnterWarehouse(EnterWarehouseBillViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                EnterWarehouseBill bill = new EnterWarehouseBill();
                bill.Id = model.Id;
                bill.BillNo = model.BillNo;
                bill.PlanId = model.PlanId;
                bill.CustomerId = model.CustomerId;
                bill.CustomerName = model.CustomerName;
                bill.DeliveryNo = model.DeliveryNo;
                bill.EnterType = model.EnterType;
                bill.IsConsigning = model.IsConsigning;
                bill.Warehouse = model.Warehouse;
                bill.UnloadingForceFeePrice = model.UnloadingForceFeePrice;
                bill.ForceFee = model.ForceFee;
                bill.StorageFeePrice = model.StorageFeePrice;
                bill.HasDrayage = model.HasDrayage;
                bill.Remark = model.Remark;
                bill.CreateTime = DateTime.Parse(model.CreateTime);

                List<EnterWarehouseBillGoods> listGoods = new List<EnterWarehouseBillGoods>();
                foreach (EnterWarehouseBillGoodsViewModel m in model.Goods)
                {
                    EnterWarehouseBillGoods g = new EnterWarehouseBillGoods();
                    g.Id = m.Id;
                    g.CustomerId = model.CustomerId;
                    g.CustomerName = model.CustomerName;
                    g.GoodsId = m.GoodsId;
                    g.GoodsNo = m.GoodsNo;
                    g.GoodsName = m.GoodsName;
                    g.Brand = m.Brand;
                    g.SpecModel = m.SpecModel;
                    g.GWeight = m.GWeight;
                    g.Grade = m.Grade;
                    g.BatchNo = m.BatchNo;
                    g.Packing = m.Packing;
                    g.Warehouse = model.Warehouse;
                    g.Location = m.Location;
                    g.Packages = m.Packages;
                    g.PieceWeight = m.PieceWeight;
                    g.Tunnages = m.Tunnages;
                    g.Piles = m.Piles;
                    g.TenThousands = m.TenThousands;
                    g.ProductionDate = m.ProductionDate;
                    g.ShipmentBillGoodsIds = m.ShipmentBillGoodsIds;
                    g.EnterWarehouseBillId = m.EnterWarehouseBillId;
                    g.DeliveryNo = model.DeliveryNo;
                    g.CreateTime = DateTime.Parse(model.CreateTime);
                    listGoods.Add(g);
                }

                //保存数据
                string strErrText;
                StockSystem stock = new StockSystem();
                if (bill.Id == 0)
                {
                    long nEnterWarehouseBillId = stock.InsertEnterWarehouseBill(bill, listGoods, LoginAccountId, LoginStaffName, out strErrText);
                    if (nEnterWarehouseBillId > 0)
                    {
                        //读取入库单号
                        bill = stock.LoadEnterWarehouseBill(nEnterWarehouseBillId, LoginAccountId, LoginStaffName, out strErrText);
                        if (bill == null)
                        {
                            var ret = new
                            {
                                EnterWarehouseBillNo = string.Empty,
                                ErrorText = strErrText
                            };
                            return Json(ret);
                        }
                        else
                        {
                            var ret = new
                            {
                                EnterWarehouseBillNo = bill.BillNo,
                                ErrorText = string.Empty
                            };
                            return Json(ret);
                        }
                    }
                    else
                    {
                        var ret = new
                        {
                            EnterWarehouseBillNo = string.Empty,
                            ErrorText = strErrText
                        };
                        return Json(ret);
                    }
                }
                else
                {
                    if (stock.UpdateEnterWarehouseBill(bill, listGoods, LoginAccountId, LoginStaffName, out strErrText))
                    {
                        var ret = new
                        {
                            EnterWarehouseBillNo = bill.BillNo,
                            ErrorText = string.Empty
                        };
                        return Json(ret);
                    }
                    else
                    {
                        var ret = new
                        {
                            EnterWarehouseBillNo = string.Empty,
                            ErrorText = strErrText
                        };
                        return Json(ret);
                    }
                }
            }
            return View(model);
        }

        #endregion

        #region 货物出库

        /// <summary>
        /// GET货物出库页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult OutWarehouse(string id)
        {
            string strErrText;

            //创建Model
            OutWarehouseBillViewModel model = new OutWarehouseBillViewModel();

            if (id != null && id != string.Empty)
            {
                //读取出库单数据
                StockSystem stock = new StockSystem();
                OutWarehouseBill data = stock.LoadOutWarehouseBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
                if (data == null)
                {
                    throw new Exception(strErrText);
                }

                model.Id = data.Id;
                model.BillNo = data.BillNo;
                model.PlanId = data.PlanId;
                model.CustomerId = data.CustomerId;
                model.CustomerName = data.CustomerName;
                model.DeliveryNo = data.DeliveryNo;
                model.OutType = data.OutType;
                model.ReceiverName = data.ReceiverName;
                model.ReceiverCountry = data.ReceiverCountry;
                model.ReceiverProvince = data.ReceiverProvince;
                model.ReceiverCity = data.ReceiverCity;
                model.ReceiverAddress = data.ReceiverAddress;
                model.ReceiverContact = data.ReceiverContact;
                model.ReceiverContactTel = data.ReceiverContactTel;
                model.ReceiveType = data.ReceiveType;
                model.CarNo = data.CarNo;
                model.TrailerNo = data.TrailerNo;
                model.CarrierId = data.CarrierId;
                model.CarrierName = data.CarrierName;
                model.PayerId = data.PayerId;
                model.PayerName = data.PayerName;
                model.IsConsigning = data.IsConsigning;
                model.ConsignedDeliveryNo = data.ConsignedDeliveryNo;
                model.Warehouse = data.Warehouse;
                model.LoadingForceFeePrice = data.LoadingForceFeePrice;
                model.ForceFee = data.ForceFee;
                model.Remark = data.Remark;
                model.CreateTime = data.CreateTime.ToString("yyyy-MM-dd");
            }
            else
            {
                model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");
            }

            model.Goods = new List<OutWarehouseBillGoodsViewModel>();
            model.Goods.Add(new OutWarehouseBillGoodsViewModel());

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
            ViewData["Countrys"] = new SelectList(selectListCountry, "Value", "Text", model.ReceiverCountry);

            //生成省份下拉列表项
            List<Province> listState = null;
            if (!string.IsNullOrEmpty(model.ReceiverCountry))
            {
                listState = dd.LoadProvincesByCountry(model.ReceiverCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listState == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listState = new List<Province>();
            }
            List<SelectListItem> selectListState = new List<SelectListItem>();
            selectListState.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListState.AddRange(from p in listState
                                     select new SelectListItem
                                     {
                                         Text = p.Name,
                                         Value = p.Name
                                     });
            ViewData["Provinces"] = new SelectList(selectListState, "Value", "Text", model.ReceiverProvince);

            //生成城市下拉列表项
            List<City> listCity = null;
            if (!string.IsNullOrEmpty(model.ReceiverProvince))
            {
                listCity = dd.LoadCitysByProvince(model.ReceiverCountry, model.ReceiverProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listCity = new List<City>();
            }
            List<SelectListItem> selectListCity = new List<SelectListItem>();
            selectListCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListCity.AddRange(from ci in listCity
                                    select new SelectListItem
                                    {
                                        Text = ci.Name,
                                        Value = ci.Name
                                    });
            ViewData["Citys"] = new SelectList(selectListCity, "Value", "Text", model.ReceiverCity);

            //生成仓库下拉列表项
            List<Warehouse> listWarehouse = dd.LoadWarehouses(LoginAccountId, LoginStaffName, out strErrText);
            if (listWarehouse == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListWarehouse = new List<SelectListItem>();
            selectListWarehouse.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListWarehouse.AddRange(from w in listWarehouse
                                         select new SelectListItem
                                         {
                                             Text = w.Name,
                                             Value = w.Name
                                         });
            ViewData["Warehouses"] = new SelectList(selectListWarehouse, "Value", "Text", model.Warehouse);

            return View(model);
        }

        /// <summary>
        /// GET货物出库页面货物表格
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="outWarehouseBillId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadOutWarehouseBillAllGoodsGrid(string sidx, string sord, int page, int rows, string outWarehouseBillId)
        {
            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<OutWarehouseBillGoods> listGoods = stock.LoadOutWarehouseBillAllGoods(long.Parse(outWarehouseBillId), LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listGoods.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "GoodsNo") + " " + (sord ?? "ASC");
            var data = listGoods.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from g in data
                      select new
                      {
                          id = g.Id,
                          cell = new string[] { 
                              g.Id.ToString(),
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.Brand,
                              g.SpecModel,
                              g.GWeight,
                              g.Grade,
                              g.BatchNo,
                              g.Packing,
                              g.Location,
                              g.Packages.ToString(),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              g.Piles.ToString("#0.######"),
                              g.TenThousands.ToString("#0.######"),
                              g.ProductionDate,
                              g.EnterWarehouseBillId.ToString(),
                              g.EnterWarehouseBillNo
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定客户和仓库是否有待调度发货计划
        /// </summary>
        /// <param name="customerId"></param>
        /// <param name="warehouse"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult HasDispatchDeliverPlans(string customerId, string warehouse)
        {
            //读取数据
            string strErrText;
            PlanSystem plan = new PlanSystem();
            List<DeliverPlan> listPlan = plan.LoadDispatchDeliverPlansByCustomerIdAndWarehouse(long.Parse(customerId), warehouse, LoginAccountId, LoginStaffName, out strErrText);
            if (listPlan == null)
            {
                throw new Exception(strErrText);
            }
            if (listPlan.Count > 0)
                return Json(true, JsonRequestBehavior.AllowGet);
            else
                return Json(false, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET选择货物库存表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="customerId"></param>
        /// <param name="goodsId"></param>
        /// <param name="batchNo"></param>
        /// <param name="packing"></param>
        /// <param name="warehouse"></param>
        /// <param name="location"></param>
        /// <param name="productionDate"></param>
        /// <param name="enterWarehouseBillId"></param>
        /// <param name="consignedDeliveryNo">寄库交货单号</param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadGoodsStockGrid(string sidx, string sord, int page, int rows, string customerId, string goodsId, string batchNo, string packing, string warehouse, string location, string productionDate, string enterWarehouseBillId, string consignedDeliveryNo)
        {
            //读取库存数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<Stock> listStock = stock.LoadGoodsStocksByConditions(customerId, goodsId, batchNo, packing, warehouse, location, productionDate, enterWarehouseBillId, consignedDeliveryNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listStock == null)
            {
                throw new Exception(strErrText);
            }

            //读取已提交未发货数据
            PlanSystem plan = new PlanSystem();
            List<DeliverPlanGoods> listDeliverPlanGoods = plan.LoadDeliverPlanGoodsBalancesByConditions(customerId, goodsId, batchNo, packing, warehouse, location, productionDate, enterWarehouseBillId, consignedDeliveryNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverPlanGoods == null)
            {
                throw new Exception(strErrText);
            }

            //计算结存数
            foreach (Stock s in listStock)
            {
                foreach (DeliverPlanGoods dpg in listDeliverPlanGoods)
                {
                    if (dpg.GoodsId == s.GoodsId &&
                        dpg.BatchNo == s.BatchNo &&
                        dpg.Packing == s.Packing &&
                        dpg.Warehouse == s.Warehouse &&
                        dpg.Location == s.Location &&
                        dpg.ProductionDate == s.ProductionDate &&
                        dpg.EnterWarehouseBillId == s.EnterWarehouseBillId &&
                        (dpg.Packages > 0 || dpg.Tunnages > 0 || dpg.Piles > 0 || dpg.TenThousands > 0))
                    {
                        if (s.Packages < dpg.Packages)
                        {
                            s.Packages = 0;
                            dpg.Packages -= s.Packages;
                        }
                        else
                        {
                            s.Packages -= dpg.Packages;
                            dpg.Packages = 0;
                        }

                        if (s.Tunnages < dpg.Tunnages)
                        {
                            s.Tunnages = 0;
                            dpg.Tunnages -= s.Tunnages;
                        }
                        else
                        {
                            s.Tunnages -= dpg.Tunnages;
                            dpg.Tunnages = 0;
                        }

                        if (s.Piles < dpg.Piles)
                        {
                            s.Piles = 0;
                            dpg.Piles -= s.Piles;
                        }
                        else
                        {
                            s.Piles -= dpg.Piles;
                            dpg.Piles = 0;
                        }

                        if (s.TenThousands < dpg.TenThousands)
                        {
                            s.TenThousands = 0;
                            dpg.TenThousands -= s.TenThousands;
                        }
                        else
                        {
                            s.TenThousands -= dpg.TenThousands;
                            dpg.TenThousands = 0;
                        }
                    }
                }
            }

            //检查已提交未发货剩余数字
            if (listDeliverPlanGoods.Sum(g => g.Packages) > 0 || listDeliverPlanGoods.Sum(g => g.Tunnages) > 0 || listDeliverPlanGoods.Sum(g => g.Piles) > 0 || listDeliverPlanGoods.Sum(g => g.TenThousands) > 0)
            {
                throw new Exception(InnoSoft.LS.Resources.Strings.SubmitedDeliverPlanGoodsNotCompleteSubtract);
            }

            //剔除结存件数为0的记录
            listStock = listStock.Where(s => s.Packages > 0 || s.Tunnages > 0 || s.Piles > 0 || s.TenThousands > 0).ToList();

            //记录编号
            for (int i = 0; i < listStock.Count; i++)
            {
                listStock[i].Id = i + 1;
            }

            //提取当前页面数据
            int nTotalRows = listStock.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            var data = listStock.OrderBy(s => s.BatchNo).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              s.GoodsId.ToString(), 
                              s.GoodsNo, 
                              s.GoodsName,
                              s.Brand,
                              s.SpecModel,
                              s.GWeight,
                              s.Grade,
                              s.BatchNo,
                              s.Packing,
                              s.Location,
                              s.Packages.ToString(),
                              s.Packages != 0 ? (s.Tunnages / s.Packages).ToString("#0.######") : s.PieceWeight.ToString("#0.######"),
                              s.Tunnages.ToString("#0.######"),
                              s.Piles.ToString("#0.######"),
                              s.TenThousands.ToString("#0.######"),
                              s.ProductionDate,
                              s.EnterWarehouseBillId.ToString(),
                              s.EnterWarehouseBillNo,
                              "0",
                              "0",
                              "0",
                              "0"
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands),
                    ActualPackages = 0,
                    ActualTunnages = 0,
                    ActualPiles = 0,
                    ActualTenThousands = 0
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET寄库货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="customerId"></param>
        /// <param name="consignedDeliveryNo"></param>
        /// <param name="warehouse"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadConsignedGoodsGrid(string sidx, string sord, int page, int rows, string customerId, string warehouse, string consignedDeliveryNo)
        {
            //读取寄库交货单库存数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<Stock> listStock = stock.LoadGoodsStocksByConditions(customerId, string.Empty, string.Empty, string.Empty, warehouse, string.Empty, string.Empty, string.Empty, consignedDeliveryNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listStock == null)
            {
                throw new Exception(strErrText);
            }

            //读取寄库交货单未发货数据
            PlanSystem plan = new PlanSystem();
            List<DeliverPlanGoods> listDeliverPlanGoods = plan.LoadDeliverPlanGoodsBalancesByConditions(customerId, string.Empty, string.Empty, string.Empty, warehouse, string.Empty, string.Empty, string.Empty, consignedDeliveryNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverPlanGoods == null)
            {
                throw new Exception(strErrText);
            }

            //计算结存数
            foreach (Stock s in listStock)
            {
                foreach (DeliverPlanGoods dpg in listDeliverPlanGoods)
                {
                    if (dpg.GoodsId == s.GoodsId &&
                        dpg.BatchNo == s.BatchNo &&
                        dpg.Packing == s.Packing &&
                        dpg.Warehouse == s.Warehouse &&
                        dpg.Location == s.Location &&
                        dpg.ProductionDate == s.ProductionDate &&
                        dpg.EnterWarehouseBillId == s.EnterWarehouseBillId &&
                        (dpg.Packages > 0 || dpg.Tunnages > 0 || dpg.Piles > 0 || dpg.TenThousands > 0))
                    {
                        if (s.Packages < dpg.Packages)
                        {
                            s.Packages = 0;
                            dpg.Packages -= s.Packages;
                        }
                        else
                        {
                            s.Packages -= dpg.Packages;
                            dpg.Packages = 0;
                        }

                        if (s.Tunnages < dpg.Tunnages)
                        {
                            s.Tunnages = 0;
                            dpg.Tunnages -= s.Tunnages;
                        }
                        else
                        {
                            s.Tunnages -= dpg.Tunnages;
                            dpg.Tunnages = 0;
                        }

                        if (s.Piles < dpg.Piles)
                        {
                            s.Piles = 0;
                            dpg.Piles -= s.Piles;
                        }
                        else
                        {
                            s.Piles -= dpg.Piles;
                            dpg.Piles = 0;
                        }

                        if (s.TenThousands < dpg.TenThousands)
                        {
                            s.TenThousands = 0;
                            dpg.TenThousands -= s.TenThousands;
                        }
                        else
                        {
                            s.TenThousands -= dpg.TenThousands;
                            dpg.TenThousands = 0;
                        }
                    }
                }
            }

            //检查已提交未发货剩余数字
            if (listDeliverPlanGoods.Sum(g => g.Packages) > 0 || listDeliverPlanGoods.Sum(g => g.Tunnages) > 0 || listDeliverPlanGoods.Sum(g => g.Piles) > 0 || listDeliverPlanGoods.Sum(g => g.TenThousands) > 0)
            {
                throw new Exception(InnoSoft.LS.Resources.Strings.SubmitedDeliverPlanGoodsNotCompleteSubtract);
            }

            //剔除结存件数为0的记录
            listStock = listStock.Where(s => s.Packages > 0 || s.Tunnages > 0 || s.Piles > 0 || s.TenThousands > 0).ToList();

            //记录编号
            for (int i = 0; i < listStock.Count; i++)
            {
                listStock[i].Id = i + 1;
            }

            //提取当前页面数据
            int nTotalRows = listStock.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "GoodsNo") + " " + (sord ?? "ASC");
            var data = listStock.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              "0",
                              s.GoodsId.ToString(), 
                              s.GoodsNo, 
                              s.GoodsName,
                              s.Brand,
                              s.SpecModel,
                              s.GWeight,
                              s.Grade,
                              s.BatchNo,
                              s.Packing,
                              s.Location,
                              s.Packages.ToString("#0"),
                              s.Packages != 0 ? (s.Tunnages / s.Packages).ToString("#0.######") : s.PieceWeight.ToString("#0.######"),
                              s.Tunnages.ToString("#0.######"),
                              s.Piles.ToString("#0.######"),
                              s.TenThousands.ToString("#0.######"),
                              s.ProductionDate,
                              s.EnterWarehouseBillId.ToString(),
                              s.EnterWarehouseBillNo
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST货物出库
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult OutWarehouse(OutWarehouseBillViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查承运单位
                if (model.OutType == InnoSoft.LS.Resources.Options.DeliverGoods)
                {
                    if (model.CarrierId == 0 || model.CarrierName == string.Empty)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterCarrierInfoWhenDeliverGoods);
                    }
                }

                //创建数据
                OutWarehouseBill bill = new OutWarehouseBill();
                bill.Id = model.Id;
                bill.BillNo = model.BillNo;
                bill.PlanId = model.PlanId;
                bill.CustomerId = model.CustomerId;
                bill.CustomerName = model.CustomerName;
                bill.DeliveryNo = model.DeliveryNo;
                bill.OutType = model.OutType;
                bill.ReceiverName = model.ReceiverName;
                bill.ReceiverCountry = model.ReceiverCountry;
                bill.ReceiverProvince = model.ReceiverProvince;
                bill.ReceiverCity = model.ReceiverCity;
                bill.ReceiverAddress = model.ReceiverAddress;
                bill.ReceiverContact = model.ReceiverContact;
                bill.ReceiverContactTel = model.ReceiverContactTel;
                bill.ReceiveType = model.ReceiveType;
                bill.CarNo = model.CarNo;
                bill.TrailerNo = model.TrailerNo;
                bill.CarrierId = model.CarrierId;
                bill.CarrierName = model.CarrierName;
                bill.PayerId = model.PayerId;
                bill.PayerName = model.PayerName;
                bill.IsConsigning = model.IsConsigning;
                bill.ConsignedDeliveryNo = model.ConsignedDeliveryNo;
                bill.Warehouse = model.Warehouse;
                bill.LoadingForceFeePrice = model.LoadingForceFeePrice;
                bill.ForceFee = model.ForceFee;
                bill.Remark = model.Remark;
                bill.CreateTime = DateTime.Parse(model.CreateTime);

                List<OutWarehouseBillGoods> listGoods = new List<OutWarehouseBillGoods>();
                foreach (OutWarehouseBillGoodsViewModel m in model.Goods)
                {
                    OutWarehouseBillGoods g = new OutWarehouseBillGoods();
                    g.Id = m.Id;
                    g.OutWarehouseBillId = m.OutWarehouseBillId;
                    g.GoodsId = m.GoodsId;
                    g.GoodsName = m.GoodsName;
                    g.GoodsNo = m.GoodsNo;
                    g.Brand = m.Brand;
                    g.SpecModel = m.SpecModel;
                    g.GWeight = m.GWeight;
                    g.Grade = m.Grade;
                    g.PieceWeight = m.PieceWeight;
                    g.Packing = m.Packing;
                    g.BatchNo = m.BatchNo;
                    g.Location = m.Location;
                    g.Packages = m.Packages;
                    g.Tunnages = m.Tunnages;
                    g.Piles = m.Piles;
                    g.TenThousands = m.TenThousands;
                    g.ProductionDate = m.ProductionDate;
                    g.EnterWarehouseBillId = m.EnterWarehouseBillId;
                    listGoods.Add(g);
                }

                string strErrText;
                StockSystem stock = new StockSystem();
                if (bill.Id > 0)
                {
                    if (stock.UpdateOutWarehouseBill(bill, listGoods, LoginAccountId, LoginStaffName, out strErrText))
                    {
                        return Json(string.Empty);
                    }
                    else
                    {
                        return Json(strErrText);
                    }
                }
                else
                {
                    if (stock.InsertOutWarehouseBill(bill, listGoods, LoginAccountId, LoginStaffName, out strErrText) > 0)
                    {
                        return Json(string.Empty);
                    }
                    else
                    {
                        return Json(strErrText);
                    }
                }
            }
            return View(model);
        }

        #endregion

        #region 货物移库

        /// <summary>
        /// GET货物移库页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult MoveWarehouse()
        {
            string strErrText;

            //生成仓库下拉列表项
            DDSystem dd = new DDSystem();
            List<Warehouse> listWarehouse = dd.LoadWarehouses(LoginAccountId, LoginStaffName, out strErrText);
            if (listWarehouse == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListWarehouse = new List<SelectListItem>();
            selectListWarehouse.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListWarehouse.AddRange(from w in listWarehouse
                                         select new SelectListItem
                                         {
                                             Text = w.Name,
                                             Value = w.Name
                                         });
            ViewData["Warehouses"] = new SelectList(selectListWarehouse, "Value", "Text");

            return View();
        }

        /// <summary>
        /// GET移库货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="customerId"></param>
        /// <param name="warehouse"></param>
        /// <param name="consignedDeliveryNo"></param>
        /// <param name="goodsId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadAllGoodsStocksGrid(string sidx, string sord, int page, int rows, string customerId, string warehouse, string consignedDeliveryNo, string goodsId)
        {
            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<Stock> listStock = stock.LoadGoodsStocksByConditions(customerId, goodsId, string.Empty, string.Empty, warehouse, string.Empty, string.Empty, string.Empty, consignedDeliveryNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listStock == null)
            {
                throw new Exception(strErrText);
            }

            //读取已提交未发货数据
            PlanSystem plan = new PlanSystem();
            List<DeliverPlanGoods> listDeliverPlanGoods = plan.LoadDeliverPlanGoodsBalancesByConditions(customerId, goodsId, string.Empty, string.Empty, warehouse, string.Empty, string.Empty, string.Empty, consignedDeliveryNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverPlanGoods == null)
            {
                throw new Exception(strErrText);
            }

            //计算结存数
            foreach (Stock s in listStock)
            {
                foreach (DeliverPlanGoods dpg in listDeliverPlanGoods)
                {
                    if (dpg.GoodsId == s.GoodsId &&
                        dpg.BatchNo == s.BatchNo &&
                        dpg.Packing == s.Packing &&
                        dpg.Warehouse == s.Warehouse &&
                        dpg.Location == s.Location &&
                        dpg.ProductionDate == s.ProductionDate &&
                        dpg.EnterWarehouseBillId == s.EnterWarehouseBillId &&
                        (dpg.Packages > 0 || dpg.Tunnages > 0 || dpg.Piles > 0 || dpg.TenThousands > 0))
                    {
                        if (s.Packages < dpg.Packages)
                        {
                            s.Packages = 0;
                            dpg.Packages -= s.Packages;
                        }
                        else
                        {
                            s.Packages -= dpg.Packages;
                            dpg.Packages = 0;
                        }

                        if (s.Tunnages < dpg.Tunnages)
                        {
                            s.Tunnages = 0;
                            dpg.Tunnages -= s.Tunnages;
                        }
                        else
                        {
                            s.Tunnages -= dpg.Tunnages;
                            dpg.Tunnages = 0;
                        }

                        if (s.Piles < dpg.Piles)
                        {
                            s.Piles = 0;
                            dpg.Piles -= s.Piles;
                        }
                        else
                        {
                            s.Piles -= dpg.Piles;
                            dpg.Piles = 0;
                        }

                        if (s.TenThousands < dpg.TenThousands)
                        {
                            s.TenThousands = 0;
                            dpg.TenThousands -= s.TenThousands;
                        }
                        else
                        {
                            s.TenThousands -= dpg.TenThousands;
                            dpg.TenThousands = 0;
                        }
                    }
                }
            }

            //检查已提交未发货剩余数字
            if (listDeliverPlanGoods.Sum(g => g.Packages) > 0 || listDeliverPlanGoods.Sum(g => g.Tunnages) > 0 || listDeliverPlanGoods.Sum(g => g.Piles) > 0 || listDeliverPlanGoods.Sum(g => g.TenThousands) > 0)
            {
                throw new Exception(InnoSoft.LS.Resources.Strings.SubmitedDeliverPlanGoodsNotCompleteSubtract);
            }

            //剔除结存件数为0的记录
            listStock = listStock.Where(s => s.Packages > 0 || s.Tunnages > 0 || s.Piles > 0 || s.TenThousands > 0).ToList();

            //记录编号
            for (int i = 0; i < listStock.Count; i++)
            {
                listStock[i].Id = i + 1;
            }

            //提取当前页面数据
            int nTotalRows = listStock.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "GoodsNo") + " " + (sord ?? "ASC");
            var data = listStock.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              s.GoodsId.ToString(), 
                              s.GoodsNo,
                              s.GoodsName,
                              s.Brand,
                              s.SpecModel,
                              s.GWeight,
                              s.Grade,
                              s.BatchNo,
                              s.Packing,
                              s.Location,
                              s.Packages.ToString(),
                              s.PieceWeight.ToString("#0.######"),
                              s.Tunnages.ToString("#0.######"),
                              s.Piles.ToString("#0.######"),
                              s.TenThousands.ToString("#0.######"),
                              s.ProductionDate,
                              s.EnterWarehouseBillId.ToString(),
                              s.EnterWarehouseBillNo,
                              string.Empty,
                              "0",
                              "0",
                              "0",
                              "0"
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands),
                    NewPackages = 0,
                    NewTunnages = 0,
                    NewPiles = 0,
                    NewTenThousands = 0
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST货物移库
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult MoveWarehouse(MoveWarehouseBillViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                MoveWarehouseBill bill = new MoveWarehouseBill();
                bill.Id = model.Id;
                bill.BillNo = model.BillNo;
                bill.CustomerId = model.CustomerId;
                bill.CustomerName = model.CustomerName;
                bill.Warehouse = model.Warehouse;
                bill.ConsignedDeliveryNo = model.ConsignedDeliveryNo;
                bill.Remark = model.Remark;

                List<MoveWarehouseBillGoods> listGoods = new List<MoveWarehouseBillGoods>();
                foreach (MoveWarehouseBillGoodsViewModel m in model.Goods)
                {
                    MoveWarehouseBillGoods g = new MoveWarehouseBillGoods();
                    g.Id = m.Id;
                    g.MoveWarehouseBillId = m.MoveWarehouseBillId;
                    g.GoodsId = m.GoodsId;
                    g.BatchNo = m.BatchNo;
                    g.Packing = m.Packing;
                    g.PieceWeight = m.PieceWeight;
                    g.Location = m.Location;
                    g.Packages = m.Packages;
                    g.Tunnages = m.Tunnages;
                    g.Piles = m.Piles;
                    g.TenThousands = m.TenThousands;
                    g.ProductionDate = m.ProductionDate;
                    g.EnterWarehouseBillId = m.EnterWarehouseBillId;
                    g.NewLocation = m.NewLocation;
                    g.NewPackages = m.NewPackages;
                    g.NewTunnages = m.NewTunnages;
                    g.NewPiles = m.NewPiles;
                    g.NewTenThousands = m.NewTenThousands;
                    listGoods.Add(g);
                }

                //保存数据
                string strErrText;
                StockSystem stock = new StockSystem();
                if (stock.InsertMoveWarehouseBill(bill, listGoods, LoginAccountId, LoginStaffName, out strErrText) > 0)
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

        #region 查询入库

        /// <summary>
        /// GET查询入库记录页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchEnterWarehouseBills()
        {
            string strErrText;

            //生成入库类别下拉列表项
            List<SelectListItem> selectListEnterType = new List<SelectListItem>();
            selectListEnterType.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListEnterType.Add(new SelectListItem { Text = InnoSoft.LS.Resources.Options.DeliverInStorage, Value = InnoSoft.LS.Resources.Options.DeliverInStorage });
            selectListEnterType.Add(new SelectListItem { Text = InnoSoft.LS.Resources.Options.AllocateInStorage, Value = InnoSoft.LS.Resources.Options.AllocateInStorage });
            ViewData["EnterTypes"] = new SelectList(selectListEnterType, "Value", "Text");

            //生成仓库下拉列表项
            DDSystem dd = new DDSystem();
            List<Warehouse> listWarehouse = dd.LoadWarehouses(LoginAccountId, LoginStaffName, out strErrText);
            if (listWarehouse == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListWarehouse = new List<SelectListItem>();
            selectListWarehouse.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListWarehouse.AddRange(from w in listWarehouse
                                         select new SelectListItem
                                         {
                                             Text = w.Name,
                                             Value = w.Name
                                         });
            ViewData["Warehouses"] = new SelectList(selectListWarehouse, "Value", "Text");

            return View();
        }

        /// <summary>
        /// GET查询入库记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="customerName"></param>
        /// <param name="deliveryNo"></param>
        /// <param name="enterWarehouseBillNo"></param>
        /// <param name="goodsNo"></param>
        /// <param name="goodsName"></param>
        /// <param name="specModel"></param>
        /// <param name="batchNo"></param>
        /// <param name="enterType"></param>
        /// <param name="warehouse"></param>
        /// <param name="isConsigning"></param>
        /// <param name="hasDrayage"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchEnterWarehouseBillsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string customerName, string deliveryNo, string enterWarehouseBillNo, string goodsNo, string goodsName, string specModel, string batchNo, string enterType, string warehouse, string isConsigning, string hasDrayage)
        {
            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<EnterWarehouseBillGoods> listGoods = stock.LoadEnterWarehouseBillGoodsByConditions(startTime, endTime, customerName, deliveryNo, enterWarehouseBillNo, goodsNo, goodsName, specModel, batchNo, enterType, warehouse, isConsigning, hasDrayage, LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listGoods.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listGoods.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from g in data
                      select new
                      {
                          id = g.Id,
                          cell = new string[] { 
                              g.Id.ToString(),
                              g.CreateTime.ToString("yyyy-MM-dd"),
                              g.EnterWarehouseBillId.ToString(),
                              g.EnterWarehouseBillNo,
                              g.DeliveryNo,
                              g.CustomerName,
                              g.EnterType,
                              g.GoodsNo,
                              g.GoodsName,
                              g.Brand,
                              g.SpecModel,
                              g.GWeight,
                              g.Grade,
                              g.Packing,
                              g.BatchNo,
                              g.Warehouse,
                              g.Location,
                              g.Packages.ToString(),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              g.Piles.ToString("#0.######"),
                              g.TenThousands.ToString("#0.######"),
                              g.ProductionDate
                          }
                      }).ToArray(),
                userdata = new
                {
                    CreateTime = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST删除入库单
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteEnterWarehouseBill(string id)
        {
            string strErrText;
            StockSystem stock = new StockSystem();
            if (stock.DeleteEnterWarehouseBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// GET导出入库单
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportEnterWarehouseBills()
        {
            //读取条件
            var request = HttpContext.Request;

            string strStartTime = request.QueryString["startTime"] ?? string.Empty;
            string strEndTime = request.QueryString["endTime"] ?? string.Empty;
            string strCustomerName = request.QueryString["customerName"] ?? string.Empty;
            string strDeliveryNo = request.QueryString["deliveryNo"] ?? string.Empty;
            string strEnterWarehouseBillNo = request.QueryString["enterWarehouseBillNo"] ?? string.Empty;
            string strGoodsNo = request.QueryString["goodsNo"] ?? string.Empty;
            string strGoodsName = request.QueryString["goodsName"] ?? string.Empty;
            string strSpecModel = request.QueryString["specModel"] ?? string.Empty;
            string strBatchNo = request.QueryString["batchNo"] ?? string.Empty;
            string strEnterType = request.QueryString["enterType"] ?? string.Empty;
            string strWarehouse = request.QueryString["warehouse"] ?? string.Empty;
            string strIsConsigning = request.QueryString["isConsigning"] ?? "false";
            string strHasDrayage = request.QueryString["hasDrayage"] ?? "false";

            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<EnterWarehouseBillGoods> listGoods = stock.LoadEnterWarehouseBillGoodsByConditions(strStartTime, strEndTime, strCustomerName, strDeliveryNo, strEnterWarehouseBillNo, strGoodsNo, strGoodsName, strSpecModel, strBatchNo, strEnterType, strWarehouse, strIsConsigning, strHasDrayage, LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                throw new Exception(strErrText);
            }

            //生成GridView
            BoundField colCreateTime = new BoundField();
            colCreateTime.HeaderText = InnoSoft.LS.Resources.Labels.EnterWarehouseTime;
            colCreateTime.DataField = "CreateTime";

            BoundField colEnterWarehouseBillNo = new BoundField();
            colEnterWarehouseBillNo.HeaderText = InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo;
            colEnterWarehouseBillNo.DataField = "EnterWarehouseBillNo";

            BoundField colDeliveryNo = new BoundField();
            colDeliveryNo.HeaderText = InnoSoft.LS.Resources.Labels.DeliveryNo;
            colDeliveryNo.DataField = "DeliveryNo";

            BoundField colCustomerName = new BoundField();
            colCustomerName.HeaderText = InnoSoft.LS.Resources.Labels.CustomerName;
            colCustomerName.DataField = "CustomerName";

            BoundField colGoodsNo = new BoundField();
            colGoodsNo.HeaderText = InnoSoft.LS.Resources.Labels.GoodsNo;
            colGoodsNo.DataField = "GoodsNo";

            BoundField colGoodsName = new BoundField();
            colGoodsName.HeaderText = InnoSoft.LS.Resources.Labels.GoodsName;
            colGoodsName.DataField = "GoodsName";

            BoundField colBrand = new BoundField();
            colBrand.HeaderText = InnoSoft.LS.Resources.Labels.Brand;
            colBrand.DataField = "Brand";

            BoundField colSpecModel = new BoundField();
            colSpecModel.HeaderText = InnoSoft.LS.Resources.Labels.Specification;
            colSpecModel.DataField = "SpecModel";

            BoundField colGWeight = new BoundField();
            colGWeight.HeaderText = InnoSoft.LS.Resources.Labels.GrammeWeight;
            colGWeight.DataField = "GWeight";

            BoundField colGrade = new BoundField();
            colGrade.HeaderText = InnoSoft.LS.Resources.Labels.Grade;
            colGrade.DataField = "Grade";

            BoundField colPacking = new BoundField();
            colPacking.HeaderText = InnoSoft.LS.Resources.Labels.PackingSpecification;
            colPacking.DataField = "Packing";

            BoundField colBatchNo = new BoundField();
            colBatchNo.HeaderText = InnoSoft.LS.Resources.Labels.BatchNo;
            colBatchNo.DataField = "BatchNo";

            BoundField colWarehouse = new BoundField();
            colWarehouse.HeaderText = InnoSoft.LS.Resources.Labels.Warehouse;
            colWarehouse.DataField = "Warehouse";

            BoundField colLocation = new BoundField();
            colLocation.HeaderText = InnoSoft.LS.Resources.Labels.Location;
            colLocation.DataField = "Location";

            BoundField colPackages = new BoundField();
            colPackages.HeaderText = InnoSoft.LS.Resources.Labels.Pieces;
            colPackages.DataField = "Packages";

            BoundField colPieceWeight = new BoundField();
            colPieceWeight.HeaderText = InnoSoft.LS.Resources.Labels.PieceWeight;
            colPieceWeight.DataField = "PieceWeight";

            BoundField colTunnages = new BoundField();
            colTunnages.HeaderText = InnoSoft.LS.Resources.Labels.Tunnages;
            colTunnages.DataField = "Tunnages";

            BoundField colPiles = new BoundField();
            colPiles.HeaderText = InnoSoft.LS.Resources.Labels.Piles;
            colPiles.DataField = "Piles";

            BoundField colTenThousands = new BoundField();
            colTenThousands.HeaderText = InnoSoft.LS.Resources.Labels.TenThousands;
            colTenThousands.DataField = "TenThousands";

            BoundField colProductionDate = new BoundField();
            colProductionDate.HeaderText = InnoSoft.LS.Resources.Labels.ProductionDate;
            colProductionDate.DataField = "ProductionDate";


            var grid = new GridView();
            grid.Columns.Add(colCreateTime);
            grid.Columns.Add(colEnterWarehouseBillNo);
            grid.Columns.Add(colDeliveryNo);
            grid.Columns.Add(colCustomerName);
            grid.Columns.Add(colGoodsNo);
            grid.Columns.Add(colGoodsName);
            grid.Columns.Add(colBrand);
            grid.Columns.Add(colSpecModel);
            grid.Columns.Add(colGWeight);
            grid.Columns.Add(colGrade);
            grid.Columns.Add(colPacking);
            grid.Columns.Add(colBatchNo);
            grid.Columns.Add(colWarehouse);
            grid.Columns.Add(colLocation);
            grid.Columns.Add(colPackages);
            grid.Columns.Add(colPieceWeight);
            grid.Columns.Add(colTunnages);
            grid.Columns.Add(colPiles);
            grid.Columns.Add(colTenThousands);
            grid.Columns.Add(colProductionDate);

            grid.AutoGenerateColumns = false;

            grid.RowDataBound += new GridViewRowEventHandler(EnterWarehouseBillsGrid_RowDataBound);
            grid.DataSource = from g in listGoods
                              select new
                              {
                                  CreateTime = g.CreateTime.ToString("yyyy-MM-dd"),
                                  EnterWarehouseBillNo = g.EnterWarehouseBillNo,
                                  DeliveryNo = g.DeliveryNo,
                                  CustomerName = g.CustomerName,
                                  GoodsNo = g.GoodsNo,
                                  GoodsName = g.GoodsName,
                                  Brand = g.Brand,
                                  SpecModel = g.SpecModel,
                                  GWeight = g.GWeight,
                                  Grade = g.Grade,
                                  Packing = g.Packing,
                                  BatchNo = g.BatchNo,
                                  Warehouse = g.Warehouse,
                                  Location = g.Location,
                                  Packages = g.Packages.ToString(),
                                  PieceWeight = g.PieceWeight.ToString("#0.######"),
                                  Tunnages = g.Tunnages.ToString("#0.######"),
                                  Piles = g.Piles.ToString("#0.######"),
                                  TenThousands = g.TenThousands.ToString("#0.######"),
                                  ProductionDate = g.ProductionDate
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=EnterWarehouseBills.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(@"<style> .text { mso-number-format:'\@'; } </style>");//定义字符串转换样式
            Response.Write(sw.ToString());
            Response.End();

            return View("SearchEnterWarehouseBills");
        }

        private void EnterWarehouseBillsGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[2].Attributes.Add("class", "text");//防止交货单号被自动转换为整形
                e.Row.Cells[4].Attributes.Add("class", "text");//防止货物编号被自动转换为整形
                e.Row.Cells[11].Attributes.Add("class", "text");//防止批次号被自动转换为整形
            }
        }

        #endregion

        #region 查询出库

        /// <summary>
        /// GET查询出库记录页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchOutWarehouseBills()
        {
            string strErrText;

            //生成出库类别下拉列表项
            List<SelectListItem> selectListOutType = new List<SelectListItem>();
            selectListOutType.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListOutType.Add(new SelectListItem { Text = InnoSoft.LS.Resources.Options.DeliverGoods, Value = InnoSoft.LS.Resources.Options.DeliverGoods });
            selectListOutType.Add(new SelectListItem { Text = InnoSoft.LS.Resources.Options.AllocateGoods, Value = InnoSoft.LS.Resources.Options.AllocateGoods });
            ViewData["OutTypes"] = new SelectList(selectListOutType, "Value", "Text");

            //生成仓库下拉列表项
            DDSystem dd = new DDSystem();
            List<Warehouse> listWarehouse = dd.LoadWarehouses(LoginAccountId, LoginStaffName, out strErrText);
            if (listWarehouse == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListWarehouse = new List<SelectListItem>();
            selectListWarehouse.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListWarehouse.AddRange(from w in listWarehouse
                                         select new SelectListItem
                                         {
                                             Text = w.Name,
                                             Value = w.Name
                                         });
            ViewData["Warehouses"] = new SelectList(selectListWarehouse, "Value", "Text");

            //生成收货方式下拉列表项
            List<SelectListItem> selectListReceiveType = new List<SelectListItem>();
            selectListReceiveType.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListReceiveType.Add(new SelectListItem { Text = InnoSoft.LS.Resources.Options.PickUpDelivery, Value = InnoSoft.LS.Resources.Options.PickUpDelivery });
            selectListReceiveType.Add(new SelectListItem { Text = InnoSoft.LS.Resources.Options.PickUpSelf, Value = InnoSoft.LS.Resources.Options.PickUpSelf });
            ViewData["ReceiveTypes"] = new SelectList(selectListReceiveType, "Value", "Text");

            return View();
        }

        /// <summary>
        /// GET查询出库记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="customerName"></param>
        /// <param name="deliveryNo"></param>
        /// <param name="outWarehouseBillNo"></param>
        /// <param name="goodsNo"></param>
        /// <param name="batchNo"></param>
        /// <param name="carNo"></param>
        /// <param name="receiverName"></param>
        /// <param name="outType"></param>
        /// <param name="warehouse"></param>
        /// <param name="receiveType"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchOutWarehouseBillsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string customerName, string deliveryNo, string outWarehouseBillNo, string goodsNo, string batchNo, string carNo, string receiverName, string outType, string warehouse, string receiveType)
        {
            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<OutWarehouseBillGoods> listGoods = stock.LoadOutWarehouseBillGoodsByConditions(startTime, endTime, customerName, deliveryNo, outWarehouseBillNo, goodsNo, batchNo, carNo, receiverName, outType, warehouse, receiveType, LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listGoods.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listGoods.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from g in data
                      select new
                      {
                          id = g.Id,
                          cell = new string[] { 
                              g.Id.ToString(),
                              g.CreateTime.ToString("yyyy-MM-dd"),
                              g.OutWarehouseBillId.ToString(),
                              g.OutWarehouseBillNo,
                              g.DeliveryNo,
                              g.CarNo,
                              g.CustomerName,
                              g.ReceiverName,
                              g.ReceiverProvince + g.ReceiverCity + g.ReceiverAddress,
                              g.Warehouse,
                              g.GoodsNo,
                              g.GoodsName,
                              g.Brand,
                              g.SpecModel,
                              g.GWeight,
                              g.Grade,
                              g.BatchNo,
                              g.ProductionDate,
                              g.Packing,
                              g.Location,
                              g.Packages.ToString(),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              g.Piles.ToString("#0.######"),
                              g.TenThousands.ToString("#0.######"),
                              g.EnterWarehouseBillNo
                          }
                      }).ToArray(),
                userdata = new
                {
                    CreateTime = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST删除出库单数据
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteOutWarehouseBill(string id)
        {
            string strErrText;
            StockSystem stock = new StockSystem();
            if (stock.DeleteOutWarehouseBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// GET导出出库单
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportOutWarehouseBills()
        {
            //读取条件
            var request = HttpContext.Request;

            string strStartTime = request.QueryString["startTime"] ?? string.Empty;
            string strEndTime = request.QueryString["endTime"] ?? string.Empty;
            string strCustomerName = request.QueryString["customerName"] ?? string.Empty;
            string strDeliveryNo = request.QueryString["deliveryNo"] ?? string.Empty;
            string strOutWarehouseBillNo = request.QueryString["outWarehouseBillNo"] ?? string.Empty;
            string strGoodsNo = request.QueryString["goodsNo"] ?? string.Empty;
            string strBatchNo = request.QueryString["batchNo"] ?? string.Empty;
            string strCarNo = request.QueryString["carNo"] ?? string.Empty;
            string strReceiverName = request.QueryString["receiverName"] ?? string.Empty;
            string strOutType = request.QueryString["outType"] ?? string.Empty;
            string strWarehouse = request.QueryString["warehouse"] ?? string.Empty;
            string strReceiveType = request.QueryString["receiveType"] ?? string.Empty;

            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<OutWarehouseBillGoods> listGoods = stock.LoadOutWarehouseBillGoodsByConditions(strStartTime, strEndTime, strCustomerName, strDeliveryNo, strOutWarehouseBillNo, strGoodsNo, strBatchNo, strCarNo, strReceiverName, strOutType, strWarehouse, strReceiveType, LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                throw new Exception(strErrText);
            }

            //生成GridView
            BoundField colCreateTime = new BoundField();
            colCreateTime.HeaderText = InnoSoft.LS.Resources.Labels.OutWarehouseTime;
            colCreateTime.DataField = "CreateTime";

            BoundField colOutWarehouseBillNo = new BoundField();
            colOutWarehouseBillNo.HeaderText = InnoSoft.LS.Resources.Labels.OutWarehouseBillNo;
            colOutWarehouseBillNo.DataField = "OutWarehouseBillNo";

            BoundField colDeliveryNo = new BoundField();
            colDeliveryNo.HeaderText = InnoSoft.LS.Resources.Labels.DeliveryNo;
            colDeliveryNo.DataField = "DeliveryNo";

            BoundField colCarNo = new BoundField();
            colCarNo.HeaderText = InnoSoft.LS.Resources.Labels.CarNo;
            colCarNo.DataField = "CarNo";

            BoundField colCustomerName = new BoundField();
            colCustomerName.HeaderText = InnoSoft.LS.Resources.Labels.CustomerName;
            colCustomerName.DataField = "CustomerName";

            BoundField colReceiverName = new BoundField();
            colReceiverName.HeaderText = InnoSoft.LS.Resources.Labels.ReceiverName;
            colReceiverName.DataField = "ReceiverName";

            BoundField colReceiverAddress = new BoundField();
            colReceiverAddress.HeaderText = InnoSoft.LS.Resources.Labels.ReceiverAddress;
            colReceiverAddress.DataField = "ReceiverAddress";

            BoundField colWarehouse = new BoundField();
            colWarehouse.HeaderText = InnoSoft.LS.Resources.Labels.Warehouse;
            colWarehouse.DataField = "Warehouse";

            BoundField colGoodsNo = new BoundField();
            colGoodsNo.HeaderText = InnoSoft.LS.Resources.Labels.GoodsNo;
            colGoodsNo.DataField = "GoodsNo";

            BoundField colGoodsName = new BoundField();
            colGoodsName.HeaderText = InnoSoft.LS.Resources.Labels.GoodsName;
            colGoodsName.DataField = "GoodsName";

            BoundField colBrand = new BoundField();
            colBrand.HeaderText = InnoSoft.LS.Resources.Labels.Brand;
            colBrand.DataField = "Brand";

            BoundField colSpecModel = new BoundField();
            colSpecModel.HeaderText = InnoSoft.LS.Resources.Labels.Specification;
            colSpecModel.DataField = "SpecModel";

            BoundField colGWeight = new BoundField();
            colGWeight.HeaderText = InnoSoft.LS.Resources.Labels.GrammeWeight;
            colGWeight.DataField = "GWeight";

            BoundField colGrade = new BoundField();
            colGrade.HeaderText = InnoSoft.LS.Resources.Labels.Grade;
            colGrade.DataField = "Grade";

            BoundField colBatchNo = new BoundField();
            colBatchNo.HeaderText = InnoSoft.LS.Resources.Labels.BatchNo;
            colBatchNo.DataField = "BatchNo";

            BoundField colPacking = new BoundField();
            colPacking.HeaderText = InnoSoft.LS.Resources.Labels.PackingSpecification;
            colPacking.DataField = "Packing";

            BoundField colLocation = new BoundField();
            colLocation.HeaderText = InnoSoft.LS.Resources.Labels.Location;
            colLocation.DataField = "Location";

            BoundField colPackages = new BoundField();
            colPackages.HeaderText = InnoSoft.LS.Resources.Labels.Pieces;
            colPackages.DataField = "Packages";

            BoundField colPieceWeight = new BoundField();
            colPieceWeight.HeaderText = InnoSoft.LS.Resources.Labels.PieceWeight;
            colPieceWeight.DataField = "PieceWeight";

            BoundField colTunnages = new BoundField();
            colTunnages.HeaderText = InnoSoft.LS.Resources.Labels.Tunnages;
            colTunnages.DataField = "Tunnages";

            BoundField colPiles = new BoundField();
            colPiles.HeaderText = InnoSoft.LS.Resources.Labels.Piles;
            colPiles.DataField = "Piles";

            BoundField colTenThousands = new BoundField();
            colTenThousands.HeaderText = InnoSoft.LS.Resources.Labels.TenThousands;
            colTenThousands.DataField = "TenThousands";

            BoundField colProductionDate = new BoundField();
            colProductionDate.HeaderText = InnoSoft.LS.Resources.Labels.ProductionDate;
            colProductionDate.DataField = "ProductionDate";

            BoundField colEnterWarehouseBillNo = new BoundField();
            colEnterWarehouseBillNo.HeaderText = InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo;
            colEnterWarehouseBillNo.DataField = "EnterWarehouseBillNo";

            var grid = new GridView();
            grid.Columns.Add(colCreateTime);
            grid.Columns.Add(colOutWarehouseBillNo);
            grid.Columns.Add(colDeliveryNo);
            grid.Columns.Add(colCarNo);
            grid.Columns.Add(colCustomerName);
            grid.Columns.Add(colReceiverName);
            grid.Columns.Add(colReceiverAddress);
            grid.Columns.Add(colWarehouse);
            grid.Columns.Add(colGoodsNo);
            grid.Columns.Add(colGoodsName);
            grid.Columns.Add(colBrand);
            grid.Columns.Add(colSpecModel);
            grid.Columns.Add(colGWeight);
            grid.Columns.Add(colGrade);
            grid.Columns.Add(colBatchNo);
            grid.Columns.Add(colPacking);
            grid.Columns.Add(colLocation);
            grid.Columns.Add(colPackages);
            grid.Columns.Add(colPieceWeight);
            grid.Columns.Add(colTunnages);
            grid.Columns.Add(colPiles);
            grid.Columns.Add(colTenThousands);
            grid.Columns.Add(colProductionDate);
            grid.Columns.Add(colEnterWarehouseBillNo);

            grid.AutoGenerateColumns = false;

            grid.RowDataBound += new GridViewRowEventHandler(OutWarehouseBillsGrid_RowDataBound);
            grid.DataSource = from g in listGoods
                              select new
                              {
                                  CreateTime = g.CreateTime.ToString("yyyy-MM-dd"),
                                  OutWarehouseBillNo = g.OutWarehouseBillNo,
                                  DeliveryNo = g.DeliveryNo,
                                  CarNo = g.CarNo,
                                  CustomerName = g.CustomerName,
                                  ReceiverName = g.ReceiverName,
                                  ReceiverAddress = g.ReceiverAddress,
                                  Warehouse = g.Warehouse,
                                  GoodsNo = g.GoodsNo,
                                  GoodsName = g.GoodsName,
                                  Brand = g.Brand,
                                  SpecModel = g.SpecModel,
                                  GWeight = g.GWeight,
                                  Grade = g.Grade,
                                  BatchNo = g.BatchNo,
                                  Packing = g.Packing,
                                  Location = g.Location,
                                  Packages = g.Packages.ToString(),
                                  PieceWeight = g.PieceWeight.ToString("#0.######"),
                                  Tunnages = g.Tunnages.ToString("#0.######"),
                                  Piles = g.Piles.ToString("#0.######"),
                                  TenThousands = g.TenThousands.ToString("#0.######"),
                                  ProductionDate = g.ProductionDate,
                                  EnterWarehouseBillNo = g.EnterWarehouseBillNo
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=OutWarehouseBills.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(@"<style> .text { mso-number-format:'\@'; } </style>");//定义字符串转换样式
            Response.Write(sw.ToString());
            Response.End();

            return View("SearchOutWarehouseBills");
        }

        private void OutWarehouseBillsGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[2].Attributes.Add("class", "text");//防止交货单号被自动转换为整形
                e.Row.Cells[8].Attributes.Add("class", "text");//防止货物编号被自动转换为整形
                e.Row.Cells[14].Attributes.Add("class", "text");//防止批次号被自动转换为整形
            }
        }

        #endregion

        #region 查询移库

        /// <summary>
        /// GET查询移库记录页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchMoveWarehouseBills()
        {
            string strErrText;

            //生成仓库下拉列表项
            DDSystem dd = new DDSystem();
            List<Warehouse> listWarehouse = dd.LoadWarehouses(LoginAccountId, LoginStaffName, out strErrText);
            if (listWarehouse == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListWarehouse = new List<SelectListItem>();
            selectListWarehouse.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListWarehouse.AddRange(from w in listWarehouse
                                         select new SelectListItem
                                         {
                                             Text = w.Name,
                                             Value = w.Name
                                         });
            ViewData["Warehouses"] = new SelectList(selectListWarehouse, "Value", "Text");

            return View();
        }

        /// <summary>
        /// GET查询移库记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="customerName"></param>
        /// <param name="moveWarehouseBillNo"></param>
        /// <param name="goodsNo"></param>
        /// <param name="warehouse"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchMoveWarehouseBillsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string customerName, string moveWarehouseBillNo, string goodsNo, string warehouse)
        {
            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<MoveWarehouseBillGoods> listGoods = stock.LoadMoveWarehouseBillGoodsByConditions(startTime, endTime, customerName, moveWarehouseBillNo, goodsNo, warehouse, LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listGoods.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listGoods.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from g in data
                      select new
                      {
                          id = g.Id,
                          cell = new string[] { 
                              g.Id.ToString(),
                              g.CreateTime.ToString("yyyy-MM-dd"),
                              g.MoveWarehouseBillId.ToString(),
                              g.MoveWarehouseBillNo,
                              g.CustomerName,
                              g.Warehouse,
                              g.GoodsNo,
                              g.GoodsName,
                              g.Brand,
                              g.SpecModel,
                              g.GWeight,
                              g.Grade,
                              g.BatchNo,
                              g.ProductionDate,
                              g.Packing,
                              g.Location,
                              g.Packages.ToString(),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              g.Piles.ToString("#0.######"),
                              g.TenThousands.ToString("#0.######"),
                              g.DeliveryNo,
                              g.EnterWarehouseBillNo,
                              g.NewLocation,
                              g.NewPackages.ToString(),
                              g.NewTunnages.ToString("#0.######"),
                              g.NewPiles.ToString("#0.######"),
                              g.NewTenThousands.ToString("#0.######")
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST删除移库单数据
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteMoveWarehouseBill(string id)
        {
            string strErrText;
            StockSystem stock = new StockSystem();
            if (stock.DeleteMoveWarehouseBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 收发存汇总

        /// <summary>
        /// GET收发存汇总页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult EnterOutBalanceSummary()
        {
            string strErrText;

            //生成仓库下拉列表项
            DDSystem dd = new DDSystem();
            List<Warehouse> listWarehouse = dd.LoadWarehouses(LoginAccountId, LoginStaffName, out strErrText);
            if (listWarehouse == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListWarehouse = new List<SelectListItem>();
            selectListWarehouse.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListWarehouse.AddRange(from w in listWarehouse
                                         select new SelectListItem
                                         {
                                             Text = w.Name,
                                             Value = w.Name
                                         });
            ViewData["Warehouses"] = new SelectList(selectListWarehouse, "Value", "Text");

            return View();
        }

        /// <summary>
        /// GET收发存汇总表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="customerName"></param>
        /// <param name="deliveryNo"></param>
        /// <param name="enterWarehouseBillNo"></param>
        /// <param name="goodsNo"></param>
        /// <param name="batchNo"></param>
        /// <param name="warehouse"></param>
        /// <param name="isConsigning"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadEnterOutBalanceSummaryGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string customerName, string deliveryNo, string enterWarehouseBillNo, string goodsNo, string batchNo, string warehouse, string isConsigning)
        {
            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<EnterOutBalanceSummary> listSummary = stock.LoadEnterOutBalanceSummariesByConditions(startTime, endTime, customerName, deliveryNo, enterWarehouseBillNo, goodsNo, batchNo, warehouse, isConsigning, LoginAccountId, LoginStaffName, out strErrText);
            if (listSummary == null)
            {
                throw new Exception(strErrText);
            }

            //记录编号
            for (int i = 0; i < listSummary.Count; i++)
            {
                listSummary[i].Id = i + 1;
            }

            //提取当前页面数据
            int nTotalRows = listSummary.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CustomerName") + " " + (sord ?? "ASC");
            var data = listSummary.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              s.CustomerName,
                              s.GoodsNo,
                              s.GoodsName,
                              s.Brand,
                              s.SpecModel,
                              s.GWeight,
                              s.Grade,
                              s.BatchNo,
                              s.Warehouse,
                              s.Location,
                              s.StartPackages.ToString(),
                              s.StartTunnages.ToString("#0.######"),
                              s.StartPiles.ToString("#0.######"),
                              s.StartTenThousands.ToString("#0.######"),
                              s.TotalEnterWarehousePackages.ToString(),
                              s.TotalEnterWarehouseTunnages.ToString("#0.######"),
                              s.TotalEnterWarehousePiles.ToString("#0.######"),
                              s.TotalEnterWarehouseTenThousands.ToString("#0.######"),
                              s.TotalOutWarehousePackages.ToString(),
                              s.TotalOutWarehouseTunnages.ToString("#0.######"),
                              s.TotalOutWarehousePiles.ToString("#0.######"),
                              s.TotalOutWarehouseTenThousands.ToString("#0.######"),
                              s.EndPackages.ToString(),
                              s.EndTunnages.ToString("#0.######"),
                              s.EndPiles.ToString("#0.######"),
                              s.EndTenThousands.ToString("#0.######"),
                              s.TotalAllocateEnterWarehousePackages.ToString(),
                              s.TotalAllocateEnterWarehouseTunnages.ToString("#0.######"),
                              s.TotalAllocateEnterWarehousePiles.ToString("#0.######"),
                              s.TotalAllocateEnterWarehouseTenThousands.ToString("#0.######"),
                              s.TotalAllocateOutWarehousePackages.ToString(),
                              s.TotalAllocateOutWarehouseTunnages.ToString("#0.######"),
                              s.TotalAllocateOutWarehousePiles.ToString("#0.######"),
                              s.TotalAllocateOutWarehouseTenThousands.ToString("#0.######"),
                              s.ProductionDate
                          }
                      }).ToArray(),
                userdata = new
                {
                    CustomerName = InnoSoft.LS.Resources.Labels.Total,
                    StartPackages = data.Sum(s => s.StartPackages),
                    StartTunnages = data.Sum(s => s.StartTunnages),
                    StartPiles = data.Sum(s => s.StartPiles),
                    StartTenThousands = data.Sum(s => s.StartTenThousands),
                    TotalEnterWarehousePackages = data.Sum(s => s.TotalEnterWarehousePackages),
                    TotalEnterWarehouseTunnages = data.Sum(s => s.TotalEnterWarehouseTunnages),
                    TotalEnterWarehousePiles = data.Sum(s => s.TotalEnterWarehousePiles),
                    TotalEnterWarehouseTenThousands = data.Sum(s => s.TotalEnterWarehouseTenThousands),
                    TotalOutWarehousePackages = data.Sum(s => s.TotalOutWarehousePackages),
                    TotalOutWarehouseTunnages = data.Sum(s => s.TotalOutWarehouseTunnages),
                    TotalOutWarehousePiles = data.Sum(s => s.TotalOutWarehousePiles),
                    TotalOutWarehouseTenThousands = data.Sum(s => s.TotalOutWarehouseTenThousands),
                    EndPackages = data.Sum(s => s.EndPackages),
                    EndTunnages = data.Sum(s => s.EndTunnages),
                    EndPiles = data.Sum(s => s.EndPiles),
                    EndTenThousands = data.Sum(s => s.EndTenThousands),
                    TotalAllocateEnterWarehousePackages = data.Sum(s => s.TotalAllocateEnterWarehousePackages),
                    TotalAllocateEnterWarehouseTunnages = data.Sum(s => s.TotalAllocateEnterWarehouseTunnages),
                    TotalAllocateEnterWarehousePiles = data.Sum(s => s.TotalAllocateEnterWarehousePiles),
                    TotalAllocateEnterWarehouseTenThousands = data.Sum(s => s.TotalAllocateEnterWarehouseTenThousands),
                    TotalAllocateOutWarehousePackages = data.Sum(s => s.TotalAllocateOutWarehousePackages),
                    TotalAllocateOutWarehouseTunnages = data.Sum(s => s.TotalAllocateOutWarehouseTunnages),
                    TotalAllocateOutWarehousePiles = data.Sum(s => s.TotalAllocateOutWarehousePiles),
                    TotalAllocateOutWarehouseTenThousands = data.Sum(s => s.TotalAllocateOutWarehouseTenThousands)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET导出收发存汇总表
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportEnterOutBalanceSummary()
        {
            //读取条件
            var request = HttpContext.Request;

            string strStartTime = request.QueryString["startTime"] ?? string.Empty;
            string strEndTime = request.QueryString["endTime"] ?? string.Empty;
            string strCustomerName = request.QueryString["customerName"] ?? string.Empty;
            string strDeliveryNo = request.QueryString["deliveryNo"] ?? string.Empty;
            string strEnterWarehouseBillNo = request.QueryString["enterWarehouseBillNo"] ?? string.Empty;
            string strGoodsNo = request.QueryString["goodsNo"] ?? string.Empty;
            string strBatchNo = request.QueryString["batchNo"] ?? string.Empty;
            string strWarehouse = request.QueryString["warehouse"] ?? string.Empty;
            string strIsConsigning = request.QueryString["isConsigning"] ?? "false";

            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<EnterOutBalanceSummary> listSummary = stock.LoadEnterOutBalanceSummariesByConditions(strStartTime, strEndTime, strCustomerName, strDeliveryNo, strEnterWarehouseBillNo, strGoodsNo, strBatchNo, strWarehouse, strIsConsigning, LoginAccountId, LoginStaffName, out strErrText);
            if (listSummary == null)
            {
                throw new Exception(strErrText);
            }

            //生成结果数据
            List<EnterOutBalanceSummary> listRet = new List<EnterOutBalanceSummary>();
            {
                //按客户分组
                var grpCustomerNames = listSummary.GroupBy(f => f.CustomerName).OrderBy(f => f.Key);
                foreach (var grpCustomerName in grpCustomerNames)
                {
                    List<EnterOutBalanceSummary> data = grpCustomerName.ToList<EnterOutBalanceSummary>();
                    listRet.AddRange(data);

                    //生成小计行
                    EnterOutBalanceSummary subtotal = new EnterOutBalanceSummary();
                    subtotal.CustomerName = grpCustomerName.Key;
                    subtotal.GoodsNo = InnoSoft.LS.Resources.Labels.Subtotal;
                    subtotal.StartPackages = data.Sum(s => s.StartPackages);
                    subtotal.StartTunnages = data.Sum(s => s.StartTunnages);
                    subtotal.StartPiles = data.Sum(s => s.StartPiles);
                    subtotal.StartTenThousands = data.Sum(s => s.StartTenThousands);
                    subtotal.TotalEnterWarehousePackages = data.Sum(s => s.TotalEnterWarehousePackages);
                    subtotal.TotalEnterWarehouseTunnages = data.Sum(s => s.TotalEnterWarehouseTunnages);
                    subtotal.TotalEnterWarehousePiles = data.Sum(s => s.TotalEnterWarehousePiles);
                    subtotal.TotalEnterWarehouseTenThousands = data.Sum(s => s.TotalEnterWarehouseTenThousands);
                    subtotal.TotalOutWarehousePackages = data.Sum(s => s.TotalOutWarehousePackages);
                    subtotal.TotalOutWarehouseTunnages = data.Sum(s => s.TotalOutWarehouseTunnages);
                    subtotal.TotalOutWarehousePiles = data.Sum(s => s.TotalOutWarehousePiles);
                    subtotal.TotalOutWarehouseTenThousands = data.Sum(s => s.TotalOutWarehouseTenThousands);
                    subtotal.EndPackages = data.Sum(s => s.EndPackages);
                    subtotal.EndTunnages = data.Sum(s => s.EndTunnages);
                    subtotal.EndPiles = data.Sum(s => s.EndPiles);
                    subtotal.EndTenThousands = data.Sum(s => s.EndTenThousands);
                    subtotal.TotalAllocateEnterWarehousePackages = data.Sum(s => s.TotalAllocateEnterWarehousePackages);
                    subtotal.TotalAllocateEnterWarehouseTunnages = data.Sum(s => s.TotalAllocateEnterWarehouseTunnages);
                    subtotal.TotalAllocateEnterWarehousePiles = data.Sum(s => s.TotalAllocateEnterWarehousePiles);
                    subtotal.TotalAllocateEnterWarehouseTenThousands = data.Sum(s => s.TotalAllocateEnterWarehouseTenThousands);
                    subtotal.TotalAllocateOutWarehousePackages = data.Sum(s => s.TotalAllocateOutWarehousePackages);
                    subtotal.TotalAllocateOutWarehouseTunnages = data.Sum(s => s.TotalAllocateOutWarehouseTunnages);
                    subtotal.TotalAllocateOutWarehousePiles = data.Sum(s => s.TotalAllocateOutWarehousePiles);
                    subtotal.TotalAllocateOutWarehouseTenThousands = data.Sum(s => s.TotalAllocateOutWarehouseTenThousands);
                    listRet.Add(subtotal);
                }

                //生成合计行
                EnterOutBalanceSummary total = new EnterOutBalanceSummary();
                total.CustomerName = InnoSoft.LS.Resources.Labels.Total;
                total.StartPackages = listSummary.Sum(s => s.StartPackages);
                total.StartTunnages = listSummary.Sum(s => s.StartTunnages);
                total.StartPiles = listSummary.Sum(s => s.StartPiles);
                total.StartTenThousands = listSummary.Sum(s => s.StartTenThousands);
                total.TotalEnterWarehousePackages = listSummary.Sum(s => s.TotalEnterWarehousePackages);
                total.TotalEnterWarehouseTunnages = listSummary.Sum(s => s.TotalEnterWarehouseTunnages);
                total.TotalEnterWarehousePiles = listSummary.Sum(s => s.TotalEnterWarehousePiles);
                total.TotalEnterWarehouseTenThousands = listSummary.Sum(s => s.TotalEnterWarehouseTenThousands);
                total.TotalOutWarehousePackages = listSummary.Sum(s => s.TotalOutWarehousePackages);
                total.TotalOutWarehouseTunnages = listSummary.Sum(s => s.TotalOutWarehouseTunnages);
                total.TotalOutWarehousePiles = listSummary.Sum(s => s.TotalOutWarehousePiles);
                total.TotalOutWarehouseTenThousands = listSummary.Sum(s => s.TotalOutWarehouseTenThousands);
                total.EndPackages = listSummary.Sum(s => s.EndPackages);
                total.EndTunnages = listSummary.Sum(s => s.EndTunnages);
                total.EndPiles = listSummary.Sum(s => s.EndPiles);
                total.EndTenThousands = listSummary.Sum(s => s.EndTenThousands);
                total.TotalAllocateEnterWarehousePackages = listSummary.Sum(s => s.TotalAllocateEnterWarehousePackages);
                total.TotalAllocateEnterWarehouseTunnages = listSummary.Sum(s => s.TotalAllocateEnterWarehouseTunnages);
                total.TotalAllocateEnterWarehousePiles = listSummary.Sum(s => s.TotalAllocateEnterWarehousePiles);
                total.TotalAllocateEnterWarehouseTenThousands = listSummary.Sum(s => s.TotalAllocateEnterWarehouseTenThousands);
                total.TotalAllocateOutWarehousePackages = listSummary.Sum(s => s.TotalAllocateOutWarehousePackages);
                total.TotalAllocateOutWarehouseTunnages = listSummary.Sum(s => s.TotalAllocateOutWarehouseTunnages);
                total.TotalAllocateOutWarehousePiles = listSummary.Sum(s => s.TotalAllocateOutWarehousePiles);
                total.TotalAllocateOutWarehouseTenThousands = listSummary.Sum(s => s.TotalAllocateOutWarehouseTenThousands);
                listRet.Add(total);
            }

            //生成GridView
            BoundField colCustomerName = new BoundField();
            colCustomerName.HeaderText = InnoSoft.LS.Resources.Labels.CustomerName;
            colCustomerName.DataField = "CustomerName";

            BoundField colGoodsNo = new BoundField();
            colGoodsNo.HeaderText = InnoSoft.LS.Resources.Labels.GoodsNo;
            colGoodsNo.DataField = "GoodsNo";

            BoundField colGoodsName = new BoundField();
            colGoodsName.HeaderText = InnoSoft.LS.Resources.Labels.GoodsName;
            colGoodsName.DataField = "GoodsName";

            BoundField colBrand = new BoundField();
            colBrand.HeaderText = InnoSoft.LS.Resources.Labels.Brand;
            colBrand.DataField = "Brand";

            BoundField colSpecModel = new BoundField();
            colSpecModel.HeaderText = InnoSoft.LS.Resources.Labels.Specification;
            colSpecModel.DataField = "SpecModel";

            BoundField colGWeight = new BoundField();
            colGWeight.HeaderText = InnoSoft.LS.Resources.Labels.GrammeWeight;
            colGWeight.DataField = "GWeight";

            BoundField colGrade = new BoundField();
            colGrade.HeaderText = InnoSoft.LS.Resources.Labels.Grade;
            colGrade.DataField = "Grade";

            BoundField colBatchNo = new BoundField();
            colBatchNo.HeaderText = InnoSoft.LS.Resources.Labels.BatchNo;
            colBatchNo.DataField = "BatchNo";

            BoundField colWarehouse = new BoundField();
            colWarehouse.HeaderText = InnoSoft.LS.Resources.Labels.Warehouse;
            colWarehouse.DataField = "Warehouse";

            BoundField colLocation = new BoundField();
            colLocation.HeaderText = InnoSoft.LS.Resources.Labels.Location;
            colLocation.DataField = "Location";

            BoundField colStartPackages = new BoundField();
            colStartPackages.HeaderText = InnoSoft.LS.Resources.Labels.BeginningBalance + InnoSoft.LS.Resources.Labels.Pieces;
            colStartPackages.DataField = "StartPackages";

            BoundField colStartTunnages = new BoundField();
            colStartTunnages.HeaderText = InnoSoft.LS.Resources.Labels.BeginningBalance + InnoSoft.LS.Resources.Labels.Tunnages;
            colStartTunnages.DataField = "StartTunnages";

            BoundField colStartPiles = new BoundField();
            colStartPiles.HeaderText = InnoSoft.LS.Resources.Labels.BeginningBalance + InnoSoft.LS.Resources.Labels.Piles;
            colStartPiles.DataField = "StartPiles";

            BoundField colStartTenThousands = new BoundField();
            colStartTenThousands.HeaderText = InnoSoft.LS.Resources.Labels.BeginningBalance + InnoSoft.LS.Resources.Labels.TenThousands;
            colStartTenThousands.DataField = "StartTenThousands";

            BoundField colTotalEnterWarehousePackages = new BoundField();
            colTotalEnterWarehousePackages.HeaderText = InnoSoft.LS.Resources.Labels.TotalEnterWarehouse + InnoSoft.LS.Resources.Labels.Pieces;
            colTotalEnterWarehousePackages.DataField = "TotalEnterWarehousePackages";

            BoundField colTotalEnterWarehouseTunnages = new BoundField();
            colTotalEnterWarehouseTunnages.HeaderText = InnoSoft.LS.Resources.Labels.TotalEnterWarehouse + InnoSoft.LS.Resources.Labels.Tunnages;
            colTotalEnterWarehouseTunnages.DataField = "TotalEnterWarehouseTunnages";

            BoundField colTotalEnterWarehousePiles = new BoundField();
            colTotalEnterWarehousePiles.HeaderText = InnoSoft.LS.Resources.Labels.TotalEnterWarehouse + InnoSoft.LS.Resources.Labels.Piles;
            colTotalEnterWarehousePiles.DataField = "TotalEnterWarehousePiles";

            BoundField colTotalEnterWarehouseTenThousands = new BoundField();
            colTotalEnterWarehouseTenThousands.HeaderText = InnoSoft.LS.Resources.Labels.TotalEnterWarehouse + InnoSoft.LS.Resources.Labels.TenThousands;
            colTotalEnterWarehouseTenThousands.DataField = "TotalEnterWarehouseTenThousands";

            BoundField colTotalOutWarehousePackages = new BoundField();
            colTotalOutWarehousePackages.HeaderText = InnoSoft.LS.Resources.Labels.TotalOutWarehouse + InnoSoft.LS.Resources.Labels.Pieces;
            colTotalOutWarehousePackages.DataField = "TotalOutWarehousePackages";

            BoundField colTotalOutWarehouseTunnages = new BoundField();
            colTotalOutWarehouseTunnages.HeaderText = InnoSoft.LS.Resources.Labels.TotalOutWarehouse + InnoSoft.LS.Resources.Labels.Tunnages;
            colTotalOutWarehouseTunnages.DataField = "TotalOutWarehouseTunnages";

            BoundField colTotalOutWarehousePiles = new BoundField();
            colTotalOutWarehousePiles.HeaderText = InnoSoft.LS.Resources.Labels.TotalOutWarehouse + InnoSoft.LS.Resources.Labels.Piles;
            colTotalOutWarehousePiles.DataField = "TotalOutWarehousePiles";

            BoundField colTotalOutWarehouseTenThousands = new BoundField();
            colTotalOutWarehouseTenThousands.HeaderText = InnoSoft.LS.Resources.Labels.TotalOutWarehouse + InnoSoft.LS.Resources.Labels.TenThousands;
            colTotalOutWarehouseTenThousands.DataField = "TotalOutWarehouseTenThousands";

            BoundField colEndPackages = new BoundField();
            colEndPackages.HeaderText = InnoSoft.LS.Resources.Labels.EndingBalance + InnoSoft.LS.Resources.Labels.Pieces;
            colEndPackages.DataField = "EndPackages";

            BoundField colEndTunnages = new BoundField();
            colEndTunnages.HeaderText = InnoSoft.LS.Resources.Labels.EndingBalance + InnoSoft.LS.Resources.Labels.Tunnages;
            colEndTunnages.DataField = "EndTunnages";

            BoundField colEndPiles = new BoundField();
            colEndPiles.HeaderText = InnoSoft.LS.Resources.Labels.EndingBalance + InnoSoft.LS.Resources.Labels.Piles;
            colEndPiles.DataField = "EndPiles";

            BoundField colEndTenThousands = new BoundField();
            colEndTenThousands.HeaderText = InnoSoft.LS.Resources.Labels.EndingBalance + InnoSoft.LS.Resources.Labels.TenThousands;
            colEndTenThousands.DataField = "EndTenThousands";

            BoundField colTotalAllocateEnterWarehousePackages = new BoundField();
            colTotalAllocateEnterWarehousePackages.HeaderText = InnoSoft.LS.Resources.Labels.TotalAllocateEnterWarehouse + InnoSoft.LS.Resources.Labels.Pieces;
            colTotalAllocateEnterWarehousePackages.DataField = "TotalAllocateEnterWarehousePackages";

            BoundField colTotalAllocateEnterWarehouseTunnages = new BoundField();
            colTotalAllocateEnterWarehouseTunnages.HeaderText = InnoSoft.LS.Resources.Labels.TotalAllocateEnterWarehouse + InnoSoft.LS.Resources.Labels.Tunnages;
            colTotalAllocateEnterWarehouseTunnages.DataField = "TotalAllocateEnterWarehouseTunnages";

            BoundField colTotalAllocateEnterWarehousePiles = new BoundField();
            colTotalAllocateEnterWarehousePiles.HeaderText = InnoSoft.LS.Resources.Labels.TotalAllocateEnterWarehouse + InnoSoft.LS.Resources.Labels.Piles;
            colTotalAllocateEnterWarehousePiles.DataField = "TotalAllocateEnterWarehousePiles";

            BoundField colTotalAllocateEnterWarehouseTenThousands = new BoundField();
            colTotalAllocateEnterWarehouseTenThousands.HeaderText = InnoSoft.LS.Resources.Labels.TotalAllocateEnterWarehouse + InnoSoft.LS.Resources.Labels.TenThousands;
            colTotalAllocateEnterWarehouseTenThousands.DataField = "TotalAllocateEnterWarehouseTenThousands";

            BoundField colTotalAllocateOutWarehousePackages = new BoundField();
            colTotalAllocateOutWarehousePackages.HeaderText = InnoSoft.LS.Resources.Labels.TotalAllocateOutWarehouse + InnoSoft.LS.Resources.Labels.Pieces;
            colTotalAllocateOutWarehousePackages.DataField = "TotalAllocateOutWarehousePackages";

            BoundField colTotalAllocateOutWarehouseTunnages = new BoundField();
            colTotalAllocateOutWarehouseTunnages.HeaderText = InnoSoft.LS.Resources.Labels.TotalAllocateOutWarehouse + InnoSoft.LS.Resources.Labels.Tunnages;
            colTotalAllocateOutWarehouseTunnages.DataField = "TotalAllocateOutWarehouseTunnages";

            BoundField colTotalAllocateOutWarehousePiles = new BoundField();
            colTotalAllocateOutWarehousePiles.HeaderText = InnoSoft.LS.Resources.Labels.TotalAllocateOutWarehouse + InnoSoft.LS.Resources.Labels.Piles;
            colTotalAllocateOutWarehousePiles.DataField = "TotalAllocateOutWarehousePiles";

            BoundField colTotalAllocateOutWarehouseTenThousands = new BoundField();
            colTotalAllocateOutWarehouseTenThousands.HeaderText = InnoSoft.LS.Resources.Labels.TotalAllocateOutWarehouse + InnoSoft.LS.Resources.Labels.TenThousands;
            colTotalAllocateOutWarehouseTenThousands.DataField = "TotalAllocateOutWarehouseTenThousands";

            BoundField colProductionDate = new BoundField();
            colProductionDate.HeaderText = InnoSoft.LS.Resources.Labels.ProductionDate;
            colProductionDate.DataField = "ProductionDate";

            var grid = new GridView();
            grid.Columns.Add(colCustomerName);
            grid.Columns.Add(colGoodsNo);
            grid.Columns.Add(colGoodsName);
            grid.Columns.Add(colBrand);
            grid.Columns.Add(colSpecModel);
            grid.Columns.Add(colGWeight);
            grid.Columns.Add(colGrade);
            grid.Columns.Add(colBatchNo);
            grid.Columns.Add(colWarehouse);
            grid.Columns.Add(colLocation);
            grid.Columns.Add(colStartPackages);
            grid.Columns.Add(colStartTunnages);
            grid.Columns.Add(colStartPiles);
            grid.Columns.Add(colStartTenThousands);
            grid.Columns.Add(colTotalEnterWarehousePackages);
            grid.Columns.Add(colTotalEnterWarehouseTunnages);
            grid.Columns.Add(colTotalEnterWarehousePiles);
            grid.Columns.Add(colTotalEnterWarehouseTenThousands);
            grid.Columns.Add(colTotalOutWarehousePackages);
            grid.Columns.Add(colTotalOutWarehouseTunnages);
            grid.Columns.Add(colTotalOutWarehousePiles);
            grid.Columns.Add(colTotalOutWarehouseTenThousands);
            grid.Columns.Add(colEndPackages);
            grid.Columns.Add(colEndTunnages);
            grid.Columns.Add(colEndPiles);
            grid.Columns.Add(colEndTenThousands);
            grid.Columns.Add(colTotalAllocateEnterWarehousePackages);
            grid.Columns.Add(colTotalAllocateEnterWarehouseTunnages);
            grid.Columns.Add(colTotalAllocateEnterWarehousePiles);
            grid.Columns.Add(colTotalAllocateEnterWarehouseTenThousands);
            grid.Columns.Add(colTotalAllocateOutWarehousePackages);
            grid.Columns.Add(colTotalAllocateOutWarehouseTunnages);
            grid.Columns.Add(colTotalAllocateOutWarehousePiles);
            grid.Columns.Add(colTotalAllocateOutWarehouseTenThousands);
            grid.Columns.Add(colProductionDate);
            grid.AutoGenerateColumns = false;

            grid.DataSource = from r in listRet
                              select new
                              {
                                  CustomerName = r.CustomerName,
                                  GoodsNo = r.GoodsNo,
                                  GoodsName = r.GoodsName,
                                  Brand = r.Brand,
                                  SpecModel = r.SpecModel,
                                  GWeight = r.GWeight,
                                  Grade = r.Grade,
                                  BatchNo = r.BatchNo,
                                  Warehouse = r.Warehouse,
                                  Location = r.Location,
                                  StartPackages = r.StartPackages > 0 ? r.StartPackages.ToString() : string.Empty,
                                  StartTunnages = r.StartTunnages > 0 ? r.StartTunnages.ToString("#0.######") : string.Empty,
                                  StartPiles = r.StartPiles > 0 ? r.StartPiles.ToString("#0.######") : string.Empty,
                                  StartTenThousands = r.StartTenThousands > 0 ? r.StartTenThousands.ToString("#0.######") : string.Empty,
                                  TotalEnterWarehousePackages = r.TotalEnterWarehousePackages > 0 ? r.TotalEnterWarehousePackages.ToString() : string.Empty,
                                  TotalEnterWarehouseTunnages = r.TotalEnterWarehouseTunnages > 0 ? r.TotalEnterWarehouseTunnages.ToString("#0.######") : string.Empty,
                                  TotalEnterWarehousePiles = r.TotalEnterWarehousePiles > 0 ? r.TotalEnterWarehousePiles.ToString("#0.######") : string.Empty,
                                  TotalEnterWarehouseTenThousands = r.TotalEnterWarehouseTenThousands > 0 ? r.TotalEnterWarehouseTenThousands.ToString("#0.######") : string.Empty,
                                  TotalOutWarehousePackages = r.TotalOutWarehousePackages > 0 ? r.TotalOutWarehousePackages.ToString() : string.Empty,
                                  TotalOutWarehouseTunnages = r.TotalOutWarehouseTunnages > 0 ? r.TotalOutWarehouseTunnages.ToString("#0.######") : string.Empty,
                                  TotalOutWarehousePiles = r.TotalOutWarehousePiles > 0 ? r.TotalOutWarehousePiles.ToString("#0.######") : string.Empty,
                                  TotalOutWarehouseTenThousands = r.TotalOutWarehouseTenThousands > 0 ? r.TotalOutWarehouseTenThousands.ToString("#0.######") : string.Empty,
                                  EndPackages = r.EndPackages > 0 ? r.EndPackages.ToString() : string.Empty,
                                  EndTunnages = r.EndTunnages > 0 ? r.EndTunnages.ToString("#0.######") : string.Empty,
                                  EndPiles = r.EndPiles > 0 ? r.EndPiles.ToString("#0.######") : string.Empty,
                                  EndTenThousands = r.EndTenThousands > 0 ? r.EndTenThousands.ToString("#0.######") : string.Empty,
                                  TotalAllocateEnterWarehousePackages = r.TotalAllocateEnterWarehousePackages > 0 ? r.TotalAllocateEnterWarehousePackages.ToString() : string.Empty,
                                  TotalAllocateEnterWarehouseTunnages = r.TotalAllocateEnterWarehouseTunnages > 0 ? r.TotalAllocateEnterWarehouseTunnages.ToString("#0.######") : string.Empty,
                                  TotalAllocateEnterWarehousePiles = r.TotalAllocateEnterWarehousePiles > 0 ? r.TotalAllocateEnterWarehousePiles.ToString("#0.######") : string.Empty,
                                  TotalAllocateEnterWarehouseTenThousands = r.TotalAllocateEnterWarehouseTenThousands > 0 ? r.TotalAllocateEnterWarehouseTenThousands.ToString("#0.######") : string.Empty,
                                  TotalAllocateOutWarehousePackages = r.TotalAllocateOutWarehousePackages > 0 ? r.TotalAllocateOutWarehousePackages.ToString() : string.Empty,
                                  TotalAllocateOutWarehouseTunnages = r.TotalAllocateOutWarehouseTunnages > 0 ? r.TotalAllocateOutWarehouseTunnages.ToString("#0.######") : string.Empty,
                                  TotalAllocateOutWarehousePiles = r.TotalAllocateOutWarehousePiles > 0 ? r.TotalAllocateOutWarehousePiles.ToString("#0.######") : string.Empty,
                                  TotalAllocateOutWarehouseTenThousands = r.TotalAllocateOutWarehouseTenThousands > 0 ? r.TotalAllocateOutWarehouseTenThousands.ToString("#0.######") : string.Empty,
                                  ProductionDate = r.ProductionDate
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=EnterOutBalanceSummary.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

            return View("EnterOutBalanceSummary");
        }

        #endregion

        #region 统计仓储力支费

        /// <summary>
        /// GET统计仓储力支费页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult StatStorageAndForceFee()
        {
            string strErrText;

            //生成空的客户下拉列表项
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

            //生成仓库下拉列表项
            DDSystem dd = new DDSystem();
            List<Warehouse> listWarehouse = dd.LoadWarehouses(LoginAccountId, LoginStaffName, out strErrText);
            if (listWarehouse == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListWarehouse = new List<SelectListItem>();
            selectListWarehouse.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListWarehouse.AddRange(from w in listWarehouse
                                         select new SelectListItem
                                         {
                                             Text = w.Name,
                                             Value = w.Name
                                         });
            ViewData["Warehouses"] = new SelectList(selectListWarehouse, "Value", "Text");

            return View();
        }

        /// <summary>
        /// GET统计仓储力支费表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="customerName"></param>
        /// <param name="warehouse"></param>
        /// <param name="isConsigning"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadStatStorageAndForceFeeGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string customerName, string warehouse, string isConsigning)
        {
            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<StatStorageAndForceFee> listFee = stock.LoadStatStorageAndForceFeeByConditions(startTime, endTime, customerName, warehouse, isConsigning, LoginAccountId, LoginStaffName, out strErrText);
            if (listFee == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listFee.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listFee.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from f in data
                      select new
                      {
                          id = f.Id,
                          cell = new string[] { 
                              f.Id.ToString(),
                              f.CustomerName,
                              f.CreateTime,
                              f.TotalDeliverEnterWarehouseTunnages > 0 ? f.TotalDeliverEnterWarehouseTunnages.ToString("#0.######") : string.Empty,
                              f.TotalDeliverEnterWarehousePiles > 0 ? f.TotalDeliverEnterWarehousePiles.ToString("#0.######") : string.Empty,
                              f.UnloadingForceFeePrice.ToString(),
                              f.DeliverEnterWarehouseForceFee > 0 ? f.DeliverEnterWarehouseForceFee.ToString() : string.Empty,
                              f.TotalAllocateEnterWarehouseTunnages > 0 ? f.TotalAllocateEnterWarehouseTunnages.ToString("#0.######") : string.Empty,
                              f.TotalDeliverOutWarehouseTunnages > 0 ? f.TotalDeliverOutWarehouseTunnages.ToString("#0.######") : string.Empty,
                              f.TotalDeliverOutWarehousePiles > 0 ? f.TotalDeliverOutWarehousePiles.ToString("#0.######") : string.Empty,
                              f.LoadingForceFeePrice.ToString(),
                              f.DeliverOutWarehouseForceFee > 0 ? f.DeliverOutWarehouseForceFee.ToString() : string.Empty,
                              f.TotalAllocateOutWarehouseTunnages > 0 ? f.TotalAllocateOutWarehouseTunnages.ToString("#0.######") : string.Empty,
                              f.AllocateOutWarehouseForceFee > 0 ? f.AllocateOutWarehouseForceFee.ToString() : string.Empty,
                              f.BalanceTunnages > 0 ? f.BalanceTunnages.ToString("#0.######") : string.Empty,
                              f.BalancePiles > 0 ? f.BalancePiles.ToString("#0.######") : string.Empty,
                              f.StorageFeePrice.ToString(),
                              f.StorageFee > 0 ? f.StorageFee.ToString() : string.Empty
                          }
                      }).ToArray(),
                userdata = new
                {
                    CreateTime = InnoSoft.LS.Resources.Labels.Total,
                    TotalDeliverEnterWarehouseTunnages = data.Sum(s => s.TotalDeliverEnterWarehouseTunnages),
                    TotalDeliverEnterWarehousePiles = data.Sum(s => s.TotalDeliverEnterWarehousePiles),
                    DeliverEnterWarehouseForceFee = data.Sum(s => s.DeliverEnterWarehouseForceFee),
                    TotalAllocateEnterWarehouseTunnages = data.Sum(s => s.TotalAllocateEnterWarehouseTunnages),
                    TotalDeliverOutWarehouseTunnages = data.Sum(s => s.TotalDeliverOutWarehouseTunnages),
                    TotalDeliverOutWarehousePiles = data.Sum(s => s.TotalDeliverOutWarehousePiles),
                    DeliverOutWarehouseForceFee = data.Sum(s => s.DeliverOutWarehouseForceFee),
                    TotalAllocateOutWarehouseTunnages = data.Sum(s => s.TotalAllocateOutWarehouseTunnages),
                    AllocateOutWarehouseForceFee = data.Sum(s => s.AllocateOutWarehouseForceFee),
                    BalanceTunnages = data.Count > 0 ? data[data.Count - 1].BalanceTunnages : 0,
                    BalancePiles = data.Count > 0 ? data[data.Count - 1].BalancePiles : 0,
                    StorageFee = data.Sum(s => s.StorageFee)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET导出仓储力支费数据
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportStorageAndForceFee()
        {
            #region 生成数据源

            //读取条件
            var request = HttpContext.Request;

            string strStartTime = request.QueryString["startTime"] ?? string.Empty;
            string strEndTime = request.QueryString["endTime"] ?? string.Empty;
            string strCustomerName = request.QueryString["customerName"] ?? string.Empty;
            string strWarehouse = request.QueryString["warehouse"] ?? string.Empty;
            string strIsConsigning = request.QueryString["isConsigning"] ?? "false";

            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<StatStorageAndForceFee> listFee = stock.LoadStatStorageAndForceFeeByConditions(strStartTime, strEndTime, strCustomerName, strWarehouse, strIsConsigning, LoginAccountId, LoginStaffName, out strErrText);
            if (listFee == null)
            {
                throw new Exception(strErrText);
            }

            //生成结果数据
            List<StatStorageAndForceFee> listRet = new List<StatStorageAndForceFee>();
            {
                decimal decBalanceTunnages = 0;
                decimal decBalancePiles = 0;

                //按客户分组
                var grpCustomerNames = listFee.GroupBy(f => f.CustomerName).OrderBy(f => f.Key);
                foreach (var grpCustomerName in grpCustomerNames)
                {
                    List<StatStorageAndForceFee> data = grpCustomerName.ToList<StatStorageAndForceFee>();
                    listRet.AddRange(data);

                    //生成小计行
                    StatStorageAndForceFee subtotal = new StatStorageAndForceFee();
                    subtotal.CustomerName = grpCustomerName.Key;
                    subtotal.CreateTime = InnoSoft.LS.Resources.Labels.Subtotal;
                    subtotal.TotalDeliverEnterWarehouseTunnages = data.Sum(s => s.TotalDeliverEnterWarehouseTunnages);
                    subtotal.TotalDeliverEnterWarehousePiles = data.Sum(s => s.TotalDeliverEnterWarehousePiles);
                    subtotal.DeliverEnterWarehouseForceFee = data.Sum(s => s.DeliverEnterWarehouseForceFee);
                    subtotal.TotalAllocateEnterWarehouseTunnages = data.Sum(s => s.TotalAllocateEnterWarehouseTunnages);
                    subtotal.TotalDeliverOutWarehouseTunnages = data.Sum(s => s.TotalDeliverOutWarehouseTunnages);
                    subtotal.TotalDeliverOutWarehousePiles = data.Sum(s => s.TotalDeliverOutWarehousePiles);
                    subtotal.DeliverOutWarehouseForceFee = data.Sum(s => s.DeliverOutWarehouseForceFee);
                    subtotal.TotalAllocateOutWarehouseTunnages = data.Sum(s => s.TotalAllocateOutWarehouseTunnages);
                    subtotal.AllocateOutWarehouseForceFee = data.Sum(s => s.AllocateOutWarehouseForceFee);
                    subtotal.BalanceTunnages = data.Last().BalanceTunnages;
                    subtotal.BalancePiles = data.Last().BalancePiles;
                    subtotal.StorageFee = data.Sum(s => s.StorageFee);
                    listRet.Add(subtotal);

                    decBalanceTunnages += subtotal.BalanceTunnages;
                    decBalancePiles += subtotal.BalancePiles;
                }

                //生成合计行
                StatStorageAndForceFee total = new StatStorageAndForceFee();
                total.CustomerName = InnoSoft.LS.Resources.Labels.Total;
                total.TotalDeliverEnterWarehouseTunnages = listFee.Sum(s => s.TotalDeliverEnterWarehouseTunnages);
                total.TotalDeliverEnterWarehousePiles = listFee.Sum(s => s.TotalDeliverEnterWarehousePiles);
                total.DeliverEnterWarehouseForceFee = listFee.Sum(s => s.DeliverEnterWarehouseForceFee);
                total.TotalAllocateEnterWarehouseTunnages = listFee.Sum(s => s.TotalAllocateEnterWarehouseTunnages);
                total.TotalDeliverOutWarehouseTunnages = listFee.Sum(s => s.TotalDeliverOutWarehouseTunnages);
                total.TotalDeliverOutWarehousePiles = listFee.Sum(s => s.TotalDeliverOutWarehousePiles);
                total.DeliverOutWarehouseForceFee = listFee.Sum(s => s.DeliverOutWarehouseForceFee);
                total.TotalAllocateOutWarehouseTunnages = listFee.Sum(s => s.TotalAllocateOutWarehouseTunnages);
                total.AllocateOutWarehouseForceFee = listFee.Sum(s => s.AllocateOutWarehouseForceFee);
                total.BalanceTunnages = decBalanceTunnages;
                total.BalancePiles = decBalancePiles;
                total.StorageFee = listFee.Sum(s => s.StorageFee);
                listRet.Add(total);
            }

            #endregion

            #region 导出Excel

            #region 创建Excel工作簿

            var workbook = new HSSFWorkbook();
            var sheet = workbook.CreateSheet();

            #endregion

            #region 设置列宽度

            sheet.SetColumnWidth(0, 20 * 256);//客户名称
            sheet.SetColumnWidth(1, 12 * 256);//日期
            sheet.SetColumnWidth(2, 12 * 256);//总计移仓入库吨数
            sheet.SetColumnWidth(3, 12 * 256);//总计移仓入库垛数
            sheet.SetColumnWidth(4, 7 * 256);//下力支费价格
            sheet.SetColumnWidth(5, 10 * 256);//移仓入库力支费
            sheet.SetColumnWidth(6, 12 * 256);//总计划拨入库吨数
            sheet.SetColumnWidth(7, 12 * 256);//总计发货出库吨数
            sheet.SetColumnWidth(8, 12 * 256);//总计发货出库垛数
            sheet.SetColumnWidth(9, 7 * 256);//上力支费价格
            sheet.SetColumnWidth(10, 10 * 256);//发货出库力支费
            sheet.SetColumnWidth(11, 12 * 256);//总计划拨出库吨数
            sheet.SetColumnWidth(12, 10 * 256);//划拨出库力支费
            sheet.SetColumnWidth(13, 12 * 256);//结存吨数
            sheet.SetColumnWidth(14, 12 * 256);//结存垛数
            sheet.SetColumnWidth(15, 7 * 256);//仓储费价格
            sheet.SetColumnWidth(16, 10 * 256);//仓储费

            #endregion

            #region 设置单元格样式

            ICellStyle styleLeft = workbook.CreateCellStyle();
            styleLeft.Alignment = HorizontalAlignment.LEFT;
            styleLeft.VerticalAlignment = VerticalAlignment.CENTER;
            styleLeft.BorderBottom = CellBorderType.THIN;
            styleLeft.BorderLeft = CellBorderType.THIN;
            styleLeft.BorderRight = CellBorderType.THIN;
            styleLeft.BorderTop = CellBorderType.THIN;
            styleLeft.WrapText = true;

            ICellStyle styleCenter = workbook.CreateCellStyle();
            styleCenter.Alignment = HorizontalAlignment.CENTER;
            styleCenter.VerticalAlignment = VerticalAlignment.CENTER;
            styleCenter.BorderBottom = CellBorderType.THIN;
            styleCenter.BorderLeft = CellBorderType.THIN;
            styleCenter.BorderRight = CellBorderType.THIN;
            styleCenter.BorderTop = CellBorderType.THIN;
            styleCenter.WrapText = true;

            ICellStyle styleRight = workbook.CreateCellStyle();
            styleRight.Alignment = HorizontalAlignment.RIGHT;
            styleRight.VerticalAlignment = VerticalAlignment.CENTER;
            styleRight.BorderBottom = CellBorderType.THIN;
            styleRight.BorderLeft = CellBorderType.THIN;
            styleRight.BorderRight = CellBorderType.THIN;
            styleRight.BorderTop = CellBorderType.THIN;
            styleRight.WrapText = true;

            #endregion

            #region 创建表头

            //表头
            var rowHeader = sheet.CreateRow(0);
            rowHeader.HeightInPoints = 40;

            rowHeader.CreateCell(0).SetCellValue(InnoSoft.LS.Resources.Labels.CustomerName);//客户名称
            rowHeader.GetCell(0).CellStyle = styleCenter;

            rowHeader.CreateCell(1).SetCellValue(InnoSoft.LS.Resources.Labels.Date);//日期
            rowHeader.GetCell(1).CellStyle = styleCenter;

            rowHeader.CreateCell(2).SetCellValue(InnoSoft.LS.Resources.Labels.TotalDeliverEnterWarehouse + InnoSoft.LS.Resources.Labels.Tunnages);//总计移仓入库吨数
            rowHeader.GetCell(2).CellStyle = styleCenter;

            rowHeader.CreateCell(3).SetCellValue(InnoSoft.LS.Resources.Labels.TotalDeliverEnterWarehouse + InnoSoft.LS.Resources.Labels.Piles);//总计移仓入库垛数
            rowHeader.GetCell(3).CellStyle = styleCenter;

            rowHeader.CreateCell(4).SetCellValue(InnoSoft.LS.Resources.Labels.UnloadingForceFeePrice);//下力支费价格
            rowHeader.GetCell(4).CellStyle = styleCenter;

            rowHeader.CreateCell(5).SetCellValue(InnoSoft.LS.Resources.Labels.DeliverEnterWarehouseForceFee);//移仓入库力支费
            rowHeader.GetCell(5).CellStyle = styleCenter;

            rowHeader.CreateCell(6).SetCellValue(InnoSoft.LS.Resources.Labels.TotalAllocateEnterWarehouseTunnages);//总计划拨入库吨数
            rowHeader.GetCell(6).CellStyle = styleCenter;

            rowHeader.CreateCell(7).SetCellValue(InnoSoft.LS.Resources.Labels.TotalDeliverOutWarehouse + InnoSoft.LS.Resources.Labels.Tunnages);//总计发货出库吨数
            rowHeader.GetCell(7).CellStyle = styleCenter;

            rowHeader.CreateCell(8).SetCellValue(InnoSoft.LS.Resources.Labels.TotalDeliverOutWarehouse + InnoSoft.LS.Resources.Labels.Piles);//总计发货出库垛数
            rowHeader.GetCell(8).CellStyle = styleCenter;

            rowHeader.CreateCell(9).SetCellValue(InnoSoft.LS.Resources.Labels.LoadingForceFeePrice);//上力支费价格
            rowHeader.GetCell(9).CellStyle = styleCenter;

            rowHeader.CreateCell(10).SetCellValue(InnoSoft.LS.Resources.Labels.DeliverOutWarehouseForceFee);//发货出库力支费
            rowHeader.GetCell(10).CellStyle = styleCenter;

            rowHeader.CreateCell(11).SetCellValue(InnoSoft.LS.Resources.Labels.TotalAllocateOutWarehouseTunnages);//总计划拨出库吨数
            rowHeader.GetCell(11).CellStyle = styleCenter;

            rowHeader.CreateCell(12).SetCellValue(InnoSoft.LS.Resources.Labels.AllocateOutWarehouseForceFee);//划拨出库力支费
            rowHeader.GetCell(12).CellStyle = styleCenter;

            rowHeader.CreateCell(13).SetCellValue(InnoSoft.LS.Resources.Labels.BalanceTunnages);//结存吨数
            rowHeader.GetCell(13).CellStyle = styleCenter;

            rowHeader.CreateCell(14).SetCellValue(InnoSoft.LS.Resources.Labels.BalancePiles);//结存垛数
            rowHeader.GetCell(14).CellStyle = styleCenter;

            rowHeader.CreateCell(15).SetCellValue(InnoSoft.LS.Resources.Labels.StorageFeePrice);//仓储费价格
            rowHeader.GetCell(15).CellStyle = styleCenter;

            rowHeader.CreateCell(16).SetCellValue(InnoSoft.LS.Resources.Labels.StorageFee);//仓储费
            rowHeader.GetCell(16).CellStyle = styleCenter;

            #endregion

            #region 创建表体

            int iRow = 1;
            foreach (var ret in listRet)
            {
                var rowBody = sheet.CreateRow(iRow++);
                rowBody.HeightInPoints = 20;

                rowBody.CreateCell(0).SetCellValue(ret.CustomerName);//客户名称
                rowBody.GetCell(0).CellStyle = styleLeft;

                rowBody.CreateCell(1).SetCellValue(ret.CreateTime);//日期
                rowBody.GetCell(1).CellStyle = styleCenter;

                rowBody.CreateCell(2).SetCellValue(ret.TotalDeliverEnterWarehouseTunnages > 0 ? ret.TotalDeliverEnterWarehouseTunnages.ToString("#0.######") : string.Empty);//总计移仓入库吨数
                rowBody.GetCell(2).CellStyle = styleCenter;

                rowBody.CreateCell(3).SetCellValue(ret.TotalDeliverEnterWarehousePiles > 0 ? ret.TotalDeliverEnterWarehousePiles.ToString("#0.######") : string.Empty);//总计移仓入库垛数
                rowBody.GetCell(3).CellStyle = styleCenter;

                rowBody.CreateCell(4).SetCellValue(ret.UnloadingForceFeePrice > 0 ? ret.UnloadingForceFeePrice.ToString("N") : string.Empty);//下力支费价格
                rowBody.GetCell(4).CellStyle = styleRight;

                rowBody.CreateCell(5).SetCellValue(ret.DeliverEnterWarehouseForceFee > 0 ? ret.DeliverEnterWarehouseForceFee.ToString("N") : string.Empty);//移仓入库力支费
                rowBody.GetCell(5).CellStyle = styleRight;

                rowBody.CreateCell(6).SetCellValue(ret.TotalAllocateEnterWarehouseTunnages > 0 ? ret.TotalAllocateEnterWarehouseTunnages.ToString("#0.######") : string.Empty);//总计划拨入库吨数
                rowBody.GetCell(6).CellStyle = styleCenter;

                rowBody.CreateCell(7).SetCellValue(ret.TotalDeliverOutWarehouseTunnages > 0 ? ret.TotalDeliverOutWarehouseTunnages.ToString("#0.######") : string.Empty);//总计发货出库吨数
                rowBody.GetCell(7).CellStyle = styleCenter;

                rowBody.CreateCell(8).SetCellValue(ret.TotalDeliverOutWarehousePiles > 0 ? ret.TotalDeliverOutWarehousePiles.ToString("#0.######") : string.Empty);//总计发货出库垛数
                rowBody.GetCell(8).CellStyle = styleCenter;

                rowBody.CreateCell(9).SetCellValue(ret.LoadingForceFeePrice > 0 ? ret.LoadingForceFeePrice.ToString("N") : string.Empty);//上力支费价格
                rowBody.GetCell(9).CellStyle = styleRight;

                rowBody.CreateCell(10).SetCellValue(ret.DeliverOutWarehouseForceFee > 0 ? ret.DeliverOutWarehouseForceFee.ToString("N") : string.Empty);//发货出库力支费
                rowBody.GetCell(10).CellStyle = styleRight;

                rowBody.CreateCell(11).SetCellValue(ret.TotalAllocateOutWarehouseTunnages > 0 ? ret.TotalAllocateOutWarehouseTunnages.ToString("#0.######") : string.Empty);//总计划拨出库吨数
                rowBody.GetCell(11).CellStyle = styleCenter;

                rowBody.CreateCell(12).SetCellValue(ret.AllocateOutWarehouseForceFee > 0 ? ret.AllocateOutWarehouseForceFee.ToString("N") : string.Empty);//划拨出库力支费
                rowBody.GetCell(12).CellStyle = styleRight;

                rowBody.CreateCell(13).SetCellValue(ret.BalanceTunnages > 0 ? ret.BalanceTunnages.ToString("#0.######") : string.Empty);//结存吨数
                rowBody.GetCell(13).CellStyle = styleCenter;

                rowBody.CreateCell(14).SetCellValue(ret.BalancePiles > 0 ? ret.BalancePiles.ToString("#0.######") : string.Empty);//结存垛数
                rowBody.GetCell(14).CellStyle = styleCenter;

                rowBody.CreateCell(15).SetCellValue(ret.StorageFeePrice > 0 ? ret.StorageFeePrice.ToString("N") : string.Empty);//仓储费价格
                rowBody.GetCell(15).CellStyle = styleRight;

                rowBody.CreateCell(16).SetCellValue(ret.StorageFee > 0 ? ret.StorageFee.ToString("N") : string.Empty);//仓储费
                rowBody.GetCell(16).CellStyle = styleRight;
            }
            #endregion

            #region 输出Excel文件

            MemoryStream output = new MemoryStream();
            workbook.Write(output);

            return File(output.ToArray(), "application/vnd.ms-excel", "StorageAndForceFee.xls");

            #endregion

            #endregion
        }

        /// <summary>
        /// POST保存仓储力支费结算数据
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewCustomerStorageAndForceFeeSettlement(CustomerStorageAndForceFeeSettlementViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                CustomerStorageAndForceFeeSettlement data = new CustomerStorageAndForceFeeSettlement();
                data.StartTime = DateTime.Parse(model.StartTime);
                data.EndTime = DateTime.Parse(model.EndTime);
                data.InvoiceNo = model.InvoiceNo;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.InvoiceType = model.InvoiceType;
                data.InvoiceAmount = model.InvoiceAmount;
                data.Remark = model.Remark;

                //保存数据
                string strErrText;
                StockSystem stock = new StockSystem();
                if (stock.InsertCustomerStorageAndForceFeeSettlement(data, LoginAccountId, LoginStaffName, out strErrText) > 0)
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

        #region 查询仓储力支费结算记录

        /// <summary>
        /// GET查询仓储力支费结算记录
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchStorageAndForceFeeSettlements()
        {
            return View();
        }

        /// <summary>
        /// GET查询仓储力支费结算记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="invoiceNo"></param>
        /// <param name="customerName"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchCustomerStorageAndForceFeeSettlementsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string invoiceNo, string customerName)
        {
            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<CustomerStorageAndForceFeeSettlement> listCustomerStorageAndForceFeeSettlement = stock.LoadCustomerStorageAndForceFeeSettlementsByConditions(startTime, endTime, invoiceNo, customerName, LoginAccountId, LoginStaffName, out strErrText);
            if (listCustomerStorageAndForceFeeSettlement == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listCustomerStorageAndForceFeeSettlement.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CustomerName") + " " + (sord ?? "ASC");
            var data = listCustomerStorageAndForceFeeSettlement.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              i.CustomerName,
                              i.StartTime.ToString("yyyy-MM-dd"),
                              i.EndTime.ToString("yyyy-MM-dd"),
                              i.InvoiceNo,
                              i.InvoiceType,
                              i.InvoiceAmount.ToString(),
                              i.Remark
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST删除仓储力支费结算记录
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteCustomerStorageAndForceFeeSettlement(string id)
        {
            string strErrText;
            StockSystem stock = new StockSystem();
            if (stock.DeleteCustomerStorageAndForceFeeSettlement(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 查询寄库计划

        /// <summary>
        /// GET查询寄库计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchConsigningDeliverPlans()
        {
            return View();
        }

        /// <summary>
        /// GET查询寄库计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="consigningDeliveryNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchConsigningDeliverPlansGrid(string sidx, string sord, int page, int rows, string consigningDeliveryNo)
        {
            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<ConsigningDeliverPlanDeliverGoods> listGoods = stock.LoadConsigningDeliverPlanDeliverGoodsByConditions(consigningDeliveryNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listGoods.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listGoods.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from g in data
                      select new
                      {
                          id = g.Id,
                          cell = new string[] { 
                              g.Id.ToString(),
                              g.ConsignedDeliveryNo,
                              g.GoodsNo,
                              g.GoodsName,
                              g.Brand,
                              g.SpecModel,
                              g.GWeight,
                              g.Grade,
                              g.PieceWeight.ToString("#0.######"),
                              g.BatchNo,
                              g.ProductionDate,
                              g.Warehouse,
                              g.CreateTime,
                              g.OutWarehouseBillNo,
                              g.DeliveryNo,
                              g.ReceiverName,
                              g.Packages > 0 ? g.Packages.ToString() : string.Empty,
                              g.Tunnages > 0 ? g.Tunnages.ToString("#0.######") : string.Empty,
                              g.BalancePackages.ToString(),
                              g.BalanceTunnages.ToString("#0.######")
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region 打印盘点表

        /// <summary>
        /// GET打印盘点表页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult PrintStocktaking()
        {
            string strErrText;

            //生成仓库下拉列表项
            DDSystem dd = new DDSystem();
            List<Warehouse> listWarehouse = dd.LoadWarehouses(LoginAccountId, LoginStaffName, out strErrText);
            if (listWarehouse == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListWarehouse = new List<SelectListItem>();
            selectListWarehouse.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListWarehouse.AddRange(from w in listWarehouse
                                         select new SelectListItem
                                         {
                                             Text = w.Name,
                                             Value = w.Name
                                         });
            ViewData["Warehouses"] = new SelectList(selectListWarehouse, "Value", "Text");

            return View();
        }

        /// <summary>
        /// GET盘点表
        /// </summary>
        /// <param name="warehouse"></param>
        /// <param name="location"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult LoadPrintStocktaking(string warehouse, string location)
        {
            string strErrText;

            //读取公司名称
            OrganizationSystem organ = new OrganizationSystem();
            List<Organization> listOrgan = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrgan == null)
            {
                throw new Exception(strErrText);
            }
            Organization root = listOrgan.Find(delegate(Organization o) { return o.ParentId == 0; });

            //读取库存数据
            StockSystem stock = new StockSystem();
            List<Stock> listStock = stock.LoadStocktakingByConditions(warehouse, location, LoginAccountId, LoginStaffName, out strErrText);
            if (listStock == null)
            {
                throw new Exception(strErrText);
            }

            //生成HTML
            int nTotalPackages = 0;
            decimal decTotalTunnages = 0;
            decimal decTotalPiles = 0;
            decimal decTotalTenThousands = 0;

            StringBuilder sb = new StringBuilder();

            //标题
            sb.Append("<table border='0' cellpadding='0' cellspacing='0' style='margin-left: auto; margin-right: auto; text-align: left;'>");
            sb.Append("<tr>");
            sb.Append("<td align='center' style='font-size: 20pt; font-weight: bold;'>");
            sb.Append(root.Name);
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("<tr>");
            sb.Append("<td align='center' style='font-size: 16pt;'>");
            sb.Append(InnoSoft.LS.Resources.Titles.Stocktaking);
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("<tr>");
            sb.Append("<td>");

            //表头
            sb.Append("<table id='stocktaking' border='0' cellpadding='0' cellspacing='0'>");
            sb.Append("<tr>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; width: 60px;'>");
            sb.Append(InnoSoft.LS.Resources.Labels.Warehouse);
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; width: 40px;'>");
            sb.Append(InnoSoft.LS.Resources.Labels.Location);
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; width: 120px;'>");
            sb.Append(InnoSoft.LS.Resources.Labels.GoodsNo);
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; width: 150px;'>");
            sb.Append(InnoSoft.LS.Resources.Labels.GoodsName);
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; width: 80px;'>");
            sb.Append(InnoSoft.LS.Resources.Labels.Specification);
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; width: 50px;'>");
            sb.Append(InnoSoft.LS.Resources.Labels.GrammeWeight);
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; width: 50px;'>");
            sb.Append(InnoSoft.LS.Resources.Labels.Grade);
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; width: 200px;'>");
            sb.Append(InnoSoft.LS.Resources.Labels.CustomerName);
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; width: 60px;'>");
            sb.Append(InnoSoft.LS.Resources.Labels.Pieces);
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; width: 80px;'>");
            sb.Append(InnoSoft.LS.Resources.Labels.Tunnages);
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; width: 80px;'>");
            sb.Append(InnoSoft.LS.Resources.Labels.Piles);
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black; width: 80px;'>");
            sb.Append(InnoSoft.LS.Resources.Labels.TenThousands);
            sb.Append("</td>");
            sb.Append("</tr>");

            //生成仓库数据
            //var grpWarehouses = from s in listStock
            //                    group s by s.Warehouse;
            var grpWarehouses = listStock.GroupBy(s => s.Warehouse).OrderBy(s => s.Key);
            foreach (var grpWarehouse in grpWarehouses)
            {
                string strWarehouse = grpWarehouse.Key;
                int nWarehouseTotalPackages = grpWarehouse.Sum(s => s.Packages);
                decimal decWarehouseTotalTunnages = grpWarehouse.Sum(s => s.Tunnages);
                decimal decWarehouseTotalPiles = grpWarehouse.Sum(s => s.Piles);
                decimal decWarehouseTotalTenThousands = grpWarehouse.Sum(s => s.TenThousands);

                nTotalPackages += nWarehouseTotalPackages;
                decTotalTunnages += decWarehouseTotalTunnages;
                decTotalPiles += decWarehouseTotalPiles;
                decTotalTenThousands += decWarehouseTotalTenThousands;

                sb.Append("<tr>");
                sb.Append("<td rowspan='").Append((from s in listStock where s.Warehouse == strWarehouse group s by s.Location).Count() + (from s in listStock where s.Warehouse == strWarehouse select s.CustomerId).Count() + 1).Append("' align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                sb.Append(strWarehouse);
                sb.Append("</td>");
                sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                sb.Append("&nbsp;");
                sb.Append("</td>");
                sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                sb.Append("&nbsp;");
                sb.Append("</td>");
                sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                sb.Append("&nbsp;");
                sb.Append("</td>");
                sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                sb.Append("&nbsp;");
                sb.Append("</td>");
                sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                sb.Append("&nbsp;");
                sb.Append("</td>");
                sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                sb.Append("&nbsp;");
                sb.Append("</td>");
                sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                sb.Append("&nbsp;");
                sb.Append("</td>");
                sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                sb.Append(nWarehouseTotalPackages.ToString());
                sb.Append("</td>");
                sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                sb.Append(decWarehouseTotalTunnages.ToString("#0.######"));
                sb.Append("</td>");
                sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                sb.Append(decWarehouseTotalPiles.ToString("#0.######"));
                sb.Append("</td>");
                sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black;'>");
                sb.Append(decWarehouseTotalTenThousands.ToString("#0.######"));
                sb.Append("</td>");

                sb.Append("</tr>");

                //生成货位数据
                //var grpLocations = from s in listStock
                //                   where s.Warehouse == strWarehouse
                //                   group s by s.Location;

                var grpLocations = grpWarehouse.GroupBy(s => s.Location).OrderBy(s => s.Key);
                foreach (var grpLocation in grpLocations)
                {
                    string strLocation = grpLocation.Key;
                    int nLocationTotalPackages = grpLocation.Sum(s => s.Packages);
                    decimal decLocationTotalTunnages = grpLocation.Sum(s => s.Tunnages);
                    decimal decLocationTotalPiles = grpLocation.Sum(s => s.Piles);
                    decimal decLocationTotalTenThousands = grpLocation.Sum(s => s.TenThousands);

                    sb.Append("<tr>");
                    sb.Append("<td rowspan='").Append((from s in listStock where s.Warehouse == strWarehouse && s.Location == strLocation select s.CustomerId).Count() + 1).Append("' align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                    sb.Append(strLocation);
                    sb.Append("</td>");
                    sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                    sb.Append("&nbsp;");
                    sb.Append("</td>");
                    sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                    sb.Append("&nbsp;");
                    sb.Append("</td>");
                    sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                    sb.Append("&nbsp;");
                    sb.Append("</td>");
                    sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                    sb.Append("&nbsp;");
                    sb.Append("</td>");
                    sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                    sb.Append("&nbsp;");
                    sb.Append("</td>");
                    sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                    sb.Append("&nbsp;");
                    sb.Append("</td>");
                    sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                    sb.Append(nLocationTotalPackages.ToString());
                    sb.Append("</td>");
                    sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                    sb.Append(decLocationTotalTunnages.ToString("#0.######"));
                    sb.Append("</td>");
                    sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                    sb.Append(decLocationTotalPiles.ToString("#0.######"));
                    sb.Append("</td>");
                    sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black;'>");
                    sb.Append(decLocationTotalTenThousands.ToString("#0.######"));
                    sb.Append("</td>");
                    sb.Append("</tr>");

                    //生成货位明细数据
                    //var goods = from s in listStock
                    //            where s.Warehouse == strWarehouse && s.Location == strLocation
                    //            select new
                    //            {
                    //                s.GoodsNo,
                    //                s.GoodsName,
                    //                s.SpecModel,
                    //                s.GWeight,
                    //                s.Grade,
                    //                s.CustomerName,
                    //                s.Packages,
                    //                s.Tunnages
                    //            };

                    var goods = from s in grpLocation
                                select new
                                {
                                    s.GoodsNo,
                                    s.GoodsName,
                                    s.SpecModel,
                                    s.GWeight,
                                    s.Grade,
                                    s.CustomerName,
                                    s.Packages,
                                    s.Tunnages,
                                    s.Piles,
                                    s.TenThousands
                                };

                    foreach (var g in goods)
                    {
                        sb.Append("<tr>");
                        sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                        sb.Append(g.GoodsNo);
                        sb.Append("</td>");
                        sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                        sb.Append(g.GoodsName);
                        sb.Append("</td>");
                        sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                        sb.Append(g.SpecModel);
                        sb.Append("</td>");
                        sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                        sb.Append(g.GWeight);
                        sb.Append("</td>");
                        sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                        sb.Append(g.Grade);
                        sb.Append("</td>");
                        sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                        sb.Append(g.CustomerName);
                        sb.Append("</td>");
                        sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                        sb.Append(g.Packages.ToString());
                        sb.Append("</td>");
                        sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                        sb.Append(g.Tunnages.ToString("#0.######"));
                        sb.Append("</td>");
                        sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black;'>");
                        sb.Append(g.Piles.ToString("#0.######"));
                        sb.Append("</td>");
                        sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black;'>");
                        sb.Append(g.TenThousands.ToString("#0.######"));
                        sb.Append("</td>");
                        sb.Append("</tr>");
                    }
                }
            }

            //合计
            sb.Append("<tr>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'>");
            sb.Append(InnoSoft.LS.Resources.Labels.FinalTotal);
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'>");
            sb.Append("&nbsp;");
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'>");
            sb.Append("&nbsp;");
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'>");
            sb.Append("&nbsp;");
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'>");
            sb.Append("&nbsp;");
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'>");
            sb.Append("&nbsp;");
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'>");
            sb.Append("&nbsp;");
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'>");
            sb.Append("&nbsp;");
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'>");
            sb.Append(nTotalPackages.ToString());
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'>");
            sb.Append(decTotalTunnages.ToString("#0.######"));
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black;'>");
            sb.Append(decTotalPiles.ToString("#0.######"));
            sb.Append("</td>");
            sb.Append("<td align='center' valign='top' style='border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black; border-bottom: 1px solid black;'>");
            sb.Append(decTotalTenThousands.ToString("#0.######"));
            sb.Append("</td>");
            sb.Append("</tr>");

            sb.Append("</table>");
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("</table>");

            return Content(sb.ToString());
        }

        /// <summary>
        /// GET导出盘点表
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportStocktaking()
        {
            //读取条件
            var request = HttpContext.Request;

            string warehouse = request.QueryString["Warehouse"] ?? string.Empty;
            string location = request.QueryString["Location"] ?? string.Empty;

            //读取库存数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<Stock> listStock = stock.LoadStocktakingByConditions(warehouse, location, LoginAccountId, LoginStaffName, out strErrText);
            if (listStock == null)
            {
                throw new Exception(strErrText);
            }

            //生成GridView数据源
            int nTotalPackages = 0;
            decimal decTotalTunnages = 0;
            decimal decTotalPiles = 0;
            decimal decTotalTenThousands = 0;

            List<Stock> listSource = new List<Stock>();

            //var grpWarehouses = from s in listStock
            //                    group s by s.Warehouse;
            var grpWarehouses = listStock.GroupBy(s => s.Warehouse).OrderBy(s => s.Key);
            foreach (var grpWarehouse in grpWarehouses)
            {
                string strWarehouse = grpWarehouse.Key;
                int nWarehouseTotalPackages = grpWarehouse.Sum(s => s.Packages);
                decimal decWarehouseTotalTunnages = grpWarehouse.Sum(s => s.Tunnages);
                decimal decWarehouseTotalPiles = grpWarehouse.Sum(s => s.Piles);
                decimal decWarehouseTotalTenThousands = grpWarehouse.Sum(s => s.TenThousands);

                nTotalPackages += nWarehouseTotalPackages;
                decTotalTunnages += decWarehouseTotalTunnages;
                decTotalPiles += decWarehouseTotalPiles;
                decTotalTenThousands += decWarehouseTotalTenThousands;

                //生成货位数据
                //var grpLocations = from s in listStock
                //                   where s.Warehouse == strWarehouse
                //                   group s by s.Location;
                var grpLocations = grpWarehouse.GroupBy(s => s.Location).OrderBy(s => s.Key);
                foreach (var grpLocation in grpLocations)
                {
                    string strLocation = grpLocation.Key;
                    int nLocationTotalPackages = grpLocation.Sum(s => s.Packages);
                    decimal decLocationTotalTunnages = grpLocation.Sum(s => s.Tunnages);
                    decimal decLocationTotalPiles = grpLocation.Sum(s => s.Piles);
                    decimal decLocationTotalTenThousands = grpLocation.Sum(s => s.TenThousands);

                    //生成货位明细数据
                    //var goods = from s in listStock
                    //            where s.Warehouse == strWarehouse && s.Location == strLocation
                    //            select new
                    //            {
                    //                s.GoodsNo,
                    //                s.GoodsName,
                    //                s.SpecModel,
                    //                s.GWeight,
                    //                s.Grade,
                    //                s.CustomerName,
                    //                s.Packages,
                    //                s.Tunnages
                    //            };

                    var goods = from s in grpLocation
                                select new
                                {
                                    s.GoodsNo,
                                    s.GoodsName,
                                    s.SpecModel,
                                    s.GWeight,
                                    s.Grade,
                                    s.CustomerName,
                                    s.Packages,
                                    s.Tunnages,
                                    s.Piles,
                                    s.TenThousands
                                };

                    foreach (var g in goods)
                    {
                        Stock g2 = new Stock();
                        g2.Warehouse = strWarehouse;
                        g2.Location = strLocation;
                        g2.GoodsNo = g.GoodsNo;
                        g2.GoodsName = g.GoodsName;
                        g2.SpecModel = g.SpecModel;
                        g2.GWeight = g.GWeight;
                        g2.Grade = g.Grade;
                        g2.CustomerName = g.CustomerName;
                        g2.Packages = g.Packages;
                        g2.Tunnages = g.Tunnages;
                        g2.Piles = g.Piles;
                        g2.TenThousands = g.TenThousands;
                        listSource.Add(g2);
                    }

                    //货位小计
                    Stock l = new Stock();
                    l.Warehouse = strWarehouse;
                    l.Location = strLocation;
                    l.GoodsNo = InnoSoft.LS.Resources.Labels.Subtotal;
                    l.Packages = nLocationTotalPackages;
                    l.Tunnages = decLocationTotalTunnages;
                    l.Piles = decLocationTotalPiles;
                    l.TenThousands = decLocationTotalTenThousands;
                    listSource.Add(l);
                }

                //仓库合计
                Stock w = new Stock();
                w.Warehouse = strWarehouse;
                w.Location = InnoSoft.LS.Resources.Labels.Total;
                w.Packages = nWarehouseTotalPackages;
                w.Tunnages = decWarehouseTotalTunnages;
                w.Piles = decWarehouseTotalPiles;
                w.TenThousands = decWarehouseTotalTenThousands;
                listSource.Add(w);
            }

            //总计
            Stock t = new Stock();
            t.Warehouse = InnoSoft.LS.Resources.Labels.FinalTotal;
            t.Packages = nTotalPackages;
            t.Tunnages = decTotalTunnages;
            t.Piles = decTotalPiles;
            t.TenThousands = decTotalTenThousands;
            listSource.Add(t);

            //生成GridView
            BoundField colWarehouse = new BoundField();
            colWarehouse.HeaderText = InnoSoft.LS.Resources.Labels.Warehouse;
            colWarehouse.DataField = "Warehouse";

            BoundField colLocation = new BoundField();
            colLocation.HeaderText = InnoSoft.LS.Resources.Labels.Location;
            colLocation.DataField = "Location";

            BoundField colGoodsNo = new BoundField();
            colGoodsNo.HeaderText = InnoSoft.LS.Resources.Labels.GoodsNo;
            colGoodsNo.DataField = "GoodsNo";

            BoundField colGoodsName = new BoundField();
            colGoodsName.HeaderText = InnoSoft.LS.Resources.Labels.GoodsName;
            colGoodsName.DataField = "GoodsName";

            BoundField colSpecification = new BoundField();
            colSpecification.HeaderText = InnoSoft.LS.Resources.Labels.Specification;
            colSpecification.DataField = "SpecModel";

            BoundField colGrammeWeight = new BoundField();
            colGrammeWeight.HeaderText = InnoSoft.LS.Resources.Labels.GrammeWeight;
            colGrammeWeight.DataField = "GWeight";

            BoundField colGrade = new BoundField();
            colGrade.HeaderText = InnoSoft.LS.Resources.Labels.Grade;
            colGrade.DataField = "Grade";

            BoundField colCustomerName = new BoundField();
            colCustomerName.HeaderText = InnoSoft.LS.Resources.Labels.CustomerName;
            colCustomerName.DataField = "CustomerName";

            BoundField colPieces = new BoundField();
            colPieces.HeaderText = InnoSoft.LS.Resources.Labels.Pieces;
            colPieces.DataField = "Packages";

            BoundField colTunnages = new BoundField();
            colTunnages.HeaderText = InnoSoft.LS.Resources.Labels.Tunnages;
            colTunnages.DataField = "Tunnages";

            BoundField colPiles = new BoundField();
            colPiles.HeaderText = InnoSoft.LS.Resources.Labels.Piles;
            colPiles.DataField = "Piles";

            BoundField colTenThousands = new BoundField();
            colTenThousands.HeaderText = InnoSoft.LS.Resources.Labels.TenThousands;
            colTenThousands.DataField = "TenThousands";

            var grid = new GridView();
            grid.Columns.Add(colWarehouse);
            grid.Columns.Add(colLocation);
            grid.Columns.Add(colGoodsNo);
            grid.Columns.Add(colGoodsName);
            grid.Columns.Add(colSpecification);
            grid.Columns.Add(colGrammeWeight);
            grid.Columns.Add(colGrade);
            grid.Columns.Add(colCustomerName);
            grid.Columns.Add(colPieces);
            grid.Columns.Add(colTunnages);
            grid.Columns.Add(colPiles);
            grid.Columns.Add(colTenThousands);
            grid.AutoGenerateColumns = false;

            grid.DataSource = from s in listSource
                              select new
                              {
                                  Warehouse = s.Warehouse,
                                  Location = s.Location,
                                  GoodsNo = s.GoodsNo,
                                  GoodsName = s.GoodsName,
                                  SpecModel = s.SpecModel,
                                  GWeight = s.GWeight,
                                  Grade = s.Grade,
                                  CustomerName = s.CustomerName,
                                  Packages = s.Packages > 0 ? s.Packages.ToString() : string.Empty,
                                  Tunnages = s.Tunnages > 0 ? s.Tunnages.ToString("#0.######") : string.Empty,
                                  Piles = s.Piles > 0 ? s.Piles.ToString("#0.######") : string.Empty,
                                  TenThousands = s.TenThousands > 0 ? s.TenThousands.ToString("#0.######") : string.Empty
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=Stocktaking.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

            return View("PrintStocktaking");
        }

        #endregion

        #region 查询库存尾差

        /// <summary>
        /// GET查询库存尾差页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchStockEndDifferences()
        {
            string strErrText;

            //生成仓库下拉列表项
            DDSystem dd = new DDSystem();
            List<Warehouse> listWarehouse = dd.LoadWarehouses(LoginAccountId, LoginStaffName, out strErrText);
            if (listWarehouse == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListWarehouse = new List<SelectListItem>();
            selectListWarehouse.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListWarehouse.AddRange(from w in listWarehouse
                                         select new SelectListItem
                                         {
                                             Text = w.Name,
                                             Value = w.Name
                                         });
            ViewData["Warehouses"] = new SelectList(selectListWarehouse, "Value", "Text");

            return View();
        }

        /// <summary>
        /// GET库存尾差表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="customerName"></param>
        /// <param name="warehouse"></param>
        /// <param name="isConsigning"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchStockEndDifferencesGrid(string sidx, string sord, int page, int rows, string customerName, string warehouse, string isConsigning)
        {
            //读取数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<Stock> listStock = stock.LoadStockEndDifferencesByConditions(customerName, string.Empty, warehouse, isConsigning, string.Empty, LoginAccountId, LoginStaffName, out strErrText);
            if (listStock == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listStock.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            var data = listStock.OrderBy(s => s.CustomerName).ThenBy(s => s.GoodsNo).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              s.CustomerName,
                              s.GoodsNo,
                              s.GoodsName,
                              s.Brand,
                              s.SpecModel,
                              s.GWeight,
                              s.Grade,
                              s.BatchNo,
                              s.Packing,
                              s.Warehouse,
                              s.Location,
                              s.Tunnages.ToString("#0.######"),
                              s.ProductionDate,
                              s.DeliveryNo,
                              s.EnterWarehouseBillNo
                          }
                      }).ToArray(),
                userdata = new
                {
                    CustomerName = InnoSoft.LS.Resources.Labels.Total,
                    Tunnages = data.Sum(s => s.Tunnages)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 导出库存尾差
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportStockEndDifferences()
        {
            string strErrText;

            var request = HttpContext.Request;

            string strCustomerName = request.QueryString["customerName"] ?? string.Empty;
            string strWarehouse = request.QueryString["warehouse"] ?? string.Empty;
            string strIsConsigning = request.QueryString["isConsigning"] ?? "false";

            //读取数据
            StockSystem stock = new StockSystem();
            List<Stock> listStock = stock.LoadStockEndDifferencesByConditions(strCustomerName, string.Empty, strWarehouse, strIsConsigning, string.Empty, LoginAccountId, LoginStaffName, out strErrText);
            if (listStock == null)
            {
                throw new Exception(strErrText);
            }

            //汇总
            List<Stock> listStat = new List<Stock>();
            {
                //按客户分组
                var grpCustomerNames = listStock.GroupBy(s => s.CustomerName).OrderBy(s => s.Key);
                foreach (var grpCustomerName in grpCustomerNames)
                {
                    List<Stock> listCustomerNameDetail = grpCustomerName.OrderBy(s => s.GoodsNo).ToList<Stock>();

                    listStat.AddRange(listCustomerNameDetail);

                    //小计
                    Stock subTotal = new Stock();
                    subTotal.CustomerName = InnoSoft.LS.Resources.Labels.Subtotal;
                    subTotal.Tunnages = listCustomerNameDetail.Sum(s => s.Tunnages);
                    listStat.Add(subTotal);
                }

                //总计
                Stock total = new Stock();
                total.CustomerName = InnoSoft.LS.Resources.Labels.Total;
                total.Tunnages = listStock.Sum(s => s.Tunnages);
                listStat.Add(total);
            }

            //生成GridView
            BoundField colCustomerName = new BoundField();
            colCustomerName.HeaderText = InnoSoft.LS.Resources.Labels.CustomerName;
            colCustomerName.DataField = "CustomerName";

            BoundField colGoodsNo = new BoundField();
            colGoodsNo.HeaderText = InnoSoft.LS.Resources.Labels.GoodsNo;
            colGoodsNo.DataField = "GoodsNo";

            BoundField colGoodsName = new BoundField();
            colGoodsName.HeaderText = InnoSoft.LS.Resources.Labels.GoodsName;
            colGoodsName.DataField = "GoodsName";

            BoundField colBrand = new BoundField();
            colBrand.HeaderText = InnoSoft.LS.Resources.Labels.Brand;
            colBrand.DataField = "Brand";

            BoundField colSpecModel = new BoundField();
            colSpecModel.HeaderText = InnoSoft.LS.Resources.Labels.Specification;
            colSpecModel.DataField = "SpecModel";

            BoundField colGWeight = new BoundField();
            colGWeight.HeaderText = InnoSoft.LS.Resources.Labels.GrammeWeight;
            colGWeight.DataField = "GWeight";

            BoundField colGrade = new BoundField();
            colGrade.HeaderText = InnoSoft.LS.Resources.Labels.Grade;
            colGrade.DataField = "Grade";

            BoundField colBatchNo = new BoundField();
            colBatchNo.HeaderText = InnoSoft.LS.Resources.Labels.BatchNo;
            colBatchNo.DataField = "BatchNo";

            BoundField colPacking = new BoundField();
            colPacking.HeaderText = InnoSoft.LS.Resources.Labels.PackingSpecification;
            colPacking.DataField = "Packing";

            BoundField colWarehouse = new BoundField();
            colWarehouse.HeaderText = InnoSoft.LS.Resources.Labels.Warehouse;
            colWarehouse.DataField = "Warehouse";

            BoundField colLocation = new BoundField();
            colLocation.HeaderText = InnoSoft.LS.Resources.Labels.Location;
            colLocation.DataField = "Location";

            BoundField colTunnages = new BoundField();
            colTunnages.HeaderText = InnoSoft.LS.Resources.Labels.Tunnages;
            colTunnages.DataField = "Tunnages";

            BoundField colProductionDate = new BoundField();
            colProductionDate.HeaderText = InnoSoft.LS.Resources.Labels.ProductionDate;
            colProductionDate.DataField = "ProductionDate";

            BoundField colDeliveryNo = new BoundField();
            colDeliveryNo.HeaderText = InnoSoft.LS.Resources.Labels.DeliveryNo;
            colDeliveryNo.DataField = "DeliveryNo";

            BoundField colEnterWarehouseBillNo = new BoundField();
            colEnterWarehouseBillNo.HeaderText = InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo;
            colEnterWarehouseBillNo.DataField = "EnterWarehouseBillNo";

            var grid = new GridView();
            grid.Columns.Add(colCustomerName);
            grid.Columns.Add(colGoodsNo);
            grid.Columns.Add(colGoodsName);
            grid.Columns.Add(colBrand);
            grid.Columns.Add(colSpecModel);
            grid.Columns.Add(colGWeight);
            grid.Columns.Add(colGrade);
            grid.Columns.Add(colBatchNo);
            grid.Columns.Add(colPacking);
            grid.Columns.Add(colWarehouse);
            grid.Columns.Add(colLocation);
            grid.Columns.Add(colTunnages);
            grid.Columns.Add(colProductionDate);
            grid.Columns.Add(colDeliveryNo);
            grid.Columns.Add(colEnterWarehouseBillNo);

            grid.AutoGenerateColumns = false;

            grid.DataSource = from s in listStat
                              select new
                              {
                                  CustomerName = s.CustomerName,
                                  GoodsNo = s.GoodsNo,
                                  GoodsName = s.GoodsName,
                                  Brand = s.Brand,
                                  SpecModel = s.SpecModel,
                                  GWeight = s.GWeight,
                                  Grade = s.Grade,
                                  BatchNo = s.BatchNo,
                                  Packing = s.Packing,
                                  Warehouse = s.Warehouse,
                                  Location = s.Location,
                                  Tunnages = s.Tunnages.ToString("#0.######"),
                                  ProductionDate = s.ProductionDate,
                                  DeliveryNo = s.DeliveryNo,
                                  EnterWarehouseBillNo = s.EnterWarehouseBillNo
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=StockEndDifferences.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

            return View("SearchStockEndDifferences");
        }

        #endregion

        #region 尾差入库

        /// <summary>
        /// GET尾差入库页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult EnterStockEndDifferences()
        {
            //创建Model
            EnterWarehouseBillViewModel model = new EnterWarehouseBillViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.Goods = new List<EnterWarehouseBillGoodsViewModel>();
            model.Goods.Add(new EnterWarehouseBillGoodsViewModel());

            return View(model);
        }

        /// <summary>
        /// GET货物库存尾差表格JSON数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="customerName"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadGoodsStockEndDifferencesGrid(string sidx, string sord, int page, int rows, string customerName)
        {
            //读取库存数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<Stock> listStock = stock.LoadStockEndDifferencesByConditions(customerName, string.Empty, string.Empty, "false", string.Empty, LoginAccountId, LoginStaffName, out strErrText);
            if (listStock == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listStock.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            var data = listStock.OrderBy(s => s.BatchNo).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              s.GoodsId.ToString(), 
                              s.GoodsNo, 
                              s.GoodsName,
                              s.Brand,
                              s.SpecModel,
                              s.GWeight,
                              s.Grade,
                              s.BatchNo,
                              s.Packing,
                              s.Warehouse,
                              s.Location,
                              s.Packages.ToString(),
                              s.Packages != 0 ? (s.Tunnages / s.Packages).ToString("#0.######") : s.PieceWeight.ToString("#0.######"),
                              s.Tunnages.ToString("#0.######"),
                              s.ProductionDate,
                              s.EnterWarehouseBillId.ToString(),
                              s.EnterWarehouseBillNo
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region 尾差出库

        /// <summary>
        /// GET尾差出库页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult OutStockEndDifferences()
        {
            string strErrText;

            //创建Model
            OutWarehouseBillViewModel model = new OutWarehouseBillViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.Goods = new List<OutWarehouseBillGoodsViewModel>();
            model.Goods.Add(new OutWarehouseBillGoodsViewModel());

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
            ViewData["Countrys"] = new SelectList(selectListCountry, "Value", "Text", model.ReceiverCountry);

            //生成省份下拉列表项
            List<Province> listState = null;
            if (!string.IsNullOrEmpty(model.ReceiverCountry))
            {
                listState = dd.LoadProvincesByCountry(model.ReceiverCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listState == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listState = new List<Province>();
            }
            List<SelectListItem> selectListState = new List<SelectListItem>();
            selectListState.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListState.AddRange(from p in listState
                                     select new SelectListItem
                                     {
                                         Text = p.Name,
                                         Value = p.Name
                                     });
            ViewData["Provinces"] = new SelectList(selectListState, "Value", "Text", model.ReceiverProvince);

            //生成城市下拉列表项
            List<City> listCity = null;
            if (!string.IsNullOrEmpty(model.ReceiverProvince))
            {
                listCity = dd.LoadCitysByProvince(model.ReceiverCountry, model.ReceiverProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listCity = new List<City>();
            }
            List<SelectListItem> selectListCity = new List<SelectListItem>();
            selectListCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListCity.AddRange(from ci in listCity
                                    select new SelectListItem
                                    {
                                        Text = ci.Name,
                                        Value = ci.Name
                                    });
            ViewData["Citys"] = new SelectList(selectListCity, "Value", "Text", model.ReceiverCity);

            //生成仓库下拉列表项
            List<Warehouse> listWarehouse = dd.LoadWarehouses(LoginAccountId, LoginStaffName, out strErrText);
            if (listWarehouse == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListWarehouse = new List<SelectListItem>();
            selectListWarehouse.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListWarehouse.AddRange(from w in listWarehouse
                                         select new SelectListItem
                                         {
                                             Text = w.Name,
                                             Value = w.Name
                                         });
            ViewData["Warehouses"] = new SelectList(selectListWarehouse, "Value", "Text", model.Warehouse);

            return View(model);
        }

        #endregion
    }
}
