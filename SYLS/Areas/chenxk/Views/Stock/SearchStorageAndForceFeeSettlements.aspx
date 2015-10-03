<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchStorageAndForceFeeSettlements %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Stock/DeleteCustomerStorageAndForceFeeSettlement/" onclick="javascript:objMain.objWorkspace.objContent.deleteCustomerStorageAndForceFeeSettlement(this.href);return false;">
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
        <% Html.RenderPartial("SearchStorageAndForceFeeSettlementsCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5061, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    $("#formSearchStorageAndForceFeeSettlementsCondition #StartTime").val("");
                    $("#formSearchStorageAndForceFeeSettlementsCondition #EndTime").val("");
                    $("#formSearchStorageAndForceFeeSettlementsCondition #InvoiceNo").val("");
                    $("#formSearchStorageAndForceFeeSettlementsCondition #CustomerName").val("");

                    //打开查询条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除
            this.deleteCustomerStorageAndForceFeeSettlement = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5061, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    var id = $("#grid1").jqGrid("getGridParam", "selrow");
                    if (id == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCustomerStorageAndForceFeeSettlement %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteCustomerStorageAndForceFeeSettlementConfirm %>") == true) {
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
                                location.replace("/chenxk/Stock/SearchStorageAndForceFeeSettlements/");
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
            //创建结算记录表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    invoiceNo: "",
                    customerName: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.EndTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.InvoiceNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.InvoiceType %>",
                    "<%: InnoSoft.LS.Resources.Labels.InvoiceAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "StartTime", index: "StartTime", width: 80, align: "center" },
                    { name: "EndTime", index: "EndTime", width: 80, align: "center" },
                    { name: "InvoiceNo", index: "InvoiceNo", width: 120, align: "center" },
                    { name: "InvoiceType", index: "InvoiceType", width: 80, align: "center" },
                    { name: "InvoiceAmount", index: "InvoiceAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "Remark", index: "Remark", width: 400, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CustomerName",
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

            //创建查询条件录入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 250,
                width: 520,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearchStorageAndForceFeeSettlementsCondition").valid()) {
                            $(this).dialog("close");

                            //重新加载结算记录表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Stock/LoadSearchCustomerStorageAndForceFeeSettlementsGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearchStorageAndForceFeeSettlementsCondition #StartTime").val().trim(),
                                    endTime: $("#formSearchStorageAndForceFeeSettlementsCondition #EndTime").val().trim(),
                                    invoiceNo: $("#formSearchStorageAndForceFeeSettlementsCondition #InvoiceNo").val().trim(),
                                    customerName: $("#formSearchStorageAndForceFeeSettlementsCondition #CustomerName").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);
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
