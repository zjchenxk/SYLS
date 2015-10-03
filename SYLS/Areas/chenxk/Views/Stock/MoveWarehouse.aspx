<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.MoveWarehouseBillViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.MoveWarehouse %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.save();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("MoveWarehouse", "Stock", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.BasicInfo %></legend>
        <%: Html.HiddenFor(model => model.CustomerId) %>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CustomerName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CustomerName) %>
                        <%: Html.ValidationMessageFor(model => model.CustomerName) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Warehouse) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.Warehouse, ViewData["Warehouses"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.Warehouse) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ConsignedDeliveryNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ConsignedDeliveryNo) %>
                        <%: Html.ValidationMessageFor(model => model.ConsignedDeliveryNo) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.GoodsNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.GoodsNo)%>
                        <%: Html.ValidationMessageFor(model => model.GoodsNo)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Remark) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Remark) %>
                        <%: Html.ValidationMessageFor(model => model.Remark) %>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.GoodsList %></legend>
        <div>
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnCopyGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Copy %>
            </button>
            <button id="btnDeleteGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete %>
            </button>
        </div>
    </fieldset>
    <% } %>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认客户名称获得焦点
                $("#form1 #CustomerName").focus().select();
            };
            //复制货物
            this.copyGoods = function () {
                var rowid = $("#grid1").jqGrid("getGridParam", "selrow");
                if (rowid == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedGoods %>");
                    return;
                }

                //如果选中行处于编辑状态，则复制前应取消编辑状态
                var ind = $("#grid1").jqGrid("getInd", rowid);
                $("#grid1").jqGrid("editCell", ind, 20, false);
                $("#grid1").jqGrid("editCell", ind, 21, false);
                $("#grid1").jqGrid("editCell", ind, 23, false);
                $("#grid1").jqGrid("editCell", ind, 24, false);

                //读取选中货物数据
                var data = $("#grid1").jqGrid("getRowData", rowid);

                //计算rowid
                var rowids = $("#grid1").jqGrid("getDataIDs");
                var rowidLast = 0;
                for (var i = 0; i < rowids.length; i++) {
                    if (parseFloat(rowids[i]) > parseFloat(rowidLast)) {
                        rowidLast = rowids[i];
                    }
                }

                //复制货物数据
                $("#grid1").jqGrid("addRowData", parseFloat(rowidLast) + 1, {
                    Id: parseFloat(rowidLast) + 1,
                    GoodsId: data.GoodsId,
                    GoodsNo: data.GoodsNo,
                    GoodsName: data.GoodsName,
                    Brand: data.Brand,
                    SpecModel: data.SpecModel,
                    GWeight: data.GWeight,
                    Grade: data.Grade,
                    BatchNo: data.BatchNo,
                    ProductionDate: data.ProductionDate,
                    Packing: data.Packing,
                    Location: data.Location,
                    Packages: data.Packages,
                    PieceWeight: data.PieceWeight,
                    Tunnages: data.Tunnages,
                    Piles: data.Piles,
                    TenThousands: data.TenThousands,
                    EnterWarehouseBillId: data.EnterWarehouseBillId,
                    EnterWarehouseBillNo: data.EnterWarehouseBillNo,
                    NewLocation: "",
                    NewPackages: "0",
                    NewTunnages: "0",
                    NewPiles: "0",
                    NewTenThousands: "0",
                    IsCopy: "1"
                });
            };
            //删除货物信息
            this.deleteGoods = function () {
                var rowid = $("#grid1").jqGrid("getGridParam", "selrow");
                if (rowid == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedGoods %>");
                    return;
                }

                //如果选中行处于编辑状态，则删除前应取消编辑状态
                var ind = $("#grid1").jqGrid("getInd", rowid);
                $("#grid1").jqGrid("editCell", ind, 20, false);
                $("#grid1").jqGrid("editCell", ind, 21, false);
                $("#grid1").jqGrid("editCell", ind, 23, false);
                $("#grid1").jqGrid("editCell", ind, 24, false);

                $("#grid1").jqGrid("delRowData", rowid);

                //重置合计数
                var totalPackages = 0;
                var totalTunnages = 0;
                var totalPiles = 0;
                var totalTenThousands = 0;
                var totalNewPackages = 0;
                var totalNewTunnages = 0;
                var totalNewPiles = 0;
                var totalNewTenThousands = 0;
                var rows = $("#grid1").jqGrid("getRowData");
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    if (row.IsCopy != "1") {
                        totalPackages += parseInt(row.Packages);
                        totalTunnages = add(totalTunnages, parseFloat(row.Tunnages));
                        totalPiles = add(totalPiles, parseFloat(row.Piles));
                        totalTenThousands = add(totalTenThousands, parseFloat(row.TenThousands));
                    }
                    totalNewPackages += parseInt(row.NewPackages);
                    totalNewTunnages = add(totalNewTunnages, parseFloat(row.NewTunnages));
                    totalNewPiles = add(totalNewPiles, parseFloat(row.NewPiles));
                    totalNewTenThousands = add(totalNewTenThousands, parseFloat(row.NewTenThousands));
                }
                $("#grid1").jqGrid("footerData", "set", {
                    GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>",
                    Packages: totalPackages,
                    Tunnages: totalTunnages,
                    Piles: totalPiles,
                    TenThousands: totalTenThousands,
                    NewPackages: totalNewPackages,
                    NewTunnages: totalNewTunnages,
                    NewPiles: totalNewPiles,
                    NewTenThousands: totalNewTenThousands
                });
            };
            //保存数据
            this.save = function () {
                $("#form1").submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            $("#form1 #CustomerId").val("0");

            //设置客户名称自动完成
            $("#form1 #CustomerName").autocomplete({
                source: "/Autocomplete/LoadCustomerNames/",
                minLength: 1,
                change: function (event, ui) {
                    //清空数据
                    $("#form1 #Warehouse").val("");
                    $("#form1 #ConsignedDeliveryNo").val("");
                    $("#form1 #GoodsNo").val("");
                    $("#grid1").jqGrid("clearGridData", true);

                    //填充客户编码
                    $.get("/Common/LoadCustomerByName", { strName: $("#form1 #CustomerName").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #CustomerId").val(ret.Id);
                        }
                        else {
                            alert("<%: InnoSoft.LS.Resources.Strings.CustomerNameNotExists %>");
                            $("#form1 #CustomerId").val("0");
                            $("#form1 #CustomerName").val("");
                            $("#form1 #CustomerName").focus().select();
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #CustomerName").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //仓库选择事件
            $("#form1 #Warehouse").change(function () {
                //检查是否输入客户名称
                if ($("#form1 #CustomerId").val().trim() == "0") {
                    $("#form1 #Warehouse").val("");
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                    return;
                }

                //清空数据
                $("#form1 #ConsignedDeliveryNo").val("");
                $("#form1 #GoodsNo").val("");
                $("#grid1").jqGrid("clearGridData", true);

                //检查当前客户和仓库是否有计划未全部发完货
                $.get("/chenxk/Stock/HasDispatchDeliverPlans", { customerId: $("#form1 #CustomerId").val().trim(), warehouse: $("#form1 #Warehouse").val().trim() }, function (ret) {
                    if (ret) {
                        $("#form1 #Warehouse").val("");
                        alert("<%: InnoSoft.LS.Resources.Strings.CanNotOutWarehouseWhenHasDispatchDeliverPlans %>");
                        return;
                    }
                    else {
                        $("#grid1").jqGrid("setGridParam", {
                            url: "/chenxk/Stock/LoadAllGoodsStocksGrid/",
                            datatype: "json",
                            postData: {
                                customerId: $("#form1 #CustomerId").val().trim(),
                                warehouse: $("#form1 #Warehouse").val().trim(),
                                consignedDeliveryNo: "",
                                goodsId: ""
                            }
                        });
                        $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                    }
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #Warehouse").val("");
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //设置寄库交货单号改变事件
            $("#form1 #ConsignedDeliveryNo").change(function () {
                //检查是否输入客户名称
                if ($("#form1 #CustomerId").val().trim() == "0") {
                    $("#form1 #ConsignedDeliveryNo").val("");
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                    return;
                }

                //检查是否输入仓库
                if ($("#form1 #Warehouse").val().trim() == "") {
                    $("#form1 #ConsignedDeliveryNo").val("");
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterWarehouse %>");
                    return;
                }

                //请空数据
                $("#form1 #GoodsNo").val("");
                $("#grid1").jqGrid("clearGridData", true);

                //填充货物表格
                $("#grid1").jqGrid("setGridParam", {
                    url: "/chenxk/Stock/LoadAllGoodsStocksGrid/",
                    postData: {
                        customerId: $("#form1 #CustomerId").val().trim(),
                        warehouse: $("#form1 #Warehouse").val().trim(),
                        consignedDeliveryNo: $("#form1 #ConsignedDeliveryNo").val().trim(),
                        goodsId: ""
                    }
                });
                $("#grid1").trigger("reloadGrid", [{ page: 1}]);
            });

            //设置货物编号自动完成
            $("#form1 #GoodsNo").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "/Autocomplete/LoadGoodsNos/",
                        dataType: "text json",
                        data: {
                            term: request.term
                        },
                        success: function (ret) {
                            response($.map(ret, function (item) {
                                return {
                                    label: item.GoodsNo + "," + item.Name + (item.SpecModel ? "," + item.SpecModel : "") + (item.GWeight ? "," + item.GWeight : "") + (item.Grade ? "," + item.Grade : "") + (item.Packing ? "," + item.Packing : "") + (item.PieceWeight ? "," + item.PieceWeight : ""),
                                    value: item.GoodsNo
                                }
                            }));
                        }
                    });
                },
                minLength: 4,
                change: function (event, ui) {
                    //检查是否输入客户名称
                    if ($("#form1 #CustomerId").val().trim() == "0") {
                        $("#form1 #ConsignedDeliveryNo").val("");
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                        return;
                    }

                    //检查是否输入仓库
                    if ($("#form1 #Warehouse").val().trim() == "") {
                        $("#form1 #ConsignedDeliveryNo").val("");
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterWarehouse %>");
                        return;
                    }

                    //清空数据
                    $("#grid1").jqGrid("clearGridData", true);

                    //读取货物信息
                    $.get("/Common/LoadGoodsByGoodsNo", { strGoodsNo: $("#form1 #GoodsNo").val().trim() }, function (ret) {
                        if (ret != null) {
                            //填充货物表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Stock/LoadAllGoodsStocksGrid/",
                                postData: {
                                    customerId: $("#form1 #CustomerId").val().trim(),
                                    warehouse: $("#form1 #Warehouse").val().trim(),
                                    consignedDeliveryNo: $("#form1 #ConsignedDeliveryNo").val().trim(),
                                    goodsId: ret.Id
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                        }
                        else {
                            alert("<%: InnoSoft.LS.Resources.Strings.GoodsNoNotExists %>");
                            $("#form1 #GoodsNo").val("");
                            $("#form1 #GoodsNo").focus().select();
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #GoodsNo").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //创建货物表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    customerId: "",
                    warehouse: "",
                    consignedDeliveryNo: "",
                    goodsId: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Brand %>",
                    "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                    "<%: InnoSoft.LS.Resources.Labels.GrammeWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Grade %>",
                    "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.PackingSpecification %>",
                    "<%: InnoSoft.LS.Resources.Labels.Location %>",
                    "<%: InnoSoft.LS.Resources.Labels.BalancePieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.PieceWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.BalanceTunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.BalancePiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.BalanceTenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.NewLocation %>",
                    "<%: InnoSoft.LS.Resources.Labels.NewPieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.NewTunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.NewPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.NewTenThousands %>",
                    ""],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "Brand", index: "Brand", width: 80, align: "center" },
                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                    { name: "GWeight", index: "GWeight", width: 50, align: "center" },
                    { name: "Grade", index: "Grade", width: 50, align: "center" },
                    { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                    { name: "Packing", index: "Packing", width: 50, align: "center" },
                    { name: "Location", index: "Location", width: 50, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                    { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center" },
                    { name: "NewLocation", index: "NewLocation", width: 60, align: "center", editable: true },
                    { name: "NewPackages", index: "NewPackages", width: 60, align: "center", editable: true },
                    { name: "NewTunnages", index: "NewTunnages", width: 100, align: "center" },
                    { name: "NewPiles", index: "NewPiles", width: 100, align: "center", editable: true },
                    { name: "NewTenThousands", index: "NewTenThousands", width: 100, align: "center", editable: true },
                    { name: "IsCopy", index: "IsCopy", width: 100, align: "center", hidden: true}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "GoodsNo",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                height: 300,
                footerrow: true,
                userDataOnFooter: true,
                cellEdit: true,
                cellsubmit: "clientArray",
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                    //失去焦点自动保存
                    $("#" + iRow + "_" + cellname).bind("blur", function () {
                        $("#grid1").jqGrid("saveCell", iRow, iCol);
                    });
                },
                afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                    if (cellname == "NewLocation") {
                        var data = $("#grid1").jqGrid("getRowData", rowid);
                        //检查移入货位
                        if (data.Location == value) {
                            alert("<%: InnoSoft.LS.Resources.Strings.NewLocationCanNotEqualLocation %>");
                            $("#grid1").jqGrid("setRowData", rowid, { NewLocation: "" });
                        }
                    }
                    else if (cellname == "NewPackages") {
                        var data = $("#grid1").jqGrid("getRowData", rowid);
                        //检查移入件数
                        var newPackages = parseInt(value);
                        if (isNaN(newPackages)) {
                            $("#grid1").jqGrid("setRowData", rowid, { NewPackages: "0", NewTunnages: "0" });
                        }
                        else if (newPackages < 0) {
                            $("#grid1").jqGrid("setRowData", rowid, { NewPackages: "0", NewTunnages: "0" });
                        }
                        else if (newPackages > parseInt(data.Packages)) {
                            alert("<%: InnoSoft.LS.Resources.Strings.NewPackagesCanNotGreaterThanBalancePackages %>");
                            $("#grid1").jqGrid("setRowData", rowid, { NewPackages: "0", NewTunnages: "0" });
                        }
                        else {
                            //计算移入吨数
                            if (data.PieceWeight == null || data.PieceWeight == "") {
                                $("#grid1").jqGrid("setRowData", rowid, { NewTunnages: "0" });
                            }
                            else {
                                var newTunnages = mul(newPackages, parseFloat(data.PieceWeight));
                                $("#grid1").jqGrid("setRowData", rowid, { NewTunnages: Math.round(newTunnages * Math.pow(10, 6)) / Math.pow(10, 6) });
                            }
                        }
                    }
                    else if (cellname == "NewPiles") {
                        var newPiles = parseFloat(value);
                        if (isNaN(newPiles)) {
                            $("#grid1").jqGrid("setRowData", rowid, { NewPiles: "0" });
                        }
                        else if (newPiles < 0) {
                            $("#grid1").jqGrid("setRowData", rowid, { NewPiles: "0" });
                        }
                        else {
                            var data = $("#grid1").jqGrid("getRowData", rowid);
                            if (newPiles > parseFloat(data.Piles)) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NewPilesCanNotGreaterThanBalancePiles %>");
                                $("#grid1").jqGrid("setRowData", rowid, { NewPiles: "0" });
                            }
                        }
                    }
                    else if (cellname == "NewTenThousands") {
                        var newTenThousands = parseFloat(value);
                        if (isNaN(newTenThousands)) {
                            $("#grid1").jqGrid("setRowData", rowid, { NewTenThousands: "0" });
                        }
                        else if (newTenThousands < 0) {
                            $("#grid1").jqGrid("setRowData", rowid, { NewTenThousands: "0" });
                        }
                        else {
                            var data = $("#grid1").jqGrid("getRowData", rowid);
                            if (newTenThousands > parseFloat(data.TenThousands)) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NewTenThousandsCanNotGreaterThanBalanceTenThousands %>");
                                $("#grid1").jqGrid("setRowData", rowid, { NewTenThousands: "0" });
                            }
                        }
                    }

                    //刷新移入件数合计和移入吨数合计
                    var totalNewPackages = 0;
                    var totalNewTunnages = 0;
                    var totalNewPiles = 0;
                    var totalNewTenThousands = 0;
                    var rows = $("#grid1").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        totalNewPackages += parseInt(row.NewPackages);
                        totalNewTunnages = add(totalNewTunnages, parseFloat(row.NewTunnages));
                        totalNewPiles = add(totalNewPiles, parseFloat(row.NewPiles));
                        totalNewTenThousands = add(totalNewTenThousands, parseFloat(row.NewTenThousands));
                    }
                    $("#grid1").jqGrid("footerData", "set", {
                        NewPackages: totalNewPackages,
                        NewTunnages: totalNewTunnages,
                        NewPiles: totalNewPiles,
                        NewTenThousands: totalNewTenThousands
                    });
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //设置复制按钮事件
            $("#btnCopyGoods").button().click(function () {
                objMain.objWorkspace.objContent.copyGoods();
            });

            //设置删除按钮事件
            $("#btnDeleteGoods").button().click(function () {
                objMain.objWorkspace.objContent.deleteGoods();
            });

            //提交事件
            $("#form1").submit(function () {
                if ($(this).valid()) {
                    //检查货物数据
                    var footerData = $("#grid1").jqGrid("footerData");

                    var totalNewPackages = parseInt(footerData.NewPackages);
                    if (isNaN(totalNewPackages)) {
                        totalNewPackages = 0;
                    }

                    var totalNewTunnages = parseFloat(footerData.NewTunnages);
                    if (isNaN(totalNewTunnages)) {
                        totalNewTunnages = 0;
                    }

                    var totalNewPiles = parseFloat(footerData.NewPiles);
                    if (isNaN(totalNewPiles)) {
                        totalNewPiles = 0;
                    }

                    var totalNewTenThousands = parseFloat(footerData.NewTenThousands);
                    if (isNaN(totalNewTenThousands)) {
                        totalNewTenThousands = 0;
                    }

                    if (totalNewTunnages == 0 && totalNewPiles == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterNewTunnagesOrNewPiles %>");
                        return false;
                    }

                    if (totalNewTunnages > 0 && totalNewPackages == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterNewPackages %>");
                        return false;
                    }

                    if (totalNewPiles > 0 && totalNewTenThousands == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterNewTenThousands %>");
                        return false;
                    }

                    var rows = $("#grid1").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var newPackages = parseInt(row.NewPackages);
                        var newTunnages = parseFloat(row.NewTunnages);
                        var newPiles = parseFloat(row.NewPiles);
                        var newTenThousands = parseFloat(row.NewTenThousands);

                        if (newTunnages == 0 && newPiles == 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterNewTunnagesOrNewPiles %>");
                            return false;
                        }
                        if (newTunnages > 0 && newPiles > 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.NewTunnagesAndNewPilesCanNotGreaterThanZeroAtSameTime %>");
                            return false;
                        }
                        if (newTunnages > 0) {
                            if (newPackages == 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterNewPackages %>");
                                return false;
                            }
                            if (newTenThousands > 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NewTenThousandsCanNotGreaterThanZeroWhenNewTunnagesGreaterThanZero %>");
                                return false;
                            }
                        }
                        else {
                            if (newTenThousands == 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterNewTenThousands %>");
                                return false;
                            }
                            if (newPackages > 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NewPackagesCanNotGreaterThanZeroWhenNewPilesGreaterThanZero %>");
                                return false;
                            }
                        }
                    }

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

                    //生成货物JSON数据
                    var goods = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        if (row.NewLocation != "" && (parseInt(row.NewPackages) > 0 || parseFloat(row.NewPiles) > 0)) {
                            var g = {
                                "Id": "0",
                                "MoveWarehouseBillId": "0",
                                "GoodsId": row.GoodsId,
                                "GoodsNo": row.GoodsNo,
                                "GoodsName": row.GoodsName,
                                "Brand": row.Brand,
                                "SpecModel": row.SpecModel,
                                "GWeight": row.GWeight,
                                "Grade": row.Grade,
                                "PieceWeight": row.PieceWeight,
                                "Packing": row.Packing,
                                "BatchNo": row.BatchNo,
                                "Location": row.Location,
                                "Packages": row.Packages,
                                "Tunnages": row.Tunnages,
                                "Piles": row.Piles,
                                "TenThousands": row.TenThousands,
                                "ProductionDate": row.ProductionDate,
                                "EnterWarehouseBillId": row.EnterWarehouseBillId,
                                "EnterWarehouseBillNo": row.EnterWarehouseBillNo,
                                "NewLocation": row.NewLocation,
                                "NewPackages": row.NewPackages,
                                "NewTunnages": row.NewTunnages,
                                "NewPiles": row.NewPiles,
                                "NewTenThousands": row.NewTenThousands
                            };
                            goods.push(g);
                        }
                    }

                    //生成移库单JSON数据
                    var o = {
                        "Id": "0",
                        "BillNo": "",
                        "CustomerId": $("#form1 #CustomerId").val().trim(),
                        "CustomerName": $("#form1 #CustomerName").val().trim(),
                        "Warehouse": $("#form1 #Warehouse").val().trim(),
                        "ConsignedDeliveryNo": $("#form1 #ConsignedDeliveryNo").val().trim(),
                        "Remark": $("#form1 #Remark").val().trim(),
                        "Goods": goods
                    };
                    var postData = JSON.stringify(o);

                    //发送数据
                    $.ajax({
                        type: "POST",
                        url: $(this).attr("action"),
                        data: postData,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceedNextAddNew %>");
                                location.replace("/chenxk/Stock/MoveWarehouse/");
                            }
                        },
                        error: function (xhr, status, error) {
                            $.unblockUI();

                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        }
                    });
                }
                return false;
            });
        });

    </script>
</asp:Content>
