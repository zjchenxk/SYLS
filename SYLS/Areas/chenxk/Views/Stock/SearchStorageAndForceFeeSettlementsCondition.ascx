<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SearchStorageAndForceFeeSettlementsConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSearchStorageAndForceFeeSettlementsCondition" }))
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
                <%: Html.EditorFor(model => model.StartTime) %><br />
                <%: Html.ValidationMessageFor(model => model.StartTime) %>
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
                <%: Html.EditorFor(model => model.EndTime) %><br />
                <%: Html.ValidationMessageFor(model => model.EndTime) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.InvoiceNo)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.InvoiceNo)%><br />
                <%: Html.ValidationMessageFor(model => model.InvoiceNo)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.CustomerName)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.CustomerName)%><br />
                <%: Html.ValidationMessageFor(model => model.CustomerName)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置起始时间
        $("#formSearchStorageAndForceFeeSettlementsCondition #StartTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置截止时间
        $("#formSearchStorageAndForceFeeSettlementsCondition #EndTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置客户名称自动完成
        $("#formSearchStorageAndForceFeeSettlementsCondition #CustomerName").autocomplete({
            source: "/Autocomplete/LoadCustomerFullNames/",
            minLength: 1
        });

    });

</script>
