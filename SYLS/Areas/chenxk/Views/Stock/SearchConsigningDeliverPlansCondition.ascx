<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SearchConsigningDeliverPlansConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSearchConsigningDeliverPlansCondition" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.DeliveryNo) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.DeliveryNo) %><br />
                <%: Html.ValidationMessageFor(model => model.DeliveryNo) %>
            </div>
        </td>
    </tr>
</table>
<% } %>
