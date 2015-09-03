<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ApproveContract %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Contract/ApproveContracts/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="/chenxk/Contract/ApproveContract/" onclick="javascript:objMain.objWorkspace.objContent.save(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //修改单元格原始值
            this.oldCellData = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")) - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //保存数据
            this.save = function (action) {
                //检查数据
                var rows = $("#grid1").jqGrid("getRowData");
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    if (row.ReceiveType == "<%: InnoSoft.LS.Resources.Options.PickUpSelf %>") {
                        continue;
                    }
                    if (parseFloat(row.TransportPrice) <= parseFloat(row.LimitedTransportPrice)) {
                        continue;
                    }
                    if (parseFloat(row.ApprovedTransportPrice) > 0) {
                        continue;
                    }
                    alert("<%: InnoSoft.LS.Resources.Strings.SomeContractsNotApprove %>");
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

                //生成合同发货JSON数据
                var goods = new Array();
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    var g = {
                        "Id": row.Id,
                        "ContractId": '<%: ViewData["ContractId"] %>',
                        "PlanId": row.PlanId,
                        "Packages": row.Packages,
                        "Tunnages": row.Tunnages,
                        "Piles": row.Piles,
                        "TenThousands": row.TenThousands,
                        "TransportChargeExpression": row.TransportChargeExpression,
                        "TransportPriceExpression": row.TransportPriceExpression,
                        "KM": row.KM,
                        "TransportPrice": row.TransportPrice,
                        "TransportCharges": row.TransportCharges,
                        "ApprovedTransportPrice": row.ApprovedTransportPrice,
                        "ApprovedTransportCharges": row.ApprovedTransportCharges
                    };
                    goods.push(g);
                }

                //生成合同JSON数据
                var o = {
                    "Id": '<%: ViewData["ContractId"] %>',
                    "DeliverPlans": goods
                };
                var postData = JSON.stringify(o);

                //发送数据
                $.ajax({
                    type: "POST",
                    url: action,
                    data: postData,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (ret) {
                        $.unblockUI();

                        if (ret.Success == false) {
                            alert(ret.Message);
                        }
                        else {
                            alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceed %>");
                            if (ret.Message != null && ret.Message != "") {
                                alert(ret.Message);
                            }
                            location.replace("/chenxk/Contract/ApproveContracts/");
                        }
                    },
                    error: function (xhr, status, error) {
                        $.unblockUI();

                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    }
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //创建价格审批表格
            $("#grid1").jqGrid({
                url: "/chenxk/Contract/LoadApproveContractDeliverPlansGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { contractId: '<%: ViewData["ContractId"] %>' },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiveType %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.KM %>",
                    "<%: InnoSoft.LS.Resources.Labels.DispatchedTransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.DispatchedTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.LimitedTransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.LimitedTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.ApprovedTransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.ApprovedTransportCharges %>",
                    "",
                    ""],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "PlanId", index: "PlanId", width: 100, hidden: true },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "StartCity", index: "StartCity", width: 60, align: "center" },
                    { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                    { name: "ReceiveType", index: "ReceiveType", width: 60, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center", hidden: true },
                    { name: "Tunnages", index: "Tunnages", width: 80, align: "center" },
                    { name: "Piles", index: "Piles", width: 80, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 60, align: "center", hidden: true },
                    { name: "KM", index: "KM", width: 60, align: "center" },
                    { name: "TransportPrice", index: "TransportPrice", width: 60, align: "right" },
                    { name: "TransportCharges", index: "TransportCharges", width: 80, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "LimitedTransportPrice", index: "LimitedTransportPrice", width: 60, align: "right" },
                    { name: "LimitedTransportCharges", index: "LimitedTransportCharges", width: 80, align: "right" },
                    { name: "ApprovedTransportPrice", index: "ApprovedTransportPrice", width: 60, align: "right", editable: true },
                    { name: "ApprovedTransportCharges", index: "ApprovedTransportCharges", width: 80, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, editable: true },
                    { name: "TransportChargeExpression", index: "TransportChargeExpression", width: 100, hidden: true },
                    { name: "TransportPriceExpression", index: "TransportPriceExpression", width: 100, hidden: true }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CustomerName",
                sortorder: "asc",
                multiselect: false,
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                height: 300,
                footerrow: true,
                userDataOnFooter: true,
                cellEdit: true,
                cellsubmit: "clientArray",
                subGrid: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                subGridRowExpanded: function (subgrid_id, row_id) {
                    var data = $("#grid1").jqGrid("getRowData", row_id);

                    var subgrid_table_id = subgrid_id + "_t";
                    var pager_id = "p_" + subgrid_table_id;

                    $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll'></table><div id='" + pager_id + "' class='scroll'></div>");

                    $("#" + subgrid_table_id).jqGrid({
                        url: "/chenxk/Contract/LoadContractApproveCommentsGrid/",
                        datatype: "json",
                        mtype: "GET",
                        postData: {
                            contractId: '<%: ViewData["ContractId"] %>',
                            planId: data.PlanId
                        },
                        colNames: [
                            "<%: InnoSoft.LS.Resources.Labels.Id %>",
                            "<%: InnoSoft.LS.Resources.Labels.ApproveTime %>",
                            "<%: InnoSoft.LS.Resources.Labels.ApproverName %>",
                            "<%: InnoSoft.LS.Resources.Labels.ApprovedTransportPrice %>",
                            "<%: InnoSoft.LS.Resources.Labels.ApprovedTransportCharges %>"],
                        colModel: [
                            { name: "Id", index: "Id", width: 100, hidden: true },
                            { name: "ApproveTime", index: "ApproveTime", width: 100, align: "center" },
                            { name: "ApproverName", index: "ApproverName", width: 80, align: "center" },
                            { name: "ApprovedTransportPrice", index: "ApprovedTransportPrice", width: 100, align: "right" },
                            { name: "ApprovedTransportCharges", index: "ApprovedTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } }],
                        rowNum: 500,
                        sortname: "ApproveTime",
                        sortorder: "asc",
                        height: "100%",
                        shrinkToFit: true,
                        pager: pager_id,
                        emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                        loadError: function (xhr, status, error) {
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        }
                    });
                    $("#" + subgrid_table_id).jqGrid("navGrid", "#" + pager_id, { edit: false, add: false, del: false, search: false });
                },
                beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
                    var data = $("#grid1").jqGrid("getRowData", rowid);
                    objMain.objWorkspace.objContent.oldCellData = data[cellname];
                    if (data.ReceiveType == "<%: InnoSoft.LS.Resources.Options.PickUpSelf %>") {
                        setTimeout(function () { $("#grid1").jqGrid("editCell", iRow, iCol, false); }, 50);
                    }
                },
                afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                    //失去焦点自动保存
                    $("#" + iRow + "_" + cellname).bind("blur", function () {
                        $("#grid1").jqGrid("saveCell", iRow, iCol);
                    });
                },
                beforeSaveCell: function (rowid, cellname, value, iRow, iCol) {
                    var data = $("#grid1").jqGrid("getRowData", rowid);
                    if (data.ReceiveType == "<%: InnoSoft.LS.Resources.Options.PickUpSelf %>") {
                        return objMain.objWorkspace.objContent.oldCellData;
                    }
                },
                afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                    if (cellname == "ApprovedTransportPrice") {
                        var data = $("#grid1").jqGrid("getRowData", rowid);
                        if (data.ReceiveType != "<%: InnoSoft.LS.Resources.Options.PickUpSelf %>") {
                            //检查审批单价
                            var approvedTransportPrice = parseFloat(data.ApprovedTransportPrice);
                            if (isNaN(approvedTransportPrice)) {
                                $("#grid1").jqGrid("setRowData", rowid, { ApprovedTransportPrice: "0.00", ApprovedTransportCharges: "0.00" });
                            }
                            else if (approvedTransportPrice <= 0) {
                                $("#grid1").jqGrid("setRowData", rowid, { ApprovedTransportPrice: "0.00", ApprovedTransportCharges: "0.00" });
                            }
                            else {
                                //计算审批运费
                                try {
                                    var exp = new Expression("");
                                    exp.Expression(data.TransportChargeExpression);

                                    //添加公里数变量
                                    exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.KM %>", data.KM);

                                    //添加吨数变量
                                    exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Tunnages %>", data.Tunnages);

                                    //添加垛数变量
                                    exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Piles %>", data.Piles);

                                    //添加单价变量
                                    exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportPrice %>", approvedTransportPrice);

                                    //添加运费变量
                                    exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportCharges %>", data.ApprovedTransportCharges);

                                    //计算结果
                                    var ret = exp.Evaluate();
                                    if (isNaN(ret)) {
                                        alert("<%: InnoSoft.LS.Resources.Strings.ComputeApprovedTransportChargesFailed %>");
                                        $("#grid1").jqGrid("setRowData", rowid, { ApprovedTransportPrice: "0.00", ApprovedTransportCharges: "0.00" });
                                    }
                                    else {
                                        //刷新审批运费
                                        $("#grid1").jqGrid("setRowData", rowid, { ApprovedTransportCharges: Math.round(ret * Math.pow(10, 2)) / Math.pow(10, 2) });
                                    }
                                }
                                catch (e) {
                                    alert("<%: InnoSoft.LS.Resources.Strings.ComputeApprovedTransportChargesFailed %>");
                                    $("#grid1").jqGrid("setRowData", rowid, { ApprovedTransportPrice: "0.00", ApprovedTransportCharges: "0.00" });
                                }
                            }

                            //刷新审批运费合计
                        var totalApprovedTransportCharges = 0;
                        var rows = $("#grid1").jqGrid("getRowData");
                        for (var i = 0; i < rows.length; i++) {
                            var row = rows[i];
                            totalApprovedTransportCharges = add(totalApprovedTransportCharges, parseFloat(row.ApprovedTransportCharges));
                        }
                        $("#grid1").jqGrid("footerData", "set", { ApprovedTransportCharges: totalApprovedTransportCharges });
                    }
                }
                else if (cellname == "ApprovedTransportCharges") {
                    var data = $("#grid1").jqGrid("getRowData", rowid);
                    if (data.ReceiveType != "<%: InnoSoft.LS.Resources.Options.PickUpSelf %>") {
                        //检查审批运费
                        var approvedTransportCharges = parseFloat(data.ApprovedTransportCharges);
                        if (isNaN(approvedTransportCharges)) {
                            $("#grid1").jqGrid("setRowData", rowid, { ApprovedTransportPrice: "0.00", ApprovedTransportCharges: "0.00" });
                        }
                        else if (approvedTransportCharges <= 0) {
                            $("#grid1").jqGrid("setRowData", rowid, { ApprovedTransportPrice: "0.00", ApprovedTransportCharges: "0.00" });
                        }
                        else {
                            //计算审批单价
                            try {
                                var exp = new Expression("");
                                exp.Expression(data.TransportPriceExpression);

                                //添加公里数变量
                                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.KM %>", data.KM);

                                //添加吨数变量
                                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Tunnages %>", data.Tunnages);

                                //添加垛数变量
                                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Piles %>", data.Piles);

                                //添加单价变量
                                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportPrice %>", data.ApprovedTransportPrice);

                                //添加运费变量
                                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportCharges %>", approvedTransportCharges);

                                //计算结果
                                var ret = exp.Evaluate();
                                if (isNaN(ret)) {
                                    alert("<%: InnoSoft.LS.Resources.Strings.ComputeApprovedTransportPriceFailed %>");
                                    $("#grid1").jqGrid("setRowData", rowid, { ApprovedTransportPrice: "0.00", ApprovedTransportCharges: "0.00" });
                                }
                                else {
                                    //刷新审批单价
                                    $("#grid1").jqGrid("setRowData", rowid, { ApprovedTransportPrice: Math.round(ret * Math.pow(10, 2)) / Math.pow(10, 2) });
                                }
                            }
                            catch (e) {
                                alert("<%: InnoSoft.LS.Resources.Strings.ComputeApprovedTransportPriceFailed %>");
                                    $("#grid1").jqGrid("setRowData", rowid, { ApprovedTransportPrice: "0.00", ApprovedTransportCharges: "0.00" });
                                }
                            }

                        //刷新审批运费合计
                        var totalApprovedTransportCharges = 0;
                        var rows = $("#grid1").jqGrid("getRowData");
                        for (var i = 0; i < rows.length; i++) {
                            var row = rows[i];
                            totalApprovedTransportCharges = add(totalApprovedTransportCharges, parseFloat(row.ApprovedTransportCharges));
                        }
                        $("#grid1").jqGrid("footerData", "set", { ApprovedTransportCharges: totalApprovedTransportCharges });
                    }
                }
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

        });

    </script>
</asp:Content>
