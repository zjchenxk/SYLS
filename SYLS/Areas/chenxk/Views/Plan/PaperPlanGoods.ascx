﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.PaperPlanGoodsViewModel>" %>
<fieldset>
    <legend>
        <%: InnoSoft.LS.Resources.Tabs.GoodsInfo %></legend>
    <% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formPaperPlanGoods" }))
       { %>
    <%: Html.HiddenFor(model => model.GoodsId) %>
    <table>
        <tr>
            <td>
                <div class="editor-label-right">
                    <%: Html.LabelFor(model => model.GoodsNo) %>
                </div>
            </td>
            <td>
                <div class="editor-field">
                    <%: Html.EditorFor(model => model.GoodsNo) %>
                    <%: Html.ValidationMessageFor(model => model.GoodsNo) %>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="editor-label-right">
                    <%: Html.LabelFor(model => model.GoodsName) %>
                </div>
            </td>
            <td>
                <div class="editor-field">
                    <%: Html.EditorFor(model => model.GoodsName) %>
                    <%: Html.ValidationMessageFor(model => model.GoodsName) %>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="editor-label-right">
                    <%: Html.LabelFor(model => model.Brand) %>
                </div>
            </td>
            <td>
                <div class="editor-field">
                    <%: Html.EditorFor(model => model.Brand) %>
                    <%: Html.ValidationMessageFor(model => model.Brand) %>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="editor-label-right">
                    <%: Html.LabelFor(model => model.SpecModel) %>
                </div>
            </td>
            <td>
                <div class="editor-field">
                    <%: Html.EditorFor(model => model.SpecModel) %>
                    <%: Html.ValidationMessageFor(model => model.SpecModel) %>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="editor-label-right">
                    <%: Html.LabelFor(model => model.GWeight) %>
                </div>
            </td>
            <td>
                <div class="editor-field">
                    <%: Html.EditorFor(model => model.GWeight) %>
                    <%: Html.ValidationMessageFor(model => model.GWeight) %>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="editor-label-right">
                    <%: Html.LabelFor(model => model.Grade) %>
                </div>
            </td>
            <td>
                <div class="editor-field">
                    <%: Html.EditorFor(model => model.Grade) %>
                    <%: Html.ValidationMessageFor(model => model.Grade) %>
                </div>
            </td>
        </tr>
    </table>
    <% } %>
</fieldset>
<fieldset>
    <legend>
        <%: InnoSoft.LS.Resources.Tabs.StocksList %></legend>
    <div>
        <table id="grid2">
        </table>
        <div id="pager2">
        </div>
    </div>
