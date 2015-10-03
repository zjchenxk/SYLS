<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchDeliverBills %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Deliver/ExportDeliverBills/" onclick="javascript:objMain.objWorkspace.objContent.export(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/049.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Export %></a></li>
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
        <% Html.RenderPartial("SearchDeliverBillsCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询条件
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 3045, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formSearchDeliverBillsCondition #StartTime").val($.jStorage.get("SearchDeliverBillsCondition_StartTime", ""));
                    $("#formSearchDeliverBillsCondition #EndTime").val($.jStorage.get("SearchDeliverBillsCondition_EndTime", ""));
                    $("#formSearchDeliverBillsCondition #CustomerName").val($.jStorage.get("SearchDeliverBillsCondition_CustomerName", ""));
                    $("#formSearchDeliverBillsCondition #DeliveryNo").val($.jStorage.get("SearchDeliverBillsCondition_DeliveryNo", ""));
                    $("#formSearchDeliverBillsCondition #CarNo").val($.jStorage.get("SearchDeliverBillsCondition_CarNo", ""));

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //导出数据
            this.export = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 3045, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#grid1").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.ExportMustAfterSearch %>");
                        return;
                    }

                    var url = action + "?" +
                        "startTime=" + $("#formSearchDeliverBillsCondition #StartTime").val().trim() + "&" +
                        "endTime=" + $("#formSearchDeliverBillsCondition #EndTime").val().trim() + "&" +
                        "customerName=" + $("#formSearchDeliverBillsCondition #CustomerName").val().trim() + "&" +
                        "deliveryNo=" + $("#formSearchDeliverBillsCondition #DeliveryNo").val().trim() + "&" +
                        "carNo=" + $("#formSearchDeliverBillsCondition #CarNo").val().trim();

                    location.replace(url);

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
                    customerName: "",
                    deliveryNo: "",
                    carNo: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverAddress %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.ContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.OriginalContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "ReceiverAddress", index: "ReceiverAddress", width: 300 },
                    { name: "TotalPackages", index: "TotalPackages", width: 60, align: "center" },
                    { name: "TotalTunnages", index: "TotalTunnages", width: 100, align: "center" },
                    { name: "TotalPiles", index: "TotalPiles", width: 100, align: "center" },
                    { name: "TotalTenThousands", index: "TotalTenThousands", width: 100, align: "center" },
                    { name: "ContractNo", index: "ContractNo", width: 100, align: "center" },
                    { name: "OriginalContractNo", index: "OriginalContractNo", width: 100, align: "center" },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","}}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CreateTime",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 300,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearchDeliverBillsCondition").valid()) {
                            //缓存查询条件
                            $.jStorage.set("SearchDeliverBillsCondition_StartTime", $("#formSearchDeliverBillsCondition #StartTime").val().trim());
                            $.jStorage.set("SearchDeliverBillsCondition_EndTime", $("#formSearchDeliverBillsCondition #EndTime").val().trim());
                            $.jStorage.set("SearchDeliverBillsCondition_CustomerName", $("#formSearchDeliverBillsCondition #CustomerName").val().trim());
                            $.jStorage.set("SearchDeliverBillsCondition_DeliveryNo", $("#formSearchDeliverBillsCondition #DeliveryNo").val().trim());
                            $.jStorage.set("SearchDeliverBillsCondition_CarNo", $("#formSearchDeliverBillsCondition #CarNo").val().trim());

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Deliver/LoadSearchDeliverBillsGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearchDeliverBillsCondition #StartTime").val().trim(),
                                    endTime: $("#formSearchDeliverBillsCondition #EndTime").val().trim(),
                                    customerName: $("#formSearchDeliverBillsCondition #CustomerName").val().trim(),
                                    deliveryNo: $("#formSearchDeliverBillsCondition #DeliveryNo").val().trim(),
                                    carNo: $("#formSearchDeliverBillsCondition #CarNo").val().trim()
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
