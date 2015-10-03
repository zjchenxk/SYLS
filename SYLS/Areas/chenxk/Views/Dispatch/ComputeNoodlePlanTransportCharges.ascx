<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.DispatchBillDeliverPlanViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formComputeNoodlePlanTransportCharges" }))
   { %>
<table>
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
                    ?</a></span>
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
                    ?</a></span>
                <%: Html.ValidationMessageFor(model => model.TransportPriceExpression)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.KM) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.KM)%>
                <%: Html.ValidationMessageFor(model => model.KM)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.AgreementTransportPrice) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.AgreementTransportPrice)%>
                <%: Html.ValidationMessageFor(model => model.AgreementTransportPrice)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.ActualTransportPrice)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.ActualTransportPrice)%>
                <%: Html.ValidationMessageFor(model => model.ActualTransportPrice)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.TransportCharges)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.TransportCharges)%>
                <%: Html.ValidationMessageFor(model => model.TransportCharges)%>
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
                <%: Html.EditorFor(model => model.Remark)%>
                <%: Html.ValidationMessageFor(model => model.Remark)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
