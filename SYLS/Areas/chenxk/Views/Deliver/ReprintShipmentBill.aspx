<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.PrintShipmentBillViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.PrintShipmentBill %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Deliver/ReprintShipmentBills/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.print();return false;">
            <img src="<%: Url.Content("~/Content/Images/062.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Print %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="shipmentBills" style="margin: 5px 5px;">
        <% Html.RenderPartial(Model.bills[0].PlanType == InnoSoft.LS.Resources.Options.PaperPlan ? "PaperShipmentBill" : "CanShipmentBill", Model); %>
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
            //打印出仓单
            this.print = function () {
                var LODOP = getLodop(document.getElementById('LODOP'), document.getElementById('LODOP_EM'));
                if (LODOP != null) {
                    LODOP.PRINT_INIT("SYLS打印出仓单");
                    LODOP.SET_PRINT_PAGESIZE(1, 2410, 1395, "");

                    for (var i = 0; i < parseInt("<%: Model.bills.Count() %>"); i++) {
                        var strBodyStyle = "<style>thead{font-size:0.75em;} tbody{font-size:0.75em;} tfoot{font-size:0.75em;}</style>";
                        var strBodyHtml = strBodyStyle + "<body>" + document.getElementById("shipmentBill" + i).innerHTML + "</body>";

                        LODOP.ADD_PRINT_TABLE("5mm", "0mm", "210mm", "125mm", strBodyHtml);
                        LODOP.SET_PRINT_STYLEA(0, "TableHeightScope", 1);

                        LODOP.NewPageA();
                    }

                    LODOP.PREVIEW();
                }
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

    </script>
</asp:Content>
