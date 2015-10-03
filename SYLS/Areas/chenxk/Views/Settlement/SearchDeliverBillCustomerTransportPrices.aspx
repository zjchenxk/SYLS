<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchDeliverBillCustomerTransportPrices %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Settlement/DeleteDeliverBillCustomerTransportPrice/" onclick="javascript:objMain.objWorkspace.objContent.deleteDeliverBillCustomerTransportPrice(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete%></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("SearchDeliverBillCustomerTransportPricesCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询条件
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 6050, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formSearchDeliverBillCustomerTransportPricesCondition #StartTime").val("");
                    $("#formSearchDeliverBillCustomerTransportPricesCondition #EndTime").val("");
                    $("#formSearchDeliverBillCustomerTransportPricesCondition #DeliverBillNo").val("");
                    $("#formSearchDeliverBillCustomerTransportPricesCondition #CustomerName").val("");
                    $("#formSearchDeliverBillCustomerTransportPricesCondition #DeliveryNo").val("");

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除特殊结算价格记录数据
            this.deleteDeliverBillCustomerTransportPrice = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 6050, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    var id = $("#grid1").jqGrid("getGridParam", "selrow");
                    if (id == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedDeliverBillCustomerTransportPrice %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteDeliverBillCustomerTransportPriceConfirm %>") == true) {
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

                        $.post(action, { id: id }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                location.replace("/chenxk/Settlement/SearchDeliverBillCustomerTransportPrices/");
                            }
                        });
                    }

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    deliverBillNo: "",
                    customerName: "",
                    deliveryNo: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.CreateTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.PayerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.AgreementTransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.ActualTransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.ActualTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransactorName %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "DeliverBillNo", index: "DeliverBillNo", width: 100, align: "center" },
                    { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "AgreementTransportPrice", index: "AgreementTransportPrice", width: 100, align: "right" },
                    { name: "ActualTransportPrice", index: "ActualTransportPrice", width: 100, align: "right" },
                    { name: "ActualTransportCharges", index: "ActualTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "Remark", index: "Remark", width: 400 },
                    { name: "CreatorName", index: "CreatorName", width: 60, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CreateTime",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 350,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearchDeliverBillCustomerTransportPricesCondition").valid()) {
                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Settlement/LoadSearchDeliverBillCustomerTransportPricesGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearchDeliverBillCustomerTransportPricesCondition #StartTime").val().trim(),
                                    endTime: $("#formSearchDeliverBillCustomerTransportPricesCondition #EndTime").val().trim(),
                                    deliverBillNo: $("#formSearchDeliverBillCustomerTransportPricesCondition #DeliverBillNo").val().trim(),
                                    customerName: $("#formSearchDeliverBillCustomerTransportPricesCondition #CustomerName").val().trim(),
                                    deliveryNo: $("#formSearchDeliverBillCustomerTransportPricesCondition #DeliveryNo").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                            $(this).dialog("close");
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });
        });

    </script>
</asp:Content>
