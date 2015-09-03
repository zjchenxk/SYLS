<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.OutWarehouseBillViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.OutStockEndDifferences %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.save();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("OutWarehouse", "Stock", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.BasicInfo %></legend>
        <%: Html.HiddenFor(model => model.CustomerId) %>
        <%: Html.HiddenFor(model => model.CarrierId) %>
        <%: Html.HiddenFor(model => model.PayerId)%>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CustomerName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CustomerName) %>
                        <%: Html.ValidationMessageFor(model => model.CustomerName) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DeliveryNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.DeliveryNo) %>
                        <%: Html.ValidationMessageFor(model => model.DeliveryNo) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ReceiverName) %>
                        <%: Html.ValidationMessageFor(model => model.ReceiverName) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverCountry) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.ReceiverCountry, ViewData["Countrys"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.ReceiverCountry) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverProvince) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.ReceiverProvince, ViewData["Provinces"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.ReceiverProvince) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverCity) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.ReceiverCity, ViewData["Citys"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.ReceiverCity) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverAddress) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ReceiverAddress) %>
                        <%: Html.ValidationMessageFor(model => model.ReceiverAddress) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverContact) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ReceiverContact) %>
                        <%: Html.ValidationMessageFor(model => model.ReceiverContact) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverContactTel) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ReceiverContactTel) %>
                        <%: Html.ValidationMessageFor(model => model.ReceiverContactTel) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiveType) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.ReceiveType, new SelectListItem[] { new SelectListItem { Text = InnoSoft.LS.Resources.Options.PickUpDelivery, Value = InnoSoft.LS.Resources.Options.PickUpDelivery, Selected = true }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.PickUpSelf, Value = InnoSoft.LS.Resources.Options.PickUpSelf } }, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.ReceiveType) %>
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
                        <%: Html.LabelFor(model => model.PayerName)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.PayerName)%>
                        <%: Html.ValidationMessageFor(model => model.PayerName)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Warehouse) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.Warehouse, ViewData["Warehouses"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.Warehouse) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.IsConsigning) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.IsConsigning) %>
                        <%: Html.ValidationMessageFor(model => model.IsConsigning) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ConsignedDeliveryNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ConsignedDeliveryNo) %>
                        <%: Html.ValidationMessageFor(model => model.ConsignedDeliveryNo) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.LoadingForceFeePrice) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.LoadingForceFeePrice)%>
                        <%: Html.ValidationMessageFor(model => model.LoadingForceFeePrice)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ForceFee) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ForceFee) %>
                        <%: Html.ValidationMessageFor(model => model.ForceFee) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Remark) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Remark) %>
                        <%: Html.ValidationMessageFor(model => model.Remark) %>
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
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.GoodsList %></legend>
        <div>
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnNewGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.New %>
            </button>
            <button id="btnModifyGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
            <button id="btnDeleteGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <% } %>
    <div id="dialogGoods" title="">
        <% Html.RenderPartial("OutStockEndDifferencesGoods", Model.Goods[0]); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //新增货物标志
            this.isNewGoods = true;
            //当前选中货物记录编码
            this.selectedGoodsId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                $("#form1 #CustomerName").focus().select();
            };
            //新增货物信息
            this.newGoods = function () {
                //检查是否输入客户名称
                if ($("#form1 #CustomerId").val().trim() == "0") {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                    return;
                }

                //检查是否输入仓库
                if ($("#form1 #Warehouse").val().trim() == "") {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterWarehouse %>");
                    return;
                }

                //设置编辑模式为新增
                this.isNewGoods = true;

                //初始化控件数据
                $("#formOutStockEndDifferencesGoods #GoodsId").val("0");
                $("#formOutStockEndDifferencesGoods #GoodsNo").val("");
                $("#formOutStockEndDifferencesGoods #GoodsName").val("");
                $("#formOutStockEndDifferencesGoods #Brand").val("");
                $("#formOutStockEndDifferencesGoods #SpecModel").val("");
                $("#formOutStockEndDifferencesGoods #GWeight").val("");
                $("#formOutStockEndDifferencesGoods #Grade").val("");

                //请空选择货物表格
                $("#grid2").jqGrid("clearGridData", true);

                //设置货物编号可写
                $("#formOutStockEndDifferencesGoods #GoodsNo").removeAttr("readonly");

                //打开对话框
                $("#dialogGoods").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewPlanGoods %>");
                $("#dialogGoods").dialog("open");
            };
            //修改货物信息
            this.modifyGoods = function () {
                //检查是否输入客户名称
                if ($("#form1 #CustomerId").val().trim() == "0") {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                    return;
                }

                //检查是否输入仓库
                if ($("#form1 #Warehouse").val().trim() == "") {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterWarehouse %>");
                    return;
                }

                //读取选中的货物记录
                if (this.selectedGoodsId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedGoods %>");
                    return;
                }

                //设置编辑模式为修改
                this.isNewGoods = false;

                //初始化控件数据
                var data = $("#grid1").jqGrid("getRowData", this.selectedGoodsId);
                $("#formOutStockEndDifferencesGoods #GoodsId").val(data.GoodsId);
                $("#formOutStockEndDifferencesGoods #GoodsNo").val(data.GoodsNo);
                $("#formOutStockEndDifferencesGoods #GoodsName").val(data.GoodsName);
                $("#formOutStockEndDifferencesGoods #Brand").val(data.Brand);
                $("#formOutStockEndDifferencesGoods #SpecModel").val(data.SpecModel);
                $("#formOutStockEndDifferencesGoods #GWeight").val(data.GWeight);
                $("#formOutStockEndDifferencesGoods #Grade").val(data.Grade);

                //填充选择货物表格
                $("#grid2").jqGrid("setGridParam", {
                    url: "/chenxk/Stock/LoadGoodsStockGrid/",
                    datatype: "json",
                    postData: {
                        customerId: $("#form1 #CustomerId").val().trim(),
                        goodsId: data.GoodsId,
                        batchNo: data.BatchNo,
                        packing: data.Packing,
                        warehouse: $("#form1 #Warehouse").val().trim(),
                        location: data.Location,
                        productionDate: data.ProductionDate,
                        enterWarehouseBillId: data.EnterWarehouseBillId,
                        consignedDeliveryNo: $("#form1 #ConsignedDeliveryNo").val().trim()
                    },
                    gridComplete: function () {
                        var rowids = $("#grid2").jqGrid("getDataIDs");
                        if (rowids.length > 0) {
                            $("#grid2").jqGrid("setRowData", rowids[0], {
                                ActualPackages: data.Packages,
                                ActualTunnages: data.Tunnages
                            });
                        }
                    }
                });
                $("#grid2").trigger("reloadGrid", [{ page: 1}]);

                //设置货物编号只读
                $("#formOutStockEndDifferencesGoods #GoodsNo").attr("readonly", "readonly");

                //打开对话框
                $("#dialogGoods").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyPlanGoods %>");
                $("#dialogGoods").dialog("open");
            };
            //删除货物信息
            this.deleteGoods = function () {
                if (this.selectedGoodsId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedGoods %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteGoodsConfirm %>") == true) {
                    $("#grid1").jqGrid("delRowData", this.selectedGoodsId);

                    //重置合计数
                    var totalTunnages = 0;
                    var rows = $("#grid1").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        totalTunnages = add(totalTunnages, parseFloat(row.Tunnages));
                    }

                    $("#grid1").jqGrid("footerData", "set", { GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>", Tunnages: totalTunnages });

                    //计算力支费
                    ComputeForceFee();

                    this.selectedGoodsId = null;
                }
            };
            //保存数据
            this.save = function () {
                if ($("#form1").valid()) {
                    //检查录入时间
                    var createTime = $("#form1 #CreateTime").val().trim();
                    var today = formatDate(new Date(), "yyyy-MM-dd");
                    if (createTime > today) {
                        alert("<%: InnoSoft.LS.Resources.Strings.CreateTimeCantNotGreaterThanSystemTime %>");
                        return;
                    }

                    //检查货物数据
                    var rows = $("#grid1").jqGrid("getRowData");
                    if (rows.length == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterGoods %>");
                        return;
                    }

                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var tunnages = parseFloat(row.Tunnages);
                        if (tunnages == 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterTunnages %>");
                            return;
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

                    //生成货物JSON数据
                    var goods = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var g = {
                            "Id": "0",
                            "OutWarehouseBillId": "0",
                            "GoodsId": row.GoodsId,
                            "GoodsNo": row.GoodsNo,
                            "GoodsName": row.GoodsName,
                            "Brand": row.Brand,
                            "SpecModel": row.SpecModel,
                            "GWeight": row.GWeight,
                            "Grade": row.Grade,
                            "PieceWeight": row.PieceWeight,
                            "Packing": row.Packing,
                            "BatchNo": row.BatchNo,
                            "Location": row.Location,
                            "Packages": row.Packages,
                            "Tunnages": row.Tunnages,
                            "Piles": row.Piles,
                            "TenThousands": row.TenThousands,
                            "ProductionDate": row.ProductionDate,
                            "EnterWarehouseBillId": row.EnterWarehouseBillId,
                            "EnterWarehouseBillNo": row.EnterWarehouseBillNo
                        };
                        goods.push(g);
                    }

                    //生成出库单JSON数据
                    var o = {
                        "Id": "0",
                        "BillNo": "",
                        "PlanId": "0",
                        "PlanNo": "",
                        "CustomerId": $("#form1 #CustomerId").val().trim(),
                        "CustomerName": $("#form1 #CustomerName").val().trim(),
                        "DeliveryNo": $("#form1 #DeliveryNo").val().trim(),
                        "OutType": "<%: InnoSoft.LS.Resources.Options.DeliverEndDifferences %>",
                        "ReceiverName": $("#form1 #ReceiverName").val().trim(),
                        "ReceiverCountry": $("#form1 #ReceiverCountry").val().trim(),
                        "ReceiverProvince": $("#form1 #ReceiverProvince").val().trim(),
                        "ReceiverCity": $("#form1 #ReceiverCity").val().trim(),
                        "ReceiverAddress": $("#form1 #ReceiverAddress").val().trim(),
                        "ReceiverContact": $("#form1 #ReceiverContact").val().trim(),
                        "ReceiverContactTel": $("#form1 #ReceiverContactTel").val().trim(),
                        "ReceiveType": $("#form1 #ReceiveType").val().trim(),
                        "CarNo": $("#form1 #CarNo").val().trim(),
                        "TrailerNo": $("#form1 #TrailerNo").val().trim(),
                        "CarrierId": $("#form1 #CarrierId").val().trim(),
                        "CarrierName": $("#form1 #CarrierName").val().trim(),
                        "PayerId": $("#form1 #PayerId").val().trim(),
                        "PayerName": $("#form1 #PayerName").val().trim(),
                        "IsConsigning": ($("#form1 #IsConsigning").attr("checked") == "checked"),
                        "ConsignedDeliveryNo": $("#form1 #ConsignedDeliveryNo").val().trim(),
                        "Warehouse": $("#form1 #Warehouse").val().trim(),
                        "LoadingForceFeePrice": $("#form1 #LoadingForceFeePrice").val().trim(),
                        "ForceFee": $("#form1 #ForceFee").val().trim(),
                        "Remark": $("#form1 #Remark").val().trim(),
                        "CreateTime": $("#form1 #CreateTime").val().trim(),
                        "Goods": goods
                    };
                    var postData = JSON.stringify(o);

                    //发送数据
                    $.ajax({
                        type: "POST",
                        url: $("#form1").attr("action"),
                        data: postData,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceedNextAddNew %>");
                                location.replace("/chenxk/Stock/OutStockEndDifferences/");
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
            //设置客户名称自动完成
            $("#form1 #CustomerName").autocomplete({
                source: "/Autocomplete/LoadCustomerNames/",
                minLength: 1,
                change: function (event, ui) {
                    //填充付款单位编码和名称，以及上力支费价格
                    $("#form1 #PayerId").val("0");
                    $("#form1 #PayerName").val("");
                    $("#form1 #LoadingForceFeePrice").val("0");
                    $("#form1 #ForceFee").val("0");

                    $.get("/Common/LoadCustomerByName", { strName: $("#form1 #CustomerName").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #CustomerId").val(ret.Id);
                            $("#form1 #PayerId").val(ret.Id);
                            $("#form1 #PayerName").val(ret.Name);
                            $("#form1 #LoadingForceFeePrice").val(ret.LoadingForceFeePrice);

                            //计算力支费
                            ComputeForceFee();
                        }
                        else {
                            alert("<%: InnoSoft.LS.Resources.Strings.CustomerNameNotExists %>");
                            $("#form1 #CustomerId").val("0");
                            $("#form1 #CustomerName").val("");
                            $("#form1 #CustomerName").focus().select();
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #CustomerName").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //设置提货单位名称自动完成
            $("#form1 #ReceiverName").autocomplete({
                source: "/Autocomplete/LoadReceiverNames/",
                minLength: 1,
                change: function (event, ui) {
                    //填充提货单位数据
                    $("#form1 #ReceiverCountry").val("");
                    $("#form1 #ReceiverProvince").val("");
                    $("#form1 #ReceiverCity").val("");
                    $("#form1 #ReceiverAddress").val("");
                    $("#form1 #ReceiverContact").val("");
                    $("#form1 #ReceiverContactTel").val("");

                    $.get("/Common/LoadReceiverByName", { strName: $("#form1 #ReceiverName").val().trim() }, function (data) {
                        if (data != null) {
                            $("#form1 #ReceiverCountry").val(data.Country);

                            $.get("/Common/LoadProvincesByCountry", { strCountryName: data.Country }, function (ret) {
                                $.each(ret, function (i, province) {
                                    var option = $("<option></option>").val(province).text(province);
                                    option.appendTo($("#form1 #ReceiverProvince"));
                                });
                                $("#form1 #ReceiverProvince").val(data.Province);
                            }, "text json").error(function (xhr, status, error) {
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            });

                            $.get("/Common/LoadCitysByProvince", { strCountryName: data.Country, strProvinceName: data.Province }, function (ret) {
                                $.each(ret, function (i, city) {
                                    var option = $("<option></option>").val(city).text(city);
                                    option.appendTo($("#form1 #ReceiverCity"));
                                });
                                $("#form1 #ReceiverCity").val(data.City);
                            }, "text json").error(function (xhr, status, error) {
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            });

                            $("#form1 #ReceiverAddress").val(data.Address);
                            $("#form1 #ReceiverContact").val(data.Contact);
                            $("#form1 #ReceiverContactTel").val(data.ContactTel);
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #ReceiverName").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //国家选择事件
            $("#form1 #ReceiverCountry").change(function () {
                $("#form1 #ReceiverProvince").empty();
                $("#form1 #ReceiverProvince").append("<option value=''></option>");

                $("#form1 #ReceiverCity").empty();
                $("#form1 #ReceiverCity").append("<option value=''></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $("<option></option>").val(province).text(province);
                        option.appendTo($("#form1 #ReceiverProvince"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #ReceiverCountry").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //省份选择事件
            $("#form1 #ReceiverProvince").change(function () {
                $("#form1 #ReceiverCity").empty();
                $("#form1 #ReceiverCity").append("<option value=''></option>");

                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#form1 #ReceiverCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, city) {
                        var option = $("<option></option>").val(city).text(city);
                        option.appendTo($("#form1 #ReceiverCity"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #ReceiverProvince").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //设置车号自动完成
            $("#form1 #CarNo").autocomplete({
                source: "/Autocomplete/LoadCarNos/",
                minLength: 1,
                change: function (event, ui) {
                    //填充挂号
                    $("#form1 #TrailerNo").val("");

                    $.get("/Common/LoadCarByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #TrailerNo").val(ret.TrailerNo);
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #CarNo").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        return;
                    });

                    //填充承运单位
                    $("#form1 #CarrierId").val("0");
                    $("#form1 #CarrierName").val("");

                    $.get("/Common/LoadCarrierByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #CarrierId").val(ret.Id);
                            $("#form1 #CarrierName").val(ret.Name);
                        }
                    }, "text json").error(function (xhr, status, error) {
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        return;
                    });
                }
            });

            //设置付款单位名称自动完成
            $("#form1 #PayerName").autocomplete({
                source: "/Autocomplete/LoadCustomerNames/",
                minLength: 1,
                change: function (event, ui) {
                    //填充付款单位编码
                    $.get("/Common/LoadCustomerByName", { strName: $("#form1 #PayerName").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #PayerId").val(ret.Id);
                        }
                        else {
                            $("#form1 #PayerId").val("0");
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #PayerName").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //仓库选择事件
            $("#form1 #Warehouse").change(function () {
                //清空货物表格
                $("#grid1").jqGrid("clearGridData", true);

                $("#form1 #ForceFee").val("0");

                //检查是否输入客户名称
                if ($("#form1 #CustomerId").val().trim() == "0") {
                    $("#form1 #Warehouse").val("");
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                    return;
                }

                //检查当前客户和仓库是否有计划未全部发完货
                $.get("/chenxk/Stock/HasDispatchDeliverPlans", { customerId: $("#form1 #CustomerId").val().trim(), warehouse: $("#form1 #Warehouse").val().trim() }, function (ret) {
                    if (ret) {
                        $("#form1 #Warehouse").val("");
                        alert("<%: InnoSoft.LS.Resources.Strings.CanNotOutWarehouseWhenHasDispatchDeliverPlans %>");
                        return;
                    }
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #Warehouse").val("");
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //设置寄库复选事件
            $("#form1 #IsConsigning").click(function () {
                if ($("#form1 #IsConsigning").attr("checked") == "checked") {
                    $("#form1 #ConsignedDeliveryNo").val("");
                    $("#form1 #ConsignedDeliveryNo").attr("disabled", "disabled");

                    $("#grid1").jqGrid("clearGridData", true);

                    $("#form1 #ForceFee").val("0");
                }
                else {
                    $("#form1 #ConsignedDeliveryNo").removeAttr("disabled");
                }
            });

            //设置寄库交货单号改变事件
            $("#form1 #ConsignedDeliveryNo").change(function () {
                //检查是否输入客户名称
                if ($("#form1 #CustomerId").val().trim() == "0") {
                    $("#form1 #ConsignedDeliveryNo").val("");
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                    return;
                }

                //检查是否输入仓库
                if ($("#form1 #Warehouse").val().trim() == "") {
                    $("#form1 #ConsignedDeliveryNo").val("");
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterWarehouse %>");
                    return;
                }

                //清空货物表格
                $("#grid1").jqGrid("clearGridData", true);
                $("#form1 #ForceFee").val("0");

                if ($("#form1 #ConsignedDeliveryNo").val().trim() != "") {
                    //填充寄库货物表格
                    $("#grid1").jqGrid("setGridParam", {
                        url: "/chenxk/Stock/LoadConsignedGoodsGrid/",
                        datatype: "json",
                        postData: {
                            customerId: $("#form1 #CustomerId").val().trim(),
                            warehouse: $("#form1 #Warehouse").val().trim(),
                            consignedDeliveryNo: $("#form1 #ConsignedDeliveryNo").val().trim()
                        },
                        gridComplete: function () {
                            //计算力支费
                            ComputeForceFee();
                        }
                    });
                    $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                }
            });

            //设置上力支费价格改变事件
            $("#form1 #LoadingForceFeePrice").change(function () {
                //检查价格
                var loadingForceFeePrice = parseFloat($("#form1 #LoadingForceFeePrice").val().trim());
                if (isNaN(loadingForceFeePrice) || loadingForceFeePrice <= 0) {
                    $("#form1 #LoadingForceFeePrice").val("0.00");
                }

                //计算力支费
                ComputeForceFee();
            });

            //设置力支费改变事件
            $("#form1 #ForceFee").change(function () {
                //检查力支费
                var forceFee = parseFloat($("#form1 #ForceFee").val().trim());
                if (isNaN(forceFee) || forceFee <= 0) {
                    $("#form1 #ForceFee").val("0.00");
                }

                //计算上力支费价格
                ComputeLoadingForceFeePrice();
            });

            //设置录入日期
            $("#form1 #CreateTime").datepicker($.datepicker.regional["zh-CN"]);

            //创建货物表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Brand %>",
                    "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                    "<%: InnoSoft.LS.Resources.Labels.GrammeWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Grade %>",
                    "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.PackingSpecification %>",
                    "<%: InnoSoft.LS.Resources.Labels.Location %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.PieceWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "Brand", index: "Brand", width: 80, align: "center" },
                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                    { name: "GWeight", index: "GWeight", width: 50, align: "center" },
                    { name: "Grade", index: "Grade", width: 50, align: "center" },
                    { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                    { name: "Packing", index: "Packing", width: 50, align: "center" },
                    { name: "Location", index: "Location", width: 80, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center", hidden: true },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center", hidden: true },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                    { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "",
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
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedGoodsId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //新增货物按钮点击事件
            $("#btnNewGoods").button().click(function () {
                objMain.objWorkspace.objContent.newGoods();
            });

            //修改货物按钮点击事件
            $("#btnModifyGoods").button().click(function () {
                objMain.objWorkspace.objContent.modifyGoods();
            });

            //删除货物按钮点击事件
            $("#btnDeleteGoods").button().click(function () {
                objMain.objWorkspace.objContent.deleteGoods();
            });

            //创建货物编辑对话框
            $("#dialogGoods").dialog({
                autoOpen: false,
                height: 650,
                width: 900,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        //检查货物编码
                        if ($("#formOutStockEndDifferencesGoods #GoodsNo").val().trim() == null || $("#formOutStockEndDifferencesGoods #GoodsNo").val().trim() == "") {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterGoodsNo %>");
                            return;
                        }

                        //检查累计实发数量
                        var grid2FooterData = $("#grid2").jqGrid("footerData");
                        var totalActualTunnages = parseFloat(grid2FooterData.ActualTunnages);
                        if (isNaN(totalActualTunnages)) {
                            totalActualTunnages = 0;
                        }
                        if (totalActualTunnages == 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterActualTunnages %>");
                            return;
                        }

                        //新增货物信息
                        if (objMain.objWorkspace.objContent.isNewGoods) {
                            //获取货物选择记录
                            var grid2Rows = $("#grid2").jqGrid("getRowData");
                            for (var i = 0; i < grid2Rows.length; i++) {
                                var grid2Row = grid2Rows[i];

                                //获取实发吨数
                                var actualTunnages = parseFloat(grid2Row.ActualTunnages);
                                if (isNaN(actualTunnages)) {
                                    actualTunnages = 0;
                                }

                                if (actualTunnages > 0) {
                                    //检查货物是否重复并累计合计数
                                    var totalTunnages = 0;
                                    var grid1Rows = $("#grid1").jqGrid("getRowData");
                                    for (var n = 0; n < grid1Rows.length; n++) {
                                        var grid1Row = grid1Rows[n];
                                        if (grid1Row.GoodsNo == grid2Row.GoodsNo &&
                                            grid1Row.BatchNo == grid2Row.BatchNo &&
                                            grid1Row.Packing == grid2Row.Packing &&
                                            grid1Row.Location == grid2Row.Location &&
                                            grid1Row.ProductionDate == grid2Row.ProductionDate &&
                                            grid1Row.EnterWarehouseBillId == grid2Row.EnterWarehouseBillId) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.GoodsIsExists %>");
                                            return;
                                        }
                                        totalTunnages = add(totalTunnages, parseFloat(grid1Row.Tunnages));
                                    }

                                    //计算rowid
                                    var rowid = 0;
                                    var rowids = $("#grid1").jqGrid("getDataIDs");
                                    for (var j = 0; j < rowids.length; j++) {
                                        if (rowid < parseFloat(rowids[j])) {
                                            rowid = parseFloat(rowids[j]);
                                        }
                                    }
                                    rowid++;

                                    //添加货物记录
                                    $("#grid1").jqGrid("addRowData", rowid, {
                                        Id: "0",
                                        GoodsId: grid2Row.GoodsId,
                                        GoodsNo: grid2Row.GoodsNo,
                                        GoodsName: grid2Row.GoodsName,
                                        Brand: grid2Row.Brand,
                                        SpecModel: grid2Row.SpecModel,
                                        GWeight: grid2Row.GWeight,
                                        Grade: grid2Row.Grade,
                                        BatchNo: grid2Row.BatchNo,
                                        Packing: grid2Row.Packing,
                                        Location: grid2Row.Location,
                                        Packages: grid2Row.ActualPackages,
                                        PieceWeight: grid2Row.PieceWeight,
                                        Tunnages: actualTunnages,
                                        Piles: grid2Row.ActualPiles,
                                        TenThousands: grid2Row.ActualTenThousands,
                                        ProductionDate: grid2Row.ProductionDate,
                                        EnterWarehouseBillId: grid2Row.EnterWarehouseBillId,
                                        EnterWarehouseBillNo: grid2Row.EnterWarehouseBillNo
                                    });

                                    //重置合计数
                                    $("#grid1").jqGrid("footerData", "set", {
                                        GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>",
                                        Tunnages: add(totalTunnages, actualTunnages)
                                    });
                                }
                            }
                        }
                        //修改货物信息
                        else {
                            //获取货物选择记录
                            var grid2Rows = $("#grid2").jqGrid("getRowData");
                            var grid2Row = grid2Rows[0];

                            //获取实发吨数
                            var actualTunnages = parseFloat(grid2Row.ActualTunnages);
                            if (isNaN(actualTunnages)) {
                                actualTunnages = 0;
                            }

                            //累计合计数
                            var totalTunnages = 0;
                            var rowids = $("#grid1").jqGrid("getDataIDs");
                            var rows = $("#grid1").jqGrid("getRowData");
                            for (var i = 0; i < rows.length; i++) {
                                var rowid = rowids[i];
                                var row = rows[i];

                                if (rowid != objMain.objWorkspace.objContent.selectedGoodsId) {
                                    totalTunnages = add(totalTunnages, parseFloat(row.Tunnages));
                                }
                            }

                            //修改货物记录
                            $("#grid1").jqGrid("setRowData", objMain.objWorkspace.objContent.selectedGoodsId, {
                                GoodsId: grid2Row.GoodsId,
                                GoodsNo: grid2Row.GoodsNo,
                                GoodsName: grid2Row.GoodsName,
                                Brand: grid2Row.Brand,
                                SpecModel: grid2Row.SpecModel,
                                GWeight: grid2Row.GWeight,
                                Grade: grid2Row.Grade,
                                BatchNo: grid2Row.BatchNo,
                                Packing: grid2Row.Packing,
                                Location: grid2Row.Location,
                                Packages: grid2Row.ActualPackages,
                                PieceWeight: grid2Row.PieceWeight,
                                Tunnages: actualTunnages,
                                Piles: grid2Row.ActualPiles,
                                TenThousands: grid2Row.ActualTenThousands,
                                ProductionDate: grid2Row.ProductionDate,
                                EnterWarehouseBillId: grid2Row.EnterWarehouseBillId,
                                EnterWarehouseBillNo: grid2Row.EnterWarehouseBillNo
                            });

                            //重置合计数
                            $("#grid1").jqGrid("footerData", "set", {
                                GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>",
                                Tunnages: add(totalTunnages, actualTunnages)
                            });
                        }

                        //计算力支费
                        ComputeForceFee();

                        $(this).dialog("close");
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                open: function () {
                    var w = parseInt($("#dialogGoods").width()) - parseInt($("#dialogGoods > fieldset:first").css("border-left-width")) * 2 - parseInt($("#dialogGoods > fieldset:first").css("padding-left")) * 2 - parseInt($("#dialogGoods > fieldset:first").css("margin-left")) * 2 - $.scrollbarWidth();
                    $("#grid2").jqGrid("setGridWidth", w - 2);
                },
                close: function () {
                }
            });
        });

        //计算力支费
        function ComputeForceFee() {
            var loadingForceFeePrice = parseFloat($("#form1 #LoadingForceFeePrice").val().trim());
            if (isNaN(loadingForceFeePrice) || loadingForceFeePrice <= 0) {
                loadingForceFeePrice = 0;
            }

            var footerData = $("#grid1").jqGrid("footerData");

            var tunnages = parseFloat(footerData.Tunnages);
            if (isNaN(tunnages) || tunnages <= 0) {
                tunnages = 0;
            }

            var piles = parseFloat(footerData.Piles);
            if (isNaN(piles) || piles <= 0) {
                piles = 0;
            }

            var forceFee = 0;
            if (tunnages > 0) {
                forceFee = mul(tunnages, loadingForceFeePrice);
            }
            else if (piles > 0) {
                forceFee = mul(piles, loadingForceFeePrice);
            }

            $("#form1 #ForceFee").val(Math.round(forceFee * Math.pow(10, 2)) / Math.pow(10, 2));
        }

        //计算上力支费价格
        function ComputeLoadingForceFeePrice() {
            var forceFee = parseFloat($("#form1 #ForceFee").val().trim());
            if (isNaN(forceFee) || forceFee <= 0) {
                forceFee = 0;
            }

            var footerData = $("#grid1").jqGrid("footerData");

            var tunnages = parseFloat(footerData.Tunnages);
            if (isNaN(tunnages) || tunnages <= 0) {
                tunnages = 0;
            }

            var piles = parseFloat(footerData.Piles);
            if (isNaN(piles) || piles <= 0) {
                piles = 0;
            }

            if (forceFee > 0 && tunnages > 0) {
                var loadingForceFeePrice = div(forceFee, tunnages);
                $("#form1 #LoadingForceFeePrice").val(Math.round(loadingForceFeePrice * Math.pow(10, 2)) / Math.pow(10, 2));
            }
            else if (forceFee > 0 && piles > 0) {
                var loadingForceFeePrice = div(forceFee, piles);
                $("#form1 #LoadingForceFeePrice").val(Math.round(loadingForceFeePrice * Math.pow(10, 2)) / Math.pow(10, 2));
            }
        }

    </script>
</asp:Content>
