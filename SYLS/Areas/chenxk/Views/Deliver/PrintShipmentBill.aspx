﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.PrintShipmentBillViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.PrintShipmentBill %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.print();return false;">
            <img src="<%: Url.Content("~/Content/Images/062.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Print %></a></li>
        <li><a href="/chenxk/Deliver/SubmitShipmentBill/" onclick="javascript:objMain.objWorkspace.objContent.submit(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/052.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Submit %></a></li>
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
            //提交出仓单
            this.submit = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 3030, strPermission: "AllowSubmit" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.SubmitShipmentBillConfirm %>") == true) {
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

                        $.post(action, { id: '<%: ViewData["ShipmentBillId"] %>' }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                location.replace("/chenxk/Deliver/SubmitShipmentBills/");
                            }
                        });
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

    </script>
</asp:Content>
