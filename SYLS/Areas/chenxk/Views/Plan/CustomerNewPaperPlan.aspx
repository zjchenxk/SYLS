<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.PaperPlanViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.CustomerNewPaperPlan %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.savePlan();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("NewPaperPlan", "Plan", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.BasicInfo %></legend>
        <%: Html.HiddenFor(model => model.CustomerId) %>
        <%: Html.HiddenFor(model => model.CustomerName)%>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ShipmentNo)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ShipmentNo)%>
                        <%: Html.ValidationMessageFor(model => model.ShipmentNo)%>
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
                        <%: Html.EditorFor(model => model.DeliveryNo) %>
                        <%: Html.ValidationMessageFor(model => model.DeliveryNo) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DeliverType) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.DeliverType, new SelectListItem[] { new SelectListItem { Text = InnoSoft.LS.Resources.Options.DeliverGoods, Value = InnoSoft.LS.Resources.Options.DeliverGoods, Selected = true }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.AllocateGoods, Value = InnoSoft.LS.Resources.Options.AllocateGoods } }, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.DeliverType) %>
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
                        <%: Html.EditorFor(model => model.ReceiverName) %>
                        <%: Html.ValidationMessageFor(model => model.ReceiverName) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverCountry) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.ReceiverCountry, ViewData["DestCountrys"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.ReceiverCountry) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverProvince) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.ReceiverProvince, ViewData["DestProvinces"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.ReceiverProvince) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverCity) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.ReceiverCity, ViewData["DestCitys"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.ReceiverCity) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverAddress) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ReceiverAddress) %>
                        <%: Html.ValidationMessageFor(model => model.ReceiverAddress) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverContact) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ReceiverContact) %>
                        <%: Html.ValidationMessageFor(model => model.ReceiverContact) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverContactTel) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ReceiverContactTel) %>
                        <%: Html.ValidationMessageFor(model => model.ReceiverContactTel) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.OrderNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.OrderNo)%>
                        <%: Html.ValidationMessageFor(model => model.OrderNo)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiveType) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.ReceiveType, new SelectListItem[] { new SelectListItem { Text = InnoSoft.LS.Resources.Options.PickUpDelivery, Value = InnoSoft.LS.Resources.Options.PickUpDelivery, Selected = true }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.PickUpSelf, Value = InnoSoft.LS.Resources.Options.PickUpSelf } }, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.ReceiveType) %>
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
                        <%: Html.EditorFor(model => model.CarNo) %>
                        <%: Html.ValidationMessageFor(model => model.CarNo) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TrailerNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TrailerNo) %>
                        <%: Html.ValidationMessageFor(model => model.TrailerNo) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DriverName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.TextBoxFor(model => model.DriverName, new { id = "txtDriverName" })%>
                        <%: Html.DropDownListFor(model => model.DriverName, new SelectListItem[] { new SelectListItem { Text = string.Empty, Value = string.Empty, Selected = true } }, new { id = "selDriverName", style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.DriverName) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DriverLicenseNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.DriverLicenseNo) %>
                        <%: Html.ValidationMessageFor(model => model.DriverLicenseNo) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DriverMobileTel) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.DriverMobileTel) %>
                        <%: Html.ValidationMessageFor(model => model.DriverMobileTel) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DriverHomeTel) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.DriverHomeTel) %>
                        <%: Html.ValidationMessageFor(model => model.DriverHomeTel) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ArrivalTime) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ArrivalTime) %>
                        <%: Html.ValidationMessageFor(model => model.ArrivalTime) %>
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
                    <%: Html.HiddenFor(model => model.PayerId) %>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.PayerName)%>
                        <%: Html.ValidationMessageFor(model => model.PayerName)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.IsConsigning) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.IsConsigning) %>
                        <%: Html.ValidationMessageFor(model => model.IsConsigning) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ConsignedDeliveryNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ConsignedDeliveryNo) %>
                        <%: Html.ValidationMessageFor(model => model.ConsignedDeliveryNo) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.IsInstalment) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.IsInstalment)%>
                        <%: Html.ValidationMessageFor(model => model.IsInstalment)%>
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
                        <%: Html.LabelFor(model => model.Remark) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Remark)%>
                        <%: Html.ValidationMessageFor(model => model.Remark)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CreateTime) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CreateTime)%>
                        <%: Html.ValidationMessageFor(model => model.CreateTime)%>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.GoodsList %></legend>
        <div>
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnNewGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.New %>
            </button>
            <button id="btnModifyGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
            <button id="btnDeleteGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <% } %>
    <div id="dialogGoods" title="">
        <% Html.RenderPartial("PaperPlanGoods", Model.Goods[0]); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //新增货物标志
            this.isNewGoods = true;
            //当前选中货物记录编码
            this.selectedGoodsId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认装运单号获得焦点
                $("#form1 #ShipmentNo").focus().select();
            };
            //新增货物信息
            this.newGoods = function () {
                //检查是否输入客户名称
                if ($("#form1 #CustomerId").val().trim() == "0") {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                    return;
                }

                //设置编辑模式为新增
                this.isNewGoods = true;

                //初始化控件数据
                $("#formPaperPlanGoods #GoodsId").val("0");
                $("#formPaperPlanGoods #GoodsNo").val("");
                $("#formPaperPlanGoods #GoodsName").val("");
                $("#formPaperPlanGoods #Brand").val("");
                $("#formPaperPlanGoods #SpecModel").val("");
                $("#formPaperPlanGoods #GWeight").val("");
                $("#formPaperPlanGoods #Grade").val("");

                //请空选择货物表格
                $("#grid2").jqGrid("clearGridData", true);

                //设置货物编号可写
                $("#formPaperPlanGoods #GoodsNo").removeAttr("readonly");

                //打开对话框
                $("#dialogGoods").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewPlanGoods %>");
                $("#dialogGoods").dialog("open");
            };
            //修改货物信息
            this.modifyGoods = function () {
                //检查是否输入客户名称
                if ($("#form1 #CustomerId").val().trim() == "0") {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                    return;
                }

                //读取选中的货物记录
                if (this.selectedGoodsId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedGoods %>");
                    return;
                }

                //设置编辑模式为修改
                this.isNewGoods = false;

                //初始化控件数据
                var data = $("#grid1").jqGrid("getRowData", this.selectedGoodsId);
                $("#formPaperPlanGoods #GoodsId").val(data.GoodsId);
                $("#formPaperPlanGoods #GoodsNo").val(data.GoodsNo);
                $("#formPaperPlanGoods #GoodsName").val(data.GoodsName);
                $("#formPaperPlanGoods #Brand").val(data.Brand);
                $("#formPaperPlanGoods #SpecModel").val(data.SpecModel);
                $("#formPaperPlanGoods #GWeight").val(data.GWeight);
                $("#formPaperPlanGoods #Grade").val(data.Grade);

                //填充选择货物表格
                $("#grid2").jqGrid("setGridParam", {
                    url: "/chenxk/Plan/LoadPaperPlanGoodsStockGrid/",
                    datatype: "json",
                    postData: {
                        customerId: $("#form1 #CustomerId").val().trim(),
                        goodsId: data.GoodsId,
                        batchNo: data.BatchNo,
                        packing: data.Packing,
                        warehouse: data.Warehouse,
                        location: data.Location,
                        productionDate: data.ProductionDate,
                        enterWarehouseBillId: data.EnterWarehouseBillId,
                        consignedDeliveryNo: $("#form1 #ConsignedDeliveryNo").val().trim()
                    },
                    gridComplete: function () {
                        var rowids = $("#grid2").jqGrid("getDataIDs");
                        if (rowids.length > 0) {
                            $("#grid2").jqGrid("setRowData", rowids[0], { ActualPackages: data.Packages, ActualTunnages: data.Tunnages });
                        }
                    }
                });
                $("#grid2").trigger("reloadGrid", [{ page: 1}]);

                //设置货物编号只读
                $("#formPaperPlanGoods #GoodsNo").attr("readonly", "readonly");

                //打开对话框
                $("#dialogGoods").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyPlanGoods %>");
                $("#dialogGoods").dialog("open");
            };
            //删除货物信息
            this.deleteGoods = function () {
                if (this.selectedGoodsId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedGoods %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteGoodsConfirm %>") == true) {
                    $("#grid1").jqGrid("delRowData", this.selectedGoodsId);

                    //重置合计数
                    var totalPackages = 0;
                    var totalTunnages = 0;
                    var rows = $("#grid1").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        totalPackages += parseInt(row.Packages);
                        totalTunnages = add(totalTunnages, parseFloat(row.Tunnages));
                    }

                    $("#grid1").jqGrid("footerData", "set", {
                        GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>",
                        Packages: totalPackages,
                        Tunnages: totalTunnages
                    });

                    this.selectedGoodsId = null;
                }
            };
            //保存数据
            this.savePlan = function () {
                $("#form1").submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //设置提货单位名称自动完成
            $("#form1 #ReceiverName").autocomplete({
                source: "/Autocomplete/LoadReceiverNames/",
                minLength: 1,
                change: function (event, ui) {
                    //填充提货单位数据
                    $("#form1 #ReceiverCountry").val("");

                    $("#form1 #ReceiverProvince").empty();
                    $("#form1 #ReceiverProvince").append("<option value=''></option>");

                    $("#form1 #ReceiverCity").empty();
                    $("#form1 #ReceiverCity").append("<option value=''></option>");

                    $("#form1 #ReceiverAddress").val("");
                    $("#form1 #ReceiverContact").val("");
                    $("#form1 #ReceiverContactTel").val("");

                    $.get("/Common/LoadReceiverByName", { strName: $("#form1 #ReceiverName").val().trim() }, function (data) {
                        if (data != null) {
                            $("#form1 #ReceiverCountry").val(data.Country);

                            $.get("/Common/LoadProvincesByCountry", { strCountryName: data.Country }, function (ret) {
                                $.each(ret, function (i, province) {
                                    var option = $("<option></option>").val(province).text(province);
                                    option.appendTo($("#form1 #ReceiverProvince"));
                                });
                                $("#form1 #ReceiverProvince").val(data.Province);
                            }, "text json").error(function (xhr, status, error) {
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                return;
                            });

                            $.get("/Common/LoadCitysByProvince", { strCountryName: data.Country, strProvinceName: data.Province }, function (ret) {
                                $.each(ret, function (i, city) {
                                    var option = $("<option></option>").val(city).text(city);
                                    option.appendTo($("#form1 #ReceiverCity"));
                                });
                                $("#form1 #ReceiverCity").val(data.City);
                            }, "text json").error(function (xhr, status, error) {
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                return;
                            });

                            $("#form1 #ReceiverAddress").val(data.Address);
                            $("#form1 #ReceiverContact").val(data.Contact);
                            $("#form1 #ReceiverContactTel").val(data.ContactTel);
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #ReceiverName").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //讫点国家选择事件
            $("#form1 #ReceiverCountry").change(function () {
                $("#form1 #ReceiverProvince").empty();
                $("#form1 #ReceiverProvince").append("<option value=''></option>");

                $("#form1 #ReceiverCity").empty();
                $("#form1 #ReceiverCity").append("<option value=''></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $("<option></option>").val(province).text(province);
                        option.appendTo($("#form1 #ReceiverProvince"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #ReceiverCountry").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //讫点省份选择事件
            $("#form1 #ReceiverProvince").change(function () {
                $("#form1 #ReceiverCity").empty();
                $("#form1 #ReceiverCity").append("<option value=''></option>");

                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#form1 #ReceiverCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, city) {
                        var option = $("<option></option>").val(city).text(city);
                        option.appendTo($("#form1 #ReceiverCity"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #ReceiverProvince").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //提货方式选择事件
            $("#form1 #ReceiveType").change(function () {
                if ($(this).val().trim() == "<%: InnoSoft.LS.Resources.Options.PickUpSelf %>") {
                    //自提情况下，需输入车辆信息
                    $("#form1 #CarNo").removeAttr("disabled");
                    $("#form1 #TrailerNo").removeAttr("disabled");
                    $("#form1 #txtDriverName").removeAttr("disabled");
                    $("#form1 #selDriverName").removeAttr("disabled");
                    document.getElementById("txtDriverName").style.display = "inline";
                    document.getElementById("selDriverName").style.display = "none";
                    $("#form1 #DriverLicenseNo").removeAttr("disabled");
                    $("#form1 #DriverMobileTel").removeAttr("disabled");
                    $("#form1 #DriverHomeTel").removeAttr("disabled");
                }
                else {
                    //配送情况下，不需要输入车辆信息
                    $("#form1 #CarNo").val("");
                    $("#form1 #CarNo").attr("disabled", "disabled");
                    $("#form1 #TrailerNo").val("");
                    $("#form1 #TrailerNo").attr("disabled", "disabled");
                    $("#form1 #txtDriverName").val("");
                    $("#form1 #selDriverName").empty();
                    $("#form1 #selDriverName").append("<option value=''></option>");
                    $("#form1 #txtDriverName").attr("disabled", "disabled");
                    $("#form1 #selDriverName").attr("disabled", "disabled");
                    document.getElementById("txtDriverName").style.display = "inline";
                    document.getElementById("selDriverName").style.display = "none";
                    $("#form1 #DriverLicenseNo").val("");
                    $("#form1 #DriverLicenseNo").attr("disabled", "disabled");
                    $("#form1 #DriverMobileTel").val("");
                    $("#form1 #DriverMobileTel").attr("disabled", "disabled");
                    $("#form1 #DriverHomeTel").val("");
                    $("#form1 #DriverHomeTel").attr("disabled", "disabled");
                }
            });

            //默认不输入车辆信息
            $("#form1 #CarNo").attr("disabled", "disabled");
            $("#form1 #TrailerNo").attr("disabled", "disabled");
            $("#form1 #txtDriverName").attr("disabled", "disabled");
            $("#form1 #selDriverName").attr("disabled", "disabled");
            document.getElementById("selDriverName").style.display = "none";
            $("#form1 #DriverLicenseNo").attr("disabled", "disabled");
            $("#form1 #DriverMobileTel").attr("disabled", "disabled");
            $("#form1 #DriverHomeTel").attr("disabled", "disabled");

            //设置车号自动完成
            $("#form1 #CarNo").autocomplete({
                source: "/Autocomplete/LoadCarNos/",
                minLength: 1,
                change: function (event, ui) {
                    //填充挂号
                    $("#form1 #TrailerNo").val("");

                    $.get("/Common/LoadCarByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #TrailerNo").val(ret.TrailerNo);
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #CarNo").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        return;
                    });

                    //填充驾驶员姓名下拉列表
                    $("#form1 #txtDriverName").val("");
                    $("#form1 #selDriverName").empty();
                    $("#form1 #selDriverName").append("<option value=''></option>");
                    $("#form1 #DriverLicenseNo").val("");
                    $("#form1 #DriverMobileTel").val("");
                    $("#form1 #DriverHomeTel").val("");

                    $.get("/Common/LoadDriversByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (ret) {
                        if (ret.length > 0) {
                            $.each(ret, function (i, driver) {
                                var option = $("<option></option>").val(driver.Id).text(driver.Name);
                                option.appendTo($("#form1 #selDriverName"));
                            });
                            $("#form1 #selDriverName").append("<option value='<%: InnoSoft.LS.Resources.Options.NewDriver %>'><%: InnoSoft.LS.Resources.Options.NewDriver %></option>");

                            document.getElementById("txtDriverName").style.display = "none";
                            document.getElementById("selDriverName").style.display = "inline";
                        }
                        else {
                            document.getElementById("txtDriverName").style.display = "inline";
                            document.getElementById("selDriverName").style.display = "none";
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #CarNo").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //驾驶员姓名选择事件
            $("#form1 #selDriverName").change(function () {
                $("#form1 #DriverLicenseNo").val("");
                $("#form1 #DriverMobileTel").val("");
                $("#form1 #DriverHomeTel").val("");

                if ($(this).val().trim() == "<%: InnoSoft.LS.Resources.Options.NewDriver %>") {
                    document.getElementById("selDriverName").style.display = "none";
                    document.getElementById("txtDriverName").style.display = "inline";
                    $("#form1 #txtDriverName").focus().select();
                }
                else if ($(this).val().trim() != "") {
                    //读取选中驾驶员信息
                    $.get("/Common/LoadDriver", { nId: $(this).val().trim() }, function (ret) {
                        $("#form1 #DriverLicenseNo").val(ret.LicenseNo);
                        $("#form1 #DriverMobileTel").val(ret.MobileTel);
                        $("#form1 #DriverHomeTel").val(ret.HomeTel);
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #selDriverName").get(0).selectedIndex = 0;
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //设置到货日期
            $("#form1 #ArrivalTime").datepicker({
                onSelect: function (dateText, inst) {
                    $("#form1 #PayerName").focus().select();
                }
            });
            $("#form1 #ArrivalTime").datepicker("option", $.datepicker.regional["zh-CN"]);

            //设置付款单位名称自动完成
            $("#form1 #PayerName").autocomplete({
                source: "/Autocomplete/LoadCustomerNames/",
                minLength: 1,
                change: function (event, ui) {
                    //填充付款单位编码
                    $.get("/Common/LoadCustomerByName", { strName: $("#form1 #PayerName").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #PayerId").val(ret.Id);
                        }
                        else {
                            $("#form1 #PayerId").val("0");
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #PayerName").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //设置寄库复选事件
            $("#form1 #IsConsigning").click(function () {
                if ($("#form1 #IsConsigning").attr("checked") == "checked") {
                    $("#form1 #ConsignedDeliveryNo").val("");
                    $("#form1 #ConsignedDeliveryNo").attr("disabled", "disabled");
                    $("#grid1").jqGrid("clearGridData");
                }
                else {
                    $("#form1 #ConsignedDeliveryNo").removeAttr("disabled");
                }
            });

            //设置寄库交货单号改变事件
            $("#form1 #ConsignedDeliveryNo").change(function () {
                //检查是否输入客户名称
                if ($("#form1 #CustomerId").val().trim() == "0") {
                    $("#form1 #ConsignedDeliveryNo").val("");
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                    return;
                }

                //清空货物表格
                $("#grid1").jqGrid("clearGridData", true);

                if ($("#form1 #ConsignedDeliveryNo").val().trim() != "") {
                    //填充寄库货物表格
                    $("#grid1").jqGrid("setGridParam", {
                        url: "/chenxk/Plan/LoadPaperPlanConsignedGoodsGrid/",
                        datatype: "json",
                        postData: {
                            customerId: $("#form1 #CustomerId").val().trim(),
                            deliveryNo: $("#form1 #ConsignedDeliveryNo").val().trim()
                        }
                    });
                    $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                }
            });

            //起点国家选择事件
            $("#form1 #StartCountry").change(function () {
                $("#form1 #StartProvince").empty();
                $("#form1 #StartProvince").append("<option value=''></option>");

                $("#form1 #StartCity").empty();
                $("#form1 #StartCity").append("<option value=''></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $("<option></option>").val(province).text(province);
                        option.appendTo($("#form1 #StartProvince"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #StartCountry").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //起点省份选择事件
            $("#form1 #StartProvince").change(function () {
                $("#form1 #StartCity").empty();
                $("#form1 #StartCity").append("<option value=''></option>");

                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#form1 #StartCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, city) {
                        var option = $("<option></option>").val(city).text(city);
                        option.appendTo($("#form1 #StartCity"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #StartProvince").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //设置录入日期
            $("#form1 #CreateTime").datepicker($.datepicker.regional["zh-CN"]);

            //创建货物表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Brand %>",
                    "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                    "<%: InnoSoft.LS.Resources.Labels.GrammeWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Grade %>",
                    "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.PackingSpecification %>",
                    "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                    "<%: InnoSoft.LS.Resources.Labels.Location %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.PieceWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>"],
                colModel: [
                    { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "Brand", index: "Brand", width: 80, align: "center" },
                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                    { name: "GWeight", index: "GWeight", width: 50, align: "center" },
                    { name: "Grade", index: "Grade", width: 50, align: "center" },
                    { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                    { name: "Packing", index: "Packing", width: 50, align: "center" },
                    { name: "Warehouse", index: "Warehouse", width: 80, align: "center" },
                    { name: "Location", index: "Location", width: 80, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                    { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                height: 300,
                footerrow: true,
                userDataOnFooter: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedGoodsId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //新增货物按钮点击事件
            $("#btnNewGoods").button().click(function () {
                objMain.objWorkspace.objContent.newGoods();
            });

            //修改货物按钮点击事件
            $("#btnModifyGoods").button().click(function () {
                objMain.objWorkspace.objContent.modifyGoods();
            });

            //删除货物按钮点击事件
            $("#btnDeleteGoods").button().click(function () {
                objMain.objWorkspace.objContent.deleteGoods();
            });

            //创建货物编辑对话框
            $("#dialogGoods").dialog({
                autoOpen: false,
                height: 650,
                width: 1000,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        //检查货物编码
                        if ($("#formPaperPlanGoods #GoodsNo").val().trim() == null || $("#formPaperPlanGoods #GoodsNo").val().trim() == "") {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterGoodsNo %>");
                            return;
                        }

                        //检查实发件数和吨数
                        var grid2FooterData = $("#grid2").jqGrid("footerData");

                        var totalActualPackages = parseInt(grid2FooterData.ActualPackages);
                        if (isNaN(totalActualPackages)) {
                            totalActualPackages = 0;
                        }
                        if (totalActualPackages == 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPackages %>");
                            return;
                        }

                        var totalActualTunnages = parseFloat(grid2FooterData.ActualTunnages);
                        if (isNaN(totalActualTunnages)) {
                            totalActualTunnages = 0;
                        }
                        if (totalActualTunnages == 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualTunnages %>");
                            return;
                        }

                        //新增货物信息
                        if (objMain.objWorkspace.objContent.isNewGoods) {
                            //获取货物选择记录
                            var grid2Rows = $("#grid2").jqGrid("getRowData");
                            for (var i = 0; i < grid2Rows.length; i++) {
                                var grid2Row = grid2Rows[i];

                                //获取实发件数
                                var actualPackages = parseInt(grid2Row.ActualPackages);
                                if (isNaN(actualPackages)) {
                                    actualPackages = 0;
                                }

                                //获取实发吨数
                                var actualTunnages = parseFloat(grid2Row.ActualTunnages);
                                if (isNaN(actualTunnages)) {
                                    actualTunnages = 0;
                                }

                                if (actualPackages > 0 && actualTunnages > 0) {
                                    //检查货物是否重复并累计合计数
                                    var totalPackages = 0;
                                    var totalTunnages = 0;
                                    var grid1Rows = $("#grid1").jqGrid("getRowData");
                                    for (var n = 0; n < grid1Rows.length; n++) {
                                        var grid1Row = grid1Rows[n];
                                        if (grid1Row.GoodsNo == grid2Row.GoodsNo &&
                                            grid1Row.BatchNo == grid2Row.BatchNo &&
                                            grid1Row.Packing == grid2Row.Packing &&
                                            grid1Row.Warehouse == grid2Row.Warehouse &&
                                            grid1Row.Location == grid2Row.Location &&
                                            grid1Row.ProductionDate == grid2Row.ProductionDate &&
                                            grid1Row.EnterWarehouseBillId == grid2Row.EnterWarehouseBillId) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.GoodsIsExists %>");
                                            return;
                                        }
                                        totalPackages += parseInt(grid1Row.Packages);
                                        totalTunnages = add(totalTunnages, parseFloat(grid1Row.Tunnages));
                                    }

                                    //计算rowid
                                    var rowid = 0;
                                    var rowids = $("#grid1").jqGrid("getDataIDs");
                                    for (var j = 0; j < rowids.length; j++) {
                                        if (rowid < parseFloat(rowids[j])) {
                                            rowid = parseFloat(rowids[j]);
                                        }
                                    }
                                    rowid++;

                                    //计算件重
                                    var pieceWeight = div(actualTunnages, actualPackages);

                                    //添加货物记录
                                    $("#grid1").jqGrid("addRowData", rowid, {
                                        GoodsId: grid2Row.GoodsId,
                                        GoodsNo: grid2Row.GoodsNo,
                                        GoodsName: grid2Row.GoodsName,
                                        Brand: grid2Row.Brand,
                                        SpecModel: grid2Row.SpecModel,
                                        GWeight: grid2Row.GWeight,
                                        Grade: grid2Row.Grade,
                                        BatchNo: grid2Row.BatchNo,
                                        Packing: grid2Row.Packing,
                                        Warehouse: grid2Row.Warehouse,
                                        Location: grid2Row.Location,
                                        Packages: grid2Row.ActualPackages,
                                        PieceWeight: Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6),
                                        Tunnages: grid2Row.ActualTunnages,
                                        ProductionDate: grid2Row.ProductionDate,
                                        EnterWarehouseBillId: grid2Row.EnterWarehouseBillId,
                                        EnterWarehouseBillNo: grid2Row.EnterWarehouseBillNo
                                    });

                                    //重置合计数
                                    $("#grid1").jqGrid("footerData", "set", {
                                        GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>",
                                        Packages: totalPackages + actualPackages,
                                        Tunnages: add(totalTunnages, actualTunnages)
                                    });
                                }
                            }
                        }
                        //修改货物信息
                        else {
                            //获取货物选择记录
                            var grid2Rows = $("#grid2").jqGrid("getRowData");
                            var grid2Row = grid2Rows[0];

                            //获取实发件数
                            var actualPackages = parseInt(grid2Row.ActualPackages);
                            if (isNaN(actualPackages)) {
                                actualPackages = 0;
                            }

                            //获取实发吨数
                            var actualTunnages = parseFloat(grid2Row.ActualTunnages);
                            if (isNaN(actualTunnages)) {
                                actualTunnages = 0;
                            }

                            //累计合计数
                            var totalPackages = 0;
                            var totalTunnages = 0;
                            var rowids = $("#grid1").jqGrid("getDataIDs");
                            var rows = $("#grid1").jqGrid("getRowData");
                            for (var i = 0; i < rows.length; i++) {
                                var rowid = rowids[i];
                                var row = rows[i];

                                if (rowid != objMain.objWorkspace.objContent.selectedGoodsId) {
                                    totalPackages += parseInt(row.Packages);
                                    totalTunnages = add(totalTunnages, parseFloat(row.Tunnages));
                                }
                            }

                            //计算件重
                            var pieceWeight = div(actualTunnages, actualPackages);

                            //修改货物记录
                            $("#grid1").jqGrid("setRowData", objMain.objWorkspace.objContent.selectedGoodsId, {
                                GoodsId: grid2Row.GoodsId,
                                GoodsNo: grid2Row.GoodsNo,
                                GoodsName: grid2Row.GoodsName,
                                Brand: grid2Row.Brand,
                                SpecModel: grid2Row.SpecModel,
                                GWeight: grid2Row.GWeight,
                                Grade: grid2Row.Grade,
                                BatchNo: grid2Row.BatchNo,
                                Packing: grid2Row.Packing,
                                Warehouse: grid2Row.Warehouse,
                                Location: grid2Row.Location,
                                Packages: grid2Row.ActualPackages,
                                PieceWeight: Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6),
                                Tunnages: grid2Row.ActualTunnages,
                                ProductionDate: grid2Row.ProductionDate,
                                EnterWarehouseBillId: grid2Row.EnterWarehouseBillId,
                                EnterWarehouseBillNo: grid2Row.EnterWarehouseBillNo
                            });

                            //重置合计数
                            $("#grid1").jqGrid("footerData", "set", {
                                GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>",
                                Packages: totalPackages + actualPackages,
                                Tunnages: add(totalTunnages, actualTunnages)
                            });
                        }

                        $(this).dialog("close");
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                open: function () {
                    var w = parseInt($("#dialogGoods").width()) - parseInt($("#dialogGoods > fieldset:first").css("border-left-width")) * 2 - parseInt($("#dialogGoods > fieldset:first").css("padding-left")) * 2 - parseInt($("#dialogGoods > fieldset:first").css("margin-left")) * 2 - $.scrollbarWidth();
                    $("#grid2").jqGrid("setGridWidth", w - 2);
                },
                close: function () {
                }
            });

            //提交事件
            $("#form1").submit(function () {
                if ($(this).valid()) {
                    //检查录入时间
                    var createTime = $("#form1 #CreateTime").val().trim();
                    var today = formatDate(new Date(), "yyyy-MM-dd");
                    if (createTime > today) {
                        alert("<%: InnoSoft.LS.Resources.Strings.CreateTimeCantNotGreaterThanSystemTime %>");
                        return false;
                    }

                    //检查货物
                    var footerData = $("#grid1").jqGrid("footerData");
                    if (parseInt(footerData.Packages) == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterGoods %>");
                        return false;
                    }

                    //检查仓库是否一致
                    var rows = $("#grid1").jqGrid("getRowData");
                    var warehouse = "";
                    for (var i = 0; i < rows.length; i++) {
                        if (warehouse != "" && rows[i].Warehouse != warehouse) {
                            alert("<%: InnoSoft.LS.Resources.Strings.WarehouseIsDiscrepancy %>");
                            return false;
                        }
                        warehouse = rows[i].Warehouse;
                    }

                    $.blockUI({
                        message: '<h1><img src="<%=Url.Content("~/Content/busy.gif")%>" /><%: InnoSoft.LS.Resources.Strings.PleaseWait %></h1>',
                        css: {
                            border: "none",
                            padding: "15px",
                            backgroundColor: "#000",
                            "-webkit-border-radius": "10px",
                            "-moz-border-radius": "10px",
                            opacity: .5,
                            color: "#fff"
                        }
                    });

                    //获取所有货物数据
                    var goods = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var g = {
                            "GoodsId": row.GoodsId,
                            "GoodsNo": row.GoodsNo,
                            "GoodsName": row.GoodsName,
                            "Brand": row.Brand,
                            "SpecModel": row.SpecModel,
                            "GWeight": row.GWeight,
                            "Grade": row.Grade,
                            "BatchNo": row.BatchNo,
                            "Packing": row.Packing,
                            "Warehouse": row.Warehouse,
                            "Location": row.Location,
                            "Packages": row.Packages,
                            "PieceWeight": row.PieceWeight,
                            "Tunnages": row.Tunnages,
                            "ProductionDate": row.ProductionDate,
                            "EnterWarehouseBillId": row.EnterWarehouseBillId,
                            "EnterWarehouseBillNo": row.EnterWarehouseBillNo
                        };
                        goods.push(g);
                    }

                    //生成JSON数据
                    var driverName = $("#form1 #txtDriverName").val().trim();
                    if (driverName == null || driverName == "") driverName = $("#form1 #selDriverName").find("option:selected").text();

                    var o = {
                        "Id": 0,
                        "CustomerId": $("#form1 #CustomerId").val().trim(),
                        "CustomerName": $("#form1 #CustomerName").val().trim(),
                        "ShipmentNo": $("#form1 #ShipmentNo").val().trim(),
                        "DeliveryNo": $("#form1 #DeliveryNo").val().trim(),
                        "DeliverType": $("#form1 #DeliverType").val().trim(),
                        "ReceiverName": $("#form1 #ReceiverName").val().trim(),
                        "ReceiverCountry": $("#form1 #ReceiverCountry").val().trim(),
                        "ReceiverProvince": $("#form1 #ReceiverProvince").val().trim(),
                        "ReceiverCity": $("#form1 #ReceiverCity").val().trim(),
                        "ReceiverAddress": $("#form1 #ReceiverAddress").val().trim(),
                        "ReceiverContact": $("#form1 #ReceiverContact").val().trim(),
                        "ReceiverContactTel": $("#form1 #ReceiverContactTel").val().trim(),
                        "OrderNo": $("#form1 #OrderNo").val().trim(),
                        "ReceiveType": $("#form1 #ReceiveType").val().trim(),
                        "CarNo": $("#form1 #CarNo").val().trim(),
                        "TrailerNo": $("#form1 #TrailerNo").val().trim(),
                        "DriverName": driverName,
                        "DriverLicenseNo": $("#form1 #DriverLicenseNo").val().trim(),
                        "DriverMobileTel": $("#form1 #DriverMobileTel").val().trim(),
                        "DriverHomeTel": $("#form1 #DriverHomeTel").val().trim(),
                        "Warehouse": warehouse,
                        "ArrivalTime": $("#form1 #ArrivalTime").val().trim(),
                        "PayerId": $("#form1 #PayerId").val().trim(),
                        "PayerName": $("#form1 #PayerName").val().trim(),
                        "IsConsigning": ($("#form1 #IsConsigning").attr("checked") == "checked"),
                        "ConsignedDeliveryNo": $("#form1 #ConsignedDeliveryNo").val().trim(),
                        "IsInstalment": ($("#form1 #IsInstalment").attr("checked") == "checked"),
                        "StartCountry": $("#form1 #StartCountry").val().trim(),
                        "StartProvince": $("#form1 #StartProvince").val().trim(),
                        "StartCity": $("#form1 #StartCity").val().trim(),
                        "Remark": $("#form1 #Remark").val().trim(),
                        "CreateTime": $("#form1 #CreateTime").val().trim(),
                        "Goods": goods
                    };
                    var postData = JSON.stringify(o);

                    //发送数据
                    $.ajax({
                        type: "POST",
                        url: $(this).attr("action"),
                        data: postData,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceed %>");

                                location.replace("/chenxk/Plan/SubmitDeliverPlans/");
                            }
                        },
                        error: function (xhr, status, error) {
                            $.unblockUI();

                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        }
                    });
                }
                return false;
            });
        });

    </script>
</asp:Content>
