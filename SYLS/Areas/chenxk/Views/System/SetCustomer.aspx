<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SetCustomer %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.searchCustomer();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/System/NewCustomer" onclick="javascript:objMain.objWorkspace.objContent.newCustomer(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.New%></a></li>
        <li><a href="/chenxk/System/ModifyCustomer/" onclick="javascript:objMain.objWorkspace.objContent.modifyCustomer(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/chenxk/System/DeleteCustomer/" onclick="javascript:objMain.objWorkspace.objContent.deleteCustomer(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete%></a></li>
        <li style="visibility: hidden;"><a href="/chenxk/System/ImportCustomers/" onclick="javascript:objMain.objWorkspace.objContent.importCustomers(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/050.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Import%></a></li>
        <li style="visibility: hidden;"><a href="/chenxk/System/ExportCustomers/" onclick="javascript:objMain.objWorkspace.objContent.exportCustomers(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/049.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Export%></a></li>
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
            <li><a href="#tabTransportPrices">
                <%: InnoSoft.LS.Resources.Tabs.SettlementPriceList %></a></li>
            <li><a href="#tabForceFeePrices">
                <%: InnoSoft.LS.Resources.Tabs.ForceFeePriceList%></a></li>
            <li><a href="#tabStorageFeePrices">
                <%: InnoSoft.LS.Resources.Tabs.StorageFeePriceList%></a></li>
        </ul>
        <div id="tabTransportPrices">
            <div>
                <table id="grid2">
                </table>
                <div id="pager2">
                </div>
            </div>
        </div>
        <div id="tabForceFeePrices">
            <div>
                <table id="grid3">
                </table>
                <div id="pager3">
                </div>
            </div>
        </div>
        <div id="tabStorageFeePrices">
            <div>
                <table id="grid4">
                </table>
                <div id="pager4">
                </div>
            </div>
        </div>
    </div>
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("SearchCustomerCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中客户编码
            this.selectedCustomerId = null;
            //表格1完成标志
            this.grid1Complete = false;
            //表格2完成标志
            this.grid2Complete = false;
            //表格3完成标志
            this.grid3Complete = false;
            //表格4完成标志
            this.grid4Complete = false;
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
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询客户
            this.searchCustomer = function () {
                //初始化控件数据
                $("#formSearchCustomerCondition #CustomerName").val("");

                //打开条件输入对话框
                $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                $("#dialogCondition").dialog("open");
            };
            //新增客户
            this.newCustomer = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9040, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace(action);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //修改客户
            this.modifyCustomer = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9040, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedCustomerId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCustomer %>");
                        return;
                    }

                    location.replace(action + objMain.objWorkspace.objContent.selectedCustomerId);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除客户
            this.deleteCustomer = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9040, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedCustomerId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCustomer %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteCustomerConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedCustomerId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                objMain.objWorkspace.objContent.grid1Complete = false;
                                $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                                objMain.objWorkspace.objContent.grid2Complete = false;
                                $("#grid2").trigger("reloadGrid", [{ page: 1}]);

                                objMain.objWorkspace.objContent.timerId = setInterval("selectCustomer();", 500);
                                objMain.objWorkspace.objContent.selectedCustomerId = null;
                            }
                        });
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //导入客户
            this.importCustomers = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9040, strPermission: "AllowImport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace(action);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //导出客户
            this.exportCustomers = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9040, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace(action);
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

            //创建客户表格
            $("#grid1").jqGrid({
                url: "/chenxk/System/LoadCustomersGrid/",
                datatype: "json",
                mtype: "GET",
                postData: {
                    customerName: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.CustomerId %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerFullName %>",
                    "<%: InnoSoft.LS.Resources.Labels.WarningStock %>",
                    "<%: InnoSoft.LS.Resources.Labels.StopStock %>",
                    "<%: InnoSoft.LS.Resources.Labels.SettlementExpression %>",
                    "<%: InnoSoft.LS.Resources.Labels.ValuationMode %>",
                    "<%: InnoSoft.LS.Resources.Labels.GrossWeightRate %>",
                    "<%: InnoSoft.LS.Resources.Labels.OwnOrganName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "Name", index: "Name", width: 200 },
                    { name: "FullName", index: "FullName", width: 200 },
                    { name: "WarningStock", index: "WarningStock", width: 100, align: "center" },
                    { name: "StopStock", index: "StopStock", width: 100, align: "center" },
                    { name: "SettlementExpression", index: "SettlementExpression", width: 150, align: "center" },
                    { name: "ValuationMode", index: "ValuationMode", width: 150, align: "center" },
                    { name: "GrossWeightRate", index: "GrossWeightRate", width: 100, align: "center" },
                    { name: "OwnOrganName", index: "OwnOrganName", width: 150, align: "center" },
                    { name: "Remark", index: "Remark", width: 400}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "Name",
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
                    objMain.objWorkspace.objContent.selectedCustomerId = rowid;

                    //加载当前选中客户的结算价格数据
                    $("#grid2").jqGrid("setGridParam", { url: "/chenxk/System/LoadCustomerTransportPriceGrid/" + rowid });
                    $("#grid2").trigger("reloadGrid", [{ page: 1}]);

                    //加载当前选中客户的力支费价格数据
                    $("#grid3").jqGrid("setGridParam", { url: "/chenxk/System/LoadCustomerForceFeePriceGrid/" + rowid });
                    $("#grid3").trigger("reloadGrid", [{ page: 1}]);

                    //加载当前选中客户的仓储费价格数据
                    $("#grid4").jqGrid("setGridParam", { url: "/chenxk/System/LoadCustomerStorageFeePriceGrid/" + rowid });
                    $("#grid4").trigger("reloadGrid", [{ page: 1}]);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建客户结算价格表格
            $("#grid2").jqGrid({
                url: "/chenxk/System/LoadCustomerTransportPriceGrid/0",
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
                    "<%: InnoSoft.LS.Resources.Labels.MinTunnagesOrPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.MaxTunnagesOrPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.EndTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarType %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.RiverCrossingCharges %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "StartCountry", index: "StartCountry", width: 80, align: "center" },
                    { name: "StartProvince", index: "StartProvince", width: 150, align: "center" },
                    { name: "StartCity", index: "StartCity", width: 100, align: "center" },
                    { name: "DestCountry", index: "StartCountry", width: 80, align: "center" },
                    { name: "DestProvince", index: "StartProvince", width: 150, align: "center" },
                    { name: "DestCity", index: "StartCity", width: 100, align: "center" },
                    { name: "MinTunnagesOrPiles", index: "MinTunnagesOrPiles", width: 100, align: "center" },
                    { name: "MaxTunnagesOrPiles", index: "MaxTunnagesOrPiles", width: 100, align: "center" },
                    { name: "StartTime", index: "StartTime", width: 80 },
                    { name: "EndTime", index: "EndTime", width: 80 },
                    { name: "CarType", index: "CarType", width: 60, align: "center" },
                    { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right" },
                    { name: "RiverCrossingCharges", index: "RiverCrossingCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","}}],
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

            //创建客户力支费价格表格
            $("#grid3").jqGrid({
                url: "/chenxk/System/LoadCustomerForceFeePriceGrid/0",
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.EndTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.LoadingForceFeePrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.UnloadingForceFeePrice %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "StartTime", index: "StartTime", width: 80 },
                    { name: "EndTime", index: "EndTime", width: 80 },
                    { name: "LoadingForceFeePrice", index: "LoadingForceFeePrice", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "UnloadingForceFeePrice", index: "UnloadingForceFeePrice", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","}}],
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

            //创建客户仓储费价格表格
            $("#grid4").jqGrid({
                url: "/chenxk/System/LoadCustomerStorageFeePriceGrid/0",
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.EndTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.StorageFeePrice %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "StartTime", index: "StartTime", width: 80 },
                    { name: "EndTime", index: "EndTime", width: 80 },
                    { name: "StorageFeePrice", index: "StorageFeePrice", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","}}],
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

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 150,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearchCustomerCondition").valid()) {
                            $(this).dialog("close");

                            objMain.objWorkspace.objContent.selectedCustomerId = null;
                            objMain.objWorkspace.objContent.grid1Complete = false;
                            objMain.objWorkspace.objContent.grid2Complete = false;

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                postData: {
                                    customerName: $("#formSearchCustomerCondition #CustomerName").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                            //清除客户的结算价格数据
                            $("#grid2").jqGrid("clearGridData");

                            //清除客户的力支费价格数据
                            $("#grid3").jqGrid("clearGridData");

                            //清除客户的仓储费价格数据
                            $("#grid4").jqGrid("clearGridData");

                            //重新选中第一个承运单位
                            objMain.objWorkspace.objContent.timerId = setInterval("selectCustomer();", 500);
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

        //默认选中第一个客户
        objMain.objWorkspace.objContent.timerId = setInterval("selectCustomer();", 500);
        function selectCustomer() {
            if (objMain.objWorkspace.objContent.grid1Complete &&
                objMain.objWorkspace.objContent.grid2Complete &&
                objMain.objWorkspace.objContent.grid3Complete &&
                objMain.objWorkspace.objContent.grid4Complete) {
                clearInterval(objMain.objWorkspace.objContent.timerId);

                if ($("#grid1").jqGrid("getGridParam", "records") > 0) {
                    var rowid = $("#grid1").jqGrid("getRowData")[0].Id;
                    $("#grid1").jqGrid("setSelection", rowid, true);
                }
            }
        }

    </script>
</asp:Content>
