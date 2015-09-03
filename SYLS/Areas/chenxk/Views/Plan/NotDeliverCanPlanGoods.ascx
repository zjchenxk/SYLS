<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.CanPlanGoodsViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formNotDeliverCanPlanGoods" }))
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
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置货物编号自动完成
        $("#formNotDeliverCanPlanGoods #GoodsNo").autocomplete({
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
                $("#formNotDeliverCanPlanGoods #GoodsId").val("0");
                $("#formNotDeliverCanPlanGoods #GoodsName").val("");
                $("#formNotDeliverCanPlanGoods #SpecModel").val("");

                $.get("/Common/LoadGoodsByGoodsNo", { strGoodsNo: $("#formNotDeliverCanPlanGoods #GoodsNo").val().trim() }, function (ret) {
                    if (ret != null) {
                        $("#formNotDeliverCanPlanGoods #GoodsId").val(ret.Id);
                        $("#formNotDeliverCanPlanGoods #GoodsName").val(ret.Name);
                        $("#formNotDeliverCanPlanGoods #SpecModel").val(ret.SpecModel);
                    }
                    else {
                        alert("<%: InnoSoft.LS.Resources.Strings.GoodsNoNotExists %>");
                        $("#formNotDeliverCanPlanGoods #GoodsNo").val("");
                        $("#formNotDeliverCanPlanGoods #GoodsNo").focus().select();
                    }
                }, "text json").error(function (xhr, status, error) {
                    $("#formNotDeliverCanPlanGoods #GoodsNo").val("");
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            }
        });

        //设置货物信息为只读
        $("#formNotDeliverCanPlanGoods #GoodsName").attr("readonly", "readonly");
        $("#formNotDeliverCanPlanGoods #SpecModel").attr("readonly", "readonly");
    });

</script>
