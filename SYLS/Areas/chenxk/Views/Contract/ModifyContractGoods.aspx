<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.ContractDeliverPlanViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ModifyContractGoods %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Contract/ModifyContract/<%: Model.ContractId %>" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="/chenxk/Contract/ModifyContractGoods/" onclick="javascript:objMain.objWorkspace.objContent.save(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.GoodsList %></legend>
        <div>
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.TransportChargesCompute %></legend>
        <% using (Html.BeginForm("", "", FormMethod.Post, new { id = "form1" }))
           { %>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TransportChargeExpression) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TransportChargeExpression)%>
                        <%: Html.ValidationMessageFor(model => model.TransportChargeExpression)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TransportPriceExpression) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TransportPriceExpression)%>
                        <%: Html.ValidationMessageFor(model => model.TransportPriceExpression)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.KM)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.KM)%>
                        <%: Html.ValidationMessageFor(model => model.KM)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TransportPrice)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TransportPrice)%>
                        <%: Html.ValidationMessageFor(model => model.TransportPrice)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TransportCharges)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TransportCharges)%>
                        <%: Html.ValidationMessageFor(model => model.TransportCharges)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Remark)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Remark)%>
                        <%: Html.ValidationMessageFor(model => model.Remark)%>
                    </div>
                </td>
            </tr>
        </table>
        <% } %>
    </fieldset>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:last").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //保存数据
            this.save = function (action) {
                //检查运费数据
                if ($("#form1").valid()) {
                    //检查货物
                    var rows = $("#grid1").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var packages = parseInt(row.Packages);
                        var tunnages = parseFloat(row.Tunnages);
                        var piles = parseFloat(row.Piles);
                        var tenThousands = parseFloat(row.TenThousands);

                        if (tunnages == 0 && piles == 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTunnagesOrPiles %>");
                            return;
                        }
                        if (tunnages != 0 && piles > 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.TunnagesAndPilesCanNotEnterAtSameTime %>");
                            return;
                        }
                        if (tunnages != 0) {
                            if (packages == 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterPackages %>");
                                return;
                            }
                            if (tenThousands > 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.TenThousandsCanNotGreaterThanZeroWhenTunnagesGreaterThanZero %>");
                                return;
                            }
                        }
                        else {
                            if (tenThousands == 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTenThousands %>");
                                return;
                            }
                            if (packages != 0) {
                                alert("<%: InnoSoft.LS.Resources.Strings.PackagesCanNotGreaterThanZeroWhenPilesGreaterThanZero %>");
                                return;
                            }
                        }
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
                            "GoodsId": row.GoodsId,
                            "GoodsName": row.GoodsName,
                            "GoodsNo": row.GoodsNo,
                            "Brand": row.Brand,
                            "SpecModel": row.SpecModel,
                            "GWeight": row.GWeight,
                            "Grade": row.Grade,
                            "BatchNo": row.BatchNo,
                            "Packing": row.Packing,
                            "Location": row.Location,
                            "Packages": row.Packages,
                            "PieceWeight": row.PieceWeight,
                            "Tunnages": row.Tunnages,
                            "Piles": row.Piles,
                            "TenThousands": row.TenThousands,
                            "ProductionDate": row.ProductionDate,
                            "EnterWarehouseBillId": row.EnterWarehouseBillId,
                            "EnterWarehouseBillNo": row.EnterWarehouseBillNo
                        };
                        goods.push(g);
                    }

                    //生成合同发货计划JSON数据
                    var footerData = $("#grid1").jqGrid("footerData");
                    var p = {
                        "Id": "<%: Model.Id %>",
                        "ContractId": "<%: Model.ContractId %>",
                        "DispatchBillId": "<%: Model.DispatchBillId %>",
                        "PlanId": "<%: Model.PlanId %>",
                        "Packages": footerData.Packages,
                        "Tunnages": footerData.Tunnages,
                        "Piles": footerData.Piles,
                        "TenThousands": footerData.TenThousands,
                        "TransportChargeExpression": $("#form1 #TransportChargeExpression").val().trim(),
                        "TransportPriceExpression": $("#form1 #TransportPriceExpression").val().trim(),
                        "KM": $("#form1 #KM").val().trim(),
                        "TransportPrice": $("#form1 #TransportPrice").val().trim(),
                        "TransportCharges": $("#form1 #TransportCharges").val().trim(),
                        "Remark": $("#form1 #Remark").val().trim(),
                        "ApprovedTransportPrice": "0",
                        "ApprovedTransportCharges": "0",
                        "Goods": goods
                    };
                    var postData = JSON.stringify(p);

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

                                location.replace("/chenxk/Contract/ModifyContract/<%: Model.ContractId %>");
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
            //创建合同发货数据表格
            $("#grid1").jqGrid({
                url: "/chenxk/Contract/LoadContractGoodsGrid",
                datatype: "json",
                mtype: "GET",
                postData: {
                    contractId: "<%: Model.ContractId %>",
                    planId: "<%: Model.PlanId %>"
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
                    { name: "Packages", index: "Packages", width: 60, align: "center", editable: true },
                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center", editable: true },
                    { name: "Piles", index: "Piles", width: 100, align: "center", editable: true },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center", editable: true },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                    { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center" }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "GoodsNo",
                sortorder: "asc",
                pager: "#pager1",
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
                        $("#grid1").jqGrid("saveCell", iRow, iCol);
                    });
                },
                afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                    var data = $("#grid1").jqGrid("getRowData", rowid);
                    if (cellname == "Packages") {
                        //检查件数
                        var packages = parseFloat(data.Packages);
                        if (isNaN(packages)) {
                            $("#grid1").jqGrid("setRowData", rowid, { Packages: "0" });
                        }
                    }
                    else if (cellname == "Tunnages") {
                        //检查吨数
                        var tunnages = parseFloat(data.Tunnages);
                        if (isNaN(tunnages)) {
                            $("#grid1").jqGrid("setRowData", rowid, { Tunnages: "0" });
                        }
                    }
                    else if (cellname == "Piles") {
                        //检查垛数
                        var piles = parseFloat(data.Piles);
                        if (isNaN(piles)) {
                            $("#grid1").jqGrid("setRowData", rowid, { Piles: "0" });
                        }
                        else if (piles < 0) {
                            $("#grid1").jqGrid("setRowData", rowid, { Piles: "0" });
                        }
                    }
                    else if (cellname == "TenThousands") {
                        //检查万只
                        var tenThousands = parseFloat(data.TenThousands);
                        if (isNaN(tenThousands)) {
                            $("#grid1").jqGrid("setRowData", rowid, { TenThousands: "0" });
                        }
                        else if (tenThousands < 0) {
                            $("#grid1").jqGrid("setRowData", rowid, { TenThousands: "0" });
                        }
                    }

                    //刷新合计
                    var totalPackages = 0;
                    var totalTunnages = 0;
                    var totalPiles = 0;
                    var totalTenThousands = 0;

                    var rows = $("#grid1").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        totalPackages = add(totalPackages, parseInt(row.Packages));
                        totalTunnages = add(totalTunnages, parseFloat(row.Tunnages));
                        totalPiles = add(totalPiles, parseFloat(row.Piles));
                        totalTenThousands = add(totalTenThousands, parseFloat(row.TenThousands));
                    }
                    $("#grid1").jqGrid("footerData", "set", {
                        Packages: totalPackages,
                        Tunnages: totalTunnages,
                        Piles: totalPiles,
                        TenThousands: totalTenThousands
                    });

                    //计算运费
                    ComputeTransportCharges();
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //设置运费控件为只读
            $("#form1 #TransportChargeExpression").attr("disabled", "disabled");
            $("#form1 #TransportPriceExpression").attr("disabled", "disabled");
            $("#form1 #KM").attr("disabled", "disabled");
            if ('<%: ViewData["ReceiveType"] %>' == '<%: InnoSoft.LS.Resources.Options.PickUpSelf %>') {
                $("fieldset:last > legend").text("<%: InnoSoft.LS.Resources.Tabs.TransportChargesComputePickUpSelf %>");
                $("#form1 #TransportPrice").attr("disabled", "disabled");
                $("#form1 #TransportCharges").attr("disabled", "disabled");
            }

            //设置单价改变事件
            $("#form1 #TransportPrice").change(function () {
                //检查单价
                var transportPrice = parseFloat($("#form1 #TransportPrice").val().trim());
                if (isNaN(transportPrice) || transportPrice <= 0) {
                    $("#form1 #TransportPrice").val("0");
                }

                //计算运费
                ComputeTransportCharges();
            });

            //设置运费改变事件
            $("#form1 #TransportCharges").change(function () {
                //检查运费
                var transportCharges = parseFloat($("#form1 #TransportCharges").val().trim());
                if (isNaN(transportCharges)) {
                    $("#form1 #TransportCharges").val("0.00");
                }

                //计算单价
                ComputeTransportPrice();
            });

        });

        //计算运费
        function ComputeTransportCharges() {
            try {
                var exp = new Expression("");
                exp.Expression($("#form1 #TransportChargeExpression").val().trim());

                //添加公里数变量
                var km = parseInt($("#form1 #KM").val().trim());
                if (isNaN(km) || km <= 0) {
                    km = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.KM %>", km);

                //添加吨数变量
                var footerData = $("#grid1").jqGrid("footerData");
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Tunnages %>", footerData.Tunnages);

                //添加垛数变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Piles %>", footerData.Piles);

                //添加单价变量
                var transportPrice = parseFloat($("#form1 #TransportPrice").val().trim());
                if (isNaN(transportPrice) || transportPrice <= 0) {
                    transportPrice = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportPrice %>", transportPrice);

                //添加运费变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportCharges %>", 0);

                //计算结果
                var ret = exp.Evaluate();
                if (isNaN(ret)) {
                    $("#form1 #TransportCharges").val("0.00");
                }
                else {
                    $("#form1 #TransportCharges").val(Math.round(ret * Math.pow(10, 2)) / Math.pow(10, 2));
                }
            }
            catch (e) {
                $("#form1 #TransportCharges").val("0.00");
            }
        }

        //计算单价
        function ComputeTransportPrice() {
            try {
                var exp = new Expression("");
                exp.Expression($("#form1 #TransportPriceExpression").val().trim());

                //添加公里数变量
                var km = parseInt($("#form1 #KM").val().trim());
                if (isNaN(km) || km <= 0) {
                    km = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.KM %>", km);

                //添加吨数变量
                var footerData = $("#grid1").jqGrid("footerData");
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Tunnages %>", footerData.Tunnages);

                //添加垛数变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.Piles %>", footerData.Piles);

                //添加单价变量
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportPrice %>", 0);

                //添加运费变量
                var transportCharges = parseFloat($("#form1 #TransportCharges").val().trim());
                if (isNaN(transportCharges)) {
                    transportCharges = 0;
                }
                exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportCharges %>", transportCharges);

                //计算结果
                var ret = exp.Evaluate();
                if (isNaN(ret)) {
                    $("#form1 #TransportPrice").val("0");
                }
                else {
                    $("#form1 #TransportPrice").val(Math.round(ret * Math.pow(10, 3)) / Math.pow(10, 3));
                }
            }
            catch (e) {
                $("#form1 #TransportPrice").val("0");
            }
        }

    </script>
</asp:Content>
