using System.Web.Mvc;
using System;

namespace SYLS.Controllers
{
    /// <summary>
    /// 控制器基类
    /// </summary>
    public class BaseController : Controller
    {
        /// <summary>
        /// 获取或设置登录帐号编码
        /// </summary>
        protected long LoginAccountId
        {
            get
            {
                if (Session["LoginAccountId"] != null)
                {
                    return long.Parse(Session["LoginAccountId"].ToString());
                }
                else
                {
                    throw new Exception(InnoSoft.LS.Resources.Strings.SessionExpired);
                }
            }
            set
            {
                Session["LoginAccountId"] = value;
            }
        }

        /// <summary>
        /// 获取或设置登录帐号名称
        /// </summary>
        protected string LoginAccountName
        {
            get
            {
                if (Session["LoginAccountName"] != null)
                {
                    return Session["LoginAccountName"].ToString();
                }
                else
                {
                    throw new Exception(InnoSoft.LS.Resources.Strings.SessionExpired);
                }
            }
            set
            {
                Session["LoginAccountName"] = value;
            }
        }

        /// <summary>
        /// 获取或设置登录帐号类别
        /// </summary>
        protected string LoginAccountType
        {
            get
            {
                if (Session["LoginAccountType"] != null)
                {
                    return Session["LoginAccountType"].ToString();
                }
                else
                {
                    throw new Exception(InnoSoft.LS.Resources.Strings.SessionExpired);
                }
            }
            set
            {
                Session["LoginAccountType"] = value;
            }
        }

        /// <summary>
        /// 获取或设置登录人组织部门编码
        /// </summary>
        protected long LoginOrganId
        {
            get
            {
                if (Session["LoginOrganId"] != null)
                {
                    return long.Parse(Session["LoginOrganId"].ToString());
                }
                else
                {
                    throw new Exception(InnoSoft.LS.Resources.Strings.SessionExpired);
                }
            }
            set
            {
                Session["LoginOrganId"] = value;
            }
        }

        /// <summary>
        /// 获取或设置登录人组织部门名称
        /// </summary>
        protected string LoginOrganName
        {
            get
            {
                if (Session["LoginOrganName"] != null)
                {
                    return Session["LoginOrganName"].ToString();
                }
                else
                {
                    throw new Exception(InnoSoft.LS.Resources.Strings.SessionExpired);
                }
            }
            set
            {
                Session["LoginOrganName"] = value;
            }
        }

        /// <summary>
        /// 获取或设置登录人编码
        /// </summary>
        protected long LoginStaffId
        {
            get
            {
                if (Session["LoginStaffId"] != null)
                {
                    return long.Parse(Session["LoginStaffId"].ToString());
                }
                else
                {
                    throw new Exception(InnoSoft.LS.Resources.Strings.SessionExpired);
                }
            }
            set
            {
                Session["LoginStaffId"] = value;
            }
        }

        /// <summary>
        /// 获取或设置登录人姓名
        /// </summary>
        protected string LoginStaffName
        {
            get
            {
                if (Session["LoginStaffName"] != null)
                {
                    return Session["LoginStaffName"].ToString();
                }
                else
                {
                    throw new Exception(InnoSoft.LS.Resources.Strings.SessionExpired);
                }
            }
            set
            {
                Session["LoginStaffName"] = value;
            }
        }

        /// <summary>
        /// 清除登录帐号
        /// </summary>
        protected void ClearLoginAccount()
        {
            Session.Remove("LoginAccountId");
            Session.Remove("LoginAccountName");
            Session.Remove("LoginAccountType");
            Session.Remove("LoginOrganId");
            Session.Remove("LoginOrganName");
            Session.Remove("LoginStaffId");
            Session.Remove("LoginStaffName");
        }

        /// <summary>
        /// 重写异常处理
        /// </summary>
        /// <param name="filterContext"></param>
        protected override void OnException(ExceptionContext filterContext)
        {
            filterContext.ExceptionHandled = true;
            if (filterContext.HttpContext.Request.IsAjaxRequest())
            {
                filterContext.Result = new ContentResult { Content = filterContext.Exception.Message };
            }
            else
            {
                string controllerName = (string)filterContext.RouteData.Values["controller"];
                string actionName = (string)filterContext.RouteData.Values["action"];
                HandleErrorInfo model = new HandleErrorInfo(filterContext.Exception, controllerName, actionName);
                filterContext.Result = new ViewResult { ViewName = "Error", MasterName = "", ViewData = new ViewDataDictionary<HandleErrorInfo>(model), TempData = filterContext.Controller.TempData };
            }
        }
    }
}
