using System.Web.Mvc;

namespace SYLS.Areas.chenxk
{
    public class chenxkAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "chenxk";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "DisagreeDeliverPlan",
                "chenxk/{controller}/{action}/{id}/{disagreeopinion}"
                );

            context.MapRoute(
                "chenxk_default",
                "chenxk/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
