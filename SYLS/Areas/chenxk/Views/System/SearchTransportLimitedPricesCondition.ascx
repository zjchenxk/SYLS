<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SearchTransportLimitedPricesConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSearchTransportLimitedPricesCondition" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.PlanType) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.PlanType, new SelectListItem[] { new SelectListItem { Text = string.Empty, Value = string.Empty, Selected = true }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.PaperPlan, Value = InnoSoft.LS.Resources.Options.PaperPlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.NotDeliverPaperPlan, Value = InnoSoft.LS.Resources.Options.NotDeliverPaperPlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.CanPlan, Value = InnoSoft.LS.Resources.Options.CanPlan },new SelectListItem { Text = InnoSoft.LS.Resources.Options.NotDeliverCanPlan, Value = InnoSoft.LS.Resources.Options.NotDeliverCanPlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.NoodlePlan, Value = InnoSoft.LS.Resources.Options.NoodlePlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.OtherPlan, Value = InnoSoft.LS.Resources.Options.OtherPlan } }, new { style = "font-family: Arial;" })%><br />
                <%: Html.ValidationMessageFor(model => model.PlanType)%>
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
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //起点国家选择事件
        $("#formSearchTransportLimitedPricesCondition #StartCountry").unbind("change");
        $("#formSearchTransportLimitedPricesCondition #StartCountry").change(function () {
            $("#formSearchTransportLimitedPricesCondition #StartProvince").empty();
            $("#formSearchTransportLimitedPricesCondition #StartProvince").append("<option value=''></option>");

            $("#formSearchTransportLimitedPricesCondition #StartCity").empty();
            $("#formSearchTransportLimitedPricesCondition #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formSearchTransportLimitedPricesCondition #StartProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSearchTransportLimitedPricesCondition #StartCountry").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //起点省份选择事件
        $("#formSearchTransportLimitedPricesCondition #StartProvince").unbind("change");
        $("#formSearchTransportLimitedPricesCondition #StartProvince").change(function () {
            $("#formSearchTransportLimitedPricesCondition #StartCity").empty();
            $("#formSearchTransportLimitedPricesCondition #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formSearchTransportLimitedPricesCondition #StartCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formSearchTransportLimitedPricesCondition #StartCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSearchTransportLimitedPricesCondition #StartProvince").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点国家选择事件
        $("#formSearchTransportLimitedPricesCondition #DestCountry").unbind("change");
        $("#formSearchTransportLimitedPricesCondition #DestCountry").change(function () {
            $("#formSearchTransportLimitedPricesCondition #DestProvince").empty();
            $("#formSearchTransportLimitedPricesCondition #DestProvince").append("<option value=''></option>");

            $("#formSearchTransportLimitedPricesCondition #DestCity").empty();
            $("#formSearchTransportLimitedPricesCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formSearchTransportLimitedPricesCondition #DestProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSearchTransportLimitedPricesCondition #DestCountry").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点省份选择事件
        $("#formSearchTransportLimitedPricesCondition #DestProvince").unbind("change");
        $("#formSearchTransportLimitedPricesCondition #DestProvince").change(function () {
            $("#formSearchTransportLimitedPricesCondition #DestCity").empty();
            $("#formSearchTransportLimitedPricesCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formSearchTransportLimitedPricesCondition #DestCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formSearchTransportLimitedPricesCondition #DestCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSearchTransportLimitedPricesCondition #DestProvince").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });
    });

</script>
