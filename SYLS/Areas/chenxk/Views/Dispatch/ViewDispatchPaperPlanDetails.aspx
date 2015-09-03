﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ViewDispatchPaperPlanDetails %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href='<%: ViewData["BackTo"] %>' onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% Html.RenderAction("LoadPaperPlanDetails", "Plan", new { id = ViewData["id"] }); %>
    <fieldset style="border: none;">
        <div>
            <table id="grid2">
            </table>
            <div id="pager2">
            </div>
        </div>
    </fieldset>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
                $("#grid2").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //设置货物表格事件
            $("#grid1").jqGrid("setGridParam", {
                onSelectRow: function (rowid, status) {
                    //加载当前选中货物的调度历史记录
                    var data = $("#grid1").jqGrid("getRowData", rowid);

                    $("#grid2").jqGrid("setGridParam", {
                        postData: {
                            planId: '<%: ViewData["id"] %>',
                            goodsId: data.GoodsId,
                            batchNo: data.BatchNo,
                            packing: data.Packing,
                            location: data.Location,
                            productionDate: data.ProductionDate,
                            enterWarehouseBillId: data.EnterWarehouseBillId
                        }
                    });
                    $("#grid2").trigger("reloadGrid", [{ page: 1}]);
                }
            });

            //创建发货历史记录表格
            $("#grid2").jqGrid({
                url: "/chenxk/Dispatch/LoadPaperPlanGoodsDispatchHistoryGrid/",
                datatype: "json",
                mtype: "GET",
                postData: {
                    planId: '<%: ViewData["id"] %>',
                    goodsId: "0",
                    batchNo: "",
                    packing: "",
                    location: "",
                    productionDate: "",
                    enterWarehouseBillId: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.DispatchBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.DispatchTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.PackingSpecification %>",
                    "<%: InnoSoft.LS.Resources.Labels.Location %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 80, align: "center" },
                    { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                    { name: "Packing", index: "Packing", width: 50, align: "center" },
                    { name: "Location", index: "Location", width: 50, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                    { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CreateTime",
                sortorder: "asc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                height: 300,
                footerrow: true,
                userDataOnFooter: true,
                caption: "<%: InnoSoft.LS.Resources.Titles.DispatchHistories %>",
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

        });

    </script>
</asp:Content>
