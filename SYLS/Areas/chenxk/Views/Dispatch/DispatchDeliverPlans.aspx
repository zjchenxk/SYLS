<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.DispatchDeliverPlans %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.dispatch();return false;">
            <img src="<%: Url.Content("~/Content/Images/015.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Dispatch %></a></li>
        <li><a href="/chenxk/Dispatch/CancelDeliverPlan/" onclick="javascript:objMain.objWorkspace.objContent.cancel(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Cancel %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <div id="Grid2" style="margin-top: 1px;">
        <table id="grid2">
        </table>
        <div id="pager2">
        </div>
    </div>
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("SearchDispatchDeliverPlanCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中计划编码
            this.selectedPlanId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                var h1 = $("#divWorkspaceContent").height() / 2;
                var h2 = $("#divWorkspaceContent").height() - h1;

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", h1 - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) + 1) - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")) - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) + 1) - 1);

                $("#grid2").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid2").jqGrid("setGridHeight", h2 - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) + 1) - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")) - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) + 1) - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询条件
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 2010, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formSearchDispatchDeliverPlanCondition #OrganId").get(0).selectedIndex = 0;
                    $("#formSearchDispatchDeliverPlanCondition #CustomerName").val("");
                    $("#formSearchDispatchDeliverPlanCondition #ShipmentNo").val("");
                    $("#formSearchDispatchDeliverPlanCondition #DeliveryNo").val("");
                    $("#formSearchDispatchDeliverPlanCondition #ReceiverName").val("");
                    $("#formSearchDispatchDeliverPlanCondition #DestCountry").get(0).selectedIndex = 0;
                    $("#formSearchDispatchDeliverPlanCondition #DestProvince").empty();
                    $("#formSearchDispatchDeliverPlanCondition #DestProvince").append("<option value=''></option>");
                    $("#formSearchDispatchDeliverPlanCondition #DestCity").empty();
                    $("#formSearchDispatchDeliverPlanCondition #DestCity").append("<option value=''></option>");
                    $("#formSearchDispatchDeliverPlanCondition #Warehouse").get(0).selectedIndex = 0;
                    $("#formSearchDispatchDeliverPlanCondition #ArrivalTime").val("");

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //查看待调度计划详细信息
            this.viewDispatchDeliverPlanDetails = function (rowid) {
                var data = $("#grid1").jqGrid("getRowData", rowid);
                if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.PaperPlan %>" || data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverPaperPlan %>") {
                    location.replace("/chenxk/Dispatch/ViewDispatchPaperPlanDetails/" + rowid);
                }
                else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.CanPlan %>" || data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverCanPlan %>") {
                    location.replace("/chenxk/Dispatch/ViewDispatchCanPlanDetails/" + rowid);
                }
                else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NoodlePlan %>") {
                    location.replace("/chenxk/Dispatch/ViewDispatchNoodlePlanDetails/" + rowid);
                }
                else {
                    location.replace("/chenxk/Dispatch/ViewDispatchOtherPlanDetails/" + rowid);
                }
            };
            //查看发货计划详细信息
            this.viewDeliverPlanDetails = function (rowid) {
                var data = $("#grid2").jqGrid("getRowData", rowid);
                if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.PaperPlan %>" || data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverPaperPlan %>") {
                    location.replace("/chenxk/Plan/ViewPaperPlanDetails/" + rowid);
                }
                else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.CanPlan %>" || data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverCanPlan %>") {
                    location.replace("/chenxk/Plan/ViewCanPlanDetails/" + rowid);
                }
                else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NoodlePlan %>") {
                    location.replace("/chenxk/Plan/ViewNoodlePlanDetails/" + rowid);
                }
                else {
                    location.replace("/chenxk/Plan/ViewOtherPlanDetails/" + rowid);
                }
            };
            //调度计划
            this.dispatch = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 2010, strPermission: "AllowDispatch" }, function (ret) {
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
                        location.replace("/chenxk/Dispatch/DispatchPaperPlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverPaperPlan %>") {
                        location.replace("/chenxk/Dispatch/DispatchNotDeliverPaperPlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.CanPlan %>") {
                        location.replace("/chenxk/Dispatch/DispatchCanPlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverCanPlan %>") {
                        location.replace("/chenxk/Dispatch/DispatchNotDeliverCanPlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NoodlePlan %>") {
                        location.replace("/chenxk/Dispatch/DispatchNoodlePlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                    else {
                        location.replace("/chenxk/Dispatch/DispatchOtherPlan/" + objMain.objWorkspace.objContent.selectedPlanId);
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //取消计划
            this.cancel = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 2010, strPermission: "AllowCancel" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedPlanId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedPlan %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.CancelPlanConfirm %>") == true) {
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
                                location.replace("/chenxk/Dispatch/DispatchDeliverPlans/");
                            }
                        });
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //退回计划
            this.returnModify = function (rowid) {
                if (confirm("<%: InnoSoft.LS.Resources.Strings.ReturnModifyPlanConfirm %>") == true) {
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

                    $.post("/chenxk/Dispatch/ReturnDeliverPlan/", { id: rowid }, function (ret) {
                        $.unblockUI();

                        if (ret != null && ret != "") {
                            alert(ret);
                        }
                        else {
                            location.replace("/chenxk/Dispatch/DispatchDeliverPlans/");
                        }
                    });
                }
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //创建待调度计划表格
            $("#grid1").jqGrid({
                url: "/chenxk/Dispatch/LoadDispatchDeliverPlansGrid/",
                datatype: "json",
                mtype: "GET",
                postData: {
                    organId: $.jStorage.get("SearchDispatchPlanCondition_OrganId", ""),
                    customerName: $.jStorage.get("SearchDispatchPlanCondition_CustomerName", ""),
                    shipmentNo: $.jStorage.get("SearchDispatchPlanCondition_ShipmentNo", ""),
                    deliveryNo: $.jStorage.get("SearchDispatchPlanCondition_DeliveryNo", ""),
                    receiverName: $.jStorage.get("SearchDispatchPlanCondition_ReceiverName", ""),
                    destCountry: $.jStorage.get("SearchDispatchPlanCondition_DestCountry", ""),
                    destProvince: $.jStorage.get("SearchDispatchPlanCondition_DestProvince", ""),
                    destCity: $.jStorage.get("SearchDispatchPlanCondition_DestCity", ""),
                    warehouse: $.jStorage.get("SearchDispatchPlanCondition_Warehouse", ""),
                    arrivalTime: $.jStorage.get("SearchDispatchPlanCondition_ArrivalTime", ""),
                    carNo: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                    "<%: InnoSoft.LS.Resources.Labels.ArrivalTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.CreateTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiveType %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>",
                    "",
                    ""],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "PlanNo", index: "PlanNo", width: 100, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center", hidden: true },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                    { name: "Warehouse", index: "Warehouse", width: 80, align: "center", hidden: true },
                    { name: "ArrivalTime", index: "ArrivalTime", width: 80, align: "center" },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "BalanceTunnages", index: "BalanceTunnages", width: 100, align: "center" },
                    { name: "BalancePiles", index: "BalancePiles", width: 100, align: "center" },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "ReceiveType", index: "ReceiveType", width: 60, align: "center", hidden: true },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center", hidden: true },
                    { name: "Remark", index: "Remark", width: 300, hidden: true },
                    { name: "Actions", index: "Actions", width: 80, align: "center", sortable: false },
                    { name: "Actions2", index: "Actions2", width: 100, align: "center", sortable: false}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CreateTime",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    var ids = $("#grid1").jqGrid("getDataIDs");
                    for (var i = 0; i < ids.length; i++) {
                        var s = "<input style='height:22px;width:60px;' type='button' value='<%: InnoSoft.LS.Resources.Buttons.View %>' onclick='objMain.objWorkspace.objContent.viewDispatchDeliverPlanDetails(" + ids[i] + ");' />";
                        var s2 = "<input style='height:22px;width:80px;' type='button' value='<%: InnoSoft.LS.Resources.Buttons.ReturnModify %>' onclick='objMain.objWorkspace.objContent.returnModify(" + ids[i] + ");' />";
                        $("#grid1").jqGrid("setRowData", ids[i], { Actions: s, Actions2: s2 });
                    }
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedPlanId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建外地来货计划表格
            $("#grid2").jqGrid({
                url: "/chenxk/Dispatch/LoadForeignDeliverPlansGrid/",
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DriverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.MobileTel %>",
                    "<%: InnoSoft.LS.Resources.Labels.ArrivalTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.CreateTime %>",
                    ""],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "PlanNo", index: "PlanNo", width: 100, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center", hidden: true },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "StartCity", index: "StartCity", width: 60, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "DriverName", index: "DriverName", width: 100, align: "center" },
                    { name: "DriverMobileTel", index: "DriverMobileTel", width: 120, align: "center" },
                    { name: "ArrivalTime", index: "ArrivalTime", width: 80, align: "center" },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "TotalTunnages", index: "TotalTunnages", width: 100, align: "center" },
                    { name: "TotalPiles", index: "TotalPiles", width: 100, align: "center" },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center", hidden: true },
                    { name: "Actions", index: "Actions", width: 80, align: "center", sortable: false}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CreateTime",
                sortorder: "desc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    var ids = $("#grid2").jqGrid("getDataIDs");
                    for (var i = 0; i < ids.length; i++) {
                        var s = "<input style='height:22px;width:60px;' type='button' value='<%: InnoSoft.LS.Resources.Buttons.View %>' onclick='objMain.objWorkspace.objContent.viewDeliverPlanDetails(" + ids[i] + ");' />";
                        $("#grid2").jqGrid("setRowData", ids[i], { Actions: s });
                    }
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 450,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        //缓存查询条件
                        $.jStorage.set("SearchDispatchPlanCondition_OrganId", $("#formSearchDispatchDeliverPlanCondition #OrganId").val().trim());
                        $.jStorage.set("SearchDispatchPlanCondition_CustomerName", $("#formSearchDispatchDeliverPlanCondition #CustomerName").val().trim());
                        $.jStorage.set("SearchDispatchPlanCondition_ShipmentNo", $("#formSearchDispatchDeliverPlanCondition #ShipmentNo").val().trim());
                        $.jStorage.set("SearchDispatchPlanCondition_DeliveryNo", $("#formSearchDispatchDeliverPlanCondition #DeliveryNo").val().trim());
                        $.jStorage.set("SearchDispatchPlanCondition_ReceiverName", $("#formSearchDispatchDeliverPlanCondition #ReceiverName").val().trim());
                        $.jStorage.set("SearchDispatchPlanCondition_DestCountry", $("#formSearchDispatchDeliverPlanCondition #DestCountry").val().trim());
                        $.jStorage.set("SearchDispatchPlanCondition_DestProvince", $("#formSearchDispatchDeliverPlanCondition #DestProvince").val().trim());
                        $.jStorage.set("SearchDispatchPlanCondition_DestCity", $("#formSearchDispatchDeliverPlanCondition #DestCity").val().trim());
                        $.jStorage.set("SearchDispatchPlanCondition_Warehouse", $("#formSearchDispatchDeliverPlanCondition #Warehouse").val().trim());
                        $.jStorage.set("SearchDispatchPlanCondition_ArrivalTime", $("#formSearchDispatchDeliverPlanCondition #ArrivalTime").val().trim());

                        //设置表格参数
                        $("#grid1").jqGrid("setGridParam", {
                            postData: {
                                organId: $("#formSearchDispatchDeliverPlanCondition #OrganId").val().trim(),
                                customerName: $("#formSearchDispatchDeliverPlanCondition #CustomerName").val().trim(),
                                shipmentNo: $("#formSearchDispatchDeliverPlanCondition #ShipmentNo").val().trim(),
                                deliveryNo: $("#formSearchDispatchDeliverPlanCondition #DeliveryNo").val().trim(),
                                receiverName: $("#formSearchDispatchDeliverPlanCondition #ReceiverName").val().trim(),
                                destCountry: $("#formSearchDispatchDeliverPlanCondition #DestCountry").val().trim(),
                                destProvince: $("#formSearchDispatchDeliverPlanCondition #DestProvince").val().trim(),
                                destCity: $("#formSearchDispatchDeliverPlanCondition #DestCity").val().trim(),
                                warehouse: $("#formSearchDispatchDeliverPlanCondition #Warehouse").val().trim(),
                                arrivalTime: $("#formSearchDispatchDeliverPlanCondition #ArrivalTime").val().trim()
                            }
                        });

                        //重新加载表格
                        $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                        $(this).dialog("close");

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
