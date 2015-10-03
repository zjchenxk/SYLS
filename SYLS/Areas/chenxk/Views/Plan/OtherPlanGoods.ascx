<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.OtherPlanGoodsViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formOtherPlanGoods" }))
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
        $("#formOtherPlanGoods #GoodsNo").autocomplete({
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
                $("#formOtherPlanGoods #GoodsId").val("0");
                $("#formOtherPlanGoods #GoodsName").val("");
                $("#formOtherPlanGoods #SpecModel").val("");

                $.get("/Common/LoadGoodsByGoodsNo", { strGoodsNo: $("#formOtherPlanGoods #GoodsNo").val().trim() }, function (ret) {
                    if (ret != null) {
                        $("#formOtherPlanGoods #GoodsId").val(ret.Id);
                        $("#formOtherPlanGoods #GoodsName").val(ret.Name);
                        $("#formOtherPlanGoods #SpecModel").val(ret.SpecModel);
                    }
                    else {
                        alert("<%: InnoSoft.LS.Resources.Strings.GoodsNoNotExists %>");
                        $("#formOtherPlanGoods #GoodsNo").val("");
                        $("#formOtherPlanGoods #GoodsNo").focus().select();
                    }
                }, "text json").error(function (xhr, status, error) {
                    $("#formOtherPlanGoods #GoodsNo").val("");
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            }
        });

        //设置货物信息为只读
        $("#formOtherPlanGoods #GoodsName").attr("readonly", "readonly");
        $("#formOtherPlanGoods #SpecModel").attr("readonly", "readonly");
    });

</script>
