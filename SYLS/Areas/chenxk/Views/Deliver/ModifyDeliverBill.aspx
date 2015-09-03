<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.DeliverBillViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ModifyDeliverBill %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Deliver/PrintDeliverBills/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="/chenxk/Deliver/ModifyDeliverBill/" onclick="javascript:objMain.objWorkspace.objContent.save(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.GoodsList %></legend>
        <div>
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.TransportChargesCompute %></legend>
        <% using (Html.BeginForm("", "", FormMethod.Post, new { id = "form1" }))
           { %>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TransportChargeExpression) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TransportChargeExpression)%>
                        <span class="formInfo"><a href="/Help/TransportChargeExpression/?width=350" class="jTip"
                            id="tooltipTransportChargeExpression" name="<%: InnoSoft.LS.Resources.Titles.Tooltip %>">
                            ?</a></span>
                        <%: Html.ValidationMessageFor(model => model.TransportChargeExpression)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TransportPriceExpression) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TransportPriceExpression)%>
                        <span class="formInfo"><a href="/Help/TransportPriceExpression/?width=350" class="jTip"
                            id="tooltipTransportPriceExpression" name="<%: InnoSoft.LS.Resources.Titles.Tooltip %>">
                            ?</a></span>
                        <%: Html.ValidationMessageFor(model => model.TransportPriceExpression)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.AgreementTransportPrice) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.AgreementTransportPrice)%>
                        <%: Html.ValidationMessageFor(model => model.AgreementTransportPrice)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ActualTransportPrice)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ActualTransportPrice)%>
                        <%: Html.ValidationMessageFor(model => model.ActualTransportPrice)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TransportCharges)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TransportCharges)%>
                        <%: Html.ValidationMessageFor(model => model.TransportCharges)%>
                    </div>
                </td>
            </tr>
        </table>
        <% } %>
    </fieldset>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中行件数
            this.selectedRowPackages = 0;
            //当前选中行吨数
            this.selectedRowTunnages = 0;
            //当前选中行垛数
            this.selectedRowPiles = 0;
            //当前选中行万只
            this.selectedRowTenThousands = 0;
            //调整布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:last").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //保存数据
            this.save = function (action) {
                //检查货物数据
                var rows = $("#grid1").jqGrid("getRowData");
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    var packages = parseInt(row.Packages);
                    var tunnages = parseFloat(row.Tunnages);
                    var piles = parseFloat(row.Piles);
                    var tenThousands = parseFloat(row.TenThousands);

                    if (!(packages == 0 && tunnages == 0 && piles == 0 && tenThousands == 0)) {
                        if (tunnages == 0 && piles == 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTunnagesOrPiles %>");
                            return;
                        }
                        if (tunnages > 0 && piles > 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.TunnagesAndPilesCanNotGreaterThanZeroAtSameTime %>");
                            return;
                        }
                        if (tunnages > 0) {
                            if (packages == 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterPackages %>");
                                return;
                            }
                            if (tenThousands > 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.TenThousandsCanNotGreaterThanZeroWhenTunnagesGreaterThanZero %>");
                                return;
                            }
                        }
                        else {
                            if (tenThousands == 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTenThousands %>");
                                return;
                            }
                            if (packages > 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.PackagesCanNotGreaterThanZeroWhenPilesGreaterThanZero %>");
                                return;
                            }
                        }
                    }
                }

                //保存数据
                if ($("#form1").valid()) {
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

                    //生成送货单货物JSON数据
                    var goods = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var g = {
                            "Id": row.Id,
                            "DeliverBillId": '<%: ViewData["DeliverBillId"] %>',
                            "GoodsId": row.GoodsId,
                            "GoodsName": row.GoodsName,
                            "GoodsNo": row.GoodsNo,
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
                            "EnterWarehouseBillNo": row.EnterWarehouseBillNo
                        };
                        goods.push(g);
                    }

                    //生成送货单JSON数据
                    var d = {
                        "Id": '<%: ViewData["DeliverBillId"] %>',
                        "BillNo": "",
                        "DispatchBillId": "0",
                        "PlanId": "0",
                        "CustomerId": "0",
                        "CustomerName": "",
                        "DeliveryNo": "",
                        "ReceiverName": "",
                        "ReceiverCountry": "",
                        "ReceiverProvince": "",
                        "ReceiverCity": "",
                        "ReceiverAddress": "",
                        "ReceiverContact": "",
                        "ReceiverContactTel": "",
                        "CarNo": "",
                        "TrailerNo": "",
                        "CarrierId": "0",
                        "CarrierName": "",
                        "Warehouse": "",
                        "TotalPackages": "0",
                        "TotalTunnages": "0",
                        "TotalPiles": "0",
                        "TotalTenThousands": "0",
                        "TransportChargeExpression": $("#form1 #TransportChargeExpression").val().trim(),
                        "TransportPriceExpression": $("#form1 #TransportPriceExpression").val().trim(),
                        "AgreementTransportPrice": $("#form1 #AgreementTransportPrice").val().trim(),
                        "ActualTransportPrice": $("#form1 #ActualTransportPrice").val().trim(),
                        "TransportCharges": $("#form1 #TransportCharges").val().trim(),
                        "Goods": goods
                    };
                    var postData = JSON.stringify(d);

                    //发送数据
                    $.ajax({
                        type: "POST",
                        url: action,
                        data: postData,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceed %>");

                                location.replace("/chenxk/Deliver/PrintDeliverBills/");
                            }
                        },
                        error: function (xhr, status, error) {
                            $.unblockUI();

                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        }
                    });
                }
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //1.创建送货单货物表格
            $("#grid1").jqGrid({
                url: "/chenxk/Deliver/LoadDeliverBillAllGoodsGrid",
                datatype: "json",
                mtype: "GET",
                postData: { deliverBillId: '<%: ViewData["DeliverBillId"] %>' },
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
                    "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                    "<%: InnoSoft.LS.Resources.Labels.Location %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.PieceWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.OldPieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.OldTunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.OldPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.OldTenThousands %>"],
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
                    { name: "Warehouse", index: "Warehouse", width: 80, align: "center" },
                    { name: "Location", index: "Location", width: 50, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center", editable: true },
                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center", editable: true },
                    { name: "Piles", index: "Piles", width: 100, align: "center", editable: true },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center", editable: true },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                    { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center" },
                    { name: "OldPackages", index: "OldPackages", width: 60, align: "center", hidden: true },
                    { name: "OldTunnages", index: "OldTunnages", width: 100, align: "center", hidden: true },
                    { name: "OldPiles", index: "OldPiles", width: 100, align: "center", hidden: true },
                    { name: "OldTenThousands", index: "OldTenThousands", width: 100, align: "center", hidden: true }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "GoodsNo",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                cellEdit: true,
                cellsubmit: "clientArray",
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
                    var data = $("#grid1").jqGrid("getRowData", rowid);
                    objMain.objWorkspace.objContent.selectedRowPackages = data.OldPackages;
                    objMain.objWorkspace.objContent.selectedRowTunnages = data.OldTunnages;
                    objMain.objWorkspace.objContent.selectedRowPiles = data.OldPiles;
                    objMain.objWorkspace.objContent.selectedRowTenThousands = data.OldTenThousands;
                },
                afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                    //失去焦点自动保存
                    $("#" + iRow + "_" + cellname).bind("blur", function () {
                        $("#grid1").jqGrid("saveCell", iRow, iCol);
                    });
                },
                afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                    var data = $("#grid1").jqGrid("getRowData", rowid);
                    if (cellname == "Packages") {
                        //检查件数
                        var packages = parseInt(value);
                        if (isNaN(packages)) {
                            $("#grid1").jqGrid("setRowData", rowid, { Packages: objMain.objWorkspace.objContent.selectedRowPackages, Tunnages: objMain.objWorkspace.objContent.selectedRowTunnages });
                            alert("<%: InnoSoft.LS.Resources.Strings.PackagesNotValidNumeric %>");
                        }
                        else if (packages < 0) {
                            $("#grid1").jqGrid("setRowData", rowid, { Packages: objMain.objWorkspace.objContent.selectedRowPackages, Tunnages: objMain.objWorkspace.objContent.selectedRowTunnages });
                            alert("<%: InnoSoft.LS.Resources.Strings.PackagesNotGreaterThanOrEqualZero %>");
                        }
                        else {
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
                            //检查库存
                            $.get("/Common/LoadGoodsStocks", { customerId: '<%: ViewData["CustomerId"] %>', goodsId: data.GoodsId, batchNo: data.BatchNo, packing: data.Packing, warehouse: data.Warehouse, location: data.Location, productionDate: data.ProductionDate, enterWarehouseBillId: data.EnterWarehouseBillId, consignedDeliveryNo: '<%: ViewData["ConsignedDeliveryNo"] %>' }, function (ret) {
                                $.unblockUI();

                                var stockPackages = parseInt(objMain.objWorkspace.objContent.selectedRowPackages);
                                var stockTunnages = parseFloat(objMain.objWorkspace.objContent.selectedRowTunnages);
                                $.each(ret, function (i, stock) {
                                    stockPackages = add(stockPackages, stock.Packages);
                                    stockTunnages = add(stockTunnages, stock.Tunnages);
                                });
                                if (packages > stockPackages) {
                                    $("#grid1").jqGrid("setRowData", rowid, { Packages: objMain.objWorkspace.objContent.selectedRowPackages, Tunnages: objMain.objWorkspace.objContent.selectedRowTunnages });
                                    alert("<%: InnoSoft.LS.Resources.Strings.EnterPackagesGreaterThanStocks %>");
                                }
                                else {
                                    //计算实发吨数
                                    if (data.PieceWeight == null || data.PieceWeight == "") {
                                        $("#grid1").jqGrid("setRowData", rowid, { Tunnages: objMain.objWorkspace.objContent.selectedRowTunnages });
                                    }
                                    else {
                                        var tunnages = mul(packages, parseFloat(data.PieceWeight));
                                        if (tunnages > stockTunnages) {
                                            if (confirm("<%: InnoSoft.LS.Resources.Strings.EnterTunnagesGreaterThanStocksConfirm %>") == true) {
                                                $("#grid1").jqGrid("setRowData", rowid, { Tunnages: Math.round(tunnages * Math.pow(10, 6)) / Math.pow(10, 6) });
                                            }
                                            else {
                                                $("#grid1").jqGrid("setRowData", rowid, { Tunnages: objMain.objWorkspace.objContent.selectedRowTunnages });
                                            }
                                        }
                                        else {
                                            $("#grid1").jqGrid("setRowData", rowid, { Tunnages: Math.round(tunnages * Math.pow(10, 6)) / Math.pow(10, 6) });
                                        }
                                    }
                                    //计算运费
                                    ComputeTransportCharges();
                                }
                            }, "text json").error(function (xhr, status, error) {
                                $.unblockUI();
                                $("#grid1").jqGrid("setRowData", rowid, { Packages: objMain.objWorkspace.objContent.selectedRowPackages, Tunnages: objMain.objWorkspace.objContent.selectedRowTunnages });
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "")
                                    alert(xhr.responseText);
                            });
                        }
                    }
                    else if (cellname == "Tunnages") {
                        //检查吨数
                        var tunnages = parseFloat(value);
                        if (isNaN(tunnages)) {
                            $("#grid1").jqGrid("setRowData", rowid, { Packages: objMain.objWorkspace.objContent.selectedRowPackages, Tunnages: objMain.objWorkspace.objContent.selectedRowTunnages });
                            alert("<%: InnoSoft.LS.Resources.Strings.TunnagesNotValidNumeric %>");
                        }
                        else if (tunnages < 0) {
                            $("#grid1").jqGrid("setRowData", rowid, { Packages: objMain.objWorkspace.objContent.selectedRowPackages, Tunnages: objMain.objWorkspace.objContent.selectedRowTunnages });
                            alert("<%: InnoSoft.LS.Resources.Strings.TunnagesNotGreaterThanOrEqualZero %>");
                        }
                        else {
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
                            //检查库存
                            $.get("/Common/LoadGoodsStocks", { customerId: '<%: ViewData["CustomerId"] %>', goodsId: data.GoodsId, batchNo: data.BatchNo, packing: data.Packing, warehouse: data.Warehouse, location: data.Location, productionDate: data.ProductionDate, enterWarehouseBillId: data.EnterWarehouseBillId, consignedDeliveryNo: '<%: ViewData["ConsignedDeliveryNo"] %>' }, function (ret) {
                                $.unblockUI();

                                var stockTunnages = parseFloat(objMain.objWorkspace.objContent.selectedRowTunnages);
                                $.each(ret, function (i, stock) {
                                    stockTunnages = add(stockTunnages, stock.Tunnages);
                                });
                                if (tunnages > stockTunnages) {
                                    if (confirm("<%: InnoSoft.LS.Resources.Strings.EnterTunnagesGreaterThanStocksConfirm %>") == true) {
                                        //计算件重
                                        var packages = 0;
                                        if (data.Packages != null && data.Packages != "") {
                                            packages = parseInt(data.Packages);
                                        }
                                        if (isNaN(packages) || packages == 0) {
                                            $("#grid1").jqGrid("setRowData", rowid, { Packages: objMain.objWorkspace.objContent.selectedRowPackages, Tunnages: objMain.objWorkspace.objContent.selectedRowTunnages });
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterPackages %>");
                                        }
                                        else {
                                            var pieceWeight = div(tunnages, packages);
                                            $("#grid1").jqGrid("setRowData", rowid, { PieceWeight: Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6) });
                                        }
                                        //计算运费
                                        ComputeTransportCharges();
                                    }
                                    else {
                                        $("#grid1").jqGrid("setRowData", rowid, { Packages: objMain.objWorkspace.objContent.selectedRowPackages, Tunnages: objMain.objWorkspace.objContent.selectedRowTunnages });
                                    }
                                }
                                else {
                                    //计算件重
                                    var packages = 0;
                                    if (data.Packages != null && data.Packages != "") {
                                        packages = parseInt(data.Packages);
                                    }
                                    if (isNaN(packages) || packages == 0) {
                                        $("#grid1").jqGrid("setRowData", rowid, { Packages: objMain.objWorkspace.objContent.selectedRowPackages, Tunnages: objMain.objWorkspace.objContent.selectedRowTunnages });
                                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterPackages %>");
                                    }
                                    else {
                                        var pieceWeight = div(tunnages, packages);
                                        $("#grid1").jqGrid("setRowData", rowid, { PieceWeight: Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6) });
                                    }
                                    //计算运费
                                    ComputeTransportCharges();
                                }
                            }, "text json").error(function (xhr, status, error) {
                                $.unblockUI();
                                $("#grid1").jqGrid("setRowData", rowid, { Packages: objMain.objWorkspace.objContent.selectedRowPackages, Tunnages: objMain.objWorkspace.objContent.selectedRowTunnages });
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "")
                                    alert(xhr.responseText);
                            });
                        }
                    }
                    else if (cellname == "Piles") {
                        //检查垛数
                        var piles = parseFloat(value);
                        if (isNaN(piles)) {
                            $("#grid1").jqGrid("setRowData", rowid, { Piles: objMain.objWorkspace.objContent.selectedRowPiles });
                            alert("<%: InnoSoft.LS.Resources.Strings.PilesNotValidNumeric %>");
                        }
                        else if (piles < 0) {
                            $("#grid1").jqGrid("setRowData", rowid, { Piles: objMain.objWorkspace.objContent.selectedRowPiles });
                            alert("<%: InnoSoft.LS.Resources.Strings.PilesNotGreaterThanOrEqualZero %>");
                        }
                        else {
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
                            //检查库存
                            $.get("/Common/LoadGoodsStocks", { customerId: '<%: ViewData["CustomerId"] %>', goodsId: data.GoodsId, batchNo: data.BatchNo, packing: data.Packing, warehouse: data.Warehouse, location: data.Location, productionDate: data.ProductionDate, enterWarehouseBillId: data.EnterWarehouseBillId, consignedDeliveryNo: '<%: ViewData["ConsignedDeliveryNo"] %>' }, function (ret) {
                                $.unblockUI();

                                var stockPiles = parseFloat(objMain.objWorkspace.objContent.selectedRowPiles);
                                $.each(ret, function (i, stock) {
                                    stockPiles = add(stockPiles, stock.Piles);
                                });
                                if (piles > stockPiles) {
                                    $("#grid1").jqGrid("setRowData", rowid, { Piles: objMain.objWorkspace.objContent.selectedRowPiles });
                                    alert("<%: InnoSoft.LS.Resources.Strings.EnterPilesGreaterThanStocks %>");
                                }
                                else {
                                    //计算运费
                                    ComputeTransportCharges();
                                }
                            }, "text json").error(function (xhr, status, error) {
                                $.unblockUI();
                                $("#grid1").jqGrid("setRowData", rowid, { Piles: objMain.objWorkspace.objContent.selectedRowPiles });
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "")
                                    alert(xhr.responseText);
                            });
                        }
                    }
                    else if (cellname == "TenThousands") {
                        //检查万只
                        var tenThousands = parseFloat(value);
                        if (isNaN(tenThousands)) {
                            $("#grid1").jqGrid("setRowData", rowid, { TenThousands: objMain.objWorkspace.objContent.selectedRowTenThousands });
                            alert("<%: InnoSoft.LS.Resources.Strings.TenThousandsNotValidNumeric %>");
                        }
                        else if (tenThousands < 0) {
                            $("#grid1").jqGrid("setRowData", rowid, { TenThousands: objMain.objWorkspace.objContent.selectedRowTenThousands });
                            alert("<%: InnoSoft.LS.Resources.Strings.TenThousandsNotGreaterThanOrEqualZero %>");
                        }
                        else {
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
                            //检查库存
                            $.get("/Common/LoadGoodsStocks", { customerId: '<%: ViewData["CustomerId"] %>', goodsId: data.GoodsId, batchNo: data.BatchNo, packing: data.Packing, warehouse: data.Warehouse, location: data.Location, productionDate: data.ProductionDate, enterWarehouseBillId: data.EnterWarehouseBillId, consignedDeliveryNo: '<%: ViewData["ConsignedDeliveryNo"] %>' }, function (ret) {
                                $.unblockUI();

                                var stockTenThousands = parseFloat(objMain.objWorkspace.objContent.selectedRowTenThousands);
                                $.each(ret, function (i, stock) {
                                    stockTenThousands = add(stockTenThousands, stock.TenThousands);
                                });
                                if (tenThousands > stockTenThousands) {
                                    $("#grid1").jqGrid("setRowData", rowid, { TenThousands: objMain.objWorkspace.objContent.selectedRowTenThousands });
                                    alert("<%: InnoSoft.LS.Resources.Strings.EnterTenThousandsGreaterThanStocks %>");
                                }
                                else {
                                    //计算运费
                                    ComputeTransportCharges();
                                }
                            }, "text json").error(function (xhr, status, error) {
                                $.unblockUI();
                                $("#grid1").jqGrid("setRowData", rowid, { TenThousands: objMain.objWorkspace.objContent.selectedRowTenThousands });
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "")
                                    alert(xhr.responseText);
                            });
                        }
                    }
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //2.设置运费控件为只读
            $("#form1 #TransportChargeExpression").attr("disabled", "disabled");
            $("#form1 #TransportPriceExpression").attr("disabled", "disabled");
            $("#form1 #AgreementTransportPrice").attr("disabled", "disabled");
            $("#form1 #ActualTransportPrice").attr("disabled", "disabled");
            $("#form1 #TransportCharges").attr("disabled", "disabled");

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //3.判断当前发货计划是否为客户自提
            $.get("/Common/LoadDeliverPlan", { nPlanId: '<%: ViewData["PlanId"] %>' }, function (ret) {
                if (ret != null) {
                    if (ret.ReceiveType == "<%: InnoSoft.LS.Resources.Options.PickUpSelf %>") {
                        $("fieldset:last > legend").text("<%: InnoSoft.LS.Resources.Tabs.TransportChargesComputePickUpSelf %>");
                    }
                }
            }, "text json").error(function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //计算运费
        function ComputeTransportCharges() {
            //刷新合计数
            var totalPackages = 0;
            var totalTunnages = 0;
            var totalPiles = 0;
            var totalTenThousands = 0;
            var rows = $("#grid1").jqGrid("getRowData");
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                totalPackages = add(totalPackages, parseInt(row.Packages));
                totalTunnages = add(totalTunnages, parseFloat(row.Tunnages));
                totalPiles = add(totalPiles, parseFloat(row.Piles));
                totalTenThousands = add(totalTenThousands, parseFloat(row.TenThousands));
            }
            $("#grid1").jqGrid("footerData", "set", { Packages: totalPackages, Tunnages: totalTunnages, Piles: totalPiles, TenThousands: totalTenThousands });


            try {
                var exp = new Expression("");
                exp.Expression($("#form1 #TransportChargeExpression").val().trim());

                //添加公里数变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.KM %>", 0);

                //添加吨数变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Tunnages %>", totalTunnages);

                //添加垛数变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Piles %>", totalPiles);

                //添加单价变量
                var actualTransportPrice = parseFloat($("#form1 #ActualTransportPrice").val().trim());
                if (isNaN(actualTransportPrice) || actualTransportPrice <= 0) {
                    actualTransportPrice = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportPrice %>", actualTransportPrice);

                //添加运费变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportCharges %>", 0);

                //计算结果
                var ret = exp.Evaluate();
                if (isNaN(ret)) {
                    $("#form1 #TransportCharges").val("0.00");
                }
                else {
                    $("#form1 #TransportCharges").val(Math.round(ret * Math.pow(10, 2)) / Math.pow(10, 2));
                }
            }
            catch (e) {
                $("#form1 #TransportCharges").val("0.00");
            }
        }

    </script>
</asp:Content>
