using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class CarrierCarViewModel
    {
        /// <summary>
        /// 记录编码
        /// </summary>
        [Display(Name = "Id", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 承运单位编码
        /// </summary>
        [Display(Name = "CarrierId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long CarrierId { get; set; }

        /// <summary>
        /// 车号
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "CarNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CarNo { get; set; }

        /// <summary>
        /// 挂号
        /// </summary>
        [StringLength(10)]
        [Display(Name = "TrailerNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string TrailerNo { get; set; }

        /// <summary>
        /// 载重
        /// </summary>
        [Required]
        [RegularExpression(@"^\d+$", ErrorMessageResourceName = "NotValidInteger", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanOrEqualZero(ErrorMessageResourceName = "CarryingCapacityNotGreaterThanOrEqualZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "CarryingCapacity", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public int CarryingCapacity { get; set; }
    }
}