using System.ComponentModel.DataAnnotations;
using SYLS.Helper;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class ReceiverDistanceViewModel
    {
        /// <summary>
        /// 起点国家
        /// </summary>
        [Required]
        [Display(Name = "StartCountry", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string StartCountry { get; set; }

        /// <summary>
        /// 起点省份
        /// </summary>
        [Required]
        [Display(Name = "StartProvince", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string StartProvince { get; set; }

        /// <summary>
        /// 起点城市
        /// </summary>
        [Required]
        [Display(Name = "StartCity", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string StartCity { get; set; }

        /// <summary>
        /// 公里数
        /// </summary>
        [RegularExpression(@"^\d+$", ErrorMessageResourceName = "NotValidInteger", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [GreaterThanZero(ErrorMessageResourceName = "KMNotGreaterThanZero", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "KM", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public int KM { get; set; }
    }
}