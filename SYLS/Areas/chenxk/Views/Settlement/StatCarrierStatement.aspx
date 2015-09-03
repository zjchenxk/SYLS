<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.StatCarrierStatement %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Settlement/ExportCarrierStatement/" onclick="javascript:objMain.objWorkspace.objContent.export(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/049.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Export %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.newSettlement();return false;">
            <img src="<%: Url.Content("~/Content/Images/084.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Settlement %><label
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
        <% Html.RenderPartial("StatCarrierStatementCondition"); %>
    </div>
    <div id="dialogNewSettlement" title="">
        <% Html.RenderPartial("NewCarrierTransportChargesSettlement"); %>
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
                $.get("/Common/LoadAccountPermission", { strFuncId: 6020, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formStatCarrierStatementCondition #StartTime").val($.jStorage.get("StatCarrierStatement_StartTime", ""));
                    $("#formStatCarrierStatementCondition #EndTime").val($.jStorage.get("StatCarrierStatement_EndTime", ""));

                    $("#formStatCarrierStatementCondition #StartCountry").val($.jStorage.get("StatCarrierStatement_StartCountry", ""));

                    $("#formStatCarrierStatementCondition #StartProvince").empty();
                    $("#formStatCarrierStatementCondition #StartProvince").append("<option value=''></option>");

                    $("#formStatCarrierStatementCondition #StartCity").empty();
                    $("#formStatCarrierStatementCondition #StartCity").append("<option value=''></option>");

                    if ($("#formStatCarrierStatementCondition #StartCountry").val().trim() != "") {
                        $.get("/Common/LoadProvincesByCountry", { strCountryName: $("#formStatCarrierStatementCondition #StartCountry").val().trim() }, function (ret) {
                            $.each(ret, function (i, province) {
                                var option = $("<option></option>").val(province).text(province);
                                option.appendTo($("#formStatCarrierStatementCondition #StartProvince"));
                            });
                            $("#formStatCarrierStatementCondition #StartProvince").val($.jStorage.get("StatCarrierStatement_StartProvince", ""));

                            if ($("#formStatCarrierStatementCondition #StartProvince").val().trim() != "") {
                                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formStatCarrierStatementCondition #StartCountry").val().trim(), strProvinceName: $("#formStatCarrierStatementCondition #StartProvince").val().trim() }, function (ret) {
                                    $.each(ret, function (i, city) {
                                        var option = $("<option></option>").val(city).text(city);
                                        option.appendTo($("#formStatCarrierStatementCondition #StartCity"));
                                    });
                                    $("#formStatCarrierStatementCondition #StartCity").val($.jStorage.get("StatCarrierStatement_StartCity", ""));
                                }, "text json").error(function (xhr, status, error) {
                                    $("#formStatCarrierStatementCondition #StartProvince").val("");
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#formStatCarrierStatementCondition #StartCountry").val("");
                        });
                    }

                    $("#formStatCarrierStatementCondition #DestCountry").val($.jStorage.get("StatCarrierStatement_DestCountry", ""));

                    $("#formStatCarrierStatementCondition #DestProvince").empty();
                    $("#formStatCarrierStatementCondition #DestProvince").append("<option value=''></option>");

                    $("#formStatCarrierStatementCondition #DestCity").empty();
                    $("#formStatCarrierStatementCondition #DestCity").append("<option value=''></option>");

                    if ($("#formStatCarrierStatementCondition #DestCountry").val().trim() != "") {
                        $.get("/Common/LoadProvincesByCountry", { strCountryName: $("#formStatCarrierStatementCondition #DestCountry").val().trim() }, function (ret) {
                            $.each(ret, function (i, province) {
                                var option = $("<option></option>").val(province).text(province);
                                option.appendTo($("#formStatCarrierStatementCondition #DestProvince"));
                            });
                            $("#formStatCarrierStatementCondition #DestProvince").val($.jStorage.get("StatCarrierStatement_DestProvince", ""));

                            if ($("#formStatCarrierStatementCondition #DestProvince").val().trim() != "") {
                                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formStatCarrierStatementCondition #DestCountry").val().trim(), strProvinceName: $("#formStatCarrierStatementCondition #DestProvince").val().trim() }, function (ret) {
                                    $.each(ret, function (i, city) {
                                        var option = $("<option></option>").val(city).text(city);
                                        option.appendTo($("#formStatCarrierStatementCondition #DestCity"));
                                    });
                                    $("#formStatCarrierStatementCondition #DestCity").val($.jStorage.get("StatCarrierStatement_DestCity", ""));
                                }, "text json").error(function (xhr, status, error) {
                                    $("#formStatCarrierStatementCondition #DestProvince").val("");
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#formStatCarrierStatementCondition #DestCountry").val("");
                        });
                    }

                    $("#formStatCarrierStatementCondition #CarrierName").val($.jStorage.get("StatCarrierStatement_CarrierName", ""));
                    $("#formStatCarrierStatementCondition #CarNo").val($.jStorage.get("StatCarrierStatement_CarNo", ""));
                    $("#formStatCarrierStatementCondition #DeliverBillReceiptReceived").attr("checked", $.jStorage.get("StatCarrierStatement_DeliverBillReceiptReceived", true));

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
                $.get("/Common/LoadAccountPermission", { strFuncId: 6020, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#grid1").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.ExportMustAfterSearch %>");
                        return;
                    }
                    else {
                        if ($("#formStatCarrierStatementCondition #StartTime").val().trim() == "" && $("#formStatCarrierStatementCondition #EndTime").val().trim() == "") {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterStartTimeAndEndTimeCondition %>");
                            return;
                        }
                    }

                    var url = action + "?" +
                        "startTime=" + $("#formStatCarrierStatementCondition #StartTime").val().trim() + "&" +
                        "endTime=" + $("#formStatCarrierStatementCondition #EndTime").val().trim() + "&" +
                        "startCountry=" + $("#formStatCarrierStatementCondition #StartCountry").val().trim() + "&" +
                        "startProvince=" + $("#formStatCarrierStatementCondition #StartProvince").val().trim() + "&" +
                        "startCity=" + $("#formStatCarrierStatementCondition #StartCity").val().trim() + "&" +
                        "destCountry=" + $("#formStatCarrierStatementCondition #DestCountry").val().trim() + "&" +
                        "destProvince=" + $("#formStatCarrierStatementCondition #DestProvince").val().trim() + "&" +
                        "destCity=" + $("#formStatCarrierStatementCondition #DestCity").val().trim() + "&" +
                        "carrierName=" + $("#formStatCarrierStatementCondition #CarrierName").val().trim() + "&" +
                        "carNo=" + $("#formStatCarrierStatementCondition #CarNo").val().trim() + "&" +
                        "deliverBillReceiptReceived=" + ($("#formStatCarrierStatementCondition #DeliverBillReceiptReceived").attr("checked") == "checked");

                    location.replace(url);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //添加结算送货单
            this.addDeliverBill = function (id) {
                var data = $("#grid1").jqGrid("getRowData", id);

                var bills = null;
                if ($.jStorage.get("StatCarrierStatement_SaveCarrierTransportChargesSettlement", "") == "") {
                    bills = new Array();
                }
                else {
                    bills = $.jStorage.get("StatCarrierStatement_SaveCarrierTransportChargesSettlement", "").split(",");
                }

                var i = 0;
                while (i < bills.length) {
                    if (bills[i].split("|")[0] == id) {
                        bills[i] = id + "|" + data.CarrierName + "|" + data.DeliverBillNo + "|" + data.TransportCharges + "|" + data.DamageInfo;
                        break;
                    }
                    i++;
                }
                if (i >= bills.length) {
                    bills.push(id + "|" + data.CarrierName + "|" + data.DeliverBillNo + "|" + data.TransportCharges + "|" + data.DamageInfo);
                }
                $.jStorage.set("StatCarrierStatement_SaveCarrierTransportChargesSettlement", bills.toString())

                $("#lblDeliverBillCount").text("(" + bills.length + ")");
            };
            //删除结算送货单
            this.deleteDeliverBill = function (id) {
                var bills = null;
                if ($.jStorage.get("StatCarrierStatement_SaveCarrierTransportChargesSettlement", "") == "") {
                    bills = new Array();
                }
                else {
                    bills = $.jStorage.get("StatCarrierStatement_SaveCarrierTransportChargesSettlement", "").split(",");
                }

                var bills2 = new Array();
                for (var i = 0; i < bills.length; i++) {
                    if (bills[i].split("|")[0] != id) {
                        bills2.push(bills[i]);
                    }
                }
                $.jStorage.set("StatCarrierStatement_SaveCarrierTransportChargesSettlement", bills2.toString())

                if (bills2.length > 0) {
                    $("#lblDeliverBillCount").text("(" + bills2.length + ")");
                }
                else {
                    $("#lblDeliverBillCount").text("");
                }
            };
            //删除所有结算送货单
            this.clearAllDeliverBills = function () {
                var bills = new Array();
                $.jStorage.set("StatCarrierStatement_SaveCarrierTransportChargesSettlement", bills.toString())

                $("#lblDeliverBillCount").text("");
            };
            //新增结算记录
            this.newSettlement = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 6020, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //填充结算送货单表格
                    if ($.jStorage.get("StatCarrierStatement_SaveCarrierTransportChargesSettlement", "") == "") {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCarrierSettlementDeliverBills %>");
                        return;
                    }

                    $("#grid2").jqGrid("clearGridData", true);

                    var bills = $.jStorage.get("StatCarrierStatement_SaveCarrierTransportChargesSettlement", "").split(",");
                    var totalTransportCharges = 0;
                    for (var i = 0; i < bills.length; i++) {
                        var data = bills[i].split("|");
                        var s = "<input style='height:22px;width:60px;' type='button' value='<%: InnoSoft.LS.Resources.Buttons.Delete %>' onclick='objMain.objWorkspace.objContent.deleteSettlementDetail(" + data[0] + ");' />";

                        totalTransportCharges = add(totalTransportCharges, parseFloat(data[3]));
                        totalTransportCharges = Math.round(totalTransportCharges * Math.pow(10, 2)) / Math.pow(10, 2);

                        $("#grid2").jqGrid("addRowData", data[0], { Id: data[0], CarrierName: data[1], DeliverBillNo: data[2], TransportCharges: data[3], DamageInfo: data[4], Actions: s });
                    }
                    $("#grid2").jqGrid("footerData", "set", { CarrierName: "<%: InnoSoft.LS.Resources.Labels.Total %>", TransportCharges: totalTransportCharges });

                    //初始化编辑控件
                    $("#formNewCarrierTransportChargesSettlement #CarrierId").val("0");
                    $("#formNewCarrierTransportChargesSettlement #CarrierName").val("");
                    $("#formNewCarrierTransportChargesSettlement #SettlementAmount").val(totalTransportCharges);
                    $("#formNewCarrierTransportChargesSettlement #WithholdAmount").val("0");
                    $("#formNewCarrierTransportChargesSettlement #FactpaymentAmount").val(totalTransportCharges);
                    $("#formNewCarrierTransportChargesSettlement #Remark").val("");

                    //打开对话框
                    $("#dialogNewSettlement").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewCarrierTransportChargesSettlement %>");
                    $("#dialogNewSettlement").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除结算明细
            this.deleteSettlementDetail = function (id) {
                //清除送货单表格选中状态
                $("#grid1").jqGrid("setSelection", id, false);

                //删除结算明细表格记录
                $("#grid2").jqGrid("delRowData", id);

                //刷新运费合计
                var totalTransportCharges = 0;
                var rows = $("#grid2").jqGrid("getRowData");
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    totalTransportCharges = add(totalTransportCharges, parseFloat(row.TransportCharges));
                }
                $("#grid2").jqGrid("footerData", "set", { TransportCharges: totalTransportCharges });

                $("#formNewCarrierTransportChargesSettlement #SettlementAmount").val(totalTransportCharges);

                //删除结算送货单缓存
                objMain.objWorkspace.objContent.deleteDeliverBill(id);
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            $.jStorage.deleteKey("StatCarrierStatement_SaveCarrierTransportChargesSettlement");

            //创建送货记录表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    startCountry: "",
                    startProvince: "",
                    startCity: "",
                    destCountry: "",
                    destProvince: "",
                    destCity: "",
                    carrierName: "",
                    carNo: "",
                    deliverBillReceiptReceived: "false"
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarrierName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>2",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiptReceived %>",
                    "<%: InnoSoft.LS.Resources.Labels.DamageInfo %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CarrierName", index: "CarrierName", width: 150 },
                    { name: "DeliverBillNo", index: "DeliverBillNo", width: 100, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "StartCity", index: "StartCity", width: 60, align: "center" },
                    { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center", summaryType: "sum" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "Piles", index: "Piles", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center", formatter: "myNumberFmatter", summaryType: myNumberSum },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "Remark", index: "Remark", width: 200 },
                    { name: "Remark2", index: "Remark2", width: 200 },
                    { name: "DeliverBillReceiptReceived", index: "DeliverBillReceiptReceived", width: 60, align: "center", formatter: "checkbox" },
                    { name: "DamageInfo", index: "DamageInfo", width: 400 }],
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
                    groupField: ["CarrierName"],
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
                height: 500,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formStatCarrierStatementCondition").valid()) {
                            //缓存查询条件
                            $.jStorage.set("StatCarrierStatement_StartTime", $("#formStatCarrierStatementCondition #StartTime").val().trim());
                            $.jStorage.set("StatCarrierStatement_EndTime", $("#formStatCarrierStatementCondition #EndTime").val().trim());
                            $.jStorage.set("StatCarrierStatement_CarrierName", $("#formStatCarrierStatementCondition #CarrierName").val().trim());
                            $.jStorage.set("StatCarrierStatement_CarNo", $("#formStatCarrierStatementCondition #CarNo").val().trim());
                            $.jStorage.set("StatCarrierStatement_StartCountry", $("#formStatCarrierStatementCondition #StartCountry").val().trim());
                            $.jStorage.set("StatCarrierStatement_StartProvince", $("#formStatCarrierStatementCondition #StartProvince").val().trim());
                            $.jStorage.set("StatCarrierStatement_StartCity", $("#formStatCarrierStatementCondition #StartCity").val().trim());
                            $.jStorage.set("StatCarrierStatement_DestCountry", $("#formStatCarrierStatementCondition #DestCountry").val().trim());
                            $.jStorage.set("StatCarrierStatement_DestProvince", $("#formStatCarrierStatementCondition #DestProvince").val().trim());
                            $.jStorage.set("StatCarrierStatement_DestCity", $("#formStatCarrierStatementCondition #DestCity").val().trim());
                            $.jStorage.set("StatCarrierStatement_DeliverBillReceiptReceived", ($("#formStatCarrierStatementCondition #DeliverBillReceiptReceived").attr("checked") == "checked"));

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Settlement/LoadStatCarrierStatementGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formStatCarrierStatementCondition #StartTime").val().trim(),
                                    endTime: $("#formStatCarrierStatementCondition #EndTime").val().trim(),
                                    startCountry: $("#formStatCarrierStatementCondition #StartCountry").val().trim(),
                                    startProvince: $("#formStatCarrierStatementCondition #StartProvince").val().trim(),
                                    startCity: $("#formStatCarrierStatementCondition #StartCity").val().trim(),
                                    destCountry: $("#formStatCarrierStatementCondition #DestCountry").val().trim(),
                                    destProvince: $("#formStatCarrierStatementCondition #DestProvince").val().trim(),
                                    destCity: $("#formStatCarrierStatementCondition #DestCity").val().trim(),
                                    carrierName: $("#formStatCarrierStatementCondition #CarrierName").val().trim(),
                                    carNo: $("#formStatCarrierStatementCondition #CarNo").val().trim(),
                                    deliverBillReceiptReceived: ($("#formStatCarrierStatementCondition #DeliverBillReceiptReceived").attr("checked") == "checked")
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1 }]);

                            //清除所有结算送货单缓存
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

            //创建新增结算记录对话框
            $("#dialogNewSettlement").dialog({
                autoOpen: false,
                height: 600,
                width: 900,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formNewCarrierTransportChargesSettlement").valid()) {
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

                            //生成结算明细JSON数据
                            var rows = $("#grid2").jqGrid("getRowData");
                            var details = new Array();
                            for (var i = 0; i < rows.length; i++) {
                                var row = rows[i];
                                var d = {
                                    "CarrierTransportChargesSettlementId": "0",
                                    "DeliverBillId": row.Id,
                                    "TransportCharges": row.TransportCharges
                                };
                                details.push(d);
                            }

                            //生成结算记录JSON数据
                            var o = {
                                "CarrierId": $("#formNewCarrierTransportChargesSettlement #CarrierId").val().trim(),
                                "CarrierName": $("#formNewCarrierTransportChargesSettlement #CarrierName").val().trim(),
                                "SettlementAmount": $("#formNewCarrierTransportChargesSettlement #SettlementAmount").val().trim(),
                                "WithholdAmount": $("#formNewCarrierTransportChargesSettlement #WithholdAmount").val().trim(),
                                "FactpaymentAmount": $("#formNewCarrierTransportChargesSettlement #FactpaymentAmount").val().trim(),
                                "Remark": $("#formNewCarrierTransportChargesSettlement #Remark").val().trim(),
                                "Details": details
                            };

                            var postData = JSON.stringify(o);

                            //发送数据
                            $.ajax({
                                type: "POST",
                                url: "/chenxk/Settlement/NewCarrierTransportChargesSettlement/",
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

                                        location.replace("/chenxk/Settlement/StatCarrierStatement/");
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

            //设置承运单位名称自动完成
            $("#formNewCarrierTransportChargesSettlement #CarrierName").autocomplete({
                source: "/Autocomplete/LoadCarrierNames/",
                minLength: 1,
                change: function (event, ui) {
                    $.get("/Common/LoadCarrierByName", { strName: $("#formNewCarrierTransportChargesSettlement #CarrierName").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#formNewCarrierTransportChargesSettlement #CarrierId").val(ret.Id);
                        }
                        else {
                            alert("<%: InnoSoft.LS.Resources.Strings.CarrierNameNotExists %>");
                            $("#formNewCarrierTransportChargesSettlement #CarrierId").val("0");
                            $("#formNewCarrierTransportChargesSettlement #CarrierName").val("");
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#formNewCarrierTransportChargesSettlement #CarrierName").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //禁止编辑结算金额和实付金额
            $("#formNewCarrierTransportChargesSettlement #SettlementAmount").attr("readonly", "readonly");
            $("#formNewCarrierTransportChargesSettlement #FactpaymentAmount").attr("readonly", "readonly");

            //设置扣款金额改变事件
            $("#formNewCarrierTransportChargesSettlement #WithholdAmount").change(function () {
                //检查扣款金额
                var withholdAmount = parseFloat($("#formNewCarrierTransportChargesSettlement #WithholdAmount").val().trim());
                if (isNaN(withholdAmount) || withholdAmount <= 0) {
                    withholdAmount = 0;
                    $("#formNewCarrierTransportChargesSettlement #WithholdAmount").val(withholdAmount);
                }

                //获取结算金额
                var settlementAmount = parseFloat($("#formNewCarrierTransportChargesSettlement #SettlementAmount").val().trim());
                if (isNaN(settlementAmount) || settlementAmount <= 0) {
                    settlementAmount = 0;
                    $("#formNewCarrierTransportChargesSettlement #SettlementAmount").val(settlementAmount);
                }

                //计算实付金额
                $("#formNewCarrierTransportChargesSettlement #FactpaymentAmount").val(sub(settlementAmount, withholdAmount));
            });

            //创建待保存结算送货单记录表格
            $("#grid2").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarrierName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.DamageInfo %>",
                    ""],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CarrierName", index: "CarrierName", width: 150 },
                    { name: "DeliverBillNo", index: "DeliverBillNo", width: 100, align: "center" },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "DamageInfo", index: "DamageInfo", width: 300 },
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
