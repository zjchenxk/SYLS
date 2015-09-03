<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.FineContracts %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.searchContracts();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveFines();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %><label
                id="lblContractCount"></label></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <div id="Grid2" style="margin-top: 1px;">
        <table id="grid2">
        </table>
        <div id="pager2">
        </div>
    </div>
    <div id="dialogSearch" title="">
        <form id="formSearch" action="">
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="ContractNo">
                            <%: InnoSoft.LS.Resources.Labels.ContractNo %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-length="<%: InnoSoft.LS.Resources.Strings.ContractNoMaxLengthIs20 %>"
                            data-val-length-max="20" id="ContractNo" name="ContractNo" type="text" value="" /><br />
                        <span class="field-validation-valid" data-valmsg-for="ReverseTime" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="OriginalContractNo">
                            <%: InnoSoft.LS.Resources.Labels.OriginalContractNo%></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-length="<%: InnoSoft.LS.Resources.Strings.OriginalContractNoMaxLengthIs20 %>"
                            data-val-length-max="20" id="OriginalContractNo" name="OriginalContractNo" type="text"
                            value="" /><br />
                        <span class="field-validation-valid" data-valmsg-for="OriginalContractNo" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="TransactorName">
                            <%: InnoSoft.LS.Resources.Labels.TransactorName %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <select id="TransactorName" name="TransactorName" style="font-family: Arial;">
                            <option value=""></option>
                        </select><br />
                        <span class="field-validation-valid" data-valmsg-for="TransactorName" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
        </table>
        </form>
    </div>
    <div id="dialogNewFine" title="">
        <form id="formNewFine" action="">
        <input type="hidden" id="ContractId" name="ContractId" value="" />
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="FineAmount">
                            <%: InnoSoft.LS.Resources.Labels.FineAmount %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-greaterthanzero="<%: InnoSoft.LS.Resources.Strings.FineAmountNotGreaterThanZero %>"
                            data-val-number="<%: InnoSoft.LS.Resources.Strings.FineAmountMustbeNumber %>"
                            data-val-regex="<%: InnoSoft.LS.Resources.Strings.NotValidCurrency %>" data-val-regex-pattern="^[0-9]+(\.[0-9]{1,2})?$"
                            data-val-required="<%: InnoSoft.LS.Resources.Strings.FineAmountRequired %>" id="FineAmount"
                            name="FineAmount" type="text" value="0.00" /><br />
                        <span class="field-validation-valid" data-valmsg-for="FineAmount" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
        </table>
        </form>
    </div>
    <div id="dialogSaveFine" title="">
        <div>
            <table id="grid3">
            </table>
            <div id="pager3">
            </div>
        </div>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中合同编码
            this.selectedContractId = null;
            //表格1完成标志
            this.grid1Complete = false;
            //表格2完成标志
            this.grid2Complete = false;
            //自动选择定时器
            this.timerId = null;
            //调整布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                var h1 = $("#divWorkspaceContent").height() / 2;
                var h2 = $("#divWorkspaceContent").height() - h1;

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", h1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);

                $("#grid2").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid2").jqGrid("setGridHeight", h2 - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) + 1) - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")) - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) + 1) - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询合同
            this.searchContracts = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4060, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    $("#formSearch #ContractNo").val("");
                    $("#formSearch #OriginalContractNo").val("");
                    $("#formSearch #TransactorName").get(0).selectedIndex = 0;

                    //打开查询条件输入对话框
                    $("#dialogSearch").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogSearch").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //添加罚款记录
            this.addFine = function (id) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4060, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //打开罚款金额输入对话框
                    var data = $("#grid1").jqGrid("getRowData", id);

                    $("#formNewFine #ContractId").val(id);
                    $("#formNewFine #FineAmount").val(data.TransportChargesBalance);

                    $("#dialogNewFine").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterFineAmount %>");
                    $("#dialogNewFine").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除罚款记录
            this.deleteFine = function (id) {
                //删除表格记录
                $("#grid3").jqGrid("delRowData", id);

                //刷新罚款金额合计
                var totalFineAmount = 0;
                var rows = $("#grid3").jqGrid("getRowData");
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    totalFineAmount = add(totalFineAmount, parseFloat(row.FineAmount));
                }
                $("#grid3").jqGrid("footerData", "set", { FineAmount: totalFineAmount });

                //刷新罚款记录缓存
                var ids = null;
                if ($.jStorage.get("FineContracts_SaveFines", "") == "") {
                    ids = new Array();
                }
                else {
                    ids = $.jStorage.get("FineContracts_SaveFines", "").split(",");
                }

                var ids2 = new Array();

                for (var i = 0; i < ids.length; i++) {
                    if (ids[i].split("|")[0] != id) {
                        ids2.push(ids[i]);
                    }
                }
                $.jStorage.set("FineContracts_SaveFines", ids2.toString())

                if (ids2.length > 0) {
                    $("#lblContractCount").text("(" + ids2.length + ")");
                }
                else {
                    $("#lblContractCount").text("");
                }
            };
            //保存罚款记录
            this.saveFines = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4060, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //刷新待保存罚款记录表格
                    $("#grid3").jqGrid("setGridParam", {
                        url: "/chenxk/Contract/LoadSaveFinesGrid/",
                        postData: { saveFines: $.jStorage.get("FineContracts_SaveFines", "") }
                    });
                    $("#grid3").trigger("reloadGrid", [{ page: 1}]);

                    //打开对话框
                    $("#dialogSaveFine").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.SaveFines %>");
                    $("#dialogSaveFine").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            $.jStorage.deleteKey("FineContracts_SaveFines");

            //创建待罚款合同表格
            $("#grid1").jqGrid({
                url: "/chenxk/Contract/LoadFineContractsGrid/",
                datatype: "json",
                mtype: "GET",
                postData: {
                    contractNo: "",
                    originalContractNo: "",
                    transactorId: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.ContractId %>",
                    "<%: InnoSoft.LS.Resources.Labels.ContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.OriginalContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DriverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.MobileTel %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalTunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalApproveTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportChargesBalance %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransactorName %>",
                    ""],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "ContractNo", index: "ContractNo", width: 100, align: "center" },
                    { name: "OriginalContractNo", index: "OriginalContractNo", width: 100, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 80, align: "center", hidden: true },
                    { name: "DriverName", index: "DriverName", width: 100, align: "center" },
                    { name: "DriverMobileTel", index: "DriverMobileTel", width: 120, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "TotalTunnages", index: "TotalTunnages", width: 100, align: "center" },
                    { name: "TotalPiles", index: "TotalPiles", width: 100, align: "center" },
                    { name: "TotalTransportCharges", index: "TotalTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "TotalApproveTransportCharges", index: "TotalApproveTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "TransportChargesBalance", index: "TransportChargesBalance", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "CreatorName", index: "CreatorName", width: 60, align: "center" },
                    { name: "Actions", index: "Actions", width: 80, align: "center", sortable: false}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "ContractNo",
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
                        var s = "<input style='height:22px;width:60px;' type='button' value='<%: InnoSoft.LS.Resources.Buttons.Fine %>' onclick='objMain.objWorkspace.objContent.addFine(" + ids[i] + ");' />";
                        $("#grid1").jqGrid("setRowData", ids[i], { Actions: s });
                    }
                    objMain.objWorkspace.objContent.grid1Complete = true;
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedContractId = rowid;

                    //加载当前选中合同的发货数据
                    $("#grid2").jqGrid("setGridParam", {
                        url: "/chenxk/Contract/LoadFineContractDeliverPlansGrid/",
                        postData: {
                            contractId: objMain.objWorkspace.objContent.selectedContractId
                        }
                    });
                    $("#grid2").trigger("reloadGrid", [{ page: 1}]);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建合同发货记录表格
            $("#grid2").jqGrid({
                url: "/chenxk/Contract/LoadFineContractDeliverPlansGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { contractId: "0" },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverAddress %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiveType %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.ApprovedTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportChargesBalance %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "PlanId", index: "PlanId", width: 100, hidden: true },
                    { name: "PlanNo", index: "PlanNo", width: 100, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "ReceiverAddress", index: "ReceiverAddress", width: 300 },
                    { name: "ReceiveType", index: "ReceiveType", width: 60, align: "center" },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "ApprovedTransportCharges", index: "ApprovedTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "TransportChargesBalance", index: "TransportChargesBalance", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","}}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "PlanNo",
                sortorder: "asc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                height: 300,
                footerrow: true,
                userDataOnFooter: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid2Complete = true;
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

            //创建查询条件录入对话框
            $("#dialogSearch").dialog({
                autoOpen: false,
                height: 200,
                width: 520,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearch").valid()) {
                            $(this).dialog("close");

                            objMain.objWorkspace.objContent.selectedContractId = null;
                            objMain.objWorkspace.objContent.grid1Complete = false;
                            objMain.objWorkspace.objContent.grid2Complete = false;

                            //重新加载合同表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Contract/LoadFineContractsGrid/",
                                datatype: "json",
                                postData: {
                                    contractNo: $("#formSearch #ContractNo").val().trim(),
                                    originalContractNo: $("#formSearch #OriginalContractNo").val().trim(),
                                    transactorId: $("#formSearch #TransactorName").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                            //重新加载合同发货表格
                            $("#grid2").jqGrid("setGridParam", {
                                postData: { contractId: "0" }
                            });
                            $("#grid2").trigger("reloadGrid", [{ page: 1}]);

                            //重新选中第一个合同
                            objMain.objWorkspace.objContent.timerId = setInterval("selectContract();", 500);
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

            //设置经办人下拉列表
            $.get("/Common/LoadStaffs", function (ret) {
                if (ret.length > 0) {
                    $.each(ret, function (i, staff) {
                        var option = $("<option></option>").val(staff.Id).text(staff.FullName);
                        option.appendTo($("#formSearch #TransactorName"));
                    });
                }
            }, "text json").error(function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });

            //创建罚款金额录入对话框
            $("#dialogNewFine").dialog({
                autoOpen: false,
                height: 150,
                width: 520,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formNewFine").valid()) {
                            //检查罚款金额
                            var data = $("#grid1").jqGrid("getRowData", $("#formNewFine #ContractId").val().trim());
                            if (parseFloat($("#formNewFine #FineAmount").val().trim()) > parseFloat(data.TransportChargesBalance)) {
                                alert("<%: InnoSoft.LS.Resources.Strings.FineAmountCanNotGreaterThanTransportChargesBalance %>");
                                return;
                            }

                            $(this).dialog("close");

                            //缓存罚款记录
                            var ids = null;
                            if ($.jStorage.get("FineContracts_SaveFines", "") == "") {
                                ids = new Array();
                            }
                            else {
                                ids = $.jStorage.get("FineContracts_SaveFines", "").split(",");
                            }

                            var i = 0;
                            while (i < ids.length) {
                                if (ids[i].split("|")[0] == $("#formNewFine #ContractId").val().trim()) {
                                    ids[i] = $("#formNewFine #ContractId").val().trim() + "|" + $("#formNewFine #FineAmount").val().trim();
                                    break;
                                }
                                i++;
                            }
                            if (i >= ids.length) {
                                ids.push($("#formNewFine #ContractId").val().trim() + "|" + $("#formNewFine #FineAmount").val().trim());
                            }
                            $.jStorage.set("FineContracts_SaveFines", ids.toString())

                            $("#lblContractCount").text("(" + ids.length + ")");
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

            //创建保存罚款记录对话框
            $("#dialogSaveFine").dialog({
                autoOpen: false,
                height: 500,
                width: 850,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        //检查罚款金额
                        var footerData = $("#grid3").jqGrid("footerData");
                        var totalFineAmount = footerData.FineAmount.replace(/,/g, "");
                        if (parseFloat(totalFineAmount) == 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterFine %>");
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

                        //生成罚款合同记录JSON数据
                        var rows = $("#grid3").jqGrid("getRowData");
                        var fines = new Array();
                        for (var i = 0; i < rows.length; i++) {
                            var row = rows[i];
                            var f = {
                                "ContractId": row.Id,
                                "FineAmount": row.FineAmount
                            };
                            fines.push(f);
                        }

                        var postData = JSON.stringify(fines);

                        //发送数据
                        $.ajax({
                            type: "POST",
                            url: "/chenxk/Contract/FineContracts/",
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

                                    location.replace("/chenxk/Contract/FineContracts/");
                                }
                            },
                            error: function (xhr, status, error) {
                                $.unblockUI();

                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            }
                        });
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                open: function () {
                    $("#grid3").jqGrid("setGridWidth", parseInt($("#dialogSaveFine").width()) - 2);
                    $("#grid3").jqGrid("setGridHeight", parseInt($("#dialogSaveFine").height()) - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));
                },
                close: function () {
                }
            });

            //创建待保存罚款记录表格
            $("#grid3").jqGrid({
                url: "/chenxk/Contract/LoadSaveFinesGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { saveFines: "" },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.ContractId %>",
                    "<%: InnoSoft.LS.Resources.Labels.ContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.OriginalContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DriverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.MobileTel %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransactorName %>",
                    "<%: InnoSoft.LS.Resources.Labels.FineAmount %>",
                    ""],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "ContractNo", index: "ContractNo", width: 100, align: "center" },
                    { name: "OriginalContractNo", index: "OriginalContractNo", width: 100, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 80, align: "center", hidden: true },
                    { name: "DriverName", index: "DriverName", width: 100, align: "center" },
                    { name: "DriverMobileTel", index: "DriverMobileTel", width: 120, align: "center" },
                    { name: "CreatorName", index: "CreatorName", width: 60, align: "center" },
                    { name: "FineAmount", index: "FineAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "Actions", index: "Actions", width: 80, align: "center", sortable: false}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "ContractNo",
                sortorder: "asc",
                pager: "#pager3",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    var ids = $("#grid3").jqGrid("getDataIDs");
                    for (var i = 0; i < ids.length; i++) {
                        var s = "<input style='height:22px;width:60px;' type='button' value='<%: InnoSoft.LS.Resources.Buttons.Delete %>' onclick='objMain.objWorkspace.objContent.deleteFine(" + ids[i] + ");' />";
                        $("#grid3").jqGrid("setRowData", ids[i], { Actions: s });
                    }
                }
            });
            $("#grid3").jqGrid("navGrid", "#pager3", { edit: false, add: false, del: false, search: false });
        });

        //默认选中第一个合同
        objMain.objWorkspace.objContent.timerId = setInterval("selectContract();", 500);
        function selectContract() {
            if (objMain.objWorkspace.objContent.grid1Complete && objMain.objWorkspace.objContent.grid2Complete) {
                clearInterval(objMain.objWorkspace.objContent.timerId);

                if ($("#grid1").jqGrid("getGridParam", "records") > 0) {
                    var rowid = $("#grid1").jqGrid("getRowData")[0].Id;
                    $("#grid1").jqGrid("setSelection", rowid, true);
                }
            }
        }

    </script>
</asp:Content>
