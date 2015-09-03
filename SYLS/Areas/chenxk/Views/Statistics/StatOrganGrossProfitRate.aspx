<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.StatOrganGrossProfitRate %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Statistics/ExportOrganGrossProfitRate/" onclick="javascript:objMain.objWorkspace.objContent.export(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/049.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Export %></a></li>
    </ul>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <div id="dialogCondition" title="" style="">
        <% Html.RenderPartial("StatOrganGrossProfitRateCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            this.totalCustomerTransportCharges = 0;
            this.totalTransportChargesDifference = 0;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-hdiv").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询条件
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 7011, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formStatOrganGrossProfitRateCondition #StartTime").val($.jStorage.get("StatOrganGrossProfitRateCondition_StartTime", ""));
                    $("#formStatOrganGrossProfitRateCondition #EndTime").val($.jStorage.get("StatOrganGrossProfitRateCondition_EndTime", ""));
                    $("#formStatOrganGrossProfitRateCondition #OrganId").val($.jStorage.get("StatOrganGrossProfitRateCondition_OrganId", ""));

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
                $.get("/Common/LoadAccountPermission", { strFuncId: 7011, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#grid1").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.ExportMustAfterSearch %>");
                        return;
                    }
                    else {
                        if ($("#formStatOrganGrossProfitRateCondition #StartTime").val().trim() == "" && $("#formStatOrganGrossProfitRateCondition #EndTime").val().trim() == "") {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterStartTimeAndEndTimeCondition %>");
                            return;
                        }
                    }

                    var url = action + "?" +
                    "startTime=" + $("#formStatOrganGrossProfitRateCondition #StartTime").val().trim() + "&" +
                    "endTime=" + $("#formStatOrganGrossProfitRateCondition #EndTime").val().trim() + "&" +
                    "organId=" + $("#formStatOrganGrossProfitRateCondition #OrganId").val().trim();

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
                    organId: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.OrganName %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.EndTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalCarrierTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalCustomerTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalTransportChargesDifference %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalGrossProfitRate %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "OrganName", index: "OrganName", width: 200 },
                    { name: "StartTime", index: "StartTime", width: 80, align: "center" },
                    { name: "EndTime", index: "EndTime", width: 80, align: "center" },
                    { name: "StartPlace", index: "StartPlace", width: 100, align: "center" },
                    { name: "DestPlace", index: "DestPlace", width: 100, align: "center" },
                    { name: "TotalCarrierTransportCharges", index: "TotalCarrierTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "TotalCustomerTransportCharges", index: "TotalCarrierTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "TotalTransportChargesDifference", index: "TotalTransportChargesDifference", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "TotalGrossProfitRate", index: "TotalGrossProfitRate", width: 100, align: "center", formatter: "number", formatoptions: { thousandsSeparator: "," }, summaryType: TotalGrossProfitRateAverage }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "OrganName",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                grouping: true,
                groupingView: {
                    groupField: ["OrganName"],
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
                    $.unblockUI();
                }
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
                        if ($("#formStatOrganGrossProfitRateCondition").valid()) {
                            //缓存查询条件
                            $.jStorage.set("StatOrganGrossProfitRateCondition_StartTime", $("#formStatOrganGrossProfitRateCondition #StartTime").val().trim());
                            $.jStorage.set("StatOrganGrossProfitRateCondition_EndTime", $("#formStatOrganGrossProfitRateCondition #EndTime").val().trim());
                            $.jStorage.set("StatOrganGrossProfitRateCondition_OrganId", $("#formStatOrganGrossProfitRateCondition #OrganId").val().trim());

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

                            objMain.objWorkspace.objContent.totalCustomerTransportCharges = 0;
                            objMain.objWorkspace.objContent.totalTransportChargesDifference = 0;

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Statistics/LoadStatOrganGrossProfitRateGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formStatOrganGrossProfitRateCondition #StartTime").val().trim(),
                                    endTime: $("#formStatOrganGrossProfitRateCondition #EndTime").val().trim(),
                                    organId: $("#formStatOrganGrossProfitRateCondition #OrganId").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1 }]);

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

        //计算毛利率分组合计
        function TotalGrossProfitRateAverage(val, name, record) {
            if (val.toString() == "") {
                objMain.objWorkspace.objContent.totalCustomerTransportCharges = 0;
                objMain.objWorkspace.objContent.totalTransportChargesDifference = 0;
            }

            objMain.objWorkspace.objContent.totalCustomerTransportCharges = add(objMain.objWorkspace.objContent.totalCustomerTransportCharges, record["TotalCustomerTransportCharges"]);
            objMain.objWorkspace.objContent.totalTransportChargesDifference = add(objMain.objWorkspace.objContent.totalTransportChargesDifference, record["TotalTransportChargesDifference"]);

            var grossProfitRate = 0;
            if (objMain.objWorkspace.objContent.totalCustomerTransportCharges != 0) {
                grossProfitRate = div(objMain.objWorkspace.objContent.totalTransportChargesDifference, objMain.objWorkspace.objContent.totalCustomerTransportCharges);
            }

            return grossProfitRate;
        }

    </script>
</asp:Content>
