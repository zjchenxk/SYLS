<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.CarrierViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ModifyCarrier %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/System/SetCarrier/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveCarrier();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("ModifyCarrier", "System", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.BasicInfo %></legend>
        <%: Html.HiddenFor(model => model.Id) %>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Name) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Name) %>
                        <%: Html.ValidationMessageFor(model => model.Name) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.BusinessType) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.BusinessType, new SelectListItem[] { new SelectListItem { Text = InnoSoft.LS.Resources.Options.SelfSupport, Value = InnoSoft.LS.Resources.Options.SelfSupport }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.JoinIn, Value = InnoSoft.LS.Resources.Options.JoinIn }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.Prestowage, Value = InnoSoft.LS.Resources.Options.Prestowage } }, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.BusinessType) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.PaymentType) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.PaymentType, new SelectListItem[] { new SelectListItem { Text = InnoSoft.LS.Resources.Options.MonthlyStatement, Value = InnoSoft.LS.Resources.Options.MonthlyStatement }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.CashPayment, Value = InnoSoft.LS.Resources.Options.CashPayment } }, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.PaymentType) %>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.CarList%></legend>
        <div>
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnNewCar" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.New %>
            </button>
            <button id="btnModifyCar" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
            <button id="btnDeleteCar" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.DriverList%></legend>
        <div>
            <table id="grid2">
            </table>
            <div id="pager2">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnNewDriver" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.New %>
            </button>
            <button id="btnModifyDriver" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
            <button id="btnDeleteDriver" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.SettlementExpressionList %></legend>
        <div>
            <table id="grid3">
            </table>
            <div id="pager3">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnNewExpression" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.New %>
            </button>
            <button id="btnModifyExpression" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
            <button id="btnDeleteExpression" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.TransportPriceList %></legend>
        <div>
            <table id="grid4">
            </table>
            <div id="pager4">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnNewPrice" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.New %>
            </button>
            <button id="btnModifyPrice" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
            <button id="btnDeletePrice" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <% } %>
    <div id="dialogCar" title="">
        <% Html.RenderPartial("CarrierCar", Model.Cars[0]); %>
    </div>
    <div id="dialogDriver" title="">
        <% Html.RenderPartial("CarrierDriver", Model.Drivers[0]); %>
    </div>
    <div id="dialogSettlementExpression" title="">
        <% Html.RenderPartial("CarrierSettlementExpression", Model.SettlementExpressions[0]); %>
    </div>
    <div id="dialogTransportPrice" title="">
        <% Html.RenderPartial("CarrierTransportPrice", Model.TransportPrices[0]); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //新增车辆标志
            this.isNewCar = true;
            //当前选中车辆记录编码
            this.selectedCarId = null;
            //新增驾驶员标志
            this.isNewDriver = true;
            //当前选中驾驶员记录编码
            this.selectedDriverId = null;
            //新增结算公式标志
            this.isNewSettlementExpression = true;
            //当前选中结算公式记录编码
            this.selectedSettlementExpressionId = null;
            //新增承运价格标志
            this.isNewTransportPrice = true;
            //当前选中承运价格记录编码
            this.selectedTransportPriceId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
                $("#grid2").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
                $("#grid3").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
                $("#grid4").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认名称获得焦点
                $("#form1 #Name").focus().select();
            };
            //新增车辆信息
            this.newCar = function () {
                //设置编辑模式为新增
                this.isNewCar = true;

                //初始化控件数据
                $("#formCar #CarNo").val("");
                $("#formCar #TrailerNo").val("");
                $("#formCar #CarryingCapacity").val("");

                //打开对话框
                $("#dialogCar").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewCarrierCar %>");
                $("#dialogCar").dialog("open");
            };
            //修改车辆信息
            this.modifyCar = function () {
                //读取选中的车辆记录
                if (this.selectedCarId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarrierCar %>");
                    return;
                }
                var data = $("#grid1").jqGrid("getRowData", this.selectedCarId);

                //初始化控件数据
                $("#formCar #CarNo").val(data.CarNo);
                $("#formCar #TrailerNo").val(data.TrailerNo);
                $("#formCar #CarryingCapacity").val(data.CarryingCapacity);

                //设置编辑模式为修改
                this.isNewCar = false;

                //打开对话框
                $("#dialogCar").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyCarrierCar %>");
                $("#dialogCar").dialog("open");
            };
            //删除车辆信息
            this.deleteCar = function () {
                if (this.selectedCarId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarrierCar %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteCarrierCarConfirm %>") == true) {
                    //清除驾驶员关联车号
                    var data1 = $("#grid1").jqGrid("getRowData", this.selectedCarId);

                    var rowids = $("#grid2").jqGrid("getDataIDs");
                    for (var i = 0; i < rowids.length; i++) {
                        var data2 = $("#grid2").jqGrid("getRowData", rowids[i]);
                        var oldCarNos = data2.CarNo.split(",");
                        var newCarNos = new Array();
                        for (var j = 0; j < oldCarNos.length; j++) {
                            if (oldCarNos[j] != data1.CarNo) {
                                newCarNos.push(oldCarNos[j]);
                            }
                        }
                        $("#grid2").jqGrid("setRowData", rowids[i], { CarNo: newCarNos.toString() });
                    }

                    //删除车辆记录
                    $("#grid1").jqGrid("delRowData", this.selectedCarId);
                    this.selectedCarId = null;
                }
            };
            //新增驾驶员信息
            this.newDriver = function () {
                //设置编辑模式为新增
                this.isNewDriver = true;

                //初始化控件数据
                $("#formDriver #Name").val("");
                $("#formDriver #LicenseNo").val("");
                $("#formDriver #MobileTel").val("");
                $("#formDriver #HomeTel").val("");

                $("#gridCarNo").jqGrid("clearGridData");
                var rows = $("#grid1").jqGrid("getRowData");
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    $("#gridCarNo").jqGrid("addRowData", i, { CarNo: row.CarNo });
                }

                //打开对话框
                $("#dialogDriver").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewCarrierDriver %>");
                $("#dialogDriver").dialog("open");
            };
            //修改驾驶员信息
            this.modifyDriver = function () {
                //读取选中的驾驶员记录
                if (this.selectedDriverId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarrierDriver %>");
                    return;
                }
                var data = $("#grid2").jqGrid("getRowData", this.selectedDriverId);

                //初始化控件数据
                $("#formDriver #Name").val(data.Name);
                $("#formDriver #LicenseNo").val(data.LicenseNo);
                $("#formDriver #MobileTel").val(data.MobileTel);
                $("#formDriver #HomeTel").val(data.HomeTel);

                $("#gridCarNo").jqGrid("clearGridData");
                var rows = $("#grid1").jqGrid("getRowData");
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    $("#gridCarNo").jqGrid("addRowData", i, { CarNo: row.CarNo });
                    if (data.CarNo.indexOf(row.CarNo) >= 0) {
                        $("#gridCarNo").jqGrid("setSelection", i, false);
                    }
                }

                //设置编辑模式为修改
                this.isNewDriver = false;

                //打开对话框
                $("#dialogDriver").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyCarrierDriver %>");
                $("#dialogDriver").dialog("open");
            };
            //删除驾驶员信息
            this.deleteDriver = function () {
                if (this.selectedDriverId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarrierDriver %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteCarrierDriverConfirm %>") == true) {
                    $("#grid2").jqGrid("delRowData", this.selectedDriverId);
                    this.selectedDriverId = null;
                }
            };
            //新增结算公式信息
            this.newExpression = function () {
                //设置编辑模式为新增
                this.isNewSettlementExpression = true;

                //初始化控件数据
                $("#formSettlementExpression #PlanType").get(0).selectedIndex = 0;
                $("#formSettlementExpression #TransportChargeExpression").val("");
                $("#formSettlementExpression #TransportPriceExpression").val("");

                //打开对话框
                $("#dialogSettlementExpression").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewCarrierSettlementExpression %>");
                $("#dialogSettlementExpression").dialog("open");
            };
            //修改结算公式信息
            this.modifyExpression = function () {
                //读取选中的结算公式记录
                if (this.selectedSettlementExpressionId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarrierSettlementExpression %>");
                    return;
                }
                var data = $("#grid3").jqGrid("getRowData", this.selectedSettlementExpressionId);

                //初始化控件数据
                $("#formSettlementExpression #PlanType").val(data.PlanType);
                $("#formSettlementExpression #TransportChargeExpression").val(data.TransportChargeExpression);
                $("#formSettlementExpression #TransportPriceExpression").val(data.TransportPriceExpression);

                //设置编辑模式为修改
                this.isNewSettlementExpression = false;

                //打开对话框
                $("#dialogSettlementExpression").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyCarrierSettlementExpression %>");
                $("#dialogSettlementExpression").dialog("open");
            };
            //删除结算公式信息
            this.deleteExpression = function () {
                if (this.selectedSettlementExpressionId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarrierSettlementExpression %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteCarrierSettlementExpressionConfirm %>") == true) {
                    $("#grid3").jqGrid("delRowData", this.selectedSettlementExpressionId);
                    this.selectedSettlementExpressionId = null;
                }
            };
            //新增承运价格
            this.newTransportPrice = function () {
                //设置编辑模式为新增
                this.isNewTransportPrice = true;

                //初始化控件数据
                $("#formTransportPrice #StartCountry").val("");

                $("#formTransportPrice #StartProvince").empty();
                $("#formTransportPrice #StartProvince").append("<option value=''></option>");

                $("#formTransportPrice #StartCity").empty();
                $("#formTransportPrice #StartCity").append("<option value=''></option>");

                $("#formTransportPrice #DestCountry").val("");

                $("#formTransportPrice #DestProvince").empty();
                $("#formTransportPrice #DestProvince").append("<option value=''></option>");

                $("#formTransportPrice #DestCity").empty();
                $("#formTransportPrice #DestCity").append("<option value=''></option>");

                $("#formTransportPrice #PlanType").get(0).selectedIndex = 0;

                var today = new Date();
                $("#formTransportPrice #StartTime").val(formatDate(today, "yyyy-MM-dd"));

                $("#formTransportPrice #EndTime").val("9999-12-31");

                $("#formTransportPrice #TransportPrice").val("");

                //打开对话框
                $("#dialogTransportPrice").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewCarrierTransportPrice %>");
                $("#dialogTransportPrice").dialog("open");
            };
            //修改承运价格
            this.modifyTransportPrice = function () {
                //读取选中的承运价格数据
                if (this.selectedTransportPriceId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarrierTransportPrice %>");
                    return;
                }
                var data = $("#grid4").jqGrid("getRowData", this.selectedTransportPriceId);

                //初始化控件数据
                $("#formTransportPrice #StartCountry").val(data.StartCountry);

                $("#formTransportPrice #StartProvince").empty();
                $("#formTransportPrice #StartProvince").append("<option value=''></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: data.StartCountry }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $("<option></option>").val(province).text(province);
                        option.appendTo($("#formTransportPrice #StartProvince"));
                    });
                    $("#formTransportPrice #StartProvince").val(data.StartProvince);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    return;
                });

                $("#formTransportPrice #StartCity").empty();
                $("#formTransportPrice #StartCity").append("<option value=''></option>");

                $.get("/Common/LoadCitysByProvince", { strCountryName: data.StartCountry, strProvinceName: data.StartProvince }, function (ret) {
                    $.each(ret, function (i, city) {
                        var option = $("<option></option>").val(city).text(city);
                        option.appendTo($("#formTransportPrice #StartCity"));
                    });
                    $("#formTransportPrice #StartCity").val(data.StartCity);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    return;
                });

                $("#formTransportPrice #DestCountry").val(data.DestCountry);

                $("#formTransportPrice #DestProvince").empty();
                $("#formTransportPrice #DestProvince").append("<option value=''></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: data.DestCountry }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $("<option></option>").val(province).text(province);
                        option.appendTo($("#formTransportPrice #DestProvince"));
                    });
                    $("#formTransportPrice #DestProvince").val(data.DestProvince);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    return;
                });

                $("#formTransportPrice #DestCity").empty();
                $("#formTransportPrice #DestCity").append("<option value=''></option>");

                $.get("/Common/LoadCitysByProvince", { strCountryName: data.DestCountry, strProvinceName: data.DestProvince }, function (ret) {
                    $.each(ret, function (i, city) {
                        var option = $("<option></option>").val(city).text(city);
                        option.appendTo($("#formTransportPrice #DestCity"));
                    });
                    $("#formTransportPrice #DestCity").val(data.DestCity);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    return;
                });

                $("#formTransportPrice #PlanType").val(data.PlanType);

                $("#formTransportPrice #StartTime").val(data.StartTime);

                $("#formTransportPrice #EndTime").val(data.EndTime);

                $("#formTransportPrice #TransportPrice").val(data.TransportPrice);

                //设置编辑模式为修改
                this.isNewTransportPrice = false;

                //打开对话框
                $("#dialogTransportPrice").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyCarrierTransportPrice %>");
                $("#dialogTransportPrice").dialog("open");
            };
            //删除承运价格
            this.deleteTransportPrice = function () {
                if (this.selectedTransportPriceId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarrierTransportPrice %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteCarrierTransportPriceConfirm %>") == true) {
                    $("#grid4").jqGrid("delRowData", this.selectedTransportPriceId);
                    this.selectedTransportPriceId = null;
                }
            };
            //保存数据
            this.saveCarrier = function () {
                $("#form1").submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //1.创建车辆表格
            $("#grid1").jqGrid({
                url: "/chenxk/System/LoadCarrierCarGrid/" + $("#Id").val().trim(),
                datatype: "json",
                mtype: "GET",
                colNames: ["<%: InnoSoft.LS.Resources.Labels.Id %>", "<%: InnoSoft.LS.Resources.Labels.CarNo %>", "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>", "<%: InnoSoft.LS.Resources.Labels.CarryingCapacity %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CarNo", index: "CarNo", width: 100, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 100, align: "center" },
                    { name: "CarryingCapacity", index: "CarryingCapacity", width: 100, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedCarId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //新增车辆按钮点击事件
            $("#btnNewCar").button().click(function () {
                objMain.objWorkspace.objContent.newCar();
            });

            //修改车辆按钮点击事件
            $("#btnModifyCar").button().click(function () {
                objMain.objWorkspace.objContent.modifyCar();
            });

            //删除车辆按钮点击事件
            $("#btnDeleteCar").button().click(function () {
                objMain.objWorkspace.objContent.deleteCar();
            });

            //创建车辆编辑对话框
            $("#dialogCar").dialog({
                autoOpen: false,
                height: 250,
                width: 480,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formCar").valid()) {
                            if (objMain.objWorkspace.objContent.isNewCar) {
                                //新增车辆
                                var rowcount = $("#grid1").jqGrid("getGridParam", "records");
                                if (rowcount == 0) {
                                    $("#grid1").jqGrid("addRowData", 1, { Id: "0", CarNo: $("#formCar #CarNo").val().trim(), TrailerNo: $("#formCar #TrailerNo").val().trim(), CarryingCapacity: $("#formCar #CarryingCapacity").val().trim() });
                                }
                                else {
                                    //检查车号是否重复
                                    var rows = $("#grid1").jqGrid("getRowData");
                                    for (var i = 0; i < rows.length; i++) {
                                        var row = rows[i];
                                        if (row.CarNo == $("#formCar #CarNo").val().trim()) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.CarrierCarNoIsExists %>");
                                            return;
                                        }
                                    }

                                    var rowids = $("#grid1").jqGrid("getDataIDs");
                                    var rowidLast = rowids[rowcount - 1];

                                    $("#grid1").jqGrid("addRowData", parseFloat(rowidLast) + 1, { Id: "0", CarNo: $("#formCar #CarNo").val().trim(), TrailerNo: $("#formCar #TrailerNo").val().trim(), CarryingCapacity: $("#formCar #CarryingCapacity").val().trim() });
                                }
                            }
                            else {
                                //检查车号是否重复
                                var rowids = $("#grid1").jqGrid("getDataIDs");
                                var rows = $("#grid1").jqGrid("getRowData");
                                for (var i = 0; i < rows.length; i++) {
                                    var rowid = rowids[i];
                                    var row = rows[i];
                                    if (row.CarNo == $("#formCar #CarNo").val().trim() && rowid != objMain.objWorkspace.objContent.selectedCarId) {
                                        alert("<%: InnoSoft.LS.Resources.Strings.CarrierCarNoIsExists %>");
                                        return;
                                    }
                                }

                                //获取原车号
                                var oldCarNo = $("#grid1").jqGrid("getRowData", objMain.objWorkspace.objContent.selectedCarId).CarNo;

                                //修改车辆
                                $("#grid1").jqGrid("setRowData", objMain.objWorkspace.objContent.selectedCarId, { CarNo: $("#formCar #CarNo").val().trim(), TrailerNo: $("#formCar #TrailerNo").val().trim(), CarryingCapacity: $("#formCar #CarryingCapacity").val().trim() });

                                //修改驾驶员表格中的车号
                                var rowids = $("#grid2").jqGrid("getDataIDs");
                                var rows = $("#grid2").jqGrid("getRowData");
                                for (var i = 0; i < rows.length; i++) {
                                    var rowid = rowids[i];
                                    var row = rows[i];
                                    var oldCarNos = row.CarNo.split(",");
                                    var newCarNos = new Array();
                                    for (var j = 0; j < oldCarNos.length; j++) {
                                        if (oldCarNos[j] != oldCarNo) {
                                            newCarNos.push(oldCarNos[j]);
                                        }
                                        else {
                                            newCarNos.push($("#formCar #CarNo").val().trim());
                                        }
                                    }
                                    $("#grid2").jqGrid("setRowData", rowid, { CarNo: newCarNos.toString() });
                                }
                            }
                            $(this).dialog("close");
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //2.创建驾驶员表格
            $("#grid2").jqGrid({
                url: "/chenxk/System/LoadCarrierDriverGrid/" + $("#Id").val().trim(),
                datatype: "json",
                mtype: "GET",
                colNames: ["<%: InnoSoft.LS.Resources.Labels.Id %>", "<%: InnoSoft.LS.Resources.Labels.DriverName %>", "<%: InnoSoft.LS.Resources.Labels.LicenseNo %>", "<%: InnoSoft.LS.Resources.Labels.MobileTel %>", "<%: InnoSoft.LS.Resources.Labels.HomeTel %>", "<%: InnoSoft.LS.Resources.Labels.CarNo %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "Name", index: "Name", width: 100, align: "center" },
                    { name: "LicenseNo", index: "LicenseNo", width: 200, align: "center" },
                    { name: "MobileTel", index: "MobileTel", width: 120, align: "center" },
                    { name: "HomeTel", index: "HomeTel", width: 120, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 400}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "",
                sortorder: "asc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedDriverId = rowid;
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

            //新增驾驶员按钮点击事件
            $("#btnNewDriver").button().click(function () {
                objMain.objWorkspace.objContent.newDriver();
            });

            //修改驾驶员按钮点击事件
            $("#btnModifyDriver").button().click(function () {
                objMain.objWorkspace.objContent.modifyDriver();
            });

            //删除驾驶员按钮点击事件
            $("#btnDeleteDriver").button().click(function () {
                objMain.objWorkspace.objContent.deleteDriver();
            });

            //创建驾驶员编辑对话框
            $("#dialogDriver").dialog({
                autoOpen: false,
                height: 450,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formDriver").valid()) {
                            //检查车号
                            var ids = $("#gridCarNo").jqGrid("getGridParam", "selarrrow");
                            if (ids.length == 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarNo %>");
                                return;
                            }

                            //生成车号字符串
                            var carNos = new Array();
                            for (var i = 0; i < ids.length; i++) {
                                var data = $("#gridCarNo").jqGrid("getRowData", ids[i]);
                                carNos.push(data.CarNo);
                            }

                            if (objMain.objWorkspace.objContent.isNewDriver) {
                                //新增驾驶员
                                var rowcount = $("#grid2").jqGrid("getGridParam", "records");
                                if (rowcount == 0) {
                                    $("#grid2").jqGrid("addRowData", 1, {
                                        Name: $("#formDriver #Name").val().trim(),
                                        LicenseNo: $("#formDriver #LicenseNo").val().trim(),
                                        MobileTel: $("#formDriver #MobileTel").val().trim(),
                                        HomeTel: $("#formDriver #HomeTel").val().trim(),
                                        CarNo: carNos.toString()
                                    });
                                }
                                else {
                                    //检查驾驶证号是否重复
                                    var rows = $("#grid2").jqGrid("getRowData");
                                    for (var i = 0; i < rows.length; i++) {
                                        var row = rows[i];
                                        if (row.LicenseNo == $("#formDriver #LicenseNo").val().trim()) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.CarrierDriveLicenseNoIsExists %>");
                                            return;
                                        }
                                    }

                                    var rowids = $("#grid2").jqGrid("getDataIDs");
                                    var rowidLast = rowids[rowcount - 1];

                                    $("#grid2").jqGrid("addRowData", parseFloat(rowidLast) + 1, {
                                        Name: $("#formDriver #Name").val().trim(),
                                        LicenseNo: $("#formDriver #LicenseNo").val().trim(),
                                        MobileTel: $("#formDriver #MobileTel").val().trim(),
                                        HomeTel: $("#formDriver #HomeTel").val().trim(),
                                        CarNo: carNos.toString()
                                    });
                                }
                            }
                            else {
                                //检查驾驶证号是否重复
                                var rowids = $("#grid2").jqGrid("getDataIDs");
                                var rows = $("#grid2").jqGrid("getRowData");
                                for (var i = 0; i < rows.length; i++) {
                                    var rowid = rowids[i];
                                    var row = rows[i];
                                    if (row.LicenseNo == $("#formDriver #LicenseNo").val().trim() && rowid != objMain.objWorkspace.objContent.selectedDriverId) {
                                        alert("<%: InnoSoft.LS.Resources.Strings.CarrierDriveLicenseNoIsExists %>");
                                        return;
                                    }
                                }

                                //修改驾驶员
                                $("#grid2").jqGrid("setRowData", objMain.objWorkspace.objContent.selectedDriverId, {
                                    Name: $("#formDriver #Name").val().trim(),
                                    LicenseNo: $("#formDriver #LicenseNo").val().trim(),
                                    MobileTel: $("#formDriver #MobileTel").val().trim(),
                                    HomeTel: $("#formDriver #HomeTel").val().trim(),
                                    CarNo: carNos.toString()
                                });
                            }
                            $(this).dialog("close");
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //3.创建结算公式表格
            $("#grid3").jqGrid({
                url: "/chenxk/System/LoadCarrierSettlementExpressionGrid/" + $("#Id").val().trim(),
                datatype: "json",
                mtype: "GET",
                colNames: ["<%: InnoSoft.LS.Resources.Labels.Id %>", "<%: InnoSoft.LS.Resources.Labels.PlanType %>", "<%: InnoSoft.LS.Resources.Labels.TransportChargeExpression %>", "<%: InnoSoft.LS.Resources.Labels.TransportPriceExpression %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "TransportChargeExpression", index: "TransportChargeExpression", width: 150, align: "center" },
                    { name: "TransportPriceExpression", index: "TransportPriceExpression", width: 150, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "",
                sortorder: "asc",
                pager: "#pager3",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedSettlementExpressionId = rowid;
                }
            });
            $("#grid3").jqGrid("navGrid", "#pager3", { edit: false, add: false, del: false, search: false });

            //新增结算公式按钮点击事件
            $("#btnNewExpression").button().click(function () {
                objMain.objWorkspace.objContent.newExpression();
            });

            //修改结算公式按钮点击事件
            $("#btnModifyExpression").button().click(function () {
                objMain.objWorkspace.objContent.modifyExpression();
            });

            //删除结算公式按钮点击事件
            $("#btnDeleteExpression").button().click(function () {
                objMain.objWorkspace.objContent.deleteExpression();
            });

            //创建结算公式编辑对话框
            $("#dialogSettlementExpression").dialog({
                autoOpen: false,
                height: 250,
                width: 550,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSettlementExpression").valid()) {
                            //检查运费公式
                            var arrTokens = Tokanize($("#formSettlementExpression #TransportChargeExpression").val().trim());
                            if (arrTokens == null || arrTokens == undefined) {
                                alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                                return false;
                            }
                            if (arrTokens.length <= 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                                return false;
                            }
                            for (var i = 0; i < arrTokens.length; i++) {
                                if (arrTokens[i] != "(" && arrTokens[i] != ")" && IsVariable(arrTokens[i])) {
                                    if (arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.KM %>" &&
                                        arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Tunnages %>" &&
                                        arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Piles %>" &&
                                        arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>") {
                                        alert("<%: InnoSoft.LS.Resources.Strings.NotValidTransportChargeExpressionVariable %>");
                                        return false;
                                    }
                                }
                            }

                            //检查单价公式
                            arrTokens = Tokanize($("#formSettlementExpression #TransportPriceExpression").val().trim());
                            if (arrTokens == null || arrTokens == undefined) {
                                alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                                return false;
                            }
                            if (arrTokens.length <= 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                                return false;
                            }
                            for (var i = 0; i < arrTokens.length; i++) {
                                if (arrTokens[i] != "(" && arrTokens[i] != ")" && IsVariable(arrTokens[i])) {
                                    if (arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.KM %>" &&
                                        arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Tunnages %>" &&
                                        arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Piles %>" &&
                                        arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>") {
                                        alert("<%: InnoSoft.LS.Resources.Strings.NotValidTransportPriceExpressionVariable %>");
                                        return false;
                                    }
                                }
                            }

                            //新增结算公式
                            if (objMain.objWorkspace.objContent.isNewSettlementExpression) {
                                var rowcount = $("#grid3").jqGrid("getGridParam", "records");
                                if (rowcount == 0) {
                                    $("#grid3").jqGrid("addRowData", 1, { PlanType: $("#formSettlementExpression #PlanType").val().trim(), TransportChargeExpression: $("#formSettlementExpression #TransportChargeExpression").val().trim(), TransportPriceExpression: $("#formSettlementExpression #TransportPriceExpression").val().trim() });
                                }
                                else {
                                    //检查计划类别是否重复
                                    var rows = $("#grid3").jqGrid("getRowData");
                                    for (var i = 0; i < rows.length; i++) {
                                        var row = rows[i];
                                        if (row.PlanType == $("#formSettlementExpression #PlanType").val().trim()) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.CarrierSettlementExpressionIsExists %>");
                                            return;
                                        }
                                    }

                                    var rowids = $("#grid3").jqGrid("getDataIDs");
                                    var rowidLast = rowids[rowcount - 1];

                                    $("#grid3").jqGrid("addRowData", parseFloat(rowidLast) + 1, { PlanType: $("#formSettlementExpression #PlanType").val().trim(), TransportChargeExpression: $("#formSettlementExpression #TransportChargeExpression").val().trim(), TransportPriceExpression: $("#formSettlementExpression #TransportPriceExpression").val().trim() });
                                }
                            }
                            //修改结算公式
                            else {
                                //检查计划类别是否重复
                                var rowids = $("#grid3").jqGrid("getDataIDs");
                                var rows = $("#grid3").jqGrid("getRowData");
                                for (var i = 0; i < rows.length; i++) {
                                    var rowid = rowids[i];
                                    var row = rows[i];
                                    if (row.PlanType == $("#formSettlementExpression #PlanType").val().trim() && rowid != objMain.objWorkspace.objContent.selectedSettlementExpressionId) {
                                        alert("<%: InnoSoft.LS.Resources.Strings.CarrierSettlementExpressionIsExists %>");
                                        return;
                                    }
                                }

                                $("#grid3").jqGrid("setRowData", objMain.objWorkspace.objContent.selectedSettlementExpressionId, { PlanType: $("#formSettlementExpression #PlanType").val().trim(), TransportChargeExpression: $("#formSettlementExpression #TransportChargeExpression").val().trim(), TransportPriceExpression: $("#formSettlementExpression #TransportPriceExpression").val().trim() });
                            }
                            $(this).dialog("close");
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

            //设置运费公式自动完成
            var transportChargeExpressions = [
                "<%: InnoSoft.LS.Resources.Strings.TransportChargeExpression1 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportChargeExpression2 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportChargeExpression3 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportChargeExpression4 %>"
            ];
            $("#formSettlementExpression #TransportChargeExpression").autocomplete({
                source: transportChargeExpressions
            });

            //设置运费价格公式自动完成
            var transportPriceExpressions = [
                "<%: InnoSoft.LS.Resources.Strings.TransportPriceExpression1 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportPriceExpression2 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportPriceExpression3 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportPriceExpression4 %>"
            ];
            $("#formSettlementExpression #TransportPriceExpression").autocomplete({
                source: transportPriceExpressions
            });

            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //4.创建承运价格表格
            $("#grid4").jqGrid({
                url: "/chenxk/System/LoadCarrierTransportPriceGrid/" + $("#Id").val().trim(),
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartCountry %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartProvince %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartCity %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestCountry %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestProvince %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestCity %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.EndTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "StartCountry", index: "StartCountry", width: 80, align: "center" },
                    { name: "StartProvince", index: "StartProvince", width: 150, align: "center" },
                    { name: "StartCity", index: "StartCity", width: 100, align: "center" },
                    { name: "DestCountry", index: "DestCountry", width: 80, align: "center" },
                    { name: "DestProvince", index: "DestProvince", width: 150, align: "center" },
                    { name: "DestCity", index: "DestCity", width: 100, align: "center" },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "StartTime", index: "StartTime", width: 80 },
                    { name: "EndTime", index: "EndTime", width: 80 },
                    { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "",
                sortorder: "asc",
                pager: "#pager4",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedTransportPriceId = rowid;
                }
            });
            $("#grid4").jqGrid("navGrid", "#pager4", { edit: false, add: false, del: false, search: false });

            //新增承运价格按钮点击事件
            $("#btnNewPrice").button().click(function () {
                objMain.objWorkspace.objContent.newTransportPrice();
            });

            //修改承运价格按钮点击事件
            $("#btnModifyPrice").button().click(function () {
                objMain.objWorkspace.objContent.modifyTransportPrice();
            });

            //删除承运价格按钮点击事件
            $("#btnDeletePrice").button().click(function () {
                objMain.objWorkspace.objContent.deleteTransportPrice();
            });

            //创建承运价格编辑对话框
            $("#dialogTransportPrice").dialog({
                autoOpen: false,
                height: 500,
                width: 600,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formTransportPrice").valid()) {
                            if (objMain.objWorkspace.objContent.isNewTransportPrice) {
                                //新增承运价格
                                var rowcount = $("#grid4").jqGrid("getGridParam", "records");
                                if (rowcount == 0) {
                                    $("#grid4").jqGrid("addRowData", 1, {
                                        StartCountry: $("#formTransportPrice #StartCountry").val().trim(),
                                        StartProvince: $("#formTransportPrice #StartProvince").val().trim(),
                                        StartCity: $("#formTransportPrice #StartCity").val().trim(),
                                        DestCountry: $("#formTransportPrice #DestCountry").val().trim(),
                                        DestProvince: $("#formTransportPrice #DestProvince").val().trim(),
                                        DestCity: $("#formTransportPrice #DestCity").val().trim(),
                                        PlanType: $("#formTransportPrice #PlanType").val().trim(),
                                        StartTime: $("#formTransportPrice #StartTime").val().trim(),
                                        EndTime: $("#formTransportPrice #EndTime").val().trim(),
                                        TransportPrice: $("#formTransportPrice #TransportPrice").val().trim()
                                    });
                                }
                                else {
                                    //检查记录是否重复
                                    var rows = $("#grid4").jqGrid("getRowData");
                                    for (var i = 0; i < rows.length; i++) {
                                        var row = rows[i];
                                        if (row.StartCountry == $("#formTransportPrice #StartCountry").val().trim() &&
                                            row.StartProvince == $("#formTransportPrice #StartProvince").val().trim() &&
                                            row.StartCity == $("#formTransportPrice #StartCity").val().trim() &&
                                            row.DestCountry == $("#formTransportPrice #DestCountry").val().trim() &&
                                            row.DestProvince == $("#formTransportPrice #DestProvince").val().trim() &&
                                            row.DestCity == $("#formTransportPrice #DestCity").val().trim() &&
                                            row.PlanType == $("#formTransportPrice #PlanType").val().trim() &&
                                            row.StartTime < $("#formTransportPrice #EndTime").val().trim() &&
                                            row.EndTime > $("#formTransportPrice #StartTime").val().trim()) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.CarrierTransportPriceIsExists %>");
                                            return;
                                        }
                                    }

                                    var rowids = $("#grid4").jqGrid("getDataIDs");
                                    var rowidLast = rowids[rowcount - 1];

                                    $("#grid4").jqGrid("addRowData", parseFloat(rowidLast) + 1, {
                                        StartCountry: $("#formTransportPrice #StartCountry").val().trim(),
                                        StartProvince: $("#formTransportPrice #StartProvince").val().trim(),
                                        StartCity: $("#formTransportPrice #StartCity").val().trim(),
                                        DestCountry: $("#formTransportPrice #DestCountry").val().trim(),
                                        DestProvince: $("#formTransportPrice #DestProvince").val().trim(),
                                        DestCity: $("#formTransportPrice #DestCity").val().trim(),
                                        PlanType: $("#formTransportPrice #PlanType").val().trim(),
                                        StartTime: $("#formTransportPrice #StartTime").val().trim(),
                                        EndTime: $("#formTransportPrice #EndTime").val().trim(),
                                        TransportPrice: $("#formTransportPrice #TransportPrice").val().trim()
                                    });
                                }
                            }
                            else {
                                //检查记录是否重复
                                var rowids = $("#grid4").jqGrid("getDataIDs");
                                var rows = $("#grid4").jqGrid("getRowData");
                                for (var i = 0; i < rows.length; i++) {
                                    var rowid = rowids[i];
                                    var row = rows[i];
                                    if (row.StartCountry == $("#formTransportPrice #StartCountry").val().trim() &&
                                        row.StartProvince == $("#formTransportPrice #StartProvince").val().trim() &&
                                        row.StartCity == $("#formTransportPrice #StartCity").val().trim() &&
                                        row.DestCountry == $("#formTransportPrice #DestCountry").val().trim() &&
                                        row.DestProvince == $("#formTransportPrice #DestProvince").val().trim() &&
                                        row.DestCity == $("#formTransportPrice #DestCity").val().trim() &&
                                        row.PlanType == $("#formTransportPrice #PlanType").val().trim() &&
                                        row.StartTime < $("#formTransportPrice #EndTime").val().trim() &&
                                        row.EndTime > $("#formTransportPrice #StartTime").val().trim() &&
                                        rowid != objMain.objWorkspace.objContent.selectedTransportPriceId) {
                                        alert("<%: InnoSoft.LS.Resources.Strings.CarrierTransportPriceIsExists %>");
                                        return;
                                    }
                                }

                                //修改承运价格
                                $("#grid4").jqGrid("setRowData", objMain.objWorkspace.objContent.selectedTransportPriceId, {
                                    StartCountry: $("#formTransportPrice #StartCountry").val().trim(),
                                    StartProvince: $("#formTransportPrice #StartProvince").val().trim(),
                                    StartCity: $("#formTransportPrice #StartCity").val().trim(),
                                    DestCountry: $("#formTransportPrice #DestCountry").val().trim(),
                                    DestProvince: $("#formTransportPrice #DestProvince").val().trim(),
                                    DestCity: $("#formTransportPrice #DestCity").val().trim(),
                                    PlanType: $("#formTransportPrice #PlanType").val().trim(),
                                    StartTime: $("#formTransportPrice #StartTime").val().trim(),
                                    EndTime: $("#formTransportPrice #EndTime").val().trim(),
                                    TransportPrice: $("#formTransportPrice #TransportPrice").val().trim()
                                });
                            }
                            $(this).dialog("close");
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //5.提交事件
            $("#form1").submit(function () {
                if ($(this).valid()) {
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

                    //获取所有车辆数据
                    var rows1 = $("#grid1").jqGrid("getRowData");
                    var cars = new Array();
                    for (var i = 0; i < rows1.length; i++) {
                        var row1 = rows1[i];
                        var c = {
                            "Id": row1.Id,
                            "CarrierId": $("#Id").val().trim(),
                            "CarNo": row1.CarNo,
                            "TrailerNo": row1.TrailerNo,
                            "CarryingCapacity": row1.CarryingCapacity
                        };
                        cars.push(c);
                    }

                    //获取所有驾驶员数据
                    var rows2 = $("#grid2").jqGrid("getRowData");
                    var drivers = new Array();
                    for (var j = 0; j < rows2.length; j++) {
                        var row2 = rows2[j];
                        var d = {
                            "CarrierId": $("#Id").val().trim(),
                            "CarNo": row2.CarNo,
                            "Name": row2.Name,
                            "LicenseNo": row2.LicenseNo,
                            "MobileTel": row2.MobileTel,
                            "HomeTel": row2.HomeTel
                        };
                        drivers.push(d);
                    }

                    //获取所有结算公式数据
                    var rows3 = $("#grid3").jqGrid("getRowData");
                    var expressions = new Array();
                    for (var n = 0; n < rows3.length; n++) {
                        var row3 = rows3[n];
                        var e = {
                            "CarrierId": $("#Id").val().trim(),
                            "PlanType": row3.PlanType,
                            "TransportChargeExpression": row3.TransportChargeExpression,
                            "TransportPriceExpression": row3.TransportPriceExpression
                        };
                        expressions.push(e);
                    }

                    //获取所有承运价格数据
                    var rows4 = $("#grid4").jqGrid("getRowData");
                    var prices = new Array();
                    for (var m = 0; m < rows4.length; m++) {
                        var row4 = rows4[m];
                        var p = {
                            "CarrierId": $("#Id").val().trim(),
                            "StartCountry": row4.StartCountry,
                            "StartProvince": row4.StartProvince,
                            "StartCity": row4.StartCity,
                            "DestCountry": row4.DestCountry,
                            "DestProvince": row4.DestProvince,
                            "DestCity": row4.DestCity,
                            "PlanType": row4.PlanType,
                            "StartTime": row4.StartTime,
                            "EndTime": row4.EndTime,
                            "TransportPrice": row4.TransportPrice
                        };
                        prices.push(p);
                    }

                    //生成JSON数据
                    var o = {
                        "Id": $("#Id").val().trim(),
                        "Name": $("#Name").val().trim(),
                        "BusinessType": $("#BusinessType").val().trim(),
                        "PaymentType": $("#PaymentType").val().trim(),
                        "Cars": cars,
                        "Drivers": drivers,
                        "SettlementExpressions": expressions,
                        "TransportPrices": prices
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
                                location.replace("/chenxk/System/SetCarrier/");
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
