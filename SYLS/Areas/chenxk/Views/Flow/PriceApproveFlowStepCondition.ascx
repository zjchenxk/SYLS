<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.PriceApproveFlowStepConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formPriceApproveFlowStepCondition" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.FieldName) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.FieldName, new SelectListItem[] { new SelectListItem { Text = InnoSoft.LS.Resources.Options.OverAmount, Value = InnoSoft.LS.Resources.Options.OverAmount }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.OverPercentage, Value = InnoSoft.LS.Resources.Options.OverPercentage } }, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.FieldName) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.CompareOperator) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.CompareOperator, new SelectListItem[] { new SelectListItem { Text = InnoSoft.LS.Resources.Options.GreaterThan, Value = InnoSoft.LS.Resources.Options.GreaterThan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.GreaterThanOrEqual, Value = InnoSoft.LS.Resources.Options.GreaterThanOrEqual }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.LessThan, Value = InnoSoft.LS.Resources.Options.LessThan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.LessThanOrEqual, Value = InnoSoft.LS.Resources.Options.LessThanOrEqual }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.Equal, Value = InnoSoft.LS.Resources.Options.Equal }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.NotEqual, Value = InnoSoft.LS.Resources.Options.NotEqual }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.Contain, Value = InnoSoft.LS.Resources.Options.Contain }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.NotContain, Value = InnoSoft.LS.Resources.Options.NotContain } }, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.CompareOperator) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.FieldValue) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.FieldValue) %><br />
                <%: Html.ValidationMessageFor(model => model.FieldValue) %>
            </div>
        </td>
    </tr>
</table>
<% } %>
