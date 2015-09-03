<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.ContractViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.NewContract %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.newContract();return false;">
            <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.New%></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveContract();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("NewContract", "Contract", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.BasicInfo %></legend>
        <%: Html.HiddenFor(model => model.CarrierId) %>
        <%: Html.HiddenFor(model => model.DispatchBillId) %>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CarNo)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CarNo)%>
                        <%: Html.ValidationMessageFor(model => model.CarNo)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TrailerNo)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TrailerNo)%>
                        <%: Html.ValidationMessageFor(model => model.TrailerNo)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CarType)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CarType)%>
                        <%: Html.ValidationMessageFor(model => model.CarType)%>
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
                        <%: Html.EditorFor(model => model.DriverName)%>
                        <%: Html.ValidationMessageFor(model => model.DriverName)%>
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
                        <%: Html.EditorFor(model => model.DriverLicenseNo)%>
                        <%: Html.ValidationMessageFor(model => model.DriverLicenseNo)%>
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
                        <%: Html.EditorFor(model => model.DriverMobileTel)%>
                        <%: Html.ValidationMessageFor(model => model.DriverMobileTel)%>
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
                        <%: Html.EditorFor(model => model.DriverHomeTel)%>
                        <%: Html.ValidationMessageFor(model => model.DriverHomeTel)%>
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
                        <%: Html.EditorFor(model => model.CarrierName)%>
                        <%: Html.ValidationMessageFor(model => model.CarrierName)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.GoodsName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.GoodsName)%>
                        <%: Html.ValidationMessageFor(model => model.GoodsName)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Packing) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Packing)%>
                        <%: Html.ValidationMessageFor(model => model.Packing)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TotalPackages) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TotalPackages)%>
                        <%: Html.ValidationMessageFor(model => model.TotalPackages)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TotalTunnages) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TotalTunnages)%>
                        <%: Html.ValidationMessageFor(model => model.TotalTunnages)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TotalPiles) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TotalPiles)%>
                        <%: Html.ValidationMessageFor(model => model.TotalPiles)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TotalTenThousands) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TotalTenThousands)%>
                        <%: Html.ValidationMessageFor(model => model.TotalTenThousands)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.StartPlace) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.StartPlace)%>
                        <%: Html.ValidationMessageFor(model => model.StartPlace)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DestPlace) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.DestPlace)%>
                        <%: Html.ValidationMessageFor(model => model.DestPlace)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ShipmentTime) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ShipmentTime)%>
                        <%: Html.ValidationMessageFor(model => model.ShipmentTime)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ArrivalTime) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ArrivalTime)%>
                        <%: Html.ValidationMessageFor(model => model.ArrivalTime)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TotalTransportCharges) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TotalTransportCharges)%>
                        <%: Html.ValidationMessageFor(model => model.TotalTransportCharges)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.PrepayTransportCharges) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.PrepayTransportCharges)%>
                        <%: Html.ValidationMessageFor(model => model.PrepayTransportCharges)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ResidualTransportCharges) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ResidualTransportCharges)%>
                        <%: Html.ValidationMessageFor(model => model.ResidualTransportCharges)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.OriginalContractNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.OriginalContractNo)%>
                        <%: Html.ValidationMessageFor(model => model.OriginalContractNo)%>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.DeliveryList %></legend>
        <div>
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
    </fieldset>
    <% } %>
    <div id="dialogChoiceCarNo" title="">
        <div>
            <table id="grid2">
            </table>
            <div id="pager2">
            </div>
        </div>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //原运费
            this.oldTransportCharges = 0;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认车号获得焦点
                $("#form1 #CarNo").focus().select();
            };
            //新增合同
            this.newContract = function () {
                //读取车号记录表格
                $("#grid2").jqGrid("setGridParam", {
                    url: "/chenxk/Contract/LoadContractDispatchBillsGrid/",
                    datatype: "json"
                });
                $("#grid2").trigger("reloadGrid", [{ page: 1}]);

                //打开对话框
                $("#dialogChoiceCarNo").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.SelectCarNo %>");
                $("#dialogChoiceCarNo").dialog("open");
            };
            //保存合同
            this.saveContract = function () {
                if ($("#form1").valid()) {
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
                    var rows = $("#grid1").jqGrid("getRowData");
                    var goods = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var g = {
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
                            "Remark": row.Remark,
                            "ApprovedTransportPrice": "0",
                            "ApprovedTransportCharges": "0"
                        };
                        goods.push(g);
                    }

                    //生成合同JSON数据
                    var o = {
                        "Id": 0,
                        "DispatchBillId": $("#form1 #DispatchBillId").val().trim(),
                        "ContractNo": "",
                        "CarNo": $("#form1 #CarNo").val().trim(),
                        "TrailerNo": $("#form1 #TrailerNo").val().trim(),
                        "CarType": $("#form1 #CarType").val().trim(),
                        "DriverName": $("#form1 #DriverName").val().trim(),
                        "DriverLicenseNo": $("#form1 #DriverLicenseNo").val().trim(),
                        "DriverMobileTel": $("#form1 #DriverMobileTel").val().trim(),
                        "DriverHomeTel": $("#form1 #DriverHomeTel").val().trim(),
                        "CarrierId": $("#form1 #CarrierId").val().trim(),
                        "CarrierName": $("#form1 #CarrierName").val().trim(),
                        "GoodsName": $("#form1 #GoodsName").val().trim(),
                        "Packing": $("#form1 #Packing").val().trim(),
                        "StartPlace": $("#form1 #StartPlace").val().trim(),
                        "DestPlace": $("#form1 #DestPlace").val().trim(),
                        "ShipmentTime": $("#form1 #ShipmentTime").val().trim(),
                        "ArrivalTime": $("#form1 #ArrivalTime").val().trim(),
                        "TotalPackages": $("#form1 #TotalPackages").val().trim(),
                        "TotalTunnages": $("#form1 #TotalTunnages").val().trim(),
                        "TotalPiles": $("#form1 #TotalPiles").val().trim(),
                        "TotalTenThousands": $("#form1 #TotalTenThousands").val().trim(),
                        "TotalTransportCharges": $("#form1 #TotalTransportCharges").val().trim(),
                        "PrepayTransportCharges": $("#form1 #PrepayTransportCharges").val().trim(),
                        "ResidualTransportCharges": $("#form1 #ResidualTransportCharges").val().trim(),
                        "OriginalContractNo": $("#form1 #OriginalContractNo").val().trim(),
                        "DeliverPlans": goods
                    };
                    var postData = JSON.stringify(o);

                    //发送数据
                    $.ajax({
                        type: "POST",
                        url: "/chenxk/Contract/NewContract/",
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

                                location.replace("/chenxk/Contract/SubmitContracts/");
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
            //设置控件只读
            $("#form1 #CarNo").attr("disabled", "disabled");
            $("#form1 #TrailerNo").attr("disabled", "disabled");
            $("#form1 #CarType").attr("disabled", "disabled");
            $("#form1 #DriverName").attr("disabled", "disabled");
            $("#form1 #DriverLicenseNo").attr("disabled", "disabled");
            $("#form1 #DriverMobileTel").attr("disabled", "disabled");
            $("#form1 #DriverHomeTel").attr("disabled", "disabled");
            $("#form1 #CarrierName").attr("disabled", "disabled");
            $("#form1 #GoodsName").attr("disabled", "disabled");
            $("#form1 #TotalPackages").attr("disabled", "disabled");
            $("#form1 #TotalTunnages").attr("disabled", "disabled");
            $("#form1 #TotalPiles").attr("disabled", "disabled");
            $("#form1 #TotalTenThousands").attr("disabled", "disabled");
            $("#form1 #StartPlace").attr("disabled", "disabled");
            $("#form1 #DestPlace").attr("disabled", "disabled");
            $("#form1 #TotalTransportCharges").attr("disabled", "disabled");
            $("#form1 #ResidualTransportCharges").attr("readonly", "readonly");

            //设置装运时间
            $("#form1 #ShipmentTime").datepicker($.datepicker.regional["zh-CN"]);

            //设置到达时间
            $("#form1 #ArrivalTime").datepicker($.datepicker.regional["zh-CN"]);

            //设置预付运费改变事件
            $("#form1 #PrepayTransportCharges").change(function () {
                //检查预付运费
                var prepayTransportCharges = parseFloat($("#form1 #PrepayTransportCharges").val().trim());
                if (isNaN(prepayTransportCharges)) {
                    $("#form1 #PrepayTransportCharges").val("");
                    return;
                }

                //计算剩余运费
                var totalTransportCharges = parseFloat($("#form1 #TotalTransportCharges").val().trim());
                $("#form1 #ResidualTransportCharges").val(sub(totalTransportCharges, prepayTransportCharges));
            });

            //创建发货表格
            $("#grid1").jqGrid({
                url: "/chenxk/Contract/LoadContractDispatchBillDeliverPlansGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { dispatchBillId: "0" },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverAddress %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiveType %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>",
                    "",
                    "",
                    ""],
                colModel: [
                    { name: "PlanId", index: "PlanId", width: 100, hidden: true },
                    { name: "PlanNo", index: "PlanNo", width: 100, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "ReceiverAddress", index: "ReceiverAddress", width: 300 },
                    { name: "ReceiveType", index: "ReceiveType", width: 60, align: "center" },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                    { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right" },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, editable: true },
                    { name: "Remark", index: "Remark", width: 200, editable: true },
                    { name: "TransportChargeExpression", index: "TransportChargeExpression", width: 100, hidden: true },
                    { name: "TransportPriceExpression", index: "TransportPriceExpression", width: 100, hidden: true },
                    { name: "KM", index: "KM", width: 60, hidden: true}],
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
                cellEdit: true,
                cellsubmit: "clientArray",
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
                    var data = $("#grid1").jqGrid("getRowData", rowid);
                    objMain.objWorkspace.objContent.oldTransportCharges = data.TransportCharges;

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
                        return objMain.objWorkspace.objContent.oldTransportCharges;
                    }
                },
                afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                    if (cellname == "TransportCharges") {
                        var data = $("#grid1").jqGrid("getRowData", rowid);
                        if (data.ReceiveType != "<%: InnoSoft.LS.Resources.Options.PickUpSelf %>") {
                            //检查运费
                            var transportCharges = parseFloat(data.TransportCharges);
                            if (isNaN(transportCharges)) {
                                $("#grid1").jqGrid("setRowData", rowid, { TransportCharges: objMain.objWorkspace.objContent.oldTransportCharges });
                            }
                            else if (transportCharges == 0) {
                                $("#grid1").jqGrid("setRowData", rowid, { TransportCharges: objMain.objWorkspace.objContent.oldTransportCharges });
                            }
                            else {
                                //计算单价
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
                                    exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportPrice %>", 0);

                                    //添加运费变量
                                    exp.AddVariable("<%: InnoSoft.LS.Resources.Labels.TransportCharges %>", data.TransportCharges);

                                    //计算结果
                                    var ret = exp.Evaluate();
                                    if (isNaN(ret)) {
                                        alert("<%: InnoSoft.LS.Resources.Strings.ComputeTransportPriceFailed %>");
                                        $("#grid1").jqGrid("setRowData", rowid, { TransportCharges: objMain.objWorkspace.objContent.oldTransportCharges });
                                    }
                                    else {
                                        //重置单价
                                        $("#grid1").jqGrid("setRowData", rowid, { TransportPrice: Math.round(ret * Math.pow(10, 2)) / Math.pow(10, 2) });

                                        //刷新运费合计
                                        var totalTransportCharges = 0;
                                        var rows = $("#grid1").jqGrid("getRowData");
                                        for (var i = 0; i < rows.length; i++) {
                                            var row = rows[i];
                                            totalTransportCharges = add(totalTransportCharges, parseFloat(row.TransportCharges));
                                        }
                                        $("#grid1").jqGrid("footerData", "set", { TransportCharges: totalTransportCharges });
                                        $("#form1 #TotalTransportCharges").val(totalTransportCharges);

                                        //计算剩余运费
                                        var prepayTransportCharges = parseFloat($("#form1 #PrepayTransportCharges").val().trim());
                                        if (isNaN(prepayTransportCharges)) {
                                            prepayTransportCharges = 0;
                                        }
                                        $("#form1 #ResidualTransportCharges").val(totalTransportCharges - prepayTransportCharges);
                                    }
                                }
                                catch (e) {
                                    alert("<%: InnoSoft.LS.Resources.Strings.ComputeTransportPriceFailed %>");
                                    $("#grid1").jqGrid("setRowData", rowid, { TransportCharges: objMain.objWorkspace.objContent.oldTransportCharges });
                                }
                            }
                        }
                    }
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建选择车号对话框
            $("#dialogChoiceCarNo").dialog({
                autoOpen: false,
                height: 650,
                width: 900,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        //获取选中的调度单
                        var ids = $("#grid2").jqGrid("getGridParam", "selarrrow");
                        if (ids.length == 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarNo %>");
                            return;
                        }

                        if (ids.length == 1) {
                            FillDispatchBillInfo(ids[0]);

                            $(this).dialog("close");
                        }
                        else {
                            //如果选择多个调度单，则检查车号是否一致
                            var carNo = "";
                            for (var i = 0; i < ids.length; i++) {
                                var data = $("#grid2").jqGrid("getRowData", ids[i]);
                                if (data.CarNo != carNo) {
                                    if (carNo == "") {
                                        carNo = data.CarNo;
                                    }
                                    else {
                                        alert("<%: InnoSoft.LS.Resources.Strings.NewContractCarNoMustSame %>");
                                        return;
                                    }
                                }
                            }

                            //选择多个调度单时，必须先对调度单进行合并后，才能新增合同
                            if (confirm("<%: InnoSoft.LS.Resources.Strings.NewContractMultiDispatchBillMustMergeConfirm %>") != true) {
                                return;
                            }

                            if (confirm("<%: InnoSoft.LS.Resources.Strings.NewContractMultiDispatchBillMustMergeAgainConfirm %>") != true) {
                                return;
                            }

                            //开始合并调度单
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

                            var o = {
                                "ids": ids.toString()
                            };
                            var postData = JSON.stringify(o);

                            //发送数据
                            $.ajax({
                                type: "POST",
                                url: "/chenxk/Dispatch/MergeDispatchBills/",
                                data: postData,
                                dataType: "json",
                                contentType: "application/json; charset=utf-8",
                                success: function (ret) {
                                    $.unblockUI();

                                    if (ret.Message != null && ret.Message != "") {
                                        alert(ret.Message);
                                    }
                                    else {
                                        if (ret.ShipmentBillMerged == true) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.ShipmentBillMergedMustReprint %>");
                                        }

                                        if (ret.DeliverBillMerged == true) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.DeliverBillMergedMustReprint %>");
                                        }

                                        FillDispatchBillInfo(ret.DispatchBillId);

                                        $("#dialogChoiceCarNo").dialog("close");
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
                    $("#grid2").jqGrid("setGridWidth", parseInt($("#dialogChoiceCarNo").width()) - 2);
                    $("#grid2").jqGrid("setGridHeight", parseInt($("#dialogChoiceCarNo").height()) - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
                },
                close: function () {
                }
            });

            //创建选择车号表格
            $("#grid2").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.DispatchBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DriverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.MobileTel %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalPackages %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalTunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalTenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.CreateTime %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 80, align: "center", hidden: true },
                    { name: "DriverName", index: "DriverName", width: 100, align: "center" },
                    { name: "DriverMobileTel", index: "DriverMobileTel", width: 120, align: "center" },
                    { name: "TotalPackages", index: "TotalPackages", width: 100, align: "center" },
                    { name: "TotalTunnages", index: "TotalTunnages", width: 100, align: "center" },
                    { name: "TotalPiles", index: "TotalPiles", width: 100, align: "center" },
                    { name: "TotalTenThousands", index: "TotalTenThousands", width: 100, align: "center" },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CarNo",
                sortorder: "asc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                height: 400,
                multiselect: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

        });

        //填充调度单信息方法
        function FillDispatchBillInfo(dispatchBillId) {
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

            //填充调度单信息
            $.get("/chenxk/Contract/LoadContractDispatchBill", { dispatchBillId: dispatchBillId }, function (ret) {
                $.unblockUI();

                $("#form1 #DispatchBillId").val(dispatchBillId);
                $("#form1 #CarNo").val(ret.CarNo);
                $("#form1 #TrailerNo").val(ret.TrailerNo);
                $("#form1 #CarType").val(ret.CarType);
                $("#form1 #DriverName").val(ret.DriverName);
                $("#form1 #DriverLicenseNo").val(ret.DriverLicenseNo);
                $("#form1 #DriverMobileTel").val(ret.DriverMobileTel);
                $("#form1 #DriverHomeTel").val(ret.DriverHomeTel);
                $("#form1 #CarrierId").val(ret.CarrierId);
                $("#form1 #CarrierName").val(ret.CarrierName);
                $("#form1 #GoodsName").val(ret.GoodsName);
                $("#form1 #Packing").val(ret.Packing);
                $("#form1 #TotalPackages").val(ret.TotalPackages);
                $("#form1 #TotalTunnages").val(ret.TotalTunnages);
                $("#form1 #TotalPiles").val(ret.TotalPiles);
                $("#form1 #TotalTenThousands").val(ret.TotalTenThousands);
                $("#form1 #StartPlace").val(ret.StartPlace);
                $("#form1 #DestPlace").val(ret.DestPlace);
                $("#form1 #ShipmentTime").val(ret.ShipmentTime);
                $("#form1 #ArrivalTime").val(ret.ArrivalTime);
                $("#form1 #TotalTransportCharges").val(ret.TotalTransportCharges);
                $("#form1 #PrepayTransportCharges").val(ret.PrepayTransportCharges);
                $("#form1 #ResidualTransportCharges").val(ret.ResidualTransportCharges);
                $("#form1 #OriginalContractNo").val(ret.OriginalContractNo);
            }, "text json").error(function (xhr, status, error) {
                $.unblockUI();

                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });

            //填充调度货物表格
            $("#grid1").jqGrid("setGridParam", {
                url: "/chenxk/Contract/LoadContractDispatchBillDeliverPlansGrid/",
                postData: { dispatchBillId: dispatchBillId }
            });
            $("#grid1").trigger("reloadGrid", [{ page: 1}]);
        }

    </script>
</asp:Content>
