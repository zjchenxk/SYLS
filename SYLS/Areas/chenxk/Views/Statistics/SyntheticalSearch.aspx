<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SyntheticalSearch %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.modify();return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/chenxk/Statistics/ExportSyntheticalSearch/" onclick="javascript:objMain.objWorkspace.objContent.export(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/049.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Export %></a></li>
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
        <% Html.RenderPartial("SyntheticalSearchCondition"); %>
    </div>
    <div id="dialogModify" title="">
        <% Html.RenderPartial("SyntheticalSearchModify"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //选中记录编码
            this.selectedRowId = null;
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
                $.get("/Common/LoadAccountPermission", { strFuncId: 7030, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formSyntheticalSearchCondition #StartTime").val($.jStorage.get("SyntheticalSearchCondition_StartTime", ""));
                    $("#formSyntheticalSearchCondition #EndTime").val($.jStorage.get("SyntheticalSearchCondition_EndTime", ""));

                    $("#formSyntheticalSearchCondition #PayerName").empty();
                    $("#formSyntheticalSearchCondition #PayerName").append("<option value=''></option>");

                    if ($.jStorage.get("SyntheticalSearchCondition_StartTime", "") != "" && $.jStorage.get("SyntheticalSearchCondition_EndTime", "") != "") {
                        $.get("/Common/LoadDeliverBillsPayersByTimespan", { startTime: $.jStorage.get("SyntheticalSearchCondition_StartTime", ""), endTime: $.jStorage.get("SyntheticalSearchCondition_EndTime", "") }, function (ret) {
                            $.each(ret, function (i, customer) {
                                var option = $("<option></option>").val(customer.Name).text(customer.Name);
                                option.appendTo($("#formSyntheticalSearchCondition #PayerName"));
                            });
                            $("#formSyntheticalSearchCondition #PayerName").val($.jStorage.get("SyntheticalSearchCondition_PayerName", ""));
                        }, "text json").error(function (xhr, status, error) {
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        });
                    }

                    $("#formSyntheticalSearchCondition #StartCountry").val($.jStorage.get("SyntheticalSearchCondition_StartCountry", ""));

                    $("#formSyntheticalSearchCondition #StartProvince").empty();
                    $("#formSyntheticalSearchCondition #StartProvince").append("<option value=''></option>");

                    $("#formSyntheticalSearchCondition #StartCity").empty();
                    $("#formSyntheticalSearchCondition #StartCity").append("<option value=''></option>");

                    if ($("#formSyntheticalSearchCondition #StartCountry").val().trim() != "") {
                        $.get("/Common/LoadProvincesByCountry", { strCountryName: $("#formSyntheticalSearchCondition #StartCountry").val().trim() }, function (ret) {
                            $.each(ret, function (i, province) {
                                var option = $("<option></option>").val(province).text(province);
                                option.appendTo($("#formSyntheticalSearchCondition #StartProvince"));
                            });
                            $("#formSyntheticalSearchCondition #StartProvince").val($.jStorage.get("SyntheticalSearchCondition_StartProvince", ""));

                            if ($("#formSyntheticalSearchCondition #StartProvince").val().trim() != "") {
                                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formSyntheticalSearchCondition #StartCountry").val().trim(), strProvinceName: $("#formSyntheticalSearchCondition #StartProvince").val().trim() }, function (ret) {
                                    $.each(ret, function (i, city) {
                                        var option = $("<option></option>").val(city).text(city);
                                        option.appendTo($("#formSyntheticalSearchCondition #StartCity"));
                                    });
                                    $("#formSyntheticalSearchCondition #StartCity").val($.jStorage.get("SyntheticalSearchCondition_StartCity", ""));
                                }, "text json").error(function (xhr, status, error) {
                                    $("#formSyntheticalSearchCondition #StartProvince").val("");
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#formSyntheticalSearchCondition #StartCountry").val("");
                        });
                    }

                    $("#formSyntheticalSearchCondition #DestCountry").val($.jStorage.get("SyntheticalSearchCondition_DestCountry", ""));

                    $("#formSyntheticalSearchCondition #DestProvince").empty();
                    $("#formSyntheticalSearchCondition #DestProvince").append("<option value=''></option>");

                    $("#formSyntheticalSearchCondition #DestCity").empty();
                    $("#formSyntheticalSearchCondition #DestCity").append("<option value=''></option>");

                    if ($("#formSyntheticalSearchCondition #DestCountry").val().trim() != "") {
                        $.get("/Common/LoadProvincesByCountry", { strCountryName: $("#formSyntheticalSearchCondition #DestCountry").val().trim() }, function (ret) {
                            $.each(ret, function (i, province) {
                                var option = $("<option></option>").val(province).text(province);
                                option.appendTo($("#formSyntheticalSearchCondition #DestProvince"));
                            });
                            $("#formSyntheticalSearchCondition #DestProvince").val($.jStorage.get("SyntheticalSearchCondition_DestProvince", ""));

                            if ($("#formSyntheticalSearchCondition #DestProvince").val().trim() != "") {
                                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formSyntheticalSearchCondition #DestCountry").val().trim(), strProvinceName: $("#formSyntheticalSearchCondition #DestProvince").val().trim() }, function (ret) {
                                    $.each(ret, function (i, city) {
                                        var option = $("<option></option>").val(city).text(city);
                                        option.appendTo($("#formSyntheticalSearchCondition #DestCity"));
                                    });
                                    $("#formSyntheticalSearchCondition #DestCity").val($.jStorage.get("SyntheticalSearchCondition_DestCity", ""));
                                }, "text json").error(function (xhr, status, error) {
                                    $("#formSyntheticalSearchCondition #DestProvince").val("");
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#formSyntheticalSearchCondition #DestCountry").val("");
                        });
                    }

                    $("#formSyntheticalSearchCondition #CarNo").val($.jStorage.get("SyntheticalSearchCondition_CarNo", ""));

                    $("#formSyntheticalSearchCondition #OrganId").empty();
                    $("#formSyntheticalSearchCondition #OrganId").append("<option value=''></option>");

                    if ($.jStorage.get("SyntheticalSearchCondition_StartTime", "") != "" && $.jStorage.get("SyntheticalSearchCondition_EndTime", "") != "") {
                        $.get("/Common/LoadDeliverBillsOwnOrgansByTimespan", { startTime: $.jStorage.get("SyntheticalSearchCondition_StartTime", ""), endTime: $.jStorage.get("SyntheticalSearchCondition_EndTime", "") }, function (ret) {
                            $.each(ret, function (i, organ) {
                                var option = $("<option></option>").val(organ.Id).text(organ.FullName);
                                option.appendTo($("#formSyntheticalSearchCondition #OrganId"));
                            });
                            $("#formSyntheticalSearchCondition #OrganId").val($.jStorage.get("SyntheticalSearchCondition_OrganId", ""));
                        }, "text json").error(function (xhr, status, error) {
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        });
                    }

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //修改
            this.modify = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 7030, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedRowId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedRecord %>");
                        return;
                    }

                    //初始化控件数据
                    var data = $("#grid1").jqGrid("getRowData", objMain.objWorkspace.objContent.selectedRowId);
                    $("#formSyntheticalSearchModify #PlanId").val(data.PlanId);
                    $("#formSyntheticalSearchModify #PayerId").val(data.PayerId);
                    $("#formSyntheticalSearchModify #ContractId").val(data.ContractId);
                    $("#formSyntheticalSearchModify #ShipmentNo").val(data.ShipmentNo);
                    $("#formSyntheticalSearchModify #DeliveryNo").val(data.DeliveryNo);
                    $("#formSyntheticalSearchModify #PayerName").val(data.PayerName);
                    $("#formSyntheticalSearchModify #OriginalContractNo").val(data.OriginalContractNo);

                    if (data.ShipmentNo == null || data.ShipmentNo == "") {
                        $("#formSyntheticalSearchModify #ShipmentNo").attr("disabled", "disabled");
                    }
                    else {
                        $("#formSyntheticalSearchModify #ShipmentNo").removeAttr("disabled");
                    }

                    if (data.ContractId == null || data.ContractId == "" || data.ContractId == "0") {
                        $("#formSyntheticalSearchModify #OriginalContractNo").attr("disabled", "disabled");
                    }
                    else {
                        $("#formSyntheticalSearchModify #OriginalContractNo").removeAttr("disabled");
                    }

                    //打开修改对话框
                    $("#dialogModify").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyData %>");
                    $("#dialogModify").dialog("open");

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //导出
            this.export = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 7030, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#grid1").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.ExportMustAfterSearch %>");
                        return;
                    }
                    else {
                        if ($("#formSyntheticalSearchCondition #StartTime").val().trim() == "" && $("#formSyntheticalSearchCondition #EndTime").val().trim() == "") {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterStartTimeAndEndTimeCondition %>");
                            return;
                        }
                    }

                    var url = action + "?" +
                    "startTime=" + $("#formSyntheticalSearchCondition #StartTime").val().trim() + "&" +
                    "endTime=" + $("#formSyntheticalSearchCondition #EndTime").val().trim() + "&" +
                    "payerName=" + $("#formSyntheticalSearchCondition #PayerName").val().trim() + "&" +
                    "startCountry=" + $("#formSyntheticalSearchCondition #StartCountry").val().trim() + "&" +
                    "startProvince=" + $("#formSyntheticalSearchCondition #StartProvince").val().trim() + "&" +
                    "startCity=" + $("#formSyntheticalSearchCondition #StartCity").val().trim() + "&" +
                    "destCountry=" + $("#formSyntheticalSearchCondition #DestCountry").val().trim() + "&" +
                    "destProvince=" + $("#formSyntheticalSearchCondition #DestProvince").val().trim() + "&" +
                    "destCity=" + $("#formSyntheticalSearchCondition #DestCity").val().trim() + "&" +
                    "carNo=" + $("#formSyntheticalSearchCondition #CarNo").val().trim() + "&" +
                    "organId=" + $("#formSyntheticalSearchCondition #OrganId").val().trim();

                    location.replace(url);

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //退回调度
            this.returnDispatch = function (id) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 7030, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    $.get("/chenxk/Statistics/CheckForReturnDispatch/", { id: id }, function (ret) {
                        if (ret.Success == false) {
                            alert("<%: InnoSoft.LS.Resources.Strings.CheckForReturnDispatchFailed %>");
                            return;
                        }

                        if (confirm(stringFormat("<%: InnoSoft.LS.Resources.Strings.ReturnDispatchConfirm %>", ret.Message)) == true) {
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

                            $.post("/chenxk/Statistics/ReturnDispatch/", { id: id }, function (ret) {
                                $.unblockUI();

                                //debugger;
                                if (ret.Success == false) {
                                    alert(ret.Message);
                                }
                                else {
                                    //if (ret.Message != null && ret.Message != "") {
                                    //    alert(ret.Message);
                                    //}

                                    location.replace("/chenxk/Statistics/SyntheticalSearch/");
                                }
                            });
                        }

                    }, "text json").error(function (xhr, status, error) {
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //创建计划表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: $.jStorage.get("SyntheticalSearchCondition_StartTime", ""),
                    endTime: $.jStorage.get("SyntheticalSearchCondition_EndTime", ""),
                    payerName: $.jStorage.get("SyntheticalSearchCondition_PayerName", ""),
                    startCountry: $.jStorage.get("SyntheticalSearchCondition_StartCountry", ""),
                    startProvince: $.jStorage.get("SyntheticalSearchCondition_StartProvince", ""),
                    startCity: $.jStorage.get("SyntheticalSearchCondition_StartCity", ""),
                    destCountry: $.jStorage.get("SyntheticalSearchCondition_DestCountry", ""),
                    destProvince: $.jStorage.get("SyntheticalSearchCondition_DestProvince", ""),
                    destCity: $.jStorage.get("SyntheticalSearchCondition_DestCity", ""),
                    carNo: $.jStorage.get("SyntheticalSearchCondition_CarNo", ""),
                    organId: $.jStorage.get("SyntheticalSearchCondition_OrganId", "")
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.DeliverBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.PayerId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PayerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverAddress %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiveType %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarType %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ContractId %>",
                    "<%: InnoSoft.LS.Resources.Labels.ContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.OriginalContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarrierTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportChargesDifference %>",
                    "<%: InnoSoft.LS.Resources.Labels.IsCustomerTransportChargesSettled %>",
                    "<%: InnoSoft.LS.Resources.Labels.IsCarrierTransportChargesSettled %>",
                    "<%: InnoSoft.LS.Resources.Labels.IsReceiptReceived %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReturnTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReversedAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportChargesBalance %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>",
                    ""
                ],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "ShipmentBillId", index: "ShipmentBillId", width: 100, hidden: true },
                    { name: "PlanId", index: "PlanId", width: 100, hidden: true },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "PlanNo", index: "PlanNo", width: 100, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 150 },
                    { name: "PayerId", index: "PayerId", width: 100, hidden: true },
                    { name: "PayerName", index: "PayerName", width: 150 },
                    { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "ReceiverAddress", index: "ReceiverAddress", width: 300, hidden: true },
                    { name: "StartCity", index: "StartCity", width: 60, align: "center" },
                    { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                    { name: "ReceiveType", index: "ReceiveType", width: 80, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 200 },
                    { name: "TotalPackages", index: "TotalPackages", width: 60, align: "center" },
                    { name: "TotalTunnages", index: "TotalTunnages", width: 100, align: "center" },
                    { name: "TotalPiles", index: "TotalPiles", width: 80, align: "center" },
                    { name: "TotalTenThousands", index: "TotalTenThousands", width: 80, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 80, align: "center" },
                    { name: "CarType", index: "CarType", width: 60, align: "center" },
                    { name: "BillNo", index: "BillNo", width: 120, align: "center" },
                    { name: "ContractId", index: "ContractId", width: 100, align: "center", hidden: true },
                    { name: "ContractNo", index: "ContractNo", width: 100, align: "center" },
                    { name: "OriginalContractNo", index: "OriginalContractNo", width: 100, align: "center" },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "CustomerTransportCharges", index: "CustomerTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "TransportChargesDifference", index: "TransportChargesDifference", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "IsCustomerTransportChargesSettled", index: "IsCustomerTransportChargesSettled", width: 100, align: "center", formatter: "checkbox" },
                    { name: "IsCarrierTransportChargesSettled", index: "IsCarrierTransportChargesSettled", width: 100, align: "center", formatter: "checkbox" },
                    { name: "IsDeliverBillReceiptReceived", index: "IsDeliverBillReceiptReceived", width: 60, align: "center", formatter: "checkbox" },
                    { name: "ReturnTime", index: "ReturnTime", width: 80, align: "center" },
                    { name: "ReverseAmount", index: "ReverseAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "TransportChargesBalance", index: "TransportChargesBalance", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "Remark", index: "Remark", width: 200 },
                    { name: "Actions", index: "Actions", width: 80, align: "center", sortable: false }
                ],
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
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    var ids = $("#grid1").jqGrid("getDataIDs");
                    for (var i = 0; i < ids.length; i++) {
                        var s = "<input style='height:22px;width:80px;' type='button' value='<%: InnoSoft.LS.Resources.Buttons.ReturnDispatch %>' onclick='objMain.objWorkspace.objContent.returnDispatch(" + ids[i] + ");' />";
                        $("#grid1").jqGrid("setRowData", ids[i], { Actions: s });
                    }
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedRowId = rowid;
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
                        //缓存查询条件
                        $.jStorage.set("SyntheticalSearchCondition_StartTime", $("#formSyntheticalSearchCondition #StartTime").val().trim());
                        $.jStorage.set("SyntheticalSearchCondition_EndTime", $("#formSyntheticalSearchCondition #EndTime").val().trim());
                        $.jStorage.set("SyntheticalSearchCondition_PayerName", $("#formSyntheticalSearchCondition #PayerName").val().trim());
                        $.jStorage.set("SyntheticalSearchCondition_StartCountry", $("#formSyntheticalSearchCondition #StartCountry").val().trim());
                        $.jStorage.set("SyntheticalSearchCondition_StartProvince", $("#formSyntheticalSearchCondition #StartProvince").val().trim());
                        $.jStorage.set("SyntheticalSearchCondition_StartCity", $("#formSyntheticalSearchCondition #StartCity").val().trim());
                        $.jStorage.set("SyntheticalSearchCondition_DestCountry", $("#formSyntheticalSearchCondition #DestCountry").val().trim());
                        $.jStorage.set("SyntheticalSearchCondition_DestProvince", $("#formSyntheticalSearchCondition #DestProvince").val().trim());
                        $.jStorage.set("SyntheticalSearchCondition_DestCity", $("#formSyntheticalSearchCondition #DestCity").val().trim());
                        $.jStorage.set("SyntheticalSearchCondition_CarNo", $("#formSyntheticalSearchCondition #CarNo").val().trim());
                        $.jStorage.set("SyntheticalSearchCondition_OrganId", $("#formSyntheticalSearchCondition #OrganId").val().trim());

                        //重新加载表格
                        $("#grid1").jqGrid("setGridParam", {
                            url: "/chenxk/Statistics/LoadSyntheticalSearchGrid/",
                            datatype: "json",
                            postData: {
                                startTime: $("#formSyntheticalSearchCondition #StartTime").val().trim(),
                                endTime: $("#formSyntheticalSearchCondition #EndTime").val().trim(),
                                payerName: $("#formSyntheticalSearchCondition #PayerName").val().trim(),
                                startCountry: $("#formSyntheticalSearchCondition #StartCountry").val().trim(),
                                startProvince: $("#formSyntheticalSearchCondition #StartProvince").val().trim(),
                                startCity: $("#formSyntheticalSearchCondition #StartCity").val().trim(),
                                destCountry: $("#formSyntheticalSearchCondition #DestCountry").val().trim(),
                                destProvince: $("#formSyntheticalSearchCondition #DestProvince").val().trim(),
                                destCity: $("#formSyntheticalSearchCondition #DestCity").val().trim(),
                                carNo: $("#formSyntheticalSearchCondition #CarNo").val().trim(),
                                organId: $("#formSyntheticalSearchCondition #OrganId").val().trim()
                            }
                        });
                        $("#grid1").trigger("reloadGrid", [{ page: 1 }]);

                        $(this).dialog("close");

                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

            //设置付款单位名称自动完成
            $("#formSyntheticalSearchModify #PayerName").autocomplete({
                source: "/Autocomplete/LoadCustomerNames/",
                minLength: 1,
                change: function (event, ui) {
                    //填充付款单位编码
                    $.get("/Common/LoadCustomerByName", { strName: $("#formSyntheticalSearchModify #PayerName").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#formSyntheticalSearchModify #PayerId").val(ret.Id);
                        }
                        else {
                            $("#formSyntheticalSearchModify #PayerId").val("0");
                            $("#formSyntheticalSearchModify #PayerName").val("");
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#formSyntheticalSearchModify #PayerName").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //创建修改输入对话框
            $("#dialogModify").dialog({
                autoOpen: false,
                height: 300,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSyntheticalSearchModify").valid()) {
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

                            var o = {
                                "PlanId": $("#formSyntheticalSearchModify #PlanId").val().trim(),
                                "ShipmentNo": $("#formSyntheticalSearchModify #ShipmentNo").val().trim(),
                                "DeliveryNo": $("#formSyntheticalSearchModify #DeliveryNo").val().trim(),
                                "PayerId": $("#formSyntheticalSearchModify #PayerId").val().trim(),
                                "PayerName": $("#formSyntheticalSearchModify #PayerName").val().trim(),
                                "ContractId": $("#formSyntheticalSearchModify #ContractId").val().trim(),
                                "OriginalContractNo": $("#formSyntheticalSearchModify #OriginalContractNo").val().trim()
                            };
                            var postData = JSON.stringify(o);

                            //发送数据
                            $.ajax({
                                type: "POST",
                                url: "/chenxk/Statistics/SyntheticalSearchModifyData",
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

                                        $("#dialogModify").dialog("close");

                                        $("#grid1").trigger("reloadGrid", [{ page: 1 }]);
                                    }
                                },
                                error: function (xhr, status, error) {
                                    $.unblockUI();

                                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "")
                                        alert(xhr.responseText);
                                }
                            });
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

        });

    </script>

</asp:Content>
