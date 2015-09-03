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
    /// 计划管理控制器
    /// </summary>
    public class PlanController : BaseController
    {
        #region 新增计划代码

        /// <summary>
        /// GET新增纸发货计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewPaperPlan()
        {
            string strErrText;

            //创建空的Model
            PaperPlanViewModel model = new PaperPlanViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.Goods = new List<PaperPlanGoodsViewModel>();
            model.Goods.Add(new PaperPlanGoodsViewModel());

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

            return View(model);
        }

        /// <summary>
        /// GET寄库货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="customerId"></param>
        /// <param name="deliveryNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPaperPlanConsignedGoodsGrid(string sidx, string sord, int page, int rows, string customerId, string deliveryNo)
        {
            //读取寄库交货单库存数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<Stock> listStock = stock.LoadGoodsStocksByConditions(customerId, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, deliveryNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listStock == null)
            {
                throw new Exception(strErrText);
            }

            //读取寄库交货单未发货数据
            PlanSystem plan = new PlanSystem();
            List<DeliverPlanGoods> listDeliverPlanGoods = plan.LoadDeliverPlanGoodsBalancesByConditions(customerId, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, deliveryNo, LoginAccountId, LoginStaffName, out strErrText);
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
                        (dpg.Packages > 0 || dpg.Tunnages > 0))
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
                    }
                }
            }

            //检查已提交未发货剩余数字
            if (listDeliverPlanGoods.Sum(g => g.Packages) > 0 || listDeliverPlanGoods.Sum(g => g.Tunnages) > 0)
            {
                throw new Exception(InnoSoft.LS.Resources.Strings.SubmitedDeliverPlanGoodsNotCompleteSubtract);
            }

            //剔除结存件数为0的记录（2013.9.10修改，去掉件数为0的记录）
            //listStock = listStock.Where(s => s.Packages > 0 || s.Tunnages > 0).ToList();
            listStock = listStock.Where(s => s.Packages > 0 && s.Tunnages > 0).ToList();

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
                              s.Packages.ToString("#0"),
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

        /// <summary>
        /// GET选择纸发货计划货物库存表格数据
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
        public JsonResult LoadPaperPlanGoodsStockGrid(string sidx, string sord, int page, int rows, string customerId, string goodsId, string batchNo, string packing, string warehouse, string location, string productionDate, string enterWarehouseBillId, string consignedDeliveryNo)
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
                        (dpg.Packages > 0 || dpg.Tunnages > 0))
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
                    }
                }
            }

            //检查已提交未发货剩余数字
            if (listDeliverPlanGoods.Sum(g => g.Packages) > 0 || listDeliverPlanGoods.Sum(g => g.Tunnages) > 0)
            {
                throw new Exception(InnoSoft.LS.Resources.Strings.SubmitedDeliverPlanGoodsNotCompleteSubtract);
            }

            //剔除结存件数为0的记录(2013.9.10修改，去掉所有件数为0的记录)
            //listStock = listStock.Where(s => s.Packages > 0 || s.Tunnages > 0).ToList();
            listStock = listStock.Where(s => s.Packages > 0 && s.Tunnages > 0).ToList();

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

            var data = listStock.OrderBy(s => s.Warehouse).ThenBy(s => s.ProductionDate).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              s.Warehouse,
                              s.Location,
                              s.Packages.ToString(),
                              s.PieceWeight.ToString("#0.######"),
                              s.Tunnages.ToString("#0.######"),
                              s.ProductionDate,
                              s.EnterWarehouseBillId.ToString(),
                              s.EnterWarehouseBillNo,
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

        /// <summary>
        /// POST新增纸发货计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewPaperPlan(PaperPlanViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.ReceiveType == InnoSoft.LS.Resources.Options.PickUpSelf)
                {
                    //自提必须输入车号
                    if (model.CarNo == null || model.CarNo == string.Empty)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterCarrierInfoWhenPickUpSelf);
                    }
                    if (model.DriverName != null && model.DriverName != string.Empty)
                    {
                        if (model.DriverLicenseNo == null || model.DriverLicenseNo == string.Empty)
                        {
                            return Json(InnoSoft.LS.Resources.Strings.NotEnterDriverLicenseNo);
                        }
                        if (model.DriverMobileTel == null || model.DriverMobileTel == string.Empty)
                        {
                            return Json(InnoSoft.LS.Resources.Strings.NotEnterDriverMobileTel);
                        }
                    }
                }
                else
                {
                    if (model.DeliveryNo == null || model.DeliveryNo == string.Empty)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterDeliveryNo);
                    }
                }
                if (model.Goods == null || model.Goods.Count == 0)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterGoods);
                }

                //创建数据
                DeliverPlan data = new DeliverPlan();
                data.PlanType = InnoSoft.LS.Resources.Options.PaperPlan;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.ShipmentNo = model.ShipmentNo;
                data.DeliveryNo = model.DeliveryNo;
                data.DeliverType = model.DeliverType;
                data.ReceiverName = model.ReceiverName;
                data.ReceiverCountry = model.ReceiverCountry;
                data.ReceiverProvince = model.ReceiverProvince;
                data.ReceiverCity = model.ReceiverCity;
                data.ReceiverAddress = model.ReceiverAddress;
                data.ReceiverContact = model.ReceiverContact;
                data.ReceiverContactTel = model.ReceiverContactTel;
                data.OrderNo = model.OrderNo;
                data.ReceiveType = model.ReceiveType;
                data.CarNo = model.CarNo;
                data.TrailerNo = model.TrailerNo;
                data.DriverName = model.DriverName;
                data.DriverLicenseNo = model.DriverLicenseNo;
                data.DriverMobileTel = model.DriverMobileTel;
                data.DriverHomeTel = model.DriverHomeTel;
                data.Warehouse = model.Warehouse;
                data.ArrivalTime = model.ArrivalTime;
                data.PayerId = model.PayerId;
                data.PayerName = model.PayerName;
                data.IsConsigning = model.IsConsigning;
                data.ConsignedDeliveryNo = model.ConsignedDeliveryNo;
                data.IsInstalment = model.IsInstalment;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.Remark = model.Remark;
                data.CreateTime = DateTime.Parse(model.CreateTime);

                List<DeliverPlanGoods> listGoods = new List<DeliverPlanGoods>();
                if (model.Goods != null)
                {
                    foreach (PaperPlanGoodsViewModel m in model.Goods)
                    {
                        DeliverPlanGoods g = new DeliverPlanGoods();
                        g.GoodsId = m.GoodsId;
                        g.BatchNo = m.BatchNo;
                        g.Packing = m.Packing;
                        g.Location = m.Location;
                        g.Packages = m.Packages;
                        g.PieceWeight = m.PieceWeight;
                        g.Tunnages = m.Tunnages;
                        g.Piles = 0;
                        g.TenThousands = 0;
                        g.ProductionDate = m.ProductionDate;
                        g.EnterWarehouseBillId = m.EnterWarehouseBillId;
                        listGoods.Add(g);
                    }
                }

                //保存数据
                string strErrText;
                PlanSystem plan = new PlanSystem();
                if (plan.InsertDeliverPlan(data, listGoods, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// GET客户新增纸发货计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult CustomerNewPaperPlan()
        {
            string strErrText;

            //创建空的Model
            PaperPlanViewModel model = new PaperPlanViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.Goods = new List<PaperPlanGoodsViewModel>();
            model.Goods.Add(new PaperPlanGoodsViewModel());

            //设置客户信息和付款单位信息
            if (LoginAccountType == InnoSoft.LS.Resources.Options.Customer)
            {
                model.CustomerId = LoginOrganId;
                model.CustomerName = LoginOrganName;
                model.PayerId = model.CustomerId;
                model.PayerName = model.CustomerName;

                //读取客户所属办事处数据
                CustomerSystem customer = new CustomerSystem();
                Customer dataCustomer = customer.LoadCustomer(model.CustomerId, LoginAccountId, LoginStaffName, out strErrText);
                if (dataCustomer == null)
                {
                    throw new Exception(strErrText);
                }
                OrganizationSystem organ = new OrganizationSystem();
                Organization dataOrgan = organ.LoadOrganization(dataCustomer.OwnOrganId, LoginAccountId, LoginStaffName, out strErrText);
                if (dataOrgan == null)
                {
                    throw new Exception(strErrText);
                }
                model.StartCountry = dataOrgan.CountryName;
                model.StartProvince = dataOrgan.ProvinceName;
                model.StartCity = dataOrgan.CityName;
            }

            //生成讫点国家下拉列表项
            DDSystem dd = new DDSystem();
            List<Country> listDestCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listDestCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListDestCountry = new List<SelectListItem>();
            selectListDestCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCountry.AddRange(from c in listDestCountry
                                           select new SelectListItem
                                           {
                                               Text = c.Name,
                                               Value = c.Name
                                           });
            ViewData["DestCountrys"] = new SelectList(selectListDestCountry, "Value", "Text");

            //生成空的讫点省份下拉列表项
            List<Province> listDestProvince = new List<Province>();
            List<SelectListItem> selectListDestProvince = new List<SelectListItem>();
            selectListDestProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestProvince.AddRange(from s in listDestProvince
                                            select new SelectListItem
                                            {
                                                Text = s.Name,
                                                Value = s.Name
                                            });
            ViewData["DestProvinces"] = new SelectList(selectListDestProvince, "Value", "Text");

            //生成空的讫点城市下拉列表项
            List<City> listDestCity = new List<City>();
            List<SelectListItem> selectListDestCity = new List<SelectListItem>();
            selectListDestCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCity.AddRange(from ci in listDestCity
                                        select new SelectListItem
                                        {
                                            Text = ci.Name,
                                            Value = ci.Name
                                        });
            ViewData["DestCitys"] = new SelectList(selectListDestCity, "Value", "Text");

            //生成起点国家下拉列表项
            List<Country> listStartCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listStartCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStartCountry = new List<SelectListItem>();
            selectListStartCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCountry.AddRange(from c in listStartCountry
                                            select new SelectListItem
                                            {
                                                Text = c.Name,
                                                Value = c.Name
                                            });
            ViewData["StartCountrys"] = new SelectList(selectListStartCountry, "Value", "Text", model.StartCountry);

            //生成起点省份下拉列表项
            List<Province> listStartProvince = null;
            if (!string.IsNullOrEmpty(model.StartCountry))
            {
                listStartProvince = dd.LoadProvincesByCountry(model.StartCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartProvince = new List<Province>();
            }
            List<SelectListItem> selectListStartProvince = new List<SelectListItem>();
            selectListStartProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartProvince.AddRange(from p in listStartProvince
                                             select new SelectListItem
                                             {
                                                 Text = p.Name,
                                                 Value = p.Name
                                             });
            ViewData["StartProvinces"] = new SelectList(selectListStartProvince, "Value", "Text", model.StartProvince);

            //生成起点城市下拉列表项
            List<City> listStartCity = null;
            if (!string.IsNullOrEmpty(model.StartProvince))
            {
                listStartCity = dd.LoadCitysByProvince(model.StartCountry, model.StartProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartCity = new List<City>();
            }
            List<SelectListItem> selectListStartCity = new List<SelectListItem>();
            selectListStartCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCity.AddRange(from ci in listStartCity
                                         select new SelectListItem
                                         {
                                             Text = ci.Name,
                                             Value = ci.Name
                                         });
            ViewData["StartCitys"] = new SelectList(selectListStartCity, "Value", "Text", model.StartCity);

            return View(model);
        }

        /// <summary>
        /// GET新增纸直发货计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewNotDeliverPaperPlan()
        {
            string strErrText;

            //创建空的Model
            PaperPlanViewModel model = new PaperPlanViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.Goods = new List<PaperPlanGoodsViewModel>();
            model.Goods.Add(new PaperPlanGoodsViewModel());

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

            return View(model);
        }

        /// <summary>
        /// POST新增纸直发货计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewNotDeliverPaperPlan(PaperPlanViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.DeliveryNo == null || model.DeliveryNo == string.Empty)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterDeliveryNo);
                }
                if (model.Goods == null || model.Goods.Count == 0)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterGoods);
                }

                //创建数据
                DeliverPlan data = new DeliverPlan();
                data.PlanType = InnoSoft.LS.Resources.Options.NotDeliverPaperPlan;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.ShipmentNo = model.ShipmentNo;
                data.DeliveryNo = model.DeliveryNo;
                data.DeliverType = model.DeliverType;
                data.ReceiverName = model.ReceiverName;
                data.ReceiverCountry = model.ReceiverCountry;
                data.ReceiverProvince = model.ReceiverProvince;
                data.ReceiverCity = model.ReceiverCity;
                data.ReceiverAddress = model.ReceiverAddress;
                data.ReceiverContact = model.ReceiverContact;
                data.ReceiverContactTel = model.ReceiverContactTel;
                data.ReceiveType = model.ReceiveType;
                data.CarNo = model.CarNo;
                data.TrailerNo = model.TrailerNo;
                data.DriverName = model.DriverName;
                data.DriverLicenseNo = model.DriverLicenseNo;
                data.DriverMobileTel = model.DriverMobileTel;
                data.DriverHomeTel = model.DriverHomeTel;
                data.Warehouse = model.Warehouse;
                data.ArrivalTime = model.ArrivalTime;
                data.PayerId = model.PayerId;
                data.PayerName = model.PayerName;
                data.IsConsigning = model.IsConsigning;
                data.ConsignedDeliveryNo = model.ConsignedDeliveryNo;
                data.IsInstalment = model.IsInstalment;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.Remark = model.Remark;
                data.CreateTime = DateTime.Parse(model.CreateTime);

                List<DeliverPlanGoods> listGoods = new List<DeliverPlanGoods>();
                if (model.Goods != null)
                {
                    foreach (PaperPlanGoodsViewModel m in model.Goods)
                    {
                        DeliverPlanGoods g = new DeliverPlanGoods();
                        g.GoodsId = m.GoodsId;
                        g.BatchNo = m.BatchNo;
                        g.Packing = m.Packing;
                        g.Location = m.Location;
                        g.Packages = m.Packages;
                        g.PieceWeight = m.PieceWeight;
                        g.Tunnages = m.Tunnages;
                        g.Piles = 0;
                        g.TenThousands = 0;
                        g.ProductionDate = m.ProductionDate;
                        g.EnterWarehouseBillId = m.EnterWarehouseBillId;
                        listGoods.Add(g);
                    }
                }

                //保存数据
                string strErrText;
                PlanSystem plan = new PlanSystem();
                if (plan.InsertDeliverPlan(data, listGoods, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// GET客户新增纸直发货计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult CustomerNewNotDeliverPaperPlan()
        {
            string strErrText;

            //创建空的Model
            PaperPlanViewModel model = new PaperPlanViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.Goods = new List<PaperPlanGoodsViewModel>();
            model.Goods.Add(new PaperPlanGoodsViewModel());

            //设置客户信息和付款单位信息
            if (LoginAccountType == InnoSoft.LS.Resources.Options.Customer)
            {
                model.CustomerId = LoginOrganId;
                model.CustomerName = LoginOrganName;
                model.PayerId = model.CustomerId;
                model.PayerName = model.CustomerName;

                //读取客户所属办事处数据
                CustomerSystem customer = new CustomerSystem();
                Customer dataCustomer = customer.LoadCustomer(model.CustomerId, LoginAccountId, LoginStaffName, out strErrText);
                if (dataCustomer == null)
                {
                    throw new Exception(strErrText);
                }
                OrganizationSystem organ = new OrganizationSystem();
                Organization dataOrgan = organ.LoadOrganization(dataCustomer.OwnOrganId, LoginAccountId, LoginStaffName, out strErrText);
                if (dataOrgan == null)
                {
                    throw new Exception(strErrText);
                }
                model.StartCountry = dataOrgan.CountryName;
                model.StartProvince = dataOrgan.ProvinceName;
                model.StartCity = dataOrgan.CityName;
            }

            //生成讫点国家下拉列表项
            DDSystem dd = new DDSystem();
            List<Country> listDestCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listDestCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListDestCountry = new List<SelectListItem>();
            selectListDestCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCountry.AddRange(from c in listDestCountry
                                           select new SelectListItem
                                           {
                                               Text = c.Name,
                                               Value = c.Name
                                           });
            ViewData["DestCountrys"] = new SelectList(selectListDestCountry, "Value", "Text");

            //生成空的讫点省份下拉列表项
            List<Province> listDestProvince = new List<Province>();
            List<SelectListItem> selectListDestProvince = new List<SelectListItem>();
            selectListDestProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestProvince.AddRange(from s in listDestProvince
                                            select new SelectListItem
                                            {
                                                Text = s.Name,
                                                Value = s.Name
                                            });
            ViewData["DestProvinces"] = new SelectList(selectListDestProvince, "Value", "Text");

            //生成空的讫点城市下拉列表项
            List<City> listDestCity = new List<City>();
            List<SelectListItem> selectListDestCity = new List<SelectListItem>();
            selectListDestCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCity.AddRange(from ci in listDestCity
                                        select new SelectListItem
                                        {
                                            Text = ci.Name,
                                            Value = ci.Name
                                        });
            ViewData["DestCitys"] = new SelectList(selectListDestCity, "Value", "Text");

            //生成起点国家下拉列表项
            List<Country> listStartCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listStartCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStartCountry = new List<SelectListItem>();
            selectListStartCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCountry.AddRange(from c in listStartCountry
                                            select new SelectListItem
                                            {
                                                Text = c.Name,
                                                Value = c.Name
                                            });
            ViewData["StartCountrys"] = new SelectList(selectListStartCountry, "Value", "Text", model.StartCountry);

            //生成起点省份下拉列表项
            List<Province> listStartProvince = null;
            if (!string.IsNullOrEmpty(model.StartCountry))
            {
                listStartProvince = dd.LoadProvincesByCountry(model.StartCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartProvince = new List<Province>();
            }
            List<SelectListItem> selectListStartProvince = new List<SelectListItem>();
            selectListStartProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartProvince.AddRange(from p in listStartProvince
                                             select new SelectListItem
                                             {
                                                 Text = p.Name,
                                                 Value = p.Name
                                             });
            ViewData["StartProvinces"] = new SelectList(selectListStartProvince, "Value", "Text", model.StartProvince);

            //生成起点城市下拉列表项
            List<City> listStartCity = null;
            if (!string.IsNullOrEmpty(model.StartProvince))
            {
                listStartCity = dd.LoadCitysByProvince(model.StartCountry, model.StartProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartCity = new List<City>();
            }
            List<SelectListItem> selectListStartCity = new List<SelectListItem>();
            selectListStartCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCity.AddRange(from ci in listStartCity
                                         select new SelectListItem
                                         {
                                             Text = ci.Name,
                                             Value = ci.Name
                                         });
            ViewData["StartCitys"] = new SelectList(selectListStartCity, "Value", "Text", model.StartCity);

            return View(model);
        }

        /// <summary>
        /// GET新增罐发货计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewCanPlan()
        {
            string strErrText;

            //创建空的Model
            CanPlanViewModel model = new CanPlanViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.Goods = new List<CanPlanGoodsViewModel>();
            model.Goods.Add(new CanPlanGoodsViewModel());

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

            return View(model);
        }

        /// <summary>
        /// GET选择罐发货计划货物库存表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="customerId"></param>
        /// <param name="goodsId"></param>
        /// <param name="batchNo"></param>
        /// <param name="warehouse"></param>
        /// <param name="location"></param>
        /// <param name="productionDate"></param>
        /// <param name="enterWarehouseBillId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCanPlanGoodsStockGrid(string sidx, string sord, int page, int rows, string customerId, string goodsId, string batchNo, string warehouse, string location, string productionDate, string enterWarehouseBillId)
        {
            //读取库存数据
            string strErrText;
            StockSystem stock = new StockSystem();
            List<Stock> listStock = stock.LoadGoodsStocksByConditions(customerId, goodsId, batchNo, string.Empty, warehouse, location, productionDate, enterWarehouseBillId, string.Empty, LoginAccountId, LoginStaffName, out strErrText);
            if (listStock == null)
            {
                throw new Exception(strErrText);
            }

            //读取已提交未发货数据
            PlanSystem plan = new PlanSystem();
            List<DeliverPlanGoods> listDeliverPlanGoods = plan.LoadDeliverPlanGoodsBalancesByConditions(customerId, goodsId, batchNo, string.Empty, warehouse, location, productionDate, enterWarehouseBillId, string.Empty, LoginAccountId, LoginStaffName, out strErrText);
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
                        dpg.Warehouse == s.Warehouse &&
                        dpg.Location == s.Location &&
                        dpg.ProductionDate == s.ProductionDate &&
                        dpg.EnterWarehouseBillId == s.EnterWarehouseBillId &&
                        (dpg.Piles > 0 || dpg.TenThousands > 0))
                    {
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
            if (listDeliverPlanGoods.Sum(g => g.Piles) > 0 || listDeliverPlanGoods.Sum(g => g.TenThousands) > 0)
            {
                throw new Exception(InnoSoft.LS.Resources.Strings.SubmitedDeliverPlanGoodsNotCompleteSubtract);
            }

            //剔除结存件数为0的记录
            listStock = listStock.Where(s => s.Piles > 0 || s.TenThousands > 0).ToList();

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

            var data = listStock.OrderBy(s => s.Warehouse).ThenBy(s => s.ProductionDate).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              s.SpecModel,
                              s.BatchNo,
                              s.Warehouse,
                              s.Location,
                              s.Piles.ToString("#0.######"),
                              s.TenThousands.ToString("#0.######"),
                              s.ProductionDate,
                              s.EnterWarehouseBillId.ToString(),
                              s.EnterWarehouseBillNo,
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

        /// <summary>
        /// POST新增罐发货计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewCanPlan(CanPlanViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.ReceiveType == InnoSoft.LS.Resources.Options.PickUpSelf)
                {
                    //自提必须输入车号
                    if (model.CarNo == null || model.CarNo == string.Empty)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterCarrierInfoWhenPickUpSelf);
                    }
                    if (model.DriverName != null && model.DriverName != string.Empty)
                    {
                        if (model.DriverLicenseNo == null || model.DriverLicenseNo == string.Empty)
                        {
                            return Json(InnoSoft.LS.Resources.Strings.NotEnterDriverLicenseNo);
                        }
                        if (model.DriverMobileTel == null || model.DriverMobileTel == string.Empty)
                        {
                            return Json(InnoSoft.LS.Resources.Strings.NotEnterDriverMobileTel);
                        }
                    }
                }
                else
                {
                    if (model.DeliveryNo == null || model.DeliveryNo == string.Empty)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterDeliveryNo);
                    }
                }
                if (model.Goods == null || model.Goods.Count == 0)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterGoods);
                }

                //创建数据
                DeliverPlan data = new DeliverPlan();
                data.PlanType = InnoSoft.LS.Resources.Options.CanPlan;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.DeliveryNo = model.DeliveryNo;
                data.DeliverType = InnoSoft.LS.Resources.Options.DeliverGoods;
                data.ReceiverName = model.ReceiverName;
                data.ReceiverCountry = model.ReceiverCountry;
                data.ReceiverProvince = model.ReceiverProvince;
                data.ReceiverCity = model.ReceiverCity;
                data.ReceiverAddress = model.ReceiverAddress;
                data.ReceiverContact = model.ReceiverContact;
                data.ReceiverContactTel = model.ReceiverContactTel;
                data.ReceiveType = model.ReceiveType;
                data.CarNo = model.CarNo;
                data.TrailerNo = model.TrailerNo;
                data.DriverName = model.DriverName;
                data.DriverLicenseNo = model.DriverLicenseNo;
                data.DriverMobileTel = model.DriverMobileTel;
                data.DriverHomeTel = model.DriverHomeTel;
                data.Warehouse = model.Warehouse;
                data.ArrivalTime = model.ArrivalTime;
                data.PayerId = model.PayerId;
                data.PayerName = model.PayerName;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.Remark = model.Remark;
                data.CreateTime = DateTime.Parse(model.CreateTime);

                List<DeliverPlanGoods> listGoods = new List<DeliverPlanGoods>();
                if (model.Goods != null)
                {
                    foreach (CanPlanGoodsViewModel m in model.Goods)
                    {
                        DeliverPlanGoods g = new DeliverPlanGoods();
                        g.GoodsId = m.GoodsId;
                        g.GoodsNo = m.GoodsNo;
                        g.GoodsName = m.GoodsName;
                        g.SpecModel = m.SpecModel;
                        g.BatchNo = m.BatchNo;
                        g.Warehouse = m.Warehouse;
                        g.Location = m.Location;
                        g.Piles = m.Piles;
                        g.TenThousands = m.TenThousands;
                        g.ProductionDate = m.ProductionDate;
                        g.EnterWarehouseBillId = m.EnterWarehouseBillId;
                        g.EnterWarehouseBillNo = m.EnterWarehouseBillNo;
                        listGoods.Add(g);
                    }
                }

                //保存数据
                string strErrText;
                PlanSystem plan = new PlanSystem();
                if (plan.InsertDeliverPlan(data, listGoods, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// GET新增罐直发货计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewNotDeliverCanPlan()
        {
            string strErrText;

            //创建空的Model
            CanPlanViewModel model = new CanPlanViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.Goods = new List<CanPlanGoodsViewModel>();
            model.Goods.Add(new CanPlanGoodsViewModel());

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

            return View(model);
        }

        /// <summary>
        /// POST新增罐直发货计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewNotDeliverCanPlan(CanPlanViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.Goods == null || model.Goods.Count == 0)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterGoods);
                }

                //创建数据
                DeliverPlan data = new DeliverPlan();
                data.PlanType = InnoSoft.LS.Resources.Options.NotDeliverCanPlan;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.DeliveryNo = model.DeliveryNo;
                data.DeliverType = InnoSoft.LS.Resources.Options.DeliverGoods;
                data.ReceiverName = model.ReceiverName;
                data.ReceiverCountry = model.ReceiverCountry;
                data.ReceiverProvince = model.ReceiverProvince;
                data.ReceiverCity = model.ReceiverCity;
                data.ReceiverAddress = model.ReceiverAddress;
                data.ReceiverContact = model.ReceiverContact;
                data.ReceiverContactTel = model.ReceiverContactTel;
                data.ReceiveType = model.ReceiveType;
                data.CarNo = model.CarNo;
                data.TrailerNo = model.TrailerNo;
                data.DriverName = model.DriverName;
                data.DriverLicenseNo = model.DriverLicenseNo;
                data.DriverMobileTel = model.DriverMobileTel;
                data.DriverHomeTel = model.DriverHomeTel;
                data.Warehouse = model.Warehouse;
                data.ArrivalTime = model.ArrivalTime;
                data.PayerId = model.PayerId;
                data.PayerName = model.PayerName;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.Remark = model.Remark;
                data.CreateTime = DateTime.Parse(model.CreateTime);

                List<DeliverPlanGoods> listGoods = new List<DeliverPlanGoods>();
                if (model.Goods != null)
                {
                    foreach (CanPlanGoodsViewModel m in model.Goods)
                    {
                        DeliverPlanGoods g = new DeliverPlanGoods();
                        g.GoodsId = m.GoodsId;
                        g.GoodsNo = m.GoodsNo;
                        g.GoodsName = m.GoodsName;
                        g.SpecModel = m.SpecModel;
                        g.BatchNo = m.BatchNo;
                        g.Warehouse = m.Warehouse;
                        g.Location = m.Location;
                        g.Piles = m.Piles;
                        g.TenThousands = m.TenThousands;
                        g.ProductionDate = m.ProductionDate;
                        g.EnterWarehouseBillId = m.EnterWarehouseBillId;
                        g.EnterWarehouseBillNo = m.EnterWarehouseBillNo;
                        listGoods.Add(g);
                    }
                }

                //保存数据
                string strErrText;
                PlanSystem plan = new PlanSystem();
                if (plan.InsertDeliverPlan(data, listGoods, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// GET新增方便面发货计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewNoodlePlan()
        {
            string strErrText;

            //创建空的Model
            NoodlePlanViewModel model = new NoodlePlanViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.Goods = new List<NoodlePlanGoodsViewModel>();
            model.Goods.Add(new NoodlePlanGoodsViewModel());

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

            return View(model);
        }

        /// <summary>
        /// POST新增方便面发货计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewNoodlePlan(NoodlePlanViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.Goods == null || model.Goods.Count == 0)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterGoods);
                }

                //创建数据
                DeliverPlan data = new DeliverPlan();
                data.PlanType = InnoSoft.LS.Resources.Options.NoodlePlan;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.DeliveryNo = model.DeliveryNo;
                data.DeliverType = InnoSoft.LS.Resources.Options.DeliverGoods;
                data.ReceiverName = model.ReceiverName;
                data.ReceiverCountry = model.ReceiverCountry;
                data.ReceiverProvince = model.ReceiverProvince;
                data.ReceiverCity = model.ReceiverCity;
                data.ReceiverAddress = model.ReceiverAddress;
                data.ReceiverContact = model.ReceiverContact;
                data.ReceiverContactTel = model.ReceiverContactTel;
                data.ReceiveType = InnoSoft.LS.Resources.Options.PickUpDelivery;
                data.Warehouse = model.Warehouse;
                data.ArrivalTime = model.ArrivalTime;
                data.PayerId = model.CustomerId;
                data.PayerName = model.CustomerName;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.Remark = model.Remark;
                data.CreateTime = DateTime.Parse(model.CreateTime);

                List<DeliverPlanGoods> listGoods = new List<DeliverPlanGoods>();
                if (model.Goods != null)
                {
                    foreach (NoodlePlanGoodsViewModel m in model.Goods)
                    {
                        DeliverPlanGoods g = new DeliverPlanGoods();
                        g.GoodsId = m.GoodsId;
                        g.Packages = m.Packages;
                        g.PieceWeight = m.PieceWeight;
                        g.Tunnages = m.Tunnages;
                        g.Piles = 0;
                        listGoods.Add(g);
                    }
                }

                //保存数据
                string strErrText;
                PlanSystem plan = new PlanSystem();
                if (plan.InsertDeliverPlan(data, listGoods, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// GET新增其它发货计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewOtherPlan()
        {
            string strErrText;

            //创建空的Model
            OtherPlanViewModel model = new OtherPlanViewModel();
            model.CreateTime = DateTime.Now.ToString("yyyy-MM-dd");

            model.Goods = new List<OtherPlanGoodsViewModel>();
            model.Goods.Add(new OtherPlanGoodsViewModel());

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

            return View(model);
        }

        /// <summary>
        /// POST新增其它发货计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewOtherPlan(OtherPlanViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.Goods == null || model.Goods.Count == 0)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterGoods);
                }

                //创建数据
                DeliverPlan data = new DeliverPlan();
                data.PlanType = InnoSoft.LS.Resources.Options.OtherPlan;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.DeliveryNo = model.DeliveryNo;
                data.DeliverType = InnoSoft.LS.Resources.Options.DeliverGoods;
                data.ReceiverName = model.ReceiverName;
                data.ReceiverCountry = model.ReceiverCountry;
                data.ReceiverProvince = model.ReceiverProvince;
                data.ReceiverCity = model.ReceiverCity;
                data.ReceiverAddress = model.ReceiverAddress;
                data.ReceiverContact = model.ReceiverContact;
                data.ReceiverContactTel = model.ReceiverContactTel;
                data.ReceiveType = InnoSoft.LS.Resources.Options.PickUpDelivery;
                data.Warehouse = model.Warehouse;
                data.ArrivalTime = model.ArrivalTime;
                data.PayerId = model.CustomerId;
                data.PayerName = model.CustomerName;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.Remark = model.Remark;
                data.CreateTime = DateTime.Parse(model.CreateTime);

                List<DeliverPlanGoods> listGoods = new List<DeliverPlanGoods>();
                if (model.Goods != null)
                {
                    foreach (OtherPlanGoodsViewModel m in model.Goods)
                    {
                        DeliverPlanGoods g = new DeliverPlanGoods();
                        g.GoodsId = m.GoodsId;
                        g.Packages = m.Packages;
                        g.Tunnages = m.Tunnages;
                        g.Piles = 0;
                        listGoods.Add(g);
                    }
                }

                //保存数据
                string strErrText;
                PlanSystem plan = new PlanSystem();
                if (plan.InsertDeliverPlan(data, listGoods, LoginAccountId, LoginStaffName, out strErrText) > 0)
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

        #region 提交计划代码

        /// <summary>
        /// GET提交发货计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SubmitDeliverPlans()
        {
            return View();
        }

        /// <summary>
        /// GET提交计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSubmitDeliverPlansGrid(string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            PlanSystem plan = new PlanSystem();
            List<DeliverPlan> listPlan = plan.LoadSubmitDeliverPlans(LoginAccountId, LoginStaffName, out strErrText);
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
                              p.ReceiverCountry + p.ReceiverProvince + p.ReceiverCity + p.ReceiverAddress,
                              p.PlanType,
                              p.LastIsAgreed,
                              p.LastApproveComment,
                              p.LastApproverName
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET修改纸发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyPaperPlan(string id)
        {
            string strErrText;

            //读取计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan data = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            PaperPlanViewModel model = new PaperPlanViewModel();
            model.Id = data.Id;
            model.CustomerId = data.CustomerId;
            model.CustomerName = data.CustomerName;
            model.ShipmentNo = data.ShipmentNo;
            model.DeliveryNo = data.DeliveryNo;
            model.DeliverType = data.DeliverType;
            model.ReceiverName = data.ReceiverName;
            model.ReceiverCountry = data.ReceiverCountry;
            model.ReceiverProvince = data.ReceiverProvince;
            model.ReceiverCity = data.ReceiverCity;
            model.ReceiverAddress = data.ReceiverAddress;
            model.ReceiverContact = data.ReceiverContact;
            model.ReceiverContactTel = data.ReceiverContactTel;
            model.OrderNo = data.OrderNo;
            model.ReceiveType = data.ReceiveType;
            model.CarNo = data.CarNo;
            model.TrailerNo = data.TrailerNo;
            model.DriverName = data.DriverName;
            model.DriverLicenseNo = data.DriverLicenseNo;
            model.DriverMobileTel = data.DriverMobileTel;
            model.DriverHomeTel = data.DriverHomeTel;
            model.ArrivalTime = data.ArrivalTime;
            model.PayerId = data.PayerId;
            model.PayerName = data.PayerName;
            model.IsConsigning = data.IsConsigning;
            model.ConsignedDeliveryNo = data.ConsignedDeliveryNo;
            model.IsInstalment = data.IsInstalment;
            model.StartCountry = data.StartCountry;
            model.StartProvince = data.StartProvince;
            model.StartCity = data.StartCity;
            model.Remark = data.Remark;
            model.CreateTime = data.CreateTime.ToString("yyyy-MM-dd");

            model.Goods = new List<PaperPlanGoodsViewModel>();
            model.Goods.Add(new PaperPlanGoodsViewModel());

            //生成讫点国家下拉列表项
            DDSystem dd = new DDSystem();
            List<Country> listDestCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listDestCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListDestCountry = new List<SelectListItem>();
            selectListDestCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCountry.AddRange(from c in listDestCountry
                                           select new SelectListItem
                                           {
                                               Text = c.Name,
                                               Value = c.Name
                                           });
            ViewData["DestCountrys"] = new SelectList(selectListDestCountry, "Value", "Text", model.ReceiverCountry);

            //生成讫点省份下拉列表项
            List<Province> listDestProvince = null;
            if (!string.IsNullOrEmpty(model.ReceiverCountry))
            {
                listDestProvince = dd.LoadProvincesByCountry(model.ReceiverCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listDestProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listDestProvince = new List<Province>();
            }
            List<SelectListItem> selectListDestProvince = new List<SelectListItem>();
            selectListDestProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestProvince.AddRange(from p in listDestProvince
                                            select new SelectListItem
                                            {
                                                Text = p.Name,
                                                Value = p.Name
                                            });
            ViewData["DestProvinces"] = new SelectList(selectListDestProvince, "Value", "Text", model.ReceiverProvince);

            //生成讫点城市下拉列表项
            List<City> listDestCity = null;
            if (!string.IsNullOrEmpty(model.ReceiverProvince))
            {
                listDestCity = dd.LoadCitysByProvince(model.ReceiverCountry, model.ReceiverProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listDestCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listDestCity = new List<City>();
            }
            List<SelectListItem> selectListDestCity = new List<SelectListItem>();
            selectListDestCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCity.AddRange(from ci in listDestCity
                                        select new SelectListItem
                                        {
                                            Text = ci.Name,
                                            Value = ci.Name
                                        });
            ViewData["DestCitys"] = new SelectList(selectListDestCity, "Value", "Text", model.ReceiverCity);

            //生成起点国家下拉列表项
            List<Country> listStartCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listStartCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStartCountry = new List<SelectListItem>();
            selectListStartCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCountry.AddRange(from c in listStartCountry
                                            select new SelectListItem
                                            {
                                                Text = c.Name,
                                                Value = c.Name
                                            });
            ViewData["StartCountrys"] = new SelectList(selectListStartCountry, "Value", "Text", model.StartCountry);

            //生成起点省份下拉列表项
            List<Province> listStartProvince = null;
            if (!string.IsNullOrEmpty(model.StartCountry))
            {
                listStartProvince = dd.LoadProvincesByCountry(model.StartCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartProvince = new List<Province>();
            }
            List<SelectListItem> selectListStartProvince = new List<SelectListItem>();
            selectListStartProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartProvince.AddRange(from p in listStartProvince
                                             select new SelectListItem
                                             {
                                                 Text = p.Name,
                                                 Value = p.Name
                                             });
            ViewData["StartProvinces"] = new SelectList(selectListStartProvince, "Value", "Text", model.StartProvince);

            //生成起点城市下拉列表项
            List<City> listStartCity = null;
            if (!string.IsNullOrEmpty(model.StartProvince))
            {
                listStartCity = dd.LoadCitysByProvince(model.StartCountry, model.StartProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartCity = new List<City>();
            }
            List<SelectListItem> selectListStartCity = new List<SelectListItem>();
            selectListStartCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCity.AddRange(from ci in listStartCity
                                         select new SelectListItem
                                         {
                                             Text = ci.Name,
                                             Value = ci.Name
                                         });
            ViewData["StartCitys"] = new SelectList(selectListStartCity, "Value", "Text", model.StartCity);

            return View(model);
        }

        /// <summary>
        /// 判断计划是否为客户录入
        /// </summary>
        /// <param name="nPlanId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult IsCustomerNew(long nPlanId)
        {
            //读取计划数据
            string strErrText;
            PlanSystem plan = new PlanSystem();
            DeliverPlan data = plan.LoadDeliverPlan(nPlanId, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //读取创建人数据
            AuthenticateSystem auth = new AuthenticateSystem();
            Account data2 = auth.LoadAccount(data.CreatorId, LoginAccountId, LoginStaffName, out strErrText);
            if (data2 == null)
            {
                throw new Exception(strErrText);
            }

            if (data2.AccountType == InnoSoft.LS.Resources.Options.Customer)
                return Json(true, JsonRequestBehavior.AllowGet);
            else
                return Json(false, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET纸发货计划货物表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPaperPlanGoodsGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            PlanSystem plan = new PlanSystem();
            List<DeliverPlanGoods> listGoods = plan.LoadDeliverPlanAllGoods(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
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
                              g.Packages.ToString("#0"),
                              g.Packages != 0 ? (g.Tunnages / g.Packages).ToString("#0.######") : g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              g.ProductionDate,
                              g.EnterWarehouseBillId.ToString(),
                              g.EnterWarehouseBillNo
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

        /// <summary>
        /// POST修改纸发货计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyPaperPlan(PaperPlanViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.ReceiveType == InnoSoft.LS.Resources.Options.PickUpSelf)
                {
                    if (model.CarNo == null || model.CarNo == string.Empty)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterCarrierInfoWhenPickUpSelf);
                    }
                    if (model.DriverName != null && model.DriverName != string.Empty)
                    {
                        if (model.DriverLicenseNo == null || model.DriverLicenseNo == string.Empty)
                        {
                            return Json(InnoSoft.LS.Resources.Strings.NotEnterDriverLicenseNo);
                        }
                        if (model.DriverMobileTel == null || model.DriverMobileTel == string.Empty)
                        {
                            return Json(InnoSoft.LS.Resources.Strings.NotEnterDriverMobileTel);
                        }
                    }
                }
                else
                {
                    if (model.DeliveryNo == null || model.DeliveryNo == string.Empty)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterDeliveryNo);
                    }
                }
                if (model.Goods == null || model.Goods.Count == 0)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterGoods);
                }

                //创建数据
                DeliverPlan data = new DeliverPlan();
                data.Id = model.Id;
                data.PlanType = InnoSoft.LS.Resources.Options.PaperPlan;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.ShipmentNo = model.ShipmentNo;
                data.DeliveryNo = model.DeliveryNo;
                data.DeliverType = model.DeliverType;
                data.ReceiverName = model.ReceiverName;
                data.ReceiverCountry = model.ReceiverCountry;
                data.ReceiverProvince = model.ReceiverProvince;
                data.ReceiverCity = model.ReceiverCity;
                data.ReceiverAddress = model.ReceiverAddress;
                data.ReceiverContact = model.ReceiverContact;
                data.ReceiverContactTel = model.ReceiverContactTel;
                data.OrderNo = model.OrderNo;
                data.ReceiveType = model.ReceiveType;
                data.CarNo = model.CarNo;
                data.TrailerNo = model.TrailerNo;
                data.DriverName = model.DriverName;
                data.DriverLicenseNo = model.DriverLicenseNo;
                data.DriverMobileTel = model.DriverMobileTel;
                data.DriverHomeTel = model.DriverHomeTel;
                data.Warehouse = model.Warehouse;
                data.ArrivalTime = model.ArrivalTime;
                data.PayerId = model.PayerId;
                data.PayerName = model.PayerName;
                data.IsConsigning = model.IsConsigning;
                data.ConsignedDeliveryNo = model.ConsignedDeliveryNo;
                data.IsInstalment = model.IsInstalment;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.Remark = model.Remark;
                data.CreateTime = DateTime.Parse(model.CreateTime);

                List<DeliverPlanGoods> listGoods = new List<DeliverPlanGoods>();
                if (model.Goods != null)
                {
                    foreach (PaperPlanGoodsViewModel m in model.Goods)
                    {
                        DeliverPlanGoods g = new DeliverPlanGoods();
                        g.GoodsId = m.GoodsId;
                        g.BatchNo = m.BatchNo;
                        g.Packing = m.Packing;
                        g.Location = m.Location;
                        g.Packages = m.Packages;
                        g.PieceWeight = m.PieceWeight;
                        g.Tunnages = m.Tunnages;
                        g.Piles = 0;
                        g.TenThousands = 0;
                        g.ProductionDate = m.ProductionDate;
                        g.EnterWarehouseBillId = m.EnterWarehouseBillId;
                        listGoods.Add(g);
                    }
                }

                //保存数据
                string strErrText;
                PlanSystem plan = new PlanSystem();
                if (plan.UpdateDeliverPlan(data, listGoods, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改纸直发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyNotDeliverPaperPlan(string id)
        {
            string strErrText;

            //读取计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan data = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            PaperPlanViewModel model = new PaperPlanViewModel();
            model.Id = data.Id;
            model.CustomerId = data.CustomerId;
            model.CustomerName = data.CustomerName;
            model.ShipmentNo = data.ShipmentNo;
            model.DeliveryNo = data.DeliveryNo;
            model.ReceiverName = data.ReceiverName;
            model.ReceiverCountry = data.ReceiverCountry;
            model.ReceiverProvince = data.ReceiverProvince;
            model.ReceiverCity = data.ReceiverCity;
            model.ReceiverAddress = data.ReceiverAddress;
            model.ReceiverContact = data.ReceiverContact;
            model.ReceiverContactTel = data.ReceiverContactTel;
            model.Warehouse = data.Warehouse;
            model.ArrivalTime = data.ArrivalTime;
            model.PayerId = data.PayerId;
            model.PayerName = data.PayerName;
            model.IsInstalment = data.IsInstalment;
            model.StartCountry = data.StartCountry;
            model.StartProvince = data.StartProvince;
            model.StartCity = data.StartCity;
            model.Remark = data.Remark;
            model.CreateTime = data.CreateTime.ToString("yyyy-MM-dd");

            model.Goods = new List<PaperPlanGoodsViewModel>();
            model.Goods.Add(new PaperPlanGoodsViewModel());

            //生成讫点国家下拉列表项
            DDSystem dd = new DDSystem();
            List<Country> listDestCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listDestCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListDestCountry = new List<SelectListItem>();
            selectListDestCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCountry.AddRange(from c in listDestCountry
                                           select new SelectListItem
                                           {
                                               Text = c.Name,
                                               Value = c.Name
                                           });
            ViewData["DestCountrys"] = new SelectList(selectListDestCountry, "Value", "Text", model.ReceiverCountry);

            //生成讫点省份下拉列表项
            List<Province> listDestProvince = null;
            if (!string.IsNullOrEmpty(model.ReceiverCountry))
            {
                listDestProvince = dd.LoadProvincesByCountry(model.ReceiverCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listDestProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listDestProvince = new List<Province>();
            }
            List<SelectListItem> selectListDestProvince = new List<SelectListItem>();
            selectListDestProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestProvince.AddRange(from p in listDestProvince
                                            select new SelectListItem
                                            {
                                                Text = p.Name,
                                                Value = p.Name
                                            });
            ViewData["DestProvinces"] = new SelectList(selectListDestProvince, "Value", "Text", model.ReceiverProvince);

            //生成讫点城市下拉列表项
            List<City> listDestCity = null;
            if (!string.IsNullOrEmpty(model.ReceiverProvince))
            {
                listDestCity = dd.LoadCitysByProvince(model.ReceiverCountry, model.ReceiverProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listDestCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listDestCity = new List<City>();
            }
            List<SelectListItem> selectListDestCity = new List<SelectListItem>();
            selectListDestCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCity.AddRange(from ci in listDestCity
                                        select new SelectListItem
                                        {
                                            Text = ci.Name,
                                            Value = ci.Name
                                        });
            ViewData["DestCitys"] = new SelectList(selectListDestCity, "Value", "Text", model.ReceiverCity);

            //生成起点国家下拉列表项
            List<Country> listStartCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listStartCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStartCountry = new List<SelectListItem>();
            selectListStartCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCountry.AddRange(from c in listStartCountry
                                            select new SelectListItem
                                            {
                                                Text = c.Name,
                                                Value = c.Name
                                            });
            ViewData["StartCountrys"] = new SelectList(selectListStartCountry, "Value", "Text", model.StartCountry);

            //生成起点省份下拉列表项
            List<Province> listStartProvince = null;
            if (!string.IsNullOrEmpty(model.StartCountry))
            {
                listStartProvince = dd.LoadProvincesByCountry(model.StartCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartProvince = new List<Province>();
            }
            List<SelectListItem> selectListStartProvince = new List<SelectListItem>();
            selectListStartProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartProvince.AddRange(from p in listStartProvince
                                             select new SelectListItem
                                             {
                                                 Text = p.Name,
                                                 Value = p.Name
                                             });
            ViewData["StartProvinces"] = new SelectList(selectListStartProvince, "Value", "Text", model.StartProvince);

            //生成起点城市下拉列表项
            List<City> listStartCity = null;
            if (!string.IsNullOrEmpty(model.StartProvince))
            {
                listStartCity = dd.LoadCitysByProvince(model.StartCountry, model.StartProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartCity = new List<City>();
            }
            List<SelectListItem> selectListStartCity = new List<SelectListItem>();
            selectListStartCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCity.AddRange(from ci in listStartCity
                                         select new SelectListItem
                                         {
                                             Text = ci.Name,
                                             Value = ci.Name
                                         });
            ViewData["StartCitys"] = new SelectList(selectListStartCity, "Value", "Text", model.StartCity);

            return View(model);
        }

        /// <summary>
        /// POST修改纸直发货计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyNotDeliverPaperPlan(PaperPlanViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.DeliveryNo == null || model.DeliveryNo == string.Empty)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterDeliveryNo);
                }
                if (model.Goods == null || model.Goods.Count == 0)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterGoods);
                }

                //创建数据
                DeliverPlan data = new DeliverPlan();
                data.Id = model.Id;
                data.PlanType = InnoSoft.LS.Resources.Options.NotDeliverPaperPlan;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.ShipmentNo = model.ShipmentNo;
                data.DeliveryNo = model.DeliveryNo;
                data.DeliverType = model.DeliverType;
                data.ReceiverName = model.ReceiverName;
                data.ReceiverCountry = model.ReceiverCountry;
                data.ReceiverProvince = model.ReceiverProvince;
                data.ReceiverCity = model.ReceiverCity;
                data.ReceiverAddress = model.ReceiverAddress;
                data.ReceiverContact = model.ReceiverContact;
                data.ReceiverContactTel = model.ReceiverContactTel;
                data.ReceiveType = model.ReceiveType;
                data.CarNo = model.CarNo;
                data.TrailerNo = model.TrailerNo;
                data.DriverName = model.DriverName;
                data.DriverLicenseNo = model.DriverLicenseNo;
                data.DriverMobileTel = model.DriverMobileTel;
                data.DriverHomeTel = model.DriverHomeTel;
                data.Warehouse = model.Warehouse;
                data.ArrivalTime = model.ArrivalTime;
                data.PayerId = model.PayerId;
                data.PayerName = model.PayerName;
                data.IsConsigning = model.IsConsigning;
                data.ConsignedDeliveryNo = model.ConsignedDeliveryNo;
                data.IsInstalment = model.IsInstalment;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.Remark = model.Remark;
                data.CreateTime = DateTime.Parse(model.CreateTime);

                List<DeliverPlanGoods> listGoods = new List<DeliverPlanGoods>();
                if (model.Goods != null)
                {
                    foreach (PaperPlanGoodsViewModel m in model.Goods)
                    {
                        DeliverPlanGoods g = new DeliverPlanGoods();
                        g.GoodsId = m.GoodsId;
                        g.BatchNo = m.BatchNo;
                        g.Packing = m.Packing;
                        g.Location = m.Location;
                        g.Packages = m.Packages;
                        g.PieceWeight = m.PieceWeight;
                        g.Tunnages = m.Tunnages;
                        g.Piles = 0;
                        g.TenThousands = 0;
                        g.ProductionDate = m.ProductionDate;
                        g.EnterWarehouseBillId = m.EnterWarehouseBillId;
                        listGoods.Add(g);
                    }
                }

                //保存数据
                string strErrText;
                PlanSystem plan = new PlanSystem();
                if (plan.UpdateDeliverPlan(data, listGoods, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改罐发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyCanPlan(string id)
        {
            string strErrText;

            //读取计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan data = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            CanPlanViewModel model = new CanPlanViewModel();
            model.Id = data.Id;
            model.CustomerId = data.CustomerId;
            model.CustomerName = data.CustomerName;
            model.DeliveryNo = data.DeliveryNo;
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
            model.DriverName = data.DriverName;
            model.DriverLicenseNo = data.DriverLicenseNo;
            model.DriverMobileTel = data.DriverMobileTel;
            model.DriverHomeTel = data.DriverHomeTel;
            model.ArrivalTime = data.ArrivalTime;
            model.PayerId = data.PayerId;
            model.PayerName = data.PayerName;
            model.StartCountry = data.StartCountry;
            model.StartProvince = data.StartProvince;
            model.StartCity = data.StartCity;
            model.Remark = data.Remark;
            model.CreateTime = data.CreateTime.ToString("yyyy-MM-dd");

            model.Goods = new List<CanPlanGoodsViewModel>();
            model.Goods.Add(new CanPlanGoodsViewModel());

            //生成讫点国家下拉列表项
            DDSystem dd = new DDSystem();
            List<Country> listDestCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listDestCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListDestCountry = new List<SelectListItem>();
            selectListDestCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCountry.AddRange(from c in listDestCountry
                                           select new SelectListItem
                                           {
                                               Text = c.Name,
                                               Value = c.Name
                                           });
            ViewData["DestCountrys"] = new SelectList(selectListDestCountry, "Value", "Text", model.ReceiverCountry);

            //生成讫点省份下拉列表项
            List<Province> listDestProvince = null;
            if (!string.IsNullOrEmpty(model.ReceiverCountry))
            {
                listDestProvince = dd.LoadProvincesByCountry(model.ReceiverCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listDestProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listDestProvince = new List<Province>();
            }
            List<SelectListItem> selectListDestProvince = new List<SelectListItem>();
            selectListDestProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestProvince.AddRange(from p in listDestProvince
                                            select new SelectListItem
                                            {
                                                Text = p.Name,
                                                Value = p.Name
                                            });
            ViewData["DestProvinces"] = new SelectList(selectListDestProvince, "Value", "Text", model.ReceiverProvince);

            //生成讫点城市下拉列表项
            List<City> listDestCity = null;
            if (!string.IsNullOrEmpty(model.ReceiverProvince))
            {
                listDestCity = dd.LoadCitysByProvince(model.ReceiverCountry, model.ReceiverProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listDestCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listDestCity = new List<City>();
            }
            List<SelectListItem> selectListDestCity = new List<SelectListItem>();
            selectListDestCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCity.AddRange(from ci in listDestCity
                                        select new SelectListItem
                                        {
                                            Text = ci.Name,
                                            Value = ci.Name
                                        });
            ViewData["DestCitys"] = new SelectList(selectListDestCity, "Value", "Text", model.ReceiverCity);

            //生成起点国家下拉列表项
            List<Country> listStartCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listStartCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStartCountry = new List<SelectListItem>();
            selectListStartCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCountry.AddRange(from c in listStartCountry
                                            select new SelectListItem
                                            {
                                                Text = c.Name,
                                                Value = c.Name
                                            });
            ViewData["StartCountrys"] = new SelectList(selectListStartCountry, "Value", "Text", model.StartCountry);

            //生成起点省份下拉列表项
            List<Province> listStartProvince = null;
            if (!string.IsNullOrEmpty(model.StartCountry))
            {
                listStartProvince = dd.LoadProvincesByCountry(model.StartCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartProvince = new List<Province>();
            }
            List<SelectListItem> selectListStartProvince = new List<SelectListItem>();
            selectListStartProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartProvince.AddRange(from p in listStartProvince
                                             select new SelectListItem
                                             {
                                                 Text = p.Name,
                                                 Value = p.Name
                                             });
            ViewData["StartProvinces"] = new SelectList(selectListStartProvince, "Value", "Text", model.StartProvince);

            //生成起点城市下拉列表项
            List<City> listStartCity = null;
            if (!string.IsNullOrEmpty(model.StartProvince))
            {
                listStartCity = dd.LoadCitysByProvince(model.StartCountry, model.StartProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartCity = new List<City>();
            }
            List<SelectListItem> selectListStartCity = new List<SelectListItem>();
            selectListStartCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCity.AddRange(from ci in listStartCity
                                         select new SelectListItem
                                         {
                                             Text = ci.Name,
                                             Value = ci.Name
                                         });
            ViewData["StartCitys"] = new SelectList(selectListStartCity, "Value", "Text", model.StartCity);

            return View(model);
        }

        /// <summary>
        /// GET罐发货计划货物表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCanPlanGoodsGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            PlanSystem plan = new PlanSystem();
            List<DeliverPlanGoods> listGoods = plan.LoadDeliverPlanAllGoods(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
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
                              g.EnterWarehouseBillNo
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST修改罐发货计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyCanPlan(CanPlanViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.ReceiveType == InnoSoft.LS.Resources.Options.PickUpSelf)
                {
                    if (model.CarNo == null || model.CarNo == string.Empty)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterCarrierInfoWhenPickUpSelf);
                    }
                    if (model.DriverName != null && model.DriverName != string.Empty)
                    {
                        if (model.DriverLicenseNo == null || model.DriverLicenseNo == string.Empty)
                        {
                            return Json(InnoSoft.LS.Resources.Strings.NotEnterDriverLicenseNo);
                        }
                        if (model.DriverMobileTel == null || model.DriverMobileTel == string.Empty)
                        {
                            return Json(InnoSoft.LS.Resources.Strings.NotEnterDriverMobileTel);
                        }
                    }
                }
                else
                {
                    if (model.DeliveryNo == null || model.DeliveryNo == string.Empty)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterDeliveryNo);
                    }
                }
                if (model.Goods == null || model.Goods.Count == 0)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterGoods);
                }

                //创建数据
                DeliverPlan data = new DeliverPlan();
                data.Id = model.Id;
                data.PlanType = InnoSoft.LS.Resources.Options.CanPlan;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.DeliveryNo = model.DeliveryNo;
                data.DeliverType = InnoSoft.LS.Resources.Options.DeliverGoods;
                data.ReceiverName = model.ReceiverName;
                data.ReceiverCountry = model.ReceiverCountry;
                data.ReceiverProvince = model.ReceiverProvince;
                data.ReceiverCity = model.ReceiverCity;
                data.ReceiverAddress = model.ReceiverAddress;
                data.ReceiverContact = model.ReceiverContact;
                data.ReceiverContactTel = model.ReceiverContactTel;
                data.ReceiveType = model.ReceiveType;
                data.CarNo = model.CarNo;
                data.TrailerNo = model.TrailerNo;
                data.DriverName = model.DriverName;
                data.DriverLicenseNo = model.DriverLicenseNo;
                data.DriverMobileTel = model.DriverMobileTel;
                data.DriverHomeTel = model.DriverHomeTel;
                data.Warehouse = model.Warehouse;
                data.ArrivalTime = model.ArrivalTime;
                data.PayerId = model.PayerId;
                data.PayerName = model.PayerName;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.Remark = model.Remark;
                data.CreateTime = DateTime.Parse(model.CreateTime);

                List<DeliverPlanGoods> listGoods = new List<DeliverPlanGoods>();
                if (model.Goods != null)
                {
                    foreach (CanPlanGoodsViewModel m in model.Goods)
                    {
                        DeliverPlanGoods g = new DeliverPlanGoods();
                        g.GoodsId = m.GoodsId;
                        g.GoodsNo = m.GoodsNo;
                        g.GoodsName = m.GoodsName;
                        g.SpecModel = m.SpecModel;
                        g.BatchNo = m.BatchNo;
                        g.Warehouse = m.Warehouse;
                        g.Location = m.Location;
                        g.Piles = m.Piles;
                        g.TenThousands = m.TenThousands;
                        g.ProductionDate = m.ProductionDate;
                        g.EnterWarehouseBillId = m.EnterWarehouseBillId;
                        g.EnterWarehouseBillNo = m.EnterWarehouseBillNo;
                        listGoods.Add(g);
                    }
                }

                //保存数据
                string strErrText;
                PlanSystem plan = new PlanSystem();
                if (plan.UpdateDeliverPlan(data, listGoods, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改罐直发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyNotDeliverCanPlan(string id)
        {
            string strErrText;

            //读取计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan data = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            CanPlanViewModel model = new CanPlanViewModel();
            model.Id = data.Id;
            model.CustomerId = data.CustomerId;
            model.CustomerName = data.CustomerName;
            model.DeliveryNo = data.DeliveryNo;
            model.ReceiverName = data.ReceiverName;
            model.ReceiverCountry = data.ReceiverCountry;
            model.ReceiverProvince = data.ReceiverProvince;
            model.ReceiverCity = data.ReceiverCity;
            model.ReceiverAddress = data.ReceiverAddress;
            model.ReceiverContact = data.ReceiverContact;
            model.ReceiverContactTel = data.ReceiverContactTel;
            model.Warehouse = data.Warehouse;
            model.ArrivalTime = data.ArrivalTime;
            model.StartCountry = data.StartCountry;
            model.StartProvince = data.StartProvince;
            model.StartCity = data.StartCity;
            model.Remark = data.Remark;
            model.CreateTime = data.CreateTime.ToString("yyyy-MM-dd");

            model.Goods = new List<CanPlanGoodsViewModel>();
            model.Goods.Add(new CanPlanGoodsViewModel());

            //生成讫点国家下拉列表项
            DDSystem dd = new DDSystem();
            List<Country> listDestCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listDestCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListDestCountry = new List<SelectListItem>();
            selectListDestCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCountry.AddRange(from c in listDestCountry
                                           select new SelectListItem
                                           {
                                               Text = c.Name,
                                               Value = c.Name
                                           });
            ViewData["DestCountrys"] = new SelectList(selectListDestCountry, "Value", "Text", model.ReceiverCountry);

            //生成讫点省份下拉列表项
            List<Province> listDestProvince = null;
            if (!string.IsNullOrEmpty(model.ReceiverCountry))
            {
                listDestProvince = dd.LoadProvincesByCountry(model.ReceiverCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listDestProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listDestProvince = new List<Province>();
            }
            List<SelectListItem> selectListDestProvince = new List<SelectListItem>();
            selectListDestProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestProvince.AddRange(from p in listDestProvince
                                            select new SelectListItem
                                            {
                                                Text = p.Name,
                                                Value = p.Name
                                            });
            ViewData["DestProvinces"] = new SelectList(selectListDestProvince, "Value", "Text", model.ReceiverProvince);

            //生成讫点城市下拉列表项
            List<City> listDestCity = null;
            if (!string.IsNullOrEmpty(model.ReceiverProvince))
            {
                listDestCity = dd.LoadCitysByProvince(model.ReceiverCountry, model.ReceiverProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listDestCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listDestCity = new List<City>();
            }
            List<SelectListItem> selectListDestCity = new List<SelectListItem>();
            selectListDestCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCity.AddRange(from ci in listDestCity
                                        select new SelectListItem
                                        {
                                            Text = ci.Name,
                                            Value = ci.Name
                                        });
            ViewData["DestCitys"] = new SelectList(selectListDestCity, "Value", "Text", model.ReceiverCity);

            //生成起点国家下拉列表项
            List<Country> listStartCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listStartCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStartCountry = new List<SelectListItem>();
            selectListStartCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCountry.AddRange(from c in listStartCountry
                                            select new SelectListItem
                                            {
                                                Text = c.Name,
                                                Value = c.Name
                                            });
            ViewData["StartCountrys"] = new SelectList(selectListStartCountry, "Value", "Text", model.StartCountry);

            //生成起点省份下拉列表项
            List<Province> listStartProvince = null;
            if (!string.IsNullOrEmpty(model.StartCountry))
            {
                listStartProvince = dd.LoadProvincesByCountry(model.StartCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartProvince = new List<Province>();
            }
            List<SelectListItem> selectListStartProvince = new List<SelectListItem>();
            selectListStartProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartProvince.AddRange(from p in listStartProvince
                                             select new SelectListItem
                                             {
                                                 Text = p.Name,
                                                 Value = p.Name
                                             });
            ViewData["StartProvinces"] = new SelectList(selectListStartProvince, "Value", "Text", model.StartProvince);

            //生成起点城市下拉列表项
            List<City> listStartCity = null;
            if (!string.IsNullOrEmpty(model.StartProvince))
            {
                listStartCity = dd.LoadCitysByProvince(model.StartCountry, model.StartProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartCity = new List<City>();
            }
            List<SelectListItem> selectListStartCity = new List<SelectListItem>();
            selectListStartCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCity.AddRange(from ci in listStartCity
                                         select new SelectListItem
                                         {
                                             Text = ci.Name,
                                             Value = ci.Name
                                         });
            ViewData["StartCitys"] = new SelectList(selectListStartCity, "Value", "Text", model.StartCity);

            return View(model);
        }

        /// <summary>
        /// POST修改罐直发货计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyNotDeliverCanPlan(CanPlanViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.Goods == null || model.Goods.Count == 0)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterGoods);
                }

                //创建数据
                DeliverPlan data = new DeliverPlan();
                data.Id = model.Id;
                data.PlanType = InnoSoft.LS.Resources.Options.NotDeliverCanPlan;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.DeliveryNo = model.DeliveryNo;
                data.DeliverType = InnoSoft.LS.Resources.Options.DeliverGoods;
                data.ReceiverName = model.ReceiverName;
                data.ReceiverCountry = model.ReceiverCountry;
                data.ReceiverProvince = model.ReceiverProvince;
                data.ReceiverCity = model.ReceiverCity;
                data.ReceiverAddress = model.ReceiverAddress;
                data.ReceiverContact = model.ReceiverContact;
                data.ReceiverContactTel = model.ReceiverContactTel;
                data.ReceiveType = model.ReceiveType;
                data.CarNo = model.CarNo;
                data.TrailerNo = model.TrailerNo;
                data.DriverName = model.DriverName;
                data.DriverLicenseNo = model.DriverLicenseNo;
                data.DriverMobileTel = model.DriverMobileTel;
                data.DriverHomeTel = model.DriverHomeTel;
                data.Warehouse = model.Warehouse;
                data.ArrivalTime = model.ArrivalTime;
                data.PayerId = model.PayerId;
                data.PayerName = model.PayerName;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.Remark = model.Remark;
                data.CreateTime = DateTime.Parse(model.CreateTime);

                List<DeliverPlanGoods> listGoods = new List<DeliverPlanGoods>();
                if (model.Goods != null)
                {
                    foreach (CanPlanGoodsViewModel m in model.Goods)
                    {
                        DeliverPlanGoods g = new DeliverPlanGoods();
                        g.GoodsId = m.GoodsId;
                        g.GoodsNo = m.GoodsNo;
                        g.GoodsName = m.GoodsName;
                        g.SpecModel = m.SpecModel;
                        g.BatchNo = m.BatchNo;
                        g.Warehouse = m.Warehouse;
                        g.Location = m.Location;
                        g.Piles = m.Piles;
                        g.TenThousands = m.TenThousands;
                        g.ProductionDate = m.ProductionDate;
                        g.EnterWarehouseBillId = m.EnterWarehouseBillId;
                        g.EnterWarehouseBillNo = m.EnterWarehouseBillNo;
                        listGoods.Add(g);
                    }
                }

                //保存数据
                string strErrText;
                PlanSystem plan = new PlanSystem();
                if (plan.UpdateDeliverPlan(data, listGoods, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改方便面发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyNoodlePlan(string id)
        {
            string strErrText;

            //读取计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan data = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            NoodlePlanViewModel model = new NoodlePlanViewModel();
            model.Id = data.Id;
            model.CustomerId = data.CustomerId;
            model.CustomerName = data.CustomerName;
            model.DeliveryNo = data.DeliveryNo;
            model.ReceiverName = data.ReceiverName;
            model.ReceiverCountry = data.ReceiverCountry;
            model.ReceiverProvince = data.ReceiverProvince;
            model.ReceiverCity = data.ReceiverCity;
            model.ReceiverAddress = data.ReceiverAddress;
            model.ReceiverContact = data.ReceiverContact;
            model.ReceiverContactTel = data.ReceiverContactTel;
            model.Warehouse = data.Warehouse;
            model.ArrivalTime = data.ArrivalTime;
            model.StartCountry = data.StartCountry;
            model.StartProvince = data.StartProvince;
            model.StartCity = data.StartCity;
            model.Remark = data.Remark;
            model.CreateTime = data.CreateTime.ToString("yyyy-MM-dd");

            model.Goods = new List<NoodlePlanGoodsViewModel>();
            model.Goods.Add(new NoodlePlanGoodsViewModel());

            //生成讫点国家下拉列表项
            DDSystem dd = new DDSystem();
            List<Country> listDestCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listDestCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListDestCountry = new List<SelectListItem>();
            selectListDestCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCountry.AddRange(from c in listDestCountry
                                           select new SelectListItem
                                           {
                                               Text = c.Name,
                                               Value = c.Name
                                           });
            ViewData["DestCountrys"] = new SelectList(selectListDestCountry, "Value", "Text", model.ReceiverCountry);

            //生成讫点省份下拉列表项
            List<Province> listDestProvince = null;
            if (!string.IsNullOrEmpty(model.ReceiverCountry))
            {
                listDestProvince = dd.LoadProvincesByCountry(model.ReceiverCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listDestProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listDestProvince = new List<Province>();
            }
            List<SelectListItem> selectListDestProvince = new List<SelectListItem>();
            selectListDestProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestProvince.AddRange(from p in listDestProvince
                                            select new SelectListItem
                                            {
                                                Text = p.Name,
                                                Value = p.Name
                                            });
            ViewData["DestProvinces"] = new SelectList(selectListDestProvince, "Value", "Text", model.ReceiverProvince);

            //生成讫点城市下拉列表项
            List<City> listDestCity = null;
            if (!string.IsNullOrEmpty(model.ReceiverProvince))
            {
                listDestCity = dd.LoadCitysByProvince(model.ReceiverCountry, model.ReceiverProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listDestCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listDestCity = new List<City>();
            }
            List<SelectListItem> selectListDestCity = new List<SelectListItem>();
            selectListDestCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCity.AddRange(from ci in listDestCity
                                        select new SelectListItem
                                        {
                                            Text = ci.Name,
                                            Value = ci.Name
                                        });
            ViewData["DestCitys"] = new SelectList(selectListDestCity, "Value", "Text", model.ReceiverCity);

            //生成起点国家下拉列表项
            List<Country> listStartCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listStartCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStartCountry = new List<SelectListItem>();
            selectListStartCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCountry.AddRange(from c in listStartCountry
                                            select new SelectListItem
                                            {
                                                Text = c.Name,
                                                Value = c.Name
                                            });
            ViewData["StartCountrys"] = new SelectList(selectListStartCountry, "Value", "Text", model.StartCountry);

            //生成起点省份下拉列表项
            List<Province> listStartProvince = null;
            if (!string.IsNullOrEmpty(model.StartCountry))
            {
                listStartProvince = dd.LoadProvincesByCountry(model.StartCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartProvince = new List<Province>();
            }
            List<SelectListItem> selectListStartProvince = new List<SelectListItem>();
            selectListStartProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartProvince.AddRange(from p in listStartProvince
                                             select new SelectListItem
                                             {
                                                 Text = p.Name,
                                                 Value = p.Name
                                             });
            ViewData["StartProvinces"] = new SelectList(selectListStartProvince, "Value", "Text", model.StartProvince);

            //生成起点城市下拉列表项
            List<City> listStartCity = null;
            if (!string.IsNullOrEmpty(model.StartProvince))
            {
                listStartCity = dd.LoadCitysByProvince(model.StartCountry, model.StartProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartCity = new List<City>();
            }
            List<SelectListItem> selectListStartCity = new List<SelectListItem>();
            selectListStartCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCity.AddRange(from ci in listStartCity
                                         select new SelectListItem
                                         {
                                             Text = ci.Name,
                                             Value = ci.Name
                                         });
            ViewData["StartCitys"] = new SelectList(selectListStartCity, "Value", "Text", model.StartCity);

            return View(model);
        }

        /// <summary>
        /// GET方便面发货计划货物表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadNoodlePlanGoodsGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            PlanSystem plan = new PlanSystem();
            List<DeliverPlanGoods> listGoods = plan.LoadDeliverPlanAllGoods(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
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
                              g.GoodsId.ToString(), 
                              g.GoodsNo, 
                              g.GoodsName,
                              g.SpecModel,
                              g.Packages.ToString("#0"),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######") 
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

        /// <summary>
        /// POST修改方便面发货计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyNoodlePlan(NoodlePlanViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.Goods == null || model.Goods.Count == 0)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterGoods);
                }

                //创建数据
                DeliverPlan data = new DeliverPlan();
                data.Id = model.Id;
                data.PlanType = InnoSoft.LS.Resources.Options.NoodlePlan;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.DeliveryNo = model.DeliveryNo;
                data.DeliverType = InnoSoft.LS.Resources.Options.DeliverGoods;
                data.ReceiverName = model.ReceiverName;
                data.ReceiverCountry = model.ReceiverCountry;
                data.ReceiverProvince = model.ReceiverProvince;
                data.ReceiverCity = model.ReceiverCity;
                data.ReceiverAddress = model.ReceiverAddress;
                data.ReceiverContact = model.ReceiverContact;
                data.ReceiverContactTel = model.ReceiverContactTel;
                data.ReceiveType = InnoSoft.LS.Resources.Options.PickUpDelivery;
                data.Warehouse = model.Warehouse;
                data.ArrivalTime = model.ArrivalTime;
                data.PayerId = model.CustomerId;
                data.PayerName = model.CustomerName;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.Remark = model.Remark;
                data.CreateTime = DateTime.Parse(model.CreateTime);

                List<DeliverPlanGoods> listGoods = new List<DeliverPlanGoods>();
                if (model.Goods != null)
                {
                    foreach (NoodlePlanGoodsViewModel m in model.Goods)
                    {
                        DeliverPlanGoods g = new DeliverPlanGoods();
                        g.GoodsId = m.GoodsId;
                        g.Packages = m.Packages;
                        g.PieceWeight = m.PieceWeight;
                        g.Tunnages = m.Tunnages;
                        g.Piles = 0;
                        listGoods.Add(g);
                    }
                }

                //保存数据
                string strErrText;
                PlanSystem plan = new PlanSystem();
                if (plan.UpdateDeliverPlan(data, listGoods, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改其它发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyOtherPlan(string id)
        {
            string strErrText;

            //读取计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan data = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            OtherPlanViewModel model = new OtherPlanViewModel();
            model.Id = data.Id;
            model.CustomerId = data.CustomerId;
            model.CustomerName = data.CustomerName;
            model.DeliveryNo = data.DeliveryNo;
            model.ReceiverName = data.ReceiverName;
            model.ReceiverCountry = data.ReceiverCountry;
            model.ReceiverProvince = data.ReceiverProvince;
            model.ReceiverCity = data.ReceiverCity;
            model.ReceiverAddress = data.ReceiverAddress;
            model.ReceiverContact = data.ReceiverContact;
            model.ReceiverContactTel = data.ReceiverContactTel;
            model.Warehouse = data.Warehouse;
            model.ArrivalTime = data.ArrivalTime;
            model.StartCountry = data.StartCountry;
            model.StartProvince = data.StartProvince;
            model.StartCity = data.StartCity;
            model.Remark = data.Remark;
            model.CreateTime = data.CreateTime.ToString("yyyy-MM-dd");

            model.Goods = new List<OtherPlanGoodsViewModel>();
            model.Goods.Add(new OtherPlanGoodsViewModel());

            //生成讫点国家下拉列表项
            DDSystem dd = new DDSystem();
            List<Country> listDestCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listDestCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListDestCountry = new List<SelectListItem>();
            selectListDestCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCountry.AddRange(from c in listDestCountry
                                           select new SelectListItem
                                           {
                                               Text = c.Name,
                                               Value = c.Name
                                           });
            ViewData["DestCountrys"] = new SelectList(selectListDestCountry, "Value", "Text", model.ReceiverCountry);

            //生成讫点省份下拉列表项
            List<Province> listDestProvince = null;
            if (!string.IsNullOrEmpty(model.ReceiverCountry))
            {
                listDestProvince = dd.LoadProvincesByCountry(model.ReceiverCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listDestProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listDestProvince = new List<Province>();
            }
            List<SelectListItem> selectListDestProvince = new List<SelectListItem>();
            selectListDestProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestProvince.AddRange(from p in listDestProvince
                                            select new SelectListItem
                                            {
                                                Text = p.Name,
                                                Value = p.Name
                                            });
            ViewData["DestProvinces"] = new SelectList(selectListDestProvince, "Value", "Text", model.ReceiverProvince);

            //生成讫点城市下拉列表项
            List<City> listDestCity = null;
            if (!string.IsNullOrEmpty(model.ReceiverProvince))
            {
                listDestCity = dd.LoadCitysByProvince(model.ReceiverCountry, model.ReceiverProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listDestCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listDestCity = new List<City>();
            }
            List<SelectListItem> selectListDestCity = new List<SelectListItem>();
            selectListDestCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListDestCity.AddRange(from ci in listDestCity
                                        select new SelectListItem
                                        {
                                            Text = ci.Name,
                                            Value = ci.Name
                                        });
            ViewData["DestCitys"] = new SelectList(selectListDestCity, "Value", "Text", model.ReceiverCity);

            //生成起点国家下拉列表项
            List<Country> listStartCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listStartCountry == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStartCountry = new List<SelectListItem>();
            selectListStartCountry.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCountry.AddRange(from c in listStartCountry
                                            select new SelectListItem
                                            {
                                                Text = c.Name,
                                                Value = c.Name
                                            });
            ViewData["StartCountrys"] = new SelectList(selectListStartCountry, "Value", "Text", model.StartCountry);

            //生成起点省份下拉列表项
            List<Province> listStartProvince = null;
            if (!string.IsNullOrEmpty(model.StartCountry))
            {
                listStartProvince = dd.LoadProvincesByCountry(model.StartCountry, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartProvince == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartProvince = new List<Province>();
            }
            List<SelectListItem> selectListStartProvince = new List<SelectListItem>();
            selectListStartProvince.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartProvince.AddRange(from p in listStartProvince
                                             select new SelectListItem
                                             {
                                                 Text = p.Name,
                                                 Value = p.Name
                                             });
            ViewData["StartProvinces"] = new SelectList(selectListStartProvince, "Value", "Text", model.StartProvince);

            //生成起点城市下拉列表项
            List<City> listStartCity = null;
            if (!string.IsNullOrEmpty(model.StartProvince))
            {
                listStartCity = dd.LoadCitysByProvince(model.StartCountry, model.StartProvince, LoginAccountId, LoginStaffName, out strErrText);
                if (listStartCity == null)
                {
                    throw new Exception(strErrText);
                }
            }
            else
            {
                listStartCity = new List<City>();
            }
            List<SelectListItem> selectListStartCity = new List<SelectListItem>();
            selectListStartCity.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStartCity.AddRange(from ci in listStartCity
                                         select new SelectListItem
                                         {
                                             Text = ci.Name,
                                             Value = ci.Name
                                         });
            ViewData["StartCitys"] = new SelectList(selectListStartCity, "Value", "Text", model.StartCity);

            return View(model);
        }

        /// <summary>
        /// GET其它发货计划货物表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadOtherPlanGoodsGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            PlanSystem plan = new PlanSystem();
            List<DeliverPlanGoods> listGoods = plan.LoadDeliverPlanAllGoods(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
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
                              g.GoodsId.ToString(), 
                              g.GoodsNo, 
                              g.GoodsName,
                              g.SpecModel,
                              g.Packages.ToString("#0"),
                              g.Tunnages.ToString("#0.######") 
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

        /// <summary>
        /// POST修改其它发货计划
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyOtherPlan(OtherPlanViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.Goods == null || model.Goods.Count == 0)
                {
                    return Json(InnoSoft.LS.Resources.Strings.NotEnterGoods);
                }

                //创建数据
                DeliverPlan data = new DeliverPlan();
                data.Id = model.Id;
                data.PlanType = InnoSoft.LS.Resources.Options.OtherPlan;
                data.CustomerId = model.CustomerId;
                data.CustomerName = model.CustomerName;
                data.DeliveryNo = model.DeliveryNo;
                data.DeliverType = InnoSoft.LS.Resources.Options.DeliverGoods;
                data.ReceiverName = model.ReceiverName;
                data.ReceiverCountry = model.ReceiverCountry;
                data.ReceiverProvince = model.ReceiverProvince;
                data.ReceiverCity = model.ReceiverCity;
                data.ReceiverAddress = model.ReceiverAddress;
                data.ReceiverContact = model.ReceiverContact;
                data.ReceiverContactTel = model.ReceiverContactTel;
                data.ReceiveType = InnoSoft.LS.Resources.Options.PickUpDelivery;
                data.Warehouse = model.Warehouse;
                data.ArrivalTime = model.ArrivalTime;
                data.PayerId = model.CustomerId;
                data.PayerName = model.CustomerName;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.Remark = model.Remark;
                data.CreateTime = DateTime.Parse(model.CreateTime);

                List<DeliverPlanGoods> listGoods = new List<DeliverPlanGoods>();
                if (model.Goods != null)
                {
                    foreach (OtherPlanGoodsViewModel m in model.Goods)
                    {
                        DeliverPlanGoods g = new DeliverPlanGoods();
                        g.GoodsId = m.GoodsId;
                        g.Packages = m.Packages;
                        g.Tunnages = m.Tunnages;
                        g.Piles = 0;
                        listGoods.Add(g);
                    }
                }

                //保存数据
                string strErrText;
                PlanSystem plan = new PlanSystem();
                if (plan.UpdateDeliverPlan(data, listGoods, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST复制发货计划
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult CopyDeliverPlan(string id)
        {
            //复制计划
            string strErrText;
            PlanSystem plan = new PlanSystem();
            long nPlanId = plan.CopyDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (nPlanId == 0)
            {
                throw new Exception(strErrText);
            }

            //读取计划
            DeliverPlan data = plan.LoadDeliverPlan(nPlanId, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            if (data.PlanType == InnoSoft.LS.Resources.Options.PaperPlan)
            {
                return RedirectToAction("ModifyPaperPlan", new { id = nPlanId });
            }
            else if (data.PlanType == InnoSoft.LS.Resources.Options.NotDeliverPaperPlan)
            {
                return RedirectToAction("ModifyNotDeliverPaperPlan", new { id = nPlanId });
            }
            else if (data.PlanType == InnoSoft.LS.Resources.Options.CanPlan)
            {
                return RedirectToAction("ModifyCanPlan", new { id = nPlanId });
            }
            else if (data.PlanType == InnoSoft.LS.Resources.Options.NotDeliverCanPlan)
            {
                return RedirectToAction("ModifyNotDeliverCanPlan", new { id = nPlanId });
            }
            else if (data.PlanType == InnoSoft.LS.Resources.Options.NoodlePlan)
            {
                return RedirectToAction("ModifyNoodlePlan", new { id = nPlanId });
            }
            else
            {
                return RedirectToAction("ModifyOtherPlan", new { id = nPlanId });
            }
        }

        /// <summary>
        /// POST删除发货计划
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteDeliverPlan(string id)
        {
            string strErrText;
            PlanSystem plan = new PlanSystem();
            if (plan.DeleteDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// GET提交纸发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult SubmitPaperPlan(string id)
        {
            ViewData["id"] = id;

            return View();
        }

        /// <summary>
        /// GET提交罐发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult SubmitCanPlan(string id)
        {
            ViewData["id"] = id;

            return View();
        }

        /// <summary>
        /// GET提交方便面发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult SubmitNoodlePlan(string id)
        {
            ViewData["id"] = id;

            return View();
        }

        /// <summary>
        /// GET提交其它发货计划页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult SubmitOtherPlan(string id)
        {
            ViewData["id"] = id;

            return View();
        }

        /// <summary>
        /// POST提交发货计划
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult SubmitDeliverPlan(string id)
        {
            string strMessage;
            PlanSystem plan = new PlanSystem();
            bool bSuccess = plan.SubmitDeliverPlan(long.Parse(id), true, string.Empty, LoginAccountId, LoginStaffName, out strMessage);

            var ret = new
            {
                Success = bSuccess,
                Message = strMessage
            };
            return Json(ret);
        }

        #endregion

        #region 客户审批计划代码

        /// <summary>
        /// GET客户审批纸发货计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult CustomerApprovePaperPlans()
        {
            return View();
        }

        /// <summary>
        /// GET客户审批纸发货计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCustomerApprovePaperPlansGrid(string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            PlanSystem plan = new PlanSystem();
            List<DeliverPlan> listPlan = plan.LoadCustomerApproveDeliverPlans(LoginAccountId, LoginStaffName, out strErrText);
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
                              p.ReceiverCountry + p.ReceiverProvince + p.ReceiverCity + p.ReceiverAddress,
                              p.PlanType
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET客户审批意见页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult CustomerApproveOpinion(string id)
        {
            ViewData["id"] = id;

            return View();
        }

        /// <summary>
        /// POST客户同意计划
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult CustomerAgreeDeliverPlan(string id)
        {
            string strErrText;
            PlanSystem plan = new PlanSystem();
            bool bSuccess = plan.CustomerAgreeDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);

            var ret = new
            {
                Success = bSuccess,
                Message = strErrText
            };
            return Json(ret);
        }

        /// <summary>
        /// POST客户不同意计划
        /// </summary>
        /// <param name="id"></param>
        /// <param name="disagreeopinion"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult CustomerDisagreeDeliverPlan(string id, string disagreeopinion)
        {
            string strErrText;
            PlanSystem plan = new PlanSystem();
            if (plan.CustomerDisagreeDeliverPlan(long.Parse(id), disagreeopinion, LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 审批计划代码

        /// <summary>
        /// GET审批发货计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ApproveDeliverPlans()
        {
            return View();
        }

        /// <summary>
        /// GET审批纸发货计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadApprovePaperPlansGrid(string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            PlanSystem plan = new PlanSystem();
            List<DeliverPlan> listPlan = plan.LoadApproveDeliverPlans(LoginAccountId, LoginStaffName, out strErrText);
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
                              p.ReceiverCountry + p.ReceiverProvince + p.ReceiverCity + p.ReceiverAddress,
                              p.PlanType
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET审批意见页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ApproveOpinion(string id)
        {
            //读取发货计划
            string strErrText;
            PlanSystem plan = new PlanSystem();
            DeliverPlan data = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            ViewData["id"] = id;
            ViewData["PlanType"] = data.PlanType;

            return View();
        }

        /// <summary>
        /// POST同意计划
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult AgreeDeliverPlan(string id)
        {
            string strMessage;
            PlanSystem plan = new PlanSystem();
            bool bSuccess = plan.SubmitDeliverPlan(long.Parse(id), true, "", LoginAccountId, LoginStaffName, out strMessage);

            var ret = new
            {
                Success = bSuccess,
                Message = strMessage
            };
            return Json(ret);
        }

        /// <summary>
        /// POST不同意计划
        /// </summary>
        /// <param name="id"></param>
        /// <param name="disagreeopinion"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DisagreeDeliverPlan(string id, string disagreeopinion)
        {
            string strErrText;
            PlanSystem plan = new PlanSystem();
            if (plan.SubmitDeliverPlan(long.Parse(id), false, disagreeopinion, LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 查询计划

        /// <summary>
        /// GET查询计划页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchDeliverPlans()
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
        /// GET查询计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="customerName"></param>
        /// <param name="shipmentNo"></param>
        /// <param name="deliveryNo"></param>
        /// <param name="deliverType"></param>
        /// <param name="receiverName"></param>
        /// <param name="startCountry"></param>
        /// <param name="startProvince"></param>
        /// <param name="startCity"></param>
        /// <param name="destCountry"></param>
        /// <param name="destProvince"></param>
        /// <param name="destCity"></param>
        /// <param name="carNo"></param>
        /// <param name="goodsNo"></param>
        /// <param name="planNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchDeliverPlansGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string customerName, string shipmentNo, string deliveryNo, string deliverType, string receiverName, string startCountry, string startProvince, string startCity, string destCountry, string destProvince, string destCity, string carNo, string goodsNo, string planNo)
        {
            //读取数据
            string strErrText;
            PlanSystem plan = new PlanSystem();
            List<DeliverPlan> listPlan = plan.LoadDeliverPlansByConditions(startTime, endTime, customerName, shipmentNo, deliveryNo, deliverType, receiverName, startCountry, startProvince, startCity, destCountry, destProvince, destCity, carNo, goodsNo, planNo, LoginAccountId, LoginStaffName, out strErrText);
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

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "DESC");
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
                              p.ReceiverCountry + p.ReceiverProvince + p.ReceiverCity + p.ReceiverAddress,
                              p.StartCity,
                              p.ReceiverCity,
                              p.PlanType,
                              p.CreateTime.ToString("yyyy-MM-dd"),
                              p.PlanState,
                              p.IsDelete.ToString(),
                              p.IsContractReversed.ToString(),
                              p.IsCustomerTransportChargesSettled.ToString(),
                              p.IsCarrierTransportChargesSettled.ToString()
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST修改发货计划备注数据
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyDeliverPlanRemark(DeliverPlanRemarkViewModel model)
        {
            if (ModelState.IsValid)
            {
                //保存数据
                string strErrText;
                PlanSystem plan = new PlanSystem();
                if (plan.UpdateDeliverPlanRemark(model.Id, model.Remark, LoginAccountId, LoginStaffName, out strErrText))
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

        #region 查看计划详细信息

        /// <summary>
        /// GET查看纸发货计划详细信息页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ViewPaperPlanDetails(string id)
        {
            ViewData["id"] = id;
            ViewData["BackTo"] = Request.UrlReferrer.AbsolutePath;

            return View();
        }

        /// <summary>
        /// GET纸发货计划详细信息页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult LoadPaperPlanDetails(string id)
        {
            string strErrText;

            //读取计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan data = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            PaperPlanViewModel model = new PaperPlanViewModel();
            model.Id = data.Id;
            model.CustomerId = data.CustomerId;
            model.CustomerName = data.CustomerName;
            model.ShipmentNo = data.ShipmentNo;
            model.DeliveryNo = data.DeliveryNo;
            model.DeliverType = data.DeliverType;
            model.ReceiverName = data.ReceiverName;
            model.ReceiverCountry = data.ReceiverCountry;
            model.ReceiverProvince = data.ReceiverProvince;
            model.ReceiverCity = data.ReceiverCity;
            model.ReceiverAddress = data.ReceiverAddress;
            model.ReceiverContact = data.ReceiverContact;
            model.ReceiverContactTel = data.ReceiverContactTel;
            model.OrderNo = data.OrderNo;
            model.ReceiveType = data.ReceiveType;
            model.CarNo = data.CarNo;
            model.TrailerNo = data.TrailerNo;
            model.DriverName = data.DriverName;
            model.DriverLicenseNo = data.DriverLicenseNo;
            model.DriverMobileTel = data.DriverMobileTel;
            model.DriverHomeTel = data.DriverHomeTel;
            model.Warehouse = data.Warehouse;
            model.ArrivalTime = data.ArrivalTime;
            model.PayerId = data.PayerId;
            model.PayerName = data.PayerName;
            model.IsConsigning = data.IsConsigning;
            model.ConsignedDeliveryNo = data.ConsignedDeliveryNo;
            model.IsInstalment = data.IsInstalment;
            model.StartCountry = data.StartCountry;
            model.StartProvince = data.StartProvince;
            model.StartCity = data.StartCity;
            model.Remark = data.Remark;
            model.CreateTime = data.CreateTime.ToString("yyyy-MM-dd");

            return PartialView("PaperPlanDetails", model);
        }

        /// <summary>
        /// GET查看罐发货计划详细信息页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ViewCanPlanDetails(string id)
        {
            ViewData["id"] = id;
            ViewData["BackTo"] = Request.UrlReferrer.AbsolutePath;

            return View();
        }

        /// <summary>
        /// GET罐发货计划详细信息页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult LoadCanPlanDetails(string id)
        {
            string strErrText;

            //读取计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan data = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            CanPlanViewModel model = new CanPlanViewModel();
            model.Id = data.Id;
            model.CustomerId = data.CustomerId;
            model.CustomerName = data.CustomerName;
            model.DeliveryNo = data.DeliveryNo;
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
            model.DriverName = data.DriverName;
            model.DriverLicenseNo = data.DriverLicenseNo;
            model.DriverMobileTel = data.DriverMobileTel;
            model.DriverHomeTel = data.DriverHomeTel;
            model.Warehouse = data.Warehouse;
            model.ArrivalTime = data.ArrivalTime;
            model.PayerName = data.PayerName;
            model.StartCountry = data.StartCountry;
            model.StartProvince = data.StartProvince;
            model.StartCity = data.StartCity;
            model.Remark = data.Remark;
            model.CreateTime = data.CreateTime.ToString("yyyy-MM-dd");

            return PartialView("CanPlanDetails", model);
        }

        /// <summary>
        /// GET查看方便面发货计划详细信息页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ViewNoodlePlanDetails(string id)
        {
            ViewData["id"] = id;
            ViewData["BackTo"] = Request.UrlReferrer.AbsolutePath;

            return View();
        }

        /// <summary>
        /// GET方便面发货计划详细信息页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult LoadNoodlePlanDetails(string id)
        {
            string strErrText;

            //读取计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan data = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            NoodlePlanViewModel model = new NoodlePlanViewModel();
            model.Id = data.Id;
            model.CustomerId = data.CustomerId;
            model.CustomerName = data.CustomerName;
            model.DeliveryNo = data.DeliveryNo;
            model.ReceiverName = data.ReceiverName;
            model.ReceiverCountry = data.ReceiverCountry;
            model.ReceiverProvince = data.ReceiverProvince;
            model.ReceiverCity = data.ReceiverCity;
            model.ReceiverAddress = data.ReceiverAddress;
            model.ReceiverContact = data.ReceiverContact;
            model.ReceiverContactTel = data.ReceiverContactTel;
            model.Warehouse = data.Warehouse;
            model.ArrivalTime = data.ArrivalTime;
            model.StartCountry = data.StartCountry;
            model.StartProvince = data.StartProvince;
            model.StartCity = data.StartCity;
            model.Remark = data.Remark;
            model.CreateTime = data.CreateTime.ToString("yyyy-MM-dd");

            return PartialView("NoodlePlanDetails", model);
        }

        /// <summary>
        /// GET查看其它发货计划详细信息页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ViewOtherPlanDetails(string id)
        {
            ViewData["id"] = id;
            ViewData["BackTo"] = Request.UrlReferrer.AbsolutePath;

            return View();
        }

        /// <summary>
        /// GET其它发货计划详细信息页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult LoadOtherPlanDetails(string id)
        {
            string strErrText;

            //读取计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan data = plan.LoadDeliverPlan(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            OtherPlanViewModel model = new OtherPlanViewModel();
            model.Id = data.Id;
            model.CustomerId = data.CustomerId;
            model.CustomerName = data.CustomerName;
            model.DeliveryNo = data.DeliveryNo;
            model.ReceiverName = data.ReceiverName;
            model.ReceiverCountry = data.ReceiverCountry;
            model.ReceiverProvince = data.ReceiverProvince;
            model.ReceiverCity = data.ReceiverCity;
            model.ReceiverAddress = data.ReceiverAddress;
            model.ReceiverContact = data.ReceiverContact;
            model.ReceiverContactTel = data.ReceiverContactTel;
            model.Warehouse = data.Warehouse;
            model.ArrivalTime = data.ArrivalTime;
            model.StartCountry = data.StartCountry;
            model.StartProvince = data.StartProvince;
            model.StartCity = data.StartCity;
            model.Remark = data.Remark;
            model.CreateTime = data.CreateTime.ToString("yyyy-MM-dd");

            return PartialView("OtherPlanDetails", model);
        }

        #endregion

    }
}
