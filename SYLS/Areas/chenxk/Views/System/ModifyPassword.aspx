<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.ModifyPasswordViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ModifyPassword %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.savePassword();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("ModifyPassword", "System", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset style="border: none;">
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.OldPassword) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.PasswordFor(model => model.OldPassword)%>
                        <%: Html.ValidationMessageFor(model => model.OldPassword) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.NewPassword) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.PasswordFor(model => model.NewPassword)%>
                        <%: Html.ValidationMessageFor(model => model.NewPassword) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ConfirmPassword) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.PasswordFor(model => model.ConfirmPassword)%>
                        <%: Html.ValidationMessageFor(model => model.ConfirmPassword) %>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <% } %>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整布局
            this.resizeContent = function () {
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认名称获得焦点
                $("#OldPassword").focus().select();
            };
            //保存密码
            this.savePassword = function () {
                $('#form1').submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
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
                            location.replace("/LogOn/Exit");
                        }
                    });
                }
                return false;
            });
        });

    </script>
</asp:Content>
