<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SearchMoveWarehouseBillsConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSearchMoveWarehouseBillsCondition" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.StartTime)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.StartTime)%><br />
                <%: Html.ValidationMessageFor(model => model.StartTime)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.EndTime) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.EndTime)%><br />
                <%: Html.ValidationMessageFor(model => model.EndTime)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.CustomerName) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.CustomerName) %><br />
                <%: Html.ValidationMessageFor(model => model.CustomerName) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.MoveWarehouseBillNo) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.MoveWarehouseBillNo) %><br />
                <%: Html.ValidationMessageFor(model => model.MoveWarehouseBillNo) %>
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
                <%: Html.EditorFor(model => model.GoodsNo) %><br />
                <%: Html.ValidationMessageFor(model => model.GoodsNo) %>
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
                <%: Html.DropDownListFor(model => model.Warehouse, ViewData["Warehouses"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.Warehouse) %>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置起止时间
        $("#formSearchMoveWarehouseBillsCondition #StartTime").datepicker($.datepicker.regional["zh-CN"]);
        $("#formSearchMoveWarehouseBillsCondition #EndTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置客户名称自动完成
        $("#formSearchMoveWarehouseBillsCondition #CustomerName").autocomplete({
            source: "/Autocomplete/LoadCustomerNames/",
            minLength: 1
        });

        //设置货物编号自动完成
        $("#formSearchMoveWarehouseBillsCondition #GoodsNo").autocomplete({
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
            minLength: 4
        });

    });

</script>
