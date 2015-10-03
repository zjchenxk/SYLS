<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.StatStorageAndForceFee %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Stock/ExportStorageAndForceFee/" onclick="javascript:objMain.objWorkspace.objContent.export(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/049.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Export %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveSettlement();return false;">
            <img src="<%: Url.Content("~/Content/Images/084.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.NewInvoice%></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <table id="caption" border="0" cellpadding="0" cellspacing="0" width="100%" style="height: 25px; background-color: #e8eef4;">
        <tr>
            <td id="tdTimeSpan" align="center" style="width: 40%;">
                <%: InnoSoft.LS.Resources.Labels.TimeSpan %>
            </td>
            <td id="tdWarehouse" align="center" style="width: 30%;">
                <%: InnoSoft.LS.Resources.Labels.Warehouse %>
            </td>
            <td id="tdIsConsigning" align="center" style="width: 30%;">
                <%: InnoSoft.LS.Resources.Labels.IsConsigning %>
            </td>
        </tr>
    </table>
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("StatStorageAndForceFeeCondition"); %>
    </div>
    <div id="dialogNewSettlement" title="">
        <% Html.RenderPartial("NewCustomerStorageAndForceFeeSettlement"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - $("#caption").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-hdiv").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询条件
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5060, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formStatStorageAndForceFeeCondition #StartTime").val($.jStorage.get("StatStorageAndForceFeeCondition_StartTime", ""));
                    $("#formStatStorageAndForceFeeCondition #EndTime").val($.jStorage.get("StatStorageAndForceFeeCondition_EndTime", ""));

                    if ($("#formStatStorageAndForceFeeCondition #StartTime").val().trim() != "" && $("#formStatStorageAndForceFeeCondition #EndTime").val().trim() != "") {
                        $("#formStatStorageAndForceFeeCondition #CustomerName").empty();
                        $("#formStatStorageAndForceFeeCondition #CustomerName").append("<option value=''></option>");

                        $.get("/Common/LoadGenerateStorageAndForceFeeCustomersByTimespan", { startTime: $("#formStatStorageAndForceFeeCondition #StartTime").val().trim(), endTime: $("#formStatStorageAndForceFeeCondition #EndTime").val().trim() }, function (ret) {
                            $.each(ret, function (i, customer) {
                                var option = $("<option></option>").val(customer.Name).text(customer.Name);
                                option.appendTo($("#formStatStorageAndForceFeeCondition #CustomerName"));
                            });
                            $("#formStatStorageAndForceFeeCondition #CustomerName").val($.jStorage.get("StatStorageAndForceFeeCondition_CustomerName", ""));
                        }, "text json").error(function (xhr, status, error) {
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        });
                    }

                    $("#formStatStorageAndForceFeeCondition #Warehouse").val($.jStorage.get("StatStorageAndForceFeeCondition_Warehouse", ""));
                    $("#formStatStorageAndForceFeeCondition #IsConsigning").attr("checked", $.jStorage.get("StatStorageAndForceFeeCondition_IsConsigning", false));

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
                $.get("/Common/LoadAccountPermission", { strFuncId: 5060, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#grid1").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.ExportMustAfterSearch %>");
                        return;
                    }
                    else {
                        if ($("#formStatStorageAndForceFeeCondition #StartTime").val().trim() == "" && $("#formStatStorageAndForceFeeCondition #EndTime").val().trim() == "") {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterStartTimeAndEndTimeCondition %>");
                            return;
                        }
                    }

                    var url = action + "?" +
                        "startTime=" + $("#formStatStorageAndForceFeeCondition #StartTime").val().trim() + "&" +
                        "endTime=" + $("#formStatStorageAndForceFeeCondition #EndTime").val().trim() + "&" +
                        "customerName=" + $("#formStatStorageAndForceFeeCondition #CustomerName").val().trim() + "&" +
                        "warehouse=" + $("#formStatStorageAndForceFeeCondition #Warehouse").val().trim() + "&" +
                        "isConsigning=" + ($("#formStatStorageAndForceFeeCondition #IsConsigning").attr("checked") == "checked").toString();

                    location.replace(url);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //保存结算信息
            this.saveSettlement = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5060, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#grid1").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NewInvoiceMustAfterSearch %>");
                        return;
                    }
                    else {
                        if ($("#formStatStorageAndForceFeeCondition #StartTime").val().trim() == "" && $("#formStatStorageAndForceFeeCondition #EndTime").val().trim() == "") {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterStartTimeAndEndTimeCondition %>");
                            return;
                        }
                    }

                    //计算开票金额
                    var footerData = $("#grid1").jqGrid("footerData");
                    var deliverEnterWarehouseForceFee = parseFloat(footerData.DeliverEnterWarehouseForceFee.replace(/,/g, ""));
                    if (isNaN(deliverEnterWarehouseForceFee)) {
                        deliverEnterWarehouseForceFee = 0;
                    }
                    var deliverOutWarehouseForceFee = parseFloat(footerData.DeliverOutWarehouseForceFee.replace(/,/g, ""));
                    if (isNaN(deliverOutWarehouseForceFee)) {
                        deliverOutWarehouseForceFee = 0;
                    }
                    var allocateOutWarehouseForceFee = parseFloat(footerData.AllocateOutWarehouseForceFee.replace(/,/g, ""));
                    if (isNaN(allocateOutWarehouseForceFee)) {
                        allocateOutWarehouseForceFee = 0;
                    }
                    var storageFee = parseFloat(footerData.StorageFee.replace(/,/g, ""));
                    if (isNaN(storageFee)) {
                        storageFee = 0;
                    }

                    var invoiceAmount = add(deliverEnterWarehouseForceFee, deliverOutWarehouseForceFee);
                    invoiceAmount = add(invoiceAmount, allocateOutWarehouseForceFee);
                    invoiceAmount = add(invoiceAmount, storageFee);

                    //初始化编辑控件
                    $("#formNewCustomerStorageAndForceFeeSettlement #StartTime").val($.jStorage.get("StatStorageAndForceFeeCondition_StartTime", ""));
                    $("#formNewCustomerStorageAndForceFeeSettlement #EndTime").val($.jStorage.get("StatStorageAndForceFeeCondition_EndTime", ""));
                    $("#formNewCustomerStorageAndForceFeeSettlement #InvoiceNo").val("");

                    if ($("#formNewCustomerStorageAndForceFeeSettlement #StartTime").val().trim() != "" && $("#formNewCustomerStorageAndForceFeeSettlement #EndTime").val().trim() != "") {
                        $("#formNewCustomerStorageAndForceFeeSettlement #CustomerName").empty();
                        $("#formNewCustomerStorageAndForceFeeSettlement #CustomerName").append("<option value=''></option>");

                        $.get("/Common/LoadGenerateStorageAndForceFeeCustomersByTimespan", { startTime: $("#formNewCustomerStorageAndForceFeeSettlement #StartTime").val().trim(), endTime: $("#formNewCustomerStorageAndForceFeeSettlement #EndTime").val().trim() }, function (ret) {
                            $.each(ret, function (i, customer) {
                                var option = $("<option></option>").val(customer.Id).text(customer.FullName);
                                option.appendTo($("#formNewCustomerStorageAndForceFeeSettlement #CustomerName"));
                            });
                            $("#formNewCustomerStorageAndForceFeeSettlement #CustomerName").val("");
                        }, "text json").error(function (xhr, status, error) {
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        });
                    }

                    $("#formNewCustomerStorageAndForceFeeSettlement #InvoiceType").get(0).selectedIndex = 1;
                    $("#formNewCustomerStorageAndForceFeeSettlement #InvoiceAmount").val(invoiceAmount);
                    $("#formNewCustomerStorageAndForceFeeSettlement #Remark").val("");

                    //打开对话框
                    $("#dialogNewSettlement").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewCustomerStorageAndForceFeeSettlement %>");
                    $("#dialogNewSettlement").dialog("open");

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    stratTime: "",
                    endTime: "",
                    customerName: "",
                    warehouse: "",
                    isConsigning: "false"
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Date %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.UnloadingForceFeePrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverEnterWarehouseForceFee %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalAllocateEnterWarehouseTunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.LoadingForceFeePrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverOutWarehouseForceFee %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalAllocateOutWarehouseTunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllocateOutWarehouseForceFee %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.StorageFeePrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.StorageFee %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "TotalDeliverEnterWarehouseTunnages", index: "TotalDeliverEnterWarehouseTunnages", width: 100, align: "center", summaryType: myNumberSum },
                    { name: "TotalDeliverEnterWarehousePiles", index: "TotalDeliverEnterWarehousePiles", width: 100, align: "center", summaryType: myNumberSum },
                    { name: "UnloadingForceFeePrice", index: "UnloadingForceFeePrice", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "DeliverEnterWarehouseForceFee", index: "DeliverEnterWarehouseForceFee", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "TotalAllocateEnterWarehouseTunnages", index: "TotalAllocateEnterWarehouseTunnages", width: 100, align: "center", summaryType: myNumberSum },
                    { name: "TotalDeliverOutWarehouseTunnages", index: "TotalDeliverOutWarehouseTunnages", width: 100, align: "center", summaryType: myNumberSum },
                    { name: "TotalDeliverOutWarehousePiles", index: "TotalDeliverOutWarehousePiles", width: 100, align: "center", summaryType: myNumberSum },
                    { name: "LoadingForceFeePrice", index: "LoadingForceFeePrice", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "DeliverOutWarehouseForceFee", index: "DeliverOutWarehouseForceFee", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "TotalAllocateOutWarehouseTunnages", index: "TotalAllocateOutWarehouseTunnages", width: 100, align: "center" },
                    { name: "AllocateOutWarehouseForceFee", index: "AllocateOutWarehouseForceFee", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "BalanceTunnages", index: "BalanceTunnages", width: 100, align: "center" },
                    { name: "BalancePiles", index: "BalancePiles", width: 100, align: "center" },
                    { name: "StorageFeePrice", index: "StorageFeePrice", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "StorageFee", index: "StorageFee", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "Id",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
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
                }
            });
            $("#grid1").jqGrid("setGroupHeaders", {
                useColSpanStyle: true,
                groupHeaders: [
                    { startColumnName: "TotalDeliverEnterWarehouseTunnages", numberOfColumns: 2, titleText: "<%: InnoSoft.LS.Resources.Labels.TotalDeliverEnterWarehouse %>" },
                    { startColumnName: "TotalDeliverOutWarehouseTunnages", numberOfColumns: 2, titleText: "<%: InnoSoft.LS.Resources.Labels.TotalDeliverOutWarehouse %>" },
                    { startColumnName: "BalanceTunnages", numberOfColumns: 2, titleText: "<%: InnoSoft.LS.Resources.Labels.Balance %>" }]
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 300,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formStatStorageAndForceFeeCondition").valid()) {
                            //缓存查询条件
                            $.jStorage.set("StatStorageAndForceFeeCondition_StartTime", $("#formStatStorageAndForceFeeCondition #StartTime").val().trim());
                            $.jStorage.set("StatStorageAndForceFeeCondition_EndTime", $("#formStatStorageAndForceFeeCondition #EndTime").val().trim());
                            $.jStorage.set("StatStorageAndForceFeeCondition_CustomerName", $("#formStatStorageAndForceFeeCondition #CustomerName").val().trim());
                            $.jStorage.set("StatStorageAndForceFeeCondition_Warehouse", $("#formStatStorageAndForceFeeCondition #Warehouse").val().trim());
                            $.jStorage.set("StatStorageAndForceFeeCondition_IsConsigning", ($("#formStatStorageAndForceFeeCondition #IsConsigning").attr("checked") == "checked"));

                            $("#tdTimeSpan").text("<%: InnoSoft.LS.Resources.Labels.TimeSpan %>:" + $("#formStatStorageAndForceFeeCondition #StartTime").val().trim() + " ～ " + $("#formStatStorageAndForceFeeCondition #EndTime").val().trim());
                            $("#tdWarehouse").text("<%: InnoSoft.LS.Resources.Labels.Warehouse %>:" + ($("#formStatStorageAndForceFeeCondition #Warehouse").val().trim() == null || $("#formStatStorageAndForceFeeCondition #Warehouse").val().trim() == "" ? "<%: InnoSoft.LS.Resources.Options.All %>" : $("#formStatStorageAndForceFeeCondition #Warehouse").val().trim()));
                            $("#tdIsConsigning").text("<%: InnoSoft.LS.Resources.Labels.IsConsigning %>:" + ($("#formStatStorageAndForceFeeCondition #IsConsigning").attr("checked") == "checked" ? "<%: InnoSoft.LS.Resources.Options.Yes %>" : "<%: InnoSoft.LS.Resources.Options.No %>"));

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Stock/LoadStatStorageAndForceFeeGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formStatStorageAndForceFeeCondition #StartTime").val().trim(),
                                    endTime: $("#formStatStorageAndForceFeeCondition #EndTime").val().trim(),
                                    customerName: $("#formStatStorageAndForceFeeCondition #CustomerName").val().trim(),
                                    warehouse: $("#formStatStorageAndForceFeeCondition #Warehouse").val().trim(),
                                    isConsigning: ($("#formStatStorageAndForceFeeCondition #IsConsigning").attr("checked") == "checked")
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1 }]);

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

            //创建结算信息保存对话框
            $("#dialogNewSettlement").dialog({
                autoOpen: false,
                height: 400,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formNewCustomerStorageAndForceFeeSettlement").valid()) {
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

                            //生成发票JSON数据
                            var o = {
                                "StartTime": $("#formNewCustomerStorageAndForceFeeSettlement #StartTime").val().trim(),
                                "EndTime": $("#formNewCustomerStorageAndForceFeeSettlement #EndTime").val().trim(),
                                "InvoiceNo": $("#formNewCustomerStorageAndForceFeeSettlement #InvoiceNo").val().trim(),
                                "CustomerId": $("#formNewCustomerStorageAndForceFeeSettlement #CustomerName").val().trim(),
                                "CustomerName": $("#formNewCustomerStorageAndForceFeeSettlement #CustomerName").find("option:selected").text(),
                                "InvoiceType": $("#formNewCustomerStorageAndForceFeeSettlement #InvoiceType").find("option:selected").text(),
                                "InvoiceAmount": $("#formNewCustomerStorageAndForceFeeSettlement #InvoiceAmount").val().trim(),
                                "Remark": $("#formNewCustomerStorageAndForceFeeSettlement #Remark").val().trim()
                            };

                            var postData = JSON.stringify(o);

                            //发送数据
                            $.ajax({
                                type: "POST",
                                url: "/chenxk/Stock/NewCustomerStorageAndForceFeeSettlement/",
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

                                        location.replace("/chenxk/Stock/StatStorageAndForceFee/");
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
                close: function () {
                }
            });

            //禁止编辑起止时间和发票金额
            $("#formNewCustomerStorageAndForceFeeSettlement #StartTime").attr("readonly", "readonly");
            $("#formNewCustomerStorageAndForceFeeSettlement #EndTime").attr("readonly", "readonly");
            $("#formNewCustomerStorageAndForceFeeSettlement #InvoiceAmount").attr("readonly", "readonly");

        });

    </script>
</asp:Content>
