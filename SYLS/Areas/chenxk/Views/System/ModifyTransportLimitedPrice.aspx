<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.TransportLimitedPriceViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ModifyTransportLimitedPrice %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/System/SetTransportLimitedPrice/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveTransportLimitedPrice();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("ModifyTransportLimitedPrice", "System", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset style="border: none;">
        <%: Html.HiddenFor(model => model.Id) %>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.PlanType) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.PlanType, new SelectListItem[] { new SelectListItem { Text = InnoSoft.LS.Resources.Options.PaperPlan, Value = InnoSoft.LS.Resources.Options.PaperPlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.NotDeliverPaperPlan, Value = InnoSoft.LS.Resources.Options.NotDeliverPaperPlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.CanPlan, Value = InnoSoft.LS.Resources.Options.CanPlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.NotDeliverCanPlan, Value = InnoSoft.LS.Resources.Options.NotDeliverCanPlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.NoodlePlan, Value = InnoSoft.LS.Resources.Options.NoodlePlan }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.OtherPlan, Value = InnoSoft.LS.Resources.Options.OtherPlan } }, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.PlanType) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.StartCountry)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.StartCountry, ViewData["StartCountrys"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.StartCountry)%>
                    </div>
                </td>
            </tr>
            <tr>
                <tr>
                    <td>
                        <div class="editor-label-right">
                            <%: Html.LabelFor(model => model.StartProvince)%>
                        </div>
                    </td>
                    <td>
                        <div class="editor-field">
                            <%: Html.DropDownListFor(model => model.StartProvince, ViewData["StartProvinces"] as SelectList, new { style = "font-family: Arial;" })%>
                            <%: Html.ValidationMessageFor(model => model.StartProvince)%>
                        </div>
                    </td>
                </tr>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.StartCity)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.StartCity, ViewData["StartCitys"] as SelectList, new { style = "font-family: Arial;" })%>
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
                        <%: Html.DropDownListFor(model => model.DestCountry, ViewData["DestCountrys"] as SelectList, new { style = "font-family: Arial;" })%>
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
                        <%: Html.DropDownListFor(model => model.DestProvince, ViewData["DestProvinces"] as SelectList, new { style = "font-family: Arial;" })%>
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
                        <%: Html.DropDownListFor(model => model.DestCity, ViewData["DestCitys"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.DestCity)%>
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
                        <%: Html.LabelFor(model => model.MinTunnagesOrPiles) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.MinTunnagesOrPiles)%>
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
                        <%: Html.EditorFor(model => model.MaxTunnagesOrPiles)%>
                        <%: Html.ValidationMessageFor(model => model.MaxTunnagesOrPiles)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.StartTime) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.StartTime)%>
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
                        <%: Html.EditorFor(model => model.EndTime)%>
                        <%: Html.ValidationMessageFor(model => model.EndTime)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TransportPrice) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TransportPrice) %>
                        <%: Html.ValidationMessageFor(model => model.TransportPrice) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TransportCharges) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TransportCharges) %>
                        <%: Html.ValidationMessageFor(model => model.TransportCharges) %>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <% } %>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认计划类别获得焦点
                $("#PlanType").focus().select();
            };
            //保存数据
            this.saveTransportLimitedPrice = function () {
                $("#form1").submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //起点国家下拉选择事件
            $("#StartCountry").change(function () {
                $("#StartProvince").empty();
                $("#StartProvince").append("<option value=''></option>");

                $("#StartCity").empty();
                $("#StartCity").append("<option value=''></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $("<option></option>").val(province).text(province);
                        option.appendTo($("#StartProvince"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#StartCountry").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //起点省份下拉选择事件
            $("#StartProvince").change(function () {
                $("#StartCity").empty();
                $("#StartCity").append("<option value=''></option>");

                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#StartCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, city) {
                        var option = $("<option></option>").val(city).text(city);
                        option.appendTo($("#StartCity"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#StartProvince").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //讫点国家下拉选择事件
            $("#DestCountry").change(function () {
                $("#DestProvince").empty();
                $("#DestProvince").append("<option value=''></option>");

                $("#DestCity").empty();
                $("#DestCity").append("<option value=''></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $("<option></option>").val(province).text(province);
                        option.appendTo($("#DestProvince"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#DestCountry").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //讫点省份下拉选择事件
            $("#DestProvince").change(function () {
                $("#DestCity").empty();
                $("#DestCity").append("<option value=''></option>");

                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#DestCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, city) {
                        var option = $("<option></option>").val(city).text(city);
                        option.appendTo($("#DestCity"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#DestProvince").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //设置起始时间
            $("#StartTime").datepicker($.datepicker.regional["zh-CN"]);

            //设置截止时间
            $("#EndTime").datepicker({
                changeYear: true,
                yearRange: "2010:9999"
            });
            $("#EndTime").datepicker("option", $.datepicker.regional["zh-CN"]);

            //提交事件
            $("#form1").submit(function () {
                if ($(this).valid()) {
                    $.blockUI({
                        message: '<h1><img src="<%=Url.Content("~/Content/busy.gif")%>" /><%: InnoSoft.LS.Resources.Strings.PleaseWait %></h1>',
                        css: {
                            border: 'none',
                            padding: '15px',
                            backgroundColor: '#000',
                            '-webkit-border-radius': '10px',
                            '-moz-border-radius': '10px',
                            opacity: .5,
                            color: '#fff'
                        }
                    });

                $.post($(this).attr("action"), $(this).serialize(), function (ret) {
                    $.unblockUI();

                    if (ret != null && ret != "") {
                        alert(ret);
                    }
                    else {
                        //缓存修改成功的记录编码
                        if ($.jStorage.get("SearchTransportLimitedPricesCondition_ModifiedIds", "") != "") {
                            $.jStorage.set("SearchTransportLimitedPricesCondition_ModifiedIds", $.jStorage.get("SearchTransportLimitedPricesCondition_ModifiedIds", "") + ",");
                        }
                        $.jStorage.set("SearchTransportLimitedPricesCondition_ModifiedIds", $.jStorage.get("SearchTransportLimitedPricesCondition_ModifiedIds", "") + $("#Id").val());

                        location.replace("/chenxk/System/SetTransportLimitedPrice/");
                    }
                });
            }
                return false;
            });
        });

    </script>
</asp:Content>
