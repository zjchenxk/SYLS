<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.StatCustomerStatementConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formStatCustomerStatementCondition" }))
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
                <%: Html.LabelFor(model => model.PayerName)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.PayerName, ViewData["Customers"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.PayerName)%>
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
                <%: Html.DropDownListFor(model => model.ReceiverName, ViewData["Receivers"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.ReceiverName) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: InnoSoft.LS.Resources.Labels.StartPlace %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.StartCountry, ViewData["Countrys"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.StartCountry) %>
            </div>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.StartProvince, ViewData["Provinces"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.StartProvince) %>
            </div>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.StartCity, ViewData["Citys"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.StartCity) %>
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
                <%: Html.LabelFor(model => model.GoodsName)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.GoodsName)%><br />
                <%: Html.ValidationMessageFor(model => model.GoodsName)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.AllowStatementWhenConsignedDeliverPlanNotCompleted)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.AllowStatementWhenConsignedDeliverPlanNotCompleted)%><br />
                <%: Html.ValidationMessageFor(model => model.AllowStatementWhenConsignedDeliverPlanNotCompleted)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置起始时间
        $("#formStatCustomerStatementCondition #StartTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置截止时间
        $("#formStatCustomerStatementCondition #EndTime").unbind("onSelect");
        $("#formStatCustomerStatementCondition #EndTime").datepicker({
            onSelect: function (dateText, inst) {
                //读取当前时间段内发生业务的付款单位数据
                $("#formStatCustomerStatementCondition #PayerName").empty();
                $("#formStatCustomerStatementCondition #PayerName").append("<option value=''></option>");

                $.get("/Common/LoadGenerateBusinessPayersByTimespan", { startTime: $("#formStatCustomerStatementCondition #StartTime").val().trim(), endTime: $("#formStatCustomerStatementCondition #EndTime").val().trim() }, function (ret) {
                    $.each(ret, function (i, customer) {
                        var option = $("<option></option>").val(customer.Name).text(customer.Name);
                        option.appendTo($("#formStatCustomerStatementCondition #PayerName"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            }
        });
        $("#formStatCustomerStatementCondition #EndTime").datepicker("option", $.datepicker.regional["zh-CN"]);

        //结算单位名称选择事件
        $("#formStatCustomerStatementCondition #PayerName").unbind("change");
        $("#formStatCustomerStatementCondition #PayerName").change(function () {
            $("#formStatCustomerStatementCondition #ReceiverName").empty();
            $("#formStatCustomerStatementCondition #ReceiverName").append("<option value=''></option>");

            $.get("/Common/LoadCustomerReceivers", { customerName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, name) {
                    var option = $("<option></option>").val(name).text(name);
                    option.appendTo($("#formStatCustomerStatementCondition #ReceiverName"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formStatCustomerStatementCondition #PayerName").val("");
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //起点国家选择事件
        $("#formStatCustomerStatementCondition #StartCountry").unbind("change");
        $("#formStatCustomerStatementCondition #StartCountry").change(function () {
            $("#formStatCustomerStatementCondition #StartProvince").empty();
            $("#formStatCustomerStatementCondition #StartProvince").append("<option value=''></option>");

            $("#formStatCustomerStatementCondition #StartCity").empty();
            $("#formStatCustomerStatementCondition #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formStatCustomerStatementCondition #StartProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formStatCustomerStatementCondition #StartCountry").val("");
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //起点省份选择事件
        $("#formStatCustomerStatementCondition #StartProvince").unbind("change");
        $("#formStatCustomerStatementCondition #StartProvince").change(function () {
            $("#formStatCustomerStatementCondition #StartCity").empty();
            $("#formStatCustomerStatementCondition #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formStatCustomerStatementCondition #StartCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formStatCustomerStatementCondition #StartCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formStatCustomerStatementCondition #StartProvince").val("");
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点国家选择事件
        $("#formStatCustomerStatementCondition #DestCountry").unbind("change");
        $("#formStatCustomerStatementCondition #DestCountry").change(function () {
            $("#formStatCustomerStatementCondition #DestProvince").empty();
            $("#formStatCustomerStatementCondition #DestProvince").append("<option value=''></option>");

            $("#formStatCustomerStatementCondition #DestCity").empty();
            $("#formStatCustomerStatementCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formStatCustomerStatementCondition #DestProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formStatCustomerStatementCondition #DestCountry").val("");
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点省份选择事件
        $("#formStatCustomerStatementCondition #DestProvince").unbind("change");
        $("#formStatCustomerStatementCondition #DestProvince").change(function () {
            $("#formStatCustomerStatementCondition #DestCity").empty();
            $("#formStatCustomerStatementCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formStatCustomerStatementCondition #DestCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formStatCustomerStatementCondition #DestCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formStatCustomerStatementCondition #DestProvince").val("");
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //设置承运单位名称自动完成
        $("#formStatCustomerStatementCondition #CarrierName").autocomplete({
            source: "/Autocomplete/LoadCarrierNames/",
            minLength: 1
        });

        //设置车号自动完成
        $("#formStatCustomerStatementCondition #CarNo").autocomplete({
            source: "/Autocomplete/LoadCarNos/",
            minLength: 1
        });

    });

</script>
