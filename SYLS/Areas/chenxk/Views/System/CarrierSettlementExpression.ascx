<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.CarrierSettlementExpressionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSettlementExpression" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.PlanType) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.PlanType, new SelectListItem[] { new SelectListItem { Text = InnoSoft.LS.Resources.Options.PaperPlan, Value = InnoSoft.LS.Resources.Options.PaperPlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.NotDeliverPaperPlan, Value = InnoSoft.LS.Resources.Options.NotDeliverPaperPlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.CanPlan, Value = InnoSoft.LS.Resources.Options.CanPlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.NotDeliverCanPlan, Value = InnoSoft.LS.Resources.Options.NotDeliverCanPlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.NoodlePlan, Value = InnoSoft.LS.Resources.Options.NoodlePlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.OtherPlan, Value = InnoSoft.LS.Resources.Options.OtherPlan } }, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.PlanType) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.TransportChargeExpression) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.TransportChargeExpression)%>
                <span class="formInfo"><a href="/Help/TransportChargeExpression/?width=350" class="jTip"
                    id="tooltipTransportChargeExpression" name="<%: InnoSoft.LS.Resources.Titles.Tooltip %>">
                    ?</a></span><br />
                <%: Html.ValidationMessageFor(model => model.TransportChargeExpression)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.TransportPriceExpression) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.TransportPriceExpression)%>
                <span class="formInfo"><a href="/Help/TransportPriceExpression/?width=350" class="jTip"
                    id="tooltipTransportPriceExpression" name="<%: InnoSoft.LS.Resources.Titles.Tooltip %>">
                    ?</a></span><br />
                <%: Html.ValidationMessageFor(model => model.TransportPriceExpression)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
