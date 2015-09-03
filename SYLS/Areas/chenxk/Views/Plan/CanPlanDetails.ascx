<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.CanPlanViewModel>" %>
<fieldset style="border: none;">
    <table cellspacing="1" class="details">
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.CustomerName%>
            </td>
            <td class="content">
                <%: Model.CustomerName%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.DeliveryNo%>
            </td>
            <td class="content">
                <%: Model.DeliveryNo%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.ReceiverName%>
            </td>
            <td class="content">
                <%: Model.ReceiverName%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.ReceiverCountry%>
            </td>
            <td class="content">
                <%: Model.ReceiverCountry%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.ReceiverProvince%>
            </td>
            <td class="content">
                <%: Model.ReceiverProvince%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.ReceiverCity%>
            </td>
            <td class="content">
                <%: Model.ReceiverCity%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.ReceiverAddress%>
            </td>
            <td class="content">
                <%: Model.ReceiverAddress%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.ReceiverContact%>
            </td>
            <td class="content">
                <%: Model.ReceiverContact%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.ReceiverContactTel%>
            </td>
            <td class="content">
                <%: Model.ReceiverContactTel%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.ReceiveType%>
            </td>
            <td class="content">
                <%: Model.ReceiveType%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.CarNo%>
            </td>
            <td class="content">
                <%: Model.CarNo%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.TrailerNo%>
            </td>
            <td class="content">
                <%: Model.TrailerNo%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.DriverName%>
            </td>
            <td class="content">
                <%: Model.DriverName%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.LicenseNo%>
            </td>
            <td class="content">
                <%: Model.DriverLicenseNo%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.MobileTel%>
            </td>
            <td class="content">
                <%: Model.DriverMobileTel%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.HomeTel%>
            </td>
            <td class="content">
                <%: Model.DriverHomeTel%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.Warehouse%>
            </td>
            <td class="content">
                <%: Model.Warehouse%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.ArrivalTime%>
            </td>
            <td class="content">
                <%: Model.ArrivalTime%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.PayerName%>
            </td>
            <td class="content">
                <%: Model.PayerName%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.StartCountry%>
            </td>
            <td class="content">
                <%: Model.StartCountry%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.StartProvince%>
            </td>
            <td class="content">
                <%: Model.StartProvince%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.StartCity%>
            </td>
            <td class="content">
                <%: Model.StartCity%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.Remark%>
            </td>
            <td class="content">
                <%: Model.Remark%>
            </td>
        </tr>
        <tr>
            <td class="label">
                <%: InnoSoft.LS.Resources.Labels.CreateTime%>
            </td>
            <td class="content">
                <%: Model.CreateTime%>
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

    //页面初始化
    $(document).ready(function () {
        //创建货物表格
        $("#grid1").jqGrid({
            url: "/chenxk/Plan/LoadCanPlanGoodsGrid/<%: Model.Id %>",
            datatype: "json",
            mtype: "GET",
            colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                    "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                    "<%: InnoSoft.LS.Resources.Labels.Location %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>"],
            colModel: [
                    { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                    { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                    { name: "Warehouse", index: "Warehouse", width: 80, align: "center" },
                    { name: "Location", index: "Location", width: 80, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                    { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center"}],
            rowNum: 500,
            rowList: [50, 100, 500, 1000, 5000],
            sortname: "GoodsNo",
            sortorder: "asc",
            pager: "#pager1",
            viewrecords: true,
            emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
            shrinkToFit: false,
            height: 300,
            footerrow: true,
            userDataOnFooter: true,
            caption: "<%: InnoSoft.LS.Resources.Titles.GoodsList %>",
            loadError: function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            }
        });
        $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

    });

</script>
