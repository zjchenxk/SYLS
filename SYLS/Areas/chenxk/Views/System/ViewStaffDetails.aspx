<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.StaffViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ViewStaffDetails %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/System/SetStaff/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.modifyStaff();return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <fieldset style="border: none;">
        <table cellspacing="1" class="details">
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.StaffId %>
                </td>
                <td class="content">
                    <%: Model.Id %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.LastName %>
                </td>
                <td class="content">
                    <%: Model.FamilyName %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.FirstName %>
                </td>
                <td class="content">
                    <%: Model.Name %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.Sex %>
                </td>
                <td class="content">
                    <%: Model.Sex %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.OrganName %>
                </td>
                <td class="content">
                    <%: Model.OrganFullName %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.PositionName %>
                </td>
                <td class="content">
                    <%: Model.PositionName %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.Tel %>
                </td>
                <td class="content">
                    <%: Model.OfficeTel %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.TelExt %>
                </td>
                <td class="content">
                    <%: Model.TelExt %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.Fax %>
                </td>
                <td class="content">
                    <%: Model.Fax %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.MobileTel %>1
                </td>
                <td class="content">
                    <%: Model.MobileTel1 %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.MobileTel %>2
                </td>
                <td class="content">
                    <%: Model.MobileTel2 %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.MobileTel %>3
                </td>
                <td class="content">
                    <%: Model.MobileTel3 %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.EMail %>
                </td>
                <td class="content">
                    <%: Model.EMail %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.QQ %>
                </td>
                <td class="content">
                    <%: Model.QQ %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.BossName %>
                </td>
                <td class="content">
                    <%: Model.BossStaffName %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.IsOrganManager %>
                </td>
                <td class="content">
                    <%: Model.IsOrganManager? InnoSoft.LS.Resources.Options.Yes : InnoSoft.LS.Resources.Options.No %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.IsOrganLeader %>
                </td>
                <td class="content">
                    <%: Model.IsOrganLeader? InnoSoft.LS.Resources.Options.Yes : InnoSoft.LS.Resources.Options.No %>
                </td>
            </tr>
        </table>
    </fieldset>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //修改员工
            this.modifyStaff = function () {
                location.replace("/chenxk/System/ModifyStaff/<%: Model.Id %>");
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

    </script>
</asp:Content>
