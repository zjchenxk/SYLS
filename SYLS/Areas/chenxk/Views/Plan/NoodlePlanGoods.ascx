<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.NoodlePlanGoodsViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formNoodlePlanGoods" }))
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
                <%: Html.EditorFor(model => model.Tunnages)%><br />
                <%: Html.ValidationMessageFor(model => model.Tunnages)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置货物编号自动完成
        $("#formNoodlePlanGoods #GoodsNo").autocomplete({
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
                $("#formNoodlePlanGoods #GoodsId").val("0");
                $("#formNoodlePlanGoods #GoodsName").val("");
                $("#formNoodlePlanGoods #SpecModel").val("");
                $("#formNoodlePlanGoods #PieceWeight").val("");

                $.get("/Common/LoadGoodsByGoodsNo", { strGoodsNo: $("#formNoodlePlanGoods #GoodsNo").val().trim() }, function (ret) {
                    if (ret != null) {
                        $("#formNoodlePlanGoods #GoodsId").val(ret.Id);
                        $("#formNoodlePlanGoods #GoodsName").val(ret.Name);
                        $("#formNoodlePlanGoods #SpecModel").val(ret.SpecModel);
                        $("#formNoodlePlanGoods #PieceWeight").val(ret.PieceWeight == null || ret.PieceWeight == "" ? 0 : ret.PieceWeight);
                    }
                    else {
                        alert("<%: InnoSoft.LS.Resources.Strings.GoodsNoNotExists %>");
                        $("#formNoodlePlanGoods #GoodsNo").val("");
                        $("#formNoodlePlanGoods #GoodsNo").focus().select();
                    }
                }, "text json").error(function (xhr, status, error) {
                    $("#formNoodlePlanGoods #GoodsNo").val("");
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            }
        });

        //设置货物信息为只读
        $("#formNoodlePlanGoods #GoodsName").attr("readonly", "readonly");
        $("#formNoodlePlanGoods #SpecModel").attr("readonly", "readonly");
        $("#formNoodlePlanGoods #PieceWeight").attr("readonly", "readonly");

        //设置件数改变事件
        $("#formNoodlePlanGoods #Packages").unbind("change");
        $("#formNoodlePlanGoods #Packages").change(function () {
            //检查货物编号
            var goodsNo = $("#formNoodlePlanGoods #GoodsNo").val().trim();
            if (goodsNo == "") {
                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterGoodsNo %>");
                $("#formNoodlePlanGoods #Packages").val("");
                $("#formNoodlePlanGoods #Tunnages").val("");
                $("#formNoodlePlanGoods #GoodsNo").focus().select();
                return;
            }

            //检查件数
            var packages = parseInt($("#formNoodlePlanGoods #Packages").val().trim());
            if (isNaN(packages)) {
                $("#formNoodlePlanGoods #Packages").val("");
                $("#formNoodlePlanGoods #Tunnages").val("");
                $("#formNoodlePlanGoods #Packages").focus().select();
                return;
            }

            //计算重量
            //debugger;
            if ($("#formNoodlePlanGoods #PieceWeight").val().trim() != null && $("#formNoodlePlanGoods #PieceWeight").val().trim() != "" && parseFloat($("#formNoodlePlanGoods #PieceWeight").val().trim()) > 0) {
                var tunnages = div(packages, $("#formNoodlePlanGoods #PieceWeight").val().trim());
                $("#formNoodlePlanGoods #Tunnages").val(Math.round(tunnages * Math.pow(10, 6)) / Math.pow(10, 6));
            }
        });

    });

</script>
