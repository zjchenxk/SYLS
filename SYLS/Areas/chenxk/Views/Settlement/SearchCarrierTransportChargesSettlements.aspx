<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchCarrierTransportChargesSettlements%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Settlement/DeleteCarrierTransportChargesSettlement/" onclick="javascript:objMain.objWorkspace.objContent.deleteCarrierTransportChargesSettlement(this.href);return false;">
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
        <% Html.RenderPartial("SearchCarrierTransportChargesSettlementsCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中结算记录编码
            this.selectedCarrierTransportChargesSettlementId = null;
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
            //查询结算记录
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 6040, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    $("#formSearchCarrierTransportChargesSettlementsCondition #StartTime").val("");
                    $("#formSearchCarrierTransportChargesSettlementsCondition #EndTime").val("");
                    $("#formSearchCarrierTransportChargesSettlementsCondition #CarrierName").val("");
                    $("#formSearchCarrierTransportChargesSettlementsCondition #CarNo").val("");
                    $("#formSearchCarrierTransportChargesSettlementsCondition #DeliverBillNo").val("");

                    //打开查询条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除结算记录
            this.deleteCarrierTransportChargesSettlement = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 6040, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedCarrierTransportChargesSettlementId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarrierTransportChargesSettlement %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteCarrierTransportChargesSettlementConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedCarrierTransportChargesSettlementId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                location.replace("/chenxk/Settlement/SearchCarrierTransportChargesSettlements/");
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
            //创建结算记录表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    carrierName: "",
                    carNo: "",
                    deliverBillNo: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.SettlementTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarrierName %>",
                    "<%: InnoSoft.LS.Resources.Labels.SettlementAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.WithholdAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.FactpaymentAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "CarrierName", index: "CarrierName", width: 150 },
                    { name: "SettlementAmount", index: "SettlementAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "WithholdAmount", index: "WithholdAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "FactpaymentAmount", index: "FactpaymentAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "Remark", index: "Remark", width: 400}],
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
                    objMain.objWorkspace.objContent.selectedCarrierTransportChargesSettlementId = rowid;

                    //加载当前选中结算记录的明细数据
                    $("#grid2").jqGrid("setGridParam", {
                        url: "/chenxk/Settlement/LoadCarrierTransportChargesSettlementDetailsGrid/",
                        postData: {
                            carrierTransportChargesSettlementId: objMain.objWorkspace.objContent.selectedCarrierTransportChargesSettlementId
                        }
                    });
                    $("#grid2").trigger("reloadGrid", [{ page: 1}]);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建结算明细表格
            $("#grid2").jqGrid({
                url: "/chenxk/Settlement/LoadCarrierTransportChargesSettlementDetailsGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { carrierTransportChargesSettlementId: "0" },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarrierName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.DamageInfo %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CarrierName", index: "CarrierName", width: 150 },
                    { name: "DeliverBillNo", index: "DeliverBillNo", width: 100, align: "center" },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "StartCity", index: "StartCity", width: 60, align: "center" },
                    { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center", summaryType: "sum" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "Piles", index: "Piles", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "DamageInfo", index: "DamageInfo", width: 400}],
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
                        if ($("#formSearchCarrierTransportChargesSettlementsCondition").valid()) {
                            $(this).dialog("close");

                            objMain.objWorkspace.objContent.selectedCarrierTransportChargesSettlementId = null;
                            objMain.objWorkspace.objContent.grid1Complete = false;
                            objMain.objWorkspace.objContent.grid2Complete = false;

                            //重新加载结算记录表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Settlement/LoadSearchCarrierTransportChargesSettlementsGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearchCarrierTransportChargesSettlementsCondition #StartTime").val().trim(),
                                    endTime: $("#formSearchCarrierTransportChargesSettlementsCondition #EndTime").val().trim(),
                                    carrierName: $("#formSearchCarrierTransportChargesSettlementsCondition #CarrierName").val().trim(),
                                    carNo: $("#formSearchCarrierTransportChargesSettlementsCondition #CarNo").val().trim(),
                                    deliverBillNo: $("#formSearchCarrierTransportChargesSettlementsCondition #DeliverBillNo").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                            //重新加载结算记录明细表格
                            $("#grid2").jqGrid("setGridParam", {
                                postData: { carrierTransportChargesSettlementId: "0" }
                            });
                            $("#grid2").trigger("reloadGrid", [{ page: 1}]);

                            //重新选中第一个结算记录
                            objMain.objWorkspace.objContent.timerId = setInterval("selectCarrierTransportChargesSettlement();", 500);
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

        //默认选中第一个结算记录
        objMain.objWorkspace.objContent.timerId = setInterval("selectCarrierTransportChargesSettlement();", 500);
        function selectCarrierTransportChargesSettlement() {
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
