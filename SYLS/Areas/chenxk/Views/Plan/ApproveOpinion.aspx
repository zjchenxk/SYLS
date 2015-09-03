<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ApproveOpinion %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Plan/AgreeDeliverPlan/" onclick="javascript:objMain.objWorkspace.objContent.agreePlan(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/079.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Agree %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.disagreePlan();return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Disagree %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% Html.RenderAction(ViewData["PlanType"] == InnoSoft.LS.Resources.Options.PaperPlan ? "LoadPaperPlanDetails" : "LoadCanPlanDetails", "Plan", new { id = ViewData["id"] }); %>
    <div id="dialogOpinion" title="">
        <input type="text" id="txtDisagreeOpinion" maxlength="200" />
    </div>
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
            //同意计划
            this.agreePlan = function (action) {
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
                        location.replace("/chenxk/Plan/ApproveDeliverPlans/");
                    }
                });
            };
            //不同意计划
            this.disagreePlan = function () {
                //打开意见输入对话框
                $("#dialogOpinion").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterOpinion %>");
                $("#dialogOpinion").dialog("open");
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //创建意见输入对话框
            $("#dialogOpinion").dialog({
                autoOpen: false,
                height: 150,
                width: 450,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#txtDisagreeOpinion").val().trim() == "") {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterDisagreeOpinion %>");
                            return;
                        }

                        $(this).dialog("close");

                        $.post("/chenxk/Plan/DisagreeDeliverPlan/", { id: '<%: ViewData["id"] %>', disagreeopinion: $("#txtDisagreeOpinion").val().trim() }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceed %>");
                                location.replace("/chenxk/Plan/ApproveDeliverPlans/");
                            }
                        });
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

        });

    </script>
</asp:Content>
