using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;
using InnoSoft.LS.Business.Facades;
using InnoSoft.LS.Models;
using SYLS.Areas.chenxk.ViewModels;
using SYLS.Controllers;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.Controllers
{
    /// <summary>
    /// 合同管理控制器
    /// </summary>
    public class ContractController : BaseController
    {
        #region 新增合同

        /// <summary>
        /// GET新增合同页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewContract()
        {
            return View();
        }

        /// <summary>
        ///  GET可以签订合同的调度单表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadContractDispatchBillsGrid(string sidx, string sord, int page, int rows)
        {
            string strErrText;

            //读取可以新增合同的车号数据
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBill> listBill = dispatch.LoadContractDispatchBills(LoginAccountId, LoginStaffName, out strErrText);
            if (listBill == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listBill.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CarNo") + " " + (sord ?? "ASC");
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
                              b.CarNo,
                              b.TrailerNo,
                              b.DriverName,
                              b.DriverMobileTel,
                              b.TotalPackages.ToString(),
                              b.TotalTunnages.ToString("#0.######"),
                              b.TotalPiles.ToString("#0.######"),
                              b.TotalTenThousands.ToString("#0.######"),
                              b.CreateTime.ToString("yyyy-MM-dd")
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET可以签订合同的调度单数据
        /// </summary>
        /// <param name="dispatchBillId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadContractDispatchBill(string dispatchBillId)
        {
            string strErrText;

            //读取调度单数据
            DispatchSystem dispatch = new DispatchSystem();
            DispatchBill bill = dispatch.LoadDispatchBill(long.Parse(dispatchBillId), LoginAccountId, LoginStaffName, out strErrText);
            if (bill == null)
            {
                throw new Exception(strErrText);
            }

            //读取调度计划数据
            List<DispatchBillDeliverPlan> listDeliverPlan = dispatch.LoadDispatchBillDeliverPlans(long.Parse(dispatchBillId), LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverPlan == null)
            {
                throw new Exception(strErrText);
            }

            //读取调度货物数据
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchBillAllGoods(long.Parse(dispatchBillId), LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                throw new Exception(strErrText);
            }

            //清除自提的计划
            foreach (DispatchBillDeliverPlan p in listDeliverPlan)
            {
                if (p.ReceiveType == InnoSoft.LS.Resources.Options.PickUpSelf)
                {
                    listGoods.RemoveAll(delegate(DispatchBillGoods g) { return g.PlanId == p.PlanId; });
                }
            }
            listDeliverPlan.RemoveAll(delegate(DispatchBillDeliverPlan p) { return p.ReceiveType == InnoSoft.LS.Resources.Options.PickUpSelf; });

            //生成结果集
            var ret = new
            {
                CarNo = bill.CarNo,
                TrailerNo = bill.TrailerNo,
                CarType = bill.CarType,
                DriverName = bill.DriverName,
                DriverLicenseNo = bill.DriverLicenseNo,
                DriverMobileTel = bill.DriverMobileTel,
                DriverHomeTel = bill.DriverHomeTel,
                CarrierId = bill.CarrierId,
                CarrierName = bill.CarrierName,
                GoodsName = (from g in listGoods select g.GoodsName).Distinct(),
                Packing = "",
                TotalPackages = listDeliverPlan.Sum(p => p.Packages),
                TotalTunnages = listDeliverPlan.Sum(p => p.Tunnages).ToString("#0.######"),
                TotalPiles = listDeliverPlan.Sum(p => p.Piles).ToString("#0.######"),
                TotalTenThousands = listDeliverPlan.Sum(p => p.TenThousands).ToString("#0.######"),
                StartPlace = (from p in listDeliverPlan select p.StartCity).Distinct(),
                DestPlace = (from p in listDeliverPlan select p.ReceiverCity).Distinct(),
                ShipmentTime = DateTime.Now.ToString("yyyy-MM-dd"),
                ArrivalTime = "",
                TotalTransportCharges = listDeliverPlan.Sum(p => p.TransportCharges).ToString("#0.00"),
                PrepayTransportCharges = "",
                ResidualTransportCharges = listDeliverPlan.Sum(p => p.TransportCharges).ToString("#0.00"),
                OriginalContractNo = ""
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET可以签订合同的调度单计划表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="dispatchBillId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadContractDispatchBillDeliverPlansGrid(string sidx, string sord, int page, int rows, string dispatchBillId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillDeliverPlan> listDeliverPlan = dispatch.LoadDispatchBillDeliverPlans(long.Parse(dispatchBillId), LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverPlan == null)
            {
                throw new Exception(strErrText);
            }

            //清除自提的计划
            listDeliverPlan.RemoveAll(delegate(DispatchBillDeliverPlan p) { return p.ReceiveType == InnoSoft.LS.Resources.Options.PickUpSelf; });

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
                              p.PlanId.ToString(),
                              p.PlanNo, 
                              p.CustomerName,
                              p.ShipmentNo,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.ReceiverCity + p.ReceiverAddress,
                              p.ReceiveType,
                              p.PlanType,
                              p.Packages.ToString(),
                              p.Tunnages.ToString("#0.######"),
                              p.Piles.ToString("#0.######"),
                              p.TenThousands.ToString("#0.######"),
                              p.TransportPrice.ToString("#0.######"),
                              p.TransportCharges.ToString(),
                              p.Remark,
                              p.TransportChargeExpression,
                              p.TransportPriceExpression,
                              p.KM.ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    PlanNo = InnoSoft.LS.Resources.Labels.Total,
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
        /// POST新增合同
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewContract(ContractViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Contract data = new Contract();
                data.DispatchBillId = model.DispatchBillId;
                data.CarNo = model.CarNo;
                data.TrailerNo = model.TrailerNo;
                data.CarType = model.CarType;
                data.DriverName = model.DriverName;
                data.DriverLicenseNo = model.DriverLicenseNo;
                data.DriverMobileTel = model.DriverMobileTel;
                data.DriverHomeTel = model.DriverHomeTel;
                data.CarrierId = model.CarrierId;
                data.CarrierName = model.CarrierName;
                data.GoodsName = model.GoodsName;
                data.Packing = model.Packing;
                data.StartPlace = model.StartPlace;
                data.DestPlace = model.DestPlace;
                data.ShipmentTime = DateTime.Parse(model.ShipmentTime);
                data.ArrivalTime = DateTime.Parse(model.ArrivalTime);
                data.TotalPackages = model.TotalPackages;
                data.TotalTunnages = model.TotalTunnages;
                data.TotalPiles = model.TotalPiles;
                data.TotalTenThousands = model.TotalTenThousands;
                data.TotalTransportCharges = model.TotalTransportCharges;
                data.PrepayTransportCharges = model.PrepayTransportCharges;
                data.ResidualTransportCharges = model.ResidualTransportCharges;
                data.OriginalContractNo = model.OriginalContractNo;
                data.IsPrestowage = true;

                List<ContractDeliverPlan> listPlan = new List<ContractDeliverPlan>();
                if (model.DeliverPlans != null)
                {
                    foreach (ContractDeliverPlanViewModel m in model.DeliverPlans)
                    {
                        ContractDeliverPlan p = new ContractDeliverPlan();
                        p.PlanId = m.PlanId;
                        p.Packages = m.Packages;
                        p.Tunnages = m.Tunnages;
                        p.Piles = m.Piles;
                        p.TenThousands = m.TenThousands;
                        p.TransportChargeExpression = m.TransportChargeExpression;
                        p.TransportPriceExpression = m.TransportPriceExpression;
                        p.KM = m.KM;
                        p.TransportPrice = m.TransportPrice;
                        p.TransportCharges = m.TransportCharges;
                        p.Remark = m.Remark;
                        listPlan.Add(p);
                    }
                }

                //保存数据
                string strErrText;
                ContractSystem contract = new ContractSystem();
                if (contract.InsertContract(data, listPlan, LoginAccountId, LoginStaffName, out strErrText) > 0)
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

        #region 提交合同

        /// <summary>
        /// GET待提交合同页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SubmitContracts()
        {
            return View();
        }

        /// <summary>
        /// GET待提交合同表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSubmitContractsGrid(string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<Contract> listContract = contract.LoadSubmitContracts(LoginAccountId, LoginStaffName, out strErrText);
            if (listContract == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listContract.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "ContractNo") + " " + (sord ?? "ASC");
            var data = listContract.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from c in data
                      select new
                      {
                          id = c.Id,
                          cell = new string[] { 
                              c.Id.ToString(), 
                              c.ContractNo, 
                              c.OriginalContractNo,
                              c.CarNo,
                              c.TrailerNo,
                              c.CarType,
                              c.DriverName,
                              c.DriverMobileTel,
                              c.GoodsName,
                              c.TotalTunnages.ToString("#0.######"),
                              c.TotalPiles.ToString("#0.######"),
                              c.TotalTransportCharges.ToString()
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET修改合同页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyContract(string id)
        {
            string strErrText;

            //读取合同数据
            ContractSystem contract = new ContractSystem();
            Contract data = contract.LoadContract(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            ContractViewModel model = new ContractViewModel();
            model.Id = data.Id;
            model.DispatchBillId = data.DispatchBillId;
            model.ContractNo = data.ContractNo;
            model.CarNo = data.CarNo;
            model.TrailerNo = data.TrailerNo;
            model.CarType = data.CarType;
            model.DriverName = data.DriverName;
            model.DriverLicenseNo = data.DriverLicenseNo;
            model.DriverMobileTel = data.DriverMobileTel;
            model.DriverHomeTel = data.DriverHomeTel;
            model.CarrierId = data.CarrierId;
            model.CarrierName = data.CarrierName;
            model.GoodsName = data.GoodsName;
            model.Packing = data.Packing;
            model.StartPlace = data.StartPlace;
            model.DestPlace = data.DestPlace;
            model.ShipmentTime = data.ShipmentTime.ToString("yyyy-MM-dd");
            model.ArrivalTime = data.ArrivalTime.ToString("yyyy-MM-dd");
            model.TotalPackages = data.TotalPackages;
            model.TotalTunnages = data.TotalTunnages;
            model.TotalPiles = data.TotalPiles;
            model.TotalTenThousands = data.TotalTenThousands;
            model.TotalTransportCharges = data.TotalTransportCharges;
            model.PrepayTransportCharges = data.PrepayTransportCharges;
            model.ResidualTransportCharges = data.ResidualTransportCharges;
            model.OriginalContractNo = data.OriginalContractNo;

            return View(model);
        }

        /// <summary>
        /// GET合同货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="contractId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadContractDeliverPlansGrid(string sidx, string sord, int page, int rows, string contractId)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<ContractDeliverPlan> listPlan = contract.LoadContractDeliverPlans(long.Parse(contractId), LoginAccountId, LoginStaffName, out strErrText);
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
                              p.PlanId.ToString(),
                              p.PlanNo, 
                              p.CustomerName,
                              p.ShipmentNo,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.ReceiverCity + p.ReceiverAddress,
                              p.ReceiveType,
                              p.PlanType,
                              p.Packages.ToString(),
                              p.Tunnages.ToString("#0.######"),
                              p.Piles.ToString("#0.######"),
                              p.TenThousands.ToString("#0.######"),
                              p.TransportPrice.ToString("#0.######"),
                              p.TransportCharges.ToString(),
                              p.Remark,
                              p.TransportChargeExpression,
                              p.TransportPriceExpression,
                              p.KM.ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    PlanNo = InnoSoft.LS.Resources.Labels.Total,
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
        /// GET修改合同发货数据页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyContractGoods()
        {
            //传入参数
            var request = HttpContext.Request;

            string strId = request.QueryString["id"] ?? "0";
            string strContractId = request.QueryString["contractId"] ?? "0";
            string strDispatchBillId = request.QueryString["dispatchBillId"] ?? "0";
            string strPlanId = request.QueryString["planId"] ?? "0";
            string strPlanType = request.QueryString["planType"] ?? string.Empty;
            string strReceiveType = request.QueryString["receiveType"] ?? string.Empty;
            string strTransportChargeExpression = request.QueryString["transportChargeExpression"] ?? string.Empty;
            string strTransportPriceExpression = request.QueryString["transportPriceExpression"] ?? string.Empty;
            string strKM = request.QueryString["km"] ?? "0";
            string strTransportPrice = request.QueryString["transportPrice"] ?? "0";
            string strTransportCharges = request.QueryString["transportCharges"] ?? "0";
            string strRemark = request.QueryString["remark"] ?? string.Empty;

            //缓存参数
            ViewData["PlanType"] = strPlanType;
            ViewData["ReceiveType"] = strReceiveType;

            //生成Model
            ContractDeliverPlanViewModel model = new ContractDeliverPlanViewModel();
            model.Id = long.Parse(strId);
            model.ContractId = long.Parse(strContractId);
            model.DispatchBillId = long.Parse(strDispatchBillId);
            model.PlanId = long.Parse(strPlanId);
            model.TransportChargeExpression = strTransportChargeExpression;
            model.TransportPriceExpression = strTransportPriceExpression;
            model.KM = int.Parse(strKM);
            model.TransportPrice = decimal.Parse(strTransportPrice);
            model.TransportCharges = decimal.Parse(strTransportCharges);
            model.Remark = strRemark;

            return View(model);
        }

        /// <summary>
        /// GET合同发货数据表格
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="contractId"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadContractGoodsGrid(string sidx, string sord, int page, int rows, string contractId, string planId)
        {
            //读取数据
            string strErrText;
            DispatchSystem dispatch = new DispatchSystem();
            List<DispatchBillGoods> listGoods = dispatch.LoadDispatchBillAllGoodsByContractIdAndPlanId(long.Parse(contractId), long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
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
        /// POST修改合同发货数据
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyContractGoods(ContractDeliverPlanViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                ContractDeliverPlan data = new ContractDeliverPlan();
                data.Id = model.Id;
                data.ContractId = model.ContractId;
                data.DispatchBillId = model.DispatchBillId;
                data.PlanId = model.PlanId;
                data.Packages = model.Packages;
                data.Tunnages = model.Tunnages;
                data.Piles = model.Piles;
                data.TenThousands = model.TenThousands;
                data.TransportChargeExpression = model.TransportChargeExpression;
                data.TransportPriceExpression = model.TransportPriceExpression;
                data.KM = model.KM;
                data.TransportPrice = model.TransportPrice;
                data.TransportCharges = model.TransportCharges;
                data.Remark = model.Remark;

                List<ContractGoods> listGoods = new List<ContractGoods>();
                if (model.Goods != null)
                {
                    foreach (ContractGoodsViewModel m in model.Goods)
                    {
                        ContractGoods g = new ContractGoods();
                        g.DispatchBillId = model.DispatchBillId;
                        g.PlanId = model.PlanId;
                        g.GoodsId = m.GoodsId;
                        g.GoodsNo = m.GoodsNo;
                        g.BatchNo = m.BatchNo;
                        g.Packing = m.Packing;
                        g.Location = m.Location;
                        g.Packages = m.Packages;
                        g.PieceWeight = m.PieceWeight;
                        g.Tunnages = m.Tunnages;
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
                ContractSystem contract = new ContractSystem();
                if (contract.UpdateContractDeliverPlan(data, listGoods, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST修改合同
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyContract(ContractViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Contract data = new Contract();
                data.Id = model.Id;
                data.DispatchBillId = model.DispatchBillId;
                data.ContractNo = model.ContractNo;
                data.CarNo = model.CarNo;
                data.TrailerNo = model.TrailerNo;
                data.CarType = model.CarType;
                data.DriverName = model.DriverName;
                data.DriverLicenseNo = model.DriverLicenseNo;
                data.DriverMobileTel = model.DriverMobileTel;
                data.DriverHomeTel = model.DriverHomeTel;
                data.CarrierId = model.CarrierId;
                data.CarrierName = model.CarrierName;
                data.GoodsName = model.GoodsName;
                data.Packing = model.Packing;
                data.StartPlace = model.StartPlace;
                data.DestPlace = model.DestPlace;
                data.ShipmentTime = DateTime.Parse(model.ShipmentTime);
                data.ArrivalTime = DateTime.Parse(model.ArrivalTime);
                data.TotalPackages = model.TotalPackages;
                data.TotalTunnages = model.TotalTunnages;
                data.TotalPiles = model.TotalPiles;
                data.TotalTenThousands = model.TotalTenThousands;
                data.TotalTransportCharges = model.TotalTransportCharges;
                data.PrepayTransportCharges = model.PrepayTransportCharges;
                data.ResidualTransportCharges = model.ResidualTransportCharges;
                data.OriginalContractNo = model.OriginalContractNo;

                //保存数据
                string strErrText;
                ContractSystem contract = new ContractSystem();
                if (contract.UpdateContract(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除合同
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteContract(string id)
        {
            string strErrText;
            ContractSystem contract = new ContractSystem();
            if (contract.DeleteContract(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// GET提交合同页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult SubmitContract(string id)
        {
            string strErrText;

            //读取合同数据
            ContractSystem contract = new ContractSystem();
            Contract data = contract.LoadContract(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            ContractViewModel model = new ContractViewModel();
            model.Id = data.Id;
            model.DispatchBillId = data.DispatchBillId;
            model.ContractNo = data.ContractNo;
            model.CarNo = data.CarNo;
            model.TrailerNo = data.TrailerNo;
            model.DriverName = data.DriverName;
            model.DriverLicenseNo = data.DriverLicenseNo;
            model.DriverMobileTel = data.DriverMobileTel;
            model.DriverHomeTel = data.DriverHomeTel;
            model.CarrierId = data.CarrierId;
            model.CarrierName = data.CarrierName;
            model.GoodsName = data.GoodsName;
            model.Packing = data.Packing;
            model.StartPlace = data.StartPlace;
            model.DestPlace = data.DestPlace;
            model.ShipmentTime = data.ShipmentTime.ToString("yyyy-MM-dd");
            model.ArrivalTime = data.ArrivalTime.ToString("yyyy-MM-dd");
            model.TotalPackages = data.TotalPackages;
            model.TotalTunnages = data.TotalTunnages;
            model.TotalPiles = data.TotalPiles;
            model.TotalTenThousands = data.TotalTenThousands;
            model.TotalTransportCharges = data.TotalTransportCharges;
            model.PrepayTransportCharges = data.PrepayTransportCharges;
            model.ResidualTransportCharges = data.ResidualTransportCharges;
            model.OriginalContractNo = data.OriginalContractNo;

            return View(model);
        }

        /// <summary>
        /// POST提交合同
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult SubmitContract(ContractViewModel model)
        {
            string strErrText;
            ContractSystem contract = new ContractSystem();
            if (contract.SubmitContract(model.Id, LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 打印合同

        /// <summary>
        /// GET待打印合同页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult PrintContracts()
        {
            return View();
        }

        /// <summary>
        /// GET待打印合同表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPrintContractsGrid(string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<Contract> listContract = contract.LoadPrintContracts(LoginAccountId, LoginStaffName, out strErrText);
            if (listContract == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listContract.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "ContractNo") + " " + (sord ?? "ASC");
            var data = listContract.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from c in data
                      select new
                      {
                          id = c.Id,
                          cell = new string[] { 
                              c.Id.ToString(), 
                              c.ContractNo, 
                              c.OriginalContractNo,
                              c.CarNo,
                              c.TrailerNo,
                              c.CarType,
                              c.DriverName,
                              c.DriverMobileTel,
                              c.GoodsName,
                              c.TotalTunnages.ToString("#0.######"),
                              c.TotalPiles.ToString("#0.######"),
                              c.TotalTransportCharges.ToString()
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET打印合同页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult PrintContract(string id)
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
            ViewData["CompanyName"] = root.Name;

            //读取合同数据
            ContractSystem contract = new ContractSystem();
            Contract data = contract.LoadContract(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            ContractViewModel model = new ContractViewModel();
            model.Id = data.Id;
            model.DispatchBillId = data.DispatchBillId;
            model.ContractNo = data.ContractNo;
            model.CarNo = data.CarNo;
            model.TrailerNo = data.TrailerNo;
            model.DriverName = data.DriverName;
            model.DriverLicenseNo = data.DriverLicenseNo;
            model.DriverMobileTel = data.DriverMobileTel;
            model.DriverHomeTel = data.DriverHomeTel;
            model.CarrierId = data.CarrierId;
            model.CarrierName = data.CarrierName;
            model.GoodsName = data.GoodsName;
            model.Packing = data.Packing;
            model.StartPlace = data.StartPlace;
            model.DestPlace = data.DestPlace;
            model.ShipmentTime = data.ShipmentTime.ToString("yyyy-MM-dd");
            model.ArrivalTime = data.ArrivalTime.ToString("yyyy-MM-dd");
            model.TotalPackages = data.TotalPackages;
            model.TotalTunnages = data.TotalTunnages;
            model.TotalPiles = data.TotalPiles;
            model.TotalTenThousands = data.TotalTenThousands;
            model.TotalTransportCharges = data.TotalTransportCharges;
            model.PrepayTransportCharges = data.PrepayTransportCharges;
            model.ResidualTransportCharges = data.ResidualTransportCharges;
            model.OriginalContractNo = data.OriginalContractNo;

            return View(model);
        }

        /// <summary>
        /// POST提交打印合同
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult SubmitPrintContract(string id)
        {
            string strMessage;
            ContractSystem contract = new ContractSystem();
            bool bSuccess = contract.SubmitPrintContract(long.Parse(id), LoginAccountId, LoginStaffName, out strMessage);

            var ret = new
            {
                Success = bSuccess,
                Message = strMessage
            };
            return Json(ret);
        }

        #endregion

        #region 审批合同

        /// <summary>
        /// GET审批合同价格页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ApproveContracts()
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

            //生成空的组织部门下拉列表项
            List<Organization> listOrganization = new List<Organization>();
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
        /// GET待审批合同表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="contractNo"></param>
        /// <param name="originalContractNo"></param>
        /// <param name="destCountry"></param>
        /// <param name="destProvince"></param>
        /// <param name="destCity"></param>
        /// <param name="carNo"></param>
        /// <param name="organId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadApproveContractsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string contractNo, string originalContractNo, string destCountry, string destProvince, string destCity, string carNo, string organId)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<Contract> listContract = contract.LoadApproveContractsByConditions(startTime, endTime, contractNo, originalContractNo, destCountry, destProvince, destCity, carNo, organId, LoginAccountId, LoginStaffName, out strErrText);
            if (listContract == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listContract.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "ShipmentTime") + " " + (sord ?? "DESC");
            var data = listContract.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from c in data
                      select new
                      {
                          id = c.Id,
                          cell = new string[] { 
                              c.Id.ToString(), 
                              c.ContractNo, 
                              c.OriginalContractNo,
                              c.ShipmentTime.ToString("yyyy-MM-dd"),
                              c.CarNo,
                              c.TrailerNo,
                              c.CarType,
                              c.DriverName,
                              c.DriverMobileTel,
                              c.GoodsName,
                              c.TotalTunnages.ToString("#0.######"),
                              c.TotalPiles.ToString("#0.######"),
                              c.TotalTransportCharges.ToString()
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定时间段内审批合同的所属办事处JSON数据
        /// </summary>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadApproveContractsOwnOrgansByTimespan(string startTime, string endTime)
        {
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<Organization> listOrgan = contract.LoadApproveContractsOwnOrgansByTimespan(startTime, endTime, LoginAccountId, LoginStaffName, out strErrText);
            if (listOrgan == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from o in listOrgan
                      select new
                      {
                          Id = o.Id.ToString(),
                          FullName = o.FullName
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET审批合同页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ApproveContract(string id)
        {
            ViewData["ContractId"] = id;

            return View();
        }

        /// <summary>
        /// GET审批合同货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="contractId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadApproveContractDeliverPlansGrid(string sidx, string sord, int page, int rows, string contractId)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<ContractDeliverPlan> listPlan = contract.LoadContractDeliverPlans(long.Parse(contractId), LoginAccountId, LoginStaffName, out strErrText);
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

            string sortExpression = (sidx ?? "CustomerName") + " " + (sord ?? "ASC");
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
                              p.PlanId.ToString(),
                              p.CustomerName,
                              p.ReceiverName,
                              p.PlanType,
                              p.StartCity,
                              p.ReceiverCity,
                              p.ReceiveType,
                              p.Packages.ToString(),
                              p.Tunnages.ToString("#0.######"),
                              p.Piles.ToString("#0.######"),
                              p.TenThousands.ToString("#0.######"),
                              p.KM.ToString(),
                              p.TransportPrice.ToString("#0.######"),
                              p.TransportCharges.ToString(),
                              p.LimitedTransportPrice.ToString("#0.######"),
                              p.LimitedTransportCharges.ToString("#0.######"),
                              p.ApprovedTransportPrice.ToString("#0.######"),
                              p.ApprovedTransportCharges.ToString(),
                              p.TransportChargeExpression,
                              p.TransportPriceExpression
                          }
                      }).ToArray(),
                userdata = new
                {
                    PlanNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands),
                    TransportCharges = data.Sum(s => s.TransportCharges),
                    ApprovedTransportCharges = data.Sum(s => s.ApprovedTransportCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET合同货物审批记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="contractId"></param>
        /// <param name="planId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadContractApproveCommentsGrid(string sidx, string sord, int page, int rows, string contractId, string planId)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<ContractApproveComment> listComment = contract.LoadContractApproveComments(long.Parse(contractId), long.Parse(planId), LoginAccountId, LoginStaffName, out strErrText);
            if (listComment == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listComment.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "ApproveTime") + " " + (sord ?? "ASC");
            var data = listComment.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              p.ApproveTime.ToString("yyyy-MM-dd"),
                              p.ApproverName,
                              p.ApprovedTransportPrice.ToString("#0.######"),
                              p.ApprovedTransportCharges.ToString()
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST审批合同价格
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ApproveContract(ContractViewModel model)
        {
            //创建数据
            List<ContractDeliverPlan> listPlan = new List<ContractDeliverPlan>();
            if (model.DeliverPlans != null)
            {
                foreach (ContractDeliverPlanViewModel m in model.DeliverPlans)
                {
                    ContractDeliverPlan p = new ContractDeliverPlan();
                    p.Id = m.Id;
                    p.ContractId = m.ContractId;
                    p.PlanId = m.PlanId;
                    p.Packages = m.Packages;
                    p.Tunnages = m.Tunnages;
                    p.Piles = m.Piles;
                    p.TenThousands = m.TenThousands;
                    p.TransportChargeExpression = m.TransportChargeExpression;
                    p.TransportPriceExpression = m.TransportPriceExpression;
                    p.KM = m.KM;
                    p.TransportPrice = m.TransportPrice;
                    p.TransportCharges = m.TransportCharges;
                    p.ApprovedTransportPrice = m.ApprovedTransportPrice;
                    p.ApprovedTransportCharges = m.ApprovedTransportCharges;
                    listPlan.Add(p);
                }
            }

            //保存数据
            string strMessage;
            ContractSystem contract = new ContractSystem();
            bool bSuccess = contract.ApproveContract(model.Id, listPlan, LoginAccountId, LoginStaffName, out strMessage);

            var ret = new
            {
                Success = bSuccess,
                Message = strMessage
            };
            return Json(ret);
        }

        #endregion

        #region 冲帐处理

        /// <summary>
        /// GET冲帐处理页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ReverseContracts()
        {
            return View();
        }

        /// <summary>
        /// GET待冲帐合同表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="contractNo"></param>
        /// <param name="originalContractNo"></param>
        /// <param name="carrierName"></param>
        /// <param name="carNo"></param>
        /// <param name="organId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadReverseContractsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string contractNo, string originalContractNo, string carrierName, string carNo, string organId)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<Contract> listContract = contract.LoadReverseContractsByConditions(startTime, endTime, contractNo, originalContractNo, carrierName, carNo, organId, LoginAccountId, LoginStaffName, out strErrText);
            if (listContract == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listContract.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "ContractNo") + " " + (sord ?? "ASC");
            var data = listContract.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from c in data
                      select new
                      {
                          id = c.Id,
                          cell = new string[] { 
                              c.Id.ToString(), 
                              c.ContractNo, 
                              c.OriginalContractNo,
                              c.GoodsName,
                              c.StartPlace,
                              c.DestPlace,
                              c.ShipmentTime.ToString("yyyy-MM-dd"),
                              c.CarNo,
                              c.TrailerNo,
                              c.DriverName,
                              c.DriverMobileTel,
                              c.TotalTunnages.ToString("#0.######"),
                              c.TotalPiles.ToString("#0.######"),
                              c.TotalTransportCharges.ToString(),
                              c.PrepayTransportCharges.ToString(),
                              c.ResidualTransportCharges.ToString(),
                              c.ReverseAmount.ToString(),
                              (c.TotalTransportCharges - c.ReverseAmount).ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    ContractNo = InnoSoft.LS.Resources.Labels.Total,
                    TotalTransportCharges = data.Sum(s => s.TotalTransportCharges),
                    PrepayTransportCharges = data.Sum(s => s.PrepayTransportCharges),
                    ResidualTransportCharges = data.Sum(s => s.ResidualTransportCharges),
                    ReverseAmount = data.Sum(s => s.ReverseAmount),
                    ResidualReverseAmount = data.Sum(s => s.TotalTransportCharges - s.ReverseAmount)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET冲帐合同的发货表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="contractId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadReverseContractDeliverPlansGrid(string sidx, string sord, int page, int rows, string contractId)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<ContractDeliverPlan> listPlan = contract.LoadContractDeliverPlans(long.Parse(contractId), LoginAccountId, LoginStaffName, out strErrText);
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
                              p.PlanId.ToString(),
                              p.PlanNo, 
                              p.CustomerName,
                              p.ShipmentNo,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.ReceiverCity + p.ReceiverAddress,
                              p.ReceiveType,
                              p.PlanType,
                              p.Packages.ToString(),
                              p.Tunnages.ToString("#0.######"),
                              p.Piles.ToString("#0.######"),
                              p.TenThousands.ToString("#0.######"),
                              p.FinalTransportPrice.ToString("#0.######"),
                              p.FinalTransportCharges.ToString(),
                              p.Remark,
                              p.DeliverBillReceiptReceived.ToString(),
                              p.DamageInfo
                          }
                      }).ToArray(),
                userdata = new
                {
                    PlanNo = InnoSoft.LS.Resources.Labels.Total,
                    Packages = data.Sum(s => s.Packages),
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TenThousands = data.Sum(s => s.TenThousands),
                    FinalTransportCharges = data.Sum(s => s.FinalTransportCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET合同冲帐记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="contractId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadContractReverseDetailsGrid(string sidx, string sord, int page, int rows, string contractId)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<ContractReverseDetail> listReverseDetail = contract.LoadContractReverseDetails(long.Parse(contractId), LoginAccountId, LoginStaffName, out strErrText);
            if (listReverseDetail == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listReverseDetail.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listReverseDetail.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              d.CreateTime.ToString("yyyy-MM-dd"),
                              d.CreatorName,
                              d.ReverseAmount.ToString(),
                              d.WithholdAmount.ToString(),
                              d.FactpaymentAmount.ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    CreateTime = InnoSoft.LS.Resources.Labels.Total,
                    ReverseAmount = data.Sum(s => s.ReverseAmount),
                    WithholdAmount = data.Sum(s => s.WithholdAmount),
                    FactpaymentAmount = data.Sum(s => s.FactpaymentAmount)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET待保存冲帐记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="saveReverses"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSaveReversesGrid(string sidx, string sord, int page, int rows, string saveReverses)
        {
            //读取数据
            List<Contract> listReverseContract = new List<Contract>();
            if (saveReverses != string.Empty)
            {
                //生成冲帐明细数据
                List<ContractReverseDetail> listReverseDetail = new List<ContractReverseDetail>();
                string[] reverses = saveReverses.Split(',');
                foreach (string reverse in reverses)
                {
                    if (reverse != string.Empty)
                    {
                        string[] s = reverse.Split('|');
                        ContractReverseDetail detail = new ContractReverseDetail();
                        detail.ContractId = long.Parse(s[0]);
                        detail.ReverseAmount = decimal.Parse(s[1]);
                        detail.WithholdAmount = decimal.Parse(s[2]);
                        detail.FactpaymentAmount = decimal.Parse(s[3]);
                        listReverseDetail.Add(detail);
                    }
                }

                //读取冲帐合同数据
                string strErrText;
                var strContractIds = string.Join(",", (from d in listReverseDetail select d.ContractId).ToArray<long>());
                ContractSystem contract = new ContractSystem();
                List<Contract> listContract = contract.LoadReverseContractsByContractIds(strContractIds, LoginAccountId, LoginStaffName, out strErrText);
                if (listContract == null)
                {
                    throw new Exception(strErrText);
                }

                //过滤数据
                foreach (ContractReverseDetail detail in listReverseDetail)
                {
                    Contract o = listContract.Find(delegate(Contract c) { return c.Id == detail.ContractId; });
                    if (o == null)
                    {
                        throw new Exception(InnoSoft.LS.Resources.Strings.FindReverseContractDataFaild);
                    }
                    o.ReverseAmount = detail.ReverseAmount;
                    o.WithholdAmount = detail.WithholdAmount;
                    o.FactpaymentAmount = detail.FactpaymentAmount;
                    listReverseContract.Add(o);
                }
            }

            //提取当前页面数据
            int nTotalRows = listReverseContract.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "ContractNo") + " " + (sord ?? "ASC");
            var data = listReverseContract.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from c in data
                      select new
                      {
                          id = c.Id,
                          cell = new string[] { 
                              c.Id.ToString(), 
                              c.ContractNo, 
                              c.OriginalContractNo,
                              c.CarNo,
                              c.TrailerNo,
                              c.DriverName,
                              c.DriverMobileTel,
                              c.ReverseAmount.ToString(),
                              c.WithholdAmount.ToString(),
                              c.FactpaymentAmount.ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    ContractNo = InnoSoft.LS.Resources.Labels.Total,
                    ReverseAmount = data.Sum(s => s.ReverseAmount),
                    WithholdAmount = data.Sum(s => s.WithholdAmount),
                    FactpaymentAmount = data.Sum(s => s.FactpaymentAmount)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST冲帐处理
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ReverseContracts(ContractReverseViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                ContractReverse data = new ContractReverse();
                data.Id = model.Id;
                data.ReverseAmount = model.ReverseAmount;
                data.WithholdAmount = model.WithholdAmount;
                data.FactpaymentAmount = model.FactpaymentAmount;
                data.CreatorId = model.CreatorId;
                data.CreatorName = model.CreatorName;

                List<ContractReverseDetail> listDetail = new List<ContractReverseDetail>();
                if (model.Details != null)
                {
                    foreach (ContractReverseDetailViewModel m in model.Details)
                    {
                        ContractReverseDetail d = new ContractReverseDetail();
                        d.Id = m.Id;
                        d.ReverseId = 0;
                        d.ContractId = m.ContractId;
                        d.ReverseAmount = m.ReverseAmount;
                        d.WithholdAmount = m.WithholdAmount;
                        d.FactpaymentAmount = m.FactpaymentAmount;
                        listDetail.Add(d);
                    }
                }

                //保存数据
                string strErrText;
                ContractSystem contract = new ContractSystem();
                if (contract.InsertContractReverse(data, listDetail, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// POST退回修改合同
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ReturnModifyContract(string id)
        {
            string strErrText;
            ContractSystem contract = new ContractSystem();
            if (contract.ReturnModifyContract(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 查询冲帐记录

        /// <summary>
        /// GET查询冲帐记录页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchReverses()
        {
            return View();
        }

        /// <summary>
        /// GET冲帐记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="contractNo"></param>
        /// <param name="originalContractNo"></param>
        /// <param name="reverserId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchContractReversesGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string contractNo, string originalContractNo, string reverserId)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<ContractReverse> listContractReverse = contract.LoadContractReversesByConditions(startTime, endTime, contractNo, originalContractNo, reverserId, LoginAccountId, LoginStaffName, out strErrText);
            if (listContractReverse == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listContractReverse.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CreateTime") + " " + (sord ?? "ASC");
            var data = listContractReverse.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from r in data
                      select new
                      {
                          id = r.Id,
                          cell = new string[] { 
                              r.Id.ToString(), 
                              r.CreatorName,
                              r.CreateTime.ToString("yyyy-MM-dd"),
                              r.ReverseAmount.ToString(),
                              r.WithholdAmount.ToString(),
                              r.FactpaymentAmount.ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    CreatorName = InnoSoft.LS.Resources.Labels.Total,
                    ReverseAmount = data.Sum(s => s.ReverseAmount),
                    WithholdAmount = data.Sum(s => s.WithholdAmount),
                    FactpaymentAmount = data.Sum(s => s.FactpaymentAmount)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET冲帐记录明细表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="reverseId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchContractReverseDetailsGrid(string sidx, string sord, int page, int rows, string reverseId)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<ContractReverseDetail> listDetail = contract.LoadContractReverseDetailsByReverseId(long.Parse(reverseId), LoginAccountId, LoginStaffName, out strErrText);
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

            string sortExpression = (sidx ?? "ContractNo") + " " + (sord ?? "ASC");
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
                              d.ContractId.ToString(),
                              d.ContractNo,
                              d.OriginalContractNo,
                              d.GoodsName,
                              d.StartPlace,
                              d.DestPlace,
                              d.ShipmentTime.ToString("yyyy-MM-dd"),
                              d.CarNo,
                              d.TrailerNo,
                              d.DriverName,
                              d.DriverMobileTel,
                              d.TotalTunnages.ToString("#0.######"),
                              d.TotalPiles.ToString("#0.######"),
                              d.TotalTransportCharges.ToString(),
                              d.ReverseAmount.ToString(),
                              d.WithholdAmount.ToString(),
                              d.FactpaymentAmount.ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    ContractNo = InnoSoft.LS.Resources.Labels.Total,
                    TotalTransportCharges = data.Sum(s => s.TotalTransportCharges),
                    ReverseAmount = data.Sum(s => s.ReverseAmount),
                    WithholdAmount = data.Sum(s => s.WithholdAmount),
                    FactpaymentAmount = data.Sum(s => s.FactpaymentAmount)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST删除冲帐记录
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteContractReverse(string id)
        {
            string strErrText;
            ContractSystem contract = new ContractSystem();
            if (contract.DeleteContractReverse(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 罚款处理

        /// <summary>
        /// GET罚款处理页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult FineContracts()
        {
            return View();
        }

        /// <summary>
        /// GET待罚款合同表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="contractNo"></param>
        /// <param name="originalContractNo"></param>
        /// <param name="transactorId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadFineContractsGrid(string sidx, string sord, int page, int rows, string contractNo, string originalContractNo, string transactorId)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<Contract> listContract = contract.LoadFineContractsByConditions(contractNo, originalContractNo, transactorId, LoginAccountId, LoginStaffName, out strErrText);
            if (listContract == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listContract.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "ContractNo") + " " + (sord ?? "ASC");
            var data = listContract.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from c in data
                      select new
                      {
                          id = c.Id,
                          cell = new string[] { 
                              c.Id.ToString(), 
                              c.ContractNo, 
                              c.OriginalContractNo,
                              c.CarNo,
                              c.TrailerNo,
                              c.DriverName,
                              c.DriverMobileTel,
                              c.GoodsName,
                              c.TotalTunnages.ToString("#0.######"),
                              c.TotalPiles.ToString("#0.######"),
                              c.TotalOriginalTransportCharges.ToString(),
                              c.TotalApprovedTransportCharges.ToString(),
                              (c.TotalOriginalTransportCharges - c.TotalApprovedTransportCharges).ToString(),
                              c.CreatorName
                          }
                      }).ToArray(),
                userdata = new
                {
                    ContractNo = InnoSoft.LS.Resources.Labels.Total,
                    TotalTransportCharges = data.Sum(s => s.TotalOriginalTransportCharges),
                    TotalApproveTransportCharges = data.Sum(s => s.TotalApprovedTransportCharges),
                    TransportChargesBalance = data.Sum(s => s.TotalOriginalTransportCharges) - data.Sum(s => s.TotalApprovedTransportCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET罚款合同的发货表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="contractId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadFineContractDeliverPlansGrid(string sidx, string sord, int page, int rows, string contractId)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<ContractDeliverPlan> listPlan = contract.LoadContractDeliverPlans(long.Parse(contractId), LoginAccountId, LoginStaffName, out strErrText);
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
                              p.PlanId.ToString(),
                              p.PlanNo, 
                              p.CustomerName,
                              p.ShipmentNo,
                              p.DeliveryNo,
                              p.ReceiverName,
                              p.ReceiverCity + p.ReceiverAddress,
                              p.ReceiveType,
                              p.PlanType,
                              p.Tunnages.ToString("#0.######"),
                              p.Piles.ToString("#0.######"),
                              p.TransportCharges.ToString(),
                              p.ApprovedTransportCharges.ToString(),
                              (p.TransportCharges - p.ApprovedTransportCharges).ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    PlanNo = InnoSoft.LS.Resources.Labels.Total,
                    Tunnages = data.Sum(s => s.Tunnages),
                    Piles = data.Sum(s => s.Piles),
                    TransportCharges = data.Sum(s => s.TransportCharges),
                    ApprovedTransportCharges = data.Sum(s => s.ApprovedTransportCharges),
                    TransportChargesBalance = data.Sum(s => s.TransportCharges) - data.Sum(s => s.ApprovedTransportCharges)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET待保存罚款记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="saveFines"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSaveFinesGrid(string sidx, string sord, int page, int rows, string saveFines)
        {
            //读取数据
            List<Contract> listFineContract = new List<Contract>();
            if (saveFines != string.Empty)
            {
                string strErrText;
                ContractSystem contract = new ContractSystem();
                List<Contract> listContract = contract.LoadFineContractsByConditions(string.Empty, string.Empty, string.Empty, LoginAccountId, LoginStaffName, out strErrText);
                if (listContract == null)
                {
                    throw new Exception(strErrText);
                }

                //过滤数据
                string[] fines = saveFines.Split(',');
                foreach (string fine in fines)
                {
                    if (fine != string.Empty)
                    {
                        string[] s = fine.Split('|');
                        long nContractId = long.Parse(s[0]);
                        decimal decFineAmount = decimal.Parse(s[1]);

                        Contract o = listContract.Find(delegate(Contract c) { return c.Id == nContractId; });
                        if (o == null)
                        {
                            throw new Exception(InnoSoft.LS.Resources.Strings.FindFineContractDataFaild);
                        }
                        o.FineAmount = decFineAmount;
                        listFineContract.Add(o);
                    }
                }
            }

            //提取当前页面数据
            int nTotalRows = listFineContract.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "ContractNo") + " " + (sord ?? "ASC");
            var data = listFineContract.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from c in data
                      select new
                      {
                          id = c.Id,
                          cell = new string[] { 
                              c.Id.ToString(), 
                              c.ContractNo, 
                              c.OriginalContractNo,
                              c.CarNo,
                              c.TrailerNo,
                              c.DriverName,
                              c.DriverMobileTel,
                              c.CreatorName,
                              c.FineAmount.ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    ContractNo = InnoSoft.LS.Resources.Labels.Total,
                    FineAmount = data.Sum(s => s.FineAmount)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST罚款处理
        /// </summary>
        /// <param name="models"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult FineContracts(List<ContractFineViewModel> models)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                List<Contract> listContract = new List<Contract>();
                if (models != null)
                {
                    foreach (ContractFineViewModel model in models)
                    {
                        Contract c = new Contract();
                        c.Id = model.ContractId;
                        c.FineAmount = model.FineAmount;
                        listContract.Add(c);
                    }
                }

                //保存数据
                string strErrText;
                ContractSystem contract = new ContractSystem();
                if (contract.FineContracts(listContract, LoginAccountId, LoginStaffName, out strErrText))
                {
                    return Json(string.Empty);
                }
                else
                {
                    return Json(strErrText);
                }
            }
            return View(models);
        }

        #endregion

        #region 查询罚款记录

        /// <summary>
        /// GET查询罚款记录页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchFines()
        {
            return View();
        }

        /// <summary>
        /// GET查询罚款记录表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="creatorId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadSearchContractFinesGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string creatorId)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<Contract> listContract = contract.LoadContractFinesByConditions(startTime, endTime, creatorId, LoginAccountId, LoginStaffName, out strErrText);
            if (listContract == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listContract.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "FineTime") + " " + (sord ?? "ASC");
            var data = listContract.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from c in data
                      select new
                      {
                          id = c.Id,
                          cell = new string[] { 
                              c.Id.ToString(), 
                              c.CreatorName,
                              c.FineTime.ToString("yyyy-MM-dd"),
                              c.ContractNo,
                              c.OriginalContractNo,
                              c.FineAmount.ToString()
                          }
                      }).ToArray(),
                userdata = new
                {
                    CreatorName = InnoSoft.LS.Resources.Labels.Total,
                    FineAmount = data.Sum(s => s.FineAmount)
                }
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST删除罚款记录
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteContractFine(string id)
        {
            string strErrText;
            ContractSystem contract = new ContractSystem();
            if (contract.DeleteContractFine(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// GET导出罚款记录
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportFines()
        {
            string strErrText;

            #region 提取参数

            var request = HttpContext.Request;
            string strStartTime = request.QueryString["startTime"] ?? string.Empty;
            string strEndTime = request.QueryString["endTime"] ?? string.Empty;
            string strCreatorId = request.QueryString["creatorId"] ?? string.Empty;

            #endregion

            #region 读取罚款数据

            ContractSystem contract = new ContractSystem();
            List<Contract> listContract = contract.LoadContractFinesByConditions(strStartTime, strEndTime, strCreatorId, LoginAccountId, LoginStaffName, out strErrText);
            if (listContract == null)
            {
                throw new Exception(strErrText);
            }

            #endregion

            #region 输出Excel

            //生成GridView
            BoundField colStaffName = new BoundField();
            colStaffName.HeaderText = InnoSoft.LS.Resources.Labels.StaffName;
            colStaffName.DataField = "CreatorName";

            BoundField colFineTime = new BoundField();
            colFineTime.HeaderText = InnoSoft.LS.Resources.Labels.FineTime;
            colFineTime.DataField = "FineTime";

            BoundField colContractNo = new BoundField();
            colContractNo.HeaderText = InnoSoft.LS.Resources.Labels.ContractNo;
            colContractNo.DataField = "ContractNo";

            BoundField colOriginalContractNo = new BoundField();
            colOriginalContractNo.HeaderText = InnoSoft.LS.Resources.Labels.OriginalContractNo;
            colOriginalContractNo.DataField = "OriginalContractNo";

            BoundField colFineAmount = new BoundField();
            colFineAmount.HeaderText = InnoSoft.LS.Resources.Labels.FineAmount;
            colFineAmount.DataField = "FineAmount";

            var grid = new GridView();
            grid.Columns.Add(colStaffName);
            grid.Columns.Add(colFineTime);
            grid.Columns.Add(colContractNo);
            grid.Columns.Add(colOriginalContractNo);
            grid.Columns.Add(colFineAmount);

            grid.AutoGenerateColumns = false;

            grid.DataSource = from c in listContract
                              select new
                              {
                                  CreatorName = c.CreatorName,
                                  FineTime = c.FineTime.ToString("yyyy-MM-dd"),
                                  ContractNo = c.ContractNo,
                                  OriginalContractNo = c.OriginalContractNo,
                                  FineAmount = c.FineAmount.ToString("N")
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=ContractFines.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

            #endregion

            return View("SearchFines");
        }

        #endregion

        #region 查询合同审批信息

        /// <summary>
        /// GET查询合同页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SearchContracts()
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
        /// GET查询合同表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <param name="contractNo"></param>
        /// <param name="originalContractNo"></param>
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
        public JsonResult LoadSearchContractsGrid(string sidx, string sord, int page, int rows, string startTime, string endTime, string contractNo, string originalContractNo, string startCountry, string startProvince, string startCity, string destCountry, string destProvince, string destCity, string carNo, string organId)
        {
            //读取数据
            string strErrText;
            ContractSystem contract = new ContractSystem();
            List<Contract> listContract = contract.LoadContractsByConditions(startTime, endTime, contractNo, originalContractNo, startCountry, startProvince, startCity, destCountry, destProvince, destCity, carNo, organId, LoginAccountId, LoginStaffName, out strErrText);
            if (listContract == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listContract.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "ContractNo") + " " + (sord ?? "ASC");
            var data = listContract.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from c in data
                      select new
                      {
                          id = c.Id,
                          cell = new string[] { 
                              c.Id.ToString(), 
                              c.ContractNo, 
                              c.OriginalContractNo,
                              c.ShipmentTime.ToString("yyyy-MM-dd"),
                              c.StartPlace,
                              c.DestPlace,
                              c.CarNo,
                              c.TrailerNo,
                              c.GoodsName,
                              c.TotalTunnages.ToString("#0.######"),
                              c.TotalPiles.ToString("#0.######"),
                              c.TotalTransportCharges.ToString(),
                              c.ApproveState == InnoSoft.LS.Resources.Options.Approved ? (c.ApproveCount > 0 ? c.ApproveState : string.Empty) : c.ApproveFlowStepName,
                              c.OwnOrganName
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        #endregion

    }
}
