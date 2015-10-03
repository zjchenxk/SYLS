<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchConsigningDeliverPlans %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("SearchConsigningDeliverPlansCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询条件
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5070, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formSearchConsigningDeliverPlansCondition #DeliveryNo").val("");

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: { consigningDeliveryNo: "" },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.ConsignedDeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Brand %>",
                    "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                    "<%: InnoSoft.LS.Resources.Labels.GrammeWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Grade %>",
                    "<%: InnoSoft.LS.Resources.Labels.PieceWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                    "<%: InnoSoft.LS.Resources.Labels.OutWarehouseTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.OutWarehouseBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.BalancePieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.BalanceTunnages %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "ConsignedDeliveryNo", index: "ConsignedDeliveryNo", width: 120, align: "center" },
                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "Brand", index: "Brand", width: 80, align: "center" },
                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                    { name: "GWeight", index: "GWeight", width: 50, align: "center" },
                    { name: "Grade", index: "Grade", width: 50, align: "center" },
                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                    { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                    { name: "Warehouse", index: "Warehouse", width: 80, align: "center" },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "OutWarehouseBillNo", index: "OutWarehouseBillNo", width: 100, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "BalancePackages", index: "BalancePackages", width: 60, align: "center" },
                    { name: "BalanceTunnages", index: "BalanceTunnages", width: 100, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "Id",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                grouping: true,
                groupingView: {
                    groupField: ['ConsignedDeliveryNo']
                },
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 150,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearchConsigningDeliverPlansCondition").valid()) {
                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Stock/LoadSearchConsigningDeliverPlansGrid/",
                                datatype: "json",
                                postData: {
                                    consigningDeliveryNo: $("#formSearchConsigningDeliverPlansCondition #DeliveryNo").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                            if ($("#formSearchConsigningDeliverPlansCondition #DeliveryNo").val().trim() != "") {
                                $("#grid1").jqGrid("groupingGroupBy", "GoodsNo");
                            }
                            else {
                                $("#grid1").jqGrid("groupingGroupBy", "ConsignedDeliveryNo");
                            }

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

    </script>
</asp:Content>
