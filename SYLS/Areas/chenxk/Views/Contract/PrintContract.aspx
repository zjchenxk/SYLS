<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.ContractViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.PrintContract %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Contract/PrintContracts/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.print();return false;">
            <img src="<%: Url.Content("~/Content/Images/062.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Print %></a></li>
        <li><a href="/chenxk/Contract/SubmitPrintContract/" onclick="javascript:objMain.objWorkspace.objContent.submit(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/052.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Submit %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="contract" style="margin: 5px 5px; text-align: center;">
        <table border="0" cellpadding="0" cellspacing="0" style="margin-left: auto; margin-right: auto;">
            <tr>
                <td align="center" style="font-size: 20pt; font-weight: bold;">
                    <%: ViewData["CompanyName"] %>
                </td>
            </tr>
            <tr>
                <td align="center" style="font-size: 16pt;">
                    <%: InnoSoft.LS.Resources.Titles.Contract %>
                </td>
            </tr>
            <tr>
                <td align="right" style="font-size: medium;">
                    <%: InnoSoft.LS.Resources.Labels.ContractNo + ":" + Model.ContractNo + (Model.OriginalContractNo != null && Model.OriginalContractNo != "" ? "/" + Model.OriginalContractNo : "")%>
                </td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="width: 740px; table-layout: fixed;">
                        <tr>
                            <td align="center" valign="top" style="width: 120px; border-top: 1px solid black;
                                border-left: 1px solid black; font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.CarrierName %>
                            </td>
                            <td align="left" valign="top" style="width: 250px; border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: Model.CarrierName %>
                            </td>
                            <td align="center" valign="top" style="width: 120px; border-top: 1px solid black;
                                border-left: 1px solid black; font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.GoodsName %>
                            </td>
                            <td align="left" valign="top" style="width: 250px; border-top: 1px solid black; border-left: 1px solid black;
                                border-right: 1px solid black; font-size: medium; padding: 5px;">
                                <%: Model.GoodsName %>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.TotalPackages %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: Model.TotalPackages %>
                            </td>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.TotalTunnages %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                border-right: 1px solid black; font-size: medium; padding: 5px;">
                                <%: Model.TotalTunnages.ToString("#0.######") %>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.TotalPiles %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: Model.TotalPiles.ToString("#0.######") %>
                            </td>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.TotalTenThousands %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                border-right: 1px solid black; font-size: medium; padding: 5px;">
                                <%: Model.TotalTenThousands.ToString("#0.######") %>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.StartPlace %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: Model.StartPlace %>
                            </td>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.DestPlace %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                border-right: 1px solid black; font-size: medium; padding: 5px;">
                                <%: Model.DestPlace %>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.ShipmentTime %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: Model.ShipmentTime %>
                            </td>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.ArrivalTime %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                border-right: 1px solid black; font-size: medium; padding: 5px;">
                                <%: Model.ArrivalTime %>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.CarNo %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: Model.CarNo %>
                            </td>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.TrailerNo %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                border-right: 1px solid black; font-size: medium; padding: 5px;">
                                <% if (Model.TrailerNo == null || Model.TrailerNo == "")
                                   { %>
                                &nbsp;<% } %>
                                <% else
                                   { %>
                                <%: Model.TrailerNo%>
                                <% } %>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.DriverName %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: Model.DriverName %>
                            </td>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.LicenseNo %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                border-right: 1px solid black; font-size: medium; padding: 5px;">
                                <%: Model.DriverLicenseNo %>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.MobileTel %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: Model.DriverMobileTel %>
                            </td>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.HomeTel %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                border-right: 1px solid black; font-size: medium; padding: 5px;">
                                <%: Model.DriverHomeTel %>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.PackingStyle %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <% if (Model.Packing == null || Model.Packing == "")
                                   { %>
                                &nbsp;<% } %>
                                <% else
                                   { %>
                                <%: Model.Packing %>
                                <% } %>
                            </td>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.TransportCharges %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                border-right: 1px solid black; font-size: medium; padding: 5px;">
                                <%: Model.TotalTransportCharges.ToString("N") %>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.PrepayTransportCharges %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: Model.PrepayTransportCharges.ToString("N") %>
                            </td>
                            <td align="center" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Labels.ResidualTransportCharges %>
                            </td>
                            <td align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                border-right: 1px solid black; font-size: medium; padding: 5px;">
                                <%: Model.ResidualTransportCharges.ToString("N")%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                border-right: 1px solid black; font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Strings.ContractTerm1 %><br />
                                <%: InnoSoft.LS.Resources.Strings.ContractTerm2 %><br />
                                <%: InnoSoft.LS.Resources.Strings.ContractTerm3 %><br />
                                <%: InnoSoft.LS.Resources.Strings.ContractTerm4 %><br />
                                <%: InnoSoft.LS.Resources.Strings.ContractTerm5 %><br />
                                <%: InnoSoft.LS.Resources.Strings.ContractTerm6 %><br />
                                <%: InnoSoft.LS.Resources.Strings.ContractTerm7 %><br />
                                <%: InnoSoft.LS.Resources.Strings.ContractTerm8 %><br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="left" valign="top" style="border-top: 1px solid black; border-left: 1px solid black;
                                border-right: 1px solid black; font-size: medium; padding: 5px;">
                                <%: InnoSoft.LS.Resources.Strings.ContractAddress1 %><br />
                                <%: InnoSoft.LS.Resources.Strings.ContractAddress2 %><br />
                                <br />
                                <%: InnoSoft.LS.Resources.Strings.ContractAddress3 %><br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr style="height: 200px;">
                                        <td align="left" valign="top" style="width: 30%; border-top: 1px solid black; border-left: 1px solid black;
                                            border-bottom: 1px solid black; font-size: medium; padding: 5px;">
                                            <%: InnoSoft.LS.Resources.Strings.ContractConsignorSign1 %><br />
                                            <%: InnoSoft.LS.Resources.Strings.ContractConsignorSign2 %><br />
                                        </td>
                                        <td align="left" valign="top" style="width: 30%; border-top: 1px solid black; border-left: 1px solid black;
                                            border-bottom: 1px solid black; font-size: medium; padding: 5px;">
                                            <%: InnoSoft.LS.Resources.Strings.ContractCarrierSign1 %><br />
                                            <%: InnoSoft.LS.Resources.Strings.ContractCarrierSign2 %><br />
                                        </td>
                                        <td align="left" valign="top" style="width: 40%; border-top: 1px solid black; border-left: 1px solid black;
                                            border-right: 1px solid black; border-bottom: 1px solid black; font-size: medium;
                                            padding: 5px;">
                                            <%: InnoSoft.LS.Resources.Labels.Remark %>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整布局
            this.resizeContent = function () {
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //打印合同
            this.print = function () {
                var LODOP = getLodop(document.getElementById('LODOP'), document.getElementById('LODOP_EM'));
                if (LODOP != null) {
                    LODOP.PRINT_INIT("SYLS打印合同");
                    LODOP.ADD_PRINT_TABLE("10mm", "0mm", "200mm", "270mm", document.getElementById("contract").innerHTML);
                    LODOP.PREVIEW();
                }
            };
            //提交打印合同
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

                    $.post(action, { id: "<%: Model.Id %>" }, function (ret) {
                        $.unblockUI();

                        if (ret.Success == false) {
                            alert(ret.Message);
                        }
                        else {
                            if (ret.Message != null && ret.Message != "") {
                                alert(ret.Message);
                            }
                            location.replace("/chenxk/Contract/PrintContracts/");
                        }
                    });
                }
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

    </script>
</asp:Content>
