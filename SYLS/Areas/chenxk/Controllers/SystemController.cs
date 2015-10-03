using InnoSoft.LS.Business.Facades;
using InnoSoft.LS.Models;
using SYLS.Areas.chenxk.ViewModels;
using SYLS.Controllers;
using SYLS.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SYLS.Areas.chenxk.Controllers
{
    /// <summary>
    /// 系统设置控制器
    /// </summary>
    public class SystemController : BaseController
    {
        #region 组织部门操作代码

        /// <summary>
        /// GET设置组织结构页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetOrganization()
        {
            return View();
        }

        /// <summary>
        /// GET组织结构图JS脚本
        /// </summary>
        /// <returns></returns>
        public ActionResult LoadOrganizationsChart()
        {
            string strErrText;

            //读取所有组织部门数据
            OrganizationSystem sys = new OrganizationSystem();
            List<Organization> listOrganization = sys.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrganization == null)
            {
                throw new Exception(strErrText);
            }

            //生成根组织部门JS脚本
            StringBuilder js = new StringBuilder();
            js.Append("<ul id='org' style='display: none'>");

            List<Organization> listRoot = listOrganization.FindAll(delegate(Organization o) { return o.ParentId == 0; });
            foreach (Organization root in listRoot)
            {
                js.Append("<li>");
                js.Append(root.Name).Append("<input type='hidden' value='" + root.Id + "' />");

                //递归生成子组织部门JS脚本
                RecursiveMakeOrganizationsChart(listOrganization, root.Id, ref js);

                js.Append("</li>");
            }
            js.Append("</ul>");

            return Content(js.ToString());
        }

        /// <summary>
        /// 递归生成组织结构图JS脚本
        /// </summary>
        /// <param name="listOrganization">组织结构数据集</param>
        /// <param name="nParentOrganId">上级组织编码</param>
        /// <param name="strIndent">组织名称缩进</param>
        private void RecursiveMakeOrganizationsChart(List<Organization> listOrganization, long nParentOrganId, ref StringBuilder js)
        {
            List<Organization> listFind = listOrganization.FindAll(delegate(Organization o) { return o.ParentId == nParentOrganId; });
            if (listFind.Count > 0)
            {
                js.Append("<ul>");

                foreach (Organization o in listFind)
                {
                    js.Append("<li>");
                    js.Append(o.Name).Append("<input type='hidden' value='" + o.Id + "' />");

                    RecursiveMakeOrganizationsChart(listOrganization, o.Id, ref js);

                    js.Append("</li>");
                }

                js.Append("</ul>");
            }
        }

        /// <summary>
        /// GET新增组织部门页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewOrganization()
        {
            string strErrText;

            //生成上级组织部门下拉列表项
            OrganizationSystem organ = new OrganizationSystem();
            List<Organization> listOrganization = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrganization == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListOrganization = new List<SelectListItem>();
            selectListOrganization.Add(new SelectListItem { Text = string.Empty, Value = "0" });
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
            ViewData["Cities"] = new SelectList(selectListCity, "Value", "Text");

            //创建空的Model
            OrganizationViewModel model = new OrganizationViewModel();

            return View(model);
        }

        /// <summary>
        /// POST新增组织部门页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewOrganization(OrganizationViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Organization data = new Organization();
                data.Name = model.Name;
                data.ParentId = model.ParentId;
                data.CountryName = model.CountryName ?? string.Empty;
                data.ProvinceName = model.StateName ?? string.Empty;
                data.CityName = model.CityName ?? string.Empty;
                data.Address = model.Address ?? string.Empty;
                data.PostalCode = model.PostalCode ?? string.Empty;
                data.Remark = model.Remark ?? string.Empty;

                //保存数据
                string strErrText;
                OrganizationSystem organ = new OrganizationSystem();
                if (organ.InsertOrganization(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改组织部门页面
        /// </summary>
        /// <param name="id">组织部门编码</param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyOrganization(string id)
        {
            string strErrText;

            //生成Model数据
            OrganizationSystem organ = new OrganizationSystem();
            Organization data = organ.LoadOrganization(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            OrganizationViewModel model = new OrganizationViewModel();
            model.Id = data.Id;
            model.Name = data.Name;
            model.ParentId = data.ParentId;
            model.CountryName = data.CountryName;
            model.StateName = data.ProvinceName;
            model.CityName = data.CityName;
            model.Address = data.Address;
            model.PostalCode = data.PostalCode;
            model.Remark = data.Remark;

            //生成上级组织部门下拉列表项
            List<Organization> listOrganization = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrganization == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListOrganization = new List<SelectListItem>();
            selectListOrganization.Add(new SelectListItem { Text = string.Empty, Value = "0" });
            selectListOrganization.AddRange(from o in listOrganization
                                            where !o.FullPath.StartsWith(data.FullPath)
                                            orderby o.FullName
                                            select new SelectListItem
                                            {
                                                Text = o.FullName,
                                                Value = o.Id.ToString()
                                            });
            ViewData["Organizations"] = new SelectList(selectListOrganization, "Value", "Text", model.ParentId);

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
            ViewData["States"] = new SelectList(selectListState, "Value", "Text", model.StateName);

            //生成空的城市下拉列表项
            List<City> listCity = null;
            if (!string.IsNullOrEmpty(model.StateName))
            {
                listCity = dd.LoadCitysByProvince(model.CountryName, model.StateName, LoginAccountId, LoginStaffName, out strErrText);
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
            ViewData["Cities"] = new SelectList(selectListCity, "Value", "Text", model.CityName);

            return View(model);
        }

        /// <summary>
        /// POST修改组织部门页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyOrganization(OrganizationViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Organization data = new Organization();
                data.Id = model.Id;
                data.Name = model.Name;
                data.ParentId = model.ParentId;
                data.CountryName = model.CountryName ?? string.Empty;
                data.ProvinceName = model.StateName ?? string.Empty;
                data.CityName = model.CityName ?? string.Empty;
                data.Address = model.Address ?? string.Empty;
                data.PostalCode = model.PostalCode ?? string.Empty;
                data.Remark = model.Remark ?? string.Empty;

                //保存数据
                string strErrText;
                OrganizationSystem organ = new OrganizationSystem();
                if (organ.UpdateOrganization(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除组织部门
        /// </summary>
        /// <param name="id">组织部门编码</param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteOrganization(string id)
        {
            //删除数据
            string strErrText;
            OrganizationSystem organ = new OrganizationSystem();
            if (organ.DeleteOrganization(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 岗位操作代码

        /// <summary>
        /// GET设置岗位页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetPosition()
        {
            return View();
        }

        /// <summary>
        /// GET岗位表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPositionsGrid(string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            PositionSystem position = new PositionSystem();
            List<Position> listPosition = position.LoadPositions(LoginAccountId, LoginStaffName, out strErrText);
            if (listPosition == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listPosition.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listPosition.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                          cell = new string[] { p.Id.ToString(), p.Name, p.Remark }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增岗位页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewPosition()
        {
            //创建空的Model
            PositionViewModel model = new PositionViewModel();

            return View(model);
        }

        /// <summary>
        /// POST新增岗位页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewPosition(PositionViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Position data = new Position();
                data.Name = model.Name;
                data.Remark = model.Remark ?? string.Empty;

                //保存数据
                string strErrText;
                PositionSystem position = new PositionSystem();
                if (position.InsertPosition(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改岗位页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyPosition(string id)
        {
            string strErrText;

            //生成Model数据
            PositionSystem position = new PositionSystem();
            Position data = position.LoadPosition(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            PositionViewModel model = new PositionViewModel();
            model.Id = data.Id;
            model.Name = data.Name;
            model.Remark = data.Remark;

            return View(model);
        }

        /// <summary>
        /// POST修改岗位页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyPosition(PositionViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Position data = new Position();
                data.Id = model.Id;
                data.Name = model.Name;
                data.Remark = model.Remark ?? string.Empty;

                //保存数据
                string strErrText;
                PositionSystem position = new PositionSystem();
                if (position.UpdatePosition(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除岗位
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeletePosition(string id)
        {
            //删除数据
            string strErrText;
            PositionSystem position = new PositionSystem();
            if (position.DeletePosition(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 员工操作代码

        /// <summary>
        /// GET设置员工页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetStaff()
        {
            return View();
        }

        /// <summary>
        /// GET员工表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadStaffsGrid(string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            StaffSystem staff = new StaffSystem();
            List<Staff> listStaff = staff.LoadStaffs(LoginAccountId, LoginStaffName, out strErrText);
            if (listStaff == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listStaff.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "StaffId") + " " + (sord ?? "ASC");
            var data = listStaff.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                          cell = new string[] 
                          { 
                              s.Id.ToString(), 
                              s.FullName,
                              s.Sex,
                              s.OrganFullName,
                              s.PositionName,
                              s.BossStaffName,
                              s.OfficeTel,
                              s.TelExt,
                              s.MobileTel1,
                              s.QQ
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增员工页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewStaff()
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

            //生成岗位下拉列表项
            PositionSystem position = new PositionSystem();
            List<Position> listPosition = position.LoadPositions(LoginAccountId, LoginStaffName, out strErrText);
            if (listPosition == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListPosition = new List<SelectListItem>();
            selectListPosition.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListPosition.AddRange(from p in listPosition
                                        select new SelectListItem
                                        {
                                            Text = p.Name,
                                            Value = p.Id.ToString()
                                        });

            ViewData["Positions"] = new SelectList(selectListPosition, "Value", "Text");

            //生成上司下拉列表项
            StaffSystem staff = new StaffSystem();
            List<Staff> listStaff = staff.LoadStaffs(LoginAccountId, LoginStaffName, out strErrText);
            if (listStaff == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStaff = new List<SelectListItem>();
            selectListStaff.Add(new SelectListItem { Text = string.Empty, Value = "0" });
            selectListStaff.AddRange(from s in listStaff
                                     select new SelectListItem
                                     {
                                         Text = s.FullName,
                                         Value = s.Id.ToString()
                                     });
            ViewData["Bosses"] = new SelectList(selectListStaff, "Value", "Text");

            //创建空的Model
            StaffViewModel model = new StaffViewModel();

            return View(model);
        }

        /// <summary>
        /// POST新增员工页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewStaff(StaffViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Staff data = new Staff();
                data.FamilyName = model.FamilyName;
                data.Name = model.Name ?? string.Empty;
                data.Sex = model.Sex;
                data.OrganId = model.OrganId;
                data.PositionId = model.PositionId;
                data.OfficeTel = model.OfficeTel ?? string.Empty;
                data.TelExt = model.TelExt ?? string.Empty;
                data.Fax = model.Fax ?? string.Empty;
                data.MobileTel1 = model.MobileTel1;
                data.MobileTel2 = model.MobileTel2 ?? string.Empty;
                data.MobileTel3 = model.MobileTel3 ?? string.Empty;
                data.EMail = model.EMail ?? string.Empty;
                data.QQ = model.QQ ?? string.Empty;
                data.IsOrganManager = model.IsOrganManager;
                data.IsOrganLeader = model.IsOrganLeader;
                data.BossStaffId = model.BossStaffId;

                //保存数据
                string strErrText;
                StaffSystem staff = new StaffSystem();
                if (staff.InsertStaff(data, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// GET修改员工页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyStaff(string id)
        {
            string strErrText;

            //生成Model数据
            long nStaffId = long.Parse(id);
            StaffSystem staff = new StaffSystem();
            Staff data = staff.LoadStaff(nStaffId, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            StaffViewModel model = new StaffViewModel();
            model.Id = data.Id;
            model.FamilyName = data.FamilyName;
            model.Name = data.Name;
            model.Sex = data.Sex;
            model.OrganId = data.OrganId;
            model.PositionId = data.PositionId;
            model.OfficeTel = data.OfficeTel;
            model.TelExt = data.TelExt;
            model.Fax = data.Fax;
            model.MobileTel1 = data.MobileTel1;
            model.MobileTel2 = data.MobileTel2;
            model.MobileTel3 = data.MobileTel3;
            model.EMail = data.EMail;
            model.QQ = data.QQ;
            model.IsOrganManager = data.IsOrganManager;
            model.IsOrganLeader = data.IsOrganLeader;
            model.BossStaffId = data.BossStaffId;

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
            ViewData["Organizations"] = new SelectList(selectListOrganization, "Value", "Text", model.OrganId);

            //生成岗位下拉列表项
            PositionSystem position = new PositionSystem();
            List<Position> listPosition = position.LoadPositions(LoginAccountId, LoginStaffName, out strErrText);
            if (listPosition == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListPosition = new List<SelectListItem>();
            selectListPosition.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListPosition.AddRange(from p in listPosition
                                        select new SelectListItem
                                        {
                                            Text = p.Name,
                                            Value = p.Id.ToString()
                                        });

            ViewData["Positions"] = new SelectList(selectListPosition, "Value", "Text", model.PositionId);

            //生成上司下拉列表项
            List<Staff> listStaff = staff.LoadStaffsExcludeSelfAndSubordinates(nStaffId, LoginAccountId, LoginStaffName, out strErrText);
            if (listStaff == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStaff = new List<SelectListItem>();
            selectListStaff.Add(new SelectListItem { Text = string.Empty, Value = "0" });
            selectListStaff.AddRange(from s in listStaff
                                     select new SelectListItem
                                     {
                                         Text = s.FullName,
                                         Value = s.Id.ToString()
                                     });
            ViewData["Bosses"] = new SelectList(selectListStaff, "Value", "Text", model.BossStaffId);

            return View(model);
        }

        /// <summary>
        /// POST修改员工页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyStaff(StaffViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Staff data = new Staff();
                data.Id = model.Id;
                data.FamilyName = model.FamilyName;
                data.Name = model.Name ?? string.Empty;
                data.Sex = model.Sex;
                data.OrganId = model.OrganId;
                data.PositionId = model.PositionId;
                data.OfficeTel = model.OfficeTel ?? string.Empty;
                data.TelExt = model.TelExt ?? string.Empty;
                data.Fax = model.Fax ?? string.Empty;
                data.MobileTel1 = model.MobileTel1;
                data.MobileTel2 = model.MobileTel2 ?? string.Empty;
                data.MobileTel3 = model.MobileTel3 ?? string.Empty;
                data.EMail = model.EMail ?? string.Empty;
                data.QQ = model.QQ ?? string.Empty;
                data.IsOrganManager = model.IsOrganManager;
                data.IsOrganLeader = model.IsOrganLeader;
                data.BossStaffId = model.BossStaffId;

                //保存数据
                string strErrText;
                StaffSystem staff = new StaffSystem();
                if (staff.UpdateStaff(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除员工
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteStaff(string id)
        {
            long nStaffId = long.Parse(id);
            if (nStaffId == LoginStaffId)
            {
                return Json(InnoSoft.LS.Resources.Strings.CanNotDeleteLoginStaff);
            }

            //删除数据
            string strErrText;
            StaffSystem staff = new StaffSystem();
            if (staff.DeleteStaff(nStaffId, LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// GET导出员工
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportStaffs()
        {
            string strErrText;

            //读取全部数据
            StaffSystem staff = new StaffSystem();
            List<Staff> listStaff = staff.LoadStaffs(LoginAccountId, LoginStaffName, out strErrText);
            if (listStaff == null)
            {
                throw new Exception(strErrText);
            }

            //生成GridView
            BoundField colStaffId = new BoundField();
            colStaffId.HeaderText = InnoSoft.LS.Resources.Labels.StaffId;
            colStaffId.DataField = "StaffId";

            BoundField colStaffName = new BoundField();
            colStaffName.HeaderText = InnoSoft.LS.Resources.Labels.StaffName;
            colStaffName.DataField = "StaffName";

            BoundField colSex = new BoundField();
            colSex.HeaderText = InnoSoft.LS.Resources.Labels.Sex;
            colSex.DataField = "Sex";

            BoundField colOrganFullName = new BoundField();
            colOrganFullName.HeaderText = InnoSoft.LS.Resources.Labels.OrganName;
            colOrganFullName.DataField = "OrganFullName";

            BoundField colPositionName = new BoundField();
            colPositionName.HeaderText = InnoSoft.LS.Resources.Labels.PositionName;
            colPositionName.DataField = "PositionName";

            BoundField colOfficeTel = new BoundField();
            colOfficeTel.HeaderText = InnoSoft.LS.Resources.Labels.Tel;
            colOfficeTel.DataField = "OfficeTel";

            BoundField colTelExt = new BoundField();
            colTelExt.HeaderText = InnoSoft.LS.Resources.Labels.TelExt;
            colTelExt.DataField = "TelExt";

            BoundField colFax = new BoundField();
            colFax.HeaderText = InnoSoft.LS.Resources.Labels.Fax;
            colFax.DataField = "Fax";

            BoundField colMobileTel1 = new BoundField();
            colMobileTel1.HeaderText = InnoSoft.LS.Resources.Labels.MobileTel + "1";
            colMobileTel1.DataField = "MobileTel1";

            BoundField colMobileTel2 = new BoundField();
            colMobileTel2.HeaderText = InnoSoft.LS.Resources.Labels.MobileTel + "2";
            colMobileTel2.DataField = "MobileTel2";

            BoundField colMobileTel3 = new BoundField();
            colMobileTel3.HeaderText = InnoSoft.LS.Resources.Labels.MobileTel + "3";
            colMobileTel3.DataField = "MobileTel3";

            BoundField colEMail = new BoundField();
            colEMail.HeaderText = InnoSoft.LS.Resources.Labels.EMail;
            colEMail.DataField = "EMail";

            BoundField colQQ = new BoundField();
            colQQ.HeaderText = InnoSoft.LS.Resources.Labels.QQ;
            colQQ.DataField = "QQ";

            BoundField colBossName = new BoundField();
            colBossName.HeaderText = InnoSoft.LS.Resources.Labels.BossName;
            colBossName.DataField = "BossName";

            BoundField colIsOrganLeader = new BoundField();
            colIsOrganLeader.HeaderText = InnoSoft.LS.Resources.Labels.IsOrganLeader;
            colIsOrganLeader.DataField = "IsOrganLeader";

            BoundField colIsOrganManager = new BoundField();
            colIsOrganManager.HeaderText = InnoSoft.LS.Resources.Labels.IsOrganManager;
            colIsOrganManager.DataField = "IsOrganManager";

            var grid = new GridView();
            grid.Columns.Add(colStaffId);
            grid.Columns.Add(colStaffName);
            grid.Columns.Add(colSex);
            grid.Columns.Add(colOrganFullName);
            grid.Columns.Add(colPositionName);
            grid.Columns.Add(colOfficeTel);
            grid.Columns.Add(colTelExt);
            grid.Columns.Add(colFax);
            grid.Columns.Add(colMobileTel1);
            grid.Columns.Add(colMobileTel2);
            grid.Columns.Add(colMobileTel3);
            grid.Columns.Add(colEMail);
            grid.Columns.Add(colQQ);
            grid.Columns.Add(colBossName);
            grid.Columns.Add(colIsOrganLeader);
            grid.Columns.Add(colIsOrganManager);
            grid.AutoGenerateColumns = false;
            grid.DataSource = from s in listStaff
                              select new
                              {
                                  StaffId = s.Id,
                                  StaffName = s.FullName,
                                  Sex = s.Sex,
                                  OrganFullName = s.OrganFullName,
                                  PositionName = s.PositionName,
                                  OfficeTel = s.OfficeTel,
                                  TelExt = s.TelExt,
                                  Fax = s.Fax,
                                  MobileTel1 = s.MobileTel1,
                                  MobileTel2 = s.MobileTel2,
                                  MobileTel3 = s.MobileTel3,
                                  EMail = s.EMail,
                                  QQ = s.QQ,
                                  BossName = s.BossStaffName,
                                  IsOrganLeader = s.IsOrganLeader ? InnoSoft.LS.Resources.Options.Yes : InnoSoft.LS.Resources.Options.No,
                                  IsOrganManager = s.IsOrganManager ? InnoSoft.LS.Resources.Options.Yes : InnoSoft.LS.Resources.Options.No
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=Staff.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

            return View("SetStaff");
        }

        /// <summary>
        /// GET查看员工详细信息页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ViewStaffDetails(string id)
        {
            string strErrText;

            //生成Model数据
            long nStaffId = long.Parse(id);
            StaffSystem staff = new StaffSystem();
            Staff data = staff.LoadStaff(nStaffId, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            StaffViewModel model = new StaffViewModel();
            model.Id = data.Id;
            model.FamilyName = data.FamilyName;
            model.Name = data.Name;
            model.Sex = data.Sex;
            model.OrganId = data.OrganId;
            model.OrganName = data.OrganName;
            model.OrganFullName = data.OrganFullName;
            model.PositionId = data.PositionId;
            model.PositionName = data.PositionName;
            model.OfficeTel = data.OfficeTel;
            model.TelExt = data.TelExt;
            model.Fax = data.Fax;
            model.MobileTel1 = data.MobileTel1;
            model.MobileTel2 = data.MobileTel2;
            model.MobileTel3 = data.MobileTel3;
            model.EMail = data.EMail;
            model.QQ = data.QQ;
            model.IsOrganManager = data.IsOrganManager;
            model.IsOrganLeader = data.IsOrganLeader;
            model.BossStaffId = data.BossStaffId;
            model.BossStaffName = data.BossStaffName;

            return View(model);
        }

        #endregion

        #region 帐号操作代码

        /// <summary>
        /// GET设置帐号页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetAccount()
        {
            return View();
        }

        /// <summary>
        /// GET帐号表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadAccountsGrid(string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            AuthenticateSystem auth = new AuthenticateSystem();
            List<Account> listAccount = auth.LoadAccounts(LoginAccountId, LoginStaffName, out strErrText);
            if (listAccount == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listAccount.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listAccount.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from a in data
                      select new
                      {
                          id = a.Id,
                          cell = new string[] 
                          { 
                              a.Id.ToString(), 
                              a.Name,
                              a.AccountType,
                              a.OrganFullName,
                              a.StaffName,
                              a.IsCancel.ToString()
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET活动帐号表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadActiveAccountsGrid(string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            AuthenticateSystem auth = new AuthenticateSystem();
            List<Account> listAccount = auth.LoadActiveAccounts(LoginAccountId, LoginStaffName, out strErrText);
            if (listAccount == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listAccount.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listAccount.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from a in data
                      select new
                      {
                          id = a.Id,
                          cell = new string[] 
                          { 
                              a.Id.ToString(), 
                              a.Name,
                              a.AccountType,
                              a.OrganFullName,
                              a.StaffName
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增帐号页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewAccount()
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
            selectListOrganization.Add(new SelectListItem { Text = string.Empty, Value = "0" });
            selectListOrganization.AddRange(from o in listOrganization
                                            orderby o.FullName
                                            select new SelectListItem
                                            {
                                                Text = o.FullName,
                                                Value = o.Id.ToString()
                                            });
            ViewData["Organizations"] = new SelectList(selectListOrganization, "Value", "Text");

            //生成空的员工下拉列表项
            List<Staff> listStaff = new List<Staff>();
            List<SelectListItem> selectListStaff = new List<SelectListItem>();
            selectListStaff.Add(new SelectListItem { Text = string.Empty, Value = "0" });
            selectListStaff.AddRange(from s in listStaff
                                     select new SelectListItem
                                     {
                                         Text = s.Name,
                                         Value = s.Id.ToString()
                                     });
            ViewData["Staffs"] = new SelectList(selectListStaff, "Value", "Text");

            //生成空的客户下拉列表项
            List<Customer> listCustomer = new List<Customer>();
            List<SelectListItem> selectListCustomer = new List<SelectListItem>();
            selectListCustomer.Add(new SelectListItem { Text = string.Empty, Value = "0" });
            selectListCustomer.AddRange(from c in listCustomer
                                        select new SelectListItem
                                        {
                                            Text = c.Name,
                                            Value = c.Id.ToString()
                                        });
            ViewData["Customers"] = new SelectList(selectListCustomer, "Value", "Text");

            //创建空的Model
            AccountViewModel model = new AccountViewModel();

            return View(model);
        }

        /// <summary>
        /// POST新增帐号页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewAccount(AccountViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.AccountType == InnoSoft.LS.Resources.Options.Staff)
                {
                    if (model.OrganId == 0)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotSelectedOrgan);
                    }
                    if (model.StaffId == 0)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotSelectedStaff);
                    }
                }
                else
                {
                    if (model.CustomerId == 0)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotSelectedCustomer);
                    }
                    if (model.ContactName.Trim() == string.Empty)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterContactName);
                    }
                }

                //创建数据
                Account data = new Account();
                data.Name = model.Name;
                data.AccountType = model.AccountType;
                data.OrganId = model.AccountType == InnoSoft.LS.Resources.Options.Staff ? model.OrganId : model.CustomerId;
                data.StaffId = model.AccountType == InnoSoft.LS.Resources.Options.Staff ? model.StaffId : 0;
                data.StaffName = model.AccountType == InnoSoft.LS.Resources.Options.Staff ? string.Empty : model.ContactName;

                //保存数据
                string strErrText;
                AuthenticateSystem auth = new AuthenticateSystem();
                if (auth.InsertAccount(data, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// GET修改帐号页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyAccount(string id)
        {
            string strErrText;

            //生成Model数据
            long nAccountId = long.Parse(id);
            AuthenticateSystem auth = new AuthenticateSystem();
            Account data = auth.LoadAccount(nAccountId, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            AccountViewModel model = new AccountViewModel();
            model.Id = data.Id;
            model.Name = data.Name;
            model.Password = data.Password;
            model.AccountType = data.AccountType;
            model.OrganId = data.AccountType == InnoSoft.LS.Resources.Options.Staff ? data.OrganId : 0;
            model.StaffId = data.AccountType == InnoSoft.LS.Resources.Options.Staff ? data.StaffId : 0;
            model.CustomerId = data.AccountType == InnoSoft.LS.Resources.Options.Staff ? 0 : data.OrganId;
            model.ContactName = data.AccountType == InnoSoft.LS.Resources.Options.Staff ? string.Empty : data.StaffName;
            model.IsCancel = data.IsCancel;

            if (data.AccountType == InnoSoft.LS.Resources.Options.Staff)
            {
                //生成组织部门下拉列表
                OrganizationSystem organ = new OrganizationSystem();
                List<Organization> listOrganization = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
                if (listOrganization == null)
                {
                    throw new Exception(strErrText);
                }
                List<SelectListItem> selectListOrganization = new List<SelectListItem>();
                selectListOrganization.Add(new SelectListItem { Text = string.Empty, Value = "0" });
                selectListOrganization.AddRange(from o in listOrganization
                                                orderby o.FullName
                                                select new SelectListItem
                                                {
                                                    Text = o.FullName,
                                                    Value = o.Id.ToString()
                                                });
                ViewData["Organizations"] = new SelectList(selectListOrganization, "Value", "Text", model.OrganId);

                //生成空的客户下拉列表
                List<Customer> listCustomer = new List<Customer>();
                List<SelectListItem> selectListCustomer = new List<SelectListItem>();
                selectListCustomer.Add(new SelectListItem { Text = string.Empty, Value = "0" });
                selectListCustomer.AddRange(from c in listCustomer
                                            select new SelectListItem
                                            {
                                                Text = c.Name,
                                                Value = c.Id.ToString()
                                            });
                ViewData["Customers"] = new SelectList(selectListCustomer, "Value", "Text");
            }
            else
            {
                //生成空的组织部门下拉列表
                {
                    List<Organization> listOrganization = new List<Organization>();
                    List<SelectListItem> selectListOrganization = new List<SelectListItem>();
                    selectListOrganization.Add(new SelectListItem { Text = string.Empty, Value = "0" });
                    selectListOrganization.AddRange(from o in listOrganization
                                                    select new SelectListItem
                                                    {
                                                        Text = o.FullName,
                                                        Value = o.Id.ToString()
                                                    });
                    ViewData["Organizations"] = new SelectList(selectListOrganization, "Value", "Text");
                }

                //生成客户下拉列表
                CustomerSystem customer = new CustomerSystem();
                List<Customer> listCustomer = customer.LoadCustomers(LoginAccountId, LoginStaffName, out strErrText);
                if (listCustomer == null)
                {
                    throw new Exception(strErrText);
                }
                List<SelectListItem> selectListCustomer = new List<SelectListItem>();
                selectListCustomer.Add(new SelectListItem { Text = string.Empty, Value = "0" });
                selectListCustomer.AddRange(from c in listCustomer
                                            orderby c.Name
                                            select new SelectListItem
                                            {
                                                Text = c.Name,
                                                Value = c.Id.ToString()
                                            });
                ViewData["Customers"] = new SelectList(selectListCustomer, "Value", "Text", model.OrganId);
            }

            //生成员工下拉列表
            if (data.AccountType == InnoSoft.LS.Resources.Options.Staff)
            {
                StaffSystem staff = new StaffSystem();
                List<Staff> listStaff = staff.LoadStaffsByOrganId(model.OrganId, LoginAccountId, LoginStaffName, out strErrText);
                if (listStaff == null)
                {
                    throw new Exception(strErrText);
                }
                List<SelectListItem> selectListStaff = new List<SelectListItem>();
                selectListStaff.Add(new SelectListItem { Text = string.Empty, Value = "0" });
                selectListStaff.AddRange(from s in listStaff
                                         select new SelectListItem
                                         {
                                             Text = s.FullName,
                                             Value = s.Id.ToString()
                                         });

                ViewData["Staffs"] = new SelectList(selectListStaff, "Value", "Text", model.StaffId);
            }
            else
            {
                List<Staff> listStaff = new List<Staff>();
                List<SelectListItem> selectListStaff = new List<SelectListItem>();
                selectListStaff.Add(new SelectListItem { Text = string.Empty, Value = "0" });
                selectListStaff.AddRange(from s in listStaff
                                         select new SelectListItem
                                         {
                                             Text = s.Name,
                                             Value = s.Id.ToString()
                                         });
                ViewData["Staffs"] = new SelectList(selectListStaff, "Value", "Text");
            }

            return View(model);
        }

        /// <summary>
        /// POST修改帐号页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyAccount(AccountViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.AccountType == InnoSoft.LS.Resources.Options.Staff)
                {
                    if (model.OrganId == 0)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotSelectedOrgan);
                    }
                    if (model.StaffId == 0)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotSelectedStaff);
                    }
                }
                else
                {
                    if (model.CustomerId == 0)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotSelectedCustomer);
                    }
                    if (model.ContactName.Trim() == string.Empty)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterContactName);
                    }
                }

                //创建数据
                Account data = new Account();
                data.Id = model.Id;
                data.Name = model.Name;
                data.Password = model.Password;
                data.AccountType = model.AccountType;
                data.OrganId = model.AccountType == InnoSoft.LS.Resources.Options.Staff ? model.OrganId : model.CustomerId;
                data.StaffId = model.AccountType == InnoSoft.LS.Resources.Options.Staff ? model.StaffId : 0;
                data.StaffName = model.AccountType == InnoSoft.LS.Resources.Options.Staff ? string.Empty : model.ContactName;
                data.IsCancel = model.IsCancel;

                //保存数据
                string strErrText;
                AuthenticateSystem auth = new AuthenticateSystem();
                if (auth.UpdateAccount(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除帐号页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteAccount(string id)
        {
            long nAccountId = long.Parse(id);
            if (nAccountId == LoginAccountId)
            {
                return Json(InnoSoft.LS.Resources.Strings.CanNotDeleteLoginAccount);
            }

            //删除数据
            string strErrText;
            AuthenticateSystem auth = new AuthenticateSystem();
            if (auth.DeleteAccount(nAccountId, LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// POST注销帐号页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult CancelAccount(string id)
        {
            long nAccountId = long.Parse(id);
            if (nAccountId == LoginAccountId)
            {
                return Json(InnoSoft.LS.Resources.Strings.CanNotCancelLoginAccount);
            }

            //修改数据
            string strErrText;
            AuthenticateSystem auth = new AuthenticateSystem();
            if (auth.CancelAccount(nAccountId, LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 权限操作

        /// <summary>
        /// GET设置权限组页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetPermissionGroup()
        {
            return View();
        }

        /// <summary>
        /// GET权限组表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPermissionGroupsGrid(string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            PermissionSystem permission = new PermissionSystem();
            List<SysGroup> listGroup = permission.LoadPermissionGroups(LoginAccountId, LoginStaffName, out strErrText);
            if (listGroup == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listGroup.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "GroupId") + " " + (sord ?? "ASC");
            var data = listGroup.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                          cell = new string[] { g.Id.ToString(), g.Name, g.Remark }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET组权限表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadGroupPermissionsGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            PermissionSystem permission = new PermissionSystem();
            List<SysGroupPermission> listPermission = permission.LoadGroupPermissions(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (listPermission == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listPermission.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "FuncId") + " " + (sord ?? "ASC");
            var data = listPermission.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                          id = f.FuncId,
                          cell = new string[] 
                          { 
                              f.FuncId.ToString(), 
                              f.FuncName, 
                              f.AllowOpen.ToString(),
                              f.AllowNew.ToString(),
                              f.AllowModify.ToString(),
                              f.AllowDelete.ToString(),
                              f.AllowCancel.ToString(),
                              f.AllowDetail.ToString(),
                              f.AllowSearch.ToString(),
                              f.AllowSubmit.ToString(),
                              f.AllowApprove.ToString(),
                              f.AllowDispatch.ToString(),
                              f.AllowExport.ToString(),
                              f.AllowImport.ToString(),
                              f.AllowPrint.ToString()
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET组权限JSON数据
        /// </summary>
        /// <param name="nGroupId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadGroupPermissions(long nGroupId)
        {
            //读取全部数据
            string strErrText;
            PermissionSystem permission = new PermissionSystem();
            List<SysGroupPermission> listPermission = permission.LoadGroupPermissions(nGroupId, LoginAccountId, LoginStaffName, out strErrText);
            if (listPermission == null)
            {
                throw new Exception(strErrText);
            }

            return Json(listPermission, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET系统功能表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadFunctionsGrid(string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            PermissionSystem permission = new PermissionSystem();
            List<SysFunction> listFunction = permission.LoadFunctions(LoginAccountId, LoginStaffName, out strErrText);
            if (listFunction == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listFunction.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listFunction.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                          cell = new string[] 
                          { 
                              f.Id.ToString(), 
                              f.Name, 
                              f.AllowOpen ? "O" : "X",
                              f.AllowNew ? "O" : "X",
                              f.AllowModify ? "O" : "X",
                              f.AllowDelete ? "O" : "X",
                              f.AllowCancel ? "O" : "X",
                              f.AllowDetail ? "O" : "X",
                              f.AllowSearch ? "O" : "X",
                              f.AllowSubmit ? "O" : "X",
                              f.AllowApprove ? "O" : "X",
                              f.AllowDispatch ? "O" : "X",
                              f.AllowExport ? "O" : "X",
                              f.AllowImport ? "O" : "X",
                              f.AllowPrint ? "O" : "X"
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增权限组页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewPermissionGroup()
        {
            //创建空的Model
            PermissionGroupViewModel model = new PermissionGroupViewModel();

            return View(model);
        }

        /// <summary>
        /// POST新增权限组页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewPermissionGroup(PermissionGroupViewModel model)
        {
            if (ModelState.IsValid)
            {
                //保存数据
                string strErrText;
                PermissionSystem permission = new PermissionSystem();
                if (permission.InsertPermissionGroup(model.Name, model.Remark ?? string.Empty, model.Functions, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// GET修改权限组页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyPermissionGroup(string id)
        {
            string strErrText;

            //生成Model数据
            long nGroupId = long.Parse(id);
            PermissionSystem permission = new PermissionSystem();
            SysGroup data = permission.LoadPermissionGroup(nGroupId, LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            PermissionGroupViewModel model = new PermissionGroupViewModel();
            model.Id = data.Id;
            model.Name = data.Name;
            model.Remark = data.Remark;

            return View(model);
        }

        /// <summary>
        /// POST修改权限页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyPermissionGroup(PermissionGroupViewModel model)
        {
            if (ModelState.IsValid)
            {
                //保存数据
                string strErrText;
                PermissionSystem permission = new PermissionSystem();
                if (permission.UpdatePermissionGroup(model.Id, model.Name, model.Remark ?? string.Empty, model.Functions, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除权限组
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeletePermissionGroup(string id)
        {
            //删除数据
            string strErrText;
            PermissionSystem permission = new PermissionSystem();
            if (permission.DeletePermissionGroup(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// GET帐号权限JSON数据
        /// </summary>
        /// <param name="nAccountId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadAccountPermissions(long nAccountId)
        {
            //读取全部数据
            string strErrText;
            PermissionSystem permission = new PermissionSystem();
            List<AccountPermission> listPermission = permission.LoadAccountPermissions(nAccountId, LoginAccountId, LoginStaffName, out strErrText);
            if (listPermission == null)
            {
                throw new Exception(strErrText);
            }

            return Json(listPermission, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET分配权限页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult AssignPermissions()
        {
            return View();
        }

        /// <summary>
        /// POST分配权限页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult AssignPermissions(AccountPermissionViewModel model)
        {
            if (ModelState.IsValid)
            {
                //保存数据
                string strErrText;
                PermissionSystem permission = new PermissionSystem();
                if (permission.UpdateAccountPermissions(model.AccountId, model.Groups, LoginAccountId, LoginStaffName, out strErrText))
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

        #region 密码操作代码

        /// <summary>
        /// GET修改密码页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyPassword()
        {
            return View();
        }

        /// <summary>
        /// POST修改密码页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyPassword(ModifyPasswordViewModel model)
        {
            if (ModelState.IsValid)
            {
                //保存数据
                string strErrText;
                AuthenticateSystem auth = new AuthenticateSystem();
                if (auth.UpdatePassword(model.OldPassword, model.NewPassword, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET初始化密码页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ResetPassword()
        {
            string strErrText;

            //生成帐号下拉列表项
            AuthenticateSystem auth = new AuthenticateSystem();
            List<Account> listAccount = auth.LoadActiveAccounts(LoginAccountId, LoginStaffName, out strErrText);
            if (listAccount == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListAccount = new List<SelectListItem>();
            selectListAccount.Add(new SelectListItem { Text = string.Empty, Value = "0" });
            selectListAccount.AddRange(from a in listAccount
                                       orderby a.Name
                                       select new SelectListItem
                                       {
                                           Text = a.Name,
                                           Value = a.Id.ToString()
                                       });
            ViewData["Accounts"] = new SelectList(selectListAccount, "Value", "Text");

            return View();
        }

        /// <summary>
        /// POST初始化密码页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ResetPassword(ResetPasswordViewModel model)
        {
            if (ModelState.IsValid)
            {
                //保存数据
                string strErrText;
                AuthenticateSystem auth = new AuthenticateSystem();
                if (auth.ResetPassword(model.AccountId, model.NewPassword, LoginAccountId, LoginStaffName, out strErrText))
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

        #region 客户操作代码

        /// <summary>
        /// GET设置客户页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetCustomer()
        {
            return View();
        }

        /// <summary>
        /// GET客户表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="customerName"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCustomersGrid(string sidx, string sord, int page, int rows, string customerName)
        {
            //读取全部数据
            string strErrText;
            CustomerSystem customer = new CustomerSystem();
            List<Customer> listCustomer = customer.LoadCustomersByConditions(customerName, LoginAccountId, LoginStaffName, out strErrText);
            if (listCustomer == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listCustomer.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "CustomerId") + " " + (sord ?? "ASC");
            var data = listCustomer.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              c.FullName,
                              c.WarningStock.ToString(),
                              c.StopStock.ToString(),
                              c.SettlementExpression,
                              c.ValuationMode,
                              c.GrossWeightRate.ToString("#0.######"),
                              c.OwnOrganName,
                              c.Remark
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET客户结算价格表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCustomerTransportPriceGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            CustomerSystem customer = new CustomerSystem();
            List<CustomerTransportPrice> listPrice = customer.LoadCustomerTransportPricesByCustomerId(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
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

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
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
                          cell = new string[] 
                          { 
                              p.Id.ToString(), 
                              p.StartCountry,
                              p.StartProvince,
                              p.StartCity,
                              p.DestCountry,
                              p.DestProvince,
                              p.DestCity,
                              p.MinTunnagesOrPiles.ToString("#0.######"),
                              p.MaxTunnagesOrPiles.ToString("#0.######"),
                              p.StartTime.ToString("yyyy-MM-dd"),
                              p.EndTime.ToString("yyyy-MM-dd"),
                              p.CarType,
                              p.TransportPrice.ToString("#0.######"),
                              p.RiverCrossingCharges.ToString()
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET客户力支费价格表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCustomerForceFeePriceGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            CustomerSystem customer = new CustomerSystem();
            List<CustomerForceFeePrice> listPrice = customer.LoadCustomerForceFeePricesByCustomerId(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
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

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
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
                          cell = new string[] 
                          { 
                              p.Id.ToString(), 
                              p.StartTime.ToString("yyyy-MM-dd"),
                              p.EndTime.ToString("yyyy-MM-dd"),
                              p.LoadingForceFeePrice.ToString(),
                              p.UnloadingForceFeePrice.ToString()
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET客户仓储费价格表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCustomerStorageFeePriceGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            CustomerSystem customer = new CustomerSystem();
            List<CustomerStorageFeePrice> listPrice = customer.LoadCustomerStorageFeePricesByCustomerId(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
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

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
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
                          cell = new string[] 
                          { 
                              p.Id.ToString(), 
                              p.StartTime.ToString("yyyy-MM-dd"),
                              p.EndTime.ToString("yyyy-MM-dd"),
                              p.StorageFeePrice.ToString()
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增客户页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewCustomer()
        {
            string strErrText;

            //生成所属组织部门下拉列表项
            OrganizationSystem organ = new OrganizationSystem();
            List<Organization> listOrgan = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrgan == null)
            {
                throw new Exception(strErrText);
            }
            Organization root = listOrgan.Find(delegate(Organization o) { return o.ParentId == 0; });
            List<SelectListItem> selectListOrgan = new List<SelectListItem>();
            selectListOrgan.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListOrgan.AddRange(from o in listOrgan
                                     where o.ParentId == root.Id
                                     select new SelectListItem
                                     {
                                         Text = o.Name,
                                         Value = o.Id.ToString()
                                     });
            ViewData["OwnOrgans"] = new SelectList(selectListOrgan, "Value", "Text");

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

            //创建空的Model
            CustomerViewModel model = new CustomerViewModel();
            model.GrossWeightRate = "1";

            model.TransportPrices = new List<CustomerTransportPriceViewModel>();
            model.TransportPrices.Add(new CustomerTransportPriceViewModel());

            model.ForceFeePrices = new List<CustomerForceFeePriceViewModel>();
            model.ForceFeePrices.Add(new CustomerForceFeePriceViewModel());

            model.StorageFeePrices = new List<CustomerStorageFeePriceViewModel>();
            model.StorageFeePrices.Add(new CustomerStorageFeePriceViewModel());

            return View(model);
        }

        /// <summary>
        /// POST新增客户页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewCustomer(CustomerViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Customer data = new Customer();
                data.Name = model.Name;
                data.FullName = model.FullName;
                data.WarningStock = model.WarningStock;
                data.StopStock = model.StopStock;
                data.SettlementExpression = model.SettlementExpression;
                data.ValuationMode = model.ValuationMode;
                data.GrossWeightRate = decimal.Parse(model.GrossWeightRate);
                data.OwnOrganId = model.OwnOrganId;
                data.Remark = model.Remark ?? string.Empty;

                List<CustomerTransportPrice> listTransportPrice = new List<CustomerTransportPrice>();
                if (model.TransportPrices != null)
                {
                    foreach (CustomerTransportPriceViewModel m in model.TransportPrices)
                    {
                        CustomerTransportPrice p = new CustomerTransportPrice();
                        p.CustomerId = m.CustomerId;
                        p.StartCountry = m.StartCountry;
                        p.StartProvince = m.StartProvince;
                        p.StartCity = m.StartCity;
                        p.DestCountry = m.DestCountry;
                        p.DestProvince = m.DestProvince;
                        p.DestCity = m.DestCity;
                        p.MinTunnagesOrPiles = m.MinTunnagesOrPiles;
                        p.MaxTunnagesOrPiles = m.MaxTunnagesOrPiles;
                        p.StartTime = DateTime.Parse(m.StartTime);
                        p.EndTime = DateTime.Parse(m.EndTime);
                        p.CarType = m.CarType;
                        p.TransportPrice = m.TransportPrice;
                        p.RiverCrossingCharges = m.RiverCrossingCharges;
                        listTransportPrice.Add(p);
                    }
                }

                List<CustomerForceFeePrice> listForceFeePrice = new List<CustomerForceFeePrice>();
                if (model.ForceFeePrices != null)
                {
                    foreach (CustomerForceFeePriceViewModel m in model.ForceFeePrices)
                    {
                        CustomerForceFeePrice p = new CustomerForceFeePrice();
                        p.CustomerId = m.CustomerId;
                        p.StartTime = DateTime.Parse(m.ForceFeePriceStartTime);
                        p.EndTime = DateTime.Parse(m.ForceFeePriceEndTime);
                        p.LoadingForceFeePrice = m.LoadingForceFeePrice;
                        p.UnloadingForceFeePrice = m.UnloadingForceFeePrice;
                        listForceFeePrice.Add(p);
                    }
                }

                List<CustomerStorageFeePrice> listStorageFeePrice = new List<CustomerStorageFeePrice>();
                if (model.StorageFeePrices != null)
                {
                    foreach (CustomerStorageFeePriceViewModel m in model.StorageFeePrices)
                    {
                        CustomerStorageFeePrice p = new CustomerStorageFeePrice();
                        p.CustomerId = m.CustomerId;
                        p.StartTime = DateTime.Parse(m.StorageFeePriceStartTime);
                        p.EndTime = DateTime.Parse(m.StorageFeePriceEndTime);
                        p.StorageFeePrice = m.StorageFeePrice;
                        listStorageFeePrice.Add(p);
                    }
                }

                //保存数据
                string strErrText;
                CustomerSystem customer = new CustomerSystem();
                if (customer.InsertCustomer(data, listTransportPrice, listForceFeePrice, listStorageFeePrice, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// GET修改客户页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyCustomer(string id)
        {
            string strErrText;

            //生成Model数据
            CustomerSystem customer = new CustomerSystem();
            Customer data = customer.LoadCustomer(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            CustomerViewModel model = new CustomerViewModel();
            model.Id = data.Id;
            model.Name = data.Name;
            model.FullName = data.FullName;
            model.WarningStock = data.WarningStock;
            model.StopStock = data.StopStock;
            model.SettlementExpression = data.SettlementExpression;
            model.ValuationMode = data.ValuationMode;
            model.GrossWeightRate = data.GrossWeightRate.ToString("#0.######");
            model.OwnOrganId = data.OwnOrganId;
            model.Remark = data.Remark;

            model.TransportPrices = new List<CustomerTransportPriceViewModel>();
            model.TransportPrices.Add(new CustomerTransportPriceViewModel());

            model.ForceFeePrices = new List<CustomerForceFeePriceViewModel>();
            model.ForceFeePrices.Add(new CustomerForceFeePriceViewModel());

            model.StorageFeePrices = new List<CustomerStorageFeePriceViewModel>();
            model.StorageFeePrices.Add(new CustomerStorageFeePriceViewModel());

            //生成所属组织部门下拉列表项
            OrganizationSystem organ = new OrganizationSystem();
            List<Organization> listOrgan = organ.LoadOrganizations(LoginAccountId, LoginStaffName, out strErrText);
            if (listOrgan == null)
            {
                throw new Exception(strErrText);
            }
            Organization root = listOrgan.Find(delegate(Organization o) { return o.ParentId == 0; });
            List<SelectListItem> selectListOrgan = new List<SelectListItem>();
            selectListOrgan.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListOrgan.AddRange(from o in listOrgan
                                     where o.ParentId == root.Id
                                     select new SelectListItem
                                     {
                                         Text = o.Name,
                                         Value = o.Id.ToString()
                                     });
            ViewData["OwnOrgans"] = new SelectList(selectListOrgan, "Value", "Text", model.OwnOrganId.ToString());

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
        /// POST修改客户页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyCustomer(CustomerViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Customer data = new Customer();
                data.Id = model.Id;
                data.Name = model.Name;
                data.FullName = model.FullName;
                data.WarningStock = model.WarningStock;
                data.StopStock = model.StopStock;
                data.SettlementExpression = model.SettlementExpression;
                data.ValuationMode = model.ValuationMode;
                data.GrossWeightRate = decimal.Parse(model.GrossWeightRate);
                data.OwnOrganId = model.OwnOrganId;
                data.Remark = model.Remark ?? string.Empty;

                List<CustomerTransportPrice> listTransportPrice = new List<CustomerTransportPrice>();
                if (model.TransportPrices != null)
                {
                    foreach (CustomerTransportPriceViewModel m in model.TransportPrices)
                    {
                        CustomerTransportPrice p = new CustomerTransportPrice();
                        p.CustomerId = m.CustomerId;
                        p.StartCountry = m.StartCountry;
                        p.StartProvince = m.StartProvince;
                        p.StartCity = m.StartCity;
                        p.DestCountry = m.DestCountry;
                        p.DestProvince = m.DestProvince;
                        p.DestCity = m.DestCity;
                        p.MinTunnagesOrPiles = m.MinTunnagesOrPiles;
                        p.MaxTunnagesOrPiles = m.MaxTunnagesOrPiles;
                        p.StartTime = DateTime.Parse(m.StartTime);
                        p.EndTime = DateTime.Parse(m.EndTime);
                        p.CarType = m.CarType;
                        p.TransportPrice = m.TransportPrice;
                        p.RiverCrossingCharges = m.RiverCrossingCharges;
                        listTransportPrice.Add(p);
                    }
                }

                List<CustomerForceFeePrice> listForceFeePrice = new List<CustomerForceFeePrice>();
                if (model.ForceFeePrices != null)
                {
                    foreach (CustomerForceFeePriceViewModel m in model.ForceFeePrices)
                    {
                        CustomerForceFeePrice p = new CustomerForceFeePrice();
                        p.CustomerId = m.CustomerId;
                        p.StartTime = DateTime.Parse(m.ForceFeePriceStartTime);
                        p.EndTime = DateTime.Parse(m.ForceFeePriceEndTime);
                        p.LoadingForceFeePrice = m.LoadingForceFeePrice;
                        p.UnloadingForceFeePrice = m.UnloadingForceFeePrice;
                        listForceFeePrice.Add(p);
                    }
                }

                List<CustomerStorageFeePrice> listStorageFeePrice = new List<CustomerStorageFeePrice>();
                if (model.StorageFeePrices != null)
                {
                    foreach (CustomerStorageFeePriceViewModel m in model.StorageFeePrices)
                    {
                        CustomerStorageFeePrice p = new CustomerStorageFeePrice();
                        p.CustomerId = m.CustomerId;
                        p.StartTime = DateTime.Parse(m.StorageFeePriceStartTime);
                        p.EndTime = DateTime.Parse(m.StorageFeePriceEndTime);
                        p.StorageFeePrice = m.StorageFeePrice;
                        listStorageFeePrice.Add(p);
                    }
                }

                //保存数据
                string strErrText;
                CustomerSystem customer = new CustomerSystem();
                if (customer.UpdateCustomer(data, listTransportPrice, listForceFeePrice, listStorageFeePrice, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除客户
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteCustomer(string id)
        {
            //删除数据
            string strErrText;
            CustomerSystem customer = new CustomerSystem();
            if (customer.DeleteCustomer(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// GET导入客户页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ImportCustomers()
        {
            return View();
        }

        /// <summary>
        /// POST导入客户页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult UploadCustomersFile()
        {
            try
            {
                if (Request.Files.Count > 0)
                {
                    HttpPostedFileBase uploadFile = Request.Files[0] as HttpPostedFileBase;
                    if (uploadFile.ContentLength > 0)
                    {
                        //上传文件
                        string strDestFolder = HttpContext.Server.MapPath("/AttachFiles") + @"\" + DateTime.Now.ToString("yyyy-MM-dd");
                        if (!Directory.Exists(strDestFolder)) Directory.CreateDirectory(strDestFolder);
                        string filePath = strDestFolder + @"\" + Guid.NewGuid().ToString() + Path.GetExtension(uploadFile.FileName);
                        uploadFile.SaveAs(filePath);

                        //读取数据
                        string strConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=1\"";
                        using (OleDbConnection conn = new System.Data.OleDb.OleDbConnection(strConnectionString))
                        {
                            conn.Open();
                            using (DataTable dtExcelSchema = conn.GetSchema("Tables"))
                            {
                                string strSheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
                                string strQuery = "SELECT * FROM [" + strSheetName + "]";
                                OleDbDataAdapter adapter = new OleDbDataAdapter(strQuery, conn);
                                DataSet ds = new DataSet();
                                adapter.Fill(ds, "Items");
                                if (ds.Tables.Count > 0)
                                {
                                    if (ds.Tables[0].Rows.Count > 0)
                                    {
                                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                                        {
                                            Customer data = new Customer();
                                            data.Name = ds.Tables[0].Rows[i][1].ToString();
                                            data.FullName = ds.Tables[0].Rows[i][2].ToString();
                                            data.WarningStock = int.Parse(ds.Tables[0].Rows[i][6].ToString());
                                            data.StopStock = int.Parse(ds.Tables[0].Rows[i][7].ToString());
                                            data.SettlementExpression = ds.Tables[0].Rows[i][8].ToString();
                                            data.ValuationMode = ds.Tables[0].Rows[i][9].ToString();
                                            data.GrossWeightRate = decimal.Parse(ds.Tables[0].Rows[i][10].ToString());
                                            data.OwnOrganId = long.Parse(ds.Tables[0].Rows[i][11].ToString());
                                            data.Remark = ds.Tables[0].Rows[i][12].ToString();

                                            string strErrText;
                                            CustomerSystem customer = new CustomerSystem();
                                            if (customer.InsertCustomer(data, new List<CustomerTransportPrice>(), new List<CustomerForceFeePrice>(), new List<CustomerStorageFeePrice>(), LoginAccountId, LoginStaffName, out strErrText) <= 0)
                                            {
                                                return Content(string.Format(InnoSoft.LS.Resources.Strings.ImportFailed, strErrText, i + 2));
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                return Content(string.Empty);
            }
            catch (Exception e)
            {
                return Content(e.Message);
            }
        }

        /// <summary>
        /// GET下载客户导入示例文件
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public FilePathResult DownloadCustomersFile()
        {
            return File(Path.Combine(HttpContext.Server.MapPath("/AttachFiles"), "ImportCustomersExample.xls"), "text/plain", "ImportCustomersExample.xls");
        }

        /// <summary>
        /// GET导出客户
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportCustomers()
        {
            string strErrText;

            //读取全部数据
            CustomerSystem customer = new CustomerSystem();
            List<Customer> listCustomer = customer.LoadCustomers(LoginAccountId, LoginStaffName, out strErrText);
            if (listCustomer == null)
            {
                throw new Exception(strErrText);
            }

            //生成GridView
            BoundField colCustomerId = new BoundField();
            colCustomerId.HeaderText = InnoSoft.LS.Resources.Labels.CustomerId;
            colCustomerId.DataField = "CustomerId";

            BoundField colName = new BoundField();
            colName.HeaderText = InnoSoft.LS.Resources.Labels.CustomerName;
            colName.DataField = "Name";

            BoundField colFullName = new BoundField();
            colFullName.HeaderText = InnoSoft.LS.Resources.Labels.CustomerFullName;
            colFullName.DataField = "FullName";

            BoundField colWarningStock = new BoundField();
            colWarningStock.HeaderText = InnoSoft.LS.Resources.Labels.WarningStock;
            colWarningStock.DataField = "WarningStock";

            BoundField colStopStock = new BoundField();
            colStopStock.HeaderText = InnoSoft.LS.Resources.Labels.StopStock;
            colStopStock.DataField = "StopStock";

            BoundField colSettlementExpression = new BoundField();
            colSettlementExpression.HeaderText = InnoSoft.LS.Resources.Labels.SettlementExpression;
            colSettlementExpression.DataField = "SettlementExpression";

            BoundField colValuationMode = new BoundField();
            colValuationMode.HeaderText = InnoSoft.LS.Resources.Labels.ValuationMode;
            colValuationMode.DataField = "ValuationMode";

            BoundField colGrossWeightRate = new BoundField();
            colGrossWeightRate.HeaderText = InnoSoft.LS.Resources.Labels.GrossWeightRate;
            colGrossWeightRate.DataField = "GrossWeightRate";

            BoundField colOwnOrganId = new BoundField();
            colOwnOrganId.HeaderText = InnoSoft.LS.Resources.Labels.OwnOrganId;
            colOwnOrganId.DataField = "OwnOrganId";

            BoundField colOwnOrganName = new BoundField();
            colOwnOrganName.HeaderText = InnoSoft.LS.Resources.Labels.OwnOrganName;
            colOwnOrganName.DataField = "OwnOrganName";

            BoundField colRemark = new BoundField();
            colRemark.HeaderText = InnoSoft.LS.Resources.Labels.Remark;
            colRemark.DataField = "Remark";

            var grid = new GridView();
            grid.Columns.Add(colCustomerId);
            grid.Columns.Add(colName);
            grid.Columns.Add(colFullName);
            grid.Columns.Add(colWarningStock);
            grid.Columns.Add(colStopStock);
            grid.Columns.Add(colSettlementExpression);
            grid.Columns.Add(colValuationMode);
            grid.Columns.Add(colGrossWeightRate);
            grid.Columns.Add(colOwnOrganId);
            grid.Columns.Add(colOwnOrganName);
            grid.Columns.Add(colRemark);

            grid.AutoGenerateColumns = false;

            grid.DataSource = from c in listCustomer
                              select new
                              {
                                  CustomerId = c.Id,
                                  Name = c.Name,
                                  FullName = c.FullName,
                                  WarningStock = c.WarningStock > 0 ? c.WarningStock.ToString() : string.Empty,
                                  StopStock = c.StopStock > 0 ? c.StopStock.ToString() : string.Empty,
                                  SettlementExpression = c.SettlementExpression,
                                  ValuationMode = c.ValuationMode,
                                  GrossWeightRate = c.GrossWeightRate > 0 ? c.GrossWeightRate.ToString("#0.######") : string.Empty,
                                  OwnOrganId = c.OwnOrganId,
                                  OwnOrganName = c.OwnOrganName,
                                  Remark = c.Remark
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=Customer.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

            return View("SetCustomer");
        }

        #endregion

        #region 货物操作代码

        /// <summary>
        /// GET设置货物页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetGoods()
        {
            return View();
        }

        /// <summary>
        /// GET货物表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="typeId">类别编码</param>
        /// <param name="goodsNo"></param>
        /// <param name="goodsName"></param>
        /// <param name="specModel"></param>
        /// <param name="grade"></param>
        /// <param name="gWeight"></param>
        /// <param name="packing"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadGoodsGrid(string sidx, string sord, int page, int rows, string typeId, string goodsNo, string goodsName, string specModel, string gWeight, string grade, string packing)
        {
            //读取货物数据
            string strErrText;
            DDSystem dd = new DDSystem();
            List<Goods> listGoods = dd.LoadAllGoodsByConditions(typeId, goodsNo, goodsName, specModel, gWeight, grade, packing, LoginAccountId, LoginStaffName, out strErrText);
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
                          cell = new string[] 
                          { 
                              g.Id.ToString(), 
                              g.GoodsNo,
                              g.Name,
                              g.TypeFullName,
                              g.SpecModel,
                              g.GWeight,
                              g.Grade,
                              g.Brand,
                              g.PieceWeight == null || g.PieceWeight==string.Empty ? null : decimal.Parse(g.PieceWeight).ToString("#0.######"),
                              g.Packing,
                              g.Remark
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增货物页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewGoods()
        {
            string strErrText;

            //生成货物类别下拉列表项
            DDSystem dd = new DDSystem();
            List<GoodsType> listGoodsType = dd.LoadGoodsTypes(LoginAccountId, LoginStaffName, out strErrText);
            if (listGoodsType == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListGoodsType = new List<SelectListItem>();
            selectListGoodsType.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListGoodsType.AddRange(from t in listGoodsType
                                         orderby t.FullName
                                         select new SelectListItem
                                         {
                                             Text = t.FullName,
                                             Value = t.Id.ToString()
                                         });
            ViewData["GoodsTypes"] = new SelectList(selectListGoodsType, "Value", "Text");

            //创建空的Model
            GoodsViewModel model = new GoodsViewModel();

            return View(model);
        }

        /// <summary>
        /// POST新增货物页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        [Authorize]
        public ActionResult NewGoods(GoodsViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Goods data = new Goods();
                data.Name = model.Name;
                data.TypeId = model.TypeId;
                data.GoodsNo = model.GoodsNo;
                data.SpecModel = model.SpecModel;
                data.GWeight = model.GWeight;
                data.Grade = model.Grade;
                data.Brand = model.Brand;
                data.PieceWeight = model.PieceWeight;
                data.Packing = model.Packing;
                data.Remark = model.Remark;

                //保存数据
                string strErrText;
                DDSystem dd = new DDSystem();
                if (dd.InsertGoods(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改货物页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyGoods(string id)
        {
            string strErrText;

            //生成货物类别下拉列表项
            DDSystem dd = new DDSystem();
            List<GoodsType> listGoodsType = dd.LoadGoodsTypes(LoginAccountId, LoginStaffName, out strErrText);
            if (listGoodsType == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListGoodsType = new List<SelectListItem>();
            selectListGoodsType.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListGoodsType.AddRange(from t in listGoodsType
                                         orderby t.FullName
                                         select new SelectListItem
                                         {
                                             Text = t.FullName,
                                             Value = t.Id.ToString()
                                         });
            ViewData["GoodsTypes"] = new SelectList(selectListGoodsType, "Value", "Text");

            //生成Model数据
            Goods data = dd.LoadGoods(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            GoodsViewModel model = new GoodsViewModel();
            model.Id = data.Id;
            model.Name = data.Name;
            model.TypeId = data.TypeId;
            model.GoodsNo = data.GoodsNo;
            model.SpecModel = data.SpecModel;
            model.GWeight = data.GWeight;
            model.Grade = data.Grade;
            model.Brand = data.Brand;
            model.PieceWeight = data.PieceWeight;
            model.Packing = data.Packing;
            model.Remark = data.Remark;

            return View(model);
        }

        /// <summary>
        /// POST修改货物页面
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        [Authorize]
        public ActionResult ModifyGoods(GoodsViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Goods data = new Goods();
                data.Id = model.Id;
                data.Name = model.Name;
                data.TypeId = model.TypeId;
                data.GoodsNo = model.GoodsNo;
                data.SpecModel = model.SpecModel;
                data.GWeight = model.GWeight;
                data.Grade = model.Grade;
                data.Brand = model.Brand;
                data.PieceWeight = model.PieceWeight;
                data.Packing = model.Packing;
                data.Remark = model.Remark;

                //保存数据
                string strErrText;
                DDSystem dd = new DDSystem();
                if (dd.UpdateGoods(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除货物
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteGoods(string id)
        {
            //删除数据
            string strErrText;
            DDSystem dd = new DDSystem();
            if (dd.DeleteGoods(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// GET导入货物页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult ImportGoods()
        {
            return View();
        }

        /// <summary>
        /// POST导入货物页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult UploadGoodsFile()
        {
            try
            {
                if (Request.Files.Count > 0)
                {
                    HttpPostedFileBase uploadFile = Request.Files[0] as HttpPostedFileBase;
                    if (uploadFile.ContentLength > 0)
                    {
                        //上传文件
                        string strDestFolder = HttpContext.Server.MapPath("/AttachFiles") + @"\" + DateTime.Now.ToString("yyyy-MM-dd");
                        if (!Directory.Exists(strDestFolder)) Directory.CreateDirectory(strDestFolder);
                        string filePath = strDestFolder + @"\" + Guid.NewGuid().ToString() + Path.GetExtension(uploadFile.FileName);
                        uploadFile.SaveAs(filePath);

                        //读取数据
                        string strConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=1\"";
                        using (OleDbConnection conn = new System.Data.OleDb.OleDbConnection(strConnectionString))
                        {
                            conn.Open();
                            using (DataTable dtExcelSchema = conn.GetSchema("Tables"))
                            {
                                string strSheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
                                string strQuery = "SELECT * FROM [" + strSheetName + "]";
                                OleDbDataAdapter adapter = new OleDbDataAdapter(strQuery, conn);
                                DataSet ds = new DataSet();
                                adapter.Fill(ds, "Items");
                                if (ds.Tables.Count > 0)
                                {
                                    if (ds.Tables[0].Rows.Count > 0)
                                    {
                                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                                        {
                                            Goods data = new Goods();
                                            data.GoodsNo = ds.Tables[0].Rows[i][0].ToString();
                                            data.Name = ds.Tables[0].Rows[i][1].ToString();
                                            long nTypeId = 0;
                                            if (!long.TryParse(ds.Tables[0].Rows[i][2].ToString(), out nTypeId))
                                            {
                                                return Content(string.Format(InnoSoft.LS.Resources.Strings.NotValidTypeId, i + 2));
                                            }
                                            data.TypeId = nTypeId;
                                            data.SpecModel = ds.Tables[0].Rows[i][3].ToString();
                                            data.GWeight = ds.Tables[0].Rows[i][4].ToString();
                                            data.Grade = ds.Tables[0].Rows[i][5].ToString();
                                            data.Brand = ds.Tables[0].Rows[i][6].ToString();
                                            if (ds.Tables[0].Rows[i][7].ToString() != string.Empty)
                                            {
                                                decimal decPieceWeight = 0;
                                                if (!decimal.TryParse(ds.Tables[0].Rows[i][7].ToString(), out decPieceWeight))
                                                {
                                                    return Content(string.Format(InnoSoft.LS.Resources.Strings.NotValidPieceWeight, i + 2));
                                                }
                                            }
                                            data.PieceWeight = ds.Tables[0].Rows[i][7].ToString();
                                            data.Packing = ds.Tables[0].Rows[i][8].ToString();
                                            data.Remark = ds.Tables[0].Rows[i][9].ToString();

                                            string strErrText;
                                            DDSystem dd = new DDSystem();
                                            if (!dd.InsertGoods(data, LoginAccountId, LoginStaffName, out strErrText))
                                            {
                                                return Content(string.Format(InnoSoft.LS.Resources.Strings.ImportFailed, strErrText, i + 2));
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                return Content(string.Empty);
            }
            catch (Exception e)
            {
                return Content(e.Message);
            }
        }

        /// <summary>
        /// GET下载货物导入示例文件
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public FilePathResult DownloadGoodsFile()
        {
            return File(Path.Combine(HttpContext.Server.MapPath("/AttachFiles"), "ImportGoodsExample.xls"), "text/plain", "ImportGoodsExample.xls");
        }

        /// <summary>
        /// GET导出货物
        /// </summary>
        /// <param name="id">类别编码</param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ExportGoods(string id)
        {
            string strErrText;

            var request = HttpContext.Request;

            string strTypeId = request.QueryString["typeId"] ?? string.Empty;
            string strGoodsNo = request.QueryString["goodsNo"] ?? string.Empty;
            string strGoodsName = request.QueryString["goodsName"] ?? string.Empty;
            string strSpecModel = request.QueryString["specModel"] ?? string.Empty;
            string strGWeight = request.QueryString["gWeight"] ?? string.Empty;
            string strGrade = request.QueryString["grade"] ?? string.Empty;
            string strPacking = request.QueryString["packing"] ?? string.Empty;

            //读取货物数据
            DDSystem dd = new DDSystem();
            List<Goods> listGoods = dd.LoadAllGoodsByConditions(strTypeId, strGoodsNo, strGoodsName, strSpecModel, strGWeight, strGrade, strPacking, LoginAccountId, LoginStaffName, out strErrText);
            if (listGoods == null)
            {
                throw new Exception(strErrText);
            }

            //生成GridView
            BoundField colGoodsNo = new BoundField();
            colGoodsNo.HeaderText = InnoSoft.LS.Resources.Labels.GoodsNo;
            colGoodsNo.DataField = "GoodsNo";

            BoundField colName = new BoundField();
            colName.HeaderText = InnoSoft.LS.Resources.Labels.GoodsName;
            colName.DataField = "Name";

            BoundField colTypeId = new BoundField();
            colTypeId.HeaderText = InnoSoft.LS.Resources.Labels.TypeId;
            colTypeId.DataField = "TypeId";

            BoundField colTypeFullName = new BoundField();
            colTypeFullName.HeaderText = InnoSoft.LS.Resources.Labels.TypeName;
            colTypeFullName.DataField = "TypeFullName";

            BoundField colSpecModel = new BoundField();
            colSpecModel.HeaderText = InnoSoft.LS.Resources.Labels.Specification;
            colSpecModel.DataField = "SpecModel";

            BoundField colGWeight = new BoundField();
            colGWeight.HeaderText = InnoSoft.LS.Resources.Labels.GrammeWeight;
            colGWeight.DataField = "GWeight";

            BoundField colGrade = new BoundField();
            colGrade.HeaderText = InnoSoft.LS.Resources.Labels.Grade;
            colGrade.DataField = "Grade";

            BoundField colBrand = new BoundField();
            colBrand.HeaderText = InnoSoft.LS.Resources.Labels.Brand;
            colBrand.DataField = "Brand";

            BoundField colPieceWeight = new BoundField();
            colPieceWeight.HeaderText = InnoSoft.LS.Resources.Labels.PieceWeightOrConvertCoefficient;
            colPieceWeight.DataField = "PieceWeight";

            BoundField colPacking = new BoundField();
            colPacking.HeaderText = InnoSoft.LS.Resources.Labels.PackingSpecification;
            colPacking.DataField = "Packing";

            BoundField colRemark = new BoundField();
            colRemark.HeaderText = InnoSoft.LS.Resources.Labels.Remark;
            colRemark.DataField = "Remark";

            var grid = new GridView();
            grid.Columns.Add(colGoodsNo);
            grid.Columns.Add(colName);
            grid.Columns.Add(colTypeId);
            grid.Columns.Add(colTypeFullName);
            grid.Columns.Add(colSpecModel);
            grid.Columns.Add(colGWeight);
            grid.Columns.Add(colGrade);
            grid.Columns.Add(colBrand);
            grid.Columns.Add(colPieceWeight);
            grid.Columns.Add(colPacking);
            grid.Columns.Add(colRemark);
            grid.AutoGenerateColumns = false;

            grid.DataSource = from g in listGoods
                              select new
                              {
                                  GoodsNo = g.GoodsNo,
                                  Name = g.Name,
                                  TypeId = g.TypeId,
                                  TypeFullName = g.TypeFullName,
                                  SpecModel = g.SpecModel,
                                  GWeight = g.GWeight,
                                  Grade = g.Grade,
                                  Brand = g.Brand,
                                  PieceWeight = g.PieceWeight,
                                  Packing = g.Packing,
                                  Remark = g.Remark
                              };
            grid.DataBind();

            //导出GridView
            Response.ClearContent();
            Response.Charset = InnoSoft.LS.Resources.Encoding.ExcelCharset;
            Response.ContentEncoding = System.Text.Encoding.GetEncoding(InnoSoft.LS.Resources.Encoding.ExcelContent);
            Response.ContentType = "application/ms-excel";
            Response.Write("<meta http-equiv=Content-Type content=text/html charset=" + InnoSoft.LS.Resources.Encoding.ExcelCharset + ">");
            Response.AddHeader("content-disposition", "attachment; filename=Goods.xls");
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

            return View("SetGoods");
        }

        #endregion

        #region 仓库操作代码

        /// <summary>
        /// GET设置仓库页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetWarehouse()
        {
            return View();
        }

        /// <summary>
        /// GET仓库表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadWarehousesGrid(string sidx, string sord, int page, int rows)
        {
            //读取仓库数据
            string strErrText;
            DDSystem dd = new DDSystem();
            List<Warehouse> listWarehouse = dd.LoadWarehouses(LoginAccountId, LoginStaffName, out strErrText);
            if (listWarehouse == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listWarehouse.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listWarehouse.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from w in data
                      select new
                      {
                          id = w.Id,
                          cell = new string[] 
                          { 
                              w.Id.ToString(), 
                              w.Name,
                              w.IsLease.ToString(),
                              w.Remark
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增仓库页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewWarehouse()
        {
            //创建空的Model
            WarehouseViewModel model = new WarehouseViewModel();

            return View(model);
        }

        /// <summary>
        /// POST新增仓库
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewWarehouse(WarehouseViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Warehouse data = new Warehouse();
                data.Name = model.Name;
                data.IsLease = model.IsLease;
                data.Remark = model.Remark;

                //保存数据
                string strErrText;
                DDSystem dd = new DDSystem();
                if (dd.InsertWarehouse(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改仓库页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyWarehouse(string id)
        {
            string strErrText;

            //生成Model数据
            DDSystem dd = new DDSystem();
            Warehouse data = dd.LoadWarehouse(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            WarehouseViewModel model = new WarehouseViewModel();
            model.Id = data.Id;
            model.Name = data.Name;
            model.IsLease = data.IsLease;
            model.Remark = data.Remark;

            return View(model);
        }

        /// <summary>
        /// POST修改仓库
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyWarehouse(WarehouseViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Warehouse data = new Warehouse();
                data.Id = model.Id;
                data.Name = model.Name;
                data.IsLease = model.IsLease;
                data.Remark = model.Remark;

                //保存数据
                string strErrText;
                DDSystem dd = new DDSystem();
                if (dd.UpdateWarehouse(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除仓库
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteWarehouse(string id)
        {
            //删除数据
            string strErrText;
            DDSystem dd = new DDSystem();
            if (dd.DeleteWarehouse(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 设置收货单位档案

        /// <summary>
        /// GET设置收货单位档案页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetReceiver()
        {
            return View();
        }

        /// <summary>
        /// GET收货单位表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadReceiversGrid(string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            DDSystem dd = new DDSystem();
            List<Receiver> listReceiver = dd.LoadReceivers(LoginAccountId, LoginStaffName, out strErrText);
            if (listReceiver == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listReceiver.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listReceiver.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                          cell = new string[] 
                          { 
                              r.Id.ToString(), 
                              r.Name,
                              r.Country,
                              r.Province,
                              r.City,
                              r.Address,
                              r.Contact,
                              r.ContactTel
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET收货单位距离表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="receiverId"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadReceiverDistancesGrid(string sidx, string sord, int page, int rows, string receiverId)
        {
            //读取全部数据
            string strErrText;
            DDSystem dd = new DDSystem();
            List<ReceiverDistance> listDistance = dd.LoadReceiverDistances(long.Parse(receiverId), LoginAccountId, LoginStaffName, out strErrText);
            if (listDistance == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listDistance.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listDistance.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                          cell = new string[] 
                          { 
                              d.Id.ToString(), 
                              d.StartCountry,
                              d.StartProvince,
                              d.StartCity,
                              d.KM.ToString()
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增收货单位页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewReceiver()
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

            //创建空的Model
            ReceiverViewModel model = new ReceiverViewModel();

            model.Distances = new List<ReceiverDistanceViewModel>();
            model.Distances.Add(new ReceiverDistanceViewModel());

            return View(model);
        }

        /// <summary>
        /// POST新增收货单位档案
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewReceiver(ReceiverViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Receiver data = new Receiver();
                data.Name = model.Name;
                data.Country = model.Country;
                data.Province = model.Province;
                data.City = model.City;
                data.Address = model.Address;
                data.Contact = model.Contact;
                data.ContactTel = model.ContactTel;

                List<ReceiverDistance> listDistance = new List<ReceiverDistance>();
                if (model.Distances != null)
                {
                    foreach (ReceiverDistanceViewModel m in model.Distances)
                    {
                        ReceiverDistance d = new ReceiverDistance();
                        d.ReceiverName = model.Name;
                        d.StartCountry = m.StartCountry;
                        d.StartProvince = m.StartProvince;
                        d.StartCity = m.StartCity;
                        d.KM = m.KM;
                        listDistance.Add(d);
                    }
                }

                //保存数据
                string strErrText;
                DDSystem dd = new DDSystem();
                if (dd.InsertReceiver(data, listDistance, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// GET修改收货单位页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyReceiver(string id)
        {
            string strErrText;

            //生成Model数据
            DDSystem dd = new DDSystem();
            Receiver data = dd.LoadReceiver(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            ReceiverViewModel model = new ReceiverViewModel();
            model.Id = data.Id;
            model.Name = data.Name;
            model.Country = data.Country;
            model.Province = data.Province;
            model.City = data.City;
            model.Address = data.Address;
            model.Contact = data.Contact;
            model.ContactTel = data.ContactTel;

            model.Distances = new List<ReceiverDistanceViewModel>();
            model.Distances.Add(new ReceiverDistanceViewModel());

            //生成国家下拉列表项
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
            ViewData["Countrys"] = new SelectList(selectListCountry, "Value", "Text", model.Country);

            //生成空的省份下拉列表项
            List<Province> listState = null;
            if (!string.IsNullOrEmpty(model.Country))
            {
                listState = dd.LoadProvincesByCountry(model.Country, LoginAccountId, LoginStaffName, out strErrText);
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
            ViewData["Provinces"] = new SelectList(selectListState, "Value", "Text", model.Province);

            //生成空的城市下拉列表项
            List<City> listCity = null;
            if (!string.IsNullOrEmpty(model.Province))
            {
                listCity = dd.LoadCitysByProvince(model.Country, model.Province, LoginAccountId, LoginStaffName, out strErrText);
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
            ViewData["Citys"] = new SelectList(selectListCity, "Value", "Text", model.City);

            return View(model);
        }

        /// <summary>
        /// POST修改收货单位档案
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyReceiver(ReceiverViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Receiver data = new Receiver();
                data.Id = model.Id;
                data.Name = model.Name;
                data.Country = model.Country;
                data.Province = model.Province;
                data.City = model.City;
                data.Address = model.Address;
                data.Contact = model.Contact;
                data.ContactTel = model.ContactTel;

                List<ReceiverDistance> listDistance = new List<ReceiverDistance>();
                if (model.Distances != null)
                {
                    foreach (ReceiverDistanceViewModel m in model.Distances)
                    {
                        ReceiverDistance d = new ReceiverDistance();
                        d.ReceiverName = model.Name;
                        d.StartCountry = m.StartCountry;
                        d.StartProvince = m.StartProvince;
                        d.StartCity = m.StartCity;
                        d.KM = m.KM;
                        listDistance.Add(d);
                    }
                }

                //保存数据
                string strErrText;
                DDSystem dd = new DDSystem();
                if (dd.UpdateReceiver(data, listDistance, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除收货单位档案
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteReceiver(string id)
        {
            //删除数据
            string strErrText;
            DDSystem dd = new DDSystem();
            if (dd.DeleteReceiver(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 承运单位操作代码

        /// <summary>
        /// GET设置承运单位页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetCarrier()
        {
            return View();
        }

        /// <summary>
        /// GET承运单位表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="carrierName"></param>
        /// <param name="carNo"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarrierGrid(string sidx, string sord, int page, int rows, string carrierName, string carNo)
        {
            //读取全部数据
            string strErrText;
            DDSystem dd = new DDSystem();
            List<Carrier> listCarrier = dd.LoadCarriersByConditions(carrierName, carNo, LoginAccountId, LoginStaffName, out strErrText);
            if (listCarrier == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listCarrier.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listCarrier.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              c.BusinessType,
                              c.PaymentType
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET承运单位车辆表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarrierCarGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            DDSystem dd = new DDSystem();
            List<CarrierCar> listCar = dd.LoadCarrierCars(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (listCar == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listCar.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listCar.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              p.CarNo,
                              p.TrailerNo,
                              p.CarryingCapacity.ToString()
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET承运单位驾驶员表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarrierDriverGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            DDSystem dd = new DDSystem();
            List<CarrierDriver> listDriver = dd.LoadCarrierDrivers(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (listDriver == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listDriver.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listDriver.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                          cell = new string[] 
                          { 
                              d.Id.ToString(), 
                              d.Name,
                              d.LicenseNo,
                              d.MobileTel,
                              d.HomeTel,
                              d.CarNo
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET承运单位结算公式表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarrierSettlementExpressionGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            DDSystem dd = new DDSystem();
            List<CarrierSettlementExpression> listExpression = dd.LoadCarrierSettlementExpressions(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (listExpression == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listExpression.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
            var data = listExpression.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

            //生成表格数据
            var ret = new
            {
                total = nTotalPages,
                page = nPageIndex,
                records = nTotalRows,
                rows = (
                      from e in data
                      select new
                      {
                          id = e.Id,
                          cell = new string[] 
                          { 
                              e.Id.ToString(), 
                              e.PlanType,
                              e.TransportChargeExpression,
                              e.TransportPriceExpression
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET承运单位运费价格表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadCarrierTransportPriceGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取全部数据
            string strErrText;
            DDSystem dd = new DDSystem();
            List<CarrierTransportPrice> listPrice = dd.LoadCarrierTransportPrices(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
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

            string sortExpression = (sidx ?? "Id") + " " + (sord ?? "ASC");
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
                          cell = new string[] 
                          { 
                              p.Id.ToString(), 
                              p.StartCountry,
                              p.StartProvince,
                              p.StartCity,
                              p.DestCountry,
                              p.DestProvince,
                              p.DestCity,
                              p.PlanType,
                              p.StartTime.ToString("yyyy-MM-dd"),
                              p.EndTime.ToString("yyyy-MM-dd"),
                              p.TransportPrice.ToString("#0.######")
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增承运单位页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewCarrier()
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

            //创建空的Model
            CarrierViewModel model = new CarrierViewModel();

            model.Cars = new List<CarrierCarViewModel>();
            model.Cars.Add(new CarrierCarViewModel());

            model.Drivers = new List<CarrierDriverViewModel>();
            model.Drivers.Add(new CarrierDriverViewModel());

            model.SettlementExpressions = new List<CarrierSettlementExpressionViewModel>();
            model.SettlementExpressions.Add(new CarrierSettlementExpressionViewModel());

            model.TransportPrices = new List<CarrierTransportPriceViewModel>();
            model.TransportPrices.Add(new CarrierTransportPriceViewModel());

            return View(model);
        }

        /// <summary>
        /// POST新增承运单位
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewCarrier(CarrierViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Carrier data = new Carrier();
                data.Name = model.Name;
                data.BusinessType = model.BusinessType;
                data.PaymentType = model.PaymentType;

                List<CarrierCar> listCar = new List<CarrierCar>();
                if (model.Cars != null)
                {
                    foreach (CarrierCarViewModel m in model.Cars)
                    {
                        CarrierCar c = new CarrierCar();
                        c.CarrierId = m.CarrierId;
                        c.CarNo = m.CarNo;
                        c.TrailerNo = m.TrailerNo;
                        c.CarryingCapacity = m.CarryingCapacity;
                        listCar.Add(c);
                    }
                }

                List<CarrierDriver> listDriver = new List<CarrierDriver>();
                if (model.Drivers != null)
                {
                    foreach (CarrierDriverViewModel m in model.Drivers)
                    {
                        CarrierDriver d = new CarrierDriver();
                        d.CarrierId = m.CarrierId;
                        d.CarNo = m.CarNo;
                        d.Name = m.Name;
                        d.LicenseNo = m.LicenseNo;
                        d.MobileTel = m.MobileTel;
                        d.HomeTel = m.HomeTel;
                        listDriver.Add(d);
                    }
                }

                List<CarrierSettlementExpression> listExpression = new List<CarrierSettlementExpression>();
                if (model.SettlementExpressions != null)
                {
                    foreach (CarrierSettlementExpressionViewModel m in model.SettlementExpressions)
                    {
                        CarrierSettlementExpression e = new CarrierSettlementExpression();
                        e.CarrierId = m.CarrierId;
                        e.PlanType = m.PlanType;
                        e.TransportChargeExpression = m.TransportChargeExpression;
                        e.TransportPriceExpression = m.TransportPriceExpression;
                        listExpression.Add(e);
                    }
                }

                List<CarrierTransportPrice> listPrice = new List<CarrierTransportPrice>();
                if (model.TransportPrices != null)
                {
                    foreach (CarrierTransportPriceViewModel m in model.TransportPrices)
                    {
                        CarrierTransportPrice p = new CarrierTransportPrice();
                        p.CarrierId = m.CarrierId;
                        p.StartCountry = m.StartCountry;
                        p.StartProvince = m.StartProvince;
                        p.StartCity = m.StartCity;
                        p.DestCountry = m.DestCountry;
                        p.DestProvince = m.DestProvince;
                        p.DestCity = m.DestCity;
                        p.PlanType = m.PlanType;
                        p.StartTime = DateTime.Parse(m.StartTime);
                        p.EndTime = DateTime.Parse(m.EndTime);
                        p.TransportPrice = m.TransportPrice;
                        listPrice.Add(p);
                    }
                }

                //保存数据
                string strErrText;
                DDSystem dd = new DDSystem();
                if (dd.InsertCarrier(data, listCar, listDriver, listExpression, listPrice, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// GET修改承运单位档案页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyCarrier(string id)
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

            //生成Model数据
            Carrier data = dd.LoadCarrier(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            CarrierViewModel model = new CarrierViewModel();
            model.Id = data.Id;
            model.Name = data.Name;
            model.BusinessType = data.BusinessType;
            model.PaymentType = data.PaymentType;

            model.Cars = new List<CarrierCarViewModel>();
            model.Cars.Add(new CarrierCarViewModel());

            model.Drivers = new List<CarrierDriverViewModel>();
            model.Drivers.Add(new CarrierDriverViewModel());

            model.SettlementExpressions = new List<CarrierSettlementExpressionViewModel>();
            model.SettlementExpressions.Add(new CarrierSettlementExpressionViewModel());

            model.TransportPrices = new List<CarrierTransportPriceViewModel>();
            model.TransportPrices.Add(new CarrierTransportPriceViewModel());

            return View(model);
        }

        /// <summary>
        /// POST修改承运单位档案
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyCarrier(CarrierViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                Carrier data = new Carrier();
                data.Id = model.Id;
                data.Name = model.Name;
                data.BusinessType = model.BusinessType;
                data.PaymentType = model.PaymentType;

                List<CarrierCar> listCar = new List<CarrierCar>();
                if (model.Cars != null)
                {
                    foreach (CarrierCarViewModel m in model.Cars)
                    {
                        CarrierCar c = new CarrierCar();
                        c.Id = m.Id;
                        c.CarrierId = m.CarrierId;
                        c.CarNo = m.CarNo;
                        c.TrailerNo = m.TrailerNo;
                        c.CarryingCapacity = m.CarryingCapacity;
                        listCar.Add(c);
                    }
                }

                List<CarrierDriver> listDriver = new List<CarrierDriver>();
                if (model.Drivers != null)
                {
                    foreach (CarrierDriverViewModel m in model.Drivers)
                    {
                        CarrierDriver d = new CarrierDriver();
                        d.CarrierId = m.CarrierId;
                        d.CarNo = m.CarNo;
                        d.Name = m.Name;
                        d.LicenseNo = m.LicenseNo;
                        d.MobileTel = m.MobileTel;
                        d.HomeTel = m.HomeTel;
                        listDriver.Add(d);
                    }
                }

                List<CarrierSettlementExpression> listExpression = new List<CarrierSettlementExpression>();
                if (model.SettlementExpressions != null)
                {
                    foreach (CarrierSettlementExpressionViewModel m in model.SettlementExpressions)
                    {
                        CarrierSettlementExpression e = new CarrierSettlementExpression();
                        e.CarrierId = m.CarrierId;
                        e.PlanType = m.PlanType;
                        e.TransportChargeExpression = m.TransportChargeExpression;
                        e.TransportPriceExpression = m.TransportPriceExpression;
                        listExpression.Add(e);
                    }
                }

                List<CarrierTransportPrice> listPrice = new List<CarrierTransportPrice>();
                if (model.TransportPrices != null)
                {
                    foreach (CarrierTransportPriceViewModel m in model.TransportPrices)
                    {
                        CarrierTransportPrice p = new CarrierTransportPrice();
                        p.CarrierId = m.CarrierId;
                        p.StartCountry = m.StartCountry;
                        p.StartProvince = m.StartProvince;
                        p.StartCity = m.StartCity;
                        p.DestCountry = m.DestCountry;
                        p.DestProvince = m.DestProvince;
                        p.DestCity = m.DestCity;
                        p.PlanType = m.PlanType;
                        p.StartTime = DateTime.Parse(m.StartTime);
                        p.EndTime = DateTime.Parse(m.EndTime);
                        p.TransportPrice = m.TransportPrice;
                        listPrice.Add(p);
                    }
                }

                //保存数据
                string strErrText;
                DDSystem dd = new DDSystem();
                if (dd.UpdateCarrier(data, listCar, listDriver, listExpression, listPrice, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除承运单位档案
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteCarrier(string id)
        {
            //删除数据
            string strErrText;
            DDSystem dd = new DDSystem();
            if (dd.DeleteCarrier(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 运费限价操作代码

        /// <summary>
        /// GET设置运费限价页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetTransportLimitedPrice()
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
        /// GET运费限价表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <param name="planType"></param>
        /// <param name="startCountry"></param>
        /// <param name="startProvince"></param>
        /// <param name="startCity"></param>
        /// <param name="destCountry"></param>
        /// <param name="destProvince"></param>
        /// <param name="destCity"></param>
        /// <param name="modifiedIds"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadTransportLimitedPriceGrid(string sidx, string sord, int page, int rows, string planType, string startCountry, string startProvince, string startCity, string destCountry, string destProvince, string destCity, string modifiedIds)
        {
            //读取全部数据
            string strErrText;
            DDSystem dd = new DDSystem();
            List<TransportLimitedPrice> listPrice = dd.LoadTransportLimitedPricesByConditions(planType, startCountry, startProvince, startCity, destCountry, destProvince, destCity, LoginAccountId, LoginStaffName, out strErrText);
            if (listPrice == null)
            {
                throw new Exception(strErrText);
            }

            //剔除已经修改成功的记录
            listPrice = listPrice.FindAll(delegate(TransportLimitedPrice p) { return modifiedIds.IndexOf(p.Id.ToString()) < 0; });

            //提取当前页面数据
            int nTotalRows = listPrice.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            var data = listPrice.Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              p.PlanType,
                              p.StartCountry,
                              p.StartProvince,
                              p.StartCity,
                              p.DestCountry,
                              p.DestProvince,
                              p.DestCity,
                              p.CarType,
                              p.MinTunnagesOrPiles.ToString("#0.######"),
                              p.MaxTunnagesOrPiles.ToString("#0.######"),
                              p.StartTime.ToString("yyyy-MM-dd"),
                              p.EndTime.ToString("yyyy-MM-dd"),
                              p.TransportPrice.ToString("#0.######"),
                              p.TransportCharges.ToString("#0.######")
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增运费限价页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewTransportLimitedPrice()
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

            //创建空Model
            TransportLimitedPriceViewModel model = new TransportLimitedPriceViewModel();

            return View(model);
        }

        /// <summary>
        /// POST新增运费限价
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewTransportLimitedPrice(TransportLimitedPriceViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                TransportLimitedPrice data = new TransportLimitedPrice();
                data.PlanType = model.PlanType;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.DestCountry = model.DestCountry;
                data.DestProvince = model.DestProvince;
                data.DestCity = model.DestCity;
                data.CarType = model.CarType;
                data.MinTunnagesOrPiles = model.MinTunnagesOrPiles;
                data.MaxTunnagesOrPiles = model.MaxTunnagesOrPiles;
                data.StartTime = DateTime.Parse(model.StartTime);
                data.EndTime = DateTime.Parse(model.EndTime);
                data.TransportPrice = model.TransportPrice;
                data.TransportCharges = model.TransportCharges;

                //保存数据
                string strErrText;
                DDSystem dd = new DDSystem();
                if (dd.InsertTransportLimitedPrice(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// GET修改运费限价页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyTransportLimitedPrice(string id)
        {
            string strErrText;

            //生成Model数据
            DDSystem dd = new DDSystem();
            TransportLimitedPrice data = dd.LoadTransportLimitedPrice(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            TransportLimitedPriceViewModel model = new TransportLimitedPriceViewModel();
            model.Id = data.Id;
            model.PlanType = data.PlanType;
            model.StartCountry = data.StartCountry;
            model.StartProvince = data.StartProvince;
            model.StartCity = data.StartCity;
            model.DestCountry = data.DestCountry;
            model.DestProvince = data.DestProvince;
            model.DestCity = data.DestCity;
            model.CarType = data.CarType;
            model.MinTunnagesOrPiles = data.MinTunnagesOrPiles;
            model.MaxTunnagesOrPiles = data.MaxTunnagesOrPiles;
            model.StartTime = data.StartTime.ToString("yyyy-MM-dd");
            model.EndTime = data.EndTime.ToString("yyyy-MM-dd");
            model.TransportPrice = data.TransportPrice;
            model.TransportCharges = data.TransportCharges;

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
            selectListStartProvince.AddRange(from s in listStartProvince
                                             select new SelectListItem
                                             {
                                                 Text = s.Name,
                                                 Value = s.Name
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

            //生成讫点国家下拉列表项
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
            ViewData["DestCountrys"] = new SelectList(selectListDestCountry, "Value", "Text", model.DestCountry);

            //生成讫点省份下拉列表项
            List<Province> listDestProvince = null;
            if (!string.IsNullOrEmpty(model.DestCountry))
            {
                listDestProvince = dd.LoadProvincesByCountry(model.DestCountry, LoginAccountId, LoginStaffName, out strErrText);
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
            selectListDestProvince.AddRange(from s in listDestProvince
                                            select new SelectListItem
                                            {
                                                Text = s.Name,
                                                Value = s.Name
                                            });
            ViewData["DestProvinces"] = new SelectList(selectListDestProvince, "Value", "Text", model.DestProvince);

            //生成讫点城市下拉列表项
            List<City> listDestCity = null;
            if (!string.IsNullOrEmpty(model.DestProvince))
            {
                listDestCity = dd.LoadCitysByProvince(model.DestCountry, model.DestProvince, LoginAccountId, LoginStaffName, out strErrText);
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
            ViewData["DestCitys"] = new SelectList(selectListDestCity, "Value", "Text", model.DestCity);

            return View(model);
        }

        /// <summary>
        /// POST修改运费限价
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyTransportLimitedPrice(TransportLimitedPriceViewModel model)
        {
            if (ModelState.IsValid)
            {
                //创建数据
                TransportLimitedPrice data = new TransportLimitedPrice();
                data.Id = model.Id;
                data.PlanType = model.PlanType;
                data.StartCountry = model.StartCountry;
                data.StartProvince = model.StartProvince;
                data.StartCity = model.StartCity;
                data.DestCountry = model.DestCountry;
                data.DestProvince = model.DestProvince;
                data.DestCity = model.DestCity;
                data.CarType = model.CarType;
                data.MinTunnagesOrPiles = model.MinTunnagesOrPiles;
                data.MaxTunnagesOrPiles = model.MaxTunnagesOrPiles;
                data.StartTime = DateTime.Parse(model.StartTime);
                data.EndTime = DateTime.Parse(model.EndTime);
                data.TransportPrice = model.TransportPrice;
                data.TransportCharges = model.TransportCharges;

                //保存数据
                string strErrText;
                DDSystem dd = new DDSystem();
                if (dd.UpdateTransportLimitedPrice(data, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除运费限价记录
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeleteTransportLimitedPrice(string id)
        {
            //删除数据
            string strErrText;
            DDSystem dd = new DDSystem();
            if (dd.DeleteTransportLimitedPrice(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
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
