<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.DispatchBillViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.NewDispatchBill %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Dispatch/SubmitDispatchBills/" onclick="javascript:objMain.objWorkspace.objContent.back(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.save();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.CarInfo %></legend>
        <% using (Html.BeginForm("", "", FormMethod.Post, new { id = "form1" }))
           { %>
        <%: Html.HiddenFor(model => model.CarrierId) %>
        <table>
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
                        <%: Html.LabelFor(model => model.CarrierName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CarrierName) %>
                        <%: Html.ValidationMessageFor(model => model.CarrierName) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CarryingCapacity) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CarryingCapacity) %>
                        <%: Html.ValidationMessageFor(model => model.CarryingCapacity) %>
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
                        <%: Html.DropDownListFor(model => model.BusinessType, new SelectListItem[] { new SelectListItem { Text = InnoSoft.LS.Resources.Options.SelfSupport, Value = InnoSoft.LS.Resources.Options.SelfSupport }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.JoinIn, Value = InnoSoft.LS.Resources.Options.JoinIn }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.Prestowage, Value = InnoSoft.LS.Resources.Options.Prestowage, Selected = true } }, new { style = "font-family: Arial;" })%>
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
                        <%: Html.DropDownListFor(model => model.PaymentType, new SelectListItem[] { new SelectListItem { Text = InnoSoft.LS.Resources.Options.MonthlyStatement, Value = InnoSoft.LS.Resources.Options.MonthlyStatement }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.CashPayment, Value = InnoSoft.LS.Resources.Options.CashPayment, Selected = true } }, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.PaymentType) %>
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
        <% } %>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.DispatchedDeliverPlanList %></legend>
        <div>
            <table id="gridDispatchedDeliverPlans">
            </table>
            <div id="pagerDispatchedDeliverPlans">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnAddPlan" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Add %>
            </button>
            <button id="btnModifyPlan" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify %>
            </button>
            <button id="btnDeletePlan" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete %>
            </button>
        </div>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.DispatchedGoodsList %></legend>
        <div>
            <table id="gridDispatchedGoods">
            </table>
            <div id="pagerDispatchedGoods">
            </div>
        </div>
    </fieldset>
    <div id="dialogAddPlan" title="">
        <fieldset>
            <legend>
                <%: InnoSoft.LS.Resources.Tabs.DispatchDeliverPlanList %></legend>
            <div>
                <table id="gridAddDispatchDeliverPlans">
                </table>
                <div id="pagerAddDispatchDeliverPlans">
                </div>
            </div>
        </fieldset>
        <fieldset>
            <legend>
                <%: InnoSoft.LS.Resources.Tabs.DispatchGoodsList %></legend>
            <div>
                <table id="gridAddDispatchGoods">
                </table>
                <div id="pagerAddDispatchGoods">
                </div>
            </div>
        </fieldset>
        <fieldset>
            <legend>
                <%: InnoSoft.LS.Resources.Tabs.TransportChargesCompute %></legend>
            <% Html.RenderPartial("AddPlanComputeTransportCharges", Model.DeliverPlans[0]); %>
        </fieldset>
    </div>
    <div id="dialogModifyPlan" title="">
        <fieldset>
            <legend>
                <%: InnoSoft.LS.Resources.Tabs.DispatchGoodsList %></legend>
            <div>
                <table id="gridModifyDispatchGoods">
                </table>
                <div id="pagerModifyDispatchGoods">
                </div>
            </div>
        </fieldset>
        <fieldset>
            <legend>
                <%: InnoSoft.LS.Resources.Tabs.TransportChargesCompute %></legend>
            <% Html.RenderPartial("ModifyPlanComputeTransportCharges", Model.DeliverPlans[0]); %>
        </fieldset>
    </div>
    <script type="text/javascript">
        //运费公式列表
        var transportChargeExpressions = [
                "<%: InnoSoft.LS.Resources.Strings.TransportChargeExpression1 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportChargeExpression2 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportChargeExpression3 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportChargeExpression4 %>"
        ];

        //运费价格公式列表
        var transportPriceExpressions = [
                "<%: InnoSoft.LS.Resources.Strings.TransportPriceExpression1 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportPriceExpression2 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportPriceExpression3 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportPriceExpression4 %>"
        ];

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中已配载计划编码
            this.selectedDispatchedPlanId = null;
            //当前选中的待调度计划编码
            this.selectedDispatchPlanId = null;
            //检查自提计划定时器
            this.timerCheckPickUpSelfDeliverPlans = null;
            //车辆信息改变标志
            this.isCarInfoChanged = false;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#gridDispatchedDeliverPlans").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
                $("#gridDispatchedGoods").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认车型获得焦点
                $("#form1 #CarType").focus();
            };
            //添加计划
            this.addDispatchedPlan = function () {
                if ($("#form1").valid()) {
                    //清除当前选中的待调度计划编码
                    objMain.objWorkspace.objContent.selectedDispatchPlanId = null;

                    //刷新待调度计划表格
                    $("#gridAddDispatchDeliverPlans").jqGrid("setGridParam", {
                        url: "/chenxk/Dispatch/LoadDispatchDeliverPlansGrid/",
                        postData: { carNo: "" }
                    });
                    $("#gridAddDispatchDeliverPlans").trigger("reloadGrid", [{ page: 1 }]);

                    //清除待调度货物表格
                    $("#gridAddDispatchGoods").jqGrid("GridUnload", "#gridAddDispatchGoods");

                    //初始化运费编辑控件
                    $("#formAddPlanComputeTransportCharges #TransportChargeExpression").val("");
                    $("#formAddPlanComputeTransportCharges #TransportPriceExpression").val("");
                    $("#formAddPlanComputeTransportCharges #KM").val("0");
                    $("#formAddPlanComputeTransportCharges #AgreementTransportPrice").val("0.00");
                    $("#formAddPlanComputeTransportCharges #ActualTransportPrice").val("0.00");
                    $("#formAddPlanComputeTransportCharges #TransportCharges").val("0.00");
                    $("#formAddPlanComputeTransportCharges #Remark").val("");

                    //打开对话框
                    $("#dialogAddPlan").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.AddDispatchedPlan %>");
                    $("#dialogAddPlan").dialog("open");
                }
                else {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCompleteAndCorrectCarInfo %>");
                }
            };
            //修改计划
            this.modifyDispatchedPlan = function () {
                if (objMain.objWorkspace.objContent.selectedDispatchedPlanId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedDispatchedPlan %>");
                    return;
                }
                if ($("#form1").valid()) {
                    var data = $("#gridDispatchedDeliverPlans").jqGrid("getRowData", objMain.objWorkspace.objContent.selectedDispatchedPlanId);

                    //#region 初始化已调度货物表格
                    //纸发货计划
                    if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.PaperPlan %>") {
                        //#region 创建已调度货物表格
                        $("#gridModifyDispatchGoods").jqGrid("GridUnload", "#gridModifyDispatchGoods");
                        $("#gridModifyDispatchGoods").jqGrid({
                            url: "/chenxk/Dispatch/LoadDispatchedPaperPlanGoodsGrid",
                            datatype: "json",
                            mtype: "GET",
                            postData: {
                                dispatchBillId: data.DispatchBillId,
                                planId: data.PlanId
                            },
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
                                "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualPieces %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualTunnages %>"],
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
                                { name: "Location", index: "Location", width: 50, align: "center" },
                                { name: "Packages", index: "Packages", width: 60, align: "center" },
                                { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                                { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                                { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                                { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                                { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center" },
                                { name: "ActualPackages", index: "ActualPackages", width: 60, align: "center", editable: true },
                                { name: "ActualTunnages", index: "ActualTunnages", width: 100, align: "center", editable: true }],
                            rowNum: 500,
                            rowList: [50, 100, 500, 1000, 5000],
                            sortname: "GoodsNo",
                            sortorder: "asc",
                            pager: "#pagerModifyDispatchGoods",
                            viewrecords: true,
                            emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                            shrinkToFit: false,
                            footerrow: true,
                            userDataOnFooter: true,
                            cellEdit: true,
                            cellsubmit: "clientArray",
                            loadError: function (xhr, status, error) {
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            },
                            afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                                //失去焦点自动保存
                                $("#" + iRow + "_" + cellname).bind("blur", function () {
                                    $("#gridModifyDispatchGoods").jqGrid("saveCell", iRow, iCol);
                                });
                            },
                            afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                                if (cellname == "ActualPackages") {
                                    //计算实发吨数
                                    var actualPackages = parseInt(value);
                                    if (isNaN(actualPackages)) {
                                        $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                        alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotValidNumeric %>");
                                    }
                                    else if (actualPackages < 0) {
                                        $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                        alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotGreaterThanOrEqualZero %>");
                                    }
                                    else {
                                        var row = $("#gridModifyDispatchGoods").jqGrid("getRowData", rowid);
                                        if (actualPackages > parseInt(row.Packages)) {
                                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesCanNotGreaterThanPackages %>");
                                        }
                                        else {
                                            if (row.PieceWeight == null || row.PieceWeight == "") {
                                                $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: "0" });
                                            }
                                            else {
                                                var actualTunnages = mul(actualPackages, parseFloat(row.PieceWeight));
                                                $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: Math.round(actualTunnages * Math.pow(10, 6)) / Math.pow(10, 6) });
                                            }
                                        }
                                    }
                            }
                            else if (cellname == "ActualTunnages") {
                                //计算件重
                                var actualTunnages = parseFloat(value);
                                if (isNaN(actualTunnages)) {
                                    $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                    alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotValidNumeric %>");
                                    }
                                    else if (actualTunnages <= 0) {
                                        $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                        alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotGreaterThanZero %>");
                                    }
                                    else {
                                        //检查件数
                                        var row = $("#gridModifyDispatchGoods").jqGrid("getRowData", rowid);
                                        var actualPackages = 0;
                                        if (row.ActualPackages != null && row.ActualPackages != "") {
                                            actualPackages = parseInt(row.ActualPackages);
                                        }
                                        if (actualPackages == 0) {
                                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPackages %>");
                                        }
                                        else {
                                            //计算件重
                                            var pieceWeight = div(actualTunnages, actualPackages);
                                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { PieceWeight: Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6) });
                                        }
                                    }
                            }

                                //合计实发件数和实发吨数
                                var totalActualPackages = 0;
                                var totalActualTunnages = 0;
                                var rows = $("#gridModifyDispatchGoods").jqGrid("getRowData");
                                for (var i = 0; i < rows.length; i++) {
                                    var row = rows[i];
                                    totalActualPackages = add(totalActualPackages, parseInt(row.ActualPackages));
                                    totalActualTunnages = add(totalActualTunnages, parseFloat(row.ActualTunnages));
                                }
                                $("#gridModifyDispatchGoods").jqGrid("footerData", "set", { ActualPackages: totalActualPackages, ActualTunnages: totalActualTunnages });

                                //计算运费
                                ModifyPlanComputeTransportCharges();
                            }
                        });
                $("#gridModifyDispatchGoods").jqGrid("navGrid", "#pagerModifyDispatchGoods", { edit: false, add: false, del: false, search: false });
                        //#endregion

                        //#region 隐藏公里数编辑框
                $("#formModifyPlanComputeTransportCharges tr:eq(2)").hide();
                        //#endregion
            }
                        //纸直发货计划
            else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverPaperPlan %>") {
                        //#region 创建已调度货物表格
                        $("#gridModifyDispatchGoods").jqGrid("GridUnload", "#gridModifyDispatchGoods");
                        $("#gridModifyDispatchGoods").jqGrid({
                            url: "/chenxk/Dispatch/LoadDispatchedNotDeliverPaperPlanGoodsGrid",
                            datatype: "json",
                            mtype: "GET",
                            postData: {
                                dispatchBillId: data.DispatchBillId,
                                planId: data.PlanId
                            },
                            colNames: [
                                "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                                "<%: InnoSoft.LS.Resources.Labels.Brand %>",
                                "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                                "<%: InnoSoft.LS.Resources.Labels.GrammeWeight %>",
                                "<%: InnoSoft.LS.Resources.Labels.Grade %>",
                                "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                                "<%: InnoSoft.LS.Resources.Labels.PieceWeight %>",
                                "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                                "<%: InnoSoft.LS.Resources.Labels.PackingSpecification %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualPieces %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualTunnages %>"],
                            colModel: [
                                { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                                { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                                { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                                { name: "Brand", index: "Brand", width: 80, align: "center" },
                                { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                                { name: "GWeight", index: "GWeight", width: 50, align: "center" },
                                { name: "Grade", index: "Grade", width: 50, align: "center" },
                                { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                                { name: "Packages", index: "Packages", width: 60, align: "center" },
                                { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                                { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                                { name: "Packing", index: "Packing", width: 50, align: "center" },
                                { name: "ActualPackages", index: "ActualPackages", width: 60, align: "center", editable: true },
                                { name: "ActualTunnages", index: "ActualTunnages", width: 100, align: "center", editable: true }],
                            rowNum: 500,
                            rowList: [50, 100, 500, 1000, 5000],
                            sortname: "GoodsNo",
                            sortorder: "asc",
                            pager: "#pagerModifyDispatchGoods",
                            viewrecords: true,
                            emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                            shrinkToFit: false,
                            footerrow: true,
                            userDataOnFooter: true,
                            cellEdit: true,
                            cellsubmit: "clientArray",
                            loadError: function (xhr, status, error) {
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            },
                            afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                                //失去焦点自动保存
                                $("#" + iRow + "_" + cellname).bind("blur", function () {
                                    $("#gridModifyDispatchGoods").jqGrid("saveCell", iRow, iCol);
                                });
                            },
                            afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                                if (cellname == "ActualPackages") {
                                    //计算实发吨数
                                    var actualPackages = parseInt(value);
                                    if (isNaN(actualPackages)) {
                                        $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                        alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotValidNumeric %>");
                                    }
                                    else if (actualPackages < 0) {
                                        $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                        alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotGreaterThanOrEqualZero %>");
                                    }
                                    else {
                                        var row = $("#gridModifyDispatchGoods").jqGrid("getRowData", rowid);
                                        if (actualPackages > parseInt(row.Packages)) {
                                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesCanNotGreaterThanPackages %>");
                                        }
                                        else {
                                            if (row.PieceWeight == null || row.PieceWeight == "") {
                                                $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: "0" });
                                            }
                                            else {
                                                var actualTunnages = mul(actualPackages, parseFloat(row.PieceWeight));
                                                $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: Math.round(actualTunnages * Math.pow(10, 6)) / Math.pow(10, 6) });
                                            }
                                        }
                                    }
                            }
                            else if (cellname == "ActualTunnages") {
                                //计算件重
                                var actualTunnages = parseFloat(value);
                                if (isNaN(actualTunnages)) {
                                    $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                    alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotValidNumeric %>");
                                    }
                                    else if (actualTunnages <= 0) {
                                        $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                        alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotGreaterThanZero %>");
                                    }
                                    else {
                                        //检查件数
                                        var row = $("#gridModifyDispatchGoods").jqGrid("getRowData", rowid);
                                        var actualPackages = 0;
                                        if (row.ActualPackages != null && row.ActualPackages != "") {
                                            actualPackages = parseInt(row.ActualPackages);
                                        }
                                        if (actualPackages == 0) {
                                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPackages %>");
                                        }
                                        else {
                                            //计算件重
                                            var pieceWeight = div(actualTunnages, actualPackages);
                                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { PieceWeight: Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6) });
                                        }
                                    }
                            }

                                //合计实发件数和实发吨数
                                var totalActualPackages = 0;
                                var totalActualTunnages = 0;
                                var rows = $("#gridModifyDispatchGoods").jqGrid("getRowData");
                                for (var i = 0; i < rows.length; i++) {
                                    var row = rows[i];
                                    totalActualPackages = add(totalActualPackages, parseInt(row.ActualPackages));
                                    totalActualTunnages = add(totalActualTunnages, parseFloat(row.ActualTunnages));
                                }
                                $("#gridModifyDispatchGoods").jqGrid("footerData", "set", { ActualPackages: totalActualPackages, ActualTunnages: totalActualTunnages });

                                //计算运费
                                ModifyPlanComputeTransportCharges();
                            }
                        });
                $("#gridModifyDispatchGoods").jqGrid("navGrid", "#pagerModifyDispatchGoods", { edit: false, add: false, del: false, search: false });
                //#endregion

                        //#region 隐藏公里数编辑框
                $("#formModifyPlanComputeTransportCharges tr:eq(2)").hide();
                        //#endregion
            }
                        //罐发货计划
            else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.CanPlan %>") {
                //#region 创建已调度货物表格
                $("#gridModifyDispatchGoods").jqGrid("GridUnload", "#gridModifyDispatchGoods");
                $("#gridModifyDispatchGoods").jqGrid({
                    url: "/chenxk/Dispatch/LoadDispatchedCanPlanGoodsGrid",
                    datatype: "json",
                    mtype: "GET",
                    postData: {
                        dispatchBillId: data.DispatchBillId,
                        planId: data.PlanId
                    },
                    colNames: [
                        "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                                "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                                "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                                "<%: InnoSoft.LS.Resources.Labels.Location %>",
                                "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                                "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                                "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                                "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillId %>",
                                "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualPiles %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualTenThousands %>"],
                            colModel: [
                                { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                                { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                                { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                                { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                                { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                                { name: "Warehouse", index: "Warehouse", width: 80, align: "center" },
                                { name: "Location", index: "Location", width: 50, align: "center" },
                                { name: "Piles", index: "Piles", width: 100, align: "center" },
                                { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                                { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                                { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                                { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center" },
                                { name: "ActualPiles", index: "ActualPiles", width: 100, align: "center", editable: true },
                                { name: "ActualTenThousands", index: "ActualTenThousands", width: 100, align: "center", editable: true }],
                            rowNum: 500,
                            rowList: [50, 100, 500, 1000, 5000],
                            sortname: "GoodsNo",
                            sortorder: "asc",
                            pager: "#pagerModifyDispatchGoods",
                            viewrecords: true,
                            emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                cellEdit: true,
                cellsubmit: "clientArray",
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                    //失去焦点自动保存
                    $("#" + iRow + "_" + cellname).bind("blur", function () {
                        $("#gridModifyDispatchGoods").jqGrid("saveCell", iRow, iCol);
                    });
                },
                afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                    //检查实发垛数
                    if (cellname == "ActualPiles") {
                        var actualPiles = parseFloat(value);
                        if (isNaN(actualPiles)) {
                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesNotValidNumeric %>");
                        }
                        else if (actualPiles < 0) {
                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesNotGreaterThanOrEqualZero %>");
                        }
                        else {
                            var row = $("#gridModifyDispatchGoods").jqGrid("getRowData", rowid);
                            if (actualPiles > parseFloat(row.Piles)) {
                                $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                                alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesCanNotGreaterThanPiles %>");
                            }
                        }
                }

                    //检查实发万只
                    if (cellname == "ActualTenThousands") {
                        var actualTenThousands = parseFloat(value);
                        if (isNaN(actualTenThousands)) {
                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsNotValidNumeric %>");
                        }
                        else if (actualTenThousands < 0) {
                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsNotGreaterThanOrEqualZero %>");
                        }
                        else {
                            var row = $("#gridModifyDispatchGoods").jqGrid("getRowData", rowid);
                            if (actualTenThousands > parseFloat(row.TenThousands)) {
                                $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                                alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsCanNotGreaterThanTenThousands %>");
                            }
                        }
                }

                    //合计实发垛数和万只
                    var totalActualPiles = 0;
                    var totalActualTenThousands = 0;
                    var rows = $("#gridModifyDispatchGoods").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        totalActualPiles = add(totalActualPiles, parseFloat(row.ActualPiles));
                        totalActualTenThousands = add(totalActualTenThousands, parseFloat(row.ActualTenThousands));
                    }
                    $("#gridModifyDispatchGoods").jqGrid("footerData", "set", { ActualPiles: totalActualPiles, ActualTenThousands: totalActualTenThousands });

                    //计算运费
                    ModifyPlanComputeTransportCharges();
                }
                        });
        $("#gridModifyDispatchGoods").jqGrid("navGrid", "#pagerModifyDispatchGoods", { edit: false, add: false, del: false, search: false });
            //#endregion

            //#region 隐藏公里数编辑框
        $("#formModifyPlanComputeTransportCharges tr:eq(2)").hide();
            //#endregion
    }
            //罐直发货计划
    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverCanPlan %>") {
            //#region 创建已调度货物表格
            $("#gridModifyDispatchGoods").jqGrid("GridUnload", "#gridModifyDispatchGoods");
            $("#gridModifyDispatchGoods").jqGrid({
                url: "/chenxk/Dispatch/LoadDispatchedNotDeliverCanPlanGoodsGrid",
                datatype: "json",
                mtype: "GET",
                postData: {
                    dispatchBillId: data.DispatchBillId,
                    planId: data.PlanId
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                                "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                                "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                                "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualPiles %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualTenThousands %>"],
                colModel: [
                    { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                    { name: "ActualPiles", index: "ActualPiles", width: 100, align: "center", editable: true },
                    { name: "ActualTenThousands", index: "ActualTenThousands", width: 100, align: "center", editable: true }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "GoodsNo",
                sortorder: "asc",
                pager: "#pagerModifyDispatchGoods",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                cellEdit: true,
                cellsubmit: "clientArray",
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                    //失去焦点自动保存
                    $("#" + iRow + "_" + cellname).bind("blur", function () {
                        $("#gridModifyDispatchGoods").jqGrid("saveCell", iRow, iCol);
                    });
                },
                afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                    //检查实发垛数
                    if (cellname == "ActualPiles") {
                        var actualPiles = parseFloat(value);
                        if (isNaN(actualPiles)) {
                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesNotValidNumeric %>");
                        }
                        else if (actualPiles < 0) {
                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesNotGreaterThanOrEqualZero %>");
                        }
                        else {
                            var row = $("#gridModifyDispatchGoods").jqGrid("getRowData", rowid);
                            if (actualPiles > parseFloat(row.Piles)) {
                                $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                                alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesCanNotGreaterThanPiles %>");
                            }
                        }
                }

                    //检查实发万只
                    if (cellname == "ActualTenThousands") {
                        var actualTenThousands = parseFloat(value);
                        if (isNaN(actualTenThousands)) {
                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsNotValidNumeric %>");
                        }
                        else if (actualTenThousands < 0) {
                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsNotGreaterThanOrEqualZero %>");
                        }
                        else {
                            var row = $("#gridModifyDispatchGoods").jqGrid("getRowData", rowid);
                            if (actualTenThousands > parseFloat(row.TenThousands)) {
                                $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                                alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsCanNotGreaterThanTenThousands %>");
                            }
                        }
                }

                    //合计实发垛数和万只
                    var totalActualPiles = 0;
                    var totalActualTenThousands = 0;
                    var rows = $("#gridModifyDispatchGoods").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        totalActualPiles = add(totalActualPiles, parseFloat(row.ActualPiles));
                        totalActualTenThousands = add(totalActualTenThousands, parseFloat(row.ActualTenThousands));
                    }
                    $("#gridModifyDispatchGoods").jqGrid("footerData", "set", { ActualPiles: totalActualPiles, ActualTenThousands: totalActualTenThousands });

                    //计算运费
                    ModifyPlanComputeTransportCharges();
                }
            });
        $("#gridModifyDispatchGoods").jqGrid("navGrid", "#pagerModifyDispatchGoods", { edit: false, add: false, del: false, search: false });
        //#endregion

        //#region 隐藏公里数编辑框
        $("#formModifyPlanComputeTransportCharges tr:eq(2)").hide();
        //#endregion
    }
        //方便面发货计划
    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NoodlePlan %>") {
        //#region 创建已调度货物表格
        $("#gridModifyDispatchGoods").jqGrid("GridUnload", "#gridModifyDispatchGoods");
        $("#gridModifyDispatchGoods").jqGrid({
            url: "/chenxk/Dispatch/LoadDispatchedNoodlePlanGoodsGrid",
            datatype: "json",
            mtype: "GET",
            postData: {
                dispatchBillId: data.DispatchBillId,
                planId: data.PlanId
            },
            colNames: [
                "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                                "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                                "<%: InnoSoft.LS.Resources.Labels.Boxes %>",
                                "<%: InnoSoft.LS.Resources.Labels.ConvertCoefficient %>",
                                "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualBoxes %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualTunnages %>"],
            colModel: [
                { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                { name: "Packages", index: "Packages", width: 60, align: "center" },
                { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                { name: "ActualPackages", index: "ActualPackages", width: 60, align: "center", editable: true },
                { name: "ActualTunnages", index: "ActualTunnages", width: 100, align: "center", editable: true }],
            rowNum: 500,
            rowList: [50, 100, 500, 1000, 5000],
            sortname: "GoodsNo",
            sortorder: "asc",
            pager: "#pagerModifyDispatchGoods",
            viewrecords: true,
            emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
            shrinkToFit: false,
            footerrow: true,
            userDataOnFooter: true,
            cellEdit: true,
            cellsubmit: "clientArray",
            loadError: function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            },
            afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                //失去焦点自动保存
                $("#" + iRow + "_" + cellname).bind("blur", function () {
                    $("#gridModifyDispatchGoods").jqGrid("saveCell", iRow, iCol);
                });
            },
            afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                var row = $("#gridModifyDispatchGoods").jqGrid("getRowData", rowid);
                var packages = parseInt(row.Packages);

                //计算实发吨数
                if (cellname == "ActualPackages") {
                    var actualPackages = parseInt(value);
                    if (isNaN(actualPackages)) {
                        $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualBoxesNotValidNumeric %>");
                    }
                    else if (packages > 0 && actualPackages < 0) {
                        $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualBoxesNotGreaterThanOrEqualZero %>");
                    }
                    else if (packages < 0 && actualPackages > 0) {
                        $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualBoxesNotLessThanOrEqualZero %>");
                    }
                    else {
                        if (Math.abs(actualPackages) > Math.abs(packages)) {
                            $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualBoxesCanNotGreaterThanBoxes %>");
                        }
                        else {
                            if (row.PieceWeight == null || row.PieceWeight == "" || parseFloat(row.PieceWeight) == 0) {
                                $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: "0" });
                            }
                            else {
                                var actualTunnages = div(actualPackages, parseFloat(row.PieceWeight));
                                $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: Math.round(actualTunnages * Math.pow(10, 6)) / Math.pow(10, 6) });
                            }
                        }
                    }
        }
        else if (cellname == "ActualTunnages") {
            var actualTunnages = parseFloat(value);
            if (isNaN(actualTunnages)) {
                $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotValidNumeric %>");
            }
            else if (packages > 0 && actualTunnages < 0) {
                $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotGreaterThanOrEqualZero %>");
            }
            else if (packages < 0 && actualTunnages > 0) {
                $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotLessThanOrEqualZero %>");
                }
    }

                //合计实发箱数和实发吨数
                var totalActualPackages = 0;
                var totalActualTunnages = 0;
                var rows = $("#gridModifyDispatchGoods").jqGrid("getRowData");
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    totalActualPackages = add(totalActualPackages, parseInt(row.ActualPackages));
                    totalActualTunnages = add(totalActualTunnages, parseFloat(row.ActualTunnages));
                }
                $("#gridModifyDispatchGoods").jqGrid("footerData", "set", { ActualPackages: totalActualPackages, ActualTunnages: totalActualTunnages });

                //计算运费
                ModifyPlanComputeTransportCharges();
            }
        });
    $("#gridModifyDispatchGoods").jqGrid("navGrid", "#pagerModifyDispatchGoods", { edit: false, add: false, del: false, search: false });
        //#endregion

        //#region 显示公里数编辑框
    $("#formModifyPlanComputeTransportCharges tr:eq(2)").show();
        //#endregion
}
        //其它发货计划
