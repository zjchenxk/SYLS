<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.CustomerTransportPriceViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formTransportPrice" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.StartCountry)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.StartCountry, ViewData["Countrys"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.StartCountry)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.StartProvince)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.StartProvince, ViewData["Provinces"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.StartProvince)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.StartCity)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.StartCity, ViewData["Citys"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.StartCity)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.DestCountry)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.DestCountry, ViewData["Countrys"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.DestCountry)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.DestProvince)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.DestProvince, ViewData["Provinces"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.DestProvince)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.DestCity)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.DestCity, ViewData["Citys"] as SelectList, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.DestCity)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.MinTunnagesOrPiles) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.MinTunnagesOrPiles)%><br />
                <%: Html.ValidationMessageFor(model => model.MinTunnagesOrPiles)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.MaxTunnagesOrPiles) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.MaxTunnagesOrPiles)%><br />
                <%: Html.ValidationMessageFor(model => model.MaxTunnagesOrPiles)%>
            </div>
        </td>
    </tr>
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
                <%: Html.LabelFor(model => model.EndTime)%>
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
                <%: Html.LabelFor(model => model.CarType) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.CarType, new SelectListItem[] { new SelectListItem { Text = string.Empty, Value = string.Empty }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.VanTruck, Value = InnoSoft.LS.Resources.Options.VanTruck }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.WoodenHandCart, Value = InnoSoft.LS.Resources.Options.WoodenHandCart } }, new { style = "font-family: Arial;" })%>
                <%: Html.ValidationMessageFor(model => model.CarType)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.TransportPrice)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.TransportPrice)%><br />
                <%: Html.ValidationMessageFor(model => model.TransportPrice)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.RiverCrossingCharges)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.RiverCrossingCharges)%><br />
                <%: Html.ValidationMessageFor(model => model.RiverCrossingCharges)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //起点国家下拉选择事件
        $("#formTransportPrice #StartCountry").unbind("change");
        $("#formTransportPrice #StartCountry").change(function () {
            $("#formTransportPrice #StartProvince").empty();
            $("#formTransportPrice #StartProvince").append("<option value=''></option>");

            $("#formTransportPrice #StartCity").empty();
            $("#formTransportPrice #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formTransportPrice #StartProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formTransportPrice #StartCountry").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //起点省份下拉选择事件
        $("#formTransportPrice #StartProvince").unbind("change");
        $("#formTransportPrice #StartProvince").change(function () {
            $("#formTransportPrice #StartCity").empty();
            $("#formTransportPrice #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formTransportPrice #StartCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formTransportPrice #StartCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formTransportPrice #StartProvince").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点国家下拉选择事件
        $("#formTransportPrice #DestCountry").unbind("change");
        $("#formTransportPrice #DestCountry").change(function () {
            $("#formTransportPrice #DestProvince").empty();
            $("#formTransportPrice #DestProvince").append("<option value=''></option>");

            $("#formTransportPrice #DestCity").empty();
            $("#formTransportPrice #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formTransportPrice #DestProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formTransportPrice #DestCountry").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点省份下拉选择事件
        $("#formTransportPrice #DestProvince").unbind("change");
        $("#formTransportPrice #DestProvince").change(function () {
            $("#formTransportPrice #DestCity").empty();
            $("#formTransportPrice #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formTransportPrice #DestCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formTransportPrice #DestCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formTransportPrice #DestProvince").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //设置起始时间
        $("#formTransportPrice #StartTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置截止时间
        $("#formTransportPrice #EndTime").datepicker({
            changeYear: true,
            yearRange: "2010:9999"
        });
        $("#formTransportPrice #EndTime").datepicker("option", $.datepicker.regional["zh-CN"]);

    });

</script>
