using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SYLS.Controllers
{
    /// <summary>
    /// 主页控制器
    /// </summary>
    public class HomeController : BaseController
    {
        /// <summary>
        /// GET主视图页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult Main()
        {
            if (!string.IsNullOrEmpty(LoginStaffName))
            {
                Session["WelcomeText"] = string.Format(InnoSoft.LS.Resources.Strings.Welcome, LoginOrganName, LoginStaffName);
            }

            return View();
        }

    }
}
