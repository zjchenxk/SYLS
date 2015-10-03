using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.shancl.ViewModels
{
    public class ProvinceViewModel
    {
        /// <summary>
        /// 省份编码
        /// </summary>
        [Display(Name = "Id", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 省份名称
        /// </summary>
        [Required]
        [StringLength(20)]
        [Display(Name = "Name", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Name { get; set; }

        /// <summary>
        /// 所属国家名称
        /// </summary>
        [Required]
        [Display(Name = "CountryName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string CountryName { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        [StringLength(100)]
        [Display(Name = "Remark", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Remark { get; set; }
    }
}