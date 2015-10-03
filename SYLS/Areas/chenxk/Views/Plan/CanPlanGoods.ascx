<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.CanPlanGoodsViewModel>" %>
<fieldset>
    <legend>
        <%: InnoSoft.LS.Resources.Tabs.GoodsInfo %></legend>
    <% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formCanPlanGoods" }))
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
        $("#formCanPlanGoods #GoodsNo").autocomplete({
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
                                label: item.GoodsNo + "," + item.Name + (item.SpecModel ? "," + item.SpecModel : ""),
                                value: item.GoodsNo
                            }
                        }));
                    }
                });
            },
            minLength: 4,
            change: function (event, ui) {
                //填充货物信息
                $("#formCanPlanGoods #GoodsId").val("0");
                $("#formCanPlanGoods #GoodsName").val("");
                $("#formCanPlanGoods #SpecModel").val("");

                //读取货物信息
                $.get("/Common/LoadGoodsByGoodsNo", { strGoodsNo: $("#formCanPlanGoods #GoodsNo").val().trim() }, function (ret) {
                    if (ret != null) {
                        $("#formCanPlanGoods #GoodsId").val(ret.Id);
                        $("#formCanPlanGoods #GoodsName").val(ret.Name);
                        $("#formCanPlanGoods #SpecModel").val(ret.SpecModel);

                        //填充选择货物表格
                        $("#grid2").jqGrid("setGridParam", {
                            url: "/chenxk/Plan/LoadCanPlanGoodsStockGrid/",
                            datatype: "json",
                            postData: {
                                customerId: $("#form1 #CustomerId").val().trim(),
                                goodsId: $("#formCanPlanGoods #GoodsId").val().trim(),
                                batchNo: "",
                                warehouse: "",
                                location: "",
                                productionDate: "",
                                enterWarehouseBillId: ""
                            },
                            gridComplete: function () {
                            }
                        });
                        $("#grid2").trigger("reloadGrid", [{ page: 1}]);
                    }
                    else {
                        alert("<%: InnoSoft.LS.Resources.Strings.GoodsNoNotExists %>");
                        $("#formCanPlanGoods #GoodsNo").val("");
                        $("#formCanPlanGoods #GoodsNo").focus().select();
                    }
                }, "text json").error(function (xhr, status, error) {
                    $("#formCanPlanGoods #GoodsNo").val("");
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            }
        });

        //设置货物信息为只读
        $("#formCanPlanGoods #GoodsName").attr("readonly", "readonly");
        $("#formCanPlanGoods #SpecModel").attr("readonly", "readonly");

        //创建货物选择表格
        $("#grid2").jqGrid({
            url: "",
            datatype: "local",
            mtype: "GET",
            postData: {
                customerId: "0",
                goodsId: "0",
                batchNo: "",
                warehouse: "",
                location: "",
                productionDate: "",
                enterWarehouseBillId: ""
            },
            colNames: [
                "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                "<%: InnoSoft.LS.Resources.Labels.Location %>",
                "<%: InnoSoft.LS.Resources.Labels.BalancePiles %>",
                "<%: InnoSoft.LS.Resources.Labels.BalanceTenThousands %>",
                "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillId %>",
                "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>",
                "<%: InnoSoft.LS.Resources.Labels.ActualPiles %>",
                "<%: InnoSoft.LS.Resources.Labels.ActualTenThousands %>"],
            colModel: [
                { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center", hidden: true },
                { name: "GoodsName", index: "GoodsName", width: 100, align: "center", hidden: true },
                { name: "SpecModel", index: "SpecModel", width: 100, align: "center", hidden: true },
                { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                { name: "Warehouse", index: "Warehouse", width: 60, align: "center" },
                { name: "Location", index: "Location", width: 50, align: "center" },
                { name: "Piles", index: "Piles", width: 80, align: "center", summaryType: myNumberSum },
                { name: "TenThousands", index: "TenThousands", width: 80, align: "center", summaryType: myNumberSum },
                { name: "ProductionDate", index: "ProductionDate", width: 80, align: "center" },
                { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center" },
                { name: "ActualPiles", index: "ActualPiles", width: 80, align: "center", editable: true },
                { name: "ActualTenThousands", index: "ActualTenThousands", width: 80, align: "center", editable: true}],
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
                if (cellname == "ActualPiles") {
                    //计算实发垛数
                    var actualPiles = parseFloat(value);
                    if (isNaN(actualPiles)) {
                        $("#grid2").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesNotValidNumeric %>");
                    }
                    else if (actualPiles < 0) {
                        $("#grid2").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesNotGreaterThanOrEqualZero %>");
                    }
                    else {
                        var row = $("#grid2").jqGrid("getRowData", rowid);
                        if (actualPiles > parseFloat(row.Piles)) {
                            $("#grid2").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesCanNotGreaterThanBalancePiles %>");
                        }
                    }
                }
                else if (cellname == "ActualTenThousands") {
                    var actualTenThousands = parseFloat(value);
                    if (isNaN(actualTenThousands)) {
                        $("#grid2").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsNotValidNumeric %>");
                    }
                    else if (actualTenThousands < 0) {
                        $("#grid2").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsNotGreaterThanOrEqualZero %>");
                    }
                    else {
                        var row = $("#grid2").jqGrid("getRowData", rowid);
                        if (actualTenThousands > parseFloat(row.TenThousands)) {
                            $("#grid2").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsCanNotGreaterThanBalanceTenThousands %>");
                        }
                    }
                }

                //合计实发垛数和实发万只
                var totalActualPiles = 0;
                var totalActualTenThousands = 0;
                var rows = $("#grid2").jqGrid("getRowData");
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    totalActualPiles = add(totalActualPiles, parseFloat(row.ActualPiles));
                    totalActualTenThousands = add(totalActualTenThousands, parseFloat(row.ActualTenThousands));
                }
                $("#grid2").jqGrid("footerData", "set", { ActualPiles: totalActualPiles, ActualTenThousands: totalActualTenThousands });
            }
        });
        $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

    });

</script>
