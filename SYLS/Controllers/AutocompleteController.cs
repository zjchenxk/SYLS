using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using InnoSoft.LS.Business.Facades;
using InnoSoft.LS.Models;

namespace SYLS.Controllers
{
    public class AutocompleteController : BaseController
    {
        /// <summary>
        /// GET所有客户名称JSON数据
        /// </summary>
        /// <param name="term"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCustomerNames(string term)
        {
            //读取所有客户数据
            string strErrText = string.Empty;
            CustomerSystem customer = new CustomerSystem();
            List<Customer> listCustomer = customer.LoadCustomerNamesByName(term, LoginAccountId, LoginStaffName, out strErrText);
            if (listCustomer == null)
            {
                listCustomer = new List<Customer>();
            }

            var ret = (from c in listCustomer select c.Name).ToArray();

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET所有客户全称JSON数据
        /// </summary>
        /// <param name="term"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCustomerFullNames(string term)
        {
            //读取所有客户数据
            string strErrText = string.Empty;
            CustomerSystem customer = new CustomerSystem();
            List<Customer> listCustomer = customer.LoadCustomers(LoginAccountId, LoginStaffName, out strErrText);
            if (listCustomer == null)
            {
                listCustomer = new List<Customer>();
            }

            //提取客户全称中包含关键字的记录
            var ret = (
                from c in listCustomer
                where c.FullName.Contains(term)
                select c.FullName).ToArray();

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET所有提货单位名称JSON数据
        /// </summary>
        /// <param name="term"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadReceiverNames(string term)
        {
            //读取所有提货单位数据
            string strErrText = string.Empty;
            DDSystem dd = new DDSystem();
            List<Receiver> listReceiver = dd.LoadReceiverNamesByName(term, LoginAccountId, LoginStaffName, out strErrText);
            if (listReceiver == null)
            {
                listReceiver = new List<Receiver>();
            }

            var ret = (from r in listReceiver select r.Name).ToArray();

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET所有承运单位名称JSON数据
        /// </summary>
        /// <param name="term"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarrierNames(string term)
        {
            //读取所有承运单位数据
            string strErrText = string.Empty;
            DDSystem dd = new DDSystem();
            List<Carrier> listCarrier = dd.LoadCarriers(LoginAccountId, LoginStaffName, out strErrText);
            if (listCarrier == null)
            {
                listCarrier = new List<Carrier>();
            }

            //提取承运单位名称中包含关键字的记录
            var ret = (
                from r in listCarrier
                where r.Name.Contains(term)
                select r.Name).ToArray();

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET所有车辆JSON数据
        /// </summary>
        /// <param name="term"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarNos(string term)
        {
            //读取所有车辆数据
            string strErrText = string.Empty;
            DDSystem dd = new DDSystem();
            List<CarrierCar> listCar = dd.LoadCarsByCarNo(term, LoginAccountId, LoginStaffName, out strErrText);
            if (listCar == null)
            {
                listCar = new List<CarrierCar>();
            }

            //提取车号中包含关键字的记录
            var ret = (
                from c in listCar
                select c.CarNo).ToArray();

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET所有货物编号JSON数据
        /// </summary>
        /// <param name="term"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadGoodsNos(string term)
        {
            //读取所有货物档案数据
            string strErrText = string.Empty;
            DDSystem dd = new DDSystem();
            List<Goods> listGoods = dd.LoadAllGoodsByGoodsNo(term, LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                listGoods = new List<Goods>();
            }

            var ret = (
                from g in listGoods
                select new
                {
                    g.GoodsNo,
                    g.Name,
                    g.SpecModel,
                    g.GWeight,
                    g.Grade,
                    g.Packing,
                    g.PieceWeight
                }).ToArray();

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET所有送货单号JSON数据
        /// </summary>
        /// <param name="term"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadDeliverBillNos(string term)
        {
            //读取所有车辆数据
            string strErrText = string.Empty;
            DeliverSystem deliver = new DeliverSystem();
            List<DeliverBill> listDeliverBills = deliver.LoadDeliverBillNosByNo(term, LoginAccountId, LoginStaffName, out strErrText);
            if (listDeliverBills == null)
            {
                listDeliverBills = new List<DeliverBill>();
            }

            var ret = (from b in listDeliverBills select b.BillNo).ToArray();

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET所有国家JSON数据
        /// </summary>
        /// <param name="term"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCountrys(string term)
        {
            //读取所有国家数据
            string strErrText = string.Empty;
            DDSystem dd = new DDSystem();
            List<Country> listCountry = dd.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listCountry == null)
            {
                listCountry = new List<Country>();
            }

            //提取国家名称中包含关键字的记录
            var ret = (from c in listCountry
                       where c.Name.Contains(term)
                       select c.Name).ToArray();

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定国家的省份JSON数据
        /// </summary>
        /// <param name="term"></param>
        /// <param name="countryName"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadProvinces(string term, string countryName)
        {
            //读取指定国家的省份数据
            string strErrText = string.Empty;
            DDSystem dd = new DDSystem();
            List<Province> listProvince = dd.LoadProvincesByCountry(countryName, LoginAccountId, LoginStaffName, out strErrText);
            if (listProvince == null)
            {
                listProvince = new List<Province>();
            }

            //提取省份名称中包含关键字的记录
            var ret = from c in listProvince
                      where c.Name.Contains(term)
                      select c.Name;

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET指定国家和省份的城市JSON数据
        /// </summary>
        /// <param name="term"></param>
        /// <param name="countryName"></param>
        /// <param name="provinceName"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCitys(string term, string countryName, string provinceName)
        {
            //读取指定国家和省份的城市数据
            string strErrText = string.Empty;
            DDSystem dd = new DDSystem();
            List<City> listCity = dd.LoadCitysByProvince(countryName, provinceName, LoginAccountId, LoginStaffName, out strErrText);
            if (listCity == null)
            {
                listCity = new List<City>();
            }

            //提取城市名称中包含关键字的记录
            var ret = from c in listCity
                      where c.Name.Contains(term)
                      select c.Name;

            return Json(ret, JsonRequestBehavior.AllowGet);
        }

    }
}
