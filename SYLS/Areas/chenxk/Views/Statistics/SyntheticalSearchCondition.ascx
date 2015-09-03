<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SyntheticalSearchConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSyntheticalSearchCondition" }))
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
        //设置起始时间
        $("#formSyntheticalSearchCondition #StartTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置截止时间
        $("#formSyntheticalSearchCondition #EndTime").unbind("onSelect");
        $("#formSyntheticalSearchCondition #EndTime").datepicker({
            onSelect: function (dateText, inst) {
                //读取当前时间段内发生业务的付款单位数据
                $("#formSyntheticalSearchCondition #PayerName").empty();
                $("#formSyntheticalSearchCondition #PayerName").append("<option value=''></option>");

                $.get("/Common/LoadDeliverBillsPayersByTimespan", { startTime: $("#formSyntheticalSearchCondition #StartTime").val().trim(), endTime: $("#formSyntheticalSearchCondition #EndTime").val().trim() }, function (ret) {
                    $.each(ret, function (i, customer) {
                        var option = $("<option></option>").val(customer.Name).text(customer.Name);
                        option.appendTo($("#formSyntheticalSearchCondition #PayerName"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });

                //读取当前时间段内发货的办事处
                $("#formSyntheticalSearchCondition #OrganId").empty();
                $("#formSyntheticalSearchCondition #OrganId").append("<option value=''></option>");

                $.get("/Common/LoadDeliverBillsOwnOrgansByTimespan", { startTime: $("#formSyntheticalSearchCondition #StartTime").val().trim(), endTime: $("#formSyntheticalSearchCondition #EndTime").val().trim() }, function (ret) {
                    $.each(ret, function (i, organ) {
                        var option = $("<option></option>").val(organ.Id).text(organ.FullName);
                        option.appendTo($("#formSyntheticalSearchCondition #OrganId"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "")
                        alert(xhr.responseText);
                });
            }
        });
        $("#formSyntheticalSearchCondition #EndTime").datepicker("option", $.datepicker.regional["zh-CN"]);

        //起点国家选择事件
        $("#formSyntheticalSearchCondition #StartCountry").unbind("change");
        $("#formSyntheticalSearchCondition #StartCountry").change(function () {
            $("#formSyntheticalSearchCondition #StartProvince").empty();
            $("#formSyntheticalSearchCondition #StartProvince").append("<option value=''></option>");

            $("#formSyntheticalSearchCondition #StartCity").empty();
            $("#formSyntheticalSearchCondition #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formSyntheticalSearchCondition #StartProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSyntheticalSearchCondition #StartCountry").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //起点省份选择事件
        $("#formSyntheticalSearchCondition #StartProvince").unbind("change");
        $("#formSyntheticalSearchCondition #StartProvince").change(function () {
            $("#formSyntheticalSearchCondition #StartCity").empty();
            $("#formSyntheticalSearchCondition #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formSyntheticalSearchCondition #StartCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formSyntheticalSearchCondition #StartCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSyntheticalSearchCondition #StartProvince").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点国家选择事件
        $("#formSyntheticalSearchCondition #DestCountry").unbind("change");
        $("#formSyntheticalSearchCondition #DestCountry").change(function () {
            $("#formSyntheticalSearchCondition #DestProvince").empty();
            $("#formSyntheticalSearchCondition #DestProvince").append("<option value=''></option>");

            $("#formSyntheticalSearchCondition #DestCity").empty();
            $("#formSyntheticalSearchCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formSyntheticalSearchCondition #DestProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSyntheticalSearchCondition #DestCountry").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点省份选择事件
        $("#formSyntheticalSearchCondition #DestProvince").unbind("change");
        $("#formSyntheticalSearchCondition #DestProvince").change(function () {
            $("#formSyntheticalSearchCondition #DestCity").empty();
            $("#formSyntheticalSearchCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formSyntheticalSearchCondition #DestCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formSyntheticalSearchCondition #DestCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSyntheticalSearchCondition #DestProvince").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //设置车号自动完成
        $("#formSyntheticalSearchCondition #CarNo").autocomplete({
            source: "/Autocomplete/LoadCarNos/",
            minLength: 1
        });

    });

</script>