</fieldset>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置货物编号自动完成
        $("#formPaperPlanGoods #GoodsNo").autocomplete({
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
                //填充货物信息
                $("#formPaperPlanGoods #GoodsId").val("0");
                $("#formPaperPlanGoods #GoodsName").val("");
                $("#formPaperPlanGoods #Brand").val("");
                $("#formPaperPlanGoods #SpecModel").val("");
                $("#formPaperPlanGoods #GWeight").val("");
                $("#formPaperPlanGoods #Grade").val("");

                //读取货物信息
                $.get("/Common/LoadGoodsByGoodsNo", { strGoodsNo: $("#formPaperPlanGoods #GoodsNo").val().trim() }, function (ret) {
                    if (ret != null) {
                        $("#formPaperPlanGoods #GoodsId").val(ret.Id);
                        $("#formPaperPlanGoods #GoodsName").val(ret.Name);
                        $("#formPaperPlanGoods #Brand").val(ret.Brand);
                        $("#formPaperPlanGoods #SpecModel").val(ret.SpecModel);
                        $("#formPaperPlanGoods #GWeight").val(ret.GWeight);
                        $("#formPaperPlanGoods #Grade").val(ret.Grade);

                        //填充选择货物表格
                        $("#grid2").jqGrid("setGridParam", {
                            url: "/chenxk/Plan/LoadPaperPlanGoodsStockGrid/",
                            datatype: "json",
                            postData: {
                                customerId: $("#form1 #CustomerId").val().trim(),
                                goodsId: $("#formPaperPlanGoods #GoodsId").val().trim(),
                                batchNo: "",
                                packing: "",
                                warehouse: "",
                                location: "",
                                productionDate: "",
                                enterWarehouseBillId: "",
                                consignedDeliveryNo: $("#form1 #ConsignedDeliveryNo").val().trim()
                            },
                            gridComplete: function () {
                            }
                        });
                        $("#grid2").trigger("reloadGrid", [{ page: 1}]);
                    }
                    else {
                        alert("<%: InnoSoft.LS.Resources.Strings.GoodsNoNotExists %>");
                        $("#formPaperPlanGoods #GoodsNo").val("");
                        $("#formPaperPlanGoods #GoodsNo").focus().select();
                    }
                }, "text json").error(function (xhr, status, error) {
                    $("#formPaperPlanGoods #GoodsNo").val("");
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            }
        });

        //设置货物信息为只读
        $("#formPaperPlanGoods #GoodsName").attr("readonly", "readonly");
        $("#formPaperPlanGoods #Brand").attr("readonly", "readonly");
        $("#formPaperPlanGoods #SpecModel").attr("readonly", "readonly");
        $("#formPaperPlanGoods #GWeight").attr("readonly", "readonly");
        $("#formPaperPlanGoods #Grade").attr("readonly", "readonly");

        //创建货物选择表格
        $("#grid2").jqGrid({
            url: "",
            datatype: "local",
            mtype: "GET",
            postData: {
                customerId: "0",
                goodsId: "0",
                batchNo: "",
                packing: "",
                warehouse: "",
                location: "",
                productionDate: "",
                enterWarehouseBillId: "",
                consignedDeliveryNo: ""
            },
            colNames: [
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
                "<%: InnoSoft.LS.Resources.Labels.BalancePieces %>",
                "<%: InnoSoft.LS.Resources.Labels.PieceWeight %>",
                "<%: InnoSoft.LS.Resources.Labels.BalanceTunnages %>",
                "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillId %>",
                "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>",
                "<%: InnoSoft.LS.Resources.Labels.ActualPieces %>",
                "<%: InnoSoft.LS.Resources.Labels.ActualTunnages %>"],
            colModel: [
                { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center", hidden: true },
                { name: "GoodsName", index: "GoodsName", width: 100, align: "center", hidden: true },
                { name: "Brand", index: "Brand", width: 80, align: "center", hidden: true },
                { name: "SpecModel", index: "SpecModel", width: 100, align: "center", hidden: true },
                { name: "GWeight", index: "GWeight", width: 50, align: "center", hidden: true },
                { name: "Grade", index: "Grade", width: 50, align: "center", hidden: true },
                { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                { name: "Packing", index: "Packing", width: 50, align: "center" },
                { name: "Warehouse", index: "Warehouse", width: 60, align: "center" },
                { name: "Location", index: "Location", width: 50, align: "center" },
                { name: "Packages", index: "Packages", width: 60, align: "center", summaryType: "sum" },
                { name: "PieceWeight", index: "PieceWeight", width: 80, align: "center" },
                { name: "Tunnages", index: "Tunnages", width: 80, align: "center", summaryType: myNumberSum },
                { name: "ProductionDate", index: "ProductionDate", width: 80, align: "center" },
                { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center" },
                { name: "ActualPackages", index: "ActualPackages", width: 60, align: "center", editable: true },
                { name: "ActualTunnages", index: "ActualTunnages", width: 80, align: "center", editable: true}],
            rowNum: 500,
            rowList: [50, 100, 500, 1000, 5000],
            sortname: "",
            sortorder: "asc",
            pager: "#pager2",
            viewrecords: true,
            emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
            shrinkToFit: false,
            height: 300,
            footerrow: true,
            userDataOnFooter: true,
            cellEdit: true,
            cellsubmit: "clientArray",
            grouping: true,
            groupingView: {
                groupField: ["Warehouse"],
                groupSummary: [true],
                groupColumnShow: [true],
                groupText: ["<b>{0}</b>"],
                groupCollapse: false,
                groupOrder: ["asc"]
            },
            loadError: function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            },
            afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                //失去焦点自动保存
                $("#" + iRow + "_" + cellname).bind("blur", function () {
                    $("#grid2").jqGrid("saveCell", iRow, iCol);
                });
            },
            afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                if (cellname == "ActualPackages") {
                    //计算实发吨数
                    var actualPackages = parseInt(value);
                    if (isNaN(actualPackages)) {
                        $("#grid2").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotValidNumeric %>");
                    }
                    else if (actualPackages < 0) {
                        $("#grid2").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotGreaterThanOrEqualZero %>");
                    }
                    else {
                        var row = $("#grid2").jqGrid("getRowData", rowid);
                        if (actualPackages > parseInt(row.Packages)) {
                            $("#grid2").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesCanNotGreaterThanBalancePackages %>");
                        }
                        else {
                            if (row.PieceWeight == null || row.PieceWeight == "") {
                                $("#grid2").jqGrid("setRowData", rowid, { ActualTunnages: "0" });
                            }
                            else {
                                var actualTunnages = mul(actualPackages, parseFloat(row.PieceWeight));
                                $("#grid2").jqGrid("setRowData", rowid, { ActualTunnages: Math.round(actualTunnages * Math.pow(10, 6)) / Math.pow(10, 6) });
                            }
                        }
                    }
                }
                else if (cellname == "ActualTunnages") {
                    var actualTunnages = parseFloat(value);
                    if (isNaN(actualTunnages)) {
                        $("#grid2").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotValidNumeric %>");
                    }
                    else if (actualTunnages < 0) {
                        $("#grid2").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotGreaterThanOrEqualZero %>");
                    }
                    else {
                        //检查件数
                        var row = $("#grid2").jqGrid("getRowData", rowid);
                        var actualPackages = 0;
                        if (row.ActualPackages != null && row.ActualPackages != "") {
                            actualPackages = parseInt(row.ActualPackages);
                        }
                        if (actualPackages < 0) {
                            $("#grid2").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotGreaterThanOrEqualZero %>");
                        }
                    }
                }

                //合计实发件数和实发吨数
                var totalActualPackages = 0;
                var totalActualTunnages = 0;
                var rows = $("#grid2").jqGrid("getRowData");
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    totalActualPackages = add(totalActualPackages, parseInt(row.ActualPackages));
                    totalActualTunnages = add(totalActualTunnages, parseFloat(row.ActualTunnages));
                }
                $("#grid2").jqGrid("footerData", "set", { ActualPackages: totalActualPackages, ActualTunnages: totalActualTunnages });
            }
        });
        $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

    });

</script>
