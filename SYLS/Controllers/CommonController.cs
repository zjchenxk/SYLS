using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using InnoSoft.LS.Business.Facades;
using InnoSoft.LS.Models;

namespace SYLS.Controllers
{
    /// <summary>
    /// 公用控制器
    /// </summary>
    public class CommonController : BaseController
    {
        /// <summary>
        /// 判断指定功能的某个权限是否有效
        /// </summary>
        /// <param name="strFuncId"></param>
        /// <param name="strPermission"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadFunctionPermission(string strFuncId, string strPermission)
        {
            //读取数据
            string strErrText;
            PermissionSystem permission = new PermissionSystem();
            int data = permission.LoadFunctionPermission(long.Parse(strFuncId), strPermission, LoginAccountId, LoginStaffName, out strErrText);
            if (data < 0)
            {
                throw new Exception(strErrText);
            }
            if (data == 1)
                return Json(true, JsonRequestBehavior.AllowGet);
            else
                return Json(false, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 判断当前登录帐号的某个权限是否有效
        /// </summary>
        /// <param name="strFuncId"></param>
        /// <param name="strPermission"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadAccountPermission(string strFuncId, string strPermission)
        {
            //读取数据
            string strErrText;
            PermissionSystem permission = new PermissionSystem();
            bool data = permission.LoadAccountPermission(long.Parse(strFuncId), strPermission, LoginAccountId, LoginStaffName, out strErrText);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET所有组织结构JSON数据
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadOrganizations()
        {
            string strErrText;
            OrganizationSystem organ = new OrganizationSystem();
            List<Organization> listOrganization = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrganization == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from o in listOrganization
                      select new
                      {
                          o.Id,
                          o.Name,
                          o.FullName,
                          o.ParentId,
                          o.ManagerName
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定组织结构JSON数据
        /// </summary>
        /// <param name="nOrganId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadOrganization(long nOrganId)
        {
            string strErrText;
            OrganizationSystem organ = new OrganizationSystem();
            Organization data = organ.LoadOrganization(nOrganId, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    Id = data.Id,
                    Name = data.Name,
                    CountryName = data.CountryName,
                    ProvinceName = data.ProvinceName,
                    CityName = data.CityName
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// GET指定组织部门的员工JSON数据
        /// </summary>
        /// <param name="nOrganId">组织部门编码</param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadOrganizationStaffs(long nOrganId)
        {
            string strErrText;
            StaffSystem staff = new StaffSystem();
            List<Staff> listStaff = staff.LoadStaffsByOrganId(nOrganId, LoginAccountId, LoginStaffName, out strErrText);
            if (listStaff == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from s in listStaff
                      select new
                      {
                          s.Id,
                          s.FullName
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定组织部门的所有员工JSON数据
        /// </summary>
        /// <param name="nOrganId">组织部门编码</param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadOrganizationAllStaffs(long nOrganId)
        {
            string strErrText;
            StaffSystem staff = new StaffSystem();
            List<Staff> listStaff = staff.LoadAllStaffsByOrganId(nOrganId, LoginAccountId, LoginStaffName, out strErrText);
            if (listStaff == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from s in listStaff
                      select new
                      {
                          s.Id,
                          s.FullName
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET国家JSON数据
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCountrys()
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            List<Country> listCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listCountry == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from c in listCountry
                      select c.Name;

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定国家的省份JSON数据
        /// </summary>
        /// <param name="strCountryName">国家名称</param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadProvincesByCountry(string strCountryName)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            List<Province> listProvince = dd.LoadProvincesByCountry(strCountryName, LoginAccountId, LoginStaffName, out strErrText);
            if (listProvince == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from p in listProvince
                      select p.Name;

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定省份的城市JSON数据
        /// </summary>
        /// <param name="strCountryName">国家名称</param>
        /// <param name="strProvinceName">省份名称</param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCitysByProvince(string strCountryName, string strProvinceName)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            List<City> listCity = dd.LoadCitysByProvince(strCountryName, strProvinceName, LoginAccountId, LoginStaffName, out strErrText);
            if (listCity == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from c in listCity
                      select c.Name;

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET所有客户JSON数据
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCustomers()
        {
            string strErrText = string.Empty;
            CustomerSystem customer = new CustomerSystem();
            List<Customer> listCustomer = customer.LoadCustomers(LoginAccountId, LoginStaffName, out strErrText);
            if (listCustomer == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from c in listCustomer
                      select new
                      {
                          c.Id,
                          c.Name
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定名称的客户JSON数据
        /// </summary>
        /// <param name="strName"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCustomerByName(string strName)
        {
            string strErrText;
            CustomerSystem customer = new CustomerSystem();
            Customer data = customer.LoadCustomerByName(strName, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                decimal decLoadingForceFeePrice = 0;
                decimal decUnloadingForceFeePrice = 0;
                CustomerForceFeePrice data1 = customer.LoadCustomerForceFeePrice(data.Id, DateTime.Now, LoginAccountId, LoginStaffName, out strErrText);
                if (data1 != null)
                {
                    decLoadingForceFeePrice = data1.LoadingForceFeePrice;
                    decUnloadingForceFeePrice = data1.UnloadingForceFeePrice;
                }

                decimal decStorageFeePrice = 0;
                CustomerStorageFeePrice data2 = customer.LoadCustomerStorageFeePrice(data.Id, DateTime.Now, LoginAccountId, LoginStaffName, out strErrText);
                if (data2 != null)
                {
                    decStorageFeePrice = data2.StorageFeePrice;
                }

                var ret = new
                {
                    Id = data.Id,
                    Name = data.Name,
                    LoadingForceFeePrice = decLoadingForceFeePrice,
                    UnloadingForceFeePrice = decUnloadingForceFeePrice,
                    StorageFeePrice = decStorageFeePrice,
                    OwnOrganId = data.OwnOrganId
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// 读取指定客户的收货单位JSON数据
        /// </summary>
        /// <param name="customerName"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCustomerReceivers(string customerName)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            List<Receiver> listReceiver = dd.LoadCustomerReceivers(customerName, LoginAccountId, LoginStaffName, out strErrText);
            if (listReceiver == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from r in listReceiver
                      select r.Name;

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定时间段内发生业务的付款单位JSON数据
        /// </summary>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadGenerateBusinessPayersByTimespan(string startTime, string endTime)
        {
            string strErrText;
            CustomerSystem customer = new CustomerSystem();
            List<Customer> listPayer = customer.LoadGenerateBusinessPayersByTimespan(startTime, endTime, LoginAccountId, LoginStaffName, out strErrText);
            if (listPayer == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from p in listPayer
                      orderby p.Name
                      select new
                      {
                          Id = p.Id.ToString(),
                          Name = p.Name,
                          FullName = p.FullName
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET所有货物类别JSON数据
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadGoodsTypes()
        {
            string strErrText = string.Empty;
            DDSystem dd = new DDSystem();
            List<GoodsType> listGoodsType = dd.LoadGoodsTypes(LoginAccountId, LoginStaffName, out strErrText);
            if (listGoodsType == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from t in listGoodsType
                      select new
                      {
                          t.Id,
                          t.FullName
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定名称的提货单位JSON数据
        /// </summary>
        /// <param name="strName"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadReceiverByName(string strName)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            Receiver data = dd.LoadReceiverByName(strName, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    Country = data.Country,
                    Province = data.Province,
                    City = data.City,
                    Address = data.Address,
                    Contact = data.Contact,
                    ContactTel = data.ContactTel
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// GET指定车号的车辆JSON数据
        /// </summary>
        /// <param name="strCarNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarByCarNo(string strCarNo)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            CarrierCar data = dd.LoadCarByCarNo(strCarNo, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    TrailerNo = data.TrailerNo,
                    CarryingCapacity = data.CarryingCapacity
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// GET指定车号的驾驶员JSON数据
        /// </summary>
        /// <param name="strCarNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDriversByCarNo(string strCarNo)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            List<CarrierDriver> listDriver = dd.LoadDriversByCarNo(strCarNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listDriver == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from d in listDriver
                      select new
                      {
                          d.Id,
                          d.Name
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定驾驶员JSON数据
        /// </summary>
        /// <param name="nId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDriver(long nId)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            CarrierDriver data = dd.LoadDriver(nId, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            var ret = new
            {
                LicenseNo = data.LicenseNo,
                MobileTel = data.MobileTel,
                HomeTel = data.HomeTel,
            };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定货物编号的货物JSON数据
        /// </summary>
        /// <param name="strGoodsNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadGoodsByGoodsNo(string strGoodsNo)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            Goods data = dd.LoadGoodsByGoodsNo(strGoodsNo, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    Id = data.Id,
                    Name = data.Name,
                    Brand = data.Brand,
                    SpecModel = data.SpecModel,
                    GWeight = data.GWeight,
                    Grade = data.Grade,
                    Packing = data.Packing,
                    PieceWeight = data.PieceWeight
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// GET指定发货计划数据
        /// </summary>
        /// <param name="nPlanId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDeliverPlan(long nPlanId)
        {
            string strErrText;
            PlanSystem plan = new PlanSystem();
            DeliverPlan data = plan.LoadDeliverPlan(nPlanId, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    ShipmentNo = data.ShipmentNo,
                    DeliveryNo = data.DeliveryNo,
                    CustomerId = data.CustomerId,
                    CustomerName = data.CustomerName,
                    PayerId = data.PayerId,
                    PayerName = data.PayerName,
                    ReceiverName = data.ReceiverName,
                    StartCountry = data.StartCountry,
                    StartProvince = data.StartProvince,
                    StartCity = data.StartCity,
                    DestCountry = data.ReceiverCountry,
                    DestProvince = data.ReceiverProvince,
                    DestCity = data.ReceiverCity,
                    PlanType = data.PlanType,
                    ReceiveType = data.ReceiveType,
                    CarNo = data.CarNo,
                    TrailerNo = data.TrailerNo,
                    DriverName = data.DriverName,
                    DriverLicenseNo = data.DriverLicenseNo,
                    DriverMobileTel = data.DriverMobileTel,
                    DriverHomeTel = data.DriverHomeTel,
                    CarrierId = data.CarrierId,
                    CarrierName = data.CarrierName,
                    CreateTime = data.CreateTime.ToString("yyyy-MM-dd"),
                    Remark = data.Remark
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// GET指定名称的承运单位JSON数据
        /// </summary>
        /// <param name="strName"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarrierByName(string strName)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            Carrier data = dd.LoadCarrierByName(strName, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    Id = data.Id,
                    Name = data.Name,
                    BusinessType = data.BusinessType,
                    PaymentType = data.PaymentType
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// GET指定承运单位JSON数据
        /// </summary>
        /// <param name="carrierId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarrier(string carrierId)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            Carrier data = dd.LoadCarrier(long.Parse(carrierId), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    Id = data.Id,
                    Name = data.Name,
                    BusinessType = data.BusinessType,
                    PaymentType = data.PaymentType
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// GET指定车号的承运单位JSON数据
        /// </summary>
        /// <param name="strCarNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarrierByCarNo(string strCarNo)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            Carrier data = dd.LoadCarrierByCarNo(strCarNo, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    Id = data.Id,
                    Name = data.Name,
                    BusinessType = data.BusinessType,
                    PaymentType = data.PaymentType
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// GET指定承运单位、起点和讫点的运输价格数据
        /// </summary>
        /// <param name="carrierId"></param>
        /// <param name="startCountry"></param>
        /// <param name="startProvince"></param>
        /// <param name="startCity"></param>
        /// <param name="destCountry"></param>
        /// <param name="destProvince"></param>
        /// <param name="destCity"></param>
        /// <param name="planType"></param>
        /// <param name="createTime"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarrierTransportPrice(string carrierId, string startCountry, string startProvince, string startCity, string destCountry, string destProvince, string destCity, string planType, string createTime)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            CarrierTransportPrice data = dd.LoadCarrierTransportPrice(long.Parse(carrierId), startCountry, startProvince, startCity, destCountry, destProvince, destCity, planType, DateTime.Parse(createTime), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(0, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(data.TransportPrice, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// GET指定承运单位的结算公式数据
        /// </summary>
        /// <param name="carrierId"></param>
        /// <param name="planType"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarrierSettlementExpression(string carrierId, string planType)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            CarrierSettlementExpression data = dd.LoadCarrierSettlementExpression(long.Parse(carrierId), planType, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    TransportChargeExpression = data.TransportChargeExpression,
                    TransportPriceExpression = data.TransportPriceExpression
                };
                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// 读取指定承运单位的车辆JSON数据
        /// </summary>
        /// <param name="carrierName"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarrierCars(string carrierName)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            List<CarrierCar> listCar = dd.LoadCarrierCars(carrierName, LoginAccountId, LoginStaffName, out strErrText);
            if (listCar == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from c in listCar
                      select new
                      {
                          c.CarNo,
                          c.TrailerNo,
                          c.CarryingCapacity
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 读取指定时间段内发生业务的承运单位数据
        /// </summary>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadGenerateBusinessCarriersByTimespan(string startTime, string endTime)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            List<Carrier> listCarrier = dd.LoadGenerateBusinessCarriersByTimespan(startTime, endTime, LoginAccountId, LoginStaffName, out strErrText);
            if (listCarrier == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from c in listCarrier
                      select c.Name;

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定起点到指定收货单位的距离
        /// </summary>
        /// <param name="strReceiverName"></param>
        /// <param name="startCountry"></param>
        /// <param name="startProvince"></param>
        /// <param name="startCity"></param>
        /// <param name="destCountry"></param>
        /// <param name="destProvince"></param>
        /// <param name="destCity"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDistance(string strReceiverName, string startCountry, string startProvince, string startCity)
        {
            string strErrText;
            DDSystem dd = new DDSystem();
            ReceiverDistance data = dd.LoadReceiverDistance(strReceiverName, startCountry, startProvince, startCity, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(data.KM, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// GET员工帐号JSON数据
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadStaffAccounts()
        {
            string strErrText;
            AuthenticateSystem auth = new AuthenticateSystem();
            List<Account> listAccount = auth.LoadStaffAccounts(LoginAccountId, LoginStaffName, out strErrText);
            if (listAccount == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from a in listAccount
                      select new
                      {
                          a.Id,
                          a.StaffName
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定送货单号的送货单数据
        /// </summary>
        /// <param name="strDeliverBillNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDeliverBillByNo(string strDeliverBillNo)
        {
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            DeliverBill data = deliver.LoadDeliverBillByNo(strDeliverBillNo, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    Id = data.Id,
                    PlanId = data.PlanId,
                    CarrierName = data.CarrierName,
                    CarNo = data.CarNo,
                    CarType = data.CarType,
                    TotalTunnages = data.TotalTunnages,
                    TotalPiles = data.TotalPiles,
                    ShipmentBillTotalTunnages = data.ShipmentBillTotalTunnages,
                    ShipmentBillTotalPiles = data.ShipmentBillTotalPiles,
                    TransportPrice = data.TransportPrice
                };

                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// GET指定发货计划的客户结算价格数据
        /// </summary>
        /// <param name="planId"></param>
        /// <param name="carType"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCustomerTransportPrice(string planId, string carType)
        {
            string strErrText;
            CustomerSystem customer = new CustomerSystem();
            CustomerTransportPrice data = customer.LoadCustomerTransportPriceByPlanId(long.Parse(planId), carType, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(0, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(data.TransportPrice, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// GET所有员工数据
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadStaffs()
        {
            string strErrText;
            StaffSystem staff = new StaffSystem();
            List<Staff> listStaff = staff.LoadStaffs(LoginAccountId, LoginStaffName, out strErrText);
            if (listStaff == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from s in listStaff
                      orderby s.FullName
                      select new
                      {
                          s.Id,
                          s.FullName
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定时间段内发生仓储力支费的客户数据
        /// </summary>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadGenerateStorageAndForceFeeCustomersByTimespan(string startTime, string endTime)
        {
            string strErrText;
            CustomerSystem customer = new CustomerSystem();
            List<Customer> listCustomer = customer.LoadGenerateStorageAndForceFeeCustomersByTimespan(startTime, endTime, LoginAccountId, LoginStaffName, out strErrText);
            if (listCustomer == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from c in listCustomer
                      select new
                      {
                          Id = c.Id.ToString(),
                          Name = c.Name,
                          FullName = c.FullName
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET LODOP打印控件安装文件
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public FilePathResult DownloadLODOP()
        {
            return File(Path.Combine(HttpContext.Server.MapPath("/AttachFiles"), "install_lodop.exe"), "application/octet-stream", "install_lodop.exe");
        }

        /// <summary>
        /// GET待处理业务个数
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPendingCount()
        {
            string strErrText;
            CommonSystem common = new CommonSystem();
            PendingCount data = common.LoadPendingCount(LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                return Json(null, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var ret = new
                {
                    SubmitDeliverPlansCount = data.SubmitDeliverPlansCount,
                    CustomerApprovePaperPlansCount = data.CustomerApprovePaperPlansCount,
                    ApproveDeliverPlansCount = data.ApproveDeliverPlansCount,
                    DispatchDeliverPlansCount = data.DispatchDeliverPlansCount,
                    SubmitDispatchBillsCount = data.SubmitDispatchBillsCount,
                    DispatchBillsForPrintDispatchedShipmentBillCount = data.DispatchBillsForPrintDispatchedShipmentBillCount,
                    PrintAllocateShipmentBillsCount = data.PrintAllocateShipmentBillsCount,
                    SubmitShipmentBillsCount = data.SubmitShipmentBillsCount,
                    PrintDeliverBillsCount = data.PrintDeliverBillsCount,
                    ReceiptDeliverBillsCount = data.ReceiptDeliverBillsCount,
                    NewContractsCount = data.NewContractsCount,
                    SubmitContractsCount = data.SubmitContractsCount,
                    PrintContractsCount = data.PrintContractsCount,
                    ApproveContractsCount = data.ApproveContractsCount,
                    ReverseContractsCount = data.ReverseContractsCount,
                    FineContractsCount = data.FineContractsCount
                };
                return Json(ret, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// 读取指定货物库存数据
        /// </summary>
        /// <param name="customerId"></param>
        /// <param name="goodsId"></param>
        /// <param name="batchNo"></param>
        /// <param name="packing"></param>
        /// <param name="warehouse"></param>
        /// <param name="location"></param>
        /// <param name="productionDate"></param>
        /// <param name="enterWarehouseBillId"></param>
        /// <param name="consignedDeliveryNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadGoodsStocks(string customerId, string goodsId, string batchNo, string packing, string warehouse, string location, string productionDate, string enterWarehouseBillId, string consignedDeliveryNo)
        {
            string strErrText;
            StockSystem stock = new StockSystem();
            List<Stock> listStock = stock.LoadGoodsStocksByConditions(customerId, goodsId, batchNo, packing, warehouse, location, productionDate, enterWarehouseBillId, consignedDeliveryNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listStock == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from s in listStock
                      select new
                      {
                          Id = s.Id,
                          Packages = s.Packages,
                          Tunnages = s.Tunnages,
                          Piles = s.Piles,
                          TenThousands = s.TenThousands
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定时间段内发货的付款单位JSON数据
        /// </summary>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDeliverBillsPayersByTimespan(string startTime, string endTime)
        {
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<Customer> listPayer = deliver.LoadDeliverBillsPayersByTimespan(startTime, endTime, LoginAccountId, LoginStaffName, out strErrText);
            if (listPayer == null)
            {
                throw new Exception(strErrText);
            }

            var ret = from p in listPayer
                      select new
                      {
                          Id = p.Id.ToString(),
                          Name = p.Name,
                          FullName = p.FullName
                      };

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定时间段内发货的办事处JSON数据
        /// </summary>
        /// <param name="startTime"></param>
        /// <param name="endTime"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDeliverBillsOwnOrgansByTimespan(string startTime, string endTime)
        {
            string strErrText;
            DeliverSystem deliver = new DeliverSystem();
            List<Organization> listOrgan = deliver.LoadDeliverBillsOwnOrgansByTimespan(startTime, endTime, LoginAccountId, LoginStaffName, out strErrText);
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

    }
}
