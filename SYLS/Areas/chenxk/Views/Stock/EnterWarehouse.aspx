<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.EnterWarehouseBillViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.EnterWarehouse %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.save();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("EnterWarehouse", "Stock", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.BasicInfo %></legend>
        <%: Html.HiddenFor(model => model.Id)%>
        <%: Html.HiddenFor(model => model.BillNo)%>
        <%: Html.HiddenFor(model => model.PlanId)%>
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
                        <%: Html.LabelFor(model => model.DeliveryNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.DeliveryNo) %>
                        <%: Html.ValidationMessageFor(model => model.DeliveryNo) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.EnterType) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.EnterType, ViewData["EnterTypes"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.EnterType) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.IsConsigning) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.IsConsigning) %>
                        <%: Html.ValidationMessageFor(model => model.IsConsigning) %>
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
                        <%: Html.LabelFor(model => model.UnloadingForceFeePrice)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.UnloadingForceFeePrice)%>
                        <%: Html.ValidationMessageFor(model => model.UnloadingForceFeePrice)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ForceFee) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ForceFee) %>
                        <%: Html.ValidationMessageFor(model => model.ForceFee) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.StorageFeePrice) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.StorageFeePrice)%>
                        <%: Html.ValidationMessageFor(model => model.StorageFeePrice)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.HasDrayage) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.HasDrayage) %>
                        <%: Html.ValidationMessageFor(model => model.HasDrayage) %>
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
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CreateTime) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CreateTime)%>
                        <%: Html.ValidationMessageFor(model => model.CreateTime)%>
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
            <button id="btnNewGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.New %>
            </button>
            <button id="btnModifyGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
            <button id="btnDeleteGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <% } %>
    <div id="dialogGoods" title="">
        <% Html.RenderPartial("EnterWarehouseBillGoods", Model.Goods[0]); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //新增货物标志
            this.isNewGoods = true;
            //当前选中货物记录编码
            this.selectedGoodsId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认客户名称获得焦点
                $("#form1 #CustomerName").focus().select();
            };
            //新增货物信息
            this.newGoods = function () {
                //检查是否输入客户名称
                if ($("#form1 #CustomerId").val().trim() == "0") {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                    return;
                }

                //检查是否输入仓库
                if ($("#form1 #Warehouse").val().trim() == "") {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterWarehouse %>");
                    return;
                }

                //设置编辑模式为新增
                this.isNewGoods = true;

                //初始化控件数据
                $("#formEnterWarehouseBillGoods #GoodsId").val("0");
                $("#formEnterWarehouseBillGoods #GoodsNo").val("");
                $("#formEnterWarehouseBillGoods #GoodsName").val("");
                $("#formEnterWarehouseBillGoods #Brand").val("");
                $("#formEnterWarehouseBillGoods #SpecModel").val("");
                $("#formEnterWarehouseBillGoods #GWeight").val("");
                $("#formEnterWarehouseBillGoods #Grade").val("");
                $("#formEnterWarehouseBillGoods #Packing").val("");
                $("#formEnterWarehouseBillGoods #BatchNo").val("");
                $("#formEnterWarehouseBillGoods #Location").val("");
                $("#formEnterWarehouseBillGoods #Packages").val("0");
                $("#formEnterWarehouseBillGoods #PieceWeight").val("0");
                $("#formEnterWarehouseBillGoods #Tunnages").val("0");
                $("#formEnterWarehouseBillGoods #Piles").val("0");
                $("#formEnterWarehouseBillGoods #TenThousands").val("0");
                $("#formEnterWarehouseBillGoods #ProductionDate").val("");
                $("#formEnterWarehouseBillGoods #ShipmentBillGoodsIds").val("");

                //打开对话框
                $("#dialogGoods").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewEnterWarehouseBillGoods %>");
                $("#dialogGoods").dialog("open");
            };
            //修改货物信息
            this.modifyGoods = function () {
                //检查是否输入客户名称
                if ($("#form1 #CustomerId").val().trim() == "0") {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                    return;
                }

                //检查是否输入仓库
                if ($("#form1 #Warehouse").val().trim() == "") {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterWarehouse %>");
                    return;
                }

                //读取选中的货物记录
                if (this.selectedGoodsId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedGoods %>");
                    return;
                }

                //设置编辑模式为修改
                this.isNewGoods = false;

                //初始化控件数据
                var data = $("#grid1").jqGrid("getRowData", this.selectedGoodsId);
                $("#formEnterWarehouseBillGoods #GoodsId").val(data.GoodsId);
                $("#formEnterWarehouseBillGoods #GoodsNo").val(data.GoodsNo);
                $("#formEnterWarehouseBillGoods #GoodsName").val(data.GoodsName);
                $("#formEnterWarehouseBillGoods #Brand").val(data.Brand);
                $("#formEnterWarehouseBillGoods #SpecModel").val(data.SpecModel);
                $("#formEnterWarehouseBillGoods #GWeight").val(data.GWeight);
                $("#formEnterWarehouseBillGoods #Grade").val(data.Grade);
                $("#formEnterWarehouseBillGoods #Packing").val(data.Packing);
                $("#formEnterWarehouseBillGoods #BatchNo").val(data.BatchNo);
                $("#formEnterWarehouseBillGoods #Location").val(data.Location);
                $("#formEnterWarehouseBillGoods #Packages").val(data.Packages);
                $("#formEnterWarehouseBillGoods #PieceWeight").val(data.PieceWeight);
                $("#formEnterWarehouseBillGoods #Tunnages").val(data.Tunnages);
                $("#formEnterWarehouseBillGoods #Piles").val(data.Piles);
                $("#formEnterWarehouseBillGoods #TenThousands").val(data.TenThousands);
                $("#formEnterWarehouseBillGoods #ProductionDate").val(data.ProductionDate);
                $("#formEnterWarehouseBillGoods #ShipmentBillGoodsIds").val(data.ShipmentBillGoodsIds);

                //打开对话框
                $("#dialogGoods").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyEnterWarehouseBillGoods %>");
                $("#dialogGoods").dialog("open");
            };
            //删除货物信息
            this.deleteGoods = function () {
                if (this.selectedGoodsId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedGoods %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteGoodsConfirm %>") == true) {
                    $("#grid1").jqGrid("delRowData", this.selectedGoodsId);

                    //重置合计数
                    var totalPackages = 0;
                    var totalTunnages = 0;
                    var totalPiles = 0;
                    var totalTenThousands = 0;
                    var rows = $("#grid1").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        totalPackages += parseInt(row.Packages);
                        totalTunnages = add(totalTunnages, parseFloat(row.Tunnages));
                        totalPiles = add(totalPiles, parseFloat(row.Piles));
                        totalTenThousands = add(totalTenThousands, parseFloat(row.TenThousands));
                    }

                    $("#grid1").jqGrid("footerData", "set", {
                        GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>",
                        Packages: totalPackages,
                        Tunnages: totalTunnages,
                        Piles: totalPiles,
                        TenThousands: totalTenThousands
                    });

                    this.selectedGoodsId = null;
                }
            };
            //保存数据
            this.save = function () {
                $("#form1").submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //1.设置客户名称自动完成
            $("#form1 #CustomerName").autocomplete({
                source: "/Autocomplete/LoadCustomerNames/",
                minLength: 1,
                change: function (event, ui) {
                    //填充客户编码、下力支费价格和仓储费价格
                    $.get("/Common/LoadCustomerByName", { strName: $("#form1 #CustomerName").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #CustomerId").val(ret.Id);
                            $("#form1 #UnloadingForceFeePrice").val(ret.UnloadingForceFeePrice);
                            $("#form1 #StorageFeePrice").val(ret.StorageFeePrice);
                        }
                        else {
                            alert("<%: InnoSoft.LS.Resources.Strings.CustomerNameNotExists %>");
                            $("#form1 #CustomerId").val("0");
                            $("#form1 #CustomerName").val("");
                            $("#form1 #CustomerName").focus().select();
                            $("#form1 #UnloadingForceFeePrice").val("0.00");
                            $("#form1 #StorageFeePrice").val("0.00");
                        }

                        //计算力支费
                        ComputeForceFee();
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #CustomerName").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //2.设置下力支费价格改变事件
            $("#form1 #UnloadingForceFeePrice").change(function () {
                //检查价格
                var unloadingForceFeePrice = parseFloat($("#form1 #UnloadingForceFeePrice").val().trim());
                if (isNaN(unloadingForceFeePrice) || unloadingForceFeePrice <= 0) {
                    $("#form1 #UnloadingForceFeePrice").val("0.00");
                }

                //计算力支费
                if ($("#form1 #EnterType").val().trim() == "<%: InnoSoft.LS.Resources.Options.DeliverInStorage %>") {
                    ComputeForceFee();
                }
            });

            //3.设置力支费改变事件
            $("#form1 #ForceFee").change(function () {
                //检查力支费
                var forceFee = parseFloat($("#form1 #ForceFee").val().trim());
                if (isNaN(forceFee) || forceFee <= 0) {
                    $("#form1 #ForceFee").val("0.00");
                }

                //计算下力支费价格
                ComputeUnloadingForceFeePrice();
            });

            //4.设置录入日期
            $("#form1 #CreateTime").datepicker($.datepicker.regional["zh-CN"]);

            //5.创建货物表格
            $("#grid1").jqGrid({
                url: "/chenxk/Stock/LoadEnterWarehouseBillAllGoodsGrid",
                datatype: "json",
                mtype: "GET",
                postData: {
                    enterWarehouseBillId: $("#form1 #Id").val().trim()
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
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.PieceWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentBillGoodsIds %>"],
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
                    { name: "ShipmentBillGoodsIds", index: "ShipmentBillGoodsIds", width: 100, align: "center", hidden: true}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                height: 300,
                footerrow: true,
                userDataOnFooter: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedGoodsId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //6.设置新增按钮事件
            $("#btnNewGoods").button().click(function () {
                objMain.objWorkspace.objContent.newGoods();
            });

            //7.设置修改按钮事件
            $("#btnModifyGoods").button().click(function () {
                objMain.objWorkspace.objContent.modifyGoods();
            });

            //8.设置删除按钮事件
            $("#btnDeleteGoods").button().click(function () {
                objMain.objWorkspace.objContent.deleteGoods();
            });

            //9.创建货物编辑对话框
            $("#dialogGoods").dialog({
                autoOpen: false,
                height: 600,
                width: 520,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formEnterWarehouseBillGoods").valid()) {
                            //检查货物数量
                            var packages = parseInt($("#formEnterWarehouseBillGoods #Packages").val().trim());
                            var tunnages = parseFloat($("#formEnterWarehouseBillGoods #Tunnages").val().trim());
                            var piles = parseFloat($("#formEnterWarehouseBillGoods #Piles").val().trim());
                            var tenThousands = parseFloat($("#formEnterWarehouseBillGoods #TenThousands").val().trim());

                            if (packages == 0 && tunnages == 0 && piles == 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTunnagesOrPiles %>");
                                return;
                            }

                            //新增货物信息
                            if (objMain.objWorkspace.objContent.isNewGoods) {
                                var rowcount = $("#grid1").jqGrid("getGridParam", "records");
                                if (rowcount == 0) {
                                    //计算件重
                                    var pieceWeight = 0;
                                    if (packages != 0) {
                                        pieceWeight = div(tunnages, packages);
                                    }

                                    //添加货物记录
                                    $("#grid1").jqGrid("addRowData", 1, {
                                        Id: "0",
                                        GoodsId: $("#formEnterWarehouseBillGoods #GoodsId").val().trim(),
                                        GoodsNo: $("#formEnterWarehouseBillGoods #GoodsNo").val().trim(),
                                        GoodsName: $("#formEnterWarehouseBillGoods #GoodsName").val().trim(),
                                        Brand: $("#formEnterWarehouseBillGoods #Brand").val().trim(),
                                        SpecModel: $("#formEnterWarehouseBillGoods #SpecModel").val().trim(),
                                        GWeight: $("#formEnterWarehouseBillGoods #GWeight").val().trim(),
                                        Grade: $("#formEnterWarehouseBillGoods #Grade").val().trim(),
                                        Packing: $("#formEnterWarehouseBillGoods #Packing").val().trim(),
                                        BatchNo: $("#formEnterWarehouseBillGoods #BatchNo").val().trim(),
                                        Location: $("#formEnterWarehouseBillGoods #Location").val().trim(),
                                        Packages: packages,
                                        PieceWeight: Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6),
                                        Tunnages: tunnages,
                                        Piles: piles,
                                        TenThousands: tenThousands,
                                        ProductionDate: $("#formEnterWarehouseBillGoods #ProductionDate").val().trim(),
                                        ShipmentBillGoodsIds: $("#formEnterWarehouseBillGoods #ShipmentBillGoodsIds").val().trim()
                                    });

                                    //重置合计数
                                    $("#grid1").jqGrid("footerData", "set", {
                                        GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>",
                                        Packages: packages,
                                        Tunnages: tunnages,
                                        Piles: piles,
                                        TenThousands: tenThousands
                                    });
                                }
                                else {
                                    //检查货物是否重复
                                    var rowids = $("#grid1").jqGrid("getDataIDs");
                                    var rows = $("#grid1").jqGrid("getRowData");
                                    var rowid = 0, row = null;
                                    var i = 0;
                                    while (i < rows.length) {
                                        rowid = rowids[i];
                                        row = rows[i];
                                        if (row.GoodsNo == $("#formEnterWarehouseBillGoods #GoodsNo").val().trim() &&
                                            row.BatchNo == $("#formEnterWarehouseBillGoods #BatchNo").val().trim() &&
                                            row.Packing == $("#formEnterWarehouseBillGoods #Packing").val().trim() &&
                                            row.ProductionDate == $("#formEnterWarehouseBillGoods #ProductionDate").val().trim() &&
                                            row.Location == $("#formEnterWarehouseBillGoods #Location").val().trim()) {
                                            break;
                                        }
                                        i++;
                                    }

                                    if (i < rows.length) {
                                        //出现重复，提示合并
                                        if (confirm("<%: InnoSoft.LS.Resources.Strings.GoodsIsExistsAndNeedMerge %>") == true) {
                                            //合并数量
                                            packages = packages + parseInt(row.Packages);
                                            tunnages = add(tunnages, parseFloat(row.Tunnages));
                                            piles = add(piles, parseFloat(row.Piles));
                                            tenThousands = add(tenThousands, parseFloat(row.TenThousands));

                                            //计算件重
                                            var pieceWeight = 0;
                                            if (packages != 0) {
                                                pieceWeight = div(tunnages, packages);
                                            }

                                            //修改货物记录
                                            $("#grid1").jqGrid("setRowData", rowid, {
                                                Packages: packages,
                                                PieceWeight: Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6),
                                                Tunnages: tunnages,
                                                Piles: piles,
                                                TenThousands: tenThousands
                                            });
                                        }
                                        else {
                                            return;
                                        }
                                    }
                                    else {
                                        //没有出现重复，则添加
                                        var rowidLast = 0;
                                        for (var i = 0; i < rowids.length; i++) {
                                            if (parseFloat(rowids[i]) > parseFloat(rowidLast)) {
                                                rowidLast = rowids[i];
                                            }
                                        }

                                        //计算件重
                                        var pieceWeight = 0;
                                        if (packages != 0) {
                                            pieceWeight = div(tunnages, packages);
                                        }

                                        //添加货物记录
                                        $("#grid1").jqGrid("addRowData", parseFloat(rowidLast) + 1, {
                                            Id: "0",
                                            GoodsId: $("#formEnterWarehouseBillGoods #GoodsId").val().trim(),
                                            GoodsNo: $("#formEnterWarehouseBillGoods #GoodsNo").val().trim(),
                                            GoodsName: $("#formEnterWarehouseBillGoods #GoodsName").val().trim(),
                                            Brand: $("#formEnterWarehouseBillGoods #Brand").val().trim(),
                                            SpecModel: $("#formEnterWarehouseBillGoods #SpecModel").val().trim(),
                                            GWeight: $("#formEnterWarehouseBillGoods #GWeight").val().trim(),
                                            Grade: $("#formEnterWarehouseBillGoods #Grade").val().trim(),
                                            Packing: $("#formEnterWarehouseBillGoods #Packing").val().trim(),
                                            BatchNo: $("#formEnterWarehouseBillGoods #BatchNo").val().trim(),
                                            Location: $("#formEnterWarehouseBillGoods #Location").val().trim(),
                                            Packages: packages,
                                            PieceWeight: Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6),
                                            Tunnages: tunnages,
                                            Piles: piles,
                                            TenThousands: tenThousands,
                                            ProductionDate: $("#formEnterWarehouseBillGoods #ProductionDate").val().trim(),
                                            ShipmentBillGoodsIds: $("#formEnterWarehouseBillGoods #ShipmentBillGoodsIds").val().trim()
                                        });
                                    }

                                    //重置合计数
                                    var totalPackages = 0;
                                    var totalTunnages = 0;
                                    var totalPiles = 0;
                                    var totalTenThousands = 0;
                                    rows = $("#grid1").jqGrid("getRowData");
                                    for (var j = 0; j < rows.length; j++) {
                                        row = rows[j];
                                        totalPackages += parseInt(row.Packages);
                                        totalTunnages = add(totalTunnages, parseFloat(row.Tunnages));
                                        totalPiles = add(totalPiles, parseFloat(row.Piles));
                                        totalTenThousands = add(totalTenThousands, parseFloat(row.TenThousands));
                                    }

                                    $("#grid1").jqGrid("footerData", "set", {
                                        GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>",
                                        Packages: totalPackages,
                                        Tunnages: totalTunnages,
                                        Piles: totalPiles,
                                        TenThousands: totalTenThousands
                                    });
                                }
                            }
                            //修改货物信息
                            else {
                                //检查货物是否重复
                                var rowids = $("#grid1").jqGrid("getDataIDs");
                                var rows = $("#grid1").jqGrid("getRowData");
                                var rowid = 0, row = null;
                                var i = 0;
                                while (i < rows.length) {
                                    rowid = rowids[i];
                                    row = rows[i];
                                    if (row.GoodsNo == $("#formEnterWarehouseBillGoods #GoodsNo").val().trim() &&
                                        row.BatchNo == $("#formEnterWarehouseBillGoods #BatchNo").val().trim() &&
                                        row.Packing == $("#formEnterWarehouseBillGoods #Packing").val().trim() &&
                                        row.ProductionDate == $("#formEnterWarehouseBillGoods #ProductionDate").val().trim() &&
                                        row.Location == $("#formEnterWarehouseBillGoods #Location").val().trim() &&
                                        rowid != objMain.objWorkspace.objContent.selectedGoodsId) {
                                        break;
                                    }
                                    i++;
                                }

                                if (i < rows.length) {
                                    //出现重复，提示合并
                                    if (confirm("<%: InnoSoft.LS.Resources.Strings.GoodsIsExistsAndNeedMerge %>") == true) {
                                        //合并货物数量
                                        packages = packages + parseInt(row.Packages);
                                        tunnages = add(tunnages, parseFloat(row.Tunnages));
                                        piles = add(piles, parseFloat(row.Piles));
                                        tenThousands = add(tenThousands, parseFloat(row.TenThousands));

                                        //合并对应划拨出仓单编码
                                        var shipmentBillGoodsIds = row.ShipmentBillGoodsIds;
                                        if (shipmentBillGoodsIds != null && shipmentBillGoodsIds != "") {
                                            shipmentBillGoodsIds += ",";
                                        }
                                        shipmentBillGoodsIds += $("#formEnterWarehouseBillGoods #ShipmentBillGoodsIds").val().trim();

                                        //计算件重
                                        var pieceWeight = 0;
                                        if (packages != 0) {
                                            pieceWeight = div(tunnages, packages);
                                        }

                                        //修改货物记录
                                        $("#grid1").jqGrid("setRowData", rowid, {
                                            Packages: packages,
                                            PieceWeight: Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6),
                                            Tunnages: tunnages,
                                            Piles: piles,
                                            TenThousands: tenThousands,
                                            ShipmentBillGoodsIds: shipmentBillGoodsIds
                                        });

                                        $("#grid1").jqGrid("delRowData", objMain.objWorkspace.objContent.selectedGoodsId);
                                    }
                                    else {
                                        return;
                                    }
                                }
                                else {
                                    //计算件重
                                    var pieceWeight = 0;
                                    if (packages != 0) {
                                        pieceWeight = div(tunnages, packages);
                                    }

                                    //修改货物记录
                                    $("#grid1").jqGrid("setRowData", objMain.objWorkspace.objContent.selectedGoodsId, {
                                        GoodsId: $("#formEnterWarehouseBillGoods #GoodsId").val().trim(),
                                        GoodsNo: $("#formEnterWarehouseBillGoods #GoodsNo").val().trim(),
                                        GoodsName: $("#formEnterWarehouseBillGoods #GoodsName").val().trim(),
                                        Brand: $("#formEnterWarehouseBillGoods #Brand").val().trim(),
                                        SpecModel: $("#formEnterWarehouseBillGoods #SpecModel").val().trim(),
                                        GWeight: $("#formEnterWarehouseBillGoods #GWeight").val().trim(),
                                        Grade: $("#formEnterWarehouseBillGoods #Grade").val().trim(),
                                        Packing: $("#formEnterWarehouseBillGoods #Packing").val().trim(),
                                        BatchNo: $("#formEnterWarehouseBillGoods #BatchNo").val().trim(),
                                        Location: $("#formEnterWarehouseBillGoods #Location").val().trim(),
                                        Packages: packages,
                                        PieceWeight: Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6),
                                        Tunnages: tunnages,
                                        Piles: piles,
                                        TenThousands: tenThousands,
                                        ProductionDate: $("#formEnterWarehouseBillGoods #ProductionDate").val().trim()
                                    });
                                }

                                //重置合计数
                                var totalPackages = 0;
                                var totalTunnages = 0;
                                var totalPiles = 0;
                                var totalTenThousands = 0;
                                rows = $("#grid1").jqGrid("getRowData");
                                for (var j = 0; j < rows.length; j++) {
                                    row = rows[j];
                                    totalPackages += parseInt(row.Packages);
                                    totalTunnages = add(totalTunnages, parseFloat(row.Tunnages));
                                    totalPiles = add(totalPiles, parseFloat(row.Piles));
                                    totalTenThousands = add(totalTenThousands, parseFloat(row.TenThousands));
                                }

                                $("#grid1").jqGrid("footerData", "set", {
                                    GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>",
                                    Packages: totalPackages,
                                    Tunnages: totalTunnages,
                                    Piles: totalPiles,
                                    TenThousands: totalTenThousands
                                });
                            }

                            //计算力支费
                            ComputeForceFee();

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

            //10.设置控件
            if ($("#form1 #Id").val().trim() == null || $("#form1 #Id").val().trim() == "" || $("#form1 #Id").val().trim() == "0") {
                //如果是新增手工入库单，则禁用下列控件

            }
            else {
                //如果是修改由划拨出库计划所产生的入库单，则禁用下列控件
                if ($("#form1 #PlanId").val().trim() != null && $("#form1 #PlanId").val().trim() != "" && $("#form1 #PlanId").val().trim() != "0") {
                    $("#form1 #CustomerName").attr("disabled", "disabled");
                    $("#form1 #DeliveryNo").attr("disabled", "disabled");
                    $("#form1 #EnterType").attr("disabled", "disabled");
                    $("#form1 #IsConsigning").attr("disabled", "disabled");
                    $("#form1 #HasDrayage").attr("disabled", "disabled");

                    $("#btnNewGoods").hide();
                    $("#btnDeleteGoods").hide();

                    $("#formEnterWarehouseBillGoods #GoodsNo").attr("readonly", "readonly");
                    $("#formEnterWarehouseBillGoods #GoodsName").attr("readonly", "readonly");
                    $("#formEnterWarehouseBillGoods #Brand").attr("readonly", "readonly");
                    $("#formEnterWarehouseBillGoods #SpecModel").attr("readonly", "readonly");
                    $("#formEnterWarehouseBillGoods #GWeight").attr("readonly", "readonly");
                    $("#formEnterWarehouseBillGoods #Grade").attr("readonly", "readonly");
                    $("#formEnterWarehouseBillGoods #Packing").attr("disabled", "disabled");
                    $("#formEnterWarehouseBillGoods #BatchNo").attr("readonly", "readonly");
                    $("#formEnterWarehouseBillGoods #PieceWeight").attr("readonly", "readonly");
                    $("#formEnterWarehouseBillGoods #ProductionDate").attr("disabled", "disabled");
                }
                else {
                    //如果是修改手工入库单，则禁用下列控件

                }
            }

            //11.如果是划拨入库，则禁用下列控件
            if ($("#form1 #EnterType").val().trim() == "<%: InnoSoft.LS.Resources.Options.AllocateInStorage %>") {
                $("#form1 #ForceFee").attr("disabled", "disabled");
            }

            //12.提交事件
            $("#form1").submit(function () {
                if ($(this).valid()) {
                    //检查录入时间
                    var createTime = $("#form1 #CreateTime").val().trim();
                    var today = formatDate(new Date(), "yyyy-MM-dd");
                    if (createTime > today) {
                        alert("<%: InnoSoft.LS.Resources.Strings.CreateTimeCantNotGreaterThanSystemTime %>");
                        return false;
                    }

                    //检查货物数据
                    var rows = $("#grid1").jqGrid("getRowData");
                    if (rows.length == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterGoods %>");
                        return false;
                    }

                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var packages = parseInt(row.Packages);
                        var tunnages = parseFloat(row.Tunnages);
                        var piles = parseFloat(row.Piles);
                        var tenThousands = parseFloat(row.TenThousands);

                        if (!(packages == 0 && tunnages == 0 && piles == 0 && tenThousands == 0)) {
                            if (tunnages == 0 && piles == 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTunnagesOrPiles %>");
                                return false;
                            }
                            if (tunnages > 0 && piles > 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.TunnagesAndPilesCanNotGreaterThanZeroAtSameTime %>");
                                return false;
                            }
                            if (piles > 0) {
                                if (tenThousands == 0) {
                                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTenThousands %>");
                                    return false;
                                }
                                if (packages > 0) {
                                    alert("<%: InnoSoft.LS.Resources.Strings.PackagesCanNotGreaterThanZeroWhenPilesGreaterThanZero %>");
                                    return false;
                                }
                            }
                            else {
                                if (tenThousands > 0) {
                                    alert("<%: InnoSoft.LS.Resources.Strings.TenThousandsCanNotGreaterThanZeroWhenTunnagesGreaterThanZero %>");
                                    return false;
                                }
                                if (packages == 0 && tunnages == 0) {
                                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterPackagesOrTunnages %>");
                                    return false;
                                }
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
                        var g = {
                            "Id": row.Id,
                            "EnterWarehouseBillId": $("#form1 #Id").val().trim(),
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
                            "ShipmentBillGoodsIds": row.ShipmentBillGoodsIds
                        };
                        goods.push(g);
                    }

                    //生成入库单JSON数据
                    var o = {
                        "Id": $("#form1 #Id").val().trim(),
                        "BillNo": $("#form1 #BillNo").val().trim(),
                        "PlanId": $("#form1 #PlanId").val().trim(),
                        "CustomerId": $("#form1 #CustomerId").val().trim(),
                        "CustomerName": $("#form1 #CustomerName").val().trim(),
                        "DeliveryNo": $("#form1 #DeliveryNo").val().trim(),
                        "EnterType": $("#form1 #EnterType").val().trim(),
                        "IsConsigning": ($("#form1 #IsConsigning").attr("checked") == "checked"),
                        "Warehouse": $("#form1 #Warehouse").val().trim(),
                        "UnloadingForceFeePrice": $("#form1 #UnloadingForceFeePrice").val().trim(),
                        "ForceFee": $("#form1 #ForceFee").val().trim(),
                        "StorageFeePrice": $("#form1 #StorageFeePrice").val().trim(),
                        "HasDrayage": ($("#form1 #HasDrayage").attr("checked") == "checked"),
                        "Remark": $("#form1 #Remark").val().trim(),
                        "CreateTime": $("#form1 #CreateTime").val().trim(),
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

                            if (ret.ErrorText != null && ret.ErrorText != "") {
                                alert(ret.ErrorText);
                            }
                            else {
                                var url = $.jStorage.get("EnterWarehouse_SaveSucceedNext", "");
                                $.jStorage.set("EnterWarehouse_SaveSucceedNext", "");

                                if (url != "") {
                                    alert("<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>" + "[" + ret.EnterWarehouseBillNo + "]" + "<%: InnoSoft.LS.Resources.Strings.SaveSucceed %>");
                                    location.replace(url);
                                }
                                else {
                                    alert("<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>" + "[" + ret.EnterWarehouseBillNo + "]" + "<%: InnoSoft.LS.Resources.Strings.SaveSucceedNextAddNew %>");
                                    location.replace("/chenxk/Stock/EnterWarehouse/");
                                }
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

        //计算力支费
        function ComputeForceFee() {
            var unloadingForceFeePrice = parseFloat($("#form1 #UnloadingForceFeePrice").val().trim());
            if (isNaN(unloadingForceFeePrice) || unloadingForceFeePrice <= 0) {
                unloadingForceFeePrice = 0;
            }

            var footerData = $("#grid1").jqGrid("footerData");

            var tunnages = parseFloat(footerData.Tunnages);
            if (isNaN(tunnages)) {
                tunnages = 0;
            }

            var piles = parseFloat(footerData.Piles);
            if (isNaN(piles)) {
                piles = 0;
            }

            var forceFee = 0;
            if (tunnages > 0) {
                forceFee = mul(tunnages, unloadingForceFeePrice);
            }
            else if (piles > 0) {
                forceFee = mul(piles, unloadingForceFeePrice);
            }

            $("#form1 #ForceFee").val(Math.round(forceFee * Math.pow(10, 2)) / Math.pow(10, 2));
        }

        //计算下力支费价格
        function ComputeUnloadingForceFeePrice() {
            var forceFee = parseFloat($("#form1 #ForceFee").val().trim());
            if (isNaN(forceFee) || forceFee <= 0) {
                forceFee = 0;
            }

            var footerData = $("#grid1").jqGrid("footerData");

            var tunnages = parseFloat(footerData.Tunnages);
            if (isNaN(tunnages)) {
                tunnages = 0;
            }

            var piles = parseFloat(footerData.Piles);
            if (isNaN(piles)) {
                piles = 0;
            }

            if (forceFee > 0 && tunnages > 0) {
                var unloadingForceFeePrice = div(forceFee, tunnages);
                $("#form1 #UnloadingForceFeePrice").val(Math.round(unloadingForceFeePrice * Math.pow(10, 2)) / Math.pow(10, 2));
            }
            else if (forceFee > 0 && piles > 0) {
                var unloadingForceFeePrice = div(forceFee, piles);
                $("#form1 #UnloadingForceFeePrice").val(Math.round(unloadingForceFeePrice * Math.pow(10, 2)) / Math.pow(10, 2));
            }
        }

    </script>
</asp:Content>
