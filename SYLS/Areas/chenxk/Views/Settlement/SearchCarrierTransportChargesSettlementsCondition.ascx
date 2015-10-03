<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SearchCarrierTransportChargesSettlementsConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSearchCarrierTransportChargesSettlementsCondition" }))
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
                <%: Html.LabelFor(model => model.CarrierName)%>
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
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置起始时间
        $("#formSearchCarrierTransportChargesSettlementsCondition #StartTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置截止时间
        $("#formSearchCarrierTransportChargesSettlementsCondition #EndTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置承运单位名称自动完成
        $("#formSearchCarrierTransportChargesSettlementsCondition #CarrierName").autocomplete({
            source: "/Autocomplete/LoadCarrierNames/",
            minLength: 1
        });

        //设置车号自动完成
        $("#formSearchCarrierTransportChargesSettlementsCondition #CarNo").autocomplete({
            source: "/Autocomplete/LoadCarNos/",
            minLength: 1
        });
    });

</script>
