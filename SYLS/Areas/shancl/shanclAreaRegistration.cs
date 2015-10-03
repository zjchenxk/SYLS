using System.Web.Mvc;

namespace SYLS.Areas.shancl
{
    public class shanclAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "shancl";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "LoadCitys",
                "shancl/{controller}/{action}/{country}/{province}"
                );

            context.MapRoute(
                "shancl_default",
                "shancl/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
