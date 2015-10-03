<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.EnterOutBalanceSummary %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.custom();return false;">
            <img src="<%: Url.Content("~/Content/Images/090.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Custom %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Stock/ExportEnterOutBalanceSummary/" onclick="javascript:objMain.objWorkspace.objContent.export(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/049.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Export %></a></li>
    </ul>
    <select id="ddlGroupBy" style="position: relative; float: right; width: 200px; margin-top: -25px; margin-right: 5px; font-family: Arial;">
        <option value="CustomerName" selected="selected">
            <%: InnoSoft.LS.Resources.Options.GroupByCustomerName%></option>
        <option value="BatchNo">
            <%: InnoSoft.LS.Resources.Options.GroupByBatchNo%></option>
        <option value="Warehouse">
            <%: InnoSoft.LS.Resources.Options.GroupByWarehouse%></option>
        <option value="Location">
            <%: InnoSoft.LS.Resources.Options.GroupByLocation%></option>
    </select>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("EnterOutBalanceSummaryCondition"); %>
    </div>
    <div id="dialogCustom" title="">
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.GoodsNo %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showGoodsNo" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.GoodsName %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showGoodsName" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.Brand %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showBrand" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.Specification %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showSpecification" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.GrammeWeight %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showGrammeWeight" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.Grade %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showGrade" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.BatchNo %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showBatchNo" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.Warehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showWarehouse" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.Location %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showLocation" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.BeginningBalance %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Pieces %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showStartPackages" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.BeginningBalance %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Tunnages %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showStartTunnages" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.BeginningBalance %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Piles %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showStartPiles" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.BeginningBalance %>&nbsp;<%: InnoSoft.LS.Resources.Labels.TenThousands %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showStartTenThousands" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalEnterWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Pieces %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalEnterWarehousePackages" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalEnterWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Tunnages %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalEnterWarehouseTunnages" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalEnterWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Piles %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalEnterWarehousePiles" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalEnterWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.TenThousands %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalEnterWarehouseTenThousands" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalOutWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Pieces %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalOutWarehousePackages" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalOutWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Tunnages %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalOutWarehouseTunnages" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalOutWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Piles %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalOutWarehousePiles" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalOutWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.TenThousands %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalOutWarehouseTenThousands" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.EndingBalance %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Pieces %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showEndPackages" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.EndingBalance %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Tunnages %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showEndTunnages" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.EndingBalance %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Piles %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showEndPiles" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.EndingBalance %>&nbsp;<%: InnoSoft.LS.Resources.Labels.TenThousands %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showEndTenThousands" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalAllocateEnterWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Pieces %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalAllocateEnterWarehousePackages" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalAllocateEnterWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Tunnages %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalAllocateEnterWarehouseTunnages" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalAllocateEnterWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Piles %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalAllocateEnterWarehousePiles" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalAllocateEnterWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.TenThousands %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalAllocateEnterWarehouseTenThousands" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalAllocateOutWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Pieces %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalAllocateOutWarehousePackages" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalAllocateOutWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Tunnages %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalAllocateOutWarehouseTunnages" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalAllocateOutWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.Piles %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalAllocateOutWarehousePiles" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.TotalAllocateOutWarehouse %>&nbsp;<%: InnoSoft.LS.Resources.Labels.TenThousands %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showTotalAllocateOutWarehouseTenThousands" type="checkbox" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: InnoSoft.LS.Resources.Labels.ProductionDate %>&nbsp;<%: InnoSoft.LS.Resources.Labels.IsShow %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input id="showProductionDate" type="checkbox" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-hdiv").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //定制表格
            this.custom = function () {
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

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowGoodsNo") == "false")
                    $("#showGoodsNo").removeAttr("checked");
                else
                    $("#showGoodsNo").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowGoodsName") == "false")
                    $("#showGoodsName").removeAttr("checked");
                else
                    $("#showGoodsName").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowBrand") == "false")
                    $("#showBrand").removeAttr("checked");
                else
                    $("#showBrand").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowSpecification") == "false")
                    $("#showSpecification").removeAttr("checked");
                else
                    $("#showSpecification").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowGrammeWeight") == "false")
                    $("#showGrammeWeight").removeAttr("checked");
                else
                    $("#showGrammeWeight").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowGrade") == "false")
                    $("#showGrade").removeAttr("checked");
                else
                    $("#showGrade").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowBatchNo") == "false")
                    $("#showBatchNo").removeAttr("checked");
                else
                    $("#showBatchNo").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowWarehouse") == "false")
                    $("#showWarehouse").removeAttr("checked");
                else
                    $("#showWarehouse").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowLocation") == "false")
                    $("#showLocation").removeAttr("checked");
                else
                    $("#showLocation").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowStartPackages") == "false")
                    $("#showStartPackages").removeAttr("checked");
                else
                    $("#showStartPackages").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowStartTunnages") == "false")
                    $("#showStartTunnages").removeAttr("checked");
                else
                    $("#showStartTunnages").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowStartPiles") == "false")
                    $("#showStartPiles").removeAttr("checked");
                else
                    $("#showStartPiles").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowStartTenThousands") == "false")
                    $("#showStartTenThousands").removeAttr("checked");
                else
                    $("#showStartTenThousands").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehousePackages") == "false")
                    $("#showTotalEnterWarehousePackages").removeAttr("checked");
                else
                    $("#showTotalEnterWarehousePackages").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehouseTunnages") == "false")
                    $("#showTotalEnterWarehouseTunnages").removeAttr("checked");
                else
                    $("#showTotalEnterWarehouseTunnages").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehousePiles") == "false")
                    $("#showTotalEnterWarehousePiles").removeAttr("checked");
                else
                    $("#showTotalEnterWarehousePiles").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehouseTenThousands") == "false")
                    $("#showTotalEnterWarehouseTenThousands").removeAttr("checked");
                else
                    $("#showTotalEnterWarehouseTenThousands").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehousePackages") == "false")
                    $("#showTotalOutWarehousePackages").removeAttr("checked");
                else
                    $("#showTotalOutWarehousePackages").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehouseTunnages") == "false")
                    $("#showTotalOutWarehouseTunnages").removeAttr("checked");
                else
                    $("#showTotalOutWarehouseTunnages").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehousePiles") == "false")
                    $("#showTotalOutWarehousePiles").removeAttr("checked");
                else
                    $("#showTotalOutWarehousePiles").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehouseTenThousands") == "false")
                    $("#showTotalOutWarehouseTenThousands").removeAttr("checked");
                else
                    $("#showTotalOutWarehouseTenThousands").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowEndPackages") == "false")
                    $("#showEndPackages").removeAttr("checked");
                else
                    $("#showEndPackages").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowEndTunnages") == "false")
                    $("#showEndTunnages").removeAttr("checked");
                else
                    $("#showEndTunnages").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowEndPiles") == "false")
                    $("#showEndPiles").removeAttr("checked");
                else
                    $("#showEndPiles").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowEndTenThousands") == "false")
                    $("#showEndTenThousands").removeAttr("checked");
                else
                    $("#showEndTenThousands").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehousePackages") == "false")
                    $("#showTotalAllocateEnterWarehousePackages").removeAttr("checked");
                else
                    $("#showTotalAllocateEnterWarehousePackages").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehouseTunnages") == "false")
                    $("#showTotalAllocateEnterWarehouseTunnages").removeAttr("checked");
                else
                    $("#showTotalAllocateEnterWarehouseTunnages").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehousePiles") == "false")
                    $("#showTotalAllocateEnterWarehousePiles").removeAttr("checked");
                else
                    $("#showTotalAllocateEnterWarehousePiles").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehouseTenThousands") == "false")
                    $("#showTotalAllocateEnterWarehouseTenThousands").removeAttr("checked");
                else
                    $("#showTotalAllocateEnterWarehouseTenThousands").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehousePackages") == "false")
                    $("#showTotalAllocateOutWarehousePackages").removeAttr("checked");
                else
                    $("#showTotalAllocateOutWarehousePackages").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehouseTunnages") == "false")
                    $("#showTotalAllocateOutWarehouseTunnages").removeAttr("checked");
                else
                    $("#showTotalAllocateOutWarehouseTunnages").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehousePiles") == "false")
                    $("#showTotalAllocateOutWarehousePiles").removeAttr("checked");
                else
                    $("#showTotalAllocateOutWarehousePiles").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehouseTenThousands") == "false")
                    $("#showTotalAllocateOutWarehouseTenThousands").removeAttr("checked");
                else
                    $("#showTotalAllocateOutWarehouseTenThousands").attr("checked", "checked");

                if (GetCookie("EnterOutBalanceSummaryCondition_ShowProductionDate") == "false")
                    $("#showProductionDate").removeAttr("checked");
                else
                    $("#showProductionDate").attr("checked", "checked");

                $.unblockUI();

                //打开条件输入对话框
                $("#dialogCustom").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.CustomGrid %>");
                $("#dialogCustom").dialog("open");
            };
            //查询条件
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5050, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formEnterOutBalanceSummaryCondition #StartTime").val($.jStorage.get("EnterOutBalanceSummaryCondition_StartTime", ""));
                    $("#formEnterOutBalanceSummaryCondition #EndTime").val($.jStorage.get("EnterOutBalanceSummaryCondition_EndTime", ""));
                    $("#formEnterOutBalanceSummaryCondition #CustomerName").val($.jStorage.get("EnterOutBalanceSummaryCondition_CustomerName", ""));
                    $("#formEnterOutBalanceSummaryCondition #DeliveryNo").val($.jStorage.get("EnterOutBalanceSummaryCondition_DeliveryNo", ""));
                    $("#formEnterOutBalanceSummaryCondition #EnterWarehouseBillNo").val($.jStorage.get("EnterOutBalanceSummaryCondition_EnterWarehouseBillNo", ""));
                    $("#formEnterOutBalanceSummaryCondition #GoodsNo").val($.jStorage.get("EnterOutBalanceSummaryCondition_GoodsNo", ""));
                    $("#formEnterOutBalanceSummaryCondition #BatchNo").val($.jStorage.get("EnterOutBalanceSummaryCondition_BatchNo", ""));
                    $("#formEnterOutBalanceSummaryCondition #Warehouse").val($.jStorage.get("EnterOutBalanceSummaryCondition_Warehouse", ""));
                    $("#formEnterOutBalanceSummaryCondition #IsConsigning").attr("checked", $.jStorage.get("EnterOutBalanceSummaryCondition_IsConsigning", false));

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
                $.get("/Common/LoadAccountPermission", { strFuncId: 5050, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#grid1").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.ExportMustAfterSearch %>");
                        return;
                    }
                    else {
                        if ($("#formEnterOutBalanceSummaryCondition #StartTime").val().trim() == "" && $("#formEnterOutBalanceSummaryCondition #EndTime").val().trim() == "") {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterStartTimeAndEndTimeCondition %>");
                            return;
                        }
                    }

                    var url = action + "?" +
                        "startTime=" + $("#formEnterOutBalanceSummaryCondition #StartTime").val().trim() + "&" +
                        "endTime=" + $("#formEnterOutBalanceSummaryCondition #EndTime").val().trim() + "&" +
                        "customerName=" + $("#formEnterOutBalanceSummaryCondition #CustomerName").val().trim() + "&" +
                        "deliveryNo=" + $("#formEnterOutBalanceSummaryCondition #DeliveryNo").val().trim() + "&" +
                        "enterWarehouseBillNo=" + $("#formEnterOutBalanceSummaryCondition #EnterWarehouseBillNo").val().trim() + "&" +
                        "goodsNo=" + $("#formEnterOutBalanceSummaryCondition #GoodsNo").val().trim() + "&" +
                        "batchNo=" + $("#formEnterOutBalanceSummaryCondition #BatchNo").val().trim() + "&" +
                        "warehouse=" + $("#formEnterOutBalanceSummaryCondition #Warehouse").val().trim() + "&" +
                        "isConsigning=" + ($("#formEnterOutBalanceSummaryCondition #IsConsigning").attr("checked") == "checked").toString();

                    location.replace(url);
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
                postData: {
                    stratTime: "",
                    endTime: "",
                    customerName: "",
                    deliveryNo: "",
                    enterWarehouseBillNo: "",
                    goodsNo: "",
                    batchNo: "",
                    warehouse: "",
                    isConsigning: "false"
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Brand %>",
                    "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                    "<%: InnoSoft.LS.Resources.Labels.GrammeWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Grade %>",
                    "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                    "<%: InnoSoft.LS.Resources.Labels.Location %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>"],
                colModel: [
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowGoodsNo") == "false") },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowGoodsName") == "false") },
                    { name: "Brand", index: "Brand", width: 80, align: "center", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowBrand") == "false") },
                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowSpecification") == "false") },
                    { name: "GWeight", index: "GWeight", width: 50, align: "center", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowGrammeWeight") == "false") },
                    { name: "Grade", index: "Grade", width: 50, align: "center", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowGrade") == "false") },
                    { name: "BatchNo", index: "BatchNo", width: 100, align: "center", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowBatchNo") == "false") },
                    { name: "Warehouse", index: "Warehouse", width: 80, align: "center", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowWarehouse") == "false") },
                    { name: "Location", index: "Location", width: 50, align: "center", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowLocation") == "false") },
                    { name: "StartPackages", index: "StartPackages", width: 100, align: "center", summaryType: "sum", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowStartPackages") == "false") },
                    { name: "StartTunnages", index: "StartTunnages", width: 100, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowStartTunnages") == "false") },
                    { name: "StartPiles", index: "StartPiles", width: 100, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowStartPiles") == "false") },
                    { name: "StartTenThousands", index: "StartTenThousands", width: 100, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowStartTenThousands") == "false") },
                    { name: "TotalEnterWarehousePackages", index: "TotalEnterWarehousePackages", width: 100, align: "center", summaryType: "sum", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehousePackages") == "false") },
                    { name: "TotalEnterWarehouseTunnages", index: "TotalEnterWarehouseTunnages", width: 100, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehouseTunnages") == "false") },
                    { name: "TotalEnterWarehousePiles", index: "TotalEnterWarehousePiles", width: 100, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehousePiles") == "false") },
                    { name: "TotalEnterWarehouseTenThousands", index: "TotalEnterWarehouseTenThousands", width: 100, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehouseTenThousands") == "false") },
                    { name: "TotalOutWarehousePackages", index: "TotalOutWarehousePackages", width: 100, align: "center", summaryType: "sum", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehousePackages") == "false") },
                    { name: "TotalOutWarehouseTunnages", index: "TotalOutWarehouseTunnages", width: 100, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehouseTunnages") == "false") },
                    { name: "TotalOutWarehousePiles", index: "TotalOutWarehousePiles", width: 100, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehousePiles") == "false") },
                    { name: "TotalOutWarehouseTenThousands", index: "TotalOutWarehouseTenThousands", width: 100, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehouseTenThousands") == "false") },
                    { name: "EndPackages", index: "EndPackages", width: 100, align: "center", summaryType: "sum", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowEndPackages") == "false") },
                    { name: "EndTunnages", index: "EndTunnages", width: 100, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowEndTunnages") == "false") },
                    { name: "EndPiles", index: "EndPiles", width: 100, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowEndPiles") == "false") },
                    { name: "EndTenThousands", index: "EndTenThousands", width: 100, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowEndTenThousands") == "false") },
                    { name: "TotalAllocateEnterWarehousePackages", index: "TotalAllocateEnterWarehousePackages", width: 120, align: "center", summaryType: "sum", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehousePackages") == "false") },
                    { name: "TotalAllocateEnterWarehouseTunnages", index: "TotalAllocateEnterWarehouseTunnages", width: 120, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehouseTunnages") == "false") },
                    { name: "TotalAllocateEnterWarehousePiles", index: "TotalAllocateEnterWarehousePiles", width: 120, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehousePiles") == "false") },
                    { name: "TotalAllocateEnterWarehouseTenThousands", index: "TotalAllocateEnterWarehouseTenThousands", width: 120, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehouseTenThousands") == "false") },
                    { name: "TotalAllocateOutWarehousePackages", index: "TotalAllocateOutWarehousePackages", width: 120, align: "center", summaryType: "sum", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehousePackages") == "false") },
                    { name: "TotalAllocateOutWarehouseTunnages", index: "TotalAllocateOutWarehouseTunnages", width: 120, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehouseTunnages") == "false") },
                    { name: "TotalAllocateOutWarehousePiles", index: "TotalAllocateOutWarehousePiles", width: 120, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehousePiles") == "false") },
                    { name: "TotalAllocateOutWarehouseTenThousands", index: "TotalAllocateOutWarehouseTenThousands", width: 120, align: "center", summaryType: myNumberSum, hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehouseTenThousands") == "false") },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center", hidden: (GetCookie("EnterOutBalanceSummaryCondition_ShowProductionDate") == "false") }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CustomerName",
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
                }
            });
            $("#grid1").jqGrid("setGroupHeaders", {
                useColSpanStyle: true,
                groupHeaders: [
                    { startColumnName: "StartPackages", numberOfColumns: 4, titleText: "<%: InnoSoft.LS.Resources.Labels.BeginningBalance %>" },
                    { startColumnName: "TotalEnterWarehousePackages", numberOfColumns: 4, titleText: "<%: InnoSoft.LS.Resources.Labels.TotalEnterWarehouse %>" },
                    { startColumnName: "TotalOutWarehousePackages", numberOfColumns: 4, titleText: "<%: InnoSoft.LS.Resources.Labels.TotalOutWarehouse %>" },
                    { startColumnName: "EndPackages", numberOfColumns: 4, titleText: "<%: InnoSoft.LS.Resources.Labels.EndingBalance %>" },
                    { startColumnName: "TotalAllocateEnterWarehousePackages", numberOfColumns: 4, titleText: "<%: InnoSoft.LS.Resources.Labels.TotalAllocateEnterWarehouse %>" },
                    { startColumnName: "TotalAllocateOutWarehousePackages", numberOfColumns: 4, titleText: "<%: InnoSoft.LS.Resources.Labels.TotalAllocateOutWarehouse %>" }]
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 400,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formEnterOutBalanceSummaryCondition").valid()) {
                            //缓存查询条件
                            $.jStorage.set("EnterOutBalanceSummaryCondition_StartTime", $("#formEnterOutBalanceSummaryCondition #StartTime").val().trim());
                            $.jStorage.set("EnterOutBalanceSummaryCondition_EndTime", $("#formEnterOutBalanceSummaryCondition #EndTime").val().trim());
                            $.jStorage.set("EnterOutBalanceSummaryCondition_CustomerName", $("#formEnterOutBalanceSummaryCondition #CustomerName").val().trim());
                            $.jStorage.set("EnterOutBalanceSummaryCondition_DeliveryNo", $("#formEnterOutBalanceSummaryCondition #DeliveryNo").val().trim());
                            $.jStorage.set("EnterOutBalanceSummaryCondition_EnterWarehouseBillNo", $("#formEnterOutBalanceSummaryCondition #EnterWarehouseBillNo").val().trim());
                            $.jStorage.set("EnterOutBalanceSummaryCondition_GoodsNo", $("#formEnterOutBalanceSummaryCondition #GoodsNo").val().trim());
                            $.jStorage.set("EnterOutBalanceSummaryCondition_BatchNo", $("#formEnterOutBalanceSummaryCondition #BatchNo").val().trim());
                            $.jStorage.set("EnterOutBalanceSummaryCondition_Warehouse", $("#formEnterOutBalanceSummaryCondition #Warehouse").val().trim());
                            $.jStorage.set("EnterOutBalanceSummaryCondition_IsConsigning", ($("#formEnterOutBalanceSummaryCondition #IsConsigning").attr("checked") == "checked"));

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Stock/LoadEnterOutBalanceSummaryGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formEnterOutBalanceSummaryCondition #StartTime").val().trim(),
                                    endTime: $("#formEnterOutBalanceSummaryCondition #EndTime").val().trim(),
                                    customerName: $("#formEnterOutBalanceSummaryCondition #CustomerName").val().trim(),
                                    deliveryNo: $("#formEnterOutBalanceSummaryCondition #DeliveryNo").val().trim(),
                                    enterWarehouseBillNo: $("#formEnterOutBalanceSummaryCondition #EnterWarehouseBillNo").val().trim(),
                                    goodsNo: $("#formEnterOutBalanceSummaryCondition #GoodsNo").val().trim(),
                                    batchNo: $("#formEnterOutBalanceSummaryCondition #BatchNo").val().trim(),
                                    warehouse: $("#formEnterOutBalanceSummaryCondition #Warehouse").val().trim(),
                                    isConsigning: ($("#formEnterOutBalanceSummaryCondition #IsConsigning").attr("checked") == "checked")
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

            //分组类别选择事件
            $("#ddlGroupBy").change(function () {
                if ($(this).val().trim() == "") {
                    $("#grid1").jqGrid("groupingRemove", true);
                } else {
                    $("#grid1").jqGrid("groupingGroupBy", $(this).val().trim());
                }
            });

            //创建定制对话框
            $("#dialogCustom").dialog({
                autoOpen: false,
                height: 400,
                width: 300,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Close %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

            $("#showGoodsNo").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "GoodsNo");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowGoodsNo", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "GoodsNo");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowGoodsNo", "false");
                }

                $.unblockUI();
            });

            $("#showGoodsName").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "GoodsName");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowGoodsName", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "GoodsName");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowGoodsName", "false");
                }

                $.unblockUI();
            });

            $("#showBrand").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "Brand");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowBrand", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "Brand");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowBrand", "false");
                }

                $.unblockUI();
            });

            $("#showSpecification").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "SpecModel");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowSpecification", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "SpecModel");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowSpecification", "false");
                }

                $.unblockUI();
            });

            $("#showGrammeWeight").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "GWeight");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowGrammeWeight", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "GWeight");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowGrammeWeight", "false");
                }

                $.unblockUI();
            });

            $("#showGrade").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "Grade");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowGrade", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "Grade");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowGrade", "false");
                }

                $.unblockUI();
            });

            $("#showBatchNo").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "BatchNo");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowBatchNo", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "BatchNo");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowBatchNo", "false");
                }

                $.unblockUI();
            });

            $("#showWarehouse").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "Warehouse");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowWarehouse", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "Warehouse");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowWarehouse", "false");
                }

                $.unblockUI();
            });

            $("#showLocation").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "Location");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowLocation", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "Location");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowLocation", "false");
                }

                $.unblockUI();
            });

            $("#showStartPackages").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "StartPackages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowStartPackages", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "StartPackages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowStartPackages", "false");
                }

                $.unblockUI();
            });

            $("#showStartTunnages").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "StartTunnages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowStartTunnages", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "StartTunnages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowStartTunnages", "false");
                }

                $.unblockUI();
            });

            $("#showStartPiles").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "StartPiles");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowStartPiles", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "StartPiles");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowStartPiles", "false");
                }

                $.unblockUI();
            });

            $("#showStartTenThousands").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "StartTenThousands");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowStartTenThousands", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "StartTenThousands");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowStartTenThousands", "false");
                }

                $.unblockUI();
            });

            $("#showTotalEnterWarehousePackages").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalEnterWarehousePackages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehousePackages", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalEnterWarehousePackages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehousePackages", "false");
                }

                $.unblockUI();
            });

            $("#showTotalEnterWarehouseTunnages").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalEnterWarehouseTunnages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehouseTunnages", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalEnterWarehouseTunnages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehouseTunnages", "false");
                }

                $.unblockUI();
            });

            $("#showTotalEnterWarehousePiles").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalEnterWarehousePiles");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehousePiles", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalEnterWarehousePiles");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehousePiles", "false");
                }

                $.unblockUI();
            });

            $("#showTotalEnterWarehouseTenThousands").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalEnterWarehouseTenThousands");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehouseTenThousands", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalEnterWarehouseTenThousands");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalEnterWarehouseTenThousands", "false");
                }

                $.unblockUI();
            });

            $("#showTotalOutWarehousePackages").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalOutWarehousePackages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehousePackages", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalOutWarehousePackages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehousePackages", "false");
                }

                $.unblockUI();
            });

            $("#showTotalOutWarehouseTunnages").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalOutWarehouseTunnages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehouseTunnages", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalOutWarehouseTunnages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehouseTunnages", "false");
                }

                $.unblockUI();
            });

            $("#showTotalOutWarehousePiles").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalOutWarehousePiles");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehousePiles", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalOutWarehousePiles");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehousePiles", "false");
                }

                $.unblockUI();
            });

            $("#showTotalOutWarehouseTenThousands").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalOutWarehouseTenThousands");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehouseTenThousands", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalOutWarehouseTenThousands");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalOutWarehouseTenThousands", "false");
                }

                $.unblockUI();
            });

            $("#showEndPackages").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "EndPackages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowEndPackages", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "EndPackages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowEndPackages", "false");
                }

                $.unblockUI();
            });

            $("#showEndTunnages").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "EndTunnages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowEndTunnages", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "EndTunnages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowEndTunnages", "false");
                }

                $.unblockUI();
            });

            $("#showEndPiles").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "EndPiles");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowEndPiles", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "EndPiles");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowEndPiles", "false");
                }

                $.unblockUI();
            });

            $("#showEndTenThousands").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "EndTenThousands");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowEndTenThousands", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "EndTenThousands");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowEndTenThousands", "false");
                }

                $.unblockUI();
            });

            $("#showTotalAllocateEnterWarehousePackages").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalAllocateEnterWarehousePackages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehousePackages", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalAllocateEnterWarehousePackages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehousePackages", "false");
                }

                $.unblockUI();
            });

            $("#showTotalAllocateEnterWarehouseTunnages").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalAllocateEnterWarehouseTunnages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehouseTunnages", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalAllocateEnterWarehouseTunnages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehouseTunnages", "false");
                }

                $.unblockUI();
            });

            $("#showTotalAllocateEnterWarehousePiles").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalAllocateEnterWarehousePiles");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehousePiles", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalAllocateEnterWarehousePiles");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehousePiles", "false");
                }

                $.unblockUI();
            });

            $("#showTotalAllocateEnterWarehouseTenThousands").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalAllocateEnterWarehouseTenThousands");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehouseTenThousands", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalAllocateEnterWarehouseTenThousands");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateEnterWarehouseTenThousands", "false");
                }

                $.unblockUI();
            });

            $("#showTotalAllocateOutWarehousePackages").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalAllocateOutWarehousePackages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehousePackages", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalAllocateOutWarehousePackages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehousePackages", "false");
                }

                $.unblockUI();
            });

            $("#showTotalAllocateOutWarehouseTunnages").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalAllocateOutWarehouseTunnages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehouseTunnages", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalAllocateOutWarehouseTunnages");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehouseTunnages", "false");
                }

                $.unblockUI();
            });

            $("#showTotalAllocateOutWarehousePiles").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalAllocateOutWarehousePiles");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehousePiles", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalAllocateOutWarehousePiles");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehousePiles", "false");
                }

                $.unblockUI();
            });

            $("#showTotalAllocateOutWarehouseTenThousands").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "TotalAllocateOutWarehouseTenThousands");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehouseTenThousands", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "TotalAllocateOutWarehouseTenThousands");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowTotalAllocateOutWarehouseTenThousands", "false");
                }

                $.unblockUI();
            });

            $("#showProductionDate").change(function () {
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

                if ($(this).attr("checked") == "checked") {
                    $("#grid1").jqGrid("showCol", "ProductionDate");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowProductionDate", "true");
                }
                else {
                    $("#grid1").jqGrid("hideCol", "ProductionDate");
                    SetCookie("EnterOutBalanceSummaryCondition_ShowProductionDate", "false");
                }

                $.unblockUI();
            });

        });

    </script>
</asp:Content>
