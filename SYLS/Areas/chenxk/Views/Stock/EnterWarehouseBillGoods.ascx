<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.EnterWarehouseBillGoodsViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formEnterWarehouseBillGoods" }))
   { %>
<%: Html.HiddenFor(model => model.GoodsId) %>
<%: Html.HiddenFor(model => model.ShipmentBillGoodsIds) %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.GoodsNo) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.GoodsNo) %><br />
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
                <%: Html.EditorFor(model => model.GoodsName) %><br />
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
                <%: Html.EditorFor(model => model.Brand) %><br />
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
                <%: Html.EditorFor(model => model.SpecModel) %><br />
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
                <%: Html.EditorFor(model => model.GWeight) %><br />
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
                <%: Html.EditorFor(model => model.Grade) %><br />
                <%: Html.ValidationMessageFor(model => model.Grade) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.Packing) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.Packing, new SelectListItem[] { new SelectListItem { Text = string.Empty, Value = string.Empty }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.HaveReam, Value = InnoSoft.LS.Resources.Options.HaveReam }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.NoReam, Value = InnoSoft.LS.Resources.Options.NoReam } }, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.Packing) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.BatchNo) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.BatchNo)%><br />
                <%: Html.ValidationMessageFor(model => model.BatchNo) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.Location) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Location) %><br />
                <%: Html.ValidationMessageFor(model => model.Location) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.Packages) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Packages) %><br />
                <%: Html.ValidationMessageFor(model => model.Packages) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.PieceWeight) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.PieceWeight) %><br />
                <%: Html.ValidationMessageFor(model => model.PieceWeight) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.Tunnages) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Tunnages) %><br />
                <%: Html.ValidationMessageFor(model => model.Tunnages) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.Piles) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Piles)%><br />
                <%: Html.ValidationMessageFor(model => model.Piles)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.TenThousands) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.TenThousands)%><br />
                <%: Html.ValidationMessageFor(model => model.TenThousands)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.ProductionDate) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.ProductionDate) %><br />
                <%: Html.ValidationMessageFor(model => model.ProductionDate) %>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置货物编号自动完成
        $("#formEnterWarehouseBillGoods #GoodsNo").autocomplete({
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
                $("#formEnterWarehouseBillGoods #GoodsId").val("0");
                $("#formEnterWarehouseBillGoods #GoodsName").val("");
                $("#formEnterWarehouseBillGoods #Brand").val("");
                $("#formEnterWarehouseBillGoods #SpecModel").val("");
                $("#formEnterWarehouseBillGoods #GWeight").val("");
                $("#formEnterWarehouseBillGoods #Grade").val("");
                $("#formEnterWarehouseBillGoods #Packing").get(0).selectedIndex = 0;
                $("#formEnterWarehouseBillGoods #PieceWeight").val("0");
                $("#formEnterWarehouseBillGoods #BatchNo").val("");

                $.get("/Common/LoadGoodsByGoodsNo", { strGoodsNo: $("#formEnterWarehouseBillGoods #GoodsNo").val().trim() }, function (ret) {
                    if (ret != null) {
                        $("#formEnterWarehouseBillGoods #GoodsId").val(ret.Id);
                        $("#formEnterWarehouseBillGoods #GoodsName").val(ret.Name);
                        $("#formEnterWarehouseBillGoods #Brand").val(ret.Brand);
                        $("#formEnterWarehouseBillGoods #SpecModel").val(ret.SpecModel);
                        $("#formEnterWarehouseBillGoods #GWeight").val(ret.GWeight);
                        $("#formEnterWarehouseBillGoods #Grade").val(ret.Grade);

                        var packings = $("#formEnterWarehouseBillGoods #Packing option").length;
                        for (var i = 0; i < packings; i++) {
                            if ($("#formEnterWarehouseBillGoods #Packing").get(0).options[i].text == ret.Packing) {
                                $("#formEnterWarehouseBillGoods #Packing").get(0).selectedIndex = i;
                                break;
                            }
                        }

                        if (ret.PieceWeight != null && ret.PieceWeight != "") {
                            $("#formEnterWarehouseBillGoods #PieceWeight").val(ret.PieceWeight);
                        }
                        else {
                            $("#formEnterWarehouseBillGoods #PieceWeight").val("0");
                        }
                    }
                    else {
                        if (confirm("<%: InnoSoft.LS.Resources.Strings.GoodsNoNotExistsAndNeedCreate %>") == true) {
                            $("#formEnterWarehouseBillGoods #GoodsName").focus().select();
                        }
                        else {
                            $("#formEnterWarehouseBillGoods #GoodsNo").val("");
                            $("#formEnterWarehouseBillGoods #GoodsNo").focus().select();
                        }
                    }
                }, "text json").error(function (xhr, status, error) {
                    $("#formEnterWarehouseBillGoods #GoodsNo").val("");
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            }
        });

        //设置件数改变事件
        $("#formEnterWarehouseBillGoods #Packages").unbind("change");
        $("#formEnterWarehouseBillGoods #Packages").change(function () {
            //检查货物编号
            var goodsNo = $("#formEnterWarehouseBillGoods #GoodsNo").val().trim();
            if (goodsNo == "") {
                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterGoodsNo %>");
                $("#formEnterWarehouseBillGoods #Packages").val("");
                $("#formEnterWarehouseBillGoods #Tunnages").val("");
                $("#formEnterWarehouseBillGoods #GoodsNo").focus().select();
                return;
            }

            //检查批次号
            var batchNo = $("#formEnterWarehouseBillGoods #BatchNo").val().trim();
            if (batchNo == "") {
                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterBatchNo %>");
                $("#formEnterWarehouseBillGoods #Packages").val("");
                $("#formEnterWarehouseBillGoods #Tunnages").val("");
                $("#formEnterWarehouseBillGoods #BatchNo").focus();
                return;
            }

            //检查件数
            var packages = parseInt($("#formEnterWarehouseBillGoods #Packages").val().trim());
            if (isNaN(packages) || packages < 0) {
                $("#formEnterWarehouseBillGoods #Packages").val("");
                $("#formEnterWarehouseBillGoods #Tunnages").val("");
                $("#formEnterWarehouseBillGoods #Packages").focus().select();
                return;
            }

            //计算重量
            if ($("#formEnterWarehouseBillGoods #PieceWeight").val().trim() != null && $("#formEnterWarehouseBillGoods #PieceWeight").val().trim() != "") {
                var tunnages = mul(packages, $("#formEnterWarehouseBillGoods #PieceWeight").val().trim());
                $("#formEnterWarehouseBillGoods #Tunnages").val(Math.round(tunnages * Math.pow(10, 6)) / Math.pow(10, 6));
            }
        });

        //设置件重改变事件
        $("#formEnterWarehouseBillGoods #PieceWeight").unbind("change");
        $("#formEnterWarehouseBillGoods #PieceWeight").change(function () {
            //检查货物编号
            var goodsNo = $("#formEnterWarehouseBillGoods #GoodsNo").val().trim();
            if (goodsNo == "") {
                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterGoodsNo %>");
                $("#formEnterWarehouseBillGoods #PieceWeight").val("");
                $("#formEnterWarehouseBillGoods #Tunnages").val("");
                $("#formEnterWarehouseBillGoods #GoodsNo").focus().select();
                return;
            }

            //检查批次号
            var batchNo = $("#formEnterWarehouseBillGoods #BatchNo").val().trim();
            if (batchNo == "") {
                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterBatchNo %>");
                $("#formEnterWarehouseBillGoods #PieceWeight").val("");
                $("#formEnterWarehouseBillGoods #Tunnages").val("");
                $("#formEnterWarehouseBillGoods #BatchNo").focus();
                return;
            }

            //检查件数
            var packages = parseInt($("#formEnterWarehouseBillGoods #Packages").val().trim());
            if (isNaN(packages) || packages < 0) {
                $("#formEnterWarehouseBillGoods #PieceWeight").val("");
                $("#formEnterWarehouseBillGoods #Tunnages").val("");
                $("#formEnterWarehouseBillGoods #Packages").val("");
                $("#formEnterWarehouseBillGoods #Packages").focus().select();
                return;
            }

            //检查件重
            var pieceWeight = parseFloat($("#formEnterWarehouseBillGoods #PieceWeight").val().trim());
            if (isNaN(pieceWeight) || pieceWeight < 0) {
                $("#formEnterWarehouseBillGoods #Tunnages").val("");
                $("#formEnterWarehouseBillGoods #PieceWeight").val("");
                $("#formEnterWarehouseBillGoods #PieceWeight").focus().select();
                return;
            }

            //计算重量
            var tunnages = mul(packages, pieceWeight);
            $("#formEnterWarehouseBillGoods #Tunnages").val(Math.round(tunnages * Math.pow(10, 6)) / Math.pow(10, 6));
        });

        //设置重量改变事件
        $("#formEnterWarehouseBillGoods #Tunnages").unbind("change");
        $("#formEnterWarehouseBillGoods #Tunnages").change(function () {
            //检查件数
            var packages = parseInt($("#formEnterWarehouseBillGoods #Packages").val().trim());
            if (isNaN(packages) || packages < 0) {
                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterPackages %>");
                $("#formEnterWarehouseBillGoods #Tunnages").val("");
                $("#formEnterWarehouseBillGoods #Packages").val("");
                $("#formEnterWarehouseBillGoods #Packages").focus().select();
                return;
            }

            //检查重量
            var tunnages = parseFloat($("#formEnterWarehouseBillGoods #Tunnages").val().trim());
            if (isNaN(tunnages) || tunnages < 0) {
                $("#formEnterWarehouseBillGoods #Tunnages").val("");
                $("#formEnterWarehouseBillGoods #Tunnages").focus().select();
                return;
            }

            //计算件重
            if (packages > 0) {
                var pieceWeight = div(tunnages, packages);
                $("#formEnterWarehouseBillGoods #PieceWeight").val(Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6));
            }
        });

        //设置生产日期控件
        $("#formEnterWarehouseBillGoods #ProductionDate").datepicker($.datepicker.regional["zh-CN"]);
    });

</script>
