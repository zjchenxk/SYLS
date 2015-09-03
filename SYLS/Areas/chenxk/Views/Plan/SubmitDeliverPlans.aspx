<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SubmitDeliverPlans %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.modifyDeliverPlan();return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/chenxk/Plan/CopyDeliverPlan/" onclick="javascript:objMain.objWorkspace.objContent.copyDeliverPlan(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Copy%></a></li>
        <li><a href="/chenxk/Plan/DeleteDeliverPlan/" onclick="javascript:objMain.objWorkspace.objContent.deleteDeliverPlan(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete%></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.submitDeliverPlan();return false;">
            <img src="<%: Url.Content("~/Content/Images/052.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Submit%></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中计划编码
            this.selectedPlanId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //修改计划
            this.modifyDeliverPlan = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 1050, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedPlanId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedPlan %>");
                        return;
                    }

                    var data = $("#grid1").jqGrid("getRowData", objMain.objWorkspace.objContent.selectedPlanId);
                    if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.PaperPlan %>") {
                        location.replace("/chenxk/Plan/ModifyPaperPlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverPaperPlan %>") {
                        location.replace("/chenxk/Plan/ModifyNotDeliverPaperPlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.CanPlan %>") {
                        location.replace("/chenxk/Plan/ModifyCanPlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverCanPlan %>") {
                        location.replace("/chenxk/Plan/ModifyNotDeliverCanPlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NoodlePlan %>") {
                        location.replace("/chenxk/Plan/ModifyNoodlePlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                    else {
                        location.replace("/chenxk/Plan/ModifyOtherPlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //复制计划
            this.copyDeliverPlan = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 1050, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedPlanId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedPlan %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.CopyPlanConfirm %>") == true) {
                        location.replace(action + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除计划
            this.deleteDeliverPlan = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 1050, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedPlanId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedPlan %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeletePlanConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedPlanId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                location.replace("/chenxk/Plan/SubmitDeliverPlans/");
                            }
                        });
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //提交计划
            this.submitDeliverPlan = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 1050, strPermission: "AllowSubmit" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedPlanId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedPlan %>");
                        return;
                    }

                    var data = $("#grid1").jqGrid("getRowData", objMain.objWorkspace.objContent.selectedPlanId);
                    if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.PaperPlan %>" || data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverPaperPlan %>") {
                        location.replace("/chenxk/Plan/SubmitPaperPlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.CanPlan %>" || data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverCanPlan %>") {
                        location.replace("/chenxk/Plan/SubmitCanPlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NoodlePlan %>") {
                        location.replace("/chenxk/Plan/SubmitNoodlePlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                    else {
                        location.replace("/chenxk/Plan/SubmitOtherPlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            $("#grid1").jqGrid({
                url: "/chenxk/Plan/LoadSubmitDeliverPlansGrid/",
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverAddress %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.ApproveResult %>",
                    "<%: InnoSoft.LS.Resources.Labels.ApproveComment %>",
                    "<%: InnoSoft.LS.Resources.Labels.ApproverName %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "PlanNo", index: "PlanNo", width: 100, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "ReceiverAddress", index: "ReceiverAddress", width: 300 },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "LastIsAgreed", index: "LastIsAgreed", width: 60, align: "center" },
                    { name: "LastApproveComment", index: "LastApproveComment", width: 200 },
                    { name: "LastApproverName", index: "LastApproverName", width: 60, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "PlanNo",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedPlanId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });
        });

    </script>
</asp:Content>
