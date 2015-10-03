<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.ReceiverDistanceViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formReceiverDistance" }))
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
                <%: Html.LabelFor(model => model.KM)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.KM)%><br />
                <%: Html.ValidationMessageFor(model => model.KM)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //起点国家下拉选择事件
        $("#formReceiverDistance #StartCountry").unbind("change");
        $("#formReceiverDistance #StartCountry").change(function () {
            $("#formReceiverDistance #StartProvince").empty();
            $("#formReceiverDistance #StartProvince").append("<option value=''></option>");

            $("#formReceiverDistance #StartCity").empty();
            $("#formReceiverDistance #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formReceiverDistance #StartProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formReceiverDistance #StartCountry").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //起点省份下拉选择事件
        $("#formReceiverDistance #StartProvince").unbind("change");
        $("#formReceiverDistance #StartProvince").change(function () {
            $("#formReceiverDistance #StartCity").empty();
            $("#formReceiverDistance #StartCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formReceiverDistance #StartCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formReceiverDistance #StartCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formReceiverDistance #StartProvince").get(0).selectedIndex = 0;
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });
    });

</script>
