<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchCustomerTransportChargesSettlements%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Settlement/DeleteCustomerTransportChargesSettlement/" onclick="javascript:objMain.objWorkspace.objContent.deleteCustomerTransportChargesSettlement(this.href);return false;">
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
    <div id="Grid2" style="margin-top: 1px;">
        <table id="grid2">
        </table>
        <div id="pager2">
        </div>
    </div>
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("SearchCustomerTransportChargesSettlementsCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中发票编码
            this.selectedCustomerTransportChargesSettlementId = null;
            //表格1完成标志
            this.grid1Complete = false;
            //表格2完成标志
            this.grid2Complete = false;
            //自动选择定时器
            this.timerId = null;
            //调整布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                var h1 = $("#divWorkspaceContent").height() / 2;
                var h2 = $("#divWorkspaceContent").height() - h1;

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", h1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);

                $("#grid2").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid2").jqGrid("setGridHeight", h2 - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) + 1) - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")) - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) + 1) - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询发票
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 6030, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    $("#formSearchCustomerTransportChargesSettlementCondition #StartTime").val("");
                    $("#formSearchCustomerTransportChargesSettlementCondition #EndTime").val("");
                    $("#formSearchCustomerTransportChargesSettlementCondition #InvoiceNo").val("");
                    $("#formSearchCustomerTransportChargesSettlementCondition #DeliverBillNo").val("");
                    $("#formSearchCustomerTransportChargesSettlementCondition #CustomerName").val("");

                    //打开查询条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除发票
            this.deleteCustomerTransportChargesSettlement = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 6030, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedCustomerTransportChargesSettlementId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCustomerTransportChargesSettlement %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteCustomerTransportChargesSettlementConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedCustomerTransportChargesSettlementId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                location.replace("/chenxk/Settlement/SearchCustomerTransportChargesSettlements/");
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
            //创建发票表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    invoiceNo: "",
                    deliverBillNo: "",
                    customerName: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.InvoiceTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.InvoiceNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.InvoiceType %>",
                    "<%: InnoSoft.LS.Resources.Labels.InvoiceAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "InvoiceNo", index: "InvoiceNo", width: 120, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "InvoiceType", index: "InvoiceType", width: 80, align: "center" },
                    { name: "InvoiceAmount", index: "InvoiceAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "Remark", index: "Remark", width: 400, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CreateTime",
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
                    objMain.objWorkspace.objContent.selectedCustomerTransportChargesSettlementId = rowid;

                    //加载当前选中发票的明细数据
                    $("#grid2").jqGrid("setGridParam", {
                        url: "/chenxk/Settlement/LoadCustomerTransportChargesSettlementDetailsGrid/",
                        postData: {
                            customerTransportChargesSettlementId: objMain.objWorkspace.objContent.selectedCustomerTransportChargesSettlementId
                        }
                    });
                    $("#grid2").trigger("reloadGrid", [{ page: 1}]);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建发票明细表格
            $("#grid2").jqGrid({
                url: "/chenxk/Settlement/LoadCustomerTransportChargesSettlementDetailsGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { customerTransportChargesSettlementId: "0" },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.PayerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverAddress %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarpoolFee %>",
                    "<%: InnoSoft.LS.Resources.Labels.RiverCrossingCharges %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "DeliverBillNo", index: "DeliverBillNo", width: 100, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "ReceiverAddress", index: "ReceiverAddress", width: 300 },
                    { name: "StartCity", index: "StartCity", width: 60, align: "center" },
                    { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center", summaryType: "sum" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "Piles", index: "Piles", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right" },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "CarpoolFee", index: "CarpoolFee", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "RiverCrossingCharges", index: "RiverCrossingCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "DeliverBillNo",
                sortorder: "asc",
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
                    objMain.objWorkspace.objContent.grid2Complete = true;
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

            //创建查询条件录入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 300,
                width: 520,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearchCustomerTransportChargesSettlementCondition").valid()) {
                            $(this).dialog("close");

                            objMain.objWorkspace.objContent.selectedCustomerTransportChargesSettlementId = null;
                            objMain.objWorkspace.objContent.grid1Complete = false;
                            objMain.objWorkspace.objContent.grid2Complete = false;

                            //重新加载发票表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Settlement/LoadSearchCustomerTransportChargesSettlementsGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearchCustomerTransportChargesSettlementCondition #StartTime").val().trim(),
                                    endTime: $("#formSearchCustomerTransportChargesSettlementCondition #EndTime").val().trim(),
                                    invoiceNo: $("#formSearchCustomerTransportChargesSettlementCondition #InvoiceNo").val().trim(),
                                    deliverBillNo: $("#formSearchCustomerTransportChargesSettlementCondition #DeliverBillNo").val().trim(),
                                    customerName: $("#formSearchCustomerTransportChargesSettlementCondition #CustomerName").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                            //重新加载发票明细表格
                            $("#grid2").jqGrid("setGridParam", {
                                postData: { customerTransportChargesSettlementId: "0" }
                            });
                            $("#grid2").trigger("reloadGrid", [{ page: 1}]);

                            //重新选中第一个发票
                            objMain.objWorkspace.objContent.timerId = setInterval("selectCustomerTransportChargesSettlement();", 500);
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

        //默认选中第一个发票
        objMain.objWorkspace.objContent.timerId = setInterval("selectCustomerTransportChargesSettlement();", 500);
        function selectCustomerTransportChargesSettlement() {
            if (objMain.objWorkspace.objContent.grid1Complete && objMain.objWorkspace.objContent.grid2Complete) {
                clearInterval(objMain.objWorkspace.objContent.timerId);

                if ($("#grid1").jqGrid("getGridParam", "records") > 0) {
                    var rowid = $("#grid1").jqGrid("getRowData")[0].Id;
                    $("#grid1").jqGrid("setSelection", rowid, true);
                }
            }
        }

    </script>
</asp:Content>
