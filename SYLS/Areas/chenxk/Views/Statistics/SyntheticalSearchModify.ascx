<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SyntheticalSearchModifyViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSyntheticalSearchModify" }))
   { %>
<%: Html.HiddenFor(model => model.PlanId)%>
<%: Html.HiddenFor(model => model.PayerId)%>
<%: Html.HiddenFor(model => model.ContractId)%>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.ShipmentNo) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.ShipmentNo)%><br />
                <%: Html.ValidationMessageFor(model => model.ShipmentNo)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.DeliveryNo) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.DeliveryNo)%><br />
                <%: Html.ValidationMessageFor(model => model.DeliveryNo)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.PayerName) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.PayerName)%><br />
                <%: Html.ValidationMessageFor(model => model.PayerName)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.OriginalContractNo) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.OriginalContractNo)%><br />
                <%: Html.ValidationMessageFor(model => model.OriginalContractNo)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
