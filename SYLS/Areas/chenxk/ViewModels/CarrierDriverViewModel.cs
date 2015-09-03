using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class CarrierDriverViewModel
    {
        /// <summary>
        /// 承运单位编码
        /// </summary>
        [Display(Name = "CarrierId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long CarrierId { get; set; }

        /// <summary>
        /// 车号
        /// </summary>
        [Required]
        [Display(Name = "CarNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CarNo { get; set; }

        /// <summary>
        /// 姓名
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "DriverName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Name { get; set; }

        /// <summary>
        /// 驾驶证号
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "LicenseNo", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string LicenseNo { get; set; }

        /// <summary>
        /// 手机号码
        /// </summary>
        [Required]
        [StringLength(20)]
        [DataType(DataType.PhoneNumber)]
        [RegularExpression(@"^(13[0-9]|14[7]|15[0-9]|18[0-9])\d{8}$", ErrorMessageResourceName = "NotValidMobileTel", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "MobileTel", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string MobileTel { get; set; }

        /// <summary>
        /// 住宅电话
        /// </summary>
        [StringLength(20)]
        [DataType(DataType.PhoneNumber)]
        [RegularExpression(@"0\d{2,3}-\d{5,9}|0\d{2,3}-\d{5,9}", ErrorMessageResourceName = "NotValidTel", ErrorMessageResourceType = typeof(InnoSoft.LS.Resources.Strings))]
        [Display(Name = "HomeTel", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string HomeTel { get; set; }
    }
}