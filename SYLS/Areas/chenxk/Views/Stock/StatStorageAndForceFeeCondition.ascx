<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.StatStorageAndForceFeeConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formStatStorageAndForceFeeCondition" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.StartTime) %>
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
                <%: Html.DropDownListFor(model => model.CustomerName, ViewData["Customers"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.CustomerName) %>
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
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.IsConsigning)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.IsConsigning)%><br />
                <%: Html.ValidationMessageFor(model => model.IsConsigning)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置起始时间
        $("#formStatStorageAndForceFeeCondition #StartTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置截止时间
        $("#formStatStorageAndForceFeeCondition #EndTime").unbind("onSelect");
        $("#formStatStorageAndForceFeeCondition #EndTime").datepicker({
            onSelect: function (dateText, inst) {
                //读取当前时间段内发生仓储力支费用的客户数据
                $("#formStatStorageAndForceFeeCondition #CustomerName").empty();
                $("#formStatStorageAndForceFeeCondition #CustomerName").append("<option value=''></option>");

                $.get("/Common/LoadGenerateStorageAndForceFeeCustomersByTimespan", { startTime: $("#formStatStorageAndForceFeeCondition #StartTime").val().trim(), endTime: $("#formStatStorageAndForceFeeCondition #EndTime").val().trim() }, function (ret) {
                    $.each(ret, function (i, customer) {
                        var option = $("<option></option>").val(customer.Name).text(customer.Name);
                        option.appendTo($("#formStatStorageAndForceFeeCondition #CustomerName"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            }
        });
        $("#formStatStorageAndForceFeeCondition #EndTime").datepicker("option", $.datepicker.regional["zh-CN"]);
    });

</script>
