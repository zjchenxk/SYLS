<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SearchDeliverBillCustomerTransportPricesConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSearchDeliverBillCustomerTransportPricesCondition" }))
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
                <%: Html.LabelFor(model => model.CustomerName)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.CustomerName)%><br />
                <%: Html.ValidationMessageFor(model => model.CustomerName)%>
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
        $("#formSearchDeliverBillCustomerTransportPricesCondition #StartTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置截止时间
        $("#formSearchDeliverBillCustomerTransportPricesCondition #EndTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置送货单号自动完成
        $("#formSearchDeliverBillCustomerTransportPricesCondition #DeliverBillNo").autocomplete({
            source: "/Autocomplete/LoadDeliverBillNos/",
            minLength: 1
        });

        //设置客户名称自动完成
        $("#formSearchDeliverBillCustomerTransportPricesCondition #CustomerName").autocomplete({
            source: "/Autocomplete/LoadCustomerNames/",
            minLength: 1
        });

    });

</script>
