<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SetCarrier %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.searchCarrier();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/System/NewCarrier" onclick="javascript:objMain.objWorkspace.objContent.newCarrier(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.New%></a></li>
        <li><a href="/chenxk/System/ModifyCarrier/" onclick="javascript:objMain.objWorkspace.objContent.modifyCarrier(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/chenxk/System/DeleteCarrier/" onclick="javascript:objMain.objWorkspace.objContent.deleteCarrier(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete%></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <div id="tabs">
        <ul>
            <li><a href="#tabCars">
                <%: InnoSoft.LS.Resources.Tabs.CarList %></a></li>
            <li><a href="#tabDrivers">
                <%: InnoSoft.LS.Resources.Tabs.DriverList %></a></li>
            <li><a href="#tabSettlementExpressions">
                <%: InnoSoft.LS.Resources.Tabs.SettlementExpressionList %></a></li>
            <li><a href="#tabPrices">
                <%: InnoSoft.LS.Resources.Tabs.TransportPriceList %></a></li>
        </ul>
        <div id="tabCars">
            <div>
                <table id="grid2">
                </table>
                <div id="pager2">
                </div>
            </div>
        </div>
        <div id="tabDrivers">
            <div>
                <table id="grid3">
                </table>
                <div id="pager3">
                </div>
            </div>
        </div>
        <div id="tabSettlementExpressions">
            <div>
                <table id="grid4">
                </table>
                <div id="pager4">
                </div>
            </div>
        </div>
        <div id="tabPrices">
            <div>
                <table id="grid5">
                </table>
                <div id="pager5">
                </div>
            </div>
        </div>
    </div>
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("SearchCarrierCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中承运单位编码
            this.selectedCarrierId = null;
            //表格1完成标志
            this.grid1Complete = false;
            //表格2完成标志
            this.grid2Complete = false;
            //表格3完成标志
            this.grid3Complete = false;
            //表格4完成标志
            this.grid4Complete = false;
            //表格5完成标志
            this.grid5Complete = false;
            //自动选择定时器
            this.timerId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                var h1 = $("#divWorkspaceContent").height() / 2;

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", h1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);

                var h2 = $("#divWorkspaceContent").height() - h1;

                $("#tabs").css("height", (h2 - parseInt($("#tabs").css("border-top-width")) - parseInt($("#tabs").css("margin-top")) - parseInt($("#tabs").css("padding-top")) - parseInt($("#tabs").css("padding-bottom")) - parseInt($("#tabs").css("margin-bottom")) - parseInt($("#tabs").css("border-bottom-width"))) + "px");

                var w3 = parseInt($(".ui-tabs .ui-tabs-panel").css("width"));
                if (w3 == 0) {
                    w3 = $("#divWorkspaceContent").width() - parseInt($("#tabs").css("border-left-width")) - parseInt($("#tabs").css("margin-left")) - parseInt($("#tabs").css("padding-left")) - parseInt($(".ui-tabs .ui-tabs-nav").css("padding-left")) - parseInt($(".ui-tabs .ui-tabs-nav").css("padding-right")) - parseInt($("#tabs").css("padding-right")) - parseInt($("#tabs").css("margin-right")) - parseInt($("#tabs").css("border-right-width"));
                }
                var h3 = parseInt($("#tabs").css("height")) - parseInt($(".ui-tabs .ui-tabs-nav").css("border-top-width")) - parseInt($(".ui-tabs .ui-tabs-nav").css("padding-top")) - parseInt($(".ui-tabs .ui-tabs-nav").css("height")) - parseInt($(".ui-tabs .ui-tabs-nav").css("padding-bottom")) - parseInt($(".ui-tabs .ui-tabs-nav").css("border-bottom-width")) - parseInt($(".ui-tabs .ui-tabs-panel").css("padding-top")) - parseInt($(".ui-tabs .ui-tabs-panel").css("padding-bottom"));

                $("#grid2").jqGrid("setGridWidth", w3);
                $("#grid2").jqGrid("setGridHeight", h3 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);

                $("#grid3").jqGrid("setGridWidth", w3);
                $("#grid3").jqGrid("setGridHeight", h3 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);

                $("#grid4").jqGrid("setGridWidth", w3);
                $("#grid4").jqGrid("setGridHeight", h3 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);

                $("#grid5").jqGrid("setGridWidth", w3);
                $("#grid5").jqGrid("setGridHeight", h3 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询承运单位
            this.searchCarrier = function () {
                //初始化控件数据
                $("#formSearchCarrierCondition #CarrierName").val("");
                $("#formSearchCarrierCondition #CarNo").val("");

                //打开条件输入对话框
                $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                $("#dialogCondition").dialog("open");
            };
            //新增承运单位
            this.newCarrier = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9130, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace(action);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //修改承运单位
            this.modifyCarrier = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9130, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedCarrierId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarrier %>");
                        return;
                    }

                    location.replace(action + objMain.objWorkspace.objContent.selectedCarrierId);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除承运单位
            this.deleteCarrier = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9130, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedCarrierId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarrier %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteCarrierConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedCarrierId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                objMain.objWorkspace.objContent.grid1Complete = false;
                                $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                                objMain.objWorkspace.objContent.grid2Complete = false;
                                $("#grid2").trigger("reloadGrid", [{ page: 1}]);

                                objMain.objWorkspace.objContent.grid3Complete = false;
                                $("#grid3").trigger("reloadGrid", [{ page: 1}]);

                                objMain.objWorkspace.objContent.grid4Complete = false;
                                $("#grid4").trigger("reloadGrid", [{ page: 1}]);

                                objMain.objWorkspace.objContent.grid5Complete = false;
                                $("#grid5").trigger("reloadGrid", [{ page: 1}]);

                                objMain.objWorkspace.objContent.timerId = setInterval("selectCarrier();", 500);
                                objMain.objWorkspace.objContent.selectedCarrierId = null;
                            }
                        });
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //创建TAB控件
            $("#tabs").tabs();

            //创建承运单位表格
            $("#grid1").jqGrid({
                url: "/chenxk/System/LoadCarrierGrid/",
                datatype: "json",
                mtype: "GET",
                postData: {
                    carrierName: "",
                    carNo: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.CarrierId %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarrierName %>",
                    "<%: InnoSoft.LS.Resources.Labels.BusinessType %>",
                    "<%: InnoSoft.LS.Resources.Labels.PaymentType %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "Name", index: "Name", width: 200 },
                    { name: "BusinessType", index: "BusinessType", width: 100, align: "center" },
                    { name: "PaymentType", index: "PaymentType", width: 100, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "Id",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid1Complete = true;
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedCarrierId = rowid;
                    //加载当前选中承运单位的车辆数据
                    $("#grid2").jqGrid("setGridParam", { url: "/chenxk/System/LoadCarrierCarGrid/" + rowid });
                    $("#grid2").trigger("reloadGrid", [{ page: 1}]);
                    //加载当前选中承运单位的驾驶员数据
                    $("#grid3").jqGrid("setGridParam", { url: "/chenxk/System/LoadCarrierDriverGrid/" + rowid });
                    $("#grid3").trigger("reloadGrid", [{ page: 1}]);
                    //加载当前选中承运单位的结算公式数据
                    $("#grid4").jqGrid("setGridParam", { url: "/chenxk/System/LoadCarrierSettlementExpressionGrid/" + rowid });
                    $("#grid4").trigger("reloadGrid", [{ page: 1}]);
                    //加载当前选中承运单位的运费价格数据
                    $("#grid5").jqGrid("setGridParam", { url: "/chenxk/System/LoadCarrierTransportPriceGrid/" + rowid });
                    $("#grid5").trigger("reloadGrid", [{ page: 1}]);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建承运单位车辆表格
            $("#grid2").jqGrid({
                url: "/chenxk/System/LoadCarrierCarGrid/0",
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarryingCapacity %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "CarNo", index: "CarNo", width: 100, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 100, align: "center" },
                    { name: "CarryingCapacity", index: "CarryingCapacity", width: 100, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "Id",
                sortorder: "asc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid2Complete = true;
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

            //创建承运单位驾驶员表格
            $("#grid3").jqGrid({
                url: "/chenxk/System/LoadCarrierDriverGrid/0",
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.DriverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.LicenseNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.MobileTel %>",
                    "<%: InnoSoft.LS.Resources.Labels.HomeTel %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "Name", index: "Name", width: 100, align: "center" },
                    { name: "LicenseNo", index: "LicenseNo", width: 200, align: "center" },
                    { name: "MobileTel", index: "MobileTel", width: 120, align: "center" },
                    { name: "HomeTel", index: "HomeTel", width: 120, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 400}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "Id",
                sortorder: "asc",
                pager: "#pager3",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid3Complete = true;
                }
            });
            $("#grid3").jqGrid("navGrid", "#pager3", { edit: false, add: false, del: false, search: false });

            //创建承运单位结算公式表格
            $("#grid4").jqGrid({
                url: "/chenxk/System/LoadCarrierSettlementExpressionGrid/0",
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportChargeExpression %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPriceExpression %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "TransportChargeExpression", index: "TransportChargeExpression", width: 150, align: "center" },
                    { name: "TransportPriceExpression", index: "TransportPriceExpression", width: 150, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "Id",
                sortorder: "asc",
                pager: "#pager4",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid4Complete = true;
                }
            });
            $("#grid4").jqGrid("navGrid", "#pager4", { edit: false, add: false, del: false, search: false });

            //创建承运单位运费价格表格
            $("#grid5").jqGrid({
                url: "/chenxk/System/LoadCarrierTransportPriceGrid/0",
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartCountry %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartProvince %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartCity %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestCountry %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestProvince %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestCity %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.EndTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "StartCountry", index: "StartCountry", width: 80 },
                    { name: "StartProvince", index: "StartProvince", width: 150 },
                    { name: "StartCity", index: "StartCity", width: 100 },
                    { name: "DestCountry", index: "StartCountry", width: 80 },
                    { name: "DestProvince", index: "StartProvince", width: 150 },
                    { name: "DestCity", index: "StartCity", width: 100 },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "StartTime", index: "StartTime", width: 80 },
                    { name: "EndTime", index: "EndTime", width: 80 },
                    { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "Id",
                sortorder: "asc",
                pager: "#pager5",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid5Complete = true;
                }
            });
            $("#grid5").jqGrid("navGrid", "#pager5", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 200,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearchCarrierCondition").valid()) {
                            $(this).dialog("close");

                            objMain.objWorkspace.objContent.selectedCarrierId = null;
                            objMain.objWorkspace.objContent.grid1Complete = false;
                            objMain.objWorkspace.objContent.grid2Complete = false;
                            objMain.objWorkspace.objContent.grid3Complete = false;
                            objMain.objWorkspace.objContent.grid4Complete = false;
                            objMain.objWorkspace.objContent.grid5Complete = false;

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                postData: {
                                    carrierName: $("#formSearchCarrierCondition #CarrierName").val().trim(),
                                    carNo: $("#formSearchCarrierCondition #CarNo").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                            //清除承运单位的车辆数据
                            $("#grid2").jqGrid("clearGridData");

                            //清除承运单位的驾驶员数据
                            $("#grid3").jqGrid("clearGridData");

                            //清除承运单位的结算公式数据
                            $("#grid4").jqGrid("clearGridData");

                            //清除承运单位的运费价格数据
                            $("#grid5").jqGrid("clearGridData");

                            //重新选中第一个承运单位
                            objMain.objWorkspace.objContent.timerId = setInterval("selectCarrier();", 500);
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });
        });

        //默认选中第一个承运单位
        objMain.objWorkspace.objContent.timerId = setInterval("selectCarrier();", 500);
        function selectCarrier() {
            if (objMain.objWorkspace.objContent.grid1Complete &&
                objMain.objWorkspace.objContent.grid2Complete &&
                objMain.objWorkspace.objContent.grid3Complete &&
                objMain.objWorkspace.objContent.grid4Complete &&
                objMain.objWorkspace.objContent.grid5Complete) {

                clearInterval(objMain.objWorkspace.objContent.timerId);

                if ($("#grid1").jqGrid("getGridParam", "records") > 0) {
                    var rowid = $("#grid1").jqGrid("getRowData")[0].Id;
                    $("#grid1").jqGrid("setSelection", rowid, true);
                }
            }
        }

    </script>
</asp:Content>
