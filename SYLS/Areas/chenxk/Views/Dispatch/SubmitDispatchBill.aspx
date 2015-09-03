<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.DispatchBillViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SubmitDispatchBill %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Dispatch/SubmitDispatchBills/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="/chenxk/Dispatch/SubmitDispatchBill/" onclick="javascript:objMain.objWorkspace.objContent.submitDispatchBill(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/052.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Submit%></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <fieldset style="border: none;">
        <table cellspacing="1" class="details">
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.CarNo %>
                </td>
                <td class="content">
                    <%: Model.CarNo %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.TrailerNo %>
                </td>
                <td class="content">
                    <%: Model.TrailerNo %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.DriverName %>
                </td>
                <td class="content">
                    <%: Model.DriverName %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.LicenseNo %>
                </td>
                <td class="content">
                    <%: Model.DriverLicenseNo %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.MobileTel %>
                </td>
                <td class="content">
                    <%: Model.DriverMobileTel %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.HomeTel %>
                </td>
                <td class="content">
                    <%: Model.DriverHomeTel %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.CarrierName %>
                </td>
                <td class="content">
                    <%: Model.CarrierName %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.CarryingCapacity %>
                </td>
                <td class="content">
                    <%: Model.CarryingCapacity %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.BusinessType%>
                </td>
                <td class="content">
                    <%: Model.BusinessType %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.PaymentType%>
                </td>
                <td class="content">
                    <%: Model.PaymentType %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.CreateTime%>
                </td>
                <td class="content">
                    <%: Model.CreateTime %>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset style="border: none;">
        <div>
            <table id="gridDispatchedDeliverPlans">
            </table>
            <div id="pagerDispatchedDeliverPlans">
            </div>
        </div>
    </fieldset>
    <fieldset style="border: none;">
        <div>
            <table id="gridDispatchedGoods">
            </table>
            <div id="pagerDispatchedGoods">
            </div>
        </div>
    </fieldset>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#gridDispatchedDeliverPlans").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
                $("#gridDispatchedGoods").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //提交数据
            this.submitDispatchBill = function (action) {
                if (confirm("<%: InnoSoft.LS.Resources.Strings.SubmitDispatchBillConfirm %>") == true) {
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

                    var data = { "Id": "<%: Model.Id %>" };

                    var postData = JSON.stringify(data);

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

                                location.replace("/chenxk/Dispatch/SubmitDispatchBills/");
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
            //创建已配载计划表格
            $("#gridDispatchedDeliverPlans").jqGrid({
                url: "/chenxk/Dispatch/LoadDispatchedDeliverPlansGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { carNo: "<%: Model.CarNo %>" },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.DispatchBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiveType %>",
                    "<%: InnoSoft.LS.Resources.Labels.KM %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "DispatchBillId", index: "DispatchBillId", width: 100, hidden: true },
                    { name: "PlanId", index: "PlanId", width: 100, hidden: true },
                    { name: "PlanNo", index: "PlanNo", width: 100, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                    { name: "ReceiveType", index: "ReceiveType", width: 60, align: "center" },
                    { name: "KM", index: "KM", width: 60, align: "center" },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right" },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "Remark", index: "Remark", width: 200}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "PlanNo",
                sortorder: "asc",
                pager: "#pagerDispatchedDeliverPlans",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                height: 300,
                footerrow: true,
                userDataOnFooter: true,
                caption: "<%: InnoSoft.LS.Resources.Tabs.DispatchedDeliverPlanList %>",
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedDispatchedPlanId = rowid;

                    //加载当前选中计划的货物数据
                    var data = $("#gridDispatchedDeliverPlans").jqGrid("getRowData", objMain.objWorkspace.objContent.selectedDispatchedPlanId);

                    $("#gridDispatchedGoods").jqGrid("setGridParam", {
                        url: "/chenxk/Dispatch/LoadDispatchedGoodsGrid/",
                        postData: {
                            carNo: "<%: Model.CarNo %>",
                            planId: data.PlanId
                        }
                    });
                    $("#gridDispatchedGoods").trigger("reloadGrid", [{ page: 1}]);
                }
            });
            $("#gridDispatchedDeliverPlans").jqGrid("navGrid", "#pagerDispatchedDeliverPlans", { edit: false, add: false, del: false, search: false });

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //创建已配载货物表格
            $("#gridDispatchedGoods").jqGrid({
                url: "/chenxk/Dispatch/LoadDispatchedGoodsGrid",
                datatype: "json",
                mtype: "GET",
                postData: {
                    carNo: "<%: Model.CarNo %>",
                    planId: "0"
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
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                    { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "GoodsNo",
                sortorder: "asc",
                pager: "#pagerDispatchedGoods",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                height: 300,
                footerrow: true,
                userDataOnFooter: true,
                caption: "<%: InnoSoft.LS.Resources.Tabs.DispatchedGoodsList %>",
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
            $("#gridDispatchedGoods").jqGrid("navGrid", "#pagerDispatchedGoods", { edit: false, add: false, del: false, search: false });
        });

    </script>
</asp:Content>
