<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SubmitNoodlePlan %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Plan/SubmitDeliverPlans/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="/chenxk/Plan/SubmitDeliverPlan/" onclick="javascript:objMain.objWorkspace.objContent.submitPlan(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/052.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Submit%></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% Html.RenderAction("LoadNoodlePlanDetails", "Plan", new { id = ViewData["id"] }); %>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //提交数据
            this.submitPlan = function (action) {
                if (confirm("<%: InnoSoft.LS.Resources.Strings.SubmitPlanConfirm %>") == true) {
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

                    $.post(action, { id: '<%: ViewData["id"] %>' }, function (ret) {
                        $.unblockUI();

                        if (ret.Success == false) {
                            alert(ret.Message);
                        }
                        else {
                            alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceed %>");
                            if (ret.Message != null && ret.Message != "") {
                                alert(ret.Message);
                            }
                            location.replace("/chenxk/Plan/SubmitDeliverPlans/");
                        }
                    });
                }
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {

        });

    </script>
</asp:Content>
