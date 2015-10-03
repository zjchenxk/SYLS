<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.StatCustomerTotalOutput %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Statistics/ExportCustomerTotalOutput/" onclick="javascript:objMain.objWorkspace.objContent.export(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/049.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Export %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <table id="caption" border="0" cellpadding="0" cellspacing="0" width="100%" style="height: 50px;
        background-color: #e8eef4;">
        <tr>
            <td id="tdTimeSpan" style="width: 34%; padding-left: 5px;">
                <%: InnoSoft.LS.Resources.Labels.TimeSpan %>
            </td>
            <td id="tdTotalTunnages" style="width: 33%; padding-left: 5px;">
                <%: InnoSoft.LS.Resources.Labels.TotalTunnages %>
            </td>
            <td id="tdTotalPiles" style="width: 33%; padding-left: 5px;">
                <%: InnoSoft.LS.Resources.Labels.TotalPiles %>
            </td>
        </tr>
        <tr>
            <td id="tdTotalTransportCharges" style="padding-left: 5px;">
                <%: InnoSoft.LS.Resources.Labels.TotalTransportCharges %>
            </td>
            <td id="tdTotalTransportChargesDifference" style="padding-left: 5px;">
                <%: InnoSoft.LS.Resources.Labels.TotalTransportChargesDifference %>
            </td>
            <td id="tdTotalGrossProfitRate" style="padding-left: 5px;">
                <%: InnoSoft.LS.Resources.Labels.TotalGrossProfitRate %>
            </td>
        </tr>
    </table>
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <div id="dialogCondition" title="" style="">
        <% Html.RenderPartial("StatCustomerTotalOutputCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            this.joinInTransportCharges = 0;
            this.selfSupportTransportCharges = 0;
            this.prestowageTransportCharges = 0;
            this.subtotalTransportCharges = 0;
            this.joinInTransportChargesDifference = 0;
            this.selfSupportTransportChargesDifference = 0;
            this.prestowageTransportChargesDifference = 0;
            this.subtotalTransportChargesDifference = 0;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - $("#caption").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-hdiv").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询条件
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 7020, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formStatCustomerTotalOutputCondition #StartTime").val($.jStorage.get("StatCustomerTotalOutputCondition_StartTime", ""));
                    $("#formStatCustomerTotalOutputCondition #EndTime").val($.jStorage.get("StatCustomerTotalOutputCondition_EndTime", ""));
                    $("#formStatCustomerTotalOutputCondition #CustomerName").val($.jStorage.get("StatCustomerTotalOutputCondition_CustomerName", ""));

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //导出数据
            this.export = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 7020, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#grid1").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.ExportMustAfterSearch %>");
                        return;
                    }
                    else {
                        if ($("#formStatCustomerTotalOutputCondition #StartTime").val().trim() == "" && $("#formStatCustomerTotalOutputCondition #EndTime").val().trim() == "") {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterStartTimeAndEndTimeCondition %>");
                            return;
                        }
                    }

                    var url = action + "?" +
                    "startTime=" + $("#formStatCustomerTotalOutputCondition #StartTime").val().trim() + "&" +
                    "endTime=" + $("#formStatCustomerTotalOutputCondition #EndTime").val().trim() + "&" +
                    "customerName=" + $("#formStatCustomerTotalOutputCondition #CustomerName").val().trim();

                    location.replace(url);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //创建统计表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    customerName: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.StateName %>",
                    "<%: InnoSoft.LS.Resources.Labels.JoinIn %>",
                    "<%: InnoSoft.LS.Resources.Labels.SelfSupport %>",
                    "<%: InnoSoft.LS.Resources.Labels.Prestowage %>",
                    "<%: InnoSoft.LS.Resources.Labels.Subtotal %>",
                    "<%: InnoSoft.LS.Resources.Labels.JoinIn %>",
                    "<%: InnoSoft.LS.Resources.Labels.SelfSupport %>",
                    "<%: InnoSoft.LS.Resources.Labels.Prestowage %>",
                    "<%: InnoSoft.LS.Resources.Labels.Subtotal %>",
                    "<%: InnoSoft.LS.Resources.Labels.JoinIn %>",
                    "<%: InnoSoft.LS.Resources.Labels.SelfSupport %>",
                    "<%: InnoSoft.LS.Resources.Labels.Prestowage %>",
                    "<%: InnoSoft.LS.Resources.Labels.Subtotal %>",
                    "<%: InnoSoft.LS.Resources.Labels.JoinIn %>",
                    "<%: InnoSoft.LS.Resources.Labels.SelfSupport %>",
                    "<%: InnoSoft.LS.Resources.Labels.Prestowage %>",
                    "<%: InnoSoft.LS.Resources.Labels.Subtotal %>",
                    "<%: InnoSoft.LS.Resources.Labels.JoinIn %>",
                    "<%: InnoSoft.LS.Resources.Labels.SelfSupport %>",
                    "<%: InnoSoft.LS.Resources.Labels.Prestowage %>",
                    "<%: InnoSoft.LS.Resources.Labels.Subtotal %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ProvinceName", index: "ProvinceName", width: 120, align: "center" },
                    { name: "JoinInTunnages", index: "JoinInTunnages", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "SelfSupportTunnages", index: "SelfSupportTunnages", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "PrestowageTunnages", index: "PrestowageTunnages", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "SubtotalTunnages", index: "SubtotalTunnages", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "JoinInPiles", index: "JoinInPiles", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "SelfSupportPiles", index: "SelfSupportPiles", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "PrestowagePiles", index: "PrestowagePiles", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "SubtotalPiles", index: "SubtotalPiles", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "JoinInTransportCharges", index: "JoinInTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "SelfSupportTransportCharges", index: "SelfSupportTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "PrestowageTransportCharges", index: "PrestowageTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "SubtotalTransportCharges", index: "SubtotalTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "JoinInTransportChargesDifference", index: "JoinInTransportChargesDifference", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "SelfSupportTransportChargesDifference", index: "SelfSupportTransportChargesDifference", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "PrestowageTransportChargesDifference", index: "PrestowageTransportChargesDifference", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "SubtotalTransportChargesDifference", index: "SubtotalTransportChargesDifference", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "JoinInGrossProfitRate", index: "JoinInGrossProfitRate", width: 100, align: "center", formatter: "number", formatoptions: { thousandsSeparator: "," }, summaryType: JoinInGrossProfitRateAverage },
                    { name: "SelfSupportGrossProfitRate", index: "SelfSupportGrossProfitRate", width: 100, align: "center", formatter: "number", formatoptions: { thousandsSeparator: "," }, summaryType: SelfSupportGrossProfitRateAverage },
                    { name: "PrestowageGrossProfitRate", index: "PrestowageGrossProfitRate", width: 100, align: "center", formatter: "number", formatoptions: { thousandsSeparator: "," }, summaryType: PrestowageGrossProfitRateAverage },
                    { name: "SubtotalGrossProfitRate", index: "SubtotalGrossProfitRate", width: 100, align: "center", formatter: "number", formatoptions: { thousandsSeparator: "," }, summaryType: SubtotalGrossProfitRateAverage}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "ProvinceName",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                grouping: true,
                groupingView: {
                    groupField: ["CustomerName"],
                    groupSummary: [true],
                    groupColumnShow: [true],
                    groupText: ["<b>{0}</b>"],
                    groupCollapse: false,
                    groupOrder: ["asc"]
                },
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    var datatype = $("#grid1").jqGrid("getGridParam", "datatype");
                    if (datatype != "local") {
                        $("#tdTimeSpan").text("<%: InnoSoft.LS.Resources.Labels.TimeSpan %>:" + $("#formStatCustomerTotalOutputCondition #StartTime").val().trim() + " ～ " + $("#formStatCustomerTotalOutputCondition #EndTime").val().trim());
                        var footerData = $("#grid1").jqGrid("footerData");
                        $("#tdTotalTunnages").text("<%: InnoSoft.LS.Resources.Labels.TotalTunnages %>:" + footerData.SubtotalTunnages);
                        $("#tdTotalPiles").text("<%: InnoSoft.LS.Resources.Labels.TotalPiles %>:" + footerData.SubtotalPiles);
                        $("#tdTotalTransportCharges").text("<%: InnoSoft.LS.Resources.Labels.TotalTransportCharges %>:" + footerData.SubtotalTransportCharges);
                        $("#tdTotalTransportChargesDifference").text("<%: InnoSoft.LS.Resources.Labels.TotalTransportChargesDifference %>:" + footerData.SubtotalTransportChargesDifference);
                        $("#tdTotalGrossProfitRate").text("<%: InnoSoft.LS.Resources.Labels.TotalGrossProfitRate %>:" + footerData.SubtotalGrossProfitRate);
                    }
                    $.unblockUI();
                }
            });
            $("#grid1").jqGrid("setGroupHeaders", {
                useColSpanStyle: true,
                groupHeaders: [
                    { startColumnName: "JoinInTunnages", numberOfColumns: 4, titleText: "<%: InnoSoft.LS.Resources.Labels.Tunnages %>" },
                    { startColumnName: "JoinInPiles", numberOfColumns: 4, titleText: "<%: InnoSoft.LS.Resources.Labels.Piles %>" },
                    { startColumnName: "JoinInTransportCharges", numberOfColumns: 4, titleText: "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>" },
                    { startColumnName: "JoinInTransportChargesDifference", numberOfColumns: 4, titleText: "<%: InnoSoft.LS.Resources.Labels.TransportChargesDifference %>" },
                    { startColumnName: "JoinInGrossProfitRate", numberOfColumns: 4, titleText: "<%: InnoSoft.LS.Resources.Labels.GrossProfitRate %>"}]
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 250,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formStatCustomerTotalOutputCondition").valid()) {
                            //缓存查询条件
                            $.jStorage.set("StatCustomerTotalOutputCondition_StartTime", $("#formStatCustomerTotalOutputCondition #StartTime").val().trim());
                            $.jStorage.set("StatCustomerTotalOutputCondition_EndTime", $("#formStatCustomerTotalOutputCondition #EndTime").val().trim());
                            $.jStorage.set("StatCustomerTotalOutputCondition_CustomerName", $("#formStatCustomerTotalOutputCondition #CustomerName").val().trim());

                            $.blockUI({
                                message: '<h1><img src="<%=Url.Content("~/Content/busy.gif")%>" /><%: InnoSoft.LS.Resources.Strings.PleaseWait %></h1>',
                                css: {
                                    border: "none",
                                    padding: "15px",
                                    backgroundColor: "#000",
                                    "-webkit-border-radius": "10px",
                                    "-moz-border-radius": "10px",
                                    opacity: .5,
                                    color: "#fff"
                                }
                            });

                            objMain.objWorkspace.objContent.joinInTransportCharges = 0;
                            objMain.objWorkspace.objContent.selfSupportTransportCharges = 0;
                            objMain.objWorkspace.objContent.prestowageTransportCharges = 0;
                            objMain.objWorkspace.objContent.subtotalTransportCharges = 0;
                            objMain.objWorkspace.objContent.joinInTransportChargesDifference = 0;
                            objMain.objWorkspace.objContent.selfSupportTransportChargesDifference = 0;
                            objMain.objWorkspace.objContent.prestowageTransportChargesDifference = 0;
                            objMain.objWorkspace.objContent.subtotalTransportChargesDifference = 0;

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Statistics/LoadStatCustomerTotalOutputGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formStatCustomerTotalOutputCondition #StartTime").val().trim(),
                                    endTime: $("#formStatCustomerTotalOutputCondition #EndTime").val().trim(),
                                    customerName: $("#formStatCustomerTotalOutputCondition #CustomerName").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                            $(this).dialog("close");
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

        //计算加盟毛利率分组合计
        function JoinInGrossProfitRateAverage(val, name, record) {
            if (val.toString() == "") {
                objMain.objWorkspace.objContent.joinInTransportCharges = 0;
                objMain.objWorkspace.objContent.joinInTransportChargesDifference = 0;
            }

            objMain.objWorkspace.objContent.joinInTransportCharges = add(objMain.objWorkspace.objContent.joinInTransportCharges, record["JoinInTransportCharges"]);
            objMain.objWorkspace.objContent.joinInTransportChargesDifference = add(objMain.objWorkspace.objContent.joinInTransportChargesDifference, record["JoinInTransportChargesDifference"]);

            var grossProfitRate = 0;
            if (objMain.objWorkspace.objContent.joinInTransportCharges != 0) {
                grossProfitRate = div(objMain.objWorkspace.objContent.joinInTransportChargesDifference, objMain.objWorkspace.objContent.joinInTransportCharges);
            }

            return grossProfitRate;
        }

        //计算自营毛利率分组合计
        function SelfSupportGrossProfitRateAverage(val, name, record) {
            if (val.toString() == "") {
                objMain.objWorkspace.objContent.selfSupportTransportCharges = 0;
                objMain.objWorkspace.objContent.selfSupportTransportChargesDifference = 0;
            }

            objMain.objWorkspace.objContent.selfSupportTransportCharges = add(objMain.objWorkspace.objContent.selfSupportTransportCharges, record["SelfSupportTransportCharges"]);
            objMain.objWorkspace.objContent.selfSupportTransportChargesDifference = add(objMain.objWorkspace.objContent.selfSupportTransportChargesDifference, record["SelfSupportTransportChargesDifference"]);

            var grossProfitRate = 0;
            if (objMain.objWorkspace.objContent.selfSupportTransportCharges != 0) {
                grossProfitRate = div(objMain.objWorkspace.objContent.selfSupportTransportChargesDifference, objMain.objWorkspace.objContent.selfSupportTransportCharges);
            }

            return grossProfitRate;
        }

        //计算配载毛利率分组合计
        function PrestowageGrossProfitRateAverage(val, name, record) {
            if (val.toString() == "") {
                objMain.objWorkspace.objContent.prestowageTransportCharges = 0;
                objMain.objWorkspace.objContent.prestowageTransportChargesDifference = 0;
            }

            objMain.objWorkspace.objContent.prestowageTransportCharges = add(objMain.objWorkspace.objContent.prestowageTransportCharges, record["PrestowageTransportCharges"]);
            objMain.objWorkspace.objContent.prestowageTransportChargesDifference = add(objMain.objWorkspace.objContent.prestowageTransportChargesDifference, record["PrestowageTransportChargesDifference"]);

            var grossProfitRate = 0;
            if (objMain.objWorkspace.objContent.prestowageTransportCharges != 0) {
                grossProfitRate = div(objMain.objWorkspace.objContent.prestowageTransportChargesDifference, objMain.objWorkspace.objContent.prestowageTransportCharges);
            }

            return grossProfitRate;
        }

        //计算毛利率小计分组合计
        function SubtotalGrossProfitRateAverage(val, name, record) {
            if (val.toString() == "") {
                objMain.objWorkspace.objContent.subtotalTransportCharges = 0;
                objMain.objWorkspace.objContent.subtotalTransportChargesDifference = 0;
            }

            objMain.objWorkspace.objContent.subtotalTransportCharges = add(objMain.objWorkspace.objContent.subtotalTransportCharges, record["SubtotalTransportCharges"]);
            objMain.objWorkspace.objContent.subtotalTransportChargesDifference = add(objMain.objWorkspace.objContent.subtotalTransportChargesDifference, record["SubtotalTransportChargesDifference"]);

            var grossProfitRate = 0;
            if (objMain.objWorkspace.objContent.subtotalTransportCharges != 0) {
                grossProfitRate = div(objMain.objWorkspace.objContent.subtotalTransportChargesDifference, objMain.objWorkspace.objContent.subtotalTransportCharges);
            }

            return grossProfitRate;
        }

    </script>
</asp:Content>
