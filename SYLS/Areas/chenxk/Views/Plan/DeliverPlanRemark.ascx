<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.DeliverPlanRemarkViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formDeliverPlanRemark" }))
   { %>
<%: Html.HiddenFor(model => model.Id)%>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.Remark) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Remark)%><br />
                <%: Html.ValidationMessageFor(model => model.Remark)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
