using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;
using InnoSoft.LS.Business.Facades;
using InnoSoft.LS.Models;
using SYLS.Areas.shancl.ViewModels;
using SYLS.Controllers;
using SYLS.Helper;

namespace SYLS.Areas.shancl.Controllers
{
    /// <summary>
    /// 系统设置控制器
    /// </summary>
    public class SystemController : BaseController
    {
        #region 国家操作代码

        /// <summary>
        /// GET设置国家页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetCountry()
        {
            return View();
        }

        /// <summary>
        /// GET国家表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCountrysGrid(string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            DDSystem country = new DDSystem();
            List<Country> listCountry = country.LoadCountrys(LoginAccountId, LoginStaffName, out strErrText);
            if (listCountry == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listCountry.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listCountry.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                          cell = new string[] 
                          { 
                              c.Id.ToString(), 
                              c.Name,
                              c.Remark,
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增国家页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewCountry()
        {
            //创建空的Model
            CountryViewModel model = new CountryViewModel();

            return View(model);
        }

        /// <summary>
        /// POST新增国家页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewCountry(CountryViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Country data = new Country();
                data.Name = model.Name;
                data.Remark = model.Remark ?? string.Empty;

                //保存数据
                string strErrText;
                DDSystem country = new DDSystem();
                if (country.InsertCountry(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改国家页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyCountry(string id)
        {
            string strErrText;

            //生成Model数据
            DDSystem country = new DDSystem();
            Country data = country.LoadCountry(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            CountryViewModel model = new CountryViewModel();
            model.Id = data.Id;
            model.Name = data.Name;
            model.Remark = data.Remark;

            return View(model);
        }

        /// <summary>
        /// POST修改国家页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyCountry(CountryViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Country data = new Country();
                data.Id = model.Id;
                data.Name = model.Name;
                data.Remark = model.Remark ?? string.Empty;

                //保存数据
                string strErrText;
                DDSystem country = new DDSystem();
                if (country.UpdateCountry(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除国家
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteCountry(string id)
        {
            //删除数据
            string strErrText;
            DDSystem country = new DDSystem();
            if (country.DeleteCountry(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 省份操作代码

        /// <summary>
        /// GET设置省份页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetProvince()
        {
            return View();
        }

        /// <summary>
        /// GET省份表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadProvincesGrid(string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            DDSystem province = new DDSystem();
            List<Province> listProvince = province.LoadProvinces(LoginAccountId, LoginStaffName, out strErrText);
            if (listProvince == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listProvince.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            var data = listProvince.OrderBy(p => p.Name).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                          cell = new string[] 
                          { 
                              p.Id.ToString(), 
                              p.Name,
                              p.CountryName,
                              p.Remark,
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增省份页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewProvince()
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
            ViewData["Countries"] = new SelectList(selectListCountry, "Value", "Text");

            //创建空的Model
            ProvinceViewModel model = new ProvinceViewModel();

            return View(model);
        }

        /// <summary>
        /// POST新增省份页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewProvince(ProvinceViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Province data = new Province();
                data.Name = model.Name;
                data.CountryName = model.CountryName;
                data.Remark = model.Remark ?? string.Empty;

                //保存数据
                string strErrText;
                DDSystem province = new DDSystem();
                if (province.InsertProvince(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改省份页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyProvince(string id)
        {
            string strErrText;

            //生成Model数据
            DDSystem province = new DDSystem();
            Province data = province.LoadProvince(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            ProvinceViewModel model = new ProvinceViewModel();
            model.Id = data.Id;
            model.Name = data.Name;
            model.CountryName = data.CountryName;
            model.Remark = data.Remark;

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
            ViewData["Countries"] = new SelectList(selectListCountry, "Value", "Text", model.CountryName);

            return View(model);
        }

        /// <summary>
        /// POST修改省份页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyProvince(ProvinceViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Province data = new Province();
                data.Id = model.Id;
                data.Name = model.Name;
                data.CountryName = model.CountryName;
                data.Remark = model.Remark ?? string.Empty;

                //保存数据
                string strErrText;
                DDSystem province = new DDSystem();
                if (province.UpdateProvince(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除省份
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteProvince(string id)
        {
            //删除数据
            string strErrText;
            DDSystem province = new DDSystem();
            if (province.DeleteProvince(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 城市操作代码

        /// <summary>
        /// GET设置城市页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetCity()
        {
            return View();
        }

        /// <summary>
        /// GET城市表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCitysGrid(string country, string province, string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            DDSystem city = new DDSystem();
            List<City> listCity = null;
            if (country == null || country == InnoSoft.LS.Resources.Options.SelectCountry)
            {
                listCity = city.LoadCitys(LoginAccountId, LoginStaffName, out strErrText);
            }
            else
            {
                if (province == null || province == InnoSoft.LS.Resources.Options.SelectProvince)
                {
                    listCity = city.LoadCitysByCountry(country, LoginAccountId, LoginStaffName, out strErrText);
                }
                else
                {
                    listCity = city.LoadCitysByProvince(country, province, LoginAccountId, LoginStaffName, out strErrText);
                }
            }
            if (listCity == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listCity.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            var data = listCity.OrderBy(c => c.ProvinceName).ThenBy(c => c.Name).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                          cell = new string[] 
                          { 
                              c.Id.ToString(), 
                              c.Name,
                              c.CountryName,
                              c.ProvinceName,
                              c.Remark,
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增城市页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewCity()
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
            ViewData["Countries"] = new SelectList(selectListCountry, "Value", "Text");

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
            ViewData["States"] = new SelectList(selectListState, "Value", "Text");

            //创建空的Model
            CityViewModel model = new CityViewModel();

            return View(model);
        }

        /// <summary>
        /// POST新增城市页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewCity(CityViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                City data = new City();
                data.Name = model.Name;
                data.CountryName = model.CountryName;
                data.ProvinceName = model.ProvinceName;
                data.Remark = model.Remark ?? string.Empty;

                //保存数据
                string strErrText;
                DDSystem city = new DDSystem();
                if (city.InsertCity(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改城市页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyCity(string id)
        {
            string strErrText;

            //生成Model数据
            DDSystem city = new DDSystem();
            City data = city.LoadCity(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            CityViewModel model = new CityViewModel();
            model.Id = data.Id;
            model.Name = data.Name;
            model.CountryName = data.CountryName;
            model.ProvinceName = data.ProvinceName;
            model.Remark = data.Remark;

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
            ViewData["Countries"] = new SelectList(selectListCountry, "Value", "Text", model.CountryName);

            //生成空的省份下拉列表项
            List<Province> listState = null;
            if (!string.IsNullOrEmpty(model.CountryName))
            {
                listState = dd.LoadProvincesByCountry(model.CountryName, LoginAccountId, LoginStaffName, out strErrText);
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
            selectListState.AddRange(from s in listState
                                     select new SelectListItem
                                     {
                                         Text = s.Name,
                                         Value = s.Name
                                     });
            ViewData["States"] = new SelectList(selectListState, "Value", "Text", model.ProvinceName);

            return View(model);
        }

        /// <summary>
        /// POST修改城市页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyCity(CityViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                City data = new City();
                data.Id = model.Id;
                data.Name = model.Name;
                data.CountryName = model.CountryName;
                data.ProvinceName = model.ProvinceName;
                data.Remark = model.Remark ?? string.Empty;

                //保存数据
                string strErrText;
                DDSystem city = new DDSystem();
                if (city.UpdateCity(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除城市
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteCity(string id)
        {
            //删除数据
            string strErrText;
            DDSystem city = new DDSystem();
            if (city.DeleteCity(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 货物类别操作代码

        /// <summary>
        /// GET设置货物类别页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetGoodsType()
        {
            return View();
        }

        /// <summary>
        /// GET货物类别表格数据
        /// </summary>
        /// <param name="nodeid"></param>
        /// <param name="n_level"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadGoodsTypesGrid(long? nodeid, int? n_level)
        {
            //读取全部数据
            string strErrText;
            DDSystem dd = new DDSystem();
            List<GoodsType> listGoodsType = dd.LoadGoodsTypes(LoginAccountId, LoginStaffName, out strErrText);
            if (listGoodsType == null)
            {
                throw new Exception(strErrText);
            }

            //根据父子关系生成类别树
            List<GoodsType> data = new List<GoodsType>();
            RecursiveMakeGoodsTypeTree(listGoodsType, 0, ref data);

            //返回数据
            var ret = new
            {
                page = 1,
                total = 1,
                records = data.Count,
                rows = (from t in data
                        select new
                        {
                            cell = new[] {
                                t.Name,
                                t.Id.ToString(),
                                t.Remark,
                                (t.FullPath.Where(c => c == '\\').Count() - 1).ToString(),
                                t.ParentId.ToString(),
                                data.Where(GoodsType => (GoodsType.FullPath.StartsWith(t.FullPath) && GoodsType.Id != t.Id)).Count() == 0 ? "true" : "false",
                                "true"
                            }
                        }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 根据父子关系递归生成货物类别树
        /// </summary>
        /// <param name="list">货物类别数据集</param>
        /// <param name="nParentId">上级货物类别编码</param>
        /// <param name="ret">结果集</param>
        private void RecursiveMakeGoodsTypeTree(List<GoodsType> list, long nParentId, ref List<GoodsType> ret)
        {
            foreach (GoodsType t in list.Where(GoodsType => GoodsType.ParentId == nParentId))
            {
                ret.Add(t);
                RecursiveMakeGoodsTypeTree(list, t.Id, ref ret);
            }
        }

        /// <summary>
        /// GET新增货物类别页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewGoodsType()
        {
            string strErrText;

            //生成上级货物类别下拉列表项
            DDSystem dd = new DDSystem();
            List<GoodsType> listGoodsType = dd.LoadGoodsTypes(LoginAccountId, LoginStaffName, out strErrText);
            if (listGoodsType == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListGoodsType = new List<SelectListItem>();
            selectListGoodsType.Add(new SelectListItem { Text = string.Empty, Value = "0" });
            selectListGoodsType.AddRange(from o in listGoodsType
                                         orderby o.FullName
                                         select new SelectListItem
                                         {
                                             Text = o.FullName,
                                             Value = o.Id.ToString()
                                         });
            ViewData["GoodsTypes"] = new SelectList(selectListGoodsType, "Value", "Text");

            //创建空的Model
            GoodsTypeViewModel model = new GoodsTypeViewModel();

            return View(model);
        }

        /// <summary>
        /// POST新增货物类别页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewGoodsType(GoodsTypeViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                GoodsType data = new GoodsType();
                data.Name = model.Name;
                data.ParentId = model.ParentId;
                data.Remark = model.Remark ?? string.Empty;

                //保存数据
                string strErrText;
                DDSystem dd = new DDSystem();
                if (dd.InsertGoodsType(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改货物类别页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyGoodsType(string id)
        {
            string strErrText;

            //生成Model数据
            DDSystem dd = new DDSystem();
            GoodsType data = dd.LoadGoodsType(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            GoodsTypeViewModel model = new GoodsTypeViewModel();
            model.Id = data.Id;
            model.Name = data.Name;
            model.ParentId = data.ParentId;
            model.Remark = data.Remark;

            List<GoodsType> listGoodsType = dd.LoadGoodsTypes(LoginAccountId, LoginStaffName, out strErrText);
            if (listGoodsType == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectlistGoodsType = new List<SelectListItem>();
            selectlistGoodsType.Add(new SelectListItem { Text = string.Empty, Value = "0" });
            selectlistGoodsType.AddRange(from t in listGoodsType
                                         where !t.FullPath.StartsWith(data.FullPath)
                                         orderby t.FullName
                                         select new SelectListItem
                                         {
                                             Text = t.FullName,
                                             Value = t.Id.ToString()
                                         });
            ViewData["GoodsTypes"] = new SelectList(selectlistGoodsType, "Value", "Text", model.ParentId);

            return View(model);
        }

        /// <summary>
        /// POST修改货物类别页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyGoodsType(GoodsTypeViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                GoodsType data = new GoodsType();
                data.Id = model.Id;
                data.Name = model.Name;
                data.ParentId = model.ParentId;
                data.Remark = model.Remark ?? string.Empty;

                //保存数据
                string strErrText;
                DDSystem dd = new DDSystem();
                if (dd.UpdateGoodsType(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除货物类别
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteGoodsType(string id)
        {
            //删除数据
            string strErrText;
            DDSystem dd = new DDSystem();
            if (dd.DeleteGoodsType(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
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
