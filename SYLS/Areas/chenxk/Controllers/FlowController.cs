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
    /// 审批流程管理控制器
    /// </summary>
    public class FlowController : BaseController
    {
        #region 计划审批流程操作代码

        /// <summary>
        /// GET设置计划审批流程
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetPlanApproveFlow()
        {
            return View();
        }

        /// <summary>
        /// GET计划审批流程步骤表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPlanApproveStepsGrid(string sidx, string sord, int page, int rows)
        {
            //读取计划审批步骤数据
            string strErrText;
            FlowSystem flow = new FlowSystem();
            List<ApproveFlowStep> listStep = flow.LoadApproveFlowStepsByFlowType(InnoSoft.LS.Resources.Options.PlanApproveFlow, LoginAccountId, LoginStaffName, out strErrText);
            if (listStep == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listStep.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "StepNum") + " " + (sord ?? "ASC");
            var data = listStep.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              s.StepNum.ToString(), 
                              s.StepName,
                              s.DisposerName,
                              s.Conditions
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增计划审批步骤页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewPlanApproveStep()
        {
            string strErrText;

            //读取计划审批步骤数据
            FlowSystem flow = new FlowSystem();
            List<ApproveFlowStep> listStep = flow.LoadApproveFlowStepsByFlowType(InnoSoft.LS.Resources.Options.PlanApproveFlow, LoginAccountId, LoginStaffName, out strErrText);
            if (listStep == null)
            {
                throw new Exception(strErrText);
            }

            //生成新步骤序号
            int nStepNum = 1;
            if (listStep.Count > 0)
            {
                nStepNum = listStep[listStep.Count - 1].StepNum + 1;
            }

            //创建空的Model
            ApproveFlowStepViewModel model = new ApproveFlowStepViewModel();
            model.StepNum = nStepNum;

            model.Conditions = new List<ApproveFlowStepConditionViewModel>();
            model.Conditions.Add(new ApproveFlowStepConditionViewModel());

            //生成处理人下拉列表项
            StaffSystem staff = new StaffSystem();
            List<Staff> listStaff = staff.LoadStaffs(LoginAccountId, LoginStaffName, out strErrText);
            if (listStaff == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStaff = new List<SelectListItem>();
            selectListStaff.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStaff.AddRange(from s in listStaff
                                     select new SelectListItem
                                     {
                                         Text = s.FullName,
                                         Value = s.Id.ToString()
                                     });
            ViewData["Disposers"] = new SelectList(selectListStaff, "Value", "Text");

            return View(model);
        }

        /// <summary>
        /// POST新增计划审批步骤
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewPlanApproveStep(ApproveFlowStepViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.ConditionExpression == null || model.ConditionExpression == string.Empty)
                {
                    if (model.Conditions != null && model.Conditions.Count > 1)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterConditionExpressionWhenMultiConditions);
                    }
                }
                else
                {
                    if (model.Conditions == null || model.Conditions.Count <= 1)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.CanNotEnterConditionExpressionWhenNoOrOneCondition);
                    }
                }

                //创建数据
                ApproveFlowStep data = new ApproveFlowStep();
                data.StepName = model.StepName;
                data.StepNum = model.StepNum;
                data.FlowType = InnoSoft.LS.Resources.Options.PlanApproveFlow;
                data.DisposerId = model.DisposerId;
                data.ConditionExpression = model.ConditionExpression;

                List<ApproveFlowStepCondition> listConditions = new List<ApproveFlowStepCondition>();
                if (model.Conditions != null)
                {
                    foreach (ApproveFlowStepConditionViewModel m in model.Conditions)
                    {
                        ApproveFlowStepCondition c = new ApproveFlowStepCondition();
                        c.FlowType = InnoSoft.LS.Resources.Options.PlanApproveFlow;
                        c.ConditionNum = m.ConditionNum;
                        c.FieldName = m.FieldName;
                        c.CompareOperator = m.CompareOperator;
                        c.FieldValue = m.FieldValue;
                        listConditions.Add(c);
                    }
                }

                //保存数据
                string strErrText;
                FlowSystem flow = new FlowSystem();
                if (flow.InsertApproveFlowStep(data, listConditions, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// GET修改计划审批步骤页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyPlanApproveStep(string id)
        {
            string strErrText;

            //读取计划审批步骤数据
            FlowSystem flow = new FlowSystem();
            ApproveFlowStep data = flow.LoadApproveFlowStep(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            ApproveFlowStepViewModel model = new ApproveFlowStepViewModel();
            model.StepNum = data.StepNum;
            model.StepName = data.StepName;
            model.DisposerId = data.DisposerId;
            model.ConditionExpression = data.ConditionExpression;

            model.Conditions = new List<ApproveFlowStepConditionViewModel>();
            model.Conditions.Add(new ApproveFlowStepConditionViewModel());

            //生成处理人下拉列表项
            StaffSystem staff = new StaffSystem();
            List<Staff> listStaff = staff.LoadStaffs(LoginAccountId, LoginStaffName, out strErrText);
            if (listStaff == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStaff = new List<SelectListItem>();
            selectListStaff.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStaff.AddRange(from s in listStaff
                                     select new SelectListItem
                                     {
                                         Text = s.FullName,
                                         Value = s.Id.ToString()
                                     });
            ViewData["Disposers"] = new SelectList(selectListStaff, "Value", "Text", model.DisposerId);

            return View(model);
        }

        /// <summary>
        /// GET计划审批步骤处理条件表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPlanApproveFlowStepConditionsGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            FlowSystem flow = new FlowSystem();
            List<ApproveFlowStepCondition> listConditions = flow.LoadApproveFlowStepConditionsByStepId(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (listConditions == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listConditions.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "ConditionNum") + " " + (sord ?? "ASC");
            var data = listConditions.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              c.ConditionNum.ToString(),
                              c.FieldName,
                              c.CompareOperator,
                              c.FieldValue
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST修改计划审批步骤
        /// </summary>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyPlanApproveStep(ApproveFlowStepViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.ConditionExpression == null || model.ConditionExpression == string.Empty)
                {
                    if (model.Conditions != null && model.Conditions.Count > 1)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterConditionExpressionWhenMultiConditions);
                    }
                }
                else
                {
                    if (model.Conditions == null || model.Conditions.Count <= 1)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.CanNotEnterConditionExpressionWhenNoOrOneCondition);
                    }
                }

                //创建数据
                ApproveFlowStep data = new ApproveFlowStep();
                data.Id = model.Id;
                data.StepName = model.StepName;
                data.StepNum = model.StepNum;
                data.FlowType = InnoSoft.LS.Resources.Options.PlanApproveFlow;
                data.DisposerId = model.DisposerId;
                data.ConditionExpression = model.ConditionExpression;

                List<ApproveFlowStepCondition> listConditions = new List<ApproveFlowStepCondition>();
                if (model.Conditions != null)
                {
                    foreach (ApproveFlowStepConditionViewModel m in model.Conditions)
                    {
                        ApproveFlowStepCondition c = new ApproveFlowStepCondition();
                        c.StepId = model.Id;
                        c.FlowType = InnoSoft.LS.Resources.Options.PlanApproveFlow;
                        c.ConditionNum = m.ConditionNum;
                        c.FieldName = m.FieldName;
                        c.CompareOperator = m.CompareOperator;
                        c.FieldValue = m.FieldValue;
                        listConditions.Add(c);
                    }
                }

                //保存数据
                string strErrText;
                FlowSystem flow = new FlowSystem();
                if (flow.UpdateApproveFlowStep(data, listConditions, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除计划审批步骤
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeletePlanApproveStep(string id)
        {
            //删除数据
            string strErrText;
            FlowSystem flow = new FlowSystem();
            if (flow.DeleteApproveFlowStep(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// POST上移计划审批步骤
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult MoveUpPlanApproveStep(string id)
        {
            //修改数据
            string strErrText;
            FlowSystem flow = new FlowSystem();
            if (flow.MoveUpApproveStep(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// POST下移计划审批步骤
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult MoveDownPlanApproveStep(string id)
        {
            //修改数据
            string strErrText;
            FlowSystem flow = new FlowSystem();
            if (flow.MoveDownApproveStep(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        #endregion

        #region 价格审批流程操作代码

        /// <summary>
        /// GET设置价格审批流程页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SetPriceApproveFlow()
        {
            return View();
        }

        /// <summary>
        /// GET价格审批流程步骤表格数据
        /// </summary>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPriceApproveStepsGrid(string sidx, string sord, int page, int rows)
        {
            //读取价格审批步骤数据
            string strErrText;
            FlowSystem flow = new FlowSystem();
            List<ApproveFlowStep> listStep = flow.LoadApproveFlowStepsByFlowType(InnoSoft.LS.Resources.Options.PriceApproveFlow, LoginAccountId, LoginStaffName, out strErrText);
            if (listStep == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listStep.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "StepNum") + " " + (sord ?? "ASC");
            var data = listStep.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              s.StepNum.ToString(), 
                              s.StepName,
                              s.DisposerName,
                              s.Conditions
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// GET新增价格审批步骤页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult NewPriceApproveStep()
        {
            string strErrText;

            //读取价格审批步骤数据
            FlowSystem flow = new FlowSystem();
            List<ApproveFlowStep> listStep = flow.LoadApproveFlowStepsByFlowType(InnoSoft.LS.Resources.Options.PriceApproveFlow, LoginAccountId, LoginStaffName, out strErrText);
            if (listStep == null)
            {
                throw new Exception(strErrText);
            }

            //生成新步骤序号
            int nStepNum = 1;
            if (listStep.Count > 0)
            {
                nStepNum = listStep[listStep.Count - 1].StepNum + 1;
            }

            //创建空的Model
            PriceApproveFlowStepViewModel model = new PriceApproveFlowStepViewModel();
            model.StepNum = nStepNum;

            model.Conditions = new List<PriceApproveFlowStepConditionViewModel>();
            model.Conditions.Add(new PriceApproveFlowStepConditionViewModel());

            //生成处理人下拉列表项
            StaffSystem staff = new StaffSystem();
            List<Staff> listStaff = staff.LoadStaffs(LoginAccountId, LoginStaffName, out strErrText);
            if (listStaff == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStaff = new List<SelectListItem>();
            selectListStaff.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStaff.AddRange(from s in listStaff
                                     select new SelectListItem
                                     {
                                         Text = s.FullName,
                                         Value = s.Id.ToString()
                                     });
            ViewData["Disposers"] = new SelectList(selectListStaff, "Value", "Text");

            return View(model);
        }

        /// <summary>
        /// POST新增价格审批步骤
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult NewPriceApproveStep(PriceApproveFlowStepViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.ConditionExpression == null || model.ConditionExpression == string.Empty)
                {
                    if (model.Conditions != null && model.Conditions.Count > 1)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterConditionExpressionWhenMultiConditions);
                    }
                }
                else
                {
                    if (model.Conditions == null || model.Conditions.Count <= 1)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.CanNotEnterConditionExpressionWhenNoOrOneCondition);
                    }
                }

                //创建数据
                ApproveFlowStep data = new ApproveFlowStep();
                data.StepName = model.StepName;
                data.StepNum = model.StepNum;
                data.FlowType = InnoSoft.LS.Resources.Options.PriceApproveFlow;
                data.DisposerId = model.DisposerId;
                data.ConditionExpression = model.ConditionExpression;

                List<ApproveFlowStepCondition> listConditions = new List<ApproveFlowStepCondition>();
                if (model.Conditions != null)
                {
                    foreach (PriceApproveFlowStepConditionViewModel m in model.Conditions)
                    {
                        ApproveFlowStepCondition c = new ApproveFlowStepCondition();
                        c.FlowType = InnoSoft.LS.Resources.Options.PriceApproveFlow;
                        c.ConditionNum = m.ConditionNum;
                        c.FieldName = m.FieldName;
                        c.CompareOperator = m.CompareOperator;
                        c.FieldValue = m.FieldValue;
                        listConditions.Add(c);
                    }
                }

                //保存数据
                string strErrText;
                FlowSystem flow = new FlowSystem();
                if (flow.InsertApproveFlowStep(data, listConditions, LoginAccountId, LoginStaffName, out strErrText) > 0)
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
        /// GET修改价格审批步骤页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        public ActionResult ModifyPriceApproveStep(string id)
        {
            string strErrText;

            //读取价格审批步骤数据
            FlowSystem flow = new FlowSystem();
            ApproveFlowStep data = flow.LoadApproveFlowStep(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (data == null)
            {
                throw new Exception(strErrText);
            }

            //创建Model
            PriceApproveFlowStepViewModel model = new PriceApproveFlowStepViewModel();
            model.StepNum = data.StepNum;
            model.StepName = data.StepName;
            model.DisposerId = data.DisposerId;
            model.ConditionExpression = data.ConditionExpression;

            model.Conditions = new List<PriceApproveFlowStepConditionViewModel>();
            model.Conditions.Add(new PriceApproveFlowStepConditionViewModel());

            //生成处理人下拉列表项
            StaffSystem staff = new StaffSystem();
            List<Staff> listStaff = staff.LoadStaffs(LoginAccountId, LoginStaffName, out strErrText);
            if (listStaff == null)
            {
                throw new Exception(strErrText);
            }
            List<SelectListItem> selectListStaff = new List<SelectListItem>();
            selectListStaff.Add(new SelectListItem { Text = string.Empty, Value = string.Empty });
            selectListStaff.AddRange(from s in listStaff
                                     select new SelectListItem
                                     {
                                         Text = s.FullName,
                                         Value = s.Id.ToString()
                                     });
            ViewData["Disposers"] = new SelectList(selectListStaff, "Value", "Text", model.DisposerId);

            return View(model);
        }

        /// <summary>
        /// GET计划审批步骤处理条件表格数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sidx"></param>
        /// <param name="sord"></param>
        /// <param name="page"></param>
        /// <param name="rows"></param>
        /// <returns></returns>
        [Authorize]
        public JsonResult LoadPriceApproveFlowStepConditionsGrid(string id, string sidx, string sord, int page, int rows)
        {
            //读取数据
            string strErrText;
            FlowSystem flow = new FlowSystem();
            List<ApproveFlowStepCondition> listConditions = flow.LoadApproveFlowStepConditionsByStepId(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText);
            if (listConditions == null)
            {
                throw new Exception(strErrText);
            }

            //提取当前页面数据
            int nTotalRows = listConditions.Count;
            int nPageIndex = page;
            int nPageSize = rows;
            int nTotalPages = nTotalRows / nPageSize;
            if (nTotalRows % nPageSize > 0)
                nTotalPages++;

            string sortExpression = (sidx ?? "ConditionNum") + " " + (sord ?? "ASC");
            var data = listConditions.OrderBy(sortExpression).Skip((nPageIndex - 1) * nPageSize).Take(nPageSize).ToList();

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
                              c.ConditionNum.ToString(),
                              c.FieldName,
                              c.CompareOperator,
                              c.FieldValue
                          }
                      }).ToArray()
            };
            return Json(ret, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// POST修改价格审批步骤
        /// </summary>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult ModifyPriceApproveStep(PriceApproveFlowStepViewModel model)
        {
            if (ModelState.IsValid)
            {
                //检查数据
                if (model.ConditionExpression == null || model.ConditionExpression == string.Empty)
                {
                    if (model.Conditions != null && model.Conditions.Count > 1)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.NotEnterConditionExpressionWhenMultiConditions);
                    }
                }
                else
                {
                    if (model.Conditions == null || model.Conditions.Count <= 1)
                    {
                        return Json(InnoSoft.LS.Resources.Strings.CanNotEnterConditionExpressionWhenNoOrOneCondition);
                    }
                }

                //创建数据
                ApproveFlowStep data = new ApproveFlowStep();
                data.Id = model.Id;
                data.StepName = model.StepName;
                data.StepNum = model.StepNum;
                data.FlowType = InnoSoft.LS.Resources.Options.PriceApproveFlow;
                data.DisposerId = model.DisposerId;
                data.ConditionExpression = model.ConditionExpression;

                List<ApproveFlowStepCondition> listConditions = new List<ApproveFlowStepCondition>();
                if (model.Conditions != null)
                {
                    foreach (PriceApproveFlowStepConditionViewModel m in model.Conditions)
                    {
                        ApproveFlowStepCondition c = new ApproveFlowStepCondition();
                        c.StepId = model.Id;
                        c.FlowType = InnoSoft.LS.Resources.Options.PriceApproveFlow;
                        c.ConditionNum = m.ConditionNum;
                        c.FieldName = m.FieldName;
                        c.CompareOperator = m.CompareOperator;
                        c.FieldValue = m.FieldValue;
                        listConditions.Add(c);
                    }
                }

                //保存数据
                string strErrText;
                FlowSystem flow = new FlowSystem();
                if (flow.UpdateApproveFlowStep(data, listConditions, LoginAccountId, LoginStaffName, out strErrText))
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
        /// POST删除价格审批步骤
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult DeletePriceApproveStep(string id)
        {
            //删除数据
            string strErrText;
            FlowSystem flow = new FlowSystem();
            if (flow.DeleteApproveFlowStep(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// POST上移价格审批步骤
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult MoveUpPriceApproveStep(string id)
        {
            //修改数据
            string strErrText;
            FlowSystem flow = new FlowSystem();
            if (flow.MoveUpApproveStep(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
            {
                return Json(string.Empty);
            }
            else
            {
                return Json(strErrText);
            }
        }

        /// <summary>
        /// POST下移价格审批步骤
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public ActionResult MoveDownPriceApproveStep(string id)
        {
            //修改数据
            string strErrText;
            FlowSystem flow = new FlowSystem();
            if (flow.MoveDownApproveStep(long.Parse(id), LoginAccountId, LoginStaffName, out strErrText))
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
