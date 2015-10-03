<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.NoodlePlanViewModel>" %>
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
            url: "/chenxk/Plan/LoadNoodlePlanGoodsGrid/<%: Model.Id %>",
            datatype: "json",
            mtype: "GET",
            colNames: ["<%: InnoSoft.LS.Resources.Labels.GoodsId %>", "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>", "<%: InnoSoft.LS.Resources.Labels.GoodsName %>", "<%: InnoSoft.LS.Resources.Labels.Specification %>", "<%: InnoSoft.LS.Resources.Labels.Boxes %>", "<%: InnoSoft.LS.Resources.Labels.PieceWeight %>", "<%: InnoSoft.LS.Resources.Labels.Tunnages %>"],
            colModel: [
                    { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                    { name: "Packages", index: "Packages", width: 100, align: "center" },
                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center"}],
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
