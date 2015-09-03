<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SearchDispatchDeliverPlanConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSearchDispatchDeliverPlanCondition" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.OrganId) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.OrganId, ViewData["Organizations"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.OrganId) %>
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
                <%: Html.EditorFor(model => model.CustomerName) %><br />
                <%: Html.ValidationMessageFor(model => model.CustomerName) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.ShipmentNo) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.ShipmentNo) %><br />
                <%: Html.ValidationMessageFor(model => model.ShipmentNo) %>
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
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.ReceiverName) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.ReceiverName) %><br />
                <%: Html.ValidationMessageFor(model => model.ReceiverName) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: InnoSoft.LS.Resources.Labels.DestPlace %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.DestCountry, ViewData["Countrys"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.DestCountry) %>
            </div>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.DestProvince, ViewData["Provinces"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.DestProvince) %>
            </div>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.DestCity, ViewData["Citys"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.DestCity) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.Warehouse) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.Warehouse, ViewData["Warehouses"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.Warehouse) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.ArrivalTime) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.ArrivalTime) %><br />
                <%: Html.ValidationMessageFor(model => model.ArrivalTime) %>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置客户名称自动完成
        $("#formSearchDispatchDeliverPlanCondition #CustomerName").autocomplete({
            source: "/Autocomplete/LoadCustomerNames/",
            minLength: 1
        });

        //设置提货单位名称自动完成
        $("#formSearchDispatchDeliverPlanCondition #ReceiverName").autocomplete({
            source: "/Autocomplete/LoadReceiverNames/",
            minLength: 1
        });

        //讫点国家选择事件
        $("#formSearchDispatchDeliverPlanCondition #DestCountry").unbind("change");
        $("#formSearchDispatchDeliverPlanCondition #DestCountry").change(function () {
            $("#formSearchDispatchDeliverPlanCondition #DestProvince").empty();
            $("#formSearchDispatchDeliverPlanCondition #DestProvince").append("<option value=''></option>");

            $("#formSearchDispatchDeliverPlanCondition #DestCity").empty();
            $("#formSearchDispatchDeliverPlanCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formSearchDispatchDeliverPlanCondition #DestProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSearchDispatchDeliverPlanCondition #DestCountry").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点省份选择事件
        $("#formSearchDispatchDeliverPlanCondition #DestProvince").unbind("change");
        $("#formSearchDispatchDeliverPlanCondition #DestProvince").change(function () {
            $("#formSearchDispatchDeliverPlanCondition #DestCity").empty();
            $("#formSearchDispatchDeliverPlanCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formSearchDispatchDeliverPlanCondition #DestCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formSearchDispatchDeliverPlanCondition #DestCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSearchDispatchDeliverPlanCondition #DestProvince").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //设置到货时间
        $("#formSearchDispatchDeliverPlanCondition #ArrivalTime").datepicker($.datepicker.regional["zh-CN"]);
    });

</script>
