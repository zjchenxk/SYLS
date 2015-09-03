<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.StatCarrierStatementConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formStatCarrierStatementCondition" }))
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
                <%: Html.LabelFor(model => model.DeliverBillReceiptReceived)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.DeliverBillReceiptReceived)%><br />
                <%: Html.ValidationMessageFor(model => model.DeliverBillReceiptReceived)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置起始时间
        $("#formStatCarrierStatementCondition #StartTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置截止时间
        $("#formStatCarrierStatementCondition #EndTime").datepicker($.datepicker.regional["zh-CN"]);
        //        $("#formStatCarrierStatementCondition #EndTime").unbind("onSelect");
        //        $("#formStatCarrierStatementCondition #EndTime").datepicker({
        //            onSelect: function (dateText, inst) {
        //                //读取当前时间段内发生业务的承运单位数据
        //                $("#formStatCarrierStatementCondition #CarrierName").empty();
        //                $("#formStatCarrierStatementCondition #CarrierName").append("<option value=''></option>");

        //                $.get("/Common/LoadGenerateBusinessCarriersByTimespan", { startTime: $("#formStatCarrierStatementCondition #StartTime").val().trim(), endTime: $("#formStatCarrierStatementCondition #EndTime").val().trim() }, function (ret) {
        //                    $.each(ret, function (i, name) {
        //                        var option = $("<option></option>").val(name).text(name);
        //                        option.appendTo($("#formStatCarrierStatementCondition #CarrierName"));
        //                    });
        //                }, "text json").error(function (xhr, status, error) {
        //                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
        //                });
        //            }
        //        });
        //        $("#formStatCarrierStatementCondition #EndTime").datepicker("option", $.datepicker.regional["zh-CN"]);

        //设置承运单位名称自动完成
        $("#formStatCarrierStatementCondition #CarrierName").autocomplete({
            source: "/Autocomplete/LoadCarrierNames/",
            minLength: 1
        });

        //设置车号自动完成
        $("#formStatCarrierStatementCondition #CarNo").autocomplete({
            source: "/Autocomplete/LoadCarNos/",
            minLength: 1
        });

        //起点国家选择事件
        $("#formStatCarrierStatementCondition #StartCountry").unbind("change");
        $("#formStatCarrierStatementCondition #StartCountry").change(function () {
            $("#formStatCarrierStatementCondition #StartProvince").empty();
            $("#formStatCarrierStatementCondition #StartProvince").append("<option value=''></option>");

            $("#formStatCarrierStatementCondition #StartCity").empty();
            $("#formStatCarrierStatementCondition #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formStatCarrierStatementCondition #StartProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formStatCarrierStatementCondition #StartCountry").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //起点省份选择事件
        $("#formStatCarrierStatementCondition #StartProvince").unbind("change");
        $("#formStatCarrierStatementCondition #StartProvince").change(function () {
            $("#formStatCarrierStatementCondition #StartCity").empty();
            $("#formStatCarrierStatementCondition #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formStatCarrierStatementCondition #StartCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formStatCarrierStatementCondition #StartCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formStatCarrierStatementCondition #StartProvince").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点国家选择事件
        $("#formStatCarrierStatementCondition #DestCountry").unbind("change");
        $("#formStatCarrierStatementCondition #DestCountry").change(function () {
            $("#formStatCarrierStatementCondition #DestProvince").empty();
            $("#formStatCarrierStatementCondition #DestProvince").append("<option value=''></option>");

            $("#formStatCarrierStatementCondition #DestCity").empty();
            $("#formStatCarrierStatementCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formStatCarrierStatementCondition #DestProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formStatCarrierStatementCondition #DestCountry").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点省份选择事件
        $("#formStatCarrierStatementCondition #DestProvince").unbind("change");
        $("#formStatCarrierStatementCondition #DestProvince").change(function () {
            $("#formStatCarrierStatementCondition #DestCity").empty();
            $("#formStatCarrierStatementCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formStatCarrierStatementCondition #DestCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formStatCarrierStatementCondition #DestCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formStatCarrierStatementCondition #DestProvince").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

    });

</script>
