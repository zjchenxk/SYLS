<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SearchDeliverBillCarrierTransportPricesConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSearchDeliverBillCarrierTransportPricesCondition" }))
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
                <%: Html.EditorFor(model => model.StartTime) %><br />
                <%: Html.ValidationMessageFor(model => model.StartTime) %>
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
                <%: Html.EditorFor(model => model.EndTime) %><br />
                <%: Html.ValidationMessageFor(model => model.EndTime) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.DeliverBillNo)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.DeliverBillNo)%><br />
                <%: Html.ValidationMessageFor(model => model.DeliverBillNo)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.CarNo)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.CarNo)%><br />
                <%: Html.ValidationMessageFor(model => model.CarNo)%>
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
                <%: Html.EditorFor(model => model.DeliveryNo) %><br />
                <%: Html.ValidationMessageFor(model => model.DeliveryNo) %>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置起始时间
        $("#formSearchDeliverBillCarrierTransportPricesCondition #StartTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置截止时间
        $("#formSearchDeliverBillCarrierTransportPricesCondition #EndTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置送货单号自动完成
        $("#formSearchDeliverBillCarrierTransportPricesCondition #DeliverBillNo").autocomplete({
            source: "/Autocomplete/LoadDeliverBillNos/",
            minLength: 1
        });

        //设置车号自动完成
        $("#formSearchDeliverBillCarrierTransportPricesCondition #CarNo").autocomplete({
            source: "/Autocomplete/LoadCarNos/",
            minLength: 1
        });

    });

</script>
