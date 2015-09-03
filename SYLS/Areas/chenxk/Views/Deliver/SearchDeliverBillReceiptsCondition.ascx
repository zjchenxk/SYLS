<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SearchDeliverBillReceiptsConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSearchDeliverBillReceiptsCondition" }))
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
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置起止时间
        $("#formSearchDeliverBillReceiptsCondition #StartTime").datepicker($.datepicker.regional["zh-CN"]);
        $("#formSearchDeliverBillReceiptsCondition #EndTime").datepicker($.datepicker.regional["zh-CN"]);
    });

</script>
