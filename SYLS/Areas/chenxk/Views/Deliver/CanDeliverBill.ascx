<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.PrintDeliverBillViewModel>" %>
<% int n = 0; foreach (var bill in Model.bills)
   { %>
<div id='<%: "deliverBill" + n %>' style="text-align: center;">
    <table border="0" cellpadding="0" cellspacing="0" style="margin-left: auto; margin-right: auto; text-align: left;">
        <thead>
            <tr>
                <td colspan="6">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan="2" align="center" style="font-size: 20pt; font-weight: bold;">
                                <%: ViewData["CompanyName"] %>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center" style="font-size: 16pt;">
                                <%: InnoSoft.LS.Resources.Titles.DeliverBill %>
                            </td>
                        </tr>
                        <tr>
                            <td valign="middle" style="width: 500px; font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.OutWarehouseUnit + ":" + bill.CustomerName%>
                            </td>
                            <td valign="middle" style="width: 200px; font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.DeliverBillNo + ":" + bill.BillNo%>
                            </td>
                        </tr>
                        <tr>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.ReceiverName + ":" + bill.ReceiverName%>
                            </td>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.OutWarehouseTime + ":" + bill.CreateTime.ToString("yyyy-MM-dd")%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; width: 100px; font-size: 10pt;">
                    <div style="width: 100px;">
                        <%: InnoSoft.LS.Resources.Labels.GoodsNo %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; width: 120px; font-size: 10pt;">
                    <div style="width: 120px;">
                        <%: InnoSoft.LS.Resources.Labels.GoodsName %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; width: 120px; font-size: 10pt;">
                    <div style="width: 120px;">
                        <%: InnoSoft.LS.Resources.Labels.Specification %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; width: 120px; font-size: 10pt;">
                    <div style="width: 120px;">
                        <%: InnoSoft.LS.Resources.Labels.BatchNo %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; width: 120px; font-size: 10pt;">
                    <div style="width: 120px;">
                        <%: InnoSoft.LS.Resources.Labels.Piles %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black; width: 120px; font-size: 10pt;">
                    <div style="width: 120px;">
                        <%: InnoSoft.LS.Resources.Labels.TenThousands %>
                    </div>
                </td>
            </tr>
        </thead>
        <% foreach (var goods in bill.Goods)
           { %>
        <tbody>
            <tr>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <div style="width: 100px;">
                        <%: goods.GoodsNo %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <div style="width: 120px;">
                        <%: goods.GoodsName %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <div style="width: 120px;">
                        <%: goods.SpecModel %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <div style="width: 120px;">
                        <%: goods.BatchNo %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <div style="width: 120px;">
                        <%: goods.Piles.ToString("#0.######")%>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black; font-size: 10pt;">
                    <div style="width: 120px;">
                        <%: goods.TenThousands.ToString("#0.######")%>
                    </div>
                </td>
            </tr>
        </tbody>
        <% } %>
        <tfoot>
            <tr>
                <td colspan="4" align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <%: InnoSoft.LS.Resources.Labels.Subtotal %>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;"
                    tdata="subSum" format="#0.######">#
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black; font-size: 10pt;"
                    tdata="subSum" format="#0.######">#
                </td>
            </tr>
            <tr>
                <td colspan="4" align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black; font-size: 10pt;">
                    <%: InnoSoft.LS.Resources.Labels.Total %>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black; font-size: 10pt;"
                    tdata="Sum" format="#0.######">#
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; font-size: 10pt;"
                    tdata="Sum" format="#0.######">#
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="middle" style="width: 300px; font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.ReceiverContact + ":" + bill.ReceiverContact%>
                            </td>
                            <td valign="middle" style="width: 200px; font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.ContactTel + ":" + bill.ReceiverContactTel%>
                            </td>
                            <td valign="middle" style="width: 200px; font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.CarNo + ":" + bill.CarNo + (bill.TrailerNo == null || bill.TrailerNo == string.Empty ? string.Empty : "-" + bill.TrailerNo)%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" valign="middle" style="font-size: 10pt;">
                                <div style="width: 500px;">
                                    <%: InnoSoft.LS.Resources.Labels.ReceiverAddress + ":" + bill.ReceiverCity + bill.ReceiverAddress%>
                                </div>
                            </td>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.OrderNo + ":" + bill.OrderNo %>
                            </td>
                        </tr>
                        <tr>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.Remark + ":" %>
                            </td>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.Drawer + ":" %>
                            </td>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.ReceiverSign + ":" %>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="6" align="right" valign="middle" style="font-size: 10pt;">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="center" tdata="pageCount" format="#">
                                <%: string.Format(InnoSoft.LS.Resources.Labels.PageCount, "#")%>
                            </td>
                            <td align="center" tdata="pageNO" format="#">
                                <%: string.Format(InnoSoft.LS.Resources.Labels.PageNo, "#")%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </tfoot>
    </table>
</div>
<% n++;
   } %>
