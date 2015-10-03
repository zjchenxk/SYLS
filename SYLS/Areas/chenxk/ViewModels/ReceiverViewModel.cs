using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace SYLS.Areas.chenxk.ViewModels
{
    public class ReceiverViewModel
    {
        /// <summary>
        /// 提货单位编码
        /// </summary>
        [Display(Name = "ReceiverId", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public long Id { get; set; }

        /// <summary>
        /// 提货单位名称
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "ReceiverName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Name { get; set; }

        /// <summary>
        /// 所在国家
        /// </summary>
        [Required]
        [Display(Name = "CountryName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Country { get; set; }

        /// <summary>
        /// 所在省份
        /// </summary>
        [Required]
        [Display(Name = "StateName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Province { get; set; }

        /// <summary>
        /// 所在城市
        /// </summary>
        [Required]
        [Display(Name = "CityName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string City { get; set; }

        /// <summary>
        /// 街道地址
        /// </summary>
        [Required]
        [StringLength(50)]
        [Display(Name = "Address", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Address { get; set; }

        /// <summary>
        /// 联系人姓名
        /// </summary>
        [StringLength(20)]
        [Display(Name = "ContactName", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string Contact { get; set; }

        /// <summary>
        /// 联系人电话
        /// </summary>
        [StringLength(20)]
        [Display(Name = "ContactTel", ResourceType = typeof(InnoSoft.LS.Resources.Labels))]
        public string ContactTel { get; set; }

        /// <summary>
        /// 距离集合
        /// </summary>
        public List<ReceiverDistanceViewModel> Distances { get; set; }
    }
}