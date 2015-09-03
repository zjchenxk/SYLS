<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.CarrierCarViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formCar" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.CarNo) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.CarNo) %><br />
                <%: Html.ValidationMessageFor(model => model.CarNo) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.TrailerNo) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.TrailerNo) %><br />
                <%: Html.ValidationMessageFor(model => model.TrailerNo) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.CarryingCapacity) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.CarryingCapacity) %><br />
                <%: Html.ValidationMessageFor(model => model.CarryingCapacity) %>
            </div>
        </td>
    </tr>
</table>
<% } %>
