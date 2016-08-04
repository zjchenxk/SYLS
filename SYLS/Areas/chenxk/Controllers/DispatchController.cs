using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using InnoSoft.LS.Business.Facades;
using InnoSoft.LS.Models;
using SYLS.Areas.chenxk.ViewModels;
using SYLS.Controllers;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.Controllers
{
    /// <summary>
    /// 调度管理控制器
    /// </summary>
    public class DispatchController : BaseController
    {
        #region 调度计划代码

        #region 调度计划代码

        /// <summary>
        /// GET调度发货计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult DispatchDeliverPlans()
        {
            string strErrText;

            ViewData["Chenxk_ControllerTime"] = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

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
            ViewData["Warehouses"] = new SelectList(selectListWarehouse, "Value", "Text");

            return View();
        }

        /// <summary>
        /// GET待调度计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="organId"></param>
        /// <param name="customerName"></param>
        /// <param name="shipmentNo"></param>
        /// <param name="deliveryNo"></param>
        /// <param name="receiverName"></param>
        /// <param name="destCountry"></param>
        /// <param name="destProvince"></param>
        /// <param name="destCity"></param>
        /// <param name="warehouse"></param>
        /// <param name="arrivalTime"></param>
        /// <param name="carNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchDeliverPlansGrid(string sidx, string sord, int page, int rows, string organId, string customerName, string shipmentNo, string deliveryNo, string receiverName, string destCountry, string destProvince, string destCity, string warehouse, string arrivalTime, string carNo)
        {
            //读取数据
            string strErrText;
            PlanSystem plan = new PlanSystem();
            List<DeliverPlan> listPlan = plan.LoadDispatchDeliverPlans(organId, customerName, shipmentNo, deliveryNo, receiverName, destCountry, destProvince, destCity, warehouse, arrivalTime, carNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listPlan == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listPlan.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listPlan.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              p.PlanNo, 
                              p.CustomerName,
                              p.ShipmentNo,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.ReceiverCity,
                              p.Warehouse,
                              p.ArrivalTime,
                              p.PlanType,
                              p.BalanceTunnages.ToString("#0.######"),
                              p.BalancePiles.ToString("#0.######"),
                              p.CreateTime.ToString("yyyy-MM-dd"),
                              p.ReceiveType,
                              p.CarNo,
                              p.Remark
                          }
                      }).ToArray(),
                userdata = new
                {
                    PlanNo = InnoSoft.LS.Resources.Labels.Total,
                    BalanceTunnages = data.Sum(s => s.BalanceTunnages),
                    BalancePiles = data.Sum(s => s.BalancePiles)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET外地来货计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadForeignDeliverPlansGrid(string sidx, string sord, int page, int rows)
        {
            string strErrText;

            //读取数据
            PlanSystem plan = new PlanSystem();
            List<DeliverPlan> listPlan = plan.LoadForeignDeliverPlans(page, rows, LoginAccountId, LoginStaffName, out strErrText);
            if (listPlan == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listPlan.Count > 0 ? listPlan[0].TotalRows : 0;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            //string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "DESC");
            //var data = listPlan.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from p in listPlan
                      select new
                      {
                          id = p.Id,
                          cell = new string[] { 
                              p.Id.ToString(), 
                              p.PlanNo, 
                              p.CustomerName,
                              p.ShipmentNo,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.StartCity,
                              p.CarNo,
                              p.DriverName,
                              p.DriverMobileTel,
                              p.ArrivalTime,
                              p.PlanType,
                              p.TotalTunnages.ToString("#0.######"),
                              p.TotalPiles.ToString("#0.######"),
                              p.CreateTime.ToString("yyyy-MM-dd")
                          }
                      }).ToArray(),
                userdata = new
                {
                    PlanNo = InnoSoft.LS.Resources.Labels.Total,
                    TotalTunnages = listPlan.Sum(s => s.TotalTunnages),
                    TotalPiles = listPlan.Sum(s => s.TotalPiles)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region 查看详细信息代码

        /// <summary>
        /// GET查看待调度纸发货计划详细信息页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ViewDispatchPaperPlanDetails(string id)
        {
            ViewData["id"] = id;
            ViewData["BackTo"] = Request.UrlReferrer.AbsolutePath;

            return View();
        }

        /// <summary>
        /// GET纸发货计划货物调度历史记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="planId"></param>
        /// <param name="goodsId"></param>
        /// <param name="batchNo"></param>
        /// <param name="packing"></param>
        /// <param name="location"></param>
        /// <param name="productionDate"></param>
        /// <param name="enterWarehouseBillId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPaperPlanGoodsDispatchHistoryGrid(string sidx, string sord, int page, int rows, string planId, string goodsId, string batchNo, string packing, string location, string productionDate, string enterWarehouseBillId)
        {
            string strErrText;

            //读取数据
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadAllDispatchBillGoodsByConditions(planId, goodsId, batchNo, packing, location, productionDate, enterWarehouseBillId, LoginAccountId, LoginStaffName, out strErrText);
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
                              g.CarNo,
                              g.TrailerNo,
                              g.BatchNo,
                              g.Packing,
                              g.Location,
                              g.Packages.ToString(),
                              g.Tunnages.ToString("#0.######"),
                              g.ProductionDate,
                              g.EnterWarehouseBillId.ToString(),
                              g.EnterWarehouseBillNo
                          }
                      }).ToArray(),
                userdata = new
                {
                    CreateTime = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET查看待调度罐发货计划详细信息页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ViewDispatchCanPlanDetails(string id)
        {
            ViewData["id"] = id;
            ViewData["BackTo"] = Request.UrlReferrer.AbsolutePath;

            return View();
        }

        /// <summary>
        /// GET罐发货计划货物调度历史记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="planId"></param>
        /// <param name="goodsId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCanPlanGoodsDispatchHistoryGrid(string sidx, string sord, int page, int rows, string planId, string goodsId)
        {
            string strErrText;

            //读取数据
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadAllDispatchBillGoodsByConditions(planId, goodsId, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, LoginAccountId, LoginStaffName, out strErrText);
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
                              g.CarNo,
                              g.TrailerNo,
                              g.Piles.ToString("#0.######"),                               
                              g.TenThousands.ToString("#0.######") 
                          }
                      }).ToArray(),
                userdata = new
                {
                    CreateTime = InnoSoft.LS.Resources.Labels.Total,
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET查看待调度方便面发货计划详细信息页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ViewDispatchNoodlePlanDetails(string id)
        {
            ViewData["id"] = id;
            ViewData["BackTo"] = Request.UrlReferrer.AbsolutePath;

            return View();
        }

        /// <summary>
        /// GET方便面发货计划货物调度历史记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="planId"></param>
        /// <param name="goodsId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadNoodlePlanGoodsDispatchHistoryGrid(string sidx, string sord, int page, int rows, string planId, string goodsId)
        {
            string strErrText;

            //读取数据
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadAllDispatchBillGoodsByConditions(planId, goodsId, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, LoginAccountId, LoginStaffName, out strErrText);
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
                              g.CarNo,
                              g.TrailerNo,
                              g.Packages.ToString(),
                              g.Tunnages.ToString("#0.######")
                          }
                      }).ToArray(),
                userdata = new
                {
                    CreateTime = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET查看待调度其它发货计划详细信息页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ViewDispatchOtherPlanDetails(string id)
        {
            ViewData["id"] = id;
            ViewData["BackTo"] = Request.UrlReferrer.AbsolutePath;

            return View();
        }

        /// <summary>
        /// GET其它发货计划货物调度历史记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="planId"></param>
        /// <param name="goodsId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadOtherPlanGoodsDispatchHistoryGrid(string sidx, string sord, int page, int rows, string planId, string goodsId)
        {
            string strErrText;

            //读取数据
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadAllDispatchBillGoodsByConditions(planId, goodsId, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, LoginAccountId, LoginStaffName, out strErrText);
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
                              g.CarNo,
                              g.TrailerNo,
                              g.Packages.ToString(),
                              g.Tunnages.ToString("#0.######")
                          }
                      }).ToArray(),
                userdata = new
                {
                    CreateTime = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region 调度纸发货计划代码

        /// <summary>
        /// GET调度纸发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult DispatchPaperPlan(string id)
        {
            string strErrText;

            //读取发货计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan deliverPlan = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (deliverPlan == null)
            {
                throw new Exception(strErrText);
            }

            //如果是配送
            if (deliverPlan.ReceiveType == InnoSoft.LS.Resources.Options.PickUpDelivery)
            {
                //创建Model
                DispatchBillViewModel model = new DispatchBillViewModel();
                model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

                model.DeliverPlans = new List<DispatchBillDeliverPlanViewModel>();
                DispatchBillDeliverPlanViewModel modelDeliverPlan = new DispatchBillDeliverPlanViewModel();
                modelDeliverPlan.PlanId = deliverPlan.Id;
                model.DeliverPlans.Add(modelDeliverPlan);

                return View(model);
            }
            //如果是自提
            else
            {
                //创建Model
                DispatchBillViewModel model = new DispatchBillViewModel();
                model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

                //读取车号是否已有调度单
                DispatchSystem dispatch = new DispatchSystem();
                DispatchBill dispatchBill = dispatch.LoadSubmitDispatchBillByCarNo(deliverPlan.CarNo, LoginAccountId, LoginStaffName, out strErrText);
                if (dispatchBill != null)
                {
                    model.CarNo = dispatchBill.CarNo;
                    model.TrailerNo = dispatchBill.TrailerNo;
                    model.DriverName = dispatchBill.DriverName;
                    model.DriverLicenseNo = dispatchBill.DriverLicenseNo;
                    model.DriverMobileTel = dispatchBill.DriverMobileTel;
                    model.DriverHomeTel = dispatchBill.DriverHomeTel;
                    model.CarrierId = dispatchBill.CarrierId;
                    model.CarrierName = dispatchBill.CarrierName;
                    model.CarryingCapacity = dispatchBill.CarryingCapacity;

                    //读取承运单位信息
                    DDSystem dd = new DDSystem();
                    Carrier carrier = dd.LoadCarrier(dispatchBill.CarrierId, LoginAccountId, LoginStaffName, out strErrText);
                    if (carrier != null)
                    {
                        model.BusinessType = carrier.BusinessType;
                        model.PaymentType = carrier.PaymentType;
                    }
                }
                else
                {
                    model.CarNo = deliverPlan.CarNo;
                    model.TrailerNo = deliverPlan.TrailerNo;
                    model.DriverName = deliverPlan.DriverName;
                    model.DriverLicenseNo = deliverPlan.DriverLicenseNo;
                    model.DriverMobileTel = deliverPlan.DriverMobileTel;
                    model.DriverHomeTel = deliverPlan.DriverHomeTel;
                    model.CarrierId = deliverPlan.CarrierId;
                    model.CarrierName = deliverPlan.CarrierName;

                    //读取车辆载重
                    DDSystem dd = new DDSystem();
                    CarrierCar car = dd.LoadCarByCarNo(deliverPlan.CarNo, LoginAccountId, LoginStaffName, out strErrText);
                    if (car != null)
                    {
                        model.CarryingCapacity = car.CarryingCapacity;
                    }

                    //读取承运单位信息
                    Carrier carrier = dd.LoadCarrierByCarNo(deliverPlan.CarNo, LoginAccountId, LoginStaffName, out strErrText);
                    if (carrier != null)
                    {
                        model.CarrierId = carrier.Id;
                        model.CarrierName = carrier.Name;
                        model.BusinessType = carrier.BusinessType;
                        model.PaymentType = carrier.PaymentType;
                    }
                }

                model.DeliverPlans = new List<DispatchBillDeliverPlanViewModel>();
                DispatchBillDeliverPlanViewModel modelDeliverPlan = new DispatchBillDeliverPlanViewModel();
                modelDeliverPlan.PlanId = deliverPlan.Id;
                model.DeliverPlans.Add(modelDeliverPlan);

                return View(model);
            }
        }

        /// <summary>
        /// GET已配载纸计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="carNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchedPaperPlansGrid(string sidx, string sord, int page, int rows, string carNo)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillDeliverPlan> listPlan = dispatch.LoadDispatchBillDeliverPlansByCarNo(carNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listPlan == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listPlan.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "PlanNo") + " " + (sord ?? "ASC");
            var data = listPlan.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              p.PlanNo, 
                              p.CustomerName,
                              p.ShipmentNo,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.ReceiverCity,
                              p.PlanType,
                              p.Tunnages.ToString("#0.######"),
                              p.TransportPrice.ToString("#0.######"),
                              p.TransportCharges.ToString(),
                              p.Remark
                          }
                      }).ToArray(),
                userdata = new
                {
                    PlanNo = InnoSoft.LS.Resources.Labels.Total,
                    Tunnages = data.Sum(s => s.Tunnages),
                    TransportCharges = data.Sum(s => s.TransportCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET待调度纸计划货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchPaperPlanGoodsGrid(string sidx, string sord, int page, int rows, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchPaperPlanAllGoods(long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.Brand,
                              g.SpecModel,
                              g.GWeight,
                              g.Grade,
                              g.BatchNo,
                              g.Packing,
                              g.Warehouse,
                              g.Location,
                              g.Packages.ToString(),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              g.ProductionDate,
                              g.EnterWarehouseBillId.ToString(),
                              g.EnterWarehouseBillNo,
                              "0",
                              "0"
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    ActualPackages = 0,
                    ActualTunnages = 0
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region 调度纸直发货计划

        /// <summary>
        /// GET调度纸直发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult DispatchNotDeliverPaperPlan(string id)
        {
            //创建Model
            DispatchBillViewModel model = new DispatchBillViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.DeliverPlans = new List<DispatchBillDeliverPlanViewModel>();
            DispatchBillDeliverPlanViewModel modelDeliverPlan = new DispatchBillDeliverPlanViewModel();
            modelDeliverPlan.PlanId = long.Parse(id);
            model.DeliverPlans.Add(modelDeliverPlan);

            return View(model);
        }

        /// <summary>
        /// GET待调度纸直发计划货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchNotDeliverPaperPlanGoodsGrid(string sidx, string sord, int page, int rows, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchDeliverPlanAllGoods(long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.Brand,
                              g.SpecModel,
                              g.GWeight,
                              g.Grade,
                              g.BatchNo,
                              g.Packages.ToString(),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              g.Packing,
                              "0",
                              "0"
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    ActualPackages = 0,
                    ActualTunnages = 0
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region 调度罐发货计划

        /// <summary>
        /// GET调度罐发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult DispatchCanPlan(string id)
        {
            string strErrText;

            //读取发货计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan deliverPlan = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (deliverPlan == null)
            {
                throw new Exception(strErrText);
            }

            //如果是配送
            if (deliverPlan.ReceiveType == InnoSoft.LS.Resources.Options.PickUpDelivery)
            {
                //创建Model
                DispatchBillViewModel model = new DispatchBillViewModel();
                model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

                model.DeliverPlans = new List<DispatchBillDeliverPlanViewModel>();
                DispatchBillDeliverPlanViewModel modelDeliverPlan = new DispatchBillDeliverPlanViewModel();
                modelDeliverPlan.PlanId = deliverPlan.Id;
                model.DeliverPlans.Add(modelDeliverPlan);

                return View(model);
            }
            //如果是自提
            else
            {
                //创建Model
                DispatchBillViewModel model = new DispatchBillViewModel();
                model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

                //读取车号是否已有调度单
                DispatchSystem dispatch = new DispatchSystem();
                DispatchBill dispatchBill = dispatch.LoadSubmitDispatchBillByCarNo(deliverPlan.CarNo, LoginAccountId, LoginStaffName, out strErrText);
                if (dispatchBill != null)
                {
                    model.CarNo = dispatchBill.CarNo;
                    model.TrailerNo = dispatchBill.TrailerNo;
                    model.DriverName = dispatchBill.DriverName;
                    model.DriverLicenseNo = dispatchBill.DriverLicenseNo;
                    model.DriverMobileTel = dispatchBill.DriverMobileTel;
                    model.DriverHomeTel = dispatchBill.DriverHomeTel;
                    model.CarrierId = dispatchBill.CarrierId;
                    model.CarrierName = dispatchBill.CarrierName;
                    model.CarryingCapacity = dispatchBill.CarryingCapacity;

                    //读取承运单位信息
                    DDSystem dd = new DDSystem();
                    Carrier carrier = dd.LoadCarrier(dispatchBill.CarrierId, LoginAccountId, LoginStaffName, out strErrText);
                    if (carrier != null)
                    {
                        model.BusinessType = carrier.BusinessType;
                        model.PaymentType = carrier.PaymentType;
                    }
                }
                else
                {
                    model.CarNo = deliverPlan.CarNo;
                    model.TrailerNo = deliverPlan.TrailerNo;
                    model.DriverName = deliverPlan.DriverName;
                    model.DriverLicenseNo = deliverPlan.DriverLicenseNo;
                    model.DriverMobileTel = deliverPlan.DriverMobileTel;
                    model.DriverHomeTel = deliverPlan.DriverHomeTel;
                    model.CarrierId = deliverPlan.CarrierId;
                    model.CarrierName = deliverPlan.CarrierName;

                    //读取车辆载重
                    DDSystem dd = new DDSystem();
                    CarrierCar car = dd.LoadCarByCarNo(deliverPlan.CarNo, LoginAccountId, LoginStaffName, out strErrText);
                    if (car != null)
                    {
                        model.CarryingCapacity = car.CarryingCapacity;
                    }

                    //读取承运单位信息
                    Carrier carrier = dd.LoadCarrierByCarNo(deliverPlan.CarNo, LoginAccountId, LoginStaffName, out strErrText);
                    if (carrier != null)
                    {
                        model.CarrierId = carrier.Id;
                        model.CarrierName = carrier.Name;
                        model.BusinessType = carrier.BusinessType;
                        model.PaymentType = carrier.PaymentType;
                    }
                }

                model.DeliverPlans = new List<DispatchBillDeliverPlanViewModel>();
                DispatchBillDeliverPlanViewModel modelDeliverPlan = new DispatchBillDeliverPlanViewModel();
                modelDeliverPlan.PlanId = deliverPlan.Id;
                model.DeliverPlans.Add(modelDeliverPlan);

                return View(model);
            }
        }

        /// <summary>
        /// GET已配载罐计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="carNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchedCanPlansGrid(string sidx, string sord, int page, int rows, string carNo)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillDeliverPlan> listPlan = dispatch.LoadDispatchBillDeliverPlansByCarNo(carNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listPlan == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listPlan.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "PlanNo") + " " + (sord ?? "ASC");
            var data = listPlan.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              p.PlanNo, 
                              p.CustomerName,
                              p.ShipmentNo,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.ReceiverCity,
                              p.PlanType,
                              p.Piles.ToString("#0.######"),
                              p.TransportPrice.ToString("#0.######"),
                              p.TransportCharges.ToString(),
                              p.Remark
                          }
                      }).ToArray(),
                userdata = new
                {
                    PlanNo = InnoSoft.LS.Resources.Labels.Total,
                    Piles = data.Sum(s => s.Piles),
                    TransportCharges = data.Sum(s => s.TransportCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET待调度罐计划货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchCanPlanGoodsGrid(string sidx, string sord, int page, int rows, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchCanPlanAllGoods(long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.SpecModel,
                              g.BatchNo,
                              g.Warehouse,
                              g.Location,
                              g.Piles.ToString("#0.######"),
                              g.TenThousands.ToString("#0.######"),
                              g.ProductionDate,
                              g.EnterWarehouseBillId.ToString(),
                              g.EnterWarehouseBillNo,
                              "0",
                              "0"
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands),
                    ActualPiles = 0,
                    ActualTenThousands = 0
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region 调度罐直发货计划

        /// <summary>
        /// GET调度罐直发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult DispatchNotDeliverCanPlan(string id)
        {
            //创建Model
            DispatchBillViewModel model = new DispatchBillViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.DeliverPlans = new List<DispatchBillDeliverPlanViewModel>();
            DispatchBillDeliverPlanViewModel modelDeliverPlan = new DispatchBillDeliverPlanViewModel();
            modelDeliverPlan.PlanId = long.Parse(id);
            model.DeliverPlans.Add(modelDeliverPlan);

            return View(model);
        }

        /// <summary>
        /// GET待调度罐直发货计划货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchNotDeliverCanPlanGoodsGrid(string sidx, string sord, int page, int rows, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchDeliverPlanAllGoods(long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.SpecModel,
                              g.Piles.ToString("#0.######"),
                              g.TenThousands.ToString("#0.######"),
                              "0",
                              "0"
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands),
                    ActualPiles = 0,
                    ActualTenThousands = 0
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region 调度方便面发货计划

        /// <summary>
        /// GET调度方便面发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult DispatchNoodlePlan(string id)
        {
            string strErrText;

            //读取发货计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan deliverPlan = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (deliverPlan == null)
            {
                throw new Exception(strErrText);
            }

            //读取发货计划起讫点的距离
            int nKM = 0;
            DDSystem dd = new DDSystem();
            ReceiverDistance distance = dd.LoadReceiverDistance(deliverPlan.ReceiverName, deliverPlan.StartCountry, deliverPlan.StartProvince, deliverPlan.StartCity, LoginAccountId, LoginStaffName, out strErrText);
            if (distance != null)
            {
                nKM = distance.KM;
            }

            //创建Model
            DispatchBillViewModel model = new DispatchBillViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.DeliverPlans = new List<DispatchBillDeliverPlanViewModel>();
            DispatchBillDeliverPlanViewModel modelDeliverPlan = new DispatchBillDeliverPlanViewModel();
            modelDeliverPlan.PlanId = long.Parse(id);
            modelDeliverPlan.KM = nKM;
            model.DeliverPlans.Add(modelDeliverPlan);

            return View(model);
        }

        /// <summary>
        /// GET已配载方便面计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="carNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchedNoodlePlansGrid(string sidx, string sord, int page, int rows, string carNo)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillDeliverPlan> listPlan = dispatch.LoadDispatchBillDeliverPlansByCarNo(carNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listPlan == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listPlan.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "PlanNo") + " " + (sord ?? "ASC");
            var data = listPlan.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              p.PlanNo, 
                              p.CustomerName,
                              p.ShipmentNo,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.ReceiverCity,
                              p.PlanType,
                              p.Tunnages.ToString("#0.######"),
                              p.TransportPrice.ToString("#0.######"),
                              p.TransportCharges.ToString(),
                              p.Remark
                          }
                      }).ToArray(),
                userdata = new
                {
                    PlanNo = InnoSoft.LS.Resources.Labels.Total,
                    Tunnages = data.Sum(s => s.Tunnages),
                    TransportCharges = data.Sum(s => s.TransportCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET待调度方便面计划货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchNoodlePlanGoodsGrid(string sidx, string sord, int page, int rows, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchDeliverPlanAllGoods(long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.SpecModel,
                              g.Packages.ToString(),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              "0",
                              "0"
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    ActualPackages = 0,
                    ActualTunnages = 0
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region 调度其它发货计划

        /// <summary>
        /// GET调度其它发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult DispatchOtherPlan(string id)
        {
            //创建Model
            DispatchBillViewModel model = new DispatchBillViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.DeliverPlans = new List<DispatchBillDeliverPlanViewModel>();
            DispatchBillDeliverPlanViewModel modelDeliverPlan = new DispatchBillDeliverPlanViewModel();
            modelDeliverPlan.PlanId = long.Parse(id);
            model.DeliverPlans.Add(modelDeliverPlan);

            return View(model);
        }

        /// <summary>
        /// GET已配载其它计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="carNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchedOtherPlansGrid(string sidx, string sord, int page, int rows, string carNo)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillDeliverPlan> listPlan = dispatch.LoadDispatchBillDeliverPlansByCarNo(carNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listPlan == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listPlan.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "PlanNo") + " " + (sord ?? "ASC");
            var data = listPlan.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              p.PlanNo, 
                              p.CustomerName,
                              p.ShipmentNo,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.ReceiverCity,
                              p.PlanType,
                              p.Tunnages.ToString("#0.######"),
                              p.TransportPrice.ToString("#0.######"),
                              p.TransportCharges.ToString(),
                              p.Remark
                          }
                      }).ToArray(),
                userdata = new
                {
                    PlanNo = InnoSoft.LS.Resources.Labels.Total,
                    Tunnages = data.Sum(s => s.Tunnages),
                    TransportCharges = data.Sum(s => s.TransportCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET待调度其它计划货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchOtherPlanGoodsGrid(string sidx, string sord, int page, int rows, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchDeliverPlanAllGoods(long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.SpecModel,
                              g.Packages.ToString(),
                              g.Tunnages.ToString("#0.######"),
                              "0",
                              "0"
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    ActualPackages = 0,
                    ActualTunnages = 0
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        #endregion

        /// <summary>
        /// GET指定车号的待提交调度单
        /// </summary>
        /// <param name="strCarNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchBillByCarNo(string strCarNo)
        {
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            DispatchBill data = dispatch.LoadSubmitDispatchBillByCarNo(strCarNo, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    CarType = data.CarType,
                    DriverName = data.DriverName,
                    DriverLicenseNo = data.DriverLicenseNo,
                    DriverMobileTel = data.DriverMobileTel,
                    DriverHomeTel = data.DriverHomeTel
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// POST调度发货计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DispatchDeliverPlan(DispatchBillViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建调度计划数据
                int nTotalPackages = 0;
                decimal decTotalTunnages = 0;
                decimal decTotalPiles = 0;
                decimal decTotalTenThousands = 0;
                decimal decTotalTransportCharges = 0;

                List<DispatchBillDeliverPlan> listDeliverPlan = new List<DispatchBillDeliverPlan>();
                if (model.DeliverPlans != null)
                {
                    foreach (DispatchBillDeliverPlanViewModel m in model.DeliverPlans)
                    {
                        DispatchBillDeliverPlan deliverPlan = new DispatchBillDeliverPlan();
                        deliverPlan.DispatchBillId = model.Id;
                        deliverPlan.PlanId = m.PlanId;
                        deliverPlan.Packages = m.Packages;
                        deliverPlan.Tunnages = m.Tunnages;
                        deliverPlan.Piles = m.Piles;
                        deliverPlan.TenThousands = m.TenThousands;
                        deliverPlan.TransportChargeExpression = m.TransportChargeExpression;
                        deliverPlan.TransportPriceExpression = m.TransportPriceExpression;
                        deliverPlan.KM = m.KM;
                        deliverPlan.TransportPrice = m.ActualTransportPrice;
                        deliverPlan.TransportCharges = m.TransportCharges;
                        deliverPlan.Remark = m.Remark;
                        deliverPlan.ReceiveType = m.ReceiveType;
                        listDeliverPlan.Add(deliverPlan);

                        nTotalPackages += m.Packages;
                        decTotalTunnages += m.Tunnages;
                        decTotalPiles += m.Piles;
                        decTotalTenThousands += m.TenThousands;
                        decTotalTransportCharges += m.TransportCharges;
                    }
                }

                //创建调度货物数据
                List<DispatchBillGoods> listGoods = new List<DispatchBillGoods>();
                if (model.Goods != null)
                {
                    foreach (DispatchBillGoodsViewModel m in model.Goods)
                    {
                        DispatchBillGoods goods = new DispatchBillGoods();
                        goods.DispatchBillId = model.Id;
                        goods.PlanId = m.PlanId;
                        goods.GoodsId = m.GoodsId;
                        goods.GoodsNo = m.GoodsNo;
                        goods.GoodsName = m.GoodsName;
                        goods.Brand = m.Brand;
                        goods.SpecModel = m.SpecModel;
                        goods.GWeight = m.GWeight;
                        goods.Grade = m.Grade;
                        goods.PieceWeight = m.PieceWeight;
                        goods.Packing = m.Packing;
                        goods.BatchNo = m.BatchNo;
                        goods.Location = m.Location;
                        goods.Packages = m.Packages;
                        goods.Tunnages = m.Tunnages;
                        goods.Piles = m.Piles;
                        goods.TenThousands = m.TenThousands;
                        goods.ProductionDate = m.ProductionDate;
                        goods.EnterWarehouseBillId = m.EnterWarehouseBillId;
                        goods.EnterWarehouseBillNo = m.EnterWarehouseBillNo;
                        listGoods.Add(goods);
                    }
                }

                //创建调度单数据
                DispatchBill bill = new DispatchBill();
                bill.Id = model.Id;
                bill.CarNo = model.CarNo;
                bill.TrailerNo = model.TrailerNo;
                bill.CarType = model.CarType;
                bill.DriverName = model.DriverName;
                bill.DriverLicenseNo = model.DriverLicenseNo;
                bill.DriverMobileTel = model.DriverMobileTel;
                bill.DriverHomeTel = model.DriverHomeTel;
                bill.CarrierId = model.CarrierId;
                bill.CarrierName = model.CarrierName;
                bill.CarryingCapacity = model.CarryingCapacity;
                bill.BusinessType = model.BusinessType;
                bill.PaymentType = model.PaymentType;
                bill.TotalPackages = nTotalPackages;
                bill.TotalTunnages = decTotalTunnages;
                bill.TotalPiles = decTotalPiles;
                bill.TotalTenThousands = decTotalTenThousands;
                bill.TotalTransportCharges = decTotalTransportCharges;
                bill.CreateTime = DateTime.Parse(model.CreateTime);

                //保存数据
                string strErrText;
                DispatchSystem dispatch = new DispatchSystem();
                if (dispatch.InsertDispatchBill(bill, listDeliverPlan, listGoods, LoginAccountId, LoginStaffName, out strErrText) > 0)
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

        #region 取消计划代码

        /// <summary>
        /// POST取消发货计划
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult CancelDeliverPlan(string id)
        {
            string strErrText;
            PlanSystem plan = new PlanSystem();
            if (plan.CancelDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 退回修改代码

        /// <summary>
        /// POST退回修改计划
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ReturnDeliverPlan(string id)
        {
            string strErrText;
            PlanSystem plan = new PlanSystem();
            if (plan.ReturnDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #endregion

        #region 提交调度单代码

        #region 待提交调度单代码

        /// <summary>
        /// GET提交调度单页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SubmitDispatchBills()
        {
            return View();
        }

        /// <summary>
        /// GET待提交调度单表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSubmitDispatchBillsGrid(string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBill> listDispatchBill = dispatch.LoadSubmitDispatchBills(LoginAccountId, LoginStaffName, out strErrText);
            if (listDispatchBill == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listDispatchBill.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "DispatchBillNo") + " " + (sord ?? "ASC");
            var data = listDispatchBill.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              b.DispatchBillNo,
                              b.CarNo,
                              b.TrailerNo,
                              b.CarType,
                              b.DriverName,
                              b.DriverMobileTel,
                              b.CarryingCapacity.ToString(),
                              b.TotalTunnages.ToString("#0.######"),
                              b.TotalPiles.ToString("#0.######"),
                              b.TotalTransportCharges.ToString()
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET调度单配载计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="dispatchBillId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchBillDeliverPlansGrid(string sidx, string sord, int page, int rows, string dispatchBillId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillDeliverPlan> listDeliverPlan = dispatch.LoadDispatchBillDeliverPlans(long.Parse(dispatchBillId), LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverPlan == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listDeliverPlan.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "PlanNo") + " " + (sord ?? "ASC");
            var data = listDeliverPlan.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              p.PlanId.ToString(),
                              p.PlanNo, 
                              p.CustomerName,
                              p.ShipmentNo,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.ReceiverCity,
                              p.PlanType,
                              p.ReceiveType,
                              p.KM.ToString(),
                              p.Tunnages.ToString("#0.######"),
                              p.Piles.ToString("#0.######"),
                              p.TransportPrice.ToString("#0.######"),
                              p.TransportCharges.ToString(),
                              p.Remark
                          }
                      }).ToArray(),
                userdata = new
                {
                    PlanNo = InnoSoft.LS.Resources.Labels.Total,
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TransportCharges = data.Sum(s => s.TransportCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET调度单配载货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="dispatchBillId"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchBillGoodsGrid(string sidx, string sord, int page, int rows, string dispatchBillId, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = null;
            if (long.Parse(planId) > 0)
            {
                listGoods = dispatch.LoadDispatchBillAllGoodsByPlanId(long.Parse(dispatchBillId), long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
            }
            else
            {
                listGoods = dispatch.LoadDispatchBillAllGoods(long.Parse(dispatchBillId), LoginAccountId, LoginStaffName, out strErrText);
            }
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.Brand,
                              g.SpecModel,
                              g.GWeight,
                              g.Grade,
                              g.BatchNo,
                              g.Packing,
                              g.Warehouse,
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

        #endregion

        #region 新增和修改调度单代码

        /// <summary>
        /// GET新增调度单页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewDispatchBill()
        {
            //创建Model
            DispatchBillViewModel model = new DispatchBillViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.DeliverPlans = new List<DispatchBillDeliverPlanViewModel>();
            DispatchBillDeliverPlanViewModel modelDeliverPlan = new DispatchBillDeliverPlanViewModel();
            model.DeliverPlans.Add(modelDeliverPlan);

            return View(model);
        }

        /// <summary>
        /// GET已配载计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="carNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchedDeliverPlansGrid(string sidx, string sord, int page, int rows, string carNo)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillDeliverPlan> listPlan = dispatch.LoadDispatchBillDeliverPlansByCarNo(carNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listPlan == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listPlan.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "PlanNo") + " " + (sord ?? "ASC");
            var data = listPlan.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              p.DispatchBillId.ToString(),
                              p.PlanId.ToString(),
                              p.PlanNo, 
                              p.CustomerName,
                              p.ShipmentNo,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.ReceiverCity,
                              p.ReceiveType,
                              p.KM.ToString(),
                              p.PlanType,
                              p.Tunnages.ToString("#0.######"),
                              p.Piles.ToString("#0.######"),
                              p.TransportPrice.ToString("#0.######"),
                              p.TransportCharges.ToString(),
                              p.Remark
                          }
                      }).ToArray(),
                userdata = new
                {
                    PlanNo = InnoSoft.LS.Resources.Labels.Total,
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TransportCharges = data.Sum(s => s.TransportCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET调度单货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="carNo"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchedGoodsGrid(string sidx, string sord, int page, int rows, string carNo, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = null;
            if (long.Parse(planId) > 0)
            {
                listGoods = dispatch.LoadDispatchBillAllGoodsByCarNoAndPlanId(carNo, long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
            }
            else
            {
                listGoods = dispatch.LoadDispatchBillAllGoodsByCarNo(carNo, LoginAccountId, LoginStaffName, out strErrText);
            }
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.Brand,
                              g.SpecModel,
                              g.GWeight,
                              g.Grade,
                              g.BatchNo,
                              g.Packing,
                              g.Warehouse,
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
        /// 读取指定车号的客户自提待调度计划个数
        /// </summary>
        /// <param name="strCarNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchDeliverPlansCountByCarNo(string strCarNo)
        {
            string strErrText;
            PlanSystem plan = new PlanSystem();
            List<DeliverPlan> listPlan = plan.LoadDispatchDeliverPlans(string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, strCarNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listPlan == null)
            {
                throw new Exception(strErrText);
            }

            return Json(listPlan.Count, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET已调度纸计划货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="dispatchBillId"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchedPaperPlanGoodsGrid(string sidx, string sord, int page, int rows, string dispatchBillId, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchedDeliverPlanAllGoods(long.Parse(dispatchBillId), long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.Brand,
                              g.SpecModel,
                              g.GWeight,
                              g.Grade,
                              g.BatchNo,
                              g.Packing,
                              g.Warehouse,
                              g.Location,
                              g.Packages.ToString(),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              g.ProductionDate,
                              g.EnterWarehouseBillId.ToString(),
                              g.EnterWarehouseBillNo,
                              g.ActualPackages.ToString(),
                              g.ActualTunnages.ToString("#0.######")
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    ActualPackages = data.Sum(s => s.ActualPackages),
                    ActualTunnages = data.Sum(s => s.ActualTunnages)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET已调度纸直发计划货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="dispatchBillId"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchedNotDeliverPaperPlanGoodsGrid(string sidx, string sord, int page, int rows, string dispatchBillId, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchedDeliverPlanAllGoods(long.Parse(dispatchBillId), long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.Brand,
                              g.SpecModel,
                              g.GWeight,
                              g.Grade,
                              g.BatchNo,
                              g.Packages.ToString(),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              g.Packing,
                              g.ActualPackages.ToString(),
                              g.ActualTunnages.ToString("#0.######")
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    ActualPackages = data.Sum(s => s.ActualPackages),
                    ActualTunnages = data.Sum(s => s.ActualTunnages)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET已调度罐计划货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="dispatchBillId"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchedCanPlanGoodsGrid(string sidx, string sord, int page, int rows, string dispatchBillId, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchedDeliverPlanAllGoods(long.Parse(dispatchBillId), long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.SpecModel,
                              g.BatchNo,
                              g.Warehouse,
                              g.Location,
                              g.Piles.ToString("#0.######"),
                              g.TenThousands.ToString("#0.######"),
                              g.ProductionDate,
                              g.EnterWarehouseBillId.ToString(),
                              g.EnterWarehouseBillNo,
                              g.ActualPiles.ToString("#0.######"),
                              g.ActualTenThousands.ToString("#0.######")
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands),
                    ActualPiles = data.Sum(s => s.ActualPiles),
                    ActualTenThousands = data.Sum(s => s.ActualTenThousands)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET已调度罐直发计划货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="dispatchBillId"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchedNotDeliverCanPlanGoodsGrid(string sidx, string sord, int page, int rows, string dispatchBillId, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchedDeliverPlanAllGoods(long.Parse(dispatchBillId), long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.SpecModel,
                              g.Piles.ToString("#0.######"),
                              g.TenThousands.ToString("#0.######"),
                              g.ActualPiles.ToString("#0.######"),
                              g.ActualTenThousands.ToString("#0.######")
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands),
                    ActualPiles = data.Sum(s => s.ActualPiles),
                    ActualTenThousands = data.Sum(s => s.ActualTenThousands)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET已调度方便面计划货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="dispatchBillId"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchedNoodlePlanGoodsGrid(string sidx, string sord, int page, int rows, string dispatchBillId, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchedDeliverPlanAllGoods(long.Parse(dispatchBillId), long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.SpecModel,
                              g.Packages.ToString(),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              g.ActualPackages.ToString(),
                              g.ActualTunnages.ToString("#0.######")
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    ActualPackages = data.Sum(s => s.ActualPackages),
                    ActualTunnages = data.Sum(s => s.ActualTunnages)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET已调度其它计划货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="dispatchBillId"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchedOtherPlanGoodsGrid(string sidx, string sord, int page, int rows, string dispatchBillId, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchedDeliverPlanAllGoods(long.Parse(dispatchBillId), long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
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

            //记录编号
            for (int i = 0; i < data.Count; i++)
            {
                data[i].Id = i + 1;
            }

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
                              g.GoodsId.ToString(), 
                              g.GoodsNo,
                              g.GoodsName,
                              g.SpecModel,
                              g.Packages.ToString(),
                              g.Tunnages.ToString("#0.######"),
                              g.ActualPackages.ToString(),
                              g.ActualTunnages.ToString("#0.######")
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    ActualPackages = data.Sum(s => s.ActualPackages),
                    ActualTunnages = data.Sum(s => s.ActualTunnages)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET调度单计划数据
        /// </summary>
        /// <param name="dispatchBillId"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDispatchBillDeliverPlan(string dispatchBillId, string planId)
        {
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            DispatchBillDeliverPlan data = dispatch.LoadDispatchBillDeliverPlan(long.Parse(dispatchBillId), long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    TransportChargeExpression = data.TransportChargeExpression,
                    TransportPriceExpression = data.TransportPriceExpression,
                    KM = data.KM,
                    TransportPrice = data.TransportPrice,
                    TransportCharges = data.TransportCharges,
                    Remark = data.Remark
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// POST修改调度计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyDispatchedPlan(DispatchBillViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建调度计划数据
                int nTotalPackages = 0;
                decimal decTotalTunnages = 0;
                decimal decTotalPiles = 0;
                decimal decTotalTenThousands = 0;
                decimal decTotalTransportCharges = 0;

                List<DispatchBillDeliverPlan> listDeliverPlan = new List<DispatchBillDeliverPlan>();
                if (model.DeliverPlans != null)
                {
                    foreach (DispatchBillDeliverPlanViewModel m in model.DeliverPlans)
                    {
                        DispatchBillDeliverPlan deliverPlan = new DispatchBillDeliverPlan();
                        deliverPlan.DispatchBillId = model.Id;
                        deliverPlan.PlanId = m.PlanId;
                        deliverPlan.Packages = m.Packages;
                        deliverPlan.Tunnages = m.Tunnages;
                        deliverPlan.Piles = m.Piles;
                        deliverPlan.TenThousands = m.TenThousands;
                        deliverPlan.TransportChargeExpression = m.TransportChargeExpression;
                        deliverPlan.TransportPriceExpression = m.TransportPriceExpression;
                        deliverPlan.KM = m.KM;
                        deliverPlan.TransportPrice = m.ActualTransportPrice;
                        deliverPlan.TransportCharges = m.TransportCharges;
                        deliverPlan.Remark = m.Remark;
                        listDeliverPlan.Add(deliverPlan);

                        nTotalPackages += m.Packages;
                        decTotalTunnages += m.Tunnages;
                        decTotalPiles += m.Piles;
                        decTotalTenThousands += m.TenThousands;
                        decTotalTransportCharges += m.TransportCharges;
                    }
                }

                //创建调度货物数据
                List<DispatchBillGoods> listGoods = new List<DispatchBillGoods>();
                if (model.Goods != null)
                {
                    foreach (DispatchBillGoodsViewModel m in model.Goods)
                    {
                        DispatchBillGoods goods = new DispatchBillGoods();
                        goods.DispatchBillId = model.Id;
                        goods.PlanId = m.PlanId;
                        goods.GoodsId = m.GoodsId;
                        goods.GoodsNo = m.GoodsNo;
                        goods.GoodsName = m.GoodsName;
                        goods.Brand = m.Brand;
                        goods.SpecModel = m.SpecModel;
                        goods.GWeight = m.GWeight;
                        goods.Grade = m.Grade;
                        goods.PieceWeight = m.PieceWeight;
                        goods.Packing = m.Packing;
                        goods.BatchNo = m.BatchNo;
                        goods.Location = m.Location;
                        goods.Packages = m.Packages;
                        goods.Tunnages = m.Tunnages;
                        goods.Piles = m.Piles;
                        goods.TenThousands = m.TenThousands;
                        goods.ProductionDate = m.ProductionDate;
                        goods.EnterWarehouseBillId = m.EnterWarehouseBillId;
                        goods.EnterWarehouseBillNo = m.EnterWarehouseBillNo;
                        listGoods.Add(goods);
                    }
                }

                //创建调度单数据
                DispatchBill bill = new DispatchBill();
                bill.Id = model.Id;
                bill.CarNo = model.CarNo;
                bill.TrailerNo = model.TrailerNo;
                bill.CarType = model.CarType;
                bill.DriverName = model.DriverName;
                bill.DriverLicenseNo = model.DriverLicenseNo;
                bill.DriverMobileTel = model.DriverMobileTel;
                bill.DriverHomeTel = model.DriverHomeTel;
                bill.CarrierId = model.CarrierId;
                bill.CarrierName = model.CarrierName;
                bill.CarryingCapacity = model.CarryingCapacity;
                bill.BusinessType = model.BusinessType;
                bill.PaymentType = model.PaymentType;
                bill.TotalPackages = nTotalPackages;
                bill.TotalTunnages = decTotalTunnages;
                bill.TotalPiles = decTotalPiles;
                bill.TotalTenThousands = decTotalTenThousands;
                bill.TotalTransportCharges = decTotalTransportCharges;
                bill.CreateTime = DateTime.Parse(model.CreateTime);

                //保存数据
                string strErrText;
                DispatchSystem dispatch = new DispatchSystem();
                if (dispatch.UpdateDispatchBill(bill, listDeliverPlan, listGoods, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改调度单页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyDispatchBill(string id)
        {
            string strErrText;

            //读取调度单数据
            DispatchSystem dispatch = new DispatchSystem();
            DispatchBill data = dispatch.LoadDispatchBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            DispatchBillViewModel model = new DispatchBillViewModel();
            model.CarNo = data.CarNo;
            model.TrailerNo = data.TrailerNo;
            model.CarType = data.CarType;
            model.DriverName = data.DriverName;
            model.DriverLicenseNo = data.DriverLicenseNo;
            model.DriverMobileTel = data.DriverMobileTel;
            model.DriverHomeTel = data.DriverHomeTel;
            model.CarrierId = data.CarrierId;
            model.CarrierName = data.CarrierName;
            model.CarryingCapacity = data.CarryingCapacity;
            model.BusinessType = data.BusinessType;
            model.PaymentType = data.PaymentType;
            model.CreateTime = data.CreateTime.ToString("yyyy-MM-dd");

            model.DeliverPlans = new List<DispatchBillDeliverPlanViewModel>();
            DispatchBillDeliverPlanViewModel modelDeliverPlan = new DispatchBillDeliverPlanViewModel();
            model.DeliverPlans.Add(modelDeliverPlan);

            return View(model);
        }

        /// <summary>
        /// POST修改调度单
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyDispatchBill(DispatchBillViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建调度单数据
                DispatchBill data = new DispatchBill();
                data.Id = model.Id;
                data.CarNo = model.CarNo;
                data.TrailerNo = model.TrailerNo;
                data.CarType = model.CarType;
                data.DriverName = model.DriverName;
                data.DriverLicenseNo = model.DriverLicenseNo;
                data.DriverMobileTel = model.DriverMobileTel;
                data.DriverHomeTel = model.DriverHomeTel;
                data.CarrierId = model.CarrierId;
                data.CarrierName = model.CarrierName;
                data.CarryingCapacity = model.CarryingCapacity;
                data.BusinessType = model.BusinessType;
                data.PaymentType = model.PaymentType;
                data.CreateTime = DateTime.Parse(model.CreateTime);

                List<DispatchBillDeliverPlan> listPlan = new List<DispatchBillDeliverPlan>();
                foreach (DispatchBillDeliverPlanViewModel m in model.DeliverPlans)
                {
                    DispatchBillDeliverPlan p = new DispatchBillDeliverPlan();
                    p.PlanId = m.PlanId;
                    p.ReceiveType = m.ReceiveType;
                    listPlan.Add(p);
                }

                //保存数据
                string strErrText;
                DispatchSystem dispatch = new DispatchSystem();
                if (dispatch.UpdateDispatchBill(data, listPlan, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除调度计划
        /// </summary>
        /// <param name="dispatchBillId"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteDispatchedPlan(string dispatchBillId, string planId)
        {
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            if (dispatch.DeleteDispatchedPlan(long.Parse(dispatchBillId), long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 删除调度单代码

        /// <summary>
        /// POST删除调度单
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteDispatchBill(string id)
        {
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            if (dispatch.DeleteDispatchBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 提交调度单代码

        /// <summary>
        /// GET提交调度单页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult SubmitDispatchBill(string id)
        {
            string strErrText;

            //读取调度单数据
            DispatchSystem dispatch = new DispatchSystem();
            DispatchBill data = dispatch.LoadDispatchBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            DispatchBillViewModel model = new DispatchBillViewModel();
            model.Id = data.Id;
            model.CarNo = data.CarNo;
            model.TrailerNo = data.TrailerNo;
            model.DriverName = data.DriverName;
            model.DriverLicenseNo = data.DriverLicenseNo;
            model.DriverMobileTel = data.DriverMobileTel;
            model.DriverHomeTel = data.DriverHomeTel;
            model.CarrierId = data.CarrierId;
            model.CarrierName = data.CarrierName;
            model.CarryingCapacity = data.CarryingCapacity;
            model.BusinessType = data.BusinessType;
            model.PaymentType = data.PaymentType;
            model.CreateTime = data.CreateTime.ToString("yyyy-MM-dd");

            return View(model);
        }

        /// <summary>
        /// POST提交调度单
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult SubmitDispatchBill(DispatchBillViewModel model)
        {
            string strMessage;
            DispatchSystem dispatch = new DispatchSystem();
            bool bSuccess = dispatch.SubmitDispatchBill(model.Id, LoginAccountId, LoginStaffName, out strMessage);

            var ret = new
            {
                Success = bSuccess,
                Message = strMessage
            };
            return Json(ret);
        }

        #endregion

        #endregion

        #region 取消调度单

        /// <summary>
        /// POST取消调度单
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult CancelDispatchBill(string id)
        {
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            if (dispatch.CancelDispatchBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 合并调度单

        /// <summary>
        /// 合并调度单
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public JsonResult MergeDispatchBills(string ids)
        {
            //保存数据
            string strMessage = string.Empty;
            bool bShipmentBillMerged = false;
            bool bDeliverBillMerged = false;

            DispatchSystem dispatch = new DispatchSystem();
            long nNewDispatchBillId = dispatch.MergeDispatchBills(ids, LoginAccountId, LoginStaffName, out bShipmentBillMerged, out bDeliverBillMerged, out strMessage);

            var ret = new
            {
                DispatchBillId = nNewDispatchBillId,
                ShipmentBillMerged = bShipmentBillMerged,
                DeliverBillMerged = bDeliverBillMerged,
                Message = strMessage
            };
            return Json(ret);
        }

        #endregion
    }
}
