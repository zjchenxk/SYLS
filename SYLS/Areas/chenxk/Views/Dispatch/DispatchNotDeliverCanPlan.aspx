<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.DispatchBillViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.DispatchNotDeliverCanPlan %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Dispatch/DispatchDeliverPlans/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="/chenxk/Dispatch/DispatchDeliverPlan/" onclick="javascript:objMain.objWorkspace.objContent.save(this.href);return false;">
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
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.DispatchGoodsList %></legend>
        <div>
            <table id="grid2">
            </table>
            <div id="pager2">
            </div>
        </div>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.TransportChargesCompute %></legend>
        <% Html.RenderPartial("ComputeCanPlanTransportCharges", Model.DeliverPlans[0]); %>
    </fieldset>
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
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
                $("#grid2").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认车型获得焦点
                $("#form1 #CarType").focus();
            };
            //保存
            this.save = function (action) {
                //设置驾驶员姓名编辑框和下拉选择框相同数据，便于通过客户端验证
                if ($("#form1 #txtDriverName").css("display") == "none") {
                    $("#form1 #txtDriverName").val($("#form1 #selDriverName").find("option:selected").text());
                }
                else {
                    $("#form1 #selDriverName").empty();
                    $("#form1 #selDriverName").append("<option value='0'>" + $("#form1 #txtDriverName").val().trim() + "</option>");
                    $("#form1 #selDriverName").get(0).selectedIndex = 0;
                }

                if ($("#form1").valid() && $("#formComputeCanPlanTransportCharges").valid()) {
                    //检查录入时间
                    var createTime = $("#form1 #CreateTime").val().trim();
                    var today = formatDate(new Date(), "yyyy-MM-dd");
                    if (createTime > today) {
                        alert("<%: InnoSoft.LS.Resources.Strings.CreateTimeCantNotGreaterThanSystemTime %>");
                        return;
                    }

                    //检查实发垛数和实发万只
                    var footerData = $("#grid2").jqGrid("footerData");
                    if (footerData.ActualPiles == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualPiles %>");
                        return;
                    }
                    if (footerData.ActualTenThousands == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualTenThousands %>");
                        return;
                    }

                    //检查运费公式
                    if ($("#formComputeCanPlanTransportCharges #TransportChargeExpression").val().trim() == "") {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTransportChargeExpression %>");
                        return;
                    }

                    //检查单价公式
                    if ($("#formComputeCanPlanTransportCharges #TransportPriceExpression").val().trim() == "") {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTransportPriceExpression %>");
                        return;
                    }

                    //检查实际单价
                    var actualTransportPrice = parseFloat($("#formComputeCanPlanTransportCharges #ActualTransportPrice").val().trim());
                    if (isNaN(actualTransportPrice) || actualTransportPrice <= 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.ActualTransportPriceNotGreaterThanZero %>");
                        return;
                    }

                    //检查运费
                    var transportCharges = parseFloat($("#formComputeCanPlanTransportCharges #TransportCharges").val().trim());
                    if (isNaN(transportCharges) || transportCharges <= 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.TransportChargesNotGreaterThanZero %>");
                        return;
                    }

                    //保存数据
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
                    var rows = $("#grid2").jqGrid("getRowData");
                    var goods = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        if (parseFloat(row.ActualPiles) > 0) {
                            var g = {
                                "PlanId": "<%: Model.DeliverPlans[0].PlanId %>",
                                "GoodsId": row.GoodsId,
                                "GoodsNo": row.GoodsNo,
                                "GoodsName": row.GoodsName,
                                "Brand": "",
                                "SpecModel": row.SpecModel,
                                "GWeight": "",
                                "Grade": "",
                                "PieceWeight": "0",
                                "Packing": "",
                                "BatchNo": "",
                                "Location": "",
                                "Packages": "0",
                                "Tunnages": "0",
                                "Piles": row.ActualPiles,
                                "TenThousands": row.ActualTenThousands
                            };
                            goods.push(g);
                        }
                    }

                    //生成调度计划JSON数据
                    var deliverPlans = new Array();
                    var p = {
                        "PlanId": "<%: Model.DeliverPlans[0].PlanId %>",
                        "Packages": "0",
                        "Tunnages": "0",
                        "Piles": footerData.ActualPiles,
                        "TenThousands": footerData.ActualTenThousands,
                        "TransportChargeExpression": $("#formComputeCanPlanTransportCharges #TransportChargeExpression").val().trim(),
                        "TransportPriceExpression": $("#formComputeCanPlanTransportCharges #TransportPriceExpression").val().trim(),
                        "KM": "0",
                        "AgreementTransportPrice": $("#formComputeCanPlanTransportCharges #AgreementTransportPrice").val().trim(),
                        "ActualTransportPrice": $("#formComputeCanPlanTransportCharges #ActualTransportPrice").val().trim(),
                        "TransportCharges": $("#formComputeCanPlanTransportCharges #TransportCharges").val().trim(),
                        "Remark": $("#formComputeCanPlanTransportCharges #Remark").val().trim()
                    };
                    deliverPlans.push(p);

                    //生成调度单JSON数据
                    var d = {
                        "Id": "0",
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
                        url: action,
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
                                location.replace("/chenxk/Dispatch/DispatchDeliverPlans/");
                            }
                        },
                        error: function (xhr, status, error) {
                            $.unblockUI();

                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        }
                    });
                }
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //0.设置车型失去焦点事件
            $("#form1 #CarType").focusout(function () {
                $(this).attr("disabled", "disabled");
            });

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //1.设置车号自动完成
            $("#form1 #CarNo").autocomplete({
                source: "/Autocomplete/LoadCarNos/",
                minLength: 1,
                change: function (event, ui) {
                    //1.1.填充挂号和载重
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

                    //1.2.填充驾驶员姓名下拉列表
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
                                    $("#form1 #txtDriverName").val("");
                                }
                                else {
                                    $("#form1 #txtDriverName").val(ret.DriverName);
                                    $("#form1 #selDriverName").empty();
                                    $("#form1 #selDriverName").append("<option value=''></option>");
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

                    //1.3.填充承运单位、结算公式、单价和运费
                    $("#form1 #CarrierId").val("0");
                    $("#form1 #CarrierName").val("");
                    $("#form1 #BusinessType").removeAttr("disabled");
                    $("#form1 #PaymentType").removeAttr("disabled");
                    $("#formComputeCanPlanTransportCharges #TransportChargeExpression").val("");
                    $("#formComputeCanPlanTransportCharges #TransportPriceExpression").val("");
                    $("#formComputeCanPlanTransportCharges #AgreementTransportPrice").val("0.00");
                    $("#formComputeCanPlanTransportCharges #ActualTransportPrice").val("0.00");
                    $("#formComputeCanPlanTransportCharges #TransportCharges").val("0.00");
                    $("#formComputeCanPlanTransportCharges #Remark").val("");

                    $.get("/Common/LoadCarrierByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #CarrierId").val(ret.Id);
                            $("#form1 #CarrierName").val(ret.Name);
                            $("#form1 #BusinessType").val(ret.BusinessType);
                            $("#form1 #PaymentType").val(ret.PaymentType);
                            $("#form1 #BusinessType").attr("disabled", "disabled");
                            $("#form1 #PaymentType").attr("disabled", "disabled");

                            //如果是月结车辆，则提示运费月结
                            if ($("#form1 #PaymentType").val().trim() == "<%: InnoSoft.LS.Resources.Options.MonthlyStatement %>") {
                                $("fieldset:last > legend").text("<%: InnoSoft.LS.Resources.Tabs.TransportChargesComputeMonthlyStatement %>");
                            }
                            else {
                                $("fieldset:last > legend").text("<%: InnoSoft.LS.Resources.Tabs.TransportChargesCompute %>");
                            }

                            //读取发货计划数据
                            $.get("/Common/LoadDeliverPlan", { nPlanId: "<%: Model.DeliverPlans[0].PlanId %>" }, function (ret) {
                                if (ret != null) {
                                    var startCountry = ret.StartCountry;
                                    var startProvince = ret.StartProvince;
                                    var startCity = ret.StartCity;
                                    var destCountry = ret.DestCountry;
                                    var destProvince = ret.DestProvince;
                                    var destCity = ret.DestCity;
                                    var planType = ret.PlanType;
                                    var createTime = ret.CreateTime;

                                    //读取承运单位结算公式
                                    $.get("/Common/LoadCarrierSettlementExpression", { carrierId: $("#form1 #CarrierId").val().trim(), planType: planType }, function (ret) {
                                        if (ret != null) {
                                            $("#formComputeCanPlanTransportCharges #TransportChargeExpression").val(ret.TransportChargeExpression);
                                            $("#formComputeCanPlanTransportCharges #TransportPriceExpression").val(ret.TransportPriceExpression);
                                        }

                                        //如果承运单位是自营，则承运单位协议价格就是客户结算价格；否则读取承运单位协议单价
                                        if ($("#form1 #BusinessType").val().trim() == "<%: InnoSoft.LS.Resources.Options.SelfSupport %>") {
                                            $.get("/Common/LoadCustomerTransportPrice", { planId: "<%: Model.DeliverPlans[0].PlanId %>", carType: $("#form1 #CarType").val().trim() }, function (ret) {
                                                $("#formComputeCanPlanTransportCharges #AgreementTransportPrice").val(ret);
                                                $("#formComputeCanPlanTransportCharges #ActualTransportPrice").val(ret);

                                                //计算运费
                                                ComputeTransportCharges();
                                            }, "text json").error(function (xhr, status, error) {
                                                $("#form1 #CarNo").val("");
                                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                                return;
                                            });
                                        }
                                        else {
                                            $.get("/Common/LoadCarrierTransportPrice", { carrierId: $("#form1 #CarrierId").val().trim(), startCountry: startCountry, startProvince: startProvince, startCity: startCity, destCountry: destCountry, destProvince: destProvince, destCity: destCity, planType: planType, createTime: createTime }, function (ret) {
                                                $("#formComputeCanPlanTransportCharges #AgreementTransportPrice").val(ret);
                                                $("#formComputeCanPlanTransportCharges #ActualTransportPrice").val(ret);

                                                //计算运费
                                                ComputeTransportCharges();
                                            }, "text json").error(function (xhr, status, error) {
                                                $("#form1 #CarNo").val("");
                                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                                return;
                                            });
                                        }
                                    }, "text json").error(function (xhr, status, error) {
                                        $("#form1 #CarNo").val("");
                                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                        return;
                                    });
                                }
                            }, "text json").error(function (xhr, status, error) {
                                $("#form1 #CarNo").val("");
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                return;
                            });
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #CarNo").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        return;
                    });

                    //1.4.加载该车号上已配载的发货计划数据
                    $("#grid1").jqGrid("setGridParam", {
                        url: "/chenxk/Dispatch/LoadDispatchedCanPlansGrid/",
                        postData: { carNo: $("#form1 #CarNo").val().trim() }
                    });
                    $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                }
            });

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //2.当车号不为空时（即客户自提时），初始化驾驶员姓名控件
            if ($("#form1 #CarNo").val().trim() != "") {
                $.get("/Common/LoadDriversByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (ret) {
                    if (ret.length > 0) {
                        $.each(ret, function (i, driver) {
                            var option = $("<option></option>").val(driver.Id).text(driver.Name);
                            option.appendTo($("#form1 #selDriverName"));
                        });
                        $("#form1 #selDriverName").append("<option value='<%: InnoSoft.LS.Resources.Options.NewDriver %>'><%: InnoSoft.LS.Resources.Options.NewDriver %></option>");

                        document.getElementById("txtDriverName").style.display = "none";
                        document.getElementById("selDriverName").style.display = "inline";

                        //默认选中客户自提车辆的驾驶员
                        var count = $("#form1 #selDriverName option").length;
                        for (var i = 0; i < count; i++) {
                            if ($("#form1 #selDriverName").get(0).options[i].text == $("#form1 #txtDriverName").val().trim()) {
                                $("#form1 #selDriverName").get(0).options[i].selected = true;
                                break;
                            }
                        }
                        $("#form1 #txtDriverName").val("");
                    }
                    else {
                        document.getElementById("txtDriverName").style.display = "inline";
                        document.getElementById("selDriverName").style.display = "none";
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            }

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //3.默认显示驾驶员姓名文本框
            document.getElementById("selDriverName").style.display = "none";

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //4.驾驶员姓名改变事件
            $("#form1 #txtDriverName").change(function () {
                if ($("#form1 #CarrierId").val().trim() == "0") {
                    $("#form1 #CarrierName").val($("#form1 #txtDriverName").val().trim());
                }
            });

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //5.驾驶员姓名选择事件
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

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //6.设置录入日期
            $("#form1 #CreateTime").datepicker($.datepicker.regional["zh-CN"]);

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //7.创建已配载计划表格
            $("#grid1").jqGrid({
                url: "/chenxk/Dispatch/LoadDispatchedCanPlansGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { carNo: $("#form1 #CarNo").val().trim() },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "PlanNo", index: "PlanNo", width: 100, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right" },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "Remark", index: "Remark", width: 200}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "PlanNo",
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
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //8.创建待调度货物表格
            $("#grid2").jqGrid({
                url: "/chenxk/Dispatch/LoadDispatchNotDeliverCanPlanGoodsGrid",
                datatype: "json",
                mtype: "GET",
                postData: { planId: "<%: Model.DeliverPlans[0].PlanId %>" },
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
                    { name: "ActualTenThousands", index: "ActualTenThousands", width: 100, align: "center", editable: true}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "GoodsNo",
                sortorder: "asc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                height: 300,
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
                        $("#grid2").jqGrid("saveCell", iRow, iCol);
                    });
                },
                afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                    //检查实发垛数
                    if (cellname == "ActualPiles") {
                        var actualPiles = parseFloat(value);
                        if (isNaN(actualPiles)) {
                            $("#grid2").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesNotValidNumeric %>");
                        }
                        else if (actualPiles < 0) {
                            $("#grid2").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesNotGreaterThanOrEqualZero %>");
                        }
                        else {
                            var row = $("#grid2").jqGrid("getRowData", rowid);
                            if (actualPiles > parseFloat(row.Piles)) {
                                $("#grid2").jqGrid("setRowData", rowid, { ActualPiles: "0" });
                                alert("<%: InnoSoft.LS.Resources.Strings.ActualPilesCanNotGreaterThanPiles %>");
                            }
                        }
                    }

                    //检查实发万只
                    if (cellname == "ActualTenThousands") {
                        var actualTenThousands = parseFloat(value);
                        if (isNaN(actualTenThousands)) {
                            $("#grid2").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsNotValidNumeric %>");
                        }
                        else if (actualTenThousands < 0) {
                            $("#grid2").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                            alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsNotGreaterThanOrEqualZero %>");
                        }
                        else {
                            var row = $("#grid2").jqGrid("getRowData", rowid);
                            if (actualTenThousands > parseFloat(row.TenThousands)) {
                                $("#grid2").jqGrid("setRowData", rowid, { ActualTenThousands: "0" });
                                alert("<%: InnoSoft.LS.Resources.Strings.ActualTenThousandsCanNotGreaterThanTenThousands %>");
                            }
                        }
                    }

                    //合计实发垛数和万只
                    var totalActualPiles = 0;
                    var totalActualTenThousands = 0;
                    var rows = $("#grid2").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        totalActualPiles = add(totalActualPiles, parseFloat(row.ActualPiles));
                        totalActualTenThousands = add(totalActualTenThousands, parseFloat(row.ActualTenThousands));
                    }
                    $("#grid2").jqGrid("footerData", "set", { ActualPiles: totalActualPiles, ActualTenThousands: totalActualTenThousands });

                    //计算运费
                    ComputeTransportCharges();
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //9.设置运费公式自动完成
            $("#formComputeCanPlanTransportCharges #TransportChargeExpression").autocomplete({
                source: transportChargeExpressions,
                change: function (event, ui) {
                    //检查公式
                    var arrTokens = Tokanize($("#formComputeCanPlanTransportCharges #TransportChargeExpression").val().trim());
                    if (arrTokens == null || arrTokens == undefined) {
                        alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                        $("#formComputeCanPlanTransportCharges #TransportChargeExpression").val("");
                    }
                    else if (arrTokens.length <= 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                        $("#formComputeCanPlanTransportCharges #TransportChargeExpression").val("");
                    }
                    else {
                        for (var i = 0; i < arrTokens.length; i++) {
                            if (arrTokens[i] != "(" && arrTokens[i] != ")" && IsVariable(arrTokens[i])) {
                                if (arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.KM %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Tunnages %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Piles %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>") {
                                    alert("<%: InnoSoft.LS.Resources.Strings.NotValidTransportChargeExpressionVariable %>");
                                    $("#formComputeCanPlanTransportCharges #TransportChargeExpression").val("");
                                    break;
                                }
                            }
                        }
                    }

                    //计算运费
                    ComputeTransportCharges();
                }
            });

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //10.设置单价公式自动完成
            $("#formComputeCanPlanTransportCharges #TransportPriceExpression").autocomplete({
                source: transportPriceExpressions,
                change: function (event, ui) {
                    //检查公式
                    var arrTokens = Tokanize($("#formComputeCanPlanTransportCharges #TransportPriceExpression").val().trim());
                    if (arrTokens == null || arrTokens == undefined) {
                        alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                        $("#formComputeCanPlanTransportCharges #TransportPriceExpression").val("");
                    }
                    else if (arrTokens.length <= 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                        $("#formComputeCanPlanTransportCharges #TransportPriceExpression").val("");
                    }
                    else {
                        for (var i = 0; i < arrTokens.length; i++) {
                            if (arrTokens[i] != "(" && arrTokens[i] != ")" && IsVariable(arrTokens[i])) {
                                if (arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.KM %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Tunnages %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Piles %>" &&
                                arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>") {
                                    alert("<%: InnoSoft.LS.Resources.Strings.NotValidTransportPriceExpressionVariable %>");
                                    $("#formComputeCanPlanTransportCharges #TransportPriceExpression").val("");
                                    break;
                                }
                            }
                        }
                    }

                    //计算单价
                    ComputeTransportPrice();
                }
            });

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //11.设置协议单价为只读
            $("#formComputeCanPlanTransportCharges #AgreementTransportPrice").attr("disabled", "disabled");

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //12.设置实际单价改变事件
            $("#formComputeCanPlanTransportCharges #ActualTransportPrice").change(function () {
                //检查单价
                var actualTransportPrice = parseFloat($("#formComputeCanPlanTransportCharges #ActualTransportPrice").val().trim());
                if (isNaN(actualTransportPrice) || actualTransportPrice <= 0) {
                    $("#formComputeCanPlanTransportCharges #ActualTransportPrice").val("0.00");
                }

                //计算运费
                ComputeTransportCharges();
            });

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //13.设置运费改变事件
            $("#formComputeCanPlanTransportCharges #TransportCharges").change(function () {
                //检查运费
                var transportCharges = parseFloat($("#formComputeCanPlanTransportCharges #TransportCharges").val().trim());
                if (isNaN(transportCharges) || transportCharges <= 0) {
                    $("#formComputeCanPlanTransportCharges #TransportCharges").val("0.00");
                }

                //计算单价
                ComputeTransportPrice();
            });

        });

        //计算运费
        function ComputeTransportCharges() {
            try {
                var exp = new Expression("");
                exp.Expression($("#formComputeCanPlanTransportCharges #TransportChargeExpression").val().trim());

                //添加公里数变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.KM %>", 0);

                //添加吨数变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Tunnages %>", 0);

                //添加垛数变量
                var footerData = $("#grid2").jqGrid("footerData");
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Piles %>", footerData.ActualPiles);

                //添加单价变量
                var actualTransportPrice = parseFloat($("#formComputeCanPlanTransportCharges #ActualTransportPrice").val().trim());
                if (isNaN(actualTransportPrice) || actualTransportPrice <= 0) {
                    actualTransportPrice = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportPrice %>", actualTransportPrice);

                //添加运费变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportCharges %>", 0);

                //计算结果
                var ret = exp.Evaluate();
                if (isNaN(ret)) {
                    $("#formComputeCanPlanTransportCharges #TransportCharges").val("0.00");
                }
                else {
                    $("#formComputeCanPlanTransportCharges #TransportCharges").val(Math.round(ret * Math.pow(10, 2)) / Math.pow(10, 2));
                }
            }
            catch (e) {
                $("#formComputeCanPlanTransportCharges #TransportCharges").val("0.00");
            }
        }

        //计算单价
        function ComputeTransportPrice() {
            try {
                var exp = new Expression("");
                exp.Expression($("#formComputeCanPlanTransportCharges #TransportPriceExpression").val().trim());

                //添加公里数变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.KM %>", 0);

                //添加吨数变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Tunnages %>", 0);

                //添加垛数变量
                var footerData = $("#grid2").jqGrid("footerData");
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Piles %>", footerData.ActualPiles);

                //添加单价变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportPrice %>", 0);

                //添加运费变量
                var transportCharges = parseFloat($("#formComputeCanPlanTransportCharges #TransportCharges").val().trim());
                if (isNaN(transportCharges) || transportCharges <= 0) {
                    transportCharges = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportCharges %>", transportCharges);

                //计算结果
                var ret = exp.Evaluate();
                if (isNaN(ret)) {
                    $("#formComputeCanPlanTransportCharges #ActualTransportPrice").val("0");
                }
                else {
                    $("#formComputeCanPlanTransportCharges #ActualTransportPrice").val(Math.round(ret * Math.pow(10, 3)) / Math.pow(10, 3));
                }
            }
            catch (e) {
                $("#formComputeCanPlanTransportCharges #ActualTransportPrice").val("0");
            }
        }

    </script>
</asp:Content>
