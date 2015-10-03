<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SearchContractsConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSearchContractsCondition" }))
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
                <%: Html.LabelFor(model => model.ContractNo)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.ContractNo)%><br />
                <%: Html.ValidationMessageFor(model => model.ContractNo)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.OriginalContractNo)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.OriginalContractNo)%><br />
                <%: Html.ValidationMessageFor(model => model.OriginalContractNo)%>
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
        $("#formSearchContractsCondition #StartTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置截止时间
        $("#formSearchContractsCondition #EndTime").datepicker($.datepicker.regional["zh-CN"]);

        //起点国家选择事件
        $("#formSearchContractsCondition #StartCountry").unbind("change");
        $("#formSearchContractsCondition #StartCountry").change(function () {
            $("#formSearchContractsCondition #StartProvince").empty();
            $("#formSearchContractsCondition #StartProvince").append("<option value=''></option>");

            $("#formSearchContractsCondition #StartCity").empty();
            $("#formSearchContractsCondition #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formSearchContractsCondition #StartProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSearchContractsCondition #StartCountry").val("");
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //起点省份选择事件
        $("#formSearchContractsCondition #StartProvince").unbind("change");
        $("#formSearchContractsCondition #StartProvince").change(function () {
            $("#formSearchContractsCondition #StartCity").empty();
            $("#formSearchContractsCondition #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formSearchContractsCondition #StartCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formSearchContractsCondition #StartCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSearchContractsCondition #StartProvince").val("");
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点国家选择事件
        $("#formSearchContractsCondition #DestCountry").unbind("change");
        $("#formSearchContractsCondition #DestCountry").change(function () {
            $("#formSearchContractsCondition #DestProvince").empty();
            $("#formSearchContractsCondition #DestProvince").append("<option value=''></option>");

            $("#formSearchContractsCondition #DestCity").empty();
            $("#formSearchContractsCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formSearchContractsCondition #DestProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSearchContractsCondition #DestCountry").val("");
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点省份选择事件
        $("#formSearchContractsCondition #DestProvince").unbind("change");
        $("#formSearchContractsCondition #DestProvince").change(function () {
            $("#formSearchContractsCondition #DestCity").empty();
            $("#formSearchContractsCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formSearchContractsCondition #DestCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formSearchContractsCondition #DestCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formSearchContractsCondition #DestProvince").val("");
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //设置车号自动完成
        $("#formSearchContractsCondition #CarNo").autocomplete({
            source: "/Autocomplete/LoadCarNos/",
            minLength: 1
        });

    });

</script>

