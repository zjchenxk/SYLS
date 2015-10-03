<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.ApproveContractsConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formApproveContractsCondition" }))
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
        $("#formApproveContractsCondition #StartTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置截止时间
        $("#formApproveContractsCondition #EndTime").unbind("onSelect");
        $("#formApproveContractsCondition #EndTime").datepicker({
            onSelect: function (dateText, inst) {
                //读取当前时间段内产生合同的办事处
                $("#formApproveContractsCondition #OrganId").empty();
                $("#formApproveContractsCondition #OrganId").append("<option value=''></option>");

                $.get("/chenxk/Contract/LoadApproveContractsOwnOrgansByTimespan", { startTime: $("#formApproveContractsCondition #StartTime").val().trim(), endTime: $("#formApproveContractsCondition #EndTime").val().trim() }, function (ret) {
                    $.each(ret, function (i, organ) {
                        var option = $("<option></option>").val(organ.Id).text(organ.FullName);
                        option.appendTo($("#formApproveContractsCondition #OrganId"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "")
                        alert(xhr.responseText);
                });
            }
        });
        $("#formApproveContractsCondition #EndTime").datepicker("option", $.datepicker.regional["zh-CN"]);

        //讫点国家选择事件
        $("#formApproveContractsCondition #DestCountry").unbind("change");
        $("#formApproveContractsCondition #DestCountry").change(function () {
            $("#formApproveContractsCondition #DestProvince").empty();
            $("#formApproveContractsCondition #DestProvince").append("<option value=''></option>");

            $("#formApproveContractsCondition #DestCity").empty();
            $("#formApproveContractsCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, province) {
                    var option = $("<option></option>").val(province).text(province);
                    option.appendTo($("#formApproveContractsCondition #DestProvince"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formApproveContractsCondition #DestCountry").val("");
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //讫点省份选择事件
        $("#formApproveContractsCondition #DestProvince").unbind("change");
        $("#formApproveContractsCondition #DestProvince").change(function () {
            $("#formApproveContractsCondition #DestCity").empty();
            $("#formApproveContractsCondition #DestCity").append("<option value=''></option>");

            $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formApproveContractsCondition #DestCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                $.each(ret, function (i, city) {
                    var option = $("<option></option>").val(city).text(city);
                    option.appendTo($("#formApproveContractsCondition #DestCity"));
                });
            }, "text json").error(function (xhr, status, error) {
                $("#formApproveContractsCondition #DestProvince").val("");
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //设置车号自动完成
        $("#formApproveContractsCondition #CarNo").autocomplete({
            source: "/Autocomplete/LoadCarNos/",
            minLength: 1
        });

    });

</script>

