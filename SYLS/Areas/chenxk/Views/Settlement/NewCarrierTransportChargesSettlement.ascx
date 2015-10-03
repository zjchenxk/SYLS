<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.CarrierTransportChargesSettlementViewModel>" %>
<fieldset>
    <legend>
        <%: InnoSoft.LS.Resources.Tabs.BasicInfo %></legend>
    <% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formNewCarrierTransportChargesSettlement" }))
       { %>
    <%: Html.HiddenFor(model => model.CarrierId) %>
    <table>
        <tr>
            <td>
                <div class="editor-label-right">
                    <%: Html.LabelFor(model => model.CarrierName) %>
                </div>
            </td>
            <td>
                <div class="editor-field">
                    <%: Html.EditorFor(model => model.CarrierName)%><br />
                    <%: Html.ValidationMessageFor(model => model.CarrierName)%>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="editor-label-right">
                    <%: Html.LabelFor(model => model.SettlementAmount)%>
                </div>
            </td>
            <td>
                <div class="editor-field">
                    <%: Html.EditorFor(model => model.SettlementAmount)%><br />
                    <%: Html.ValidationMessageFor(model => model.SettlementAmount)%>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="editor-label-right">
                    <%: Html.LabelFor(model => model.WithholdAmount)%>
                </div>
            </td>
            <td>
                <div class="editor-field">
                    <%: Html.EditorFor(model => model.WithholdAmount)%><br />
                    <%: Html.ValidationMessageFor(model => model.WithholdAmount)%>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="editor-label-right">
                    <%: Html.LabelFor(model => model.FactpaymentAmount)%>
                </div>
            </td>
            <td>
                <div class="editor-field">
                    <%: Html.EditorFor(model => model.FactpaymentAmount)%><br />
                    <%: Html.ValidationMessageFor(model => model.FactpaymentAmount)%>
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
</fieldset>
<fieldset>
    <legend>
        <%: InnoSoft.LS.Resources.Tabs.DeliverBillList %></legend>
    <div>
        <table id="grid2">
        </table>
        <div id="pager2">
        </div>
    </div>
</fieldset>
