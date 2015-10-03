<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.StatCustomerStatement %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Settlement/ExportCustomerStatement/" onclick="javascript:objMain.objWorkspace.objContent.export(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/049.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Export %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveSettlement();return false;">
            <img src="<%: Url.Content("~/Content/Images/084.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.NewInvoice%><label
                id="lblDeliverBillCount"></label></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("StatCustomerStatementCondition"); %>
    </div>
    <div id="dialogNewSettlement" title="">
        <% Html.RenderPartial("NewCustomerTransportChargesSettlement"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询条件
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 6010, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formStatCustomerStatementCondition #StartTime").val($.jStorage.get("StatCustomerStatement_StartTime", ""));
                    $("#formStatCustomerStatementCondition #EndTime").val($.jStorage.get("StatCustomerStatement_EndTime", ""));

                    if ($.jStorage.get("StatCustomerStatement_StartTime", "") != "" && $.jStorage.get("StatCustomerStatement_EndTime", "") != "") {
                        $("#formStatCustomerStatementCondition #PayerName").empty();
                        $("#formStatCustomerStatementCondition #PayerName").append("<option value=''></option>");

                        $.get("/Common/LoadGenerateBusinessPayersByTimespan", {
                            startTime: $.jStorage.get("StatCustomerStatement_StartTime", ""),
                            endTime: $.jStorage.get("StatCustomerStatement_EndTime", "")
                        }, function (ret) {
                            $.each(ret, function (i, customer) {
                                var option = $("<option></option>").val(customer.Name).text(customer.Name);
                                option.appendTo($("#formStatCustomerStatementCondition #PayerName"));
                            });
                            $("#formStatCustomerStatementCondition #PayerName").val($.jStorage.get("StatCustomerStatement_PayerName", ""));
                        }, "text json").error(function (xhr, status, error) {
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        });
                    }

                    if ($.jStorage.get("StatCustomerStatement_PayerName", "") != "") {
                        $("#formStatCustomerStatementCondition #ReceiverName").empty();
                        $("#formStatCustomerStatementCondition #ReceiverName").append("<option value=''></option>");

                        $.get("/Common/LoadCustomerReceivers", {
                            customerName: $.jStorage.get("StatCustomerStatement_PayerName", "")
                        }, function (ret) {
                            $.each(ret, function (i, name) {
                                var option = $("<option></option>").val(name).text(name);
                                option.appendTo($("#formStatCustomerStatementCondition #ReceiverName"));
                            });
                            $("#formStatCustomerStatementCondition #ReceiverName").val($.jStorage.get("StatCustomerStatement_ReceiverName", ""));
                        }, "text json").error(function (xhr, status, error) {
                            $("#formStatCustomerStatementCondition #PayerName").val("");
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        });
                    }

                    $("#formStatCustomerStatementCondition #StartCountry").val($.jStorage.get("StatCustomerStatement_StartCountry", ""));

                    $("#formStatCustomerStatementCondition #StartProvince").empty();
                    $("#formStatCustomerStatementCondition #StartProvince").append("<option value=''></option>");

                    $("#formStatCustomerStatementCondition #StartCity").empty();
                    $("#formStatCustomerStatementCondition #StartCity").append("<option value=''></option>");

                    if ($.jStorage.get("StatCustomerStatement_StartCountry", "") != "") {
                        $.get("/Common/LoadProvincesByCountry", {
                            strCountryName: $.jStorage.get("StatCustomerStatement_StartCountry", "")
                        }, function (ret) {
                            $.each(ret, function (i, province) {
                                var option = $("<option></option>").val(province).text(province);
                                option.appendTo($("#formStatCustomerStatementCondition #StartProvince"));
                            });
                            $("#formStatCustomerStatementCondition #StartProvince").val($.jStorage.get("StatCustomerStatement_StartProvince", ""));

                            if ($.jStorage.get("StatCustomerStatement_StartProvince", "") != "") {
                                $.get("/Common/LoadCitysByProvince", {
                                    strCountryName: $.jStorage.get("StatCustomerStatement_StartCountry", ""),
                                    strProvinceName: $.jStorage.get("StatCustomerStatement_StartProvince", "")
                                }, function (ret) {
                                    $.each(ret, function (i, city) {
                                        var option = $("<option></option>").val(city).text(city);
                                        option.appendTo($("#formStatCustomerStatementCondition #StartCity"));
                                    });
                                    $("#formStatCustomerStatementCondition #StartCity").val($.jStorage.get("StatCustomerStatement_StartCity", ""));
                                }, "text json").error(function (xhr, status, error) {
                                    $("#formStatCustomerStatementCondition #StartProvince").val("");
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#formStatCustomerStatementCondition #StartCountry").val("");
                        });
                    }

                    $("#formStatCustomerStatementCondition #DestCountry").val($.jStorage.get("StatCustomerStatement_DestCountry", ""));

                    $("#formStatCustomerStatementCondition #DestProvince").empty();
                    $("#formStatCustomerStatementCondition #DestProvince").append("<option value=''></option>");

                    $("#formStatCustomerStatementCondition #DestCity").empty();
                    $("#formStatCustomerStatementCondition #DestCity").append("<option value=''></option>");

                    if ($.jStorage.get("StatCustomerStatement_DestCountry", "") != "") {
                        $.get("/Common/LoadProvincesByCountry", {
                            strCountryName: $.jStorage.get("StatCustomerStatement_DestCountry", "")
                        }, function (ret) {
                            $.each(ret, function (i, province) {
                                var option = $("<option></option>").val(province).text(province);
                                option.appendTo($("#formStatCustomerStatementCondition #DestProvince"));
                            });
                            $("#formStatCustomerStatementCondition #DestProvince").val($.jStorage.get("StatCustomerStatement_DestProvince", ""));

                            if ($.jStorage.get("StatCustomerStatement_DestProvince", "") != "") {
                                $.get("/Common/LoadCitysByProvince", {
                                    strCountryName: $.jStorage.get("StatCustomerStatement_DestCountry", ""),
                                    strProvinceName: $.jStorage.get("StatCustomerStatement_DestProvince", "")
                                }, function (ret) {
                                    $.each(ret, function (i, city) {
                                        var option = $("<option></option>").val(city).text(city);
                                        option.appendTo($("#formStatCustomerStatementCondition #DestCity"));
                                    });
                                    $("#formStatCustomerStatementCondition #DestCity").val($.jStorage.get("StatCustomerStatement_DestCity", ""));
                                }, "text json").error(function (xhr, status, error) {
                                    $("#formStatCustomerStatementCondition #DestProvince").val("");
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#formStatCustomerStatementCondition #DestCountry").val("");
                        });
                    }

                    $("#formStatCustomerStatementCondition #CarrierName").val($.jStorage.get("StatCustomerStatement_CarrierName", ""));
                    $("#formStatCustomerStatementCondition #CarNo").val($.jStorage.get("StatCustomerStatement_CarNo", ""));
                    $("#formStatCustomerStatementCondition #GoodsName").val($.jStorage.get("StatCustomerStatement_GoodsName", ""));
                    $("#formStatCustomerStatementCondition #AllowStatementWhenConsignedDeliverPlanNotCompleted").attr("checked", $.jStorage.get("StatCustomerStatement_AllowStatementWhenConsignedDeliverPlanNotCompleted", false));

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //导出数据
            this.export = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 6010, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#grid1").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.ExportMustAfterSearch %>");
                        return;
                    }
                    else {
                        if ($("#formStatCustomerStatementCondition #StartTime").val().trim() == "" || $("#formStatCustomerStatementCondition #EndTime").val().trim() == "") {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterStartTimeOrEndTimeOrPayerNameCondition %>");
                            return;
                        }
                    }

                    var url = action + "?" +
                        "startTime=" + $("#formStatCustomerStatementCondition #StartTime").val().trim() + "&" +
                        "endTime=" + $("#formStatCustomerStatementCondition #EndTime").val().trim() + "&" +
                        "payerName=" + $("#formStatCustomerStatementCondition #PayerName").val().trim() + "&" +
                        "receiverName=" + $("#formStatCustomerStatementCondition #ReceiverName").val().trim() + "&" +
                        "startCountry=" + $("#formStatCustomerStatementCondition #StartCountry").val().trim() + "&" +
                        "startProvince=" + $("#formStatCustomerStatementCondition #StartProvince").val().trim() + "&" +
                        "startCity=" + $("#formStatCustomerStatementCondition #StartCity").val().trim() + "&" +
                        "destCountry=" + $("#formStatCustomerStatementCondition #DestCountry").val().trim() + "&" +
                        "destProvince=" + $("#formStatCustomerStatementCondition #DestProvince").val().trim() + "&" +
                        "destCity=" + $("#formStatCustomerStatementCondition #DestCity").val().trim() + "&" +
                        "carrierName=" + $("#formStatCustomerStatementCondition #CarrierName").val().trim() + "&" +
                        "carNo=" + $("#formStatCustomerStatementCondition #CarNo").val().trim() + "&" +
                        "goodsName=" + $("#formStatCustomerStatementCondition #GoodsName").val().trim() + "&" +
                        "allowStatementWhenConsignedDeliverPlanNotCompleted=" + ($("#formStatCustomerStatementCondition #AllowStatementWhenConsignedDeliverPlanNotCompleted").attr("checked") == "checked");

                    location.replace(url);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //添加开票送货单
            this.addDeliverBill = function (id) {
                var data = $("#grid1").jqGrid("getRowData", id);

                var bills = null;
                if ($.jStorage.get("StatCustomerStatement_SaveCustomerTransportChargesSettlement", "") == "") {
                    bills = new Array();
                }
                else {
                    bills = $.jStorage.get("StatCustomerStatement_SaveCustomerTransportChargesSettlement", "").split(",");
                }

                var i = 0;
                while (i < bills.length) {
                    if (bills[i].split("|")[0] == id) {
                        bills[i] = id + "|" + data.DeliverBillNo + "|" + data.CustomerName + "|" + data.TransportPrice + "|" + data.TransportCharges + "|" + data.CarpoolFee + "|" + data.RiverCrossingCharges;
                        break;
                    }
                    i++;
                }
                if (i >= bills.length) {
                    bills.push(id + "|" + data.DeliverBillNo + "|" + data.CustomerName + "|" + data.TransportPrice + "|" + data.TransportCharges + "|" + data.CarpoolFee + "|" + data.RiverCrossingCharges);
                }
                $.jStorage.set("StatCustomerStatement_SaveCustomerTransportChargesSettlement", bills.toString())

                $("#lblDeliverBillCount").text("(" + bills.length + ")");
            };
            //删除开票送货单
            this.deleteDeliverBill = function (id) {
                var bills = null;
                if ($.jStorage.get("StatCustomerStatement_SaveCustomerTransportChargesSettlement", "") == "") {
                    bills = new Array();
                }
                else {
                    bills = $.jStorage.get("StatCustomerStatement_SaveCustomerTransportChargesSettlement", "").split(",");
                }

                var bills2 = new Array();
                for (var i = 0; i < bills.length; i++) {
                    if (bills[i].split("|")[0] != id) {
                        bills2.push(bills[i]);
                    }
                }
                $.jStorage.set("StatCustomerStatement_SaveCustomerTransportChargesSettlement", bills2.toString())

                if (bills2.length > 0) {
                    $("#lblDeliverBillCount").text("(" + bills2.length + ")");
                }
                else {
                    $("#lblDeliverBillCount").text("");
                }
            };
            //删除所有开票送货单
            this.clearAllDeliverBills = function () {
                var bills = new Array();
                $.jStorage.set("StatCustomerStatement_SaveCustomerTransportChargesSettlement", bills.toString())

                $("#lblDeliverBillCount").text("");
            };
            //保存结算信息
            this.saveSettlement = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 6010, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //填充开票记录表格
                    if ($.jStorage.get("StatCustomerStatement_SaveCustomerTransportChargesSettlement", "") == "") {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterInvoiceDeliverBills %>");
                        return;
                    }

                    $("#grid2").jqGrid("clearGridData", true);

                    var bills = $.jStorage.get("StatCustomerStatement_SaveCustomerTransportChargesSettlement", "").split(",");
                    var totalTransportCharges = 0;
                    var totalCarpoolFee = 0;
                    var totalRiverCrossingCharges = 0;
                    for (var i = 0; i < bills.length; i++) {
                        var data = bills[i].split("|");
                        var s = "<input style='height:22px;width:60px;' type='button' value='<%: InnoSoft.LS.Resources.Buttons.Delete %>' onclick='objMain.objWorkspace.objContent.deleteCustomerTransportChargesSettlementDetail(" + data[0] + ");' />";

                        totalTransportCharges = add(totalTransportCharges, parseFloat(data[4]));
                        totalCarpoolFee = add(totalCarpoolFee, parseFloat(data[5]));
                        totalRiverCrossingCharges = add(totalRiverCrossingCharges, parseFloat(data[6]));

                        $("#grid2").jqGrid("addRowData", data[0], {
                            Id: data[0],
                            DeliverBillNo: data[1],
                            CustomerName: data[2],
                            TransportPrice: data[3],
                            TransportCharges: data[4],
                            CarpoolFee: data[5],
                            RiverCrossingCharges: data[6],
                            Actions: s
                        });
                    }
                    $("#grid2").jqGrid("footerData", "set", {
                        DeliverBillNo: "<%: InnoSoft.LS.Resources.Labels.Total %>",
                        TransportCharges: totalTransportCharges,
                        CarpoolFee: totalCarpoolFee,
                        RiverCrossingCharges: totalRiverCrossingCharges
                    });

                    //初始化编辑控件
                    $("#formNewCustomerTransportChargesSettlement #InvoiceNo").val("");
                    $("#formNewCustomerTransportChargesSettlement #InvoiceNo").focus().select();

                    if ($("#formStatCustomerStatementCondition #StartTime").val().trim() != "" && $("#formStatCustomerStatementCondition #EndTime").val().trim() != "") {
                        $("#formNewCustomerTransportChargesSettlement #CustomerName").empty();
                        $("#formNewCustomerTransportChargesSettlement #CustomerName").append("<option value=''></option>");

                        $.get("/Common/LoadGenerateBusinessPayersByTimespan", { startTime: $("#formStatCustomerStatementCondition #StartTime").val().trim(), endTime: $("#formStatCustomerStatementCondition #EndTime").val().trim() }, function (ret) {
                            $.each(ret, function (i, customer) {
                                var option = $("<option></option>").val(customer.Id).text(customer.FullName);
                                option.appendTo($("#formNewCustomerTransportChargesSettlement #CustomerName"));
                            });
                        }, "text json").error(function (xhr, status, error) {
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        });
                    }
                    $("#formNewCustomerTransportChargesSettlement #CustomerName").val("");

                    $("#formNewCustomerTransportChargesSettlement #InvoiceType").get(0).selectedIndex = 1;
                    $("#formNewCustomerTransportChargesSettlement #InvoiceAmount").val(Math.round(add(add(totalTransportCharges, totalCarpoolFee), totalRiverCrossingCharges) * Math.pow(10, 2)) / Math.pow(10, 2));
                    $("#formNewCustomerTransportChargesSettlement #Remark").val("");

                    //打开对话框
                    $("#dialogNewSettlement").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewCustomerTransportChargesSettlement %>");
                    $("#dialogNewSettlement").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除发票明细
            this.deleteCustomerTransportChargesSettlementDetail = function (id) {
                //清除送货单表格选中状态
                $("#grid1").jqGrid("setSelection", id, false);

                //删除发票明细表格记录
                $("#grid2").jqGrid("delRowData", id);

                //刷新运费、拼车费合计
                var totalTransportCharges = 0;
                var totalCarpoolFee = 0;
                var totalRiverCrossingCharges = 0;
                var rows = $("#grid2").jqGrid("getRowData");
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    totalTransportCharges = add(totalTransportCharges, parseFloat(row.TransportCharges));
                    totalCarpoolFee = add(totalCarpoolFee, parseFloat(row.CarpoolFee));
                    totalRiverCrossingCharges = add(totalRiverCrossingCharges, parseFloat(row.RiverCrossingCharges));
                }
                $("#grid2").jqGrid("footerData", "set", { TransportCharges: totalTransportCharges, CarpoolFee: totalCarpoolFee, RiverCrossingCharges: totalRiverCrossingCharges });

                $("#formNewCustomerTransportChargesSettlement #InvoiceAmount").val(Math.round(add(add(totalTransportCharges, totalCarpoolFee), totalRiverCrossingCharges) * Math.pow(10, 2)) / Math.pow(10, 2));

                //删除开票送货单记录
                objMain.objWorkspace.objContent.deleteDeliverBill(id);
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            $.jStorage.deleteKey("StatCustomerStatement_SaveCustomerTransportChargesSettlement");

            //创建送货单表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    payerName: "",
                    receiverName: "",
                    startCountry: "",
                    startProvince: "",
                    startCity: "",
                    destCountry: "",
                    destProvince: "",
                    destCity: "",
                    carrierName: "",
                    carNo: "",
                    goodsName: "",
                    allowStatementWhenConsignedDeliverPlanNotCompleted: "false"
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.PayerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverAddress %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.KM %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.SettlementExpression %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarpoolFee %>",
                    "<%: InnoSoft.LS.Resources.Labels.RiverCrossingCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>2",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiptReceived %>",
                    "<%: InnoSoft.LS.Resources.Labels.InvoiceNo %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "PlanNo", index: "PlanNo", width: 100, align: "center" },
                    { name: "DeliverBillNo", index: "DeliverBillNo", width: 100, align: "center" },
                    { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "ReceiverAddress", index: "ReceiverAddress", width: 300 },
                    { name: "StartCity", index: "StartCity", width: 60, align: "center" },
                    { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                    { name: "KM", index: "KM", width: 60, hidden: true },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center", summaryType: "sum" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "Piles", index: "Piles", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right" },
                    { name: "SettlementExpression", index: "SettlementExpression", width: 150, align: "center", hidden: true },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "CarpoolFee", index: "CarpoolFee", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "RiverCrossingCharges", index: "RiverCrossingCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "Remark", index: "Remark", width: 300 },
                    { name: "Remark2", index: "Remark2", width: 300 },
                    { name: "DeliverBillReceiptReceived", index: "DeliverBillReceiptReceived", width: 60, align: "center", formatter: "checkbox" },
                    { name: "InvoiceNo", index: "InvoiceNo", width: 120, align: "center", hidden: true }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CreateTime",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                multiselect: true,
                grouping: true,
                groupingView: {
                    groupField: ["CustomerName"],
                    groupSummary: [true],
                    groupColumnShow: [true],
                    groupText: ["<b>{0}</b>"],
                    groupCollapse: false,
                    groupOrder: ["asc"]
                },
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    if (status == true) {
                        objMain.objWorkspace.objContent.addDeliverBill(rowid);
                    }
                    else {
                        objMain.objWorkspace.objContent.deleteDeliverBill(rowid);
                    }
                },
                onSelectAll: function (aRowids, status) {
                    if (status == true) {
                        for (var i = 0; i < aRowids.length; i++) {
                            if (aRowids[i] != "") {
                                objMain.objWorkspace.objContent.addDeliverBill(aRowids[i]);
                            }
                        }
                    }
                    else {
                        for (var i = 0; i < aRowids.length; i++) {
                            if (aRowids[i] != "") {
                                objMain.objWorkspace.objContent.deleteDeliverBill(aRowids[i]);
                            }
                        }
                    }
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 600,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formStatCustomerStatementCondition").valid()) {
                            //缓存查询条件
                            $.jStorage.set("StatCustomerStatement_StartTime", $("#formStatCustomerStatementCondition #StartTime").val().trim());
                            $.jStorage.set("StatCustomerStatement_EndTime", $("#formStatCustomerStatementCondition #EndTime").val().trim());
                            $.jStorage.set("StatCustomerStatement_PayerName", $("#formStatCustomerStatementCondition #PayerName").val().trim());
                            $.jStorage.set("StatCustomerStatement_ReceiverName", $("#formStatCustomerStatementCondition #ReceiverName").val().trim());
                            $.jStorage.set("StatCustomerStatement_StartCountry", $("#formStatCustomerStatementCondition #StartCountry").val().trim());
                            $.jStorage.set("StatCustomerStatement_StartProvince", $("#formStatCustomerStatementCondition #StartProvince").val().trim());
                            $.jStorage.set("StatCustomerStatement_StartCity", $("#formStatCustomerStatementCondition #StartCity").val().trim());
                            $.jStorage.set("StatCustomerStatement_DestCountry", $("#formStatCustomerStatementCondition #DestCountry").val().trim());
                            $.jStorage.set("StatCustomerStatement_DestProvince", $("#formStatCustomerStatementCondition #DestProvince").val().trim());
                            $.jStorage.set("StatCustomerStatement_DestCity", $("#formStatCustomerStatementCondition #DestCity").val().trim());
                            $.jStorage.set("StatCustomerStatement_CarrierName", $("#formStatCustomerStatementCondition #CarrierName").val().trim());
                            $.jStorage.set("StatCustomerStatement_CarNo", $("#formStatCustomerStatementCondition #CarNo").val().trim());
                            $.jStorage.set("StatCustomerStatement_GoodsName", $("#formStatCustomerStatementCondition #GoodsName").val().trim());
                            $.jStorage.set("StatCustomerStatement_AllowStatementWhenConsignedDeliverPlanNotCompleted", ($("#formStatCustomerStatementCondition #AllowStatementWhenConsignedDeliverPlanNotCompleted").attr("checked") == "checked"));

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Settlement/LoadStatCustomerStatementGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formStatCustomerStatementCondition #StartTime").val().trim(),
                                    endTime: $("#formStatCustomerStatementCondition #EndTime").val().trim(),
                                    payerName: $("#formStatCustomerStatementCondition #PayerName").val().trim(),
                                    receiverName: $("#formStatCustomerStatementCondition #ReceiverName").val().trim(),
                                    startCountry: $("#formStatCustomerStatementCondition #StartCountry").val().trim(),
                                    startProvince: $("#formStatCustomerStatementCondition #StartProvince").val().trim(),
                                    startCity: $("#formStatCustomerStatementCondition #StartCity").val().trim(),
                                    destCountry: $("#formStatCustomerStatementCondition #DestCountry").val().trim(),
                                    destProvince: $("#formStatCustomerStatementCondition #DestProvince").val().trim(),
                                    destCity: $("#formStatCustomerStatementCondition #DestCity").val().trim(),
                                    carrierName: $("#formStatCustomerStatementCondition #CarrierName").val().trim(),
                                    carNo: $("#formStatCustomerStatementCondition #CarNo").val().trim(),
                                    goodsName: $("#formStatCustomerStatementCondition #GoodsName").val().trim(),
                                    allowStatementWhenConsignedDeliverPlanNotCompleted: ($("#formStatCustomerStatementCondition #AllowStatementWhenConsignedDeliverPlanNotCompleted").attr("checked") == "checked")
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1 }]);

                            //清除所有开票送货单缓存
                            //objMain.objWorkspace.objContent.clearAllDeliverBills();

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

            //创建录入发票对话框
            $("#dialogNewSettlement").dialog({
                autoOpen: false,
                height: 600,
                width: 900,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formNewCustomerTransportChargesSettlement").valid()) {
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

                            //生成发票明细JSON数据
                            var rows = $("#grid2").jqGrid("getRowData");
                            var details = new Array();
                            for (var i = 0; i < rows.length; i++) {
                                var row = rows[i];
                                var d = {
                                    "CustomerTransportChargesSettlementId": "0",
                                    "DeliverBillId": row.Id,
                                    "TransportPrice": row.TransportPrice,
                                    "TransportCharges": row.TransportCharges,
                                    "CarpoolFee": row.CarpoolFee,
                                    "RiverCrossingCharges": row.RiverCrossingCharges
                                };
                                details.push(d);
                            }

                            //生成发票JSON数据
                            var o = {
                                "InvoiceNo": $("#formNewCustomerTransportChargesSettlement #InvoiceNo").val().trim(),
                                "CustomerId": $("#formNewCustomerTransportChargesSettlement #CustomerName").val().trim(),
                                "CustomerName": $("#formNewCustomerTransportChargesSettlement #CustomerName").find("option:selected").text(),
                                "InvoiceType": $("#formNewCustomerTransportChargesSettlement #InvoiceType").find("option:selected").text(),
                                "InvoiceAmount": $("#formNewCustomerTransportChargesSettlement #InvoiceAmount").val().trim(),
                                "Remark": $("#formNewCustomerTransportChargesSettlement #Remark").val().trim(),
                                "Details": details
                            };

                            var postData = JSON.stringify(o);

                            //发送数据
                            $.ajax({
                                type: "POST",
                                url: "/chenxk/Settlement/NewCustomerTransportChargesSettlement/",
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

                                        $(this).dialog("close");

                                        location.replace("/chenxk/Settlement/StatCustomerStatement/");
                                    }
                                },
                                error: function (xhr, status, error) {
                                    $.unblockUI();

                                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                }
                            });
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                open: function () {
                    var w = parseInt($("#dialogNewSettlement").width()) - parseInt($("#dialogNewSettlement > fieldset:first").css("border-left-width")) * 2 - parseInt($("#dialogNewSettlement > fieldset:first").css("padding-left")) * 2 - parseInt($("#dialogNewSettlement > fieldset:first").css("margin-left")) * 2 - $.scrollbarWidth();
                    $("#grid2").jqGrid("setGridWidth", w - 2);
                },
                close: function () {
                }
            });

            //禁止编辑发票金额
            $("#formNewCustomerTransportChargesSettlement #InvoiceAmount").attr("readonly", "readonly");

            //创建待保存开票送货单记录表格
            $("#grid2").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.PayerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarpoolFee %>",
                    "<%: InnoSoft.LS.Resources.Labels.RiverCrossingCharges %>",
                    ""],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "DeliverBillNo", index: "DeliverBillNo", width: 100, align: "center", fixed: true },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right" },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "CarpoolFee", index: "CarpoolFee", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "RiverCrossingCharges", index: "RiverCrossingCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "Actions", index: "Actions", width: 80, align: "center", sortable: false }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "DeliverBillNo",
                sortorder: "asc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                height: "100%",
                footerrow: true,
                userDataOnFooter: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

        });

    </script>
</asp:Content>
