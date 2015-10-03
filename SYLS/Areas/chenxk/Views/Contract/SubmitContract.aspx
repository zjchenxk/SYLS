<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.ContractViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SubmitContract %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Contract/SubmitContracts/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="/chenxk/Contract/SubmitContract/" onclick="javascript:objMain.objWorkspace.objContent.submit(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/052.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Submit%></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <fieldset style="border: none;">
        <table cellspacing="1" class="details">
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.ContractNo %>
                </td>
                <td class="content">
                    <%: Model.ContractNo %>
                </td>
            </tr>
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
                    <%: InnoSoft.LS.Resources.Labels.GoodsName %>
                </td>
                <td class="content">
                    <%: Model.GoodsName %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.PackingStyle %>
                </td>
                <td class="content">
                    <%: Model.Packing %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.TotalPackages %>
                </td>
                <td class="content">
                    <%: Model.TotalPackages %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.TotalTunnages %>
                </td>
                <td class="content">
                    <%: Model.TotalTunnages.ToString("#0.######")%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.TotalPiles %>
                </td>
                <td class="content">
                    <%: Model.TotalPiles.ToString("#0.######")%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.TotalTenThousands %>
                </td>
                <td class="content">
                    <%: Model.TotalTenThousands.ToString("#0.######")%>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.StartPlace %>
                </td>
                <td class="content">
                    <%: Model.StartPlace %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.DestPlace %>
                </td>
                <td class="content">
                    <%: Model.DestPlace %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.ShipmentTime %>
                </td>
                <td class="content">
                    <%: Model.ShipmentTime %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.ArrivalTime %>
                </td>
                <td class="content">
                    <%: Model.ArrivalTime %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.TotalTransportCharges %>
                </td>
                <td class="content">
                    <%: Model.TotalTransportCharges.ToString("N") %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.PrepayTransportCharges %>
                </td>
                <td class="content">
                    <%: Model.PrepayTransportCharges.ToString("N") %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.ResidualTransportCharges %>
                </td>
                <td class="content">
                    <%: Model.ResidualTransportCharges.ToString("N") %>
                </td>
            </tr>
            <tr>
                <td class="label">
                    <%: InnoSoft.LS.Resources.Labels.OriginalContractNo %>
                </td>
                <td class="content">
                    <%: Model.OriginalContractNo %>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset style="border: none;">
        <div>
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
    </fieldset>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //提交合同
            this.submit = function (action) {
                if (confirm("<%: InnoSoft.LS.Resources.Strings.SubmitContractConfirm %>") == true) {
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
            //创建发货表格
            $("#grid1").jqGrid({
                url: "/chenxk/Contract/LoadContractDeliverPlansGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { contractId: "<%: Model.Id %>" },
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
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>",
                    "", 
                    ""],
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
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                    { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right" },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "Remark", index: "Remark", width: 200 },
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
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

        });

    </script>
</asp:Content>
