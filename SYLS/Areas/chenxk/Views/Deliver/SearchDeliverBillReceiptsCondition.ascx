<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SearchDeliverBillReceiptsConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSearchDeliverBillReceiptsCondition" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.StartTime)%>
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
                <%: Html.LabelFor(model => model.CarNo) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.CarNo) %><br />
                <%: Html.ValidationMessageFor(model => model.CarNo) %>
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
                <%: Html.LabelFor(model => model.OrganId)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.OrganId, ViewData["Organizations"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.OrganId)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置起止时间
        $("#formSearchDeliverBillReceiptsCondition #StartTime").datepicker($.datepicker.regional["zh-CN"]);
        $("#formSearchDeliverBillReceiptsCondition #EndTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置客户名称自动完成
        $("#formSearchDeliverBillReceiptsCondition #CustomerName").autocomplete({
            source: "/Autocomplete/LoadCustomerNames/",
            minLength: 1
        });

        //设置车号自动完成
        $("#formSearchDeliverBillReceiptsCondition #CarNo").autocomplete({
            source: "/Autocomplete/LoadCarNos/",
            minLength: 1
        });

        //讫点国家选择事件
        $("#formSearchDeliverBillReceiptsCondition #DestCountry").unbind("change");
        $("#formSearchDeliverBillReceiptsCondition #DestCountry").change(function () {
            $("#formSearchDeliverBillReceiptsCondition #DestProvince").empty();
            $("#formSearchDeliverBillReceiptsCondition #DestProvince").append("<option value=''></option>");

            $("#formSearchDeliverBillReceiptsCondition #DestCity").empty();
            $("#formSearchDeliverBillReceiptsCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formSearchDeliverBillReceiptsCondition #DestProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSearchDeliverBillReceiptsCondition #DestCountry").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点省份选择事件
        $("#formSearchDeliverBillReceiptsCondition #DestProvince").unbind("change");
        $("#formSearchDeliverBillReceiptsCondition #DestProvince").change(function () {
            $("#formSearchDeliverBillReceiptsCondition #DestCity").empty();
            $("#formSearchDeliverBillReceiptsCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formSearchDeliverBillReceiptsCondition #DestCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formSearchDeliverBillReceiptsCondition #DestCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSearchDeliverBillReceiptsCondition #DestProvince").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

    });

</script>