else {
        //#region 创建已调度货物表格
    $("#gridModifyDispatchGoods").jqGrid("GridUnload", "#gridModifyDispatchGoods");
    $("#gridModifyDispatchGoods").jqGrid({
        url: "/chenxk/Dispatch/LoadDispatchedOtherPlanGoodsGrid",
        datatype: "json",
        mtype: "GET",
        postData: {
            dispatchBillId: data.DispatchBillId,
            planId: data.PlanId
        },
        colNames: [
            "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                                "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                                "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                                "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualPieces %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualTunnages %>"],
        colModel: [
            { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
            { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
            { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
            { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
            { name: "Packages", index: "Packages", width: 60, align: "center" },
            { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
            { name: "ActualPackages", index: "ActualPackages", width: 60, align: "center", editable: true },
            { name: "ActualTunnages", index: "ActualTunnages", width: 100, align: "center", editable: true }],
        rowNum: 500,
        rowList: [50, 100, 500, 1000, 5000],
        sortname: "GoodsNo",
        sortorder: "asc",
        pager: "#pagerModifyDispatchGoods",
        viewrecords: true,
        emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
        shrinkToFit: false,
        footerrow: true,
        userDataOnFooter: true,
        cellEdit: true,
        cellsubmit: "clientArray",
        loadError: function (xhr, status, error) {
            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
        },
        afterEditCell: function (rowid, cellname, value, iRow, iCol) {
            //失去焦点自动保存
            $("#" + iRow + "_" + cellname).bind("blur", function () {
                $("#gridModifyDispatchGoods").jqGrid("saveCell", iRow, iCol);
            });
        },
        afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
            //检查实发件数
            if (cellname == "ActualPackages") {
                var actualPackages = parseInt(value);
                if (isNaN(actualPackages)) {
                    $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0" });
                    alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotValidNumeric %>");
                }
                else if (actualPackages < 0) {
                    $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0" });
                    alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotGreaterThanOrEqualZero %>");
                }
                else {
                    var row = $("#gridModifyDispatchGoods").jqGrid("getRowData", rowid);
                    if (actualPackages > parseInt(row.Packages)) {
                        $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesCanNotGreaterThanPackages %>");
                    }
                }
        }

            //检查实发吨数
            if (cellname == "ActualTunnages") {
                var actualTunnages = parseFloat(value);
                if (isNaN(actualTunnages)) {
                    $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: "0" });
                    alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotValidNumeric %>");
                }
                else if (actualTunnages < 0) {
                    $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: "0" });
                    alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotGreaterThanOrEqualZero %>");
                }
                else {
                    var row = $("#gridModifyDispatchGoods").jqGrid("getRowData", rowid);
                    if (actualTunnages > parseFloat(row.Tunnages)) {
                        $("#gridModifyDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesCanNotGreaterThanTunnages %>");
                    }
                }
        }

            //合计实发件数和实发吨数
            var totalActualPackages = 0;
            var totalActualTunnages = 0;
            var rows = $("#gridModifyDispatchGoods").jqGrid("getRowData");
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                totalActualPackages = add(totalActualPackages, parseInt(row.ActualPackages));
                totalActualTunnages = add(totalActualTunnages, parseFloat(row.ActualTunnages));
            }
            $("#gridModifyDispatchGoods").jqGrid("footerData", "set", { ActualPackages: totalActualPackages, ActualTunnages: totalActualTunnages });

            //计算运费
            ModifyPlanComputeTransportCharges();
        }
    });
    $("#gridModifyDispatchGoods").jqGrid("navGrid", "#pagerModifyDispatchGoods", { edit: false, add: false, del: false, search: false });
        //#endregion

        //#region 隐藏公里数编辑框
    $("#formModifyPlanComputeTransportCharges tr:eq(2)").hide();
        //#endregion
}
                    //#endregion

                    //#region 初始化运费计算控件
    $("#formModifyPlanComputeTransportCharges #TransportChargeExpression").val("");
    $("#formModifyPlanComputeTransportCharges #TransportPriceExpression").val("");
    $("#formModifyPlanComputeTransportCharges #KM").val("0");
    $("#formModifyPlanComputeTransportCharges #AgreementTransportPrice").val("0.00");
    $("#formModifyPlanComputeTransportCharges #ActualTransportPrice").val("0.00");
    $("#formModifyPlanComputeTransportCharges #TransportCharges").val("0.00");
    $("#formModifyPlanComputeTransportCharges #Remark").val("");

                    //如果计划为客户自提，则不需要计算运费；否则应初始化结算公式、单价和运费
    $.get("/Common/LoadDeliverPlan", { nPlanId: data.PlanId }, function (ret) {
        if (ret != null) {
            var carNo = ret.CarNo;
            var startCountry = ret.StartCountry;
            var startProvince = ret.StartProvince;
            var startCity = ret.StartCity;
            var destCountry = ret.DestCountry;
            var destProvince = ret.DestProvince;
            var destCity = ret.DestCity;
            var planType = ret.PlanType;
            var receiveType = ret.ReceiveType;
            var createTime = ret.CreateTime;

            //自提
            if (receiveType == "<%: InnoSoft.LS.Resources.Options.PickUpSelf %>" && carNo == $("#form1 #CarNo").val().trim()) {
                //禁用运费编辑控件
                $("#dialogModifyPlan fieldset:last > legend").text("<%: InnoSoft.LS.Resources.Tabs.TransportChargesComputePickUpSelf %>");
                $("#formModifyPlanComputeTransportCharges #TransportChargeExpression").attr("disabled", "disabled");
                $("#formModifyPlanComputeTransportCharges #TransportPriceExpression").attr("disabled", "disabled");
                $("#formModifyPlanComputeTransportCharges #ActualTransportPrice").attr("disabled", "disabled");
                $("#formModifyPlanComputeTransportCharges #TransportCharges").attr("disabled", "disabled");
                $("#formModifyPlanComputeTransportCharges #Remark").attr("disabled", "disabled");
            }
                //配送
            else {
                $("#formModifyPlanComputeTransportCharges #TransportChargeExpression").removeAttr("disabled");
                $("#formModifyPlanComputeTransportCharges #TransportPriceExpression").removeAttr("disabled");
                $("#formModifyPlanComputeTransportCharges #ActualTransportPrice").removeAttr("disabled");
                $("#formModifyPlanComputeTransportCharges #TransportCharges").removeAttr("disabled");
                $("#formModifyPlanComputeTransportCharges #Remark").removeAttr("disabled");

                //读取承运单位信息
                $.get("/Common/LoadCarrier", { carrierId: $("#form1 #CarrierId").val().trim() }, function (ret) {
                    if (ret != null) {
                        var businessType = ret.BusinessType;

                        //如果是月结车辆，则提示运费月结
                        if (ret.PaymentType == "<%: InnoSoft.LS.Resources.Options.MonthlyStatement %>") {
                            $("#dialogModifyPlan fieldset:last > legend").text("<%: InnoSoft.LS.Resources.Tabs.TransportChargesComputeMonthlyStatement %>");
                        }
                        else {
                            $("#dialogModifyPlan fieldset:last > legend").text("<%: InnoSoft.LS.Resources.Tabs.TransportChargesCompute %>");
                        }

                        //读取调度单中该计划数据
                        $.get("/chenxk/Dispatch/LoadDispatchBillDeliverPlan", { dispatchBillId: data.DispatchBillId, planId: data.PlanId }, function (ret) {
                            if (ret != null) {
                                $("#formModifyPlanComputeTransportCharges #TransportChargeExpression").val(ret.TransportChargeExpression);
                                $("#formModifyPlanComputeTransportCharges #TransportPriceExpression").val(ret.TransportPriceExpression);
                                $("#formModifyPlanComputeTransportCharges #KM").val(ret.KM);
                                $("#formModifyPlanComputeTransportCharges #ActualTransportPrice").val(ret.TransportPrice);
                                $("#formModifyPlanComputeTransportCharges #TransportCharges").val(ret.TransportCharges);
                                $("#formModifyPlanComputeTransportCharges #Remark").val(ret.Remark);
                            }

                            //如果承运单位是自营，则承运单位协议价格就是客户结算价格；否则读取承运单位协议单价
                            if (businessType == "<%: InnoSoft.LS.Resources.Options.SelfSupport %>") {
                                $.get("/Common/LoadCustomerTransportPrice", { planId: data.PlanId, carType: $("#form1 #CarType").val().trim() }, function (ret) {
                                    $("#formModifyPlanComputeTransportCharges #AgreementTransportPrice").val(ret);
                                }, "text json").error(function (xhr, status, error) {
                                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                    return;
                                });
                            }
                            else {
                                $.get("/Common/LoadCarrierTransportPrice", { carrierId: $("#form1 #CarrierId").val().trim(), startCountry: startCountry, startProvince: startProvince, startCity: startCity, destCountry: destCountry, destProvince: destProvince, destCity: destCity, planType: planType, createTime: createTime }, function (ret) {
                                    $("#formModifyPlanComputeTransportCharges #AgreementTransportPrice").val(ret);
                                }, "text json").error(function (xhr, status, error) {
                                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                    return;
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            return;
                        });
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    return;
                });
            }
        }
    }, "text json").error(function (xhr, status, error) {
        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
        return;
    });
                    //#endregion

                    //#region 打开对话框
    $("#dialogModifyPlan").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyDispatchedPlan %>");
                    $("#dialogModifyPlan").dialog("open");
                    //#endregion
                }
                else {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCompleteAndCorrectCarInfo %>");
                }
            };
            //删除计划
            this.deleteDispatchedPlan = function () {
                if (objMain.objWorkspace.objContent.selectedDispatchedPlanId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedDispatchedPlan %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteDispatchedPlanConfirm %>") == true) {
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

                    var data = $("#gridDispatchedDeliverPlans").jqGrid("getRowData", objMain.objWorkspace.objContent.selectedDispatchedPlanId);

                    $.post("/chenxk/Dispatch/DeleteDispatchedPlan/", { dispatchBillId: data.DispatchBillId, planId: data.PlanId }, function (ret) {
                        $.unblockUI();

                        if (ret != null && ret != "") {
                            alert(ret);
                        }
                        else {
                            alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceed %>");

                                objMain.objWorkspace.objContent.selectedDispatchedPlanId = null;

                            //刷新已配载计划表格
                                $("#gridDispatchedDeliverPlans").jqGrid("setGridParam", {
                                    url: "/chenxk/Dispatch/LoadDispatchedDeliverPlansGrid/",
                                    postData: { carNo: $("#form1 #CarNo").val().trim() }
                                });
                                $("#gridDispatchedDeliverPlans").trigger("reloadGrid", [{ page: 1 }]);

                            //刷新已配载货物表格
                                $("#gridDispatchedGoods").jqGrid("setGridParam", {
                                    url: "/chenxk/Dispatch/LoadDispatchedGoodsGrid/",
                                    postData: { carNo: $("#form1 #CarNo").val().trim(), planId: "0" }
                                });
                                $("#gridDispatchedGoods").trigger("reloadGrid", [{ page: 1 }]);

                                objMain.objWorkspace.objContent.isCarInfoChanged = true;
                            }
                    });
                    }
            };
            //保存调度单
                this.save = function () {
                    if ($("#gridDispatchedDeliverPlans").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotAddDispatchDeliverPlan %>");
                        return;
                    }
                    if ($("#form1").valid()) {
                        //检查录入时间
                        var createTime = $("#form1 #CreateTime").val().trim();
                        var today = formatDate(new Date(), "yyyy-MM-dd");
                        if (createTime > today) {
                            alert("<%: InnoSoft.LS.Resources.Strings.CreateTimeCantNotGreaterThanSystemTime %>");
                            return;
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

                        //生成空的调度货物JSON数据
                        var goods = new Array();

                        //生成空的调度计划JSON数据
                        var deliverPlans = new Array();
                        var rows = $("#gridDispatchedDeliverPlans").jqGrid("getRowData");
                        for (var i = 0; i < rows.length; i++) {
                            var row = rows[i];
                            var p = {
                                "PlanId": row.PlanId,
                                "Packages": "0",
                                "Tunnages": "0",
                                "Piles": "0",
                                "TenThousands": "0",
                                "TransportChargeExpression": "",
                                "TransportPriceExpression": "",
                                "KM": "0",
                                "AgreementTransportPrice": "0",
                                "ActualTransportPrice": "0",
                                "TransportCharges": "0",
                                "Remark": "",
                                "ReceiveType": row.ReceiveType
                            };
                            deliverPlans.push(p);
                        }

                        //生成调度单JSON数据
                        var dispatchBillId = $("#gridDispatchedDeliverPlans").jqGrid("getRowData")[0].DispatchBillId;
                        var d = {
                            "Id": dispatchBillId,
                            "CarNo": $("#form1 #CarNo").val().trim(),
                            "TrailerNo": $("#form1 #TrailerNo").val().trim(),
                            "CarType": $("#form1 #CarType").val().trim(),
                            "DriverName": $("#form1 #txtDriverName").val().trim(),
                            "DriverLicenseNo": $("#form1 #DriverLicenseNo").val().trim(),
                            "DriverMobileTel": $("#form1 #DriverMobileTel").val().trim(),
                            "DriverHomeTel": $("#form1 #DriverHomeTel").val().trim(),
                            "CarrierId": $("#form1 #CarrierId").val().trim(),
                            "CarrierName": $("#form1 #CarrierName").val().trim(),
                            "CarryingCapacity": $("#form1 #CarryingCapacity").val().trim(),
                            "BusinessType": $("#form1 #BusinessType").val().trim(),
                            "PaymentType": $("#form1 #PaymentType").val().trim(),
                            "CreateTime": $("#form1 #CreateTime").val().trim(),
                            "DeliverPlans": deliverPlans,
                            "Goods": goods
                        };

                        var postData = JSON.stringify(d);

                        //发送数据
                        $.ajax({
                            type: "POST",
                            url: "/chenxk/Dispatch/ModifyDispatchBill/",
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

                                    //关闭对话框
                                    $("#dialogModifyPlan").dialog("close");

                                    objMain.objWorkspace.objContent.isCarInfoChanged = false;

                                    location.replace("/chenxk/Dispatch/SubmitDispatchBills/");
                                }
                            },
                            error: function (xhr, status, error) {
                                $.unblockUI();

                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            }
                        });
                    }
                };
            //返回
                this.back = function (action) {
                    if (objMain.objWorkspace.objContent.isCarInfoChanged && $("#gridDispatchedDeliverPlans").jqGrid("getGridParam", "records") > 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.DispatchBillHadChanged %>");
                        return;
                    }
                    location.replace(action);
                };
            };
            objMain.objWorkspace.objContent = new WorkspaceContent();

            //页面初始化
            $(document).ready(function () {
                $.jStorage.deleteKey("NewDispatchBill_CarNo");

                //#region 1.车辆信息
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置车型失去焦点事件
                $("#form1 #CarType").change(function () {
                    objMain.objWorkspace.objContent.isCarInfoChanged = true;
                });
                $("#form1 #CarType").focusout(function () {
                    $(this).attr("disabled", "disabled");
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置车号自动完成
                $("#form1 #CarNo").autocomplete({
                    source: "/Autocomplete/LoadCarNos/",
                    minLength: 1,
                    change: function (event, ui) {
                        //#region 检查修改车号是否合法
                        var canModifyCarNo = true;
                        var needLoadNewCardNoDispatchedDeliverPlans = true;

                        if ($("#gridDispatchedDeliverPlans").jqGrid("getGridParam", "records") > 0) {
                            $.ajax({
                                url: "/chenxk/Dispatch/LoadDispatchBillByCarNo",
                                type: "GET",
                                data: { strCarNo: $("#form1 #CarNo").val().trim() },
                                dataType: "json",
                                async: false,
                                success: function (ret) {
                                    if (ret != null) {
                                        canModifyCarNo = false;
                                        alert(stringFormat("<%: InnoSoft.LS.Resources.Strings.CanNotModifyCarNo %>", $("#form1 #CarNo").val().trim()));
                                        $("#form1 #CarNo").val($.jStorage.get("NewDispatchBill_CarNo", ""));
                                        return;
                                    }
                                    else {
                                        needLoadNewCardNoDispatchedDeliverPlans = false;
                                    }
                                },
                                error: function (xhr, status, error) {
                                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                    return;
                                }
                            });
                        }
                        if (!canModifyCarNo) {
                            return;
                        }
                        //#endregion

                        //#region 如果原车号下有客户自提的发货计划，则修改后应提示是否将自提改为配送
                        if ($("#gridDispatchedDeliverPlans").jqGrid("getGridParam", "records") > 0) {
                            var rows = $("#gridDispatchedDeliverPlans").jqGrid("getRowData");
                            for (var i = 0; i < rows.length; i++) {
                                var row = rows[i];
                                if (row.ReceiveType == "<%: InnoSoft.LS.Resources.Options.PickUpSelf %>") {
                                    var s = "<%: InnoSoft.LS.Resources.Labels.CustomerName %>: " + row.CustomerName + ", <%: InnoSoft.LS.Resources.Labels.ReceiverName %>: " + row.ReceiverName + ", <%: InnoSoft.LS.Resources.Labels.PlanNo %>: " + row.PlanNo + ", <%: InnoSoft.LS.Resources.Strings.ModifyDeliverPlanReceiveTypeConfirm %>";
                                    if (confirm(s) == true) {
                                        $("#gridDispatchedDeliverPlans").jqGrid("setRowData", row.Id, { ReceiveType: "<%: InnoSoft.LS.Resources.Options.PickUpDelivery %>" });
                                    }
                                }
                            }
                        }
                        //#endregion

                        //#region 填充挂号和载重
                        $("#form1 #TrailerNo").val("");
                        $("#form1 #CarryingCapacity").val("0");

                        $.get("/Common/LoadCarByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (ret) {
                            if (ret != null) {
                                $("#form1 #TrailerNo").val(ret.TrailerNo);
                                $("#form1 #CarryingCapacity").val(ret.CarryingCapacity);
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#form1 #CarNo").val("");
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            return;
                        });
                        //#endregion

                        //#region 填充驾驶员姓名下拉列表
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

                            //如果该车号已有待提交调度单存在，则应将调度单中的驾驶员信息复制到当前界面
                            $.get("/chenxk/Dispatch/LoadDispatchBillByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (ret) {
                                if (ret != null) {
                                    $("#form1 #CarType").val(ret.CarType);
                                    if ($("#form1 #txtDriverName").css("display") == "none") {
                                        var count = $("#form1 #selDriverName option").length;
                                        for (var i = 0; i < count; i++) {
                                            if ($("#form1 #selDriverName").get(0).options[i].text == ret.DriverName) {
                                                $("#form1 #selDriverName").get(0).selectedIndex = i;
                                                break;
                                            }
                                        }
                                        $("#form1 #txtDriverName").val(ret.DriverName);
                                    }
                                    else {
                                        $("#form1 #txtDriverName").val(ret.DriverName);
                                        $("#form1 #selDriverName").empty();
                                        $("#form1 #selDriverName").append("<option value='0'>" + $("#form1 #txtDriverName").val().trim() + "</option>");
                                        $("#form1 #selDriverName").get(0).selectedIndex = 0;
                                    }
                                    $("#form1 #DriverLicenseNo").val(ret.DriverLicenseNo);
                                    $("#form1 #DriverMobileTel").val(ret.DriverMobileTel);
                                    $("#form1 #DriverHomeTel").val(ret.DriverHomeTel);
                                }
                            }, "text json").error(function (xhr, status, error) {
                                $("#form1 #CarNo").val("");
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                return;
                            });
                        }, "text json").error(function (xhr, status, error) {
                            $("#form1 #CarNo").val("");
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            return;
                        });
                        //#endregion

                        //#region 填充承运单位
                        $("#form1 #CarrierId").val("0");
                        $("#form1 #CarrierName").val("");
                        $("#form1 #BusinessType").removeAttr("disabled");
                        $("#form1 #PaymentType").removeAttr("disabled");

                        $.get("/Common/LoadCarrierByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (ret) {
                            if (ret != null) {
                                $("#form1 #CarrierId").val(ret.Id);
                                $("#form1 #CarrierName").val(ret.Name);
                                $("#form1 #BusinessType").val(ret.BusinessType);
                                $("#form1 #PaymentType").val(ret.PaymentType);
                                $("#form1 #BusinessType").attr("disabled", "disabled");
                                $("#form1 #PaymentType").attr("disabled", "disabled");
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#form1 #CarNo").val("");
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            return;
                        });
                        //#endregion

                        //#region 加载该车号上已配载的发货计划和货物数据
                        if (needLoadNewCardNoDispatchedDeliverPlans) {
                            $("#gridDispatchedDeliverPlans").jqGrid("setGridParam", {
                                url: "/chenxk/Dispatch/LoadDispatchedDeliverPlansGrid/",
                                postData: {
                                    carNo: $("#form1 #CarNo").val().trim()
                                }
                            });
                            $("#gridDispatchedDeliverPlans").trigger("reloadGrid", [{ page: 1 }]);

                            $("#gridDispatchedGoods").jqGrid("setGridParam", {
                                url: "/chenxk/Dispatch/LoadDispatchedGoodsGrid",
                                postData: {
                                    carNo: $("#form1 #CarNo").val().trim(),
                                    planId: "0"
                                }
                            });
                            $("#gridDispatchedGoods").trigger("reloadGrid", [{ page: 1 }]);
                        }
                        //#endregion

                        //#region 自动将客户自提车号与当前输入车号一致的计划添加到已配载计划中
                        objMain.objWorkspace.objContent.timerCheckPickUpSelfDeliverPlans = setInterval("checkDispatchPickUpSelfDeliverPlans();", 500);
                        //#endregion

                        //#region 缓存车号
                        $.jStorage.set("NewDispatchBill_CarNo", $("#form1 #CarNo").val().trim());
                        //#endregion

                        objMain.objWorkspace.objContent.isCarInfoChanged = true;
                    }
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //挂号改变事件
                $("#form1 #TrailerNo").change(function () {
                    objMain.objWorkspace.objContent.isCarInfoChanged = true;
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //默认显示驾驶员姓名文本框
                document.getElementById("selDriverName").style.display = "none";

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //驾驶员姓名改变事件
                $("#form1 #txtDriverName").change(function () {
                    $("#form1 #selDriverName").empty();
                    $("#form1 #selDriverName").append("<option value='0'>" + $("#form1 #txtDriverName").val().trim() + "</option>");
                    $("#form1 #selDriverName").get(0).selectedIndex = 0;

                    if ($("#form1 #CarrierId").val().trim() == "0") {
                        $("#form1 #CarrierName").val($("#form1 #txtDriverName").val().trim());
                    }

                    objMain.objWorkspace.objContent.isCarInfoChanged = true;
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //驾驶员姓名选择事件
                $("#form1 #selDriverName").change(function () {
                    $("#form1 #DriverLicenseNo").val("");
                    $("#form1 #DriverMobileTel").val("");
                    $("#form1 #DriverHomeTel").val("");

                    if ($(this).val().trim() == "<%: InnoSoft.LS.Resources.Options.NewDriver %>") {
                        document.getElementById("selDriverName").style.display = "none";
                        $("#form1 #txtDriverName").val("");
                        document.getElementById("txtDriverName").style.display = "inline";
                        $("#form1 #txtDriverName").focus().select();
                    }
                    else if ($(this).val().trim() != "") {
                        //读取选中驾驶员信息
                        $.get("/Common/LoadDriver", { nId: $(this).val().trim() }, function (ret) {
                            $("#form1 #txtDriverName").val($("#form1 #selDriverName").find("option:selected").text());
                            $("#form1 #DriverLicenseNo").val(ret.LicenseNo);
                            $("#form1 #DriverMobileTel").val(ret.MobileTel);
                            $("#form1 #DriverHomeTel").val(ret.HomeTel);
                        }, "text json").error(function (xhr, status, error) {
                            $("#form1 #selDriverName").get(0).selectedIndex = 0;
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            return;
                        });
                    }

                    objMain.objWorkspace.objContent.isCarInfoChanged = true;
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //驾驶证号改变事件
                $("#form1 #DriverLicenseNo").change(function () {
                    objMain.objWorkspace.objContent.isCarInfoChanged = true;
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //驾驶员手机改变事件
                $("#form1 #DriverMobileTel").change(function () {
                    objMain.objWorkspace.objContent.isCarInfoChanged = true;
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //驾驶员住宅电话改变事件
                $("#form1 #DriverHomeTel").change(function () {
                    objMain.objWorkspace.objContent.isCarInfoChanged = true;
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //承运单位名称改变事件
                $("#form1 #CarrierName").change(function () {
                    objMain.objWorkspace.objContent.isCarInfoChanged = true;
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //载重改变事件
                $("#form1 #CarryingCapacity").change(function () {
                    objMain.objWorkspace.objContent.isCarInfoChanged = true;
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //承运单位经营性质改变事件
                $("#form1 #BusinessType").change(function () {
                    objMain.objWorkspace.objContent.isCarInfoChanged = true;
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //承运单位结算方式改变事件
                $("#form1 #PaymentType").change(function () {
                    objMain.objWorkspace.objContent.isCarInfoChanged = true;
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置录入日期
                $("#form1 #CreateTime").datepicker({
                    onSelect: function (dateText, inst) {
                        objMain.objWorkspace.objContent.isCarInfoChanged = true;
                    }
                });
                $("#form1 #CreateTime").datepicker("option", $.datepicker.regional["zh-CN"]);

                //#endregion

                //#region 2.已调度计划和货物信息
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //创建已配载计划表格
                $("#gridDispatchedDeliverPlans").jqGrid({
                    url: "/chenxk/Dispatch/LoadDispatchedDeliverPlansGrid/",
                    datatype: "json",
                    mtype: "GET",
                    postData: { carNo: $("#form1 #CarNo").val().trim() },
                    colNames: [
                        "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.DispatchBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiveType %>",
                    "<%: InnoSoft.LS.Resources.Labels.KM %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>"],
                    colModel: [
                        { name: "Id", index: "Id", width: 100, hidden: true },
                        { name: "DispatchBillId", index: "DispatchBillId", width: 100, hidden: true },
                        { name: "PlanId", index: "PlanId", width: 100, hidden: true },
                        { name: "PlanNo", index: "PlanNo", width: 100, align: "center" },
                        { name: "CustomerName", index: "CustomerName", width: 200 },
                        { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center" },
                        { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                        { name: "ReceiverName", index: "ReceiverName", width: 200 },
                        { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                        { name: "ReceiveType", index: "ReceiveType", width: 60, align: "center" },
                        { name: "KM", index: "KM", width: 60, align: "center" },
                        { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                        { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                        { name: "Piles", index: "Piles", width: 100, align: "center" },
                        { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right" },
                        { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                        { name: "Remark", index: "Remark", width: 200 }],
                    rowNum: 500,
                    rowList: [50, 100, 500, 1000, 5000],
                    sortname: "PlanNo",
                    sortorder: "asc",
                    pager: "#pagerDispatchedDeliverPlans",
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
                        objMain.objWorkspace.objContent.selectedDispatchedPlanId = rowid;

                        //加载当前选中计划的货物数据
                        var data = $("#gridDispatchedDeliverPlans").jqGrid("getRowData", objMain.objWorkspace.objContent.selectedDispatchedPlanId);

                        $("#gridDispatchedGoods").jqGrid("setGridParam", {
                            url: "/chenxk/Dispatch/LoadDispatchedGoodsGrid/",
                            postData: {
                                carNo: $("#form1 #CarNo").val().trim(),
                                planId: data.PlanId
                            }
                        });
                        $("#gridDispatchedGoods").trigger("reloadGrid", [{ page: 1 }]);
                    }
                });
                $("#gridDispatchedDeliverPlans").jqGrid("navGrid", "#pagerDispatchedDeliverPlans", { edit: false, add: false, del: false, search: false });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //绑定添加计划按钮事件
                $("#btnAddPlan").button().click(function () {
                    objMain.objWorkspace.objContent.addDispatchedPlan();
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //绑定修改计划按钮事件
                $("#btnModifyPlan").button().click(function () {
                    objMain.objWorkspace.objContent.modifyDispatchedPlan();
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //绑定删除计划按钮事件
                $("#btnDeletePlan").button().click(function () {
                    objMain.objWorkspace.objContent.deleteDispatchedPlan();
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //创建已配载货物表格
                $("#gridDispatchedGoods").jqGrid({
                    url: "/chenxk/Dispatch/LoadDispatchedGoodsGrid",
                    datatype: "json",
                    mtype: "GET",
                    postData: {
                        carNo: $("#form1 #CarNo").val().trim(),
                        planId: "0"
                    },
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
                    "<%: InnoSoft.LS.Resources.Labels.PiecesOrBoxes %>",
                    "<%: InnoSoft.LS.Resources.Labels.PieceWeightOrConvertCoefficient %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
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
                        { name: "Location", index: "Location", width: 50, align: "center" },
                        { name: "Packages", index: "Packages", width: 60, align: "center" },
                        { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                        { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                        { name: "Piles", index: "Piles", width: 100, align: "center" },
                        { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                        { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                        { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                        { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center" }],
                    rowNum: 500,
                    rowList: [50, 100, 500, 1000, 5000],
                    sortname: "GoodsNo",
                    sortorder: "asc",
                    pager: "#pagerDispatchedGoods",
                    viewrecords: true,
                    emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                    shrinkToFit: false,
                    height: 300,
                    footerrow: true,
                    userDataOnFooter: true,
                    loadError: function (xhr, status, error) {
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    }
                });
                $("#gridDispatchedGoods").jqGrid("navGrid", "#pagerDispatchedGoods", { edit: false, add: false, del: false, search: false });
                //#endregion

                //#region 3.添加计划
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //创建添加计划对话框
                $("#dialogAddPlan").dialog({
                    autoOpen: false,
                    height: 700,
                    width: 1000,
                    modal: true,
                    resizable: false,
                    buttons: {
                        "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                            //#region 数据验证
                            var rows = $("#gridAddDispatchGoods").jqGrid("getRowData");
                            for (var i = 0; i < rows.length; i++) {
                                var row = rows[i];
                                var packages = (row.Packages == null || row.Packages == undefined) ? "0" : row.Packages;
                                var piles = (row.Piles == null || row.Piles == undefined) ? "0" : row.Piles;
                                var actualPackages = (row.ActualPackages == null || row.ActualPackages == undefined) ? "0" : row.ActualPackages;
                                var actualPiles = (row.ActualPiles == null || row.ActualPiles == undefined) ? "0" : row.ActualPiles;

                                if (Math.abs(parseInt(actualPackages)) > Math.abs(parseInt(packages))) {
                                    alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesCanNotGreaterThanPackages %>");
                                    return;
                                }
                                if (Math.abs(parseFloat(actualPiles)) > Math.abs(parseFloat(piles))) {
                                    alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesCanNotGreaterThanPiles %>");
                                    return;
                                }
                            }

                            if ($("#formAddPlanComputeTransportCharges").valid() == false) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCompleteAndCorrectTransportChargeInfo %>");
                                return;
                            }

                            if ($("#form1").valid() == false) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCompleteAndCorrectCarInfo %>");
                                return;
                            }
                            //#endregion

                            //读取当前待调度计划数据
                            $.get("/Common/LoadDeliverPlan", { nPlanId: objMain.objWorkspace.objContent.selectedDispatchPlanId }, function (ret) {
                                if (ret != null) {
                                    //#region 检查实发件数(箱数)、吨数、垛数、万只，和总吨数与载重

                                    //读取已配载吨数
                                    var footerData = $("#gridDispatchedDeliverPlans").jqGrid("footerData");
                                    var totalDispatchedTunnages = footerData.Tunnages;
                                    if (totalDispatchedTunnages == null || totalDispatchedTunnages == undefined) {
                                        totalDispatchedTunnages = "0";
                                    }

                                    //读取实发件数、吨数、垛数和万只
                                    var footerData = $("#gridAddDispatchGoods").jqGrid("footerData");
                                    var actualPackages = footerData.ActualPackages;
                                    if (actualPackages == null || actualPackages == undefined) {
                                        actualPackages = "0";
                                    }
                                    var actualTunnages = footerData.ActualTunnages;
                                    if (actualTunnages == null || actualTunnages == undefined) {
                                        actualTunnages = "0";
                                    }
                                    var actualPiles = footerData.ActualPiles;
                                    if (actualPiles == null || actualPiles == undefined) {
                                        actualPiles = "0";
                                    }
                                    var actualTenThousands = footerData.ActualTenThousands;
                                    if (actualTenThousands == null || actualTenThousands == undefined) {
                                        actualTenThousands = "0";
                                    }

                                    //纸发货计划
                                    if (ret.PlanType == "<%: InnoSoft.LS.Resources.Options.PaperPlan %>" || ret.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverPaperPlan %>") {
                                        //检查实发件数
                                        if (parseInt(actualPackages) == 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPackages %>");
                                            return;
                                        }
                                        //检查总吨数与载重
                                        var totalTunnages = add(totalDispatchedTunnages, actualTunnages);
                                        if (totalTunnages > parseInt($("#form1 #CarryingCapacity").val().trim())) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.TotalTunnagesCanNotGreaterThanCarryingCapacity %>");
                                            return;
                                        }
                                    }
                                        //罐发货计划
                                    else if (ret.PlanType == "<%: InnoSoft.LS.Resources.Options.CanPlan %>" || ret.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverCanPlan %>") {
                                        //检查实发垛数
                                        if (parseFloat(actualPiles) == 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPiles %>");
                                            return;
                                        }
                                        //检查实发万只
                                        if (parseFloat(actualTenThousands) == 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualTenThousands %>");
                                            return;
                                        }
                                    }
                                        //方便面发货计划
                                    else if (ret.PlanType == "<%: InnoSoft.LS.Resources.Options.NoodlePlan %>") {
                                        //检查实发箱数和吨数
                                        if (parseInt(actualPackages) == 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPackages %>");
                                            return;
                                        }
                                        if (parseFloat(actualTunnages) == 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualTunnages %>");
                                            return;
                                        }
                                        //检查总吨数与载重
                                        var totalTunnages = add(totalDispatchedTunnages, actualTunnages);
                                        if (Math.abs(totalTunnages) > parseInt($("#form1 #CarryingCapacity").val().trim())) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.TotalTunnagesCanNotGreaterThanCarryingCapacity %>");
                                            return;
                                        }
                                        //检查公里数
                                        var km = parseInt($("#formAddPlanComputeTransportCharges #KM").val().trim());
                                        if (isNaN(km) || km <= 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.KMNotGreaterThanZero %>");
                                            return;
                                        }
                                    }
                                        //其它发货计划
                                    else {
                                        //检查实发件数
                                        if (parseInt(actualPackages) == 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPackages %>");
                                            return;
                                        }
                                        //检查总吨数与载重
                                        var totalTunnages = add(totalDispatchedTunnages, actualTunnages);
                                        if (totalTunnages > parseInt($("#form1 #CarryingCapacity").val().trim())) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.TotalTunnagesCanNotGreaterThanCarryingCapacity %>");
                                            return;
                                        }
                                    }
                                    //#endregion

                                    //#region 提货方式为配送时，应检查结算公式、单价和运费；提货方式为自提时，且车号不一致，则提示是否需要改自提为配送
                            var newReceiveType = "";
                            if (ret.ReceiveType == "<%: InnoSoft.LS.Resources.Options.PickUpDelivery %>") {
                                if ($("#formAddPlanComputeTransportCharges #TransportChargeExpression").val().trim() == "") {
                                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTransportChargeExpression %>");
                                    return;
                                }

                                if ($("#formAddPlanComputeTransportCharges #TransportPriceExpression").val().trim() == "") {
                                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTransportPriceExpression %>");
                                return;
                            }

                            var actualTransportPrice = parseFloat($("#formAddPlanComputeTransportCharges #ActualTransportPrice").val().trim());
                            if (isNaN(actualTransportPrice) || actualTransportPrice <= 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.ActualTransportPriceNotGreaterThanZero %>");
                                return;
                            }

                            var transportCharges = parseFloat($("#formAddPlanComputeTransportCharges #TransportCharges").val().trim());
                            if (isNaN(transportCharges)) {
                                alert("<%: InnoSoft.LS.Resources.Strings.TransportChargesNotValidNumeric %>");
                                return;
                            }
                        }
                        else {
                            if (ret.CarNo != $("#form1 #CarNo").val().trim()) {
                                if (confirm("<%: InnoSoft.LS.Resources.Strings.ModifyDeliverPlanReceiveTypeConfirm %>") == true) {
                                    newReceiveType = "<%: InnoSoft.LS.Resources.Options.PickUpDelivery %>";
                                }
                            }
                        }
                                    //#endregion

                                    //#region 保存数据
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

                                    //生成调度货物JSON数据
                        var goods = new Array();
                        for (var i = 0; i < rows.length; i++) {
                            var row = rows[i];
                            var goodsId = row.GoodsId;
                            var goodsNo = row.GoodsNo;
                            var goodsName = row.GoodsName;
                            var brand = (row.Brand == null || row.Brand == undefined) ? "" : row.Brand;
                            var specModel = (row.SpecModel == null || row.SpecModel == undefined) ? "" : row.SpecModel;
                            var gWeight = (row.GWeight == null || row.GWeight == undefined) ? "" : row.GWeight;
                            var grade = (row.Grade == null || row.Grade == undefined) ? "" : row.Grade;
                            var pieceWeight = (row.PieceWeight == null || row.PieceWeight == undefined) ? "0" : row.PieceWeight;
                            var packing = (row.Packing == null || row.Packing == undefined) ? "" : row.Packing;
                            var batchNo = (row.BatchNo == null || row.BatchNo == undefined) ? "" : row.BatchNo;
                            var location = (row.Location == null || row.Location == undefined) ? "" : row.Location;
                            var packages = (row.ActualPackages == null || row.ActualPackages == undefined) ? "0" : row.ActualPackages;
                            var tunnages = (row.ActualTunnages == null || row.ActualTunnages == undefined) ? "0" : row.ActualTunnages;
                            var piles = (row.ActualPiles == null || row.ActualPiles == undefined) ? "0" : row.ActualPiles;
                            var tenThousands = (row.ActualTenThousands == null || row.ActualTenThousands == undefined) ? "0" : row.ActualTenThousands;
                            var productionDate = (row.ProductionDate == null || row.ProductionDate == undefined) ? "" : row.ProductionDate;
                            var enterWarehouseBillId = (row.EnterWarehouseBillId == null || row.EnterWarehouseBillId == undefined) ? "0" : row.EnterWarehouseBillId;
                            var enterWarehouseBillNo = (row.EnterWarehouseBillNo == null || row.EnterWarehouseBillNo == undefined) ? "" : row.EnterWarehouseBillNo;

                            if (parseInt(packages) != 0 || parseFloat(piles) > 0) {
                                var g = {
                                    "PlanId": objMain.objWorkspace.objContent.selectedDispatchPlanId,
                                    "GoodsId": goodsId,
                                    "GoodsNo": goodsNo,
                                    "GoodsName": goodsName,
                                    "Brand": brand,
                                    "SpecModel": specModel,
                                    "GWeight": gWeight,
                                    "Grade": grade,
                                    "PieceWeight": pieceWeight,
                                    "Packing": packing,
                                    "BatchNo": batchNo,
                                    "Location": location,
                                    "Packages": packages,
                                    "Tunnages": tunnages,
                                    "Piles": piles,
                                    "TenThousands": tenThousands,
                                    "ProductionDate": productionDate,
                                    "EnterWarehouseBillId": enterWarehouseBillId,
                                    "EnterWarehouseBillNo": enterWarehouseBillNo
                                };
                                goods.push(g);
                            }
                        }

                                    //生成调度计划JSON数据
                        var deliverPlans = new Array();
                        var p = {
                            "PlanId": objMain.objWorkspace.objContent.selectedDispatchPlanId,
                            "Packages": actualPackages,
                            "Tunnages": actualTunnages,
                            "Piles": actualPiles,
                            "TenThousands": actualTenThousands,
                            "TransportChargeExpression": $("#formAddPlanComputeTransportCharges #TransportChargeExpression").val().trim(),
                            "TransportPriceExpression": $("#formAddPlanComputeTransportCharges #TransportPriceExpression").val().trim(),
                            "KM": $("#formAddPlanComputeTransportCharges #KM").val().trim(),
                            "AgreementTransportPrice": $("#formAddPlanComputeTransportCharges #AgreementTransportPrice").val().trim(),
                            "ActualTransportPrice": $("#formAddPlanComputeTransportCharges #ActualTransportPrice").val().trim(),
                            "TransportCharges": $("#formAddPlanComputeTransportCharges #TransportCharges").val().trim(),
                            "Remark": $("#formAddPlanComputeTransportCharges #Remark").val().trim(),
                            "ReceiveType": newReceiveType
                        };
                        deliverPlans.push(p);

                                    //生成调度单JSON数据
                        var dispatchBillId = "0";
                        rows = $("#gridDispatchedDeliverPlans").jqGrid("getRowData");
                        if (rows.length > 0) {
                            dispatchBillId = rows[0].DispatchBillId;
                        }
                        var d = {
                            "Id": dispatchBillId,
                            "CarNo": $("#form1 #CarNo").val().trim(),
                            "TrailerNo": $("#form1 #TrailerNo").val().trim(),
                            "CarType": $("#form1 #CarType").val().trim(),
                            "DriverName": $("#form1 #txtDriverName").val().trim(),
                            "DriverLicenseNo": $("#form1 #DriverLicenseNo").val().trim(),
                            "DriverMobileTel": $("#form1 #DriverMobileTel").val().trim(),
                            "DriverHomeTel": $("#form1 #DriverHomeTel").val().trim(),
                            "CarrierId": $("#form1 #CarrierId").val().trim(),
                            "CarrierName": $("#form1 #CarrierName").val().trim(),
                            "CarryingCapacity": $("#form1 #CarryingCapacity").val().trim(),
                            "BusinessType": $("#form1 #BusinessType").val().trim(),
                            "PaymentType": $("#form1 #PaymentType").val().trim(),
                            "CreateTime": $("#form1 #CreateTime").val().trim(),
                            "DeliverPlans": deliverPlans,
                            "Goods": goods
                        };

                        var postData = JSON.stringify(d);

                                    //发送数据
                        $.ajax({
                            type: "POST",
                            url: "/chenxk/Dispatch/DispatchDeliverPlan/",
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

                                    objMain.objWorkspace.objContent.selectedDispatchedPlanId = null;

                                    //刷新已配载计划表格
                                    $("#gridDispatchedDeliverPlans").jqGrid("setGridParam", {
                                        url: "/chenxk/Dispatch/LoadDispatchedDeliverPlansGrid/",
                                        postData: {
                                            carNo: $("#form1 #CarNo").val().trim()
                                        }
                                    });
                                    $("#gridDispatchedDeliverPlans").trigger("reloadGrid", [{ page: 1 }]);

                                    //刷新已配载货物表格
                                    $("#gridDispatchedGoods").jqGrid("setGridParam", {
                                        url: "/chenxk/Dispatch/LoadDispatchedGoodsGrid/",
                                        postData: {
                                            carNo: $("#form1 #CarNo").val().trim(),
                                            planId: "0"
                                        }
                                    });
                                    $("#gridDispatchedGoods").trigger("reloadGrid", [{ page: 1 }]);

                                    //读取承运单位编码
                                    $.get("/Common/LoadCarrierByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (data) {
                                        if (data != null) {
                                            $("#form1 #CarrierId").val(data.Id);
                                        }
                                    }, "text json").error(function (xhr, status, error) {
                                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                    });

                                    //关闭对话框
                                    $("#dialogAddPlan").dialog("close");

                                    objMain.objWorkspace.objContent.isCarInfoChanged = true;
                                }
                            },
                            error: function (xhr, status, error) {
                                $.unblockUI();

                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            }
                        });
                                    //#endregion
                    }
                    else {
                        alert("<%: InnoSoft.LS.Resources.Strings.LoadDeliverPlanFailed %>");
                                }
                            }, "text json").error(function (xhr, status, error) {
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            });
                        },
                        "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                            $("#dialogAddPlan").dialog("close");
                        }
                    },
                    open: function () {
                        var w = parseInt($("#dialogAddPlan").width()) - parseInt($("#dialogAddPlan > fieldset:first").css("border-left-width")) * 2 - parseInt($("#dialogAddPlan > fieldset:first").css("padding-left")) * 2 - parseInt($("#dialogAddPlan > fieldset:first").css("margin-left")) * 2 - $.scrollbarWidth();
                        $("#gridAddDispatchDeliverPlans").jqGrid("setGridWidth", w - 2);
                    },
                    close: function () {
                        //启动计时器检查客户自提计划
                        objMain.objWorkspace.objContent.timerCheckPickUpSelfDeliverPlans = setInterval("checkDispatchPickUpSelfDeliverPlans();", 500);
                    }
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //创建待调度计划表格
                $("#gridAddDispatchDeliverPlans").jqGrid({
                    url: "/chenxk/Dispatch/LoadDispatchDeliverPlansGrid/",
                    datatype: "json",
                    mtype: "GET",
                    postData: {
                        organId: "",
                        customerName: "",
                        shipmentNo: "",
                        deliveryNo: "",
                        receiverName: "",
                        destCountry: "",
                        destProvince: "",
                        destCity: "",
                        warehouse: "",
                        arrivalTime: "",
                        carNo: $("#form1 #CarNo").val().trim()
                    },
                    colNames: [
                        "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                    "<%: InnoSoft.LS.Resources.Labels.ArrivalTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.CreateTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiveType %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>"],
                    colModel: [
                        { name: "Id", index: "Id", width: 100, hidden: true },
                        { name: "PlanNo", index: "PlanNo", width: 100, align: "center" },
                        { name: "CustomerName", index: "CustomerName", width: 200 },
                        { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center" },
                        { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                        { name: "ReceiverName", index: "ReceiverName", width: 200 },
                        { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                        { name: "Warehouse", index: "Warehouse", width: 80, align: "center" },
                        { name: "ArrivalTime", index: "ArrivalTime", width: 80, align: "center" },
                        { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                        { name: "BalanceTunnages", index: "BalanceTunnages", width: 100, align: "center" },
                        { name: "BalancePiles", index: "BalancePiles", width: 100, align: "center" },
                        { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                        { name: "ReceiveType", index: "ReceiveType", width: 60, align: "center", hidden: true },
                        { name: "CarNo", index: "CarNo", width: 80, align: "center", hidden: true },
                        { name: "Remark", index: "Remark", width: 300 }],
                    rowNum: 500,
                    rowList: [50, 100, 500, 1000, 5000],
                    sortname: "CreateTime",
                    sortorder: "asc",
                    pager: "#pagerAddDispatchDeliverPlans",
                    viewrecords: true,
                    emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                    shrinkToFit: false,
                    footerrow: true,
                    userDataOnFooter: true,
                    loadError: function (xhr, status, error) {
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    },
                    gridComplete: function () {
                        if ($("#gridAddDispatchDeliverPlans").jqGrid("getGridParam", "records") > 0) {
                            var rows = $("#gridAddDispatchDeliverPlans").jqGrid("getRowData");
                            var i = 0;
                            while (i < rows.length) {
                                if (rows[i].ReceiveType == "<%: InnoSoft.LS.Resources.Options.PickUpSelf %>" && rows[i].CarNo == $("#form1 #CarNo").val().trim()) {
                                    $("#gridAddDispatchDeliverPlans").jqGrid("setSelection", rows[i].Id, true);
                                    break;
                                }
                                i++;
                            }
                            if (i >= rows.length) {
                                $("#gridAddDispatchDeliverPlans").jqGrid("setSelection", rows[0].Id, true);
                            }
                        }
                    },
                    onSelectRow: function (rowid, status) {
                        objMain.objWorkspace.objContent.selectedDispatchPlanId = rowid;

                        //#region 初始化待调度货物表格
                        var data = $("#gridAddDispatchDeliverPlans").jqGrid("getRowData", objMain.objWorkspace.objContent.selectedDispatchPlanId);
                        //纸发货计划
                        if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.PaperPlan %>") {
                            //#region 创建待调度货物表格
                            $("#gridAddDispatchGoods").jqGrid("GridUnload", "#gridAddDispatchGoods");
                            $("#gridAddDispatchGoods").jqGrid({
                                url: "/chenxk/Dispatch/LoadDispatchPaperPlanGoodsGrid",
                                datatype: "json",
                                mtype: "GET",
                                postData: { planId: objMain.objWorkspace.objContent.selectedDispatchPlanId },
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
                                "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualPieces %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualTunnages %>"],
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
                                    { name: "Location", index: "Location", width: 50, align: "center" },
                                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                                    { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center" },
                                    { name: "ActualPackages", index: "ActualPackages", width: 60, align: "center", editable: true },
                                    { name: "ActualTunnages", index: "ActualTunnages", width: 100, align: "center", editable: true }],
                                rowNum: 500,
                                rowList: [50, 100, 500, 1000, 5000],
                                sortname: "GoodsNo",
                                sortorder: "asc",
                                pager: "#pagerAddDispatchGoods",
                                viewrecords: true,
                                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                                shrinkToFit: false,
                                footerrow: true,
                                userDataOnFooter: true,
                                cellEdit: true,
                                cellsubmit: "clientArray",
                                loadError: function (xhr, status, error) {
                                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                },
                                afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                                    //失去焦点自动保存
                                    $("#" + iRow + "_" + cellname).bind("blur", function () {
                                        $("#gridAddDispatchGoods").jqGrid("saveCell", iRow, iCol);
                                    });
                                },
                                afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                                    if (cellname == "ActualPackages") {
                                        //计算实发吨数
                                        var actualPackages = parseInt(value);
                                        if (isNaN(actualPackages)) {
                                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotValidNumeric %>");
                                        }
                                        else if (actualPackages < 0) {
                                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotGreaterThanOrEqualZero %>");
                                        }
                                        else {
                                            var row = $("#gridAddDispatchGoods").jqGrid("getRowData", rowid);
                                            if (actualPackages > parseInt(row.Packages)) {
                                                $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                                alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesCanNotGreaterThanPackages %>");
                                            }
                                            else {
                                                if (row.PieceWeight == null || row.PieceWeight == "") {
                                                    $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: "0" });
                                                }
                                                else {
                                                    var actualTunnages = mul(actualPackages, parseFloat(row.PieceWeight));
                                                    $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: Math.round(actualTunnages * Math.pow(10, 6)) / Math.pow(10, 6) });
                                                }
                                            }
                                        }
                                }
                                else if (cellname == "ActualTunnages") {
                                    //计算件重
                                    var actualTunnages = parseFloat(value);
                                    if (isNaN(actualTunnages)) {
                                        $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                        alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotValidNumeric %>");
                                    }
                                    else if (actualTunnages <= 0) {
                                        $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                        alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotGreaterThanZero %>");
                                    }
                                    else {
                                        //检查件数
                                        var row = $("#gridAddDispatchGoods").jqGrid("getRowData", rowid);
                                        var actualPackages = 0;
                                        if (row.ActualPackages != null && row.ActualPackages != "") {
                                            actualPackages = parseInt(row.ActualPackages);
                                        }
                                        if (actualPackages == 0) {
                                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPackages %>");
                                        }
                                        else {
                                            //计算件重
                                            var pieceWeight = div(actualTunnages, actualPackages);
                                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { PieceWeight: Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6) });
                                        }
                                    }
                            }

                                    //合计实发件数和实发吨数
                                    var totalActualPackages = 0;
                                    var totalActualTunnages = 0;
                                    var rows = $("#gridAddDispatchGoods").jqGrid("getRowData");
                                    for (var i = 0; i < rows.length; i++) {
                                        var row = rows[i];
                                        totalActualPackages = add(totalActualPackages, parseInt(row.ActualPackages));
                                        totalActualTunnages = add(totalActualTunnages, parseFloat(row.ActualTunnages));
                                    }
                                    $("#gridAddDispatchGoods").jqGrid("footerData", "set", { ActualPackages: totalActualPackages, ActualTunnages: totalActualTunnages });

                                    //计算运费
                                    AddPlanComputeTransportCharges();
                                }
                            });
                $("#gridAddDispatchGoods").jqGrid("navGrid", "#pagerAddDispatchGoods", { edit: false, add: false, del: false, search: false });
                $("#gridAddDispatchGoods").jqGrid("setGridWidth", $("#dialogAddPlan > fieldset:first").width() - 2);
                            //#endregion

                            //#region 隐藏公里数编辑框
                $("#formAddPlanComputeTransportCharges tr:eq(2)").hide();
                            //#endregion
            }
                            //纸直发货计划
            else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverPaperPlan %>") {
                            //#region 创建待调度货物表格
                            $("#gridAddDispatchGoods").jqGrid("GridUnload", "#gridAddDispatchGoods");
                            $("#gridAddDispatchGoods").jqGrid({
                                url: "/chenxk/Dispatch/LoadDispatchNotDeliverPaperPlanGoodsGrid",
                                datatype: "json",
                                mtype: "GET",
                                postData: { planId: objMain.objWorkspace.objContent.selectedDispatchPlanId },
                                colNames: [
                                    "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                                "<%: InnoSoft.LS.Resources.Labels.Brand %>",
                                "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                                "<%: InnoSoft.LS.Resources.Labels.GrammeWeight %>",
                                "<%: InnoSoft.LS.Resources.Labels.Grade %>",
                                "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                                "<%: InnoSoft.LS.Resources.Labels.PieceWeight %>",
                                "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                                "<%: InnoSoft.LS.Resources.Labels.PackingSpecification %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualPieces %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualTunnages %>"],
                                colModel: [
                                    { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                                    { name: "Brand", index: "Brand", width: 80, align: "center" },
                                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                                    { name: "GWeight", index: "GWeight", width: 50, align: "center" },
                                    { name: "Grade", index: "Grade", width: 50, align: "center" },
                                    { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                                    { name: "Packing", index: "Packing", width: 50, align: "center" },
                                    { name: "ActualPackages", index: "ActualPackages", width: 60, align: "center", editable: true },
                                    { name: "ActualTunnages", index: "ActualTunnages", width: 100, align: "center", editable: true }],
                                rowNum: 500,
                                rowList: [50, 100, 500, 1000, 5000],
                                sortname: "GoodsNo",
                                sortorder: "asc",
                                pager: "#pagerAddDispatchGoods",
                                viewrecords: true,
                                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                                shrinkToFit: false,
                                footerrow: true,
                                userDataOnFooter: true,
                                cellEdit: true,
                                cellsubmit: "clientArray",
                                loadError: function (xhr, status, error) {
                                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                },
                                afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                                    //失去焦点自动保存
                                    $("#" + iRow + "_" + cellname).bind("blur", function () {
                                        $("#gridAddDispatchGoods").jqGrid("saveCell", iRow, iCol);
                                    });
                                },
                                afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                                    if (cellname == "ActualPackages") {
                                        //计算实发吨数
                                        var actualPackages = parseInt(value);
                                        if (isNaN(actualPackages)) {
                                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotValidNumeric %>");
                                        }
                                        else if (actualPackages < 0) {
                                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotGreaterThanOrEqualZero %>");
                                        }
                                        else {
                                            var row = $("#gridAddDispatchGoods").jqGrid("getRowData", rowid);
                                            if (actualPackages > parseInt(row.Packages)) {
                                                $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                                alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesCanNotGreaterThanPackages %>");
                                            }
                                            else {
                                                if (row.PieceWeight == null || row.PieceWeight == "") {
                                                    $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: "0" });
                                                }
                                                else {
                                                    var actualTunnages = mul(actualPackages, parseFloat(row.PieceWeight));
                                                    $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: Math.round(actualTunnages * Math.pow(10, 6)) / Math.pow(10, 6) });
                                                }
                                            }
                                        }
                                }
                                else if (cellname == "ActualTunnages") {
                                    //计算件重
                                    var actualTunnages = parseFloat(value);
                                    if (isNaN(actualTunnages)) {
                                        $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                        alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotValidNumeric %>");
                                    }
                                    else if (actualTunnages <= 0) {
                                        $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                        alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotGreaterThanZero %>");
                                    }
                                    else {
                                        //检查件数
                                        var row = $("#gridAddDispatchGoods").jqGrid("getRowData", rowid);
                                        var actualPackages = 0;
                                        if (row.ActualPackages != null && row.ActualPackages != "") {
                                            actualPackages = parseInt(row.ActualPackages);
                                        }
                                        if (actualPackages == 0) {
                                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPackages %>");
                                        }
                                        else {
                                            //计算件重
                                            var pieceWeight = div(actualTunnages, actualPackages);
                                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { PieceWeight: Math.round(pieceWeight * Math.pow(10, 6)) / Math.pow(10, 6) });
                                        }
                                    }
                            }

                                    //合计实发件数和实发吨数
                                    var totalActualPackages = 0;
                                    var totalActualTunnages = 0;
                                    var rows = $("#gridAddDispatchGoods").jqGrid("getRowData");
                                    for (var i = 0; i < rows.length; i++) {
                                        var row = rows[i];
                                        totalActualPackages = add(totalActualPackages, parseInt(row.ActualPackages));
                                        totalActualTunnages = add(totalActualTunnages, parseFloat(row.ActualTunnages));
                                    }
                                    $("#gridAddDispatchGoods").jqGrid("footerData", "set", { ActualPackages: totalActualPackages, ActualTunnages: totalActualTunnages });

                                    //计算运费
                                    AddPlanComputeTransportCharges();
                                }
                            });
                $("#gridAddDispatchGoods").jqGrid("navGrid", "#pagerAddDispatchGoods", { edit: false, add: false, del: false, search: false });
                $("#gridAddDispatchGoods").jqGrid("setGridWidth", $("#dialogAddPlan > fieldset:first").width() - 2);
                //#endregion

                //#region 隐藏公里数编辑框
                $("#formAddPlanComputeTransportCharges tr:eq(2)").hide();
                //#endregion
            }
                //罐发货计划
            else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.CanPlan %>") {
                //#region 创建待调度货物表格
                $("#gridAddDispatchGoods").jqGrid("GridUnload", "#gridAddDispatchGoods");
                $("#gridAddDispatchGoods").jqGrid({
                    url: "/chenxk/Dispatch/LoadDispatchCanPlanGoodsGrid",
                    datatype: "json",
                    mtype: "GET",
                    postData: { planId: objMain.objWorkspace.objContent.selectedDispatchPlanId },
                    colNames: [
                        "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                                "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                                "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                                "<%: InnoSoft.LS.Resources.Labels.Location %>",
                                "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                                "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                                "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                                "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillId %>",
                                "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualPiles %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualTenThousands %>"],
                    colModel: [
                        { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                        { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                        { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                        { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                        { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                        { name: "Warehouse", index: "Warehouse", width: 80, align: "center" },
                        { name: "Location", index: "Location", width: 50, align: "center" },
                        { name: "Piles", index: "Piles", width: 100, align: "center" },
                        { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                        { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                        { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                        { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center" },
                        { name: "ActualPiles", index: "ActualPiles", width: 100, align: "center", editable: true },
                        { name: "ActualTenThousands", index: "ActualTenThousands", width: 100, align: "center", editable: true }],
                    rowNum: 500,
                    rowList: [50, 100, 500, 1000, 5000],
                    sortname: "GoodsNo",
                    sortorder: "asc",
                    pager: "#pagerAddDispatchGoods",
                    viewrecords: true,
                    emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                    shrinkToFit: false,
                    footerrow: true,
                    userDataOnFooter: true,
                    cellEdit: true,
                    cellsubmit: "clientArray",
                    loadError: function (xhr, status, error) {
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    },
                    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                        //失去焦点自动保存
                        $("#" + iRow + "_" + cellname).bind("blur", function () {
                            $("#gridAddDispatchGoods").jqGrid("saveCell", iRow, iCol);
                        });
                    },
                    afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                        //检查实发垛数
                        if (cellname == "ActualPiles") {
                            var actualPiles = parseFloat(value);
                            if (isNaN(actualPiles)) {
                                $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                                alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesNotValidNumeric %>");
                        }
                        else if (actualPiles < 0) {
                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesNotGreaterThanOrEqualZero %>");
                        }
                        else {
                            var row = $("#gridAddDispatchGoods").jqGrid("getRowData", rowid);
                            if (actualPiles > parseFloat(row.Piles)) {
                                $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                                alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesCanNotGreaterThanPiles %>");
                            }
                        }
                }

                    //检查实发万只
                    if (cellname == "ActualTenThousands") {
                        var actualTenThousands = parseFloat(value);
                        if (isNaN(actualTenThousands)) {
                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsNotValidNumeric %>");
                        }
                        else if (actualTenThousands < 0) {
                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsNotGreaterThanOrEqualZero %>");
                        }
                        else {
                            var row = $("#gridAddDispatchGoods").jqGrid("getRowData", rowid);
                            if (actualTenThousands > parseFloat(row.TenThousands)) {
                                $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                                alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsCanNotGreaterThanTenThousands %>");
                            }
                        }
                }

                    //合计实发垛数和万只
                    var totalActualPiles = 0;
                    var totalActualTenThousands = 0;
                    var rows = $("#gridAddDispatchGoods").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        totalActualPiles = add(totalActualPiles, parseFloat(row.ActualPiles));
                        totalActualTenThousands = add(totalActualTenThousands, parseFloat(row.ActualTenThousands));
                    }
                    $("#gridAddDispatchGoods").jqGrid("footerData", "set", { ActualPiles: totalActualPiles, ActualTenThousands: totalActualTenThousands });

                    //计算运费
                    AddPlanComputeTransportCharges();
                }
                });
        $("#gridAddDispatchGoods").jqGrid("navGrid", "#pagerAddDispatchGoods", { edit: false, add: false, del: false, search: false });
        $("#gridAddDispatchGoods").jqGrid("setGridWidth", $("#dialogAddPlan > fieldset:first").width() - 2);
                //#endregion

                //#region 隐藏公里数编辑框
        $("#formAddPlanComputeTransportCharges tr:eq(2)").hide();
                //#endregion
    }
                //罐直发货计划
    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverCanPlan %>") {
                //#region 创建待调度货物表格
                $("#gridAddDispatchGoods").jqGrid("GridUnload", "#gridAddDispatchGoods");
                $("#gridAddDispatchGoods").jqGrid({
                    url: "/chenxk/Dispatch/LoadDispatchNotDeliverCanPlanGoodsGrid",
                    datatype: "json",
                    mtype: "GET",
                    postData: { planId: objMain.objWorkspace.objContent.selectedDispatchPlanId },
                    colNames: [
                        "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                                "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                                "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                                "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualPiles %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualTenThousands %>"],
                    colModel: [
                        { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                        { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                        { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                        { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                        { name: "Piles", index: "Piles", width: 100, align: "center" },
                        { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                        { name: "ActualPiles", index: "ActualPiles", width: 100, align: "center", editable: true },
                        { name: "ActualTenThousands", index: "ActualTenThousands", width: 100, align: "center", editable: true }],
                    rowNum: 500,
                    rowList: [50, 100, 500, 1000, 5000],
                    sortname: "GoodsNo",
                    sortorder: "asc",
                    pager: "#pagerAddDispatchGoods",
                    viewrecords: true,
                    emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                    shrinkToFit: false,
                    footerrow: true,
                    userDataOnFooter: true,
                    cellEdit: true,
                    cellsubmit: "clientArray",
                    loadError: function (xhr, status, error) {
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    },
                    afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                        //失去焦点自动保存
                        $("#" + iRow + "_" + cellname).bind("blur", function () {
                            $("#gridAddDispatchGoods").jqGrid("saveCell", iRow, iCol);
                        });
                    },
                    afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                        //检查实发垛数
                        if (cellname == "ActualPiles") {
                            var actualPiles = parseFloat(value);
                            if (isNaN(actualPiles)) {
                                $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                                alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesNotValidNumeric %>");
                        }
                        else if (actualPiles < 0) {
                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesNotGreaterThanOrEqualZero %>");
                        }
                        else {
                            var row = $("#gridAddDispatchGoods").jqGrid("getRowData", rowid);
                            if (actualPiles > parseFloat(row.Piles)) {
                                $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                                alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesCanNotGreaterThanPiles %>");
                            }
                        }
                }

                    //检查实发万只
                    if (cellname == "ActualTenThousands") {
                        var actualTenThousands = parseFloat(value);
                        if (isNaN(actualTenThousands)) {
                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsNotValidNumeric %>");
                        }
                        else if (actualTenThousands < 0) {
                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsNotGreaterThanOrEqualZero %>");
                        }
                        else {
                            var row = $("#gridAddDispatchGoods").jqGrid("getRowData", rowid);
                            if (actualTenThousands > parseFloat(row.TenThousands)) {
                                $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                                alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsCanNotGreaterThanTenThousands %>");
                            }
                        }
                }

                    //合计实发垛数和万只
                    var totalActualPiles = 0;
                    var totalActualTenThousands = 0;
                    var rows = $("#gridAddDispatchGoods").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        totalActualPiles = add(totalActualPiles, parseFloat(row.ActualPiles));
                        totalActualTenThousands = add(totalActualTenThousands, parseFloat(row.ActualTenThousands));
                    }
                    $("#gridAddDispatchGoods").jqGrid("footerData", "set", { ActualPiles: totalActualPiles, ActualTenThousands: totalActualTenThousands });

                    //计算运费
                    AddPlanComputeTransportCharges();
                }
                });
        $("#gridAddDispatchGoods").jqGrid("navGrid", "#pagerAddDispatchGoods", { edit: false, add: false, del: false, search: false });
        $("#gridAddDispatchGoods").jqGrid("setGridWidth", $("#dialogAddPlan > fieldset:first").width() - 2);
                //#endregion

                //#region 隐藏公里数编辑框
        $("#formAddPlanComputeTransportCharges tr:eq(2)").hide();
                //#endregion
    }
                //方便面发货计划
    else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NoodlePlan %>") {
                //#region 创建待调度货物表格
                $("#gridAddDispatchGoods").jqGrid("GridUnload", "#gridAddDispatchGoods");
                $("#gridAddDispatchGoods").jqGrid({
                    url: "/chenxk/Dispatch/LoadDispatchNoodlePlanGoodsGrid",
                    datatype: "json",
                    mtype: "GET",
                    postData: { planId: objMain.objWorkspace.objContent.selectedDispatchPlanId },
                    colNames: [
                        "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                                "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                                "<%: InnoSoft.LS.Resources.Labels.Boxes %>",
                                "<%: InnoSoft.LS.Resources.Labels.ConvertCoefficient %>",
                                "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualBoxes %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualTunnages %>"],
            colModel: [
                { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                { name: "Packages", index: "Packages", width: 60, align: "center" },
                { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                { name: "ActualPackages", index: "ActualPackages", width: 60, align: "center", editable: true },
                { name: "ActualTunnages", index: "ActualTunnages", width: 100, align: "center", editable: true }],
            rowNum: 500,
            rowList: [50, 100, 500, 1000, 5000],
            sortname: "GoodsNo",
            sortorder: "asc",
            pager: "#pagerAddDispatchGoods",
            viewrecords: true,
            emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
            shrinkToFit: false,
            footerrow: true,
            userDataOnFooter: true,
            cellEdit: true,
            cellsubmit: "clientArray",
            loadError: function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            },
            afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                //失去焦点自动保存
                $("#" + iRow + "_" + cellname).bind("blur", function () {
                    $("#gridAddDispatchGoods").jqGrid("saveCell", iRow, iCol);
                });
            },
            afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                var row = $("#gridAddDispatchGoods").jqGrid("getRowData", rowid);
                var packages = parseInt(row.Packages);

                //计算实发吨数
                if (cellname == "ActualPackages") {
                    var actualPackages = parseInt(value);
                    if (isNaN(actualPackages)) {
                        $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualBoxesNotValidNumeric %>");
                    }
                    else if (packages > 0 && actualPackages < 0) {
                        $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualBoxesNotGreaterThanOrEqualZero %>");
                    }
                    else if (packages < 0 && actualPackages > 0) {
                        $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualBoxesNotLessThanOrEqualZero %>");
                    }
                    else {
                        if (Math.abs(actualPackages) > Math.abs(packages)) {
                            $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualBoxesCanNotGreaterThanBoxes %>");
                        }
                        else {
                            if (row.PieceWeight == null || row.PieceWeight == "" || parseFloat(row.PieceWeight) == 0) {
                                $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: "0" });
                            }
                            else {
                                var actualTunnages = div(actualPackages, parseFloat(row.PieceWeight));
                                $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: Math.round(actualTunnages * Math.pow(10, 6)) / Math.pow(10, 6) });
                            }
                        }
                    }
        }
        else if (cellname == "ActualTunnages") {
            var actualTunnages = parseFloat(value);
            if (isNaN(actualTunnages)) {
                $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotValidNumeric %>");
            }
            else if (packages > 0 && actualTunnages < 0) {
                $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotGreaterThanOrEqualZero %>");
            }
            else if (packages < 0 && actualTunnages > 0) {
                $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0", ActualTunnages: "0" });
                alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotLessThanOrEqualZero %>");
                }
    }

                //合计实发箱数和实发吨数
                var totalActualPackages = 0;
                var totalActualTunnages = 0;
                var rows = $("#gridAddDispatchGoods").jqGrid("getRowData");
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    totalActualPackages = add(totalActualPackages, parseInt(row.ActualPackages));
                    totalActualTunnages = add(totalActualTunnages, parseFloat(row.ActualTunnages));
                }
                $("#gridAddDispatchGoods").jqGrid("footerData", "set", { ActualPackages: totalActualPackages, ActualTunnages: totalActualTunnages });

                //计算运费
                AddPlanComputeTransportCharges();
            }
        });
    $("#gridAddDispatchGoods").jqGrid("navGrid", "#pagerAddDispatchGoods", { edit: false, add: false, del: false, search: false });
    $("#gridAddDispatchGoods").jqGrid("setGridWidth", $("#dialogAddPlan > fieldset:first").width() - 2);
        //#endregion

        //#region 显示公里数编辑框
    $("#formAddPlanComputeTransportCharges tr:eq(2)").show();
        //#endregion
}
        //其它发货计划
else {
        //#region 创建待调度货物表格
    $("#gridAddDispatchGoods").jqGrid("GridUnload", "#gridAddDispatchGoods");
    $("#gridAddDispatchGoods").jqGrid({
        url: "/chenxk/Dispatch/LoadDispatchOtherPlanGoodsGrid",
        datatype: "json",
        mtype: "GET",
        postData: { planId: objMain.objWorkspace.objContent.selectedDispatchPlanId },
        colNames: [
            "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                                "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                                "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                                "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                                "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualPieces %>",
                                "<%: InnoSoft.LS.Resources.Labels.ActualTunnages %>"],
        colModel: [
            { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
            { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
            { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
            { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
            { name: "Packages", index: "Packages", width: 60, align: "center" },
            { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
            { name: "ActualPackages", index: "ActualPackages", width: 60, align: "center", editable: true },
            { name: "ActualTunnages", index: "ActualTunnages", width: 100, align: "center", editable: true }],
        rowNum: 500,
        rowList: [50, 100, 500, 1000, 5000],
        sortname: "GoodsNo",
        sortorder: "asc",
        pager: "#pagerAddDispatchGoods",
        viewrecords: true,
        emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
        shrinkToFit: false,
        footerrow: true,
        userDataOnFooter: true,
        cellEdit: true,
        cellsubmit: "clientArray",
        loadError: function (xhr, status, error) {
            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
        },
        afterEditCell: function (rowid, cellname, value, iRow, iCol) {
            //失去焦点自动保存
            $("#" + iRow + "_" + cellname).bind("blur", function () {
                $("#gridAddDispatchGoods").jqGrid("saveCell", iRow, iCol);
            });
        },
        afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
            //检查实发件数
            if (cellname == "ActualPackages") {
                var actualPackages = parseInt(value);
                if (isNaN(actualPackages)) {
                    $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0" });
                    alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotValidNumeric %>");
                }
                else if (actualPackages < 0) {
                    $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0" });
                    alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesNotGreaterThanOrEqualZero %>");
                }
                else {
                    var row = $("#gridAddDispatchGoods").jqGrid("getRowData", rowid);
                    if (actualPackages > parseInt(row.Packages)) {
                        $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualPackages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesCanNotGreaterThanPackages %>");
                    }
                }
        }

            //检查实发吨数
            if (cellname == "ActualTunnages") {
                var actualTunnages = parseFloat(value);
                if (isNaN(actualTunnages)) {
                    $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: "0" });
                    alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotValidNumeric %>");
                }
                else if (actualTunnages < 0) {
                    $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: "0" });
                    alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesNotGreaterThanOrEqualZero %>");
                }
                else {
                    var row = $("#gridAddDispatchGoods").jqGrid("getRowData", rowid);
                    if (actualTunnages > parseFloat(row.Tunnages)) {
                        $("#gridAddDispatchGoods").jqGrid("setRowData", rowid, { ActualTunnages: "0" });
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualTunnagesCanNotGreaterThanTunnages %>");
                    }
                }
        }

            //合计实发件数和实发吨数
            var totalActualPackages = 0;
            var totalActualTunnages = 0;
            var rows = $("#gridAddDispatchGoods").jqGrid("getRowData");
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                totalActualPackages = add(totalActualPackages, parseInt(row.ActualPackages));
                totalActualTunnages = add(totalActualTunnages, parseFloat(row.ActualTunnages));
            }
            $("#gridAddDispatchGoods").jqGrid("footerData", "set", { ActualPackages: totalActualPackages, ActualTunnages: totalActualTunnages });

            //计算运费
            AddPlanComputeTransportCharges();
        }
    });
    $("#gridAddDispatchGoods").jqGrid("navGrid", "#pagerAddDispatchGoods", { edit: false, add: false, del: false, search: false });
    $("#gridAddDispatchGoods").jqGrid("setGridWidth", $("#dialogAddPlan > fieldset:first").width() - 2);
        //#endregion

        //#region 隐藏公里数编辑框
    $("#formAddPlanComputeTransportCharges tr:eq(2)").hide();
        //#endregion
}
                        //#endregion

                        //#region 初始化运费计算控件
                        $("#formAddPlanComputeTransportCharges #TransportChargeExpression").val("");
                        $("#formAddPlanComputeTransportCharges #TransportPriceExpression").val("");
                        $("#formAddPlanComputeTransportCharges #KM").val("0");
                        $("#formAddPlanComputeTransportCharges #AgreementTransportPrice").val("0.00");
                        $("#formAddPlanComputeTransportCharges #ActualTransportPrice").val("0.00");
                        $("#formAddPlanComputeTransportCharges #TransportCharges").val("0.00");
                        $("#formAddPlanComputeTransportCharges #Remark").val("");

                        //如果计划为客户自提，则不需要计算运费，同时应将自提车辆信息复制到当前界面；否则应读取结算公式和单价
                        $.get("/Common/LoadDeliverPlan", { nPlanId: objMain.objWorkspace.objContent.selectedDispatchPlanId }, function (ret) {
                            if (ret != null) {
                                var startCountry = ret.StartCountry;
                                var startProvince = ret.StartProvince;
                                var startCity = ret.StartCity;
                                var destCountry = ret.DestCountry;
                                var destProvince = ret.DestProvince;
                                var destCity = ret.DestCity;
                                var planType = ret.PlanType;
                                var receiverName = ret.ReceiverName;
                                var receiveType = ret.ReceiveType;
                                var carNo = ret.CarNo;
                                var trailerNo = ret.TrailerNo;
                                var driverName = ret.DriverName;
                                var driverLicenseNo = ret.DriverLicenseNo;
                                var driverMobileTel = ret.DriverMobileTel;
                                var driverHomeTel = ret.DriverHomeTel;
                                var carrierId = ret.CarrierId;
                                var carrierName = ret.CarrierName;
                                var createTime = ret.CreateTime;

                                //读取公里数
                                $.get("/Common/LoadDistance", { strReceiverName: receiverName, startCountry: startCountry, startProvince: startProvince, startCity: startCity }, function (ret) {
                                    if (ret != null) {
                                        $("#formAddPlanComputeTransportCharges #KM").val(ret);
                                    }
                                }, "text json").error(function (xhr, status, error) {
                                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                    return;
                                });

                                //自提
                                if (receiveType == "<%: InnoSoft.LS.Resources.Options.PickUpSelf %>" && carNo == $("#form1 #CarNo").val().trim()) {
                                    //禁用运费编辑控件
                                    $("#dialogAddPlan fieldset:last > legend").text("<%: InnoSoft.LS.Resources.Tabs.TransportChargesComputePickUpSelf %>");
                                    $("#formAddPlanComputeTransportCharges #TransportChargeExpression").attr("disabled", "disabled");
                                    $("#formAddPlanComputeTransportCharges #TransportPriceExpression").attr("disabled", "disabled");
                                    $("#formAddPlanComputeTransportCharges #ActualTransportPrice").attr("disabled", "disabled");
                                    $("#formAddPlanComputeTransportCharges #TransportCharges").attr("disabled", "disabled");
                                    $("#formAddPlanComputeTransportCharges #Remark").attr("disabled", "disabled");

                                    //复制自提车辆信息
                                    if ($("#form1 #TrailerNo").val().trim() == "") {
                                        $("#form1 #TrailerNo").val(trailerNo);
                                    }
                                    if ($("#form1 #txtDriverName").css("display") == "none") {
                                        if ($("#form1 #selDriverName").val().trim() == "") {
                                            var count = $("#form1 #selDriverName option").length;
                                            for (var i = 0; i < count; i++) {
                                                if ($("#form1 #selDriverName").get(0).options[i].text == driverName) {
                                                    $("#form1 #selDriverName").get(0).selectedIndex = i;
                                                    break;
                                                }
                                            }
                                            $("#form1 #txtDriverName").val(driverName);
                                        }
                                    }
                                    else {
                                        if ($("#form1 #txtDriverName").val().trim() == "") {
                                            $("#form1 #txtDriverName").val(driverName);
                                            $("#form1 #selDriverName").empty();
                                            $("#form1 #selDriverName").append("<option value='0'>" + driverName + "</option>");
                                            $("#form1 #selDriverName").get(0).selectedIndex = 0;
                                        }
                                    }
                                    if ($("#form1 #DriverLicenseNo").val().trim() == "") {
                                        $("#form1 #DriverLicenseNo").val(driverLicenseNo);
                                    }
                                    if ($("#form1 #DriverMobileTel").val().trim() == "") {
                                        $("#form1 #DriverMobileTel").val(driverMobileTel);
                                    }
                                    if ($("#form1 #DriverHomeTel").val().trim() == "") {
                                        $("#form1 #DriverHomeTel").val(driverHomeTel);
                                    }
                                    if ($("#form1 #CarrierId").val().trim() == "0") {
                                        $("#form1 #CarrierId").val(carrierId);
                                    }
                                    if ($("#form1 #CarrierName").val().trim() == "") {
                                        $("#form1 #CarrierName").val(carrierName);
                                    }
                                }
                                    //配送
                                else {
                                    $("#formAddPlanComputeTransportCharges #TransportChargeExpression").removeAttr("disabled");
                                    $("#formAddPlanComputeTransportCharges #TransportPriceExpression").removeAttr("disabled");
                                    $("#formAddPlanComputeTransportCharges #ActualTransportPrice").removeAttr("disabled");
                                    $("#formAddPlanComputeTransportCharges #TransportCharges").removeAttr("disabled");
                                    $("#formAddPlanComputeTransportCharges #Remark").removeAttr("disabled");

                                    //读取承运单位信息
                                    $.get("/Common/LoadCarrier", { carrierId: $("#form1 #CarrierId").val().trim() }, function (ret) {
                                        if (ret != null) {
                                            var businessType = ret.BusinessType;

                                            //如果是月结车辆，则提示运费月结
                                            if (ret.PaymentType == "<%: InnoSoft.LS.Resources.Options.MonthlyStatement %>") {
                                                $("#dialogAddPlan fieldset:last > legend").text("<%: InnoSoft.LS.Resources.Tabs.TransportChargesComputeMonthlyStatement %>");
                                            }
                                            else {
                                                $("#dialogAddPlan fieldset:last > legend").text("<%: InnoSoft.LS.Resources.Tabs.TransportChargesCompute %>");
                                            }

                                            //读取承运单位结算公式
                                            $.get("/Common/LoadCarrierSettlementExpression", { carrierId: $("#form1 #CarrierId").val().trim(), planType: planType }, function (ret) {
                                                if (ret != null) {
                                                    $("#formAddPlanComputeTransportCharges #TransportChargeExpression").val(ret.TransportChargeExpression);
                                                    $("#formAddPlanComputeTransportCharges #TransportPriceExpression").val(ret.TransportPriceExpression);
                                                }

                                                //如果承运单位是自营，则承运单位协议价格就是客户结算价格；否则读取承运单位协议单价
                                                if (businessType == "<%: InnoSoft.LS.Resources.Options.SelfSupport %>") {
                                                    $.get("/Common/LoadCustomerTransportPrice", { planId: objMain.objWorkspace.objContent.selectedDispatchPlanId, carType: $("#form1 #CarType").val().trim() }, function (ret) {
                                                        $("#formAddPlanComputeTransportCharges #AgreementTransportPrice").val(ret);
                                                        $("#formAddPlanComputeTransportCharges #ActualTransportPrice").val(ret);

                                                        //计算运费
                                                        AddPlanComputeTransportCharges();
                                                    }, "text json").error(function (xhr, status, error) {
                                                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                                        return;
                                                    });
                                                }
                                                else {
                                                    $.get("/Common/LoadCarrierTransportPrice", { carrierId: $("#form1 #CarrierId").val().trim(), startCountry: startCountry, startProvince: startProvince, startCity: startCity, destCountry: destCountry, destProvince: destProvince, destCity: destCity, planType: planType, createTime: createTime }, function (ret) {
                                                        $("#formAddPlanComputeTransportCharges #AgreementTransportPrice").val(ret);
                                                        $("#formAddPlanComputeTransportCharges #ActualTransportPrice").val(ret);

                                                        //计算运费
                                                        AddPlanComputeTransportCharges();
                                                    }, "text json").error(function (xhr, status, error) {
                                                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                                        return;
                                                    });
                                                }
                                            }, "text json").error(function (xhr, status, error) {
                                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                                return;
                                            });
                                        }
                                    }, "text json").error(function (xhr, status, error) {
                                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                        return;
                                    });
                                }
                            }
                        }, "text json").error(function (xhr, status, error) {
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            return;
                        });
                        //#endregion
                    }
                });
                $("#gridAddDispatchDeliverPlans").jqGrid("navGrid", "#pagerAddDispatchDeliverPlans", { edit: false, add: false, del: false, search: false });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置运费公式自动完成
                $("#formAddPlanComputeTransportCharges #TransportChargeExpression").autocomplete({
                    source: transportChargeExpressions,
                    change: function (event, ui) {
                        //检查公式
                        var arrTokens = Tokanize($("#formAddPlanComputeTransportCharges #TransportChargeExpression").val().trim());
                        if (arrTokens == null || arrTokens == undefined) {
                            alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                            $("#formAddPlanComputeTransportCharges #TransportChargeExpression").val("");
                        }
                        else if (arrTokens.length <= 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                            $("#formAddPlanComputeTransportCharges #TransportChargeExpression").val("");
                        }
                        else {
                            for (var i = 0; i < arrTokens.length; i++) {
                                if (arrTokens[i] != "(" && arrTokens[i] != ")" && IsVariable(arrTokens[i])) {
                                    if (arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.KM %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Tunnages %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Piles %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>") {
                                        alert("<%: InnoSoft.LS.Resources.Strings.NotValidTransportChargeExpressionVariable %>");
                                        $("#formAddPlanComputeTransportCharges #TransportChargeExpression").val("");
                                        break;
                                    }
                                }
                            }
                        }

                        //计算运费
                        AddPlanComputeTransportCharges();
                    }
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置单价公式自动完成
                $("#formAddPlanComputeTransportCharges #TransportPriceExpression").autocomplete({
                    source: transportPriceExpressions,
                    change: function (event, ui) {
                        //检查公式
                        var arrTokens = Tokanize($("#formAddPlanComputeTransportCharges #TransportPriceExpression").val().trim());
                        if (arrTokens == null || arrTokens == undefined) {
                            alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                            $("#formAddPlanComputeTransportCharges #TransportPriceExpression").val("");
                        }
                        else if (arrTokens.length <= 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                            $("#formAddPlanComputeTransportCharges #TransportPriceExpression").val("");
                        }
                        else {
                            for (var i = 0; i < arrTokens.length; i++) {
                                if (arrTokens[i] != "(" && arrTokens[i] != ")" && IsVariable(arrTokens[i])) {
                                    if (arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.KM %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Tunnages %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Piles %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>") {
                                        alert("<%: InnoSoft.LS.Resources.Strings.NotValidTransportPriceExpressionVariable %>");
                                        $("#formAddPlanComputeTransportCharges #TransportPriceExpression").val("");
                                        break;
                                    }
                                }
                            }
                        }

                        //计算单价
                        AddPlanComputeTransportPrice();
                    }
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置公里数改变事件
                $("#formAddPlanComputeTransportCharges #KM").change(function () {
                    //检查公里数
                    var km = parseInt($("#formAddPlanComputeTransportCharges #KM").val().trim());
                    if (isNaN(km) || km <= 0) {
                        $("#formAddPlanComputeTransportCharges #KM").val("0");
                    }

                    //计算运费
                    AddPlanComputeTransportCharges();
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置协议单价为只读
                $("#formAddPlanComputeTransportCharges #AgreementTransportPrice").attr("disabled", "disabled");

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置实际单价改变事件
                $("#formAddPlanComputeTransportCharges #ActualTransportPrice").change(function () {
                    //检查单价
                    var actualTransportPrice = parseFloat($("#formAddPlanComputeTransportCharges #ActualTransportPrice").val().trim());
                    if (isNaN(actualTransportPrice) || actualTransportPrice <= 0) {
                        $("#formAddPlanComputeTransportCharges #ActualTransportPrice").val("0.00");
                    }

                    //计算运费
                    AddPlanComputeTransportCharges();
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置运费改变事件
                $("#formAddPlanComputeTransportCharges #TransportCharges").change(function () {
                    //检查运费
                    var transportCharges = parseFloat($("#formAddPlanComputeTransportCharges #TransportCharges").val().trim());
                    if (isNaN(transportCharges)) {
                        $("#formAddPlanComputeTransportCharges #TransportCharges").val("0.00");
                    }

                    //计算单价
                    AddPlanComputeTransportPrice();
                });
                //#endregion

                //#region 4.修改计划
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //创建修改计划对话框
                $("#dialogModifyPlan").dialog({
                    autoOpen: false,
                    height: 600,
                    width: 1000,
                    modal: true,
                    resizable: false,
                    buttons: {
                        "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                            //#region 数据验证
                            var rows = $("#gridModifyDispatchGoods").jqGrid("getRowData");
                            for (var i = 0; i < rows.length; i++) {
                                var row = rows[i];
                                var packages = (row.Packages == null || row.Packages == undefined) ? "0" : row.Packages;
                                var piles = (row.Piles == null || row.Piles == undefined) ? "0" : row.Piles;
                                var actualPackages = (row.ActualPackages == null || row.ActualPackages == undefined) ? "0" : row.ActualPackages;
                                var actualPiles = (row.ActualPiles == null || row.ActualPiles == undefined) ? "0" : row.ActualPiles;

                                if (Math.abs(parseInt(actualPackages)) > Math.abs(parseInt(packages))) {
                                    alert("<%: InnoSoft.LS.Resources.Strings.ActualPackagesCanNotGreaterThanPackages %>");
                                    return;
                                }
                                if (Math.abs(parseFloat(actualPiles)) > Math.abs(parseFloat(piles))) {
                                    alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesCanNotGreaterThanPiles %>");
                                    return;
                                }
                            }

                            if ($("#formModifyPlanComputeTransportCharges").valid() == false) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCompleteAndCorrectTransportChargeInfo %>");
                                return;
                            }

                            if ($("#form1").valid() == false) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCompleteAndCorrectCarInfo %>");
                                return;
                            }
                            //#endregion

                            //读取当前待调度计划数据
                            var data = $("#gridDispatchedDeliverPlans").jqGrid("getRowData", objMain.objWorkspace.objContent.selectedDispatchedPlanId);
                            $.get("/Common/LoadDeliverPlan", { nPlanId: data.PlanId }, function (ret) {
                                if (ret != null) {
                                    //#region 检查实发件数(箱数)、吨数、垛数、万只，和总吨数与载重

                                    //读取累计配载吨数
                                    var footerData = $("#gridDispatchedDeliverPlans").jqGrid("footerData");
                                    var totalDispatchedTunnages = footerData.Tunnages;
                                    if (totalDispatchedTunnages == null || totalDispatchedTunnages == undefined) {
                                        totalDispatchedTunnages = "0";
                                    }

                                    //读取原配载吨数
                                    var dispatchedTunnages = data.Tunnages;

                                    //读取实发件数、吨数、垛数和万只
                                    var footerData = $("#gridModifyDispatchGoods").jqGrid("footerData");
                                    var actualPackages = footerData.ActualPackages;
                                    if (actualPackages == null || actualPackages == undefined) {
                                        actualPackages = "0";
                                    }
                                    var actualTunnages = footerData.ActualTunnages;
                                    if (actualTunnages == null || actualTunnages == undefined) {
                                        actualTunnages = "0";
                                    }
                                    var actualPiles = footerData.ActualPiles;
                                    if (actualPiles == null || actualPiles == undefined) {
                                        actualPiles = "0";
                                    }
                                    var actualTenThousands = footerData.ActualTenThousands;
                                    if (actualTenThousands == null || actualTenThousands == undefined) {
                                        actualTenThousands = "0";
                                    }

                                    //纸发货计划
                                    if (ret.PlanType == "<%: InnoSoft.LS.Resources.Options.PaperPlan %>" || ret.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverPaperPlan %>") {
                                        //检查实发件数
                                        if (parseInt(actualPackages) == 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPackages %>");
                                            return;
                                        }
                                        //检查总吨数与载重
                                        var totalTunnages = add(totalDispatchedTunnages, actualTunnages);
                                        totalTunnages = sub(totalTunnages, dispatchedTunnages);
                                        if (totalTunnages > parseInt($("#form1 #CarryingCapacity").val().trim())) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.TotalTunnagesCanNotGreaterThanCarryingCapacity %>");
                                            return;
                                        }
                                    }
                                        //罐发货计划
                                    else if (ret.PlanType == "<%: InnoSoft.LS.Resources.Options.CanPlan %>" || ret.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverCanPlan %>") {
                                        //检查实发垛数
                                        if (parseFloat(actualPiles) == 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPiles %>");
                                            return;
                                        }
                                        //检查实发万只
                                        if (parseFloat(actualTenThousands) == 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualTenThousands %>");
                                            return;
                                        }
                                    }
                                        //方便面发货计划
                                    else if (ret.PlanType == "<%: InnoSoft.LS.Resources.Options.NoodlePlan %>") {
                                        //检查实发箱数和吨数
                                        if (parseInt(actualPackages) == 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPackages %>");
                                            return;
                                        }
                                        if (parseFloat(actualTunnages) == 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualTunnages %>");
                                            return;
                                        }
                                        //检查总吨数与载重
                                        var totalTunnages = add(totalDispatchedTunnages, actualTunnages);
                                        totalTunnages = sub(totalTunnages, dispatchedTunnages);
                                        if (Math.abs(totalTunnages) > parseInt($("#form1 #CarryingCapacity").val().trim())) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.TotalTunnagesCanNotGreaterThanCarryingCapacity %>");
                                            return;
                                        }
                                        //检查公里数
                                        var km = parseInt($("#formModifyPlanComputeTransportCharges #KM").val().trim());
                                        if (isNaN(km) || km <= 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.KMNotGreaterThanZero %>");
                                            return;
                                        }
                                    }
                                        //其它发货计划
                                    else {
                                        //检查实发件数
                                        if (parseInt(actualPackages) == 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPackages %>");
                                            return;
                                        }
                                        //检查总吨数与载重
                                        var totalTunnages = add(totalDispatchedTunnages, actualTunnages);
                                        totalTunnages = sub(totalTunnages, dispatchedTunnages);
                                        if (totalTunnages > parseInt($("#form1 #CarryingCapacity").val().trim())) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.TotalTunnagesCanNotGreaterThanCarryingCapacity %>");
                                            return;
                                        }
                                    }
                                    //#endregion

                                    //#region 提货方式为配送时，应检查结算公式、单价和运费
                            if (ret.ReceiveType == "<%: InnoSoft.LS.Resources.Options.PickUpDelivery %>") {
                                        if ($("#formModifyPlanComputeTransportCharges #TransportChargeExpression").val().trim() == "") {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTransportChargeExpression %>");
                                            return;
                                        }

                                        if ($("#formModifyPlanComputeTransportCharges #TransportPriceExpression").val().trim() == "") {
                                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTransportPriceExpression %>");
                                            return;
                                        }

                                        var actualTransportPrice = parseFloat($("#formModifyPlanComputeTransportCharges #ActualTransportPrice").val().trim());
                                        if (isNaN(actualTransportPrice) || actualTransportPrice <= 0) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.ActualTransportPriceNotGreaterThanZero %>");
                                            return;
                                        }

                                        var transportCharges = parseFloat($("#formModifyPlanComputeTransportCharges #TransportCharges").val().trim());
                                        if (isNaN(transportCharges)) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.TransportChargesNotValidNumeric %>");
                                            return;
                                        }
                                    }
                                    //#endregion

                                    //#region 保存数据
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

                                    //生成调度货物JSON数据
                                    var goods = new Array();
                                    for (var i = 0; i < rows.length; i++) {
                                        var row = rows[i];
                                        var goodsId = row.GoodsId;
                                        var goodsNo = row.GoodsNo;
                                        var goodsName = row.GoodsName;
                                        var brand = (row.Brand == null || row.Brand == undefined) ? "" : row.Brand;
                                        var specModel = (row.SpecModel == null || row.SpecModel == undefined) ? "" : row.SpecModel;
                                        var gWeight = (row.GWeight == null || row.GWeight == undefined) ? "" : row.GWeight;
                                        var grade = (row.Grade == null || row.Grade == undefined) ? "" : row.Grade;
                                        var pieceWeight = (row.PieceWeight == null || row.PieceWeight == undefined) ? "0" : row.PieceWeight;
                                        var packing = (row.Packing == null || row.Packing == undefined) ? "" : row.Packing;
                                        var batchNo = (row.BatchNo == null || row.BatchNo == undefined) ? "" : row.BatchNo;
                                        var location = (row.Location == null || row.Location == undefined) ? "" : row.Location;
                                        var packages = (row.ActualPackages == null || row.ActualPackages == undefined) ? "0" : row.ActualPackages;
                                        var tunnages = (row.ActualTunnages == null || row.ActualTunnages == undefined) ? "0" : row.ActualTunnages;
                                        var piles = (row.ActualPiles == null || row.ActualPiles == undefined) ? "0" : row.ActualPiles;
                                        var tenThousands = (row.ActualTenThousands == null || row.ActualTenThousands == undefined) ? "0" : row.ActualTenThousands;
                                        var productionDate = (row.ProductionDate == null || row.ProductionDate == undefined) ? "" : row.ProductionDate;
                                        var enterWarehouseBillId = (row.EnterWarehouseBillId == null || row.EnterWarehouseBillId == undefined) ? "0" : row.EnterWarehouseBillId;
                                        var enterWarehouseBillNo = (row.EnterWarehouseBillNo == null || row.EnterWarehouseBillNo == undefined) ? "" : row.EnterWarehouseBillNo;

                                        if (parseInt(packages) != 0 || parseFloat(piles) > 0) {
                                            var g = {
                                                "PlanId": data.PlanId,
                                                "GoodsId": goodsId,
                                                "GoodsNo": goodsNo,
                                                "GoodsName": goodsName,
                                                "Brand": brand,
                                                "SpecModel": specModel,
                                                "GWeight": gWeight,
                                                "Grade": grade,
                                                "PieceWeight": pieceWeight,
                                                "Packing": packing,
                                                "BatchNo": batchNo,
                                                "Location": location,
                                                "Packages": packages,
                                                "Tunnages": tunnages,
                                                "Piles": piles,
                                                "TenThousands": tenThousands,
                                                "ProductionDate": productionDate,
                                                "EnterWarehouseBillId": enterWarehouseBillId,
                                                "EnterWarehouseBillNo": enterWarehouseBillNo
                                            };
                                            goods.push(g);
                                        }
                                    }

                                    //生成调度计划JSON数据
                                    var deliverPlans = new Array();
                                    var p = {
                                        "PlanId": data.PlanId,
                                        "Packages": actualPackages,
                                        "Tunnages": actualTunnages,
                                        "Piles": actualPiles,
                                        "TenThousands": actualTenThousands,
                                        "TransportChargeExpression": $("#formModifyPlanComputeTransportCharges #TransportChargeExpression").val().trim(),
                                        "TransportPriceExpression": $("#formModifyPlanComputeTransportCharges #TransportPriceExpression").val().trim(),
                                        "KM": $("#formModifyPlanComputeTransportCharges #KM").val().trim(),
                                        "AgreementTransportPrice": $("#formModifyPlanComputeTransportCharges #AgreementTransportPrice").val().trim(),
                                        "ActualTransportPrice": $("#formModifyPlanComputeTransportCharges #ActualTransportPrice").val().trim(),
                                        "TransportCharges": $("#formModifyPlanComputeTransportCharges #TransportCharges").val().trim(),
                                        "Remark": $("#formModifyPlanComputeTransportCharges #Remark").val().trim()
                                    };
                                    deliverPlans.push(p);

                                    //生成调度单JSON数据
                                    var d = {
                                        "Id": data.DispatchBillId,
                                        "CarNo": $("#form1 #CarNo").val().trim(),
                                        "TrailerNo": $("#form1 #TrailerNo").val().trim(),
                                        "CarType": $("#form1 #CarType").val().trim(),
                                        "DriverName": $("#form1 #txtDriverName").val().trim(),
                                        "DriverLicenseNo": $("#form1 #DriverLicenseNo").val().trim(),
                                        "DriverMobileTel": $("#form1 #DriverMobileTel").val().trim(),
                                        "DriverHomeTel": $("#form1 #DriverHomeTel").val().trim(),
                                        "CarrierId": $("#form1 #CarrierId").val().trim(),
                                        "CarrierName": $("#form1 #CarrierName").val().trim(),
                                        "CarryingCapacity": $("#form1 #CarryingCapacity").val().trim(),
                                        "BusinessType": $("#form1 #BusinessType").val().trim(),
                                        "PaymentType": $("#form1 #PaymentType").val().trim(),
                                        "CreateTime": $("#form1 #CreateTime").val().trim(),
                                        "DeliverPlans": deliverPlans,
                                        "Goods": goods
                                    };

                                    var postData = JSON.stringify(d);

                                    //发送数据
                                    $.ajax({
                                        type: "POST",
                                        url: "/chenxk/Dispatch/ModifyDispatchedPlan/",
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

                                                objMain.objWorkspace.objContent.selectedDispatchedPlanId = null;

                                                //刷新已配载计划表格
                                                $("#gridDispatchedDeliverPlans").jqGrid("setGridParam", {
                                                    url: "/chenxk/Dispatch/LoadDispatchedDeliverPlansGrid/",
                                                    postData: {
                                                        carNo: $("#form1 #CarNo").val().trim()
                                                    }
                                                });
                                                $("#gridDispatchedDeliverPlans").trigger("reloadGrid", [{ page: 1 }]);

                                                //刷新已配载货物表格
                                                $("#gridDispatchedGoods").jqGrid("setGridParam", {
                                                    url: "/chenxk/Dispatch/LoadDispatchedGoodsGrid/",
                                                    postData: {
                                                        carNo: $("#form1 #CarNo").val().trim(),
                                                        planId: "0"
                                                    }
                                                });
                                                $("#gridDispatchedGoods").trigger("reloadGrid", [{ page: 1 }]);

                                                //关闭对话框
                                                $("#dialogModifyPlan").dialog("close");

                                                objMain.objWorkspace.objContent.isCarInfoChanged = true;
                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            $.unblockUI();

                                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                        }
                                    });
                                    //#endregion
                                }
                                else {
                                    alert("<%: InnoSoft.LS.Resources.Strings.LoadDeliverPlanFailed %>");
                                }
                            }, "text json").error(function (xhr, status, error) {
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            });
                        },
                        "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                            $("#dialogModifyPlan").dialog("close");
                        }
                    },
                    open: function () {
                        var w = parseInt($("#dialogModifyPlan").width()) - parseInt($("#dialogModifyPlan > fieldset:first").css("border-left-width")) * 2 - parseInt($("#dialogModifyPlan > fieldset:first").css("padding-left")) * 2 - parseInt($("#dialogModifyPlan > fieldset:first").css("margin-left")) * 2 - $.scrollbarWidth();
                        $("#gridModifyDispatchGoods").jqGrid("setGridWidth", w - 2);
                    },
                    close: function () {
                    }
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置运费公式自动完成
                $("#formModifyPlanComputeTransportCharges #TransportChargeExpression").autocomplete({
                    source: transportChargeExpressions,
                    change: function (event, ui) {
                        //检查公式
                        var arrTokens = Tokanize($("#formModifyPlanComputeTransportCharges #TransportChargeExpression").val().trim());
                        if (arrTokens == null || arrTokens == undefined) {
                            alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                            $("#formModifyPlanComputeTransportCharges #TransportChargeExpression").val("");
                        }
                        else if (arrTokens.length <= 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                            $("#formModifyPlanComputeTransportCharges #TransportChargeExpression").val("");
                        }
                        else {
                            for (var i = 0; i < arrTokens.length; i++) {
                                if (arrTokens[i] != "(" && arrTokens[i] != ")" && IsVariable(arrTokens[i])) {
                                    if (arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.KM %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Tunnages %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Piles %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>") {
                                        alert("<%: InnoSoft.LS.Resources.Strings.NotValidTransportChargeExpressionVariable %>");
                                        $("#formModifyPlanComputeTransportCharges #TransportChargeExpression").val("");
                                        break;
                                    }
                                }
                            }
                        }

                        //计算运费
                        ModifyPlanComputeTransportCharges();
                    }
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置单价公式自动完成
                $("#formModifyPlanComputeTransportCharges #TransportPriceExpression").autocomplete({
                    source: transportPriceExpressions,
                    change: function (event, ui) {
                        //检查公式
                        var arrTokens = Tokanize($("#formModifyPlanComputeTransportCharges #TransportPriceExpression").val().trim());
                        if (arrTokens == null || arrTokens == undefined) {
                            alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                            $("#formModifyPlanComputeTransportCharges #TransportPriceExpression").val("");
                        }
                        else if (arrTokens.length <= 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                            $("#formModifyPlanComputeTransportCharges #TransportPriceExpression").val("");
                        }
                        else {
                            for (var i = 0; i < arrTokens.length; i++) {
                                if (arrTokens[i] != "(" && arrTokens[i] != ")" && IsVariable(arrTokens[i])) {
                                    if (arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.KM %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Tunnages %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Piles %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>") {
                                        alert("<%: InnoSoft.LS.Resources.Strings.NotValidTransportPriceExpressionVariable %>");
                                        $("#formModifyPlanComputeTransportCharges #TransportPriceExpression").val("");
                                        break;
                                    }
                                }
                            }
                        }

                        //计算单价
                        ModifyPlanComputeTransportPrice();
                    }
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置公里数改变事件
                $("#formModifyPlanComputeTransportCharges #KM").change(function () {
                    //检查公里数
                    var km = parseInt($("#formModifyPlanComputeTransportCharges #KM").val().trim());
                    if (isNaN(km) || km <= 0) {
                        $("#formModifyPlanComputeTransportCharges #KM").val("0");
                    }

                    //计算运费
                    ModifyPlanComputeTransportCharges();
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置协议单价为只读
                $("#formModifyPlanComputeTransportCharges #AgreementTransportPrice").attr("disabled", "disabled");

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置实际单价改变事件
                $("#formModifyPlanComputeTransportCharges #ActualTransportPrice").change(function () {
                    //检查单价
                    var actualTransportPrice = parseFloat($("#formModifyPlanComputeTransportCharges #ActualTransportPrice").val().trim());
                    if (isNaN(actualTransportPrice) || actualTransportPrice <= 0) {
                        $("#formModifyPlanComputeTransportCharges #ActualTransportPrice").val("0.00");
                    }

                    //计算运费
                    ModifyPlanComputeTransportCharges();
                });

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //设置运费改变事件
                $("#formModifyPlanComputeTransportCharges #TransportCharges").change(function () {
                    //检查运费
                    var transportCharges = parseFloat($("#formModifyPlanComputeTransportCharges #TransportCharges").val().trim());
                    if (isNaN(transportCharges)) {
                        $("#formModifyPlanComputeTransportCharges #TransportCharges").val("0.00");
                    }

                    //计算单价
                    ModifyPlanComputeTransportPrice();
                });
                //#endregion
            });

        //检查客户自提发货计划，并自动添加
        function checkDispatchPickUpSelfDeliverPlans() {
            //停止计时器
            clearInterval(objMain.objWorkspace.objContent.timerCheckPickUpSelfDeliverPlans);

            //读取自提计划个数
            $.ajax({
                url: "/chenxk/Dispatch/LoadDispatchDeliverPlansCountByCarNo",
                type: "GET",
                data: { strCarNo: $("#form1 #CarNo").val().trim() },
                dataType: "json",
                async: false,
                success: function (ret) {
                    if (ret > 0) {
                        if (confirm("<%: InnoSoft.LS.Resources.Strings.AutoAddPickUpSelfDeliverPlansConfirm %>") == true) {
                            //清除当前选中的待调度计划编码
                            objMain.objWorkspace.objContent.selectedDispatchPlanId = null;

                            //刷新待调度计划表格
                            $("#gridAddDispatchDeliverPlans").jqGrid("setGridParam", {
                                url: "/chenxk/Dispatch/LoadDispatchDeliverPlansGrid/",
                                postData: {
                                    carNo: $("#form1 #CarNo").val().trim()
                                }
                            });
                            $("#gridAddDispatchDeliverPlans").trigger("reloadGrid", [{ page: 1 }]);

                            //清除待调度货物表格
                            $("#gridAddDispatchGoods").jqGrid("GridUnload", "#gridAddDispatchGoods");

                            //初始化运费编辑控件
                            $("#formAddPlanComputeTransportCharges #TransportChargeExpression").val("");
                            $("#formAddPlanComputeTransportCharges #TransportPriceExpression").val("");
                            $("#formAddPlanComputeTransportCharges #KM").val("0");
                            $("#formAddPlanComputeTransportCharges #AgreementTransportPrice").val("0.00");
                            $("#formAddPlanComputeTransportCharges #ActualTransportPrice").val("0.00");
                            $("#formAddPlanComputeTransportCharges #TransportCharges").val("0.00");
                            $("#formAddPlanComputeTransportCharges #Remark").val("");

                            //打开对话框
                            $("#dialogAddPlan").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.AddDispatchedPlan %>");
                            $("#dialogAddPlan").dialog("open");
                        }
                    }
                },
                error: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
        }

        //添加计划时计算运费
        function AddPlanComputeTransportCharges() {
            try {
                var exp = new Expression("");
                exp.Expression($("#formAddPlanComputeTransportCharges #TransportChargeExpression").val().trim());

                //添加公里数变量
                var km = parseInt($("#formAddPlanComputeTransportCharges #KM").val().trim());
                if (isNaN(km) || km <= 0) {
                    km = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.KM %>", km);

                //添加吨数变量
                var footerData = $("#gridAddDispatchGoods").jqGrid("footerData");
                var actualTunnages = footerData.ActualTunnages;
                if (actualTunnages == null || actualTunnages == undefined) {
                    actualTunnages = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Tunnages %>", actualTunnages);

                //添加垛数变量
                var actualPiles = footerData.ActualPiles;
                if (actualPiles == null || actualPiles == undefined) {
                    actualPiles = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Piles %>", actualPiles);

                //添加单价变量
                var actualTransportPrice = parseFloat($("#formAddPlanComputeTransportCharges #ActualTransportPrice").val().trim());
                if (isNaN(actualTransportPrice) || actualTransportPrice <= 0) {
                    actualTransportPrice = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportPrice %>", actualTransportPrice);

                //添加运费变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportCharges %>", 0);

                //计算结果
                var ret = exp.Evaluate();
                if (isNaN(ret)) {
                    $("#formAddPlanComputeTransportCharges #TransportCharges").val("0.00");
                }
                else {
                    $("#formAddPlanComputeTransportCharges #TransportCharges").val(Math.round(ret * Math.pow(10, 2)) / Math.pow(10, 2));
                }
            }
            catch (e) {
                $("#formAddPlanComputeTransportCharges #TransportCharges").val("0.00");
            }
        }

        //添加计划时计算单价
        function AddPlanComputeTransportPrice() {
            try {
                var exp = new Expression("");
                exp.Expression($("#formAddPlanComputeTransportCharges #TransportPriceExpression").val().trim());

                //添加公里数变量
                var km = parseInt($("#formAddPlanComputeTransportCharges #KM").val().trim());
                if (isNaN(km) || km <= 0) {
                    km = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.KM %>", km);

                //添加吨数变量
                var footerData = $("#gridAddDispatchGoods").jqGrid("footerData");
                var actualTunnages = footerData.ActualTunnages;
                if (actualTunnages == null || actualTunnages == undefined) {
                    actualTunnages = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Tunnages %>", actualTunnages);

                //添加垛数变量
                var actualPiles = footerData.ActualPiles;
                if (actualPiles == null || actualPiles == undefined) {
                    actualPiles = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Piles %>", actualPiles);

                //添加单价变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportPrice %>", 0);

                //添加运费变量
                var transportCharges = parseFloat($("#formAddPlanComputeTransportCharges #TransportCharges").val().trim());
                if (isNaN(transportCharges)) {
                    transportCharges = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportCharges %>", transportCharges);

                //计算结果
                var ret = exp.Evaluate();
                if (isNaN(ret)) {
                    $("#formAddPlanComputeTransportCharges #ActualTransportPrice").val("0.00");
                }
                else {
                    $("#formAddPlanComputeTransportCharges #ActualTransportPrice").val(Math.round(ret * Math.pow(10, 2)) / Math.pow(10, 2));
                }
            }
            catch (e) {
                $("#formAddPlanComputeTransportCharges #ActualTransportPrice").val("0.00");
            }
        }

        //修改计划时计算运费
        function ModifyPlanComputeTransportCharges() {
            try {
                var exp = new Expression("");
                exp.Expression($("#formModifyPlanComputeTransportCharges #TransportChargeExpression").val().trim());

                //添加公里数变量
                var km = parseInt($("#formModifyPlanComputeTransportCharges #KM").val().trim());
                if (isNaN(km) || km <= 0) {
                    km = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.KM %>", km);

                //添加吨数变量
                var footerData = $("#gridModifyDispatchGoods").jqGrid("footerData");
                var actualTunnages = footerData.ActualTunnages;
                if (actualTunnages == null || actualTunnages == undefined) {
                    actualTunnages = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Tunnages %>", actualTunnages);

                //添加垛数变量
                var actualPiles = footerData.ActualPiles;
                if (actualPiles == null || actualPiles == undefined) {
                    actualPiles = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Piles %>", actualPiles);

                //添加单价变量
                var actualTransportPrice = parseFloat($("#formModifyPlanComputeTransportCharges #ActualTransportPrice").val().trim());
                if (isNaN(actualTransportPrice) || actualTransportPrice <= 0) {
                    actualTransportPrice = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportPrice %>", actualTransportPrice);

                //添加运费变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportCharges %>", 0);

                //计算结果
                var ret = exp.Evaluate();
                if (isNaN(ret)) {
                    $("#formModifyPlanComputeTransportCharges #TransportCharges").val("0.00");
                }
                else {
                    $("#formModifyPlanComputeTransportCharges #TransportCharges").val(Math.round(ret * Math.pow(10, 2)) / Math.pow(10, 2));
                }
            }
            catch (e) {
                $("#formModifyPlanComputeTransportCharges #TransportCharges").val("0.00");
            }
        }

        //修改计划时计算单价
        function ModifyPlanComputeTransportPrice() {
            try {
                var exp = new Expression("");
                exp.Expression($("#formModifyPlanComputeTransportCharges #TransportPriceExpression").val().trim());

                //添加公里数变量
                var km = parseInt($("#formModifyPlanComputeTransportCharges #KM").val().trim());
                if (isNaN(km) || km <= 0) {
                    km = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.KM %>", km);

                //添加吨数变量
                var footerData = $("#gridModifyDispatchGoods").jqGrid("footerData");
                var actualTunnages = footerData.ActualTunnages;
                if (actualTunnages == null || actualTunnages == undefined) {
                    actualTunnages = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Tunnages %>", actualTunnages);

                //添加垛数变量
                var actualPiles = footerData.ActualPiles;
                if (actualPiles == null || actualPiles == undefined) {
                    actualPiles = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Piles %>", actualPiles);

                //添加单价变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportPrice %>", 0);

                //添加运费变量
                var transportCharges = parseFloat($("#formModifyPlanComputeTransportCharges #TransportCharges").val().trim());
                if (isNaN(transportCharges)) {
                    transportCharges = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportCharges %>", transportCharges);

                //计算结果
                var ret = exp.Evaluate();
                if (isNaN(ret)) {
                    $("#formModifyPlanComputeTransportCharges #ActualTransportPrice").val("0.00");
                }
                else {
                    $("#formModifyPlanComputeTransportCharges #ActualTransportPrice").val(Math.round(ret * Math.pow(10, 2)) / Math.pow(10, 2));
                }
            }
            catch (e) {
                $("#formModifyPlanComputeTransportCharges #ActualTransportPrice").val("0.00");
            }
        }

    </script>
</asp:Content>
