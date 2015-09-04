using InnoSoft.LS.Business.Facades;
using InnoSoft.LS.Models;
using SYLS.Areas.chenxk.ViewModels;
using SYLS.Controllers;
using SYLS.Helper;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SYLS.Areas.chenxk.Controllers
{
    /// <summary>
    /// 发货管理控制器
    /// </summary>
    public class DeliverController : BaseController
    {
        #region 打印调度出仓单

        /// <summary>
        /// GET所有待打印调度出仓单页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult PrintDispatchedShipmentBills()
        {
            return View();
        }

        /// <summary>
        /// GET待打印调度出仓单表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPrintDispatchedShipmentBillsGrid(string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<ShipmentBill> listShipmentBill = deliver.LoadPrintDispatchedShipmentBills(LoginAccountId, LoginStaffName, out strErrText);
            if (listShipmentBill == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listShipmentBill.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CarNo") + " " + (sord ?? "ASC");
            var data = listShipmentBill.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              b.BillNo,
                              b.PlanId.ToString(),
                              b.PlanNo, 
                              b.DispatchBillId.ToString(),
                              b.DispatchBillNo,
                              b.CustomerName,
                              b.ShipmentNo,
                              b.DeliveryNo,
                              b.ReceiverName,
                              b.ReceiverCity + b.ReceiverAddress,
                              b.CarNo,
                              b.TrailerNo,
                              b.DriverName,
                              b.DriverMobileTel,
                              b.TotalPackages.ToString(),
                              b.TotalTunnages.ToString("#0.######"),
                              b.TotalPiles.ToString("#0.######"),
                              b.TotalTenThousands.ToString("#0.######")
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET待打印调度出仓单页面
        /// </summary>
        /// <param name="id">出仓单编码</param>
        /// <returns></returns>
        [Authorize]
        public ActionResult PrintDispatchedShipmentBill(string id)
        {
            string strErrText;

            ViewData["ShipmentBillId"] = id;

            //读取公司名称
            OrganizationSystem organ = new OrganizationSystem();
            List<Organization> listOrgan = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrgan == null)
            {
                throw new Exception(strErrText);
            }
            Organization root = listOrgan.Find(delegate(Organization o) { return o.ParentId == 0; });
            ViewData["CompanyName"] = root.Name;

            //读取出仓单数据
            DeliverSystem deliver = new DeliverSystem();
            ShipmentBill bill = deliver.LoadShipmentBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (bill == null)
            {
                throw new Exception(strErrText);
            }

            List<ShipmentBillGoods> listGoods = deliver.LoadShipmentBillAllGoods(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                throw new Exception(strErrText);
            }

            //读取发货计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan deliverPlan = plan.LoadDeliverPlan(bill.PlanId, LoginAccountId, LoginStaffName, out strErrText);
            if (deliverPlan == null)
            {
                throw new Exception(strErrText);
            }

            //生成Model
            PrintShipmentBillViewModel model = new PrintShipmentBillViewModel();
            model.bills = new List<ShipmentBillViewModel>();

            ShipmentBillViewModel modelBill = new ShipmentBillViewModel();
            modelBill.BillNo = bill.BillNo;
            modelBill.PlanNo = bill.PlanNo;
            modelBill.PlanType = bill.PlanType;
            modelBill.CustomerName = bill.CustomerName;
            modelBill.PayerName = bill.PayerName;
            modelBill.DeliveryNo = bill.DeliveryNo;
            modelBill.OutType = bill.OutType;
            modelBill.ReceiverName = bill.ReceiverName;
            modelBill.ReceiverCountry = bill.ReceiverCountry;
            modelBill.ReceiverProvince = bill.ReceiverProvince;
            modelBill.ReceiverCity = bill.ReceiverCity;
            modelBill.ReceiverAddress = bill.ReceiverAddress;
            modelBill.ReceiverContact = bill.ReceiverContact;
            modelBill.ReceiverContactTel = bill.ReceiverContactTel;
            modelBill.OrderNo = bill.OrderNo;
            modelBill.ReceiveType = bill.ReceiveType;
            modelBill.CarNo = bill.CarNo;
            modelBill.TrailerNo = bill.TrailerNo;
            modelBill.Warehouse = bill.Warehouse;
            modelBill.TotalPackages = bill.TotalPackages;
            modelBill.TotalTunnages = bill.TotalTunnages;
            modelBill.TotalPiles = bill.TotalPiles;
            modelBill.TotalTenThousands = bill.TotalTenThousands;
            modelBill.Remark = bill.Remark;
            modelBill.CreateTime = bill.CreateTime.ToString("yyyy-MM-dd");
            modelBill.CreatorName = deliverPlan.CreatorName;

            modelBill.Goods = new List<ShipmentBillGoodsViewModel>();
            foreach (ShipmentBillGoods goods in listGoods)
            {
                ShipmentBillGoodsViewModel modelGoods = new ShipmentBillGoodsViewModel();
                modelGoods.GoodsName = goods.GoodsName;
                modelGoods.GoodsNo = goods.GoodsNo;
                modelGoods.SpecModel = goods.SpecModel;
                modelGoods.GWeight = goods.GWeight;
                modelGoods.Grade = goods.Grade;
                modelGoods.PieceWeight = goods.PieceWeight;
                modelGoods.Packing = goods.Packing;
                modelGoods.BatchNo = goods.BatchNo;
                modelGoods.Location = goods.Location;
                modelGoods.Packages = goods.Packages;
                modelGoods.Tunnages = goods.Tunnages;
                modelGoods.Piles = goods.Piles;
                modelGoods.TenThousands = goods.TenThousands;

                modelBill.Goods.Add(modelGoods);
            }

            model.bills.Add(modelBill);

            return View(model);
        }

        /// <summary>
        /// POST提交待打印出仓单
        /// </summary>
        /// <param name="id">出仓单编码</param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult SubmitPrintShipmentBill(string id)
        {
            string strErrText;
            long nOutWarehouseBillId = 0;
            long nEnterWarehouseBillId = 0;
            DeliverSystem deliver = new DeliverSystem();
            bool bSuccess = deliver.SubmitPrintShipmentBill(long.Parse(id), out nOutWarehouseBillId, out nEnterWarehouseBillId, LoginAccountId, LoginStaffName, out strErrText);
            var ret = new
            {
                Success = bSuccess,
                ErrorMessage = strErrText,
                OutWarehouseBillId = nOutWarehouseBillId,
                EnterWarehouseBillId = nEnterWarehouseBillId
            };
            return Json(ret);
        }

        #endregion

        #region 打印划拨出仓单

        /// <summary>
        /// GET所有待打印划拨出仓单页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult PrintAllocateShipmentBills()
        {
            return View();
        }

        /// <summary>
        /// GET待打印划拨出仓单表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPrintAllocateShipmentBillsGrid(string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<ShipmentBill> listShipmentBill = deliver.LoadPrintAllocateShipmentBills(LoginAccountId, LoginStaffName, out strErrText);
            if (listShipmentBill == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listShipmentBill.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "BillNo") + " " + (sord ?? "ASC");
            var data = listShipmentBill.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              p.BillNo,
                              p.PlanNo, 
                              p.CustomerName,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.TotalPackages.ToString(),
                              p.TotalTunnages.ToString("#0.######")
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET出仓单货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="shipmentBillId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadShipmentBillAllGoodsGrid(string sidx, string sord, int page, int rows, string shipmentBillId)
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<ShipmentBillGoods> listGoods = deliver.LoadShipmentBillAllGoods(long.Parse(shipmentBillId), LoginAccountId, LoginStaffName, out strErrText);
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
                              g.Warehouse,
                              g.Location,
                              g.Packages.ToString(),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              g.Piles.ToString("#0.######"),
                              g.TenThousands.ToString("#0.######"),
                              g.ProductionDate,
                              g.EnterWarehouseBillId.ToString(),
                              g.EnterWarehouseBillNo,
                              g.Location,
                              g.Packages.ToString(),
                              g.Tunnages.ToString("#0.######"),
                              g.Piles.ToString("#0.######"),
                              g.TenThousands.ToString("#0.######")
                          }
                      }).ToArray(),
                userdata = new
                {
                    GoodsNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands),
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET待打印划拨出仓单页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult PrintAllocateShipmentBill(string id)
        {
            string strErrText;

            ViewData["ShipmentBillId"] = id;

            //读取公司名称
            OrganizationSystem organ = new OrganizationSystem();
            List<Organization> listOrgan = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrgan == null)
            {
                throw new Exception(strErrText);
            }
            Organization root = listOrgan.Find(delegate(Organization o) { return o.ParentId == 0; });
            ViewData["CompanyName"] = root.Name;

            //读取出仓单数据
            DeliverSystem deliver = new DeliverSystem();
            ShipmentBill bill = deliver.LoadShipmentBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (bill == null)
            {
                throw new Exception(strErrText);
            }

            List<ShipmentBillGoods> listGoods = deliver.LoadShipmentBillAllGoods(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                throw new Exception(strErrText);
            }

            //生成Model
            PrintShipmentBillViewModel model = new PrintShipmentBillViewModel();
            model.bills = new List<ShipmentBillViewModel>();

            ShipmentBillViewModel modelBill = new ShipmentBillViewModel();
            modelBill.BillNo = bill.BillNo;
            modelBill.PlanNo = bill.PlanNo;
            modelBill.CustomerName = bill.CustomerName;
            modelBill.PayerName = bill.PayerName;
            modelBill.DeliveryNo = bill.DeliveryNo;
            modelBill.OutType = bill.OutType;
            modelBill.ReceiverName = bill.ReceiverName;
            modelBill.ReceiverCountry = bill.ReceiverCountry;
            modelBill.ReceiverProvince = bill.ReceiverProvince;
            modelBill.ReceiverCity = bill.ReceiverCity;
            modelBill.ReceiverAddress = bill.ReceiverAddress;
            modelBill.ReceiverContact = bill.ReceiverContact;
            modelBill.ReceiverContactTel = bill.ReceiverContactTel;
            modelBill.OrderNo = bill.OrderNo;
            modelBill.ReceiveType = bill.ReceiveType;
            modelBill.CarNo = bill.CarNo;
            modelBill.TrailerNo = bill.TrailerNo;
            modelBill.Warehouse = bill.Warehouse;
            modelBill.TotalPackages = bill.TotalPackages;
            modelBill.TotalTunnages = bill.TotalTunnages;
            modelBill.Remark = bill.Remark;
            modelBill.CreateTime = bill.CreateTime.ToString("yyyy-MM-dd");

            modelBill.Goods = new List<ShipmentBillGoodsViewModel>();
            foreach (ShipmentBillGoods goods in listGoods)
            {
                ShipmentBillGoodsViewModel modelGoods = new ShipmentBillGoodsViewModel();
                modelGoods.GoodsName = goods.GoodsName;
                modelGoods.GoodsNo = goods.GoodsNo;
                modelGoods.SpecModel = goods.SpecModel;
                modelGoods.GWeight = goods.GWeight;
                modelGoods.Grade = goods.Grade;
                modelGoods.PieceWeight = goods.PieceWeight;
                modelGoods.Packing = goods.Packing;
                modelGoods.BatchNo = goods.BatchNo;
                modelGoods.Location = goods.Location;
                modelGoods.Packages = goods.Packages;
                modelGoods.Tunnages = goods.Tunnages;

                modelBill.Goods.Add(modelGoods);
            }

            model.bills.Add(modelBill);

            return View(model);
        }

        #endregion

        #region 提交出仓单

        /// <summary>
        /// GET待提交出仓单页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SubmitShipmentBills()
        {
            return View();
        }

        /// <summary>
        /// GET待提交出仓单表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="carNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSubmitShipmentBillsGrid(string sidx, string sord, int page, int rows, string carNo)
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<ShipmentBill> listShipmentBill = deliver.LoadSubmitShipmentBills(LoginAccountId, LoginStaffName, out strErrText);
            if (listShipmentBill == null)
            {
                throw new Exception(strErrText);
            }

            if (carNo != null && carNo != string.Empty)
            {
                listShipmentBill = listShipmentBill.FindAll(delegate(ShipmentBill b) { return b.CarNo == carNo; });
            }

            //提取当前页面数据
            int nTotalRows = listShipmentBill.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "BillNo") + " " + (sord ?? "ASC");
            var data = listShipmentBill.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              p.BillNo,
                              p.CustomerName,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.CarNo,
                              p.TrailerNo,
                              p.TotalPackages.ToString(),
                              p.TotalTunnages.ToString("#0.######"),
                              p.TotalPiles.ToString("#0.######"),
                              p.TotalTenThousands.ToString("#0.######")
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET待提交出仓单车号数据
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSubmitShipmentBillsCarNo()
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<ShipmentBill> listShipmentBill = deliver.LoadSubmitShipmentBills(LoginAccountId, LoginStaffName, out strErrText);
            if (listShipmentBill == null)
            {
                throw new Exception(strErrText);
            }

            var ret = (from b in listShipmentBill
                       where b.CarNo != null && b.CarNo != string.Empty
                       select b.CarNo).Distinct();

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET修改出仓单页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyShipmentBill(string id)
        {
            string strErrText;

            //读取出仓单数据
            DeliverSystem deliver = new DeliverSystem();
            ShipmentBill shipmentBill = deliver.LoadShipmentBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (shipmentBill == null)
            {
                throw new Exception(strErrText);
            }

            //读取发货计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan deliverPlan = plan.LoadDeliverPlan(shipmentBill.PlanId, LoginAccountId, LoginStaffName, out strErrText);
            if (deliverPlan == null)
            {
                throw new Exception(strErrText);
            }

            //生成Model
            ShipmentBillViewModel model = new ShipmentBillViewModel();
            if (shipmentBill.OutType == InnoSoft.LS.Resources.Options.DeliverGoods)
            {
                //读取调度数据
                DispatchSystem dispatch = new DispatchSystem();
                DispatchBill dispatchBill = dispatch.LoadDispatchBill(shipmentBill.DispatchBillId, LoginAccountId, LoginStaffName, out strErrText);
                if (dispatchBill == null)
                {
                    throw new Exception(strErrText);
                }

                DispatchBillDeliverPlan dispatchBillDeliverPlan = dispatch.LoadDispatchBillDeliverPlan(shipmentBill.DispatchBillId, shipmentBill.PlanId, LoginAccountId, LoginStaffName, out strErrText);
                if (dispatchBillDeliverPlan == null)
                {
                    throw new Exception(strErrText);
                }

                //读取协议价格
                decimal decAgreementTransportPrice = 0;
                DDSystem dd = new DDSystem();
                CarrierTransportPrice price = dd.LoadCarrierTransportPrice(dispatchBill.CarrierId, deliverPlan.StartCountry, deliverPlan.StartProvince, deliverPlan.StartCity, deliverPlan.ReceiverCountry, deliverPlan.ReceiverProvince, deliverPlan.ReceiverCity, deliverPlan.PlanType, deliverPlan.CreateTime, LoginAccountId, LoginStaffName, out strErrText);
                if (price != null)
                {
                    decAgreementTransportPrice = price.TransportPrice;
                }

                model.TransportChargeExpression = dispatchBillDeliverPlan.TransportChargeExpression;
                model.TransportPriceExpression = dispatchBillDeliverPlan.TransportPriceExpression;
                model.AgreementTransportPrice = decAgreementTransportPrice;
                model.ActualTransportPrice = dispatchBillDeliverPlan.TransportPrice;
                model.TransportCharges = dispatchBillDeliverPlan.TransportCharges;
            }

            //缓存出仓单编码和发货计划编码
            ViewData["ShipmentBillId"] = id;
            ViewData["CustomerId"] = shipmentBill.CustomerId;
            ViewData["PlanId"] = shipmentBill.PlanId;
            ViewData["ConsignedDeliveryNo"] = deliverPlan.ConsignedDeliveryNo;

            return View(model);
        }

        /// <summary>
        /// POST修改出仓单
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyShipmentBill(ShipmentBillViewModel model)
        {
            List<ShipmentBillGoods> listGoods = new List<ShipmentBillGoods>();
            foreach (ShipmentBillGoodsViewModel m in model.Goods)
            {
                ShipmentBillGoods g = new ShipmentBillGoods();
                g.Id = m.Id;
                g.ShipmentBillId = m.ShipmentBillId;
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
                g.EnterWarehouseBillNo = m.EnterWarehouseBillNo;
                listGoods.Add(g);
            }

            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            if (deliver.UpdateShipmentBill(model.Id, model.TransportCharges, listGoods, LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// GET打印出仓单页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult PrintShipmentBill(string id)
        {
            string strErrText;

            ViewData["ShipmentBillId"] = id;

            //读取公司名称
            OrganizationSystem organ = new OrganizationSystem();
            List<Organization> listOrgan = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrgan == null)
            {
                throw new Exception(strErrText);
            }
            Organization root = listOrgan.Find(delegate(Organization o) { return o.ParentId == 0; });
            ViewData["CompanyName"] = root.Name;

            //读取出仓单数据
            DeliverSystem deliver = new DeliverSystem();
            ShipmentBill bill = deliver.LoadShipmentBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (bill == null)
            {
                throw new Exception(strErrText);
            }

            List<ShipmentBillGoods> listGoods = deliver.LoadShipmentBillAllGoods(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                throw new Exception(strErrText);
            }

            //读取发货计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan deliverPlan = plan.LoadDeliverPlan(bill.PlanId, LoginAccountId, LoginStaffName, out strErrText);
            if (deliverPlan == null)
            {
                throw new Exception(strErrText);
            }

            //生成Model
            PrintShipmentBillViewModel model = new PrintShipmentBillViewModel();
            model.bills = new List<ShipmentBillViewModel>();

            ShipmentBillViewModel modelBill = new ShipmentBillViewModel();
            modelBill.BillNo = bill.BillNo;
            modelBill.PlanNo = bill.PlanNo;
            modelBill.PlanType = bill.PlanType;
            modelBill.CustomerName = bill.CustomerName;
            modelBill.DeliveryNo = bill.DeliveryNo;
            modelBill.OutType = bill.OutType;
            modelBill.ReceiverName = bill.ReceiverName;
            modelBill.ReceiverCountry = bill.ReceiverCountry;
            modelBill.ReceiverProvince = bill.ReceiverProvince;
            modelBill.ReceiverCity = bill.ReceiverCity;
            modelBill.ReceiverAddress = bill.ReceiverAddress;
            modelBill.ReceiverContact = bill.ReceiverContact;
            modelBill.ReceiverContactTel = bill.ReceiverContactTel;
            modelBill.ReceiveType = bill.ReceiveType;
            modelBill.CarNo = bill.CarNo;
            modelBill.TrailerNo = bill.TrailerNo;
            modelBill.Warehouse = bill.Warehouse;
            modelBill.TotalPackages = bill.TotalPackages;
            modelBill.TotalTunnages = bill.TotalTunnages;
            modelBill.TotalPiles = bill.TotalPiles;
            modelBill.TotalTenThousands = bill.TotalTenThousands;
            modelBill.CreatorName = deliverPlan.CreatorName;

            modelBill.Goods = new List<ShipmentBillGoodsViewModel>();
            foreach (ShipmentBillGoods goods in listGoods)
            {
                ShipmentBillGoodsViewModel modelGoods = new ShipmentBillGoodsViewModel();
                modelGoods.GoodsName = goods.GoodsName;
                modelGoods.GoodsNo = goods.GoodsNo;
                modelGoods.SpecModel = goods.SpecModel;
                modelGoods.GWeight = goods.GWeight;
                modelGoods.Grade = goods.Grade;
                modelGoods.PieceWeight = goods.PieceWeight;
                modelGoods.Packing = goods.Packing;
                modelGoods.BatchNo = goods.BatchNo;
                modelGoods.Location = goods.Location;
                modelGoods.Packages = goods.Packages;
                modelGoods.Tunnages = goods.Tunnages;
                modelGoods.Piles = goods.Piles;
                modelGoods.TenThousands = goods.TenThousands;

                modelBill.Goods.Add(modelGoods);
            }

            model.bills.Add(modelBill);

            return View(model);
        }

        /// <summary>
        /// POST取消出仓单
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult CancelShipmentBill(string id)
        {
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            if (deliver.CancelShipmentBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// POST提交出仓单
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult SubmitShipmentBill(string id)
        {
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            if (deliver.SubmitShipmentBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 打印送货单

        /// <summary>
        /// GET打印送货单页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult PrintDeliverBills()
        {
            return View();
        }

        /// <summary>
        /// GET待打印送货单表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="carNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPrintDeliverBillsGrid(string sidx, string sord, int page, int rows, string carNo)
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<DeliverBill> listDeliverBill = deliver.LoadPrintDeliverBills(LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverBill == null)
            {
                throw new Exception(strErrText);
            }

            if (carNo != null && carNo != string.Empty)
            {
                listDeliverBill = listDeliverBill.FindAll(delegate(DeliverBill b) { return b.CarNo == carNo; });
            }

            //提取当前页面数据
            int nTotalRows = listDeliverBill.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "BillNo") + " " + (sord ?? "ASC");
            var data = listDeliverBill.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              b.BillNo,
                              b.CustomerName,
                              b.DeliveryNo,
                              b.ReceiverName,
                              b.ReceiverCity,
                              b.CarNo,
                              b.TrailerNo,
                              b.TotalPackages.ToString(),
                              b.TotalTunnages.ToString("#0.######"),
                              b.TotalPiles.ToString("#0.######"),
                              b.TotalTenThousands.ToString("#0.######")
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET送货单货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="deliverBillId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDeliverBillAllGoodsGrid(string sidx, string sord, int page, int rows, string deliverBillId)
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<DeliverBillGoods> listGoods = deliver.LoadDeliverBillAllGoods(long.Parse(deliverBillId), LoginAccountId, LoginStaffName, out strErrText);
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
                              g.Warehouse,
                              g.Location,
                              g.Packages.ToString(),
                              g.PieceWeight.ToString("#0.######"),
                              g.Tunnages.ToString("#0.######"),
                              g.Piles.ToString("#0.######"),
                              g.TenThousands.ToString("#0.######"),
                              g.ProductionDate,
                              g.EnterWarehouseBillId.ToString(),
                              g.EnterWarehouseBillNo,
                              g.Packages.ToString(),
                              g.Tunnages.ToString("#0.######"),
                              g.Piles.ToString("#0.######"),
                              g.TenThousands.ToString("#0.######")
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
        /// GET待打印送货单车号数据
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPrintDeliverBillsCarNo()
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<DeliverBill> listDeliverBill = deliver.LoadPrintDeliverBills(LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverBill == null)
            {
                throw new Exception(strErrText);
            }

            var ret = (from b in listDeliverBill
                       where b.CarNo != null && b.CarNo != string.Empty
                       select b.CarNo).Distinct();

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET修改送货单页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyDeliverBill(string id)
        {
            string strErrText;

            //读取送货单数据
            DeliverSystem deliver = new DeliverSystem();
            DeliverBill deliverBill = deliver.LoadDeliverBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (deliverBill == null)
            {
                throw new Exception(strErrText);
            }

            //读取发货计划数据
            PlanSystem plan = new PlanSystem();
            DeliverPlan deliverPlan = plan.LoadDeliverPlan(deliverBill.PlanId, LoginAccountId, LoginStaffName, out strErrText);
            if (deliverPlan == null)
            {
                throw new Exception(strErrText);
            }

            //读取调度数据
            DispatchSystem dispatch = new DispatchSystem();
            DispatchBill dispatchBill = dispatch.LoadDispatchBill(deliverBill.DispatchBillId, LoginAccountId, LoginStaffName, out strErrText);
            if (dispatchBill == null)
            {
                throw new Exception(strErrText);
            }

            DispatchBillDeliverPlan dispatchBillDeliverPlan = dispatch.LoadDispatchBillDeliverPlan(deliverBill.DispatchBillId, deliverBill.PlanId, LoginAccountId, LoginStaffName, out strErrText);
            if (dispatchBillDeliverPlan == null)
            {
                throw new Exception(strErrText);
            }

            //读取协议价格
            DDSystem dd = new DDSystem();
            CarrierTransportPrice price = dd.LoadCarrierTransportPrice(dispatchBill.CarrierId, deliverPlan.StartCountry, deliverPlan.StartProvince, deliverPlan.StartCity, deliverPlan.ReceiverCountry, deliverPlan.ReceiverProvince, deliverPlan.ReceiverCity, deliverPlan.PlanType, deliverPlan.CreateTime, LoginAccountId, LoginStaffName, out strErrText);
            if (price == null)
            {
                throw new Exception(string.Format(InnoSoft.LS.Resources.Strings.LoadCarrierTransportPriceFaild, dispatchBill.CarrierName, deliverPlan.StartProvince + deliverPlan.StartCity, deliverPlan.ReceiverProvince + deliverPlan.ReceiverCity, deliverPlan.PlanType));
            }

            //生成Model
            DeliverBillViewModel model = new DeliverBillViewModel();
            model.TransportChargeExpression = dispatchBillDeliverPlan.TransportChargeExpression;
            model.TransportPriceExpression = dispatchBillDeliverPlan.TransportPriceExpression;
            model.AgreementTransportPrice = price.TransportPrice;
            model.ActualTransportPrice = dispatchBillDeliverPlan.TransportPrice;
            model.TransportCharges = dispatchBillDeliverPlan.TransportCharges;

            //缓存送货单编码和发货计划编码
            ViewData["DeliverBillId"] = id;
            ViewData["CustomerId"] = deliverBill.CustomerId;
            ViewData["PlanId"] = deliverBill.PlanId;
            ViewData["ConsignedDeliveryNo"] = deliverPlan.ConsignedDeliveryNo;

            return View(model);
        }

        /// <summary>
        /// POST修改送货单
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyDeliverBill(DeliverBillViewModel model)
        {
            List<DeliverBillGoods> listGoods = new List<DeliverBillGoods>();
            foreach (DeliverBillGoodsViewModel m in model.Goods)
            {
                DeliverBillGoods g = new DeliverBillGoods();
                g.Id = m.Id;
                g.DeliverBillId = m.DeliverBillId;
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
                g.EnterWarehouseBillNo = m.EnterWarehouseBillNo;
                listGoods.Add(g);
            }

            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            if (deliver.UpdateDeliverBill(model.Id, model.TransportCharges, listGoods, LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// POST取消送货单
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult CancelDeliverBill(string id)
        {
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            if (deliver.CancelDeliverBill(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// GET打印送货单页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult PrintDeliverBill(string id)
        {
            string strErrText;

            ViewData["DeliverBillId"] = id;

            //读取公司名称
            OrganizationSystem organ = new OrganizationSystem();
            List<Organization> listOrgan = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrgan == null)
            {
                throw new Exception(strErrText);
            }
            Organization root = listOrgan.Find(delegate(Organization o) { return o.ParentId == 0; });
            ViewData["CompanyName"] = root.Name;

            //读取送货单数据
            DeliverSystem deliver = new DeliverSystem();
            List<DeliverBill> listDeliverBill = deliver.LoadPrintDeliverBills(LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverBill == null)
            {
                throw new Exception(strErrText);
            }
            listDeliverBill = listDeliverBill.FindAll(delegate(DeliverBill b) { return b.Id == long.Parse(id); });

            //生成Model
            PrintDeliverBillViewModel model = new PrintDeliverBillViewModel();
            model.bills = new List<DeliverBillViewModel>();
            foreach (DeliverBill bill in listDeliverBill)
            {
                DeliverBillViewModel billVM = new DeliverBillViewModel();
                billVM.Id = bill.Id;
                billVM.BillNo = bill.BillNo;
                billVM.PlanType = bill.PlanType;
                billVM.CustomerName = bill.CustomerName;
                billVM.ReceiverName = bill.ReceiverName;
                billVM.ReceiverCountry = bill.ReceiverCountry;
                billVM.ReceiverProvince = bill.ReceiverProvince;
                billVM.ReceiverCity = bill.ReceiverCity;
                billVM.ReceiverAddress = bill.ReceiverAddress;
                billVM.ReceiverContact = bill.ReceiverContact;
                billVM.ReceiverContactTel = bill.ReceiverContactTel;
                billVM.ReceiveType = bill.ReceiveType;
                billVM.OrderNo = bill.OrderNo;
                billVM.CarNo = bill.CarNo;
                billVM.TrailerNo = bill.TrailerNo;
                billVM.CreateTime = bill.CreateTime;
                billVM.TotalPackages = bill.TotalPackages;
                billVM.TotalTunnages = bill.TotalTunnages;
                billVM.TotalPiles = bill.TotalPiles;
                billVM.TotalTenThousands = bill.TotalTenThousands;
                billVM.Remark = bill.Remark;
                billVM.Goods = new List<DeliverBillGoodsViewModel>();
                model.bills.Add(billVM);

                //读取送货单货物数据
                List<DeliverBillGoods> listGoods = deliver.LoadDeliverBillAllGoods(bill.Id, LoginAccountId, LoginStaffName, out strErrText);
                if (listGoods == null)
                {
                    throw new Exception(strErrText);
                }
                foreach (DeliverBillGoods goods in listGoods)
                {
                    DeliverBillGoodsViewModel goodsVM = new DeliverBillGoodsViewModel();
                    goodsVM.GoodsName = goods.GoodsName;
                    goodsVM.GoodsNo = goods.GoodsNo;
                    goodsVM.SpecModel = goods.SpecModel;
                    goodsVM.GWeight = goods.GWeight;
                    goodsVM.Grade = goods.Grade;
                    goodsVM.PieceWeight = goods.PieceWeight;
                    goodsVM.Packing = goods.Packing;
                    goodsVM.BatchNo = goods.BatchNo;
                    goodsVM.Packages = goods.Packages;
                    goodsVM.Tunnages = goods.Tunnages;
                    goodsVM.Piles = goods.Piles;
                    goodsVM.TenThousands = goods.TenThousands;

                    billVM.Goods.Add(goodsVM);
                }
            }

            return View(model);
        }

        /// <summary>
        /// POST提交待打印送货单
        /// </summary>
        /// <param name="id">车号</param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult SubmitPrintDeliverBill(string id)
        {
            string strMessage;
            DeliverSystem deliver = new DeliverSystem();
            bool bSuccess = deliver.SubmitPrintDeliverBill(long.Parse(id), LoginAccountId, LoginStaffName, out strMessage);

            var ret = new
            {
                Success = bSuccess,
                Message = strMessage
            };
            return Json(ret);
        }

        #endregion

        #region 查询送货单

        /// <summary>
        /// GET查询送货单页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchDeliverBills()
        {
            return View();
        }

        /// <summary>
        /// GET送货单表格JSON数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="customerName"></param>
        /// <param name="deliveryNo"></param>
        /// <param name="carNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchDeliverBillsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string customerName, string deliveryNo, string carNo)
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<DeliverBill> listDeliverBill = deliver.LoadDeliverBillsByConditions(startTime, endTime, string.Empty, customerName, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, carNo, deliveryNo, string.Empty, "1", LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverBill == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listDeliverBill.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listDeliverBill.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              b.CreateTime.ToString("yyyy-MM-dd"),
                              b.DeliveryNo,
                              b.CarNo,
                              b.CustomerName,
                              b.ReceiverName,
                              b.ReceiverProvince + b.ReceiverCity + b.ReceiverAddress,
                              b.TotalPackages.ToString(),
                              b.TotalTunnages.ToString("#0.######"),
                              b.TotalPiles.ToString("#0.######"),
                              b.TotalTenThousands.ToString("#0.######"),
                              b.ContractNo,
                              b.OriginalContractNo,
                              b.TransportCharges.ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    CreateTime = InnoSoft.LS.Resources.Labels.Total,
                    TotalPackages = data.Sum(s => s.TotalPackages),
                    TotalTunnages = data.Sum(s => s.TotalTunnages),
                    TotalPiles = data.Sum(s => s.TotalPiles),
                    TotalTenThousands = data.Sum(s => s.TotalTenThousands),
                    TransportCharges = data.Sum(s => s.TransportCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET导出送货单
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportDeliverBills()
        {
            string strErrText;

            //提取查询条件
            var request = HttpContext.Request;
            string strStartTime = request.QueryString["startTime"] ?? string.Empty;
            string strEndTime = request.QueryString["endTime"] ?? string.Empty;
            string strCustomerName = request.QueryString["customerName"] ?? string.Empty;
            string strDeliveryNo = request.QueryString["deliveryNo"] ?? string.Empty;
            string strCarNo = request.QueryString["carNo"] ?? string.Empty;

            //读取回单数据
            DeliverSystem deliver = new DeliverSystem();
            List<DeliverBill> listDeliverBill = deliver.LoadDeliverBillsByConditions(strStartTime, strEndTime, string.Empty, strCustomerName, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, strCarNo, strDeliveryNo, string.Empty, "1", LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverBill == null)
            {
                throw new Exception(strErrText);
            }

            //生成GridView
            BoundField colCreateTime = new BoundField();
            colCreateTime.HeaderText = InnoSoft.LS.Resources.Labels.DeliverDate;
            colCreateTime.DataField = "CreateTime";

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

            BoundField colContractNo = new BoundField();
            colContractNo.HeaderText = InnoSoft.LS.Resources.Labels.ContractNo;
            colContractNo.DataField = "ContractNo";

            BoundField colOriginalContractNo = new BoundField();
            colOriginalContractNo.HeaderText = InnoSoft.LS.Resources.Labels.OriginalContractNo;
            colOriginalContractNo.DataField = "OriginalContractNo";

            BoundField colTransportCharges = new BoundField();
            colTransportCharges.HeaderText = InnoSoft.LS.Resources.Labels.TransportCharges;
            colTransportCharges.DataField = "TransportCharges";

            var grid = new GridView();
            grid.Columns.Add(colCreateTime);
            grid.Columns.Add(colDeliveryNo);
            grid.Columns.Add(colCarNo);
            grid.Columns.Add(colCustomerName);
            grid.Columns.Add(colReceiverName);
            grid.Columns.Add(colReceiverAddress);
            grid.Columns.Add(colTotalPackages);
            grid.Columns.Add(colTotalTunnages);
            grid.Columns.Add(colTotalPiles);
            grid.Columns.Add(colTotalTenThousands);
            grid.Columns.Add(colContractNo);
            grid.Columns.Add(colOriginalContractNo);
            grid.Columns.Add(colTransportCharges);

            grid.AutoGenerateColumns = false;

            grid.RowDataBound += new GridViewRowEventHandler(SearchDeliverBillsGrid_RowDataBound);
            grid.DataSource = from bill in listDeliverBill
                              select new
                              {
                                  CreateTime = bill.CreateTime.ToString("yyyy-MM-dd"),
                                  DeliveryNo = bill.DeliveryNo,
                                  CarNo = bill.CarNo,
                                  CustomerName = bill.CustomerName,
                                  ReceiverName = bill.ReceiverName,
                                  ReceiverAddress = bill.ReceiverProvince + bill.ReceiverCity + bill.ReceiverAddress,
                                  TotalPackages = bill.TotalPackages > 0 ? bill.TotalPackages.ToString() : string.Empty,
                                  TotalTunnages = bill.TotalTunnages > 0 ? bill.TotalTunnages.ToString("#0.######") : string.Empty,
                                  TotalPiles = bill.TotalPiles > 0 ? bill.TotalPiles.ToString("#0.######") : string.Empty,
                                  TotalTenThousands = bill.TotalTenThousands > 0 ? bill.TotalTenThousands.ToString("#0.######") : string.Empty,
                                  ContractNo = bill.ContractNo,
                                  OriginalContractNo = bill.OriginalContractNo,
                                  TransportCharges = bill.TransportCharges.ToString("N2")
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=DeliverBills.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(@"<style> .text { mso-number-format:'\@'; } </style>");//定义字符串转换样式
            Response.Write(sw.ToString());
            Response.End();

            return View("SearchDeliverBills");
        }

        private void SearchDeliverBillsGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[1].Attributes.Add("class", "text");//防止交货单号被自动转换为整形
                e.Row.Cells[11].Attributes.Add("class", "text");//防止原始合同号被自动转换为整形
            }
        }

        #endregion

        #region 接收送货单回单

        /// <summary>
        /// GET接收送货单回单页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ReceiptDeliverBills()
        {
            return View();
        }

        /// <summary>
        /// GET待接收回单送货单表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="customerName"></param>
        /// <param name="carNo"></param>
        /// <param name="deliveryNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadReceiptDeliverBillsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string customerName, string carNo, string deliveryNo)
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<DeliverBill> listDeliverBill = deliver.LoadReceiptDeliverBillsByConditions(startTime, endTime, customerName, carNo, deliveryNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverBill == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listDeliverBill.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listDeliverBill.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              b.CreateTime.ToString("yyyy-MM-dd"),
                              b.BillNo,
                              b.CustomerName,
                              b.DeliveryNo,
                              b.ReceiverName,
                              b.CarNo,
                              b.TrailerNo,
                              b.TotalPackages.ToString(),
                              b.TotalTunnages.ToString("#0.######"),
                              b.TotalPiles.ToString("#0.######"),
                              b.TotalTenThousands.ToString("#0.######")
                          }
                      }).ToArray(),
                userdata = new
                {
                    CreateTime = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.TotalPackages),
                    Tunnages = data.Sum(s => s.TotalTunnages),
                    Piles = data.Sum(s => s.TotalPiles),
                    TenThousands = data.Sum(s => s.TotalTenThousands)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST保存送货单回单信息
        /// </summary>
        /// <param name="ids"></param>
        /// <param name="returnTime"></param>
        /// <param name="damageInfo"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ReceiptDeliverBill(string ids, string returnTime, string damageInfo)
        {
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            foreach (string id in ids.Split(','))
            {
                if (!deliver.UpdateDeliverBillReceipt(long.Parse(id), DateTime.Parse(returnTime), damageInfo, LoginAccountId, LoginStaffName, out strErrText))
                {
                    return Json(strErrText);
                }
            }
            return Json(string.Empty);
        }

        #endregion

        #region 查询送货单回单

        /// <summary>
        /// GET查询送货单回单页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchDeliverBillReceipts()
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
        /// GET查询送货单回单表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="customerName"></param>
        /// <param name="deliveryNo"></param>
        /// <param name="carNo"></param>
        /// <param name="destCountry"></param>
        /// <param name="destProvince"></param>
        /// <param name="destCity"></param>
        /// <param name="organId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchDeliverBillReceiptsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string customerName, string deliveryNo,
            string carNo, string destCountry, string destProvince, string destCity, string organId)
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<DeliverBill> listDeliverBill = deliver.LoadDeliverBillReceiptsByConditions(startTime, endTime, customerName, deliveryNo, carNo, destCountry,
                destProvince, destCity, organId, LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverBill == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listDeliverBill.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "BillNo") + " " + (sord ?? "ASC");
            var data = listDeliverBill.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              b.BillNo,
                              b.CreateTime.ToString("yyyy-MM-dd"),
                              b.CustomerName,
                              b.DeliveryNo,
                              b.ReceiverCity,
                              b.ReceiverName,
                              b.CarNo,
                              b.TotalPackages.ToString(),
                              b.TotalTunnages.ToString("#0.######"),
                              b.TotalPiles.ToString("#0.######"),
                              b.TotalTenThousands.ToString("#0.######"),
                              b.ReturnTime.ToString("yyyy-MM-dd"),
                              b.DamageInfo
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 导出送货单回单数据
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportDeliverBillReceipts()
        {
            string strErrText;

            //提取查询条件
            var request = HttpContext.Request;
            string strStartTime = request.QueryString["startTime"] ?? string.Empty;
            string strEndTime = request.QueryString["endTime"] ?? string.Empty;
            string strCustomerName = request.QueryString["customerName"] ?? string.Empty;
            string strDeliveryNo = request.QueryString["deliveryNo"] ?? string.Empty;
            string strCarNo = request.QueryString["carNo"] ?? string.Empty;
            string strDestCountry = request.QueryString["destCountry"] ?? string.Empty;
            string strDestProvince = request.QueryString["destProvince"] ?? string.Empty;
            string strDestCity = request.QueryString["destCity"] ?? string.Empty;
            string strOrganId = request.QueryString["organId"] ?? string.Empty;

            //读取回单数据
            DeliverSystem deliver = new DeliverSystem();
            List<DeliverBill> listDeliverBill = deliver.LoadDeliverBillReceiptsByConditions(strStartTime, strEndTime, strCustomerName, strDeliveryNo, strCarNo,
                strDestCountry, strDestProvince, strDestCity, strOrganId, LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverBill == null)
            {
                throw new Exception(strErrText);
            }

            //生成GridView
            BoundField colDeliverBillNo = new BoundField();
            colDeliverBillNo.HeaderText = InnoSoft.LS.Resources.Labels.DeliverBillNo;
            colDeliverBillNo.DataField = "BillNo";

            BoundField colDeliverDate = new BoundField();
            colDeliverDate.HeaderText = InnoSoft.LS.Resources.Labels.DeliverDate;
            colDeliverDate.DataField = "CreateTime";

            BoundField colCustomerName = new BoundField();
            colCustomerName.HeaderText = InnoSoft.LS.Resources.Labels.CustomerName;
            colCustomerName.DataField = "CustomerName";

            BoundField colDeliveryNo = new BoundField();
            colDeliveryNo.HeaderText = InnoSoft.LS.Resources.Labels.DeliveryNo;
            colDeliveryNo.DataField = "DeliveryNo";

            BoundField colReceiverCity = new BoundField();
            colReceiverCity.HeaderText = InnoSoft.LS.Resources.Labels.DestPlace;
            colReceiverCity.DataField = "ReceiverCity";

            BoundField colReceiverName = new BoundField();
            colReceiverName.HeaderText = InnoSoft.LS.Resources.Labels.ReceiverName;
            colReceiverName.DataField = "ReceiverName";

            BoundField colCarNo = new BoundField();
            colCarNo.HeaderText = InnoSoft.LS.Resources.Labels.CarNo;
            colCarNo.DataField = "CarNo";

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

            BoundField colReturnTime = new BoundField();
            colReturnTime.HeaderText = InnoSoft.LS.Resources.Labels.ReturnTime;
            colReturnTime.DataField = "ReturnTime";

            BoundField colDamageInfo = new BoundField();
            colDamageInfo.HeaderText = InnoSoft.LS.Resources.Labels.DamageInfo;
            colDamageInfo.DataField = "DamageInfo";

            var grid = new GridView();
            grid.Columns.Add(colDeliverBillNo);
            grid.Columns.Add(colDeliverDate);
            grid.Columns.Add(colCustomerName);
            grid.Columns.Add(colDeliveryNo);
            grid.Columns.Add(colReceiverCity);
            grid.Columns.Add(colReceiverName);
            grid.Columns.Add(colCarNo);
            grid.Columns.Add(colPackages);
            grid.Columns.Add(colTunnages);
            grid.Columns.Add(colPiles);
            grid.Columns.Add(colTenThousands);
            grid.Columns.Add(colReturnTime);
            grid.Columns.Add(colDamageInfo);

            grid.AutoGenerateColumns = false;

            grid.DataSource = from bill in listDeliverBill
                              select new
                              {
                                  BillNo = bill.BillNo,
                                  CreateTime = bill.CreateTime.ToString("yyyy-MM-dd"),
                                  CustomerName = bill.CustomerName,
                                  DeliveryNo = bill.DeliveryNo,
                                  ReceiverCity = bill.ReceiverCity,
                                  ReceiverName = bill.ReceiverName,
                                  CarNo = bill.CarNo,
                                  Packages = bill.TotalPackages > 0 ? bill.TotalPackages.ToString() : string.Empty,
                                  Tunnages = bill.TotalTunnages > 0 ? bill.TotalTunnages.ToString("#0.######") : string.Empty,
                                  Piles = bill.TotalPiles > 0 ? bill.TotalPiles.ToString("#0.######") : string.Empty,
                                  TenThousands = bill.TotalTenThousands > 0 ? bill.TotalTenThousands.ToString("#0.######") : string.Empty,
                                  ReturnTime = bill.ReturnTime.ToString("yyyy-MM-dd"),
                                  DamageInfo = bill.DamageInfo
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=DeliverBillReceipts.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

            return View("SearchDeliverBillReceipts");
        }

        #endregion

        #region 补打出仓单

        /// <summary>
        /// GET补打出仓单页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ReprintShipmentBills()
        {
            return View();
        }

        /// <summary>
        /// GET重打出仓单表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="shipmentBillNo"></param>
        /// <param name="customerName"></param>
        /// <param name="carNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadReprintShipmentBillsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string shipmentBillNo, string customerName, string carNo)
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<ShipmentBill> listShipmentBill = deliver.LoadShipmentBillsByConditions(startTime, endTime, shipmentBillNo, customerName, carNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listShipmentBill == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listShipmentBill.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "BillNo") + " " + (sord ?? "ASC");
            var data = listShipmentBill.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              b.BillNo,
                              b.CustomerName,
                              b.DeliveryNo,
                              b.ReceiverName,
                              b.CarNo,
                              b.TrailerNo,
                              b.PlanType,
                              b.TotalPackages.ToString(),
                              b.TotalTunnages.ToString("#0.######"),
                              b.TotalPiles.ToString("#0.######"),
                              b.TotalTenThousands.ToString("#0.######")
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET补打出仓单页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ReprintShipmentBill(string id)
        {
            string strErrText;
            string[] shipmentBillIds = id.Split(',');

            //读取公司名称
            OrganizationSystem organ = new OrganizationSystem();
            List<Organization> listOrgan = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrgan == null)
            {
                throw new Exception(strErrText);
            }
            Organization root = listOrgan.Find(delegate(Organization o) { return o.ParentId == 0; });
            ViewData["CompanyName"] = root.Name;

            //生成Model
            PrintShipmentBillViewModel model = new PrintShipmentBillViewModel();
            model.bills = new List<ShipmentBillViewModel>();

            DeliverSystem deliver = new DeliverSystem();
            PlanSystem plan = new PlanSystem();
            foreach (string shipmentBillId in shipmentBillIds)
            {
                ShipmentBill bill = deliver.LoadShipmentBill(long.Parse(shipmentBillId), LoginAccountId, LoginStaffName, out strErrText);
                if (bill == null)
                {
                    throw new Exception(strErrText);
                }

                List<ShipmentBillGoods> listGoods = deliver.LoadShipmentBillAllGoods(long.Parse(shipmentBillId), LoginAccountId, LoginStaffName, out strErrText);
                if (listGoods == null)
                {
                    throw new Exception(strErrText);
                }

                DeliverPlan deliverPlan = plan.LoadDeliverPlan(bill.PlanId, LoginAccountId, LoginStaffName, out strErrText);
                if (deliverPlan == null)
                {
                    throw new Exception(strErrText);
                }

                ShipmentBillViewModel modelBill = new ShipmentBillViewModel();
                modelBill.BillNo = bill.BillNo;
                modelBill.PlanType = bill.PlanType;
                modelBill.PlanNo = bill.PlanNo;
                modelBill.CustomerName = bill.CustomerName;
                modelBill.PayerName = bill.PayerName;
                modelBill.DeliveryNo = bill.DeliveryNo;
                modelBill.OutType = bill.OutType;
                modelBill.ReceiverName = bill.ReceiverName;
                modelBill.ReceiverCountry = bill.ReceiverCountry;
                modelBill.ReceiverProvince = bill.ReceiverProvince;
                modelBill.ReceiverCity = bill.ReceiverCity;
                modelBill.ReceiverAddress = bill.ReceiverAddress;
                modelBill.ReceiverContact = bill.ReceiverContact;
                modelBill.ReceiverContactTel = bill.ReceiverContactTel;
                modelBill.OrderNo = bill.OrderNo;
                modelBill.ReceiveType = bill.ReceiveType;
                modelBill.CarNo = bill.CarNo;
                modelBill.TrailerNo = bill.TrailerNo;
                modelBill.Warehouse = bill.Warehouse;
                modelBill.TotalPackages = bill.TotalPackages;
                modelBill.TotalTunnages = bill.TotalTunnages;
                modelBill.TotalPiles = bill.TotalPiles;
                modelBill.TotalTenThousands = bill.TotalTenThousands;
                modelBill.Remark = bill.Remark;
                modelBill.CreateTime = bill.CreateTime.ToString("yyyy-MM-dd");
                modelBill.CreatorName = deliverPlan.CreatorName;

                modelBill.Goods = new List<ShipmentBillGoodsViewModel>();
                foreach (ShipmentBillGoods goods in listGoods)
                {
                    ShipmentBillGoodsViewModel modelGoods = new ShipmentBillGoodsViewModel();
                    modelGoods.GoodsName = goods.GoodsName;
                    modelGoods.GoodsNo = goods.GoodsNo;
                    modelGoods.SpecModel = goods.SpecModel;
                    modelGoods.GWeight = goods.GWeight;
                    modelGoods.Grade = goods.Grade;
                    modelGoods.PieceWeight = goods.PieceWeight;
                    modelGoods.Packing = goods.Packing;
                    modelGoods.BatchNo = goods.BatchNo;
                    modelGoods.Location = goods.Location;
                    modelGoods.Packages = goods.Packages;
                    modelGoods.Tunnages = goods.Tunnages;
                    modelGoods.Piles = goods.Piles;
                    modelGoods.TenThousands = goods.TenThousands;

                    modelBill.Goods.Add(modelGoods);
                }

                model.bills.Add(modelBill);
            }

            return View(model);
        }

        #endregion

        #region 补打送货单

        /// <summary>
        /// GET补打送货单页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ReprintDeliverBills()
        {
            return View();
        }

        /// <summary>
        /// GET重打送货单表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="deliverBillNo"></param>
        /// <param name="customerName"></param>
        /// <param name="carNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadReprintDeliverBillsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string deliverBillNo, string customerName, string carNo)
        {
            //读取数据
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<DeliverBill> listDeliverBill = deliver.LoadDeliverBillsByConditions(startTime, endTime, deliverBillNo, customerName, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, string.Empty, carNo, string.Empty, string.Empty, "1", LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverBill == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listDeliverBill.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "BillNo") + " " + (sord ?? "ASC");
            var data = listDeliverBill.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              b.BillNo,
                              b.CustomerName,
                              b.DeliveryNo,
                              b.ReceiverName,
                              b.ReceiverCity,
                              b.CarNo,
                              b.TrailerNo,
                              b.PlanType,
                              b.TotalPackages.ToString(),
                              b.TotalTunnages.ToString("#0.######"),
                              b.TotalPiles.ToString("#0.######"),
                              b.TotalTenThousands.ToString("#0.######")
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET补打送货单页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ReprintDeliverBill(string id)
        {
            string strErrText;
            string[] deliverBillIds = id.Split(',');

            //读取公司名称
            OrganizationSystem organ = new OrganizationSystem();
            List<Organization> listOrgan = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrgan == null)
            {
                throw new Exception(strErrText);
            }
            Organization root = listOrgan.Find(delegate(Organization o) { return o.ParentId == 0; });
            ViewData["CompanyName"] = root.Name;

            //生成Model
            PrintDeliverBillViewModel model = new PrintDeliverBillViewModel();
            model.bills = new List<DeliverBillViewModel>();

            DeliverSystem deliver = new DeliverSystem();
            foreach (string deliverBillId in deliverBillIds)
            {
                DeliverBill data = deliver.LoadDeliverBill(long.Parse(deliverBillId), LoginAccountId, LoginStaffName, out strErrText);
                if (data == null)
                {
                    throw new Exception(strErrText);
                }

                List<DeliverBillGoods> listGoods = deliver.LoadDeliverBillAllGoods(long.Parse(deliverBillId), LoginAccountId, LoginStaffName, out strErrText);
                if (listGoods == null)
                {
                    throw new Exception(strErrText);
                }

                DeliverBillViewModel billVM = new DeliverBillViewModel();
                billVM.Id = data.Id;
                billVM.BillNo = data.BillNo;
                billVM.PlanType = data.PlanType;
                billVM.CustomerName = data.CustomerName;
                billVM.ReceiverName = data.ReceiverName;
                billVM.ReceiverCountry = data.ReceiverCountry;
                billVM.ReceiverProvince = data.ReceiverProvince;
                billVM.ReceiverCity = data.ReceiverCity;
                billVM.ReceiverAddress = data.ReceiverAddress;
                billVM.ReceiverContact = data.ReceiverContact;
                billVM.ReceiverContactTel = data.ReceiverContactTel;
                billVM.ReceiveType = data.ReceiveType;
                billVM.OrderNo = data.OrderNo;
                billVM.CarNo = data.CarNo;
                billVM.TrailerNo = data.TrailerNo;
                billVM.CreateTime = data.CreateTime;
                billVM.TotalPackages = data.TotalPackages;
                billVM.TotalTunnages = data.TotalTunnages;
                billVM.TotalPiles = data.TotalPiles;
                billVM.TotalTenThousands = data.TotalTenThousands;
                billVM.Remark = data.Remark;

                billVM.Goods = new List<DeliverBillGoodsViewModel>();
                foreach (DeliverBillGoods goods in listGoods)
                {
                    DeliverBillGoodsViewModel goodsVM = new DeliverBillGoodsViewModel();
                    goodsVM.GoodsName = goods.GoodsName;
                    goodsVM.GoodsNo = goods.GoodsNo;
                    goodsVM.SpecModel = goods.SpecModel;
                    goodsVM.GWeight = goods.GWeight;
                    goodsVM.Grade = goods.Grade;
                    goodsVM.PieceWeight = goods.PieceWeight;
                    goodsVM.Packing = goods.Packing;
                    goodsVM.BatchNo = goods.BatchNo;
                    goodsVM.Packages = goods.Packages;
                    goodsVM.Tunnages = goods.Tunnages;
                    goodsVM.Piles = goods.Piles;
                    goodsVM.TenThousands = goods.TenThousands;

                    billVM.Goods.Add(goodsVM);
                }
                model.bills.Add(billVM);
            }
            return View(model);
        }

        #endregion

    }
}
