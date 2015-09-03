using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using InnoSoft.LS.Models;

namespace SYLS.Helper
{
    public class ControlHelper
    {
        /// <summary>
        /// 生成组织部门下拉列表项
        /// </summary>
        /// <param name="listOrganization"></param>
        /// <param name="nSelectedOrganId"></param>
        /// <returns></returns>
        public static SelectList MakeOrganizationSelectList(List<Organization> listOrganization, long nSelectedOrganId)
        {
            List<SelectListItem> selectList = new List<SelectListItem>();

            //添加空选项
            selectList.Add(new SelectListItem { Text = string.Empty, Value = "0" });

            //递归添加组织部门
            RecursiveAppendOrganizations(listOrganization, 0, "", selectList);

            return new SelectList(selectList, "Value", "Text", nSelectedOrganId.ToString());
        }

        /// <summary>
        /// 递归填充下级组织部门
        /// </summary>
        /// <param name="listOrganization">组织结构数据集</param>
        /// <param name="nParentId">上级组织编码</param>
        /// <param name="strIndent">组织名称缩进</param>
        /// <param name="selectList"></param>
        private static void RecursiveAppendOrganizations(List<Organization> listOrganization, long nParentId, string strIndent, List<SelectListItem> selectList)
        {
            List<Organization> listFind = listOrganization.FindAll(delegate(Organization o) { return o.ParentId == nParentId; });
            foreach (Organization find in listFind)
            {
                selectList.Add(new SelectListItem { Text = strIndent + find.Name, Value = find.Id.ToString() });

                RecursiveAppendOrganizations(listOrganization, find.Id, strIndent + InnoSoft.LS.Resources.Strings.FillSpace, selectList);
            }
        }

    }
}