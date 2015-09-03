<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.CustomerStorageAndForceFeeSettlementViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formNewCustomerStorageAndForceFeeSettlement" }))
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
                <%: Html.LabelFor(model => model.InvoiceNo) %>
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
                <%: Html.LabelFor(model => model.CustomerName) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.CustomerName, ViewData["Customers"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.CustomerName)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.InvoiceType)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.InvoiceType, new SelectListItem[] { new SelectListItem { Text = InnoSoft.LS.Resources.Options.PlainInvoice, Value = InnoSoft.LS.Resources.Options.PlainInvoice }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.VatInvoice, Value = InnoSoft.LS.Resources.Options.VatInvoice, Selected = true } }, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.InvoiceType)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.InvoiceAmount)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.InvoiceAmount)%><br />
                <%: Html.ValidationMessageFor(model => model.InvoiceAmount)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.Remark)%>
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
