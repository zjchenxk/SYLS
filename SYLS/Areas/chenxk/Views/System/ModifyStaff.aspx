<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.StaffViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ModifyStaff %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/System/SetStaff/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveStaff();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("ModifyStaff", "System", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset style="border: none;">
        <%: Html.HiddenFor(model => model.Id) %>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.FamilyName)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.FamilyName)%>
                        <%: Html.ValidationMessageFor(model => model.FamilyName)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Name)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Name)%>
                        <%: Html.ValidationMessageFor(model => model.Name)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Sex)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.Sex, new SelectListItem[]
                        {
                            new SelectListItem{Text = InnoSoft.LS.Resources.Options.Male, Value = InnoSoft.LS.Resources.Options.Male},
                            new SelectListItem{Text = InnoSoft.LS.Resources.Options.Female, Value = InnoSoft.LS.Resources.Options.Female}
                        }, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.Sex)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.OrganId)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.OrganId, ViewData["Organizations"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.OrganId)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.PositionId)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.PositionId, ViewData["Positions"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.PositionId)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.OfficeTel)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.OfficeTel)%>
                        <%: Html.ValidationMessageFor(model => model.OfficeTel)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TelExt)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TelExt)%>
                        <%: Html.ValidationMessageFor(model => model.TelExt)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Fax)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Fax)%>
                        <%: Html.ValidationMessageFor(model => model.Fax)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.MobileTel1)%>1
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.MobileTel1)%>
                        <%: Html.ValidationMessageFor(model => model.MobileTel1)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.MobileTel2)%>2
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.MobileTel2)%>
                        <%: Html.ValidationMessageFor(model => model.MobileTel2)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.MobileTel3)%>3
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.MobileTel3)%>
                        <%: Html.ValidationMessageFor(model => model.MobileTel3)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.EMail)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.EMail)%>
                        <%: Html.ValidationMessageFor(model => model.EMail)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.QQ)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.QQ)%>
                        <%: Html.ValidationMessageFor(model => model.QQ)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.BossStaffId)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.BossStaffId, ViewData["Bosses"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.BossStaffId)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.IsOrganLeader)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.IsOrganLeader)%>
                        <%: Html.ValidationMessageFor(model => model.IsOrganLeader)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.IsOrganManager)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.IsOrganManager)%>
                        <%: Html.ValidationMessageFor(model => model.IsOrganManager)%>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <% } %>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认名称获得焦点
                $("#FamilyName").focus().select();
            };
            //保存数据
            this.saveStaff = function () {
                $('#form1').submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            $("#IsOrganLeader").click(function () {
                if ($("#IsOrganLeader").attr("checked") == "checked") $("#IsOrganManager").attr("checked", true);
            });

            //提交事件
            $('#form1').submit(function () {
                if ($(this).valid()) {
                    $.blockUI({
                        message: '<h1><img src="<%=Url.Content("~/Content/busy.gif")%>" /><%: InnoSoft.LS.Resources.Strings.PleaseWait %></h1>',
                        css: {
                            border: 'none',
                            padding: '15px',
                            backgroundColor: '#000',
                            '-webkit-border-radius': '10px',
                            '-moz-border-radius': '10px',
                            opacity: .5,
                            color: '#fff'
                        }
                    });
                    $.post($(this).attr('action'), $(this).serialize(), function (ret) {
                        $.unblockUI();

                        if (ret != null && ret != "") {
                            alert(ret);
                        }
                        else {
                            alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceed %>");
                            location.replace("/chenxk/System/SetStaff/");
                        }
                    });
                }
                return false;
            });
        });

    </script>
</asp:Content>
