<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.PaperPlanGoodsViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formNotDeliverPaperPlanGoods" }))
   { %>
<%: Html.HiddenFor(model => model.GoodsId) %>
<%: Html.HiddenFor(model => model.SpecModel) %>
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
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置货物编号自动完成
        $("#formNotDeliverPaperPlanGoods #GoodsNo").autocomplete({
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
                $("#formNotDeliverPaperPlanGoods #GoodsId").val("0");
                $("#formNotDeliverPaperPlanGoods #GoodsName").val("");
                $("#formNotDeliverPaperPlanGoods #SpecModel").val("");
                $("#formNotDeliverPaperPlanGoods #Packages").val("");
                $("#formNotDeliverPaperPlanGoods #PieceWeight").val("");
                $("#formNotDeliverPaperPlanGoods #Tunnages").val("");

                //读取货物信息
                $.get("/Common/LoadGoodsByGoodsNo", { strGoodsNo: $("#formNotDeliverPaperPlanGoods #GoodsNo").val().trim() }, function (ret) {
                    if (ret != null) {
                        $("#formNotDeliverPaperPlanGoods #GoodsId").val(ret.Id);
                        $("#formNotDeliverPaperPlanGoods #GoodsName").val(ret.Name);
                        $("#formNotDeliverPaperPlanGoods #SpecModel").val(ret.SpecModel);
                    }
                    else {
                        alert("<%: InnoSoft.LS.Resources.Strings.GoodsNoNotExists %>");
                        $("#formNotDeliverPaperPlanGoods #GoodsNo").val("");
                        $("#formNotDeliverPaperPlanGoods #GoodsNo").focus().select();
                    }
                }, "text json").error(function (xhr, status, error) {
                    $("#formNotDeliverPaperPlanGoods #GoodsNo").val("");
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            }
        });

        //设置货物信息为只读
        $("#formNotDeliverPaperPlanGoods #GoodsName").attr("readonly", "readonly");

        //设置件数改变事件
        $("#formNotDeliverPaperPlanGoods #Packages").unbind("change");
        $("#formNotDeliverPaperPlanGoods #Packages").change(function () {
            //检查货物编号
            var goodsNo = $("#formNotDeliverPaperPlanGoods #GoodsNo").val().trim();
            if (goodsNo == "") {
                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterGoodsNo %>");
                $("#formNotDeliverPaperPlanGoods #Packages").val("");
                $("#formNotDeliverPaperPlanGoods #Tunnages").val("");
                $("#formNotDeliverPaperPlanGoods #GoodsNo").focus().select();
                return;
            }

            //检查件数
            var packages = parseInt($("#formNotDeliverPaperPlanGoods #Packages").val().trim());
            if (isNaN(packages) || packages <= 0) {
                $("#formNotDeliverPaperPlanGoods #Packages").val("");
                $("#formNotDeliverPaperPlanGoods #Tunnages").val("");
                $("#formNotDeliverPaperPlanGoods #Packages").focus().select();
                return;
            }

            //计算重量
            if ($("#formNotDeliverPaperPlanGoods #PieceWeight").val().trim() != null && $("#formNotDeliverPaperPlanGoods #PieceWeight").val().trim() != "") {
                var tunnages = mul(packages, $("#formNotDeliverPaperPlanGoods #PieceWeight").val().trim());
                $("#formNotDeliverPaperPlanGoods #Tunnages").val(Math.round(tunnages * Math.pow(10, 6)) / Math.pow(10, 6));
            }
        });

        //设置重量改变事件
        $("#formNotDeliverPaperPlanGoods #Tunnages").unbind("change");
        $("#formNotDeliverPaperPlanGoods #Tunnages").change(function () {
            //检查件数
            var packages = parseInt($("#formNotDeliverPaperPlanGoods #Packages").val().trim());
            if (isNaN(packages) || packages <= 0) {
                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterPackages %>");
                $("#formNotDeliverPaperPlanGoods #Tunnages").val("");
                $("#formNotDeliverPaperPlanGoods #Packages").val("");
                $("#formNotDeliverPaperPlanGoods #Packages").focus().select();
                return;
            }

            //检查重量
            var tunnages = parseFloat($("#formNotDeliverPaperPlanGoods #Tunnages").val().trim());
            if (isNaN(tunnages) || tunnages <= 0) {
                $("#formNotDeliverPaperPlanGoods #Tunnages").val("");
                $("#formNotDeliverPaperPlanGoods #Packages").val("");
                $("#formNotDeliverPaperPlanGoods #Packages").focus().select();
                return;
            }

            //计算件重
            if (packages > 0) {
                var pieceWeight = div(tunnages, packages);
                $("#formNotDeliverPaperPlanGoods #PieceWeight").val(Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6));
            }
        });

    });

</script>
