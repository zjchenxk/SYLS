<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.PrintShipmentBillViewModel>" %>
<% var n = 0; foreach (var bill in Model.bills)
   { %>
<div id='<%: "shipmentBill" + n %>' style="text-align: center;">
    <table border="0" cellpadding="0" cellspacing="0" style="margin-left: auto; margin-right: auto; text-align: left;">
        <thead>
            <tr>
                <td colspan="11">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan="3" align="center" style="font-size: 20pt; font-weight: bold;">
                                <%: ViewData["CompanyName"] %>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center" style="font-size: 16pt;">
                                <%: InnoSoft.LS.Resources.Titles.ShipmentBill %>
                            </td>
                        </tr>
                        <tr>
                            <td valign="middle" style="width: 260px; font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.DeliveryNo + ":" + bill.DeliveryNo %>
                            </td>
                            <td valign="middle" style="width: 240px; font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.Warehouse + ":" + bill.Warehouse %>
                            </td>
                            <td valign="middle" style="width: 240px; font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.ShipmentBillNo + ":" + bill.BillNo %>
                            </td>
                        </tr>
                        <tr>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.CustomerName + ":" + bill.CustomerName %>
                            </td>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.ShiptoParty + ":" + bill.PayerName %>
                            </td>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.ShipmentDate + ":" + bill.CreateTime %>
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
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; width: 100px; font-size: 10pt;">
                    <div style="width: 100px;">
                        <%: InnoSoft.LS.Resources.Labels.Specification %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; width: 40px; font-size: 10pt;">
                    <div style="width: 40px;">
                        <%: InnoSoft.LS.Resources.Labels.GrammeWeight %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; width: 40px; font-size: 10pt;">
                    <div style="width: 40px;">
                        <%: InnoSoft.LS.Resources.Labels.Grade %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; width: 80px; font-size: 10pt;">
                    <div style="width: 80px;">
                        <%: InnoSoft.LS.Resources.Labels.BatchNo %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; width: 40px; font-size: 10pt;">
                    <div style="width: 40px;">
                        <%: InnoSoft.LS.Resources.Labels.Location %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; width: 40px; font-size: 10pt;">
                    <div style="width: 40px;">
                        <%: InnoSoft.LS.Resources.Labels.Pieces %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; width: 60px; font-size: 10pt;">
                    <div style="width: 60px;">
                        <%: InnoSoft.LS.Resources.Labels.PieceWeight %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; width: 80px; font-size: 10pt;">
                    <div style="width: 80px;">
                        <%: InnoSoft.LS.Resources.Labels.Tunnages %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black; width: 40px; font-size: 10pt;">
                    <div style="width: 40px;">
                        <%: InnoSoft.LS.Resources.Labels.PackingSpecification %>
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
                    <div style="width: 100px;">
                        <%: goods.SpecModel %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <div style="width: 40px;">
                        <% if (goods.GWeight == null || goods.GWeight == "")
                           { %>
                    &nbsp;<% } %>
                        <% else
                           { %>
                        <%: goods.GWeight %>
                        <% } %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <div style="width: 40px;">
                        <% if (goods.Grade == null || goods.Grade == "")
                           { %>
                    &nbsp;<% } %>
                        <% else
                           { %>
                        <%: goods.Grade%>
                        <% } %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <div style="width: 80px;">
                        <%: goods.BatchNo %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <div style="width: 40px;">
                        <%: goods.Location %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <div style="width: 40px;">
                        <%: goods.Packages %>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <div style="width: 60px;">
                        <%: goods.PieceWeight.ToString("#0.######")%>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <div style="width: 80px;">
                        <%: goods.Tunnages.ToString("#0.######")%>
                    </div>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black; font-size: 10pt;">
                    <div style="width: 40px;">
                        <%: goods.Packing %>
                    </div>
                </td>
            </tr>
        </tbody>
        <% } %>
        <tfoot>
            <tr>
                <td colspan="7" align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">
                    <%: InnoSoft.LS.Resources.Labels.Subtotal %>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;"
                    tdata="subSum" format="#">#
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;">&nbsp;
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; font-size: 10pt;"
                    tdata="subSum" format="#0.######">#
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black; font-size: 10pt;">&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="7" align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black; font-size: 10pt;">
                    <%: InnoSoft.LS.Resources.Labels.Total %>
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black; font-size: 10pt;"
                    tdata="Sum" format="#">#
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black; font-size: 10pt;">&nbsp;
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-bottom: 1px solid black; font-size: 10pt;"
                    tdata="Sum" format="#0.######">#
                </td>
                <td align="center" valign="middle" style="border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; font-size: 10pt;">&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="11">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="middle" style="width: 260px; font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.ReceiverName + ":" + bill.ReceiverName %>
                            </td>
                            <td valign="middle" style="width: 240px; font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.ContactName + ":" + bill.ReceiverContact %>
                            </td>
                            <td valign="middle" style="width: 240px; font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.ContactTel + ":" + bill.ReceiverContactTel %>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" valign="middle" style="font-size: 10pt;">
                                <div style="width: 500px;">
                                    <%: InnoSoft.LS.Resources.Labels.ReceiverAddress + ":" + (bill.OutType == InnoSoft.LS.Resources.Options.AllocateGoods? "" : (bill.ReceiverCity + bill.ReceiverAddress)) %>
                                </div>
                            </td>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.ReceiveType + ":" + (bill.OutType == InnoSoft.LS.Resources.Options.AllocateGoods? "" : bill.ReceiveType) %>
                            </td>
                        </tr>
                        <tr>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.CarNo + ":" + bill.CarNo + (bill.TrailerNo == string.Empty || bill.TrailerNo == null ? string.Empty : ("-" + bill.TrailerNo)) %>
                            </td>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.DeliverType + ":" + bill.OutType %>
                            </td>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.OrderNo + ":" + bill.OrderNo %>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.Remark + ":" + bill.Remark %>
                            </td>
                        </tr>
                        <tr>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.BillMaker + ":" + bill.CreatorName %>
                            </td>
                            <td valign="middle" style="font-size: 10pt;">
                                <%: InnoSoft.LS.Resources.Labels.Auditor %>:
                            </td>
                            <td align="right" valign="middle" style="font-size: 10pt;">
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
                    </table>
                </td>
            </tr>
        </tfoot>
    </table>
</div>
<% n++;
   } %>
