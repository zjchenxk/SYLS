using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SYLS.Controllers
{
    /// <summary>
    /// 帮助控制器
    /// </summary>
    public class HelpController : Controller
    {
        /// <summary>
        /// GET结算公式帮助页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult SettlementExpression()
        {
            return View();
        }

        /// <summary>
        /// GET运费公式帮助页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult TransportChargeExpression()
        {
            return View();
        }

        /// <summary>
        /// GET单价公式帮助页面
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult TransportPriceExpression()
        {
            return View();
        }
    }
}
