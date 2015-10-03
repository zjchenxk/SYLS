<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.PrintContracts %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Contract/PrintContract/" onclick="javascript:objMain.objWorkspace.objContent.print(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/062.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Print %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中合同编码
            this.selectedContractId = null;
            //调整布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //打印合同
            this.print = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4030, strPermission: "AllowPrint" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedContractId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedContract %>");
                        return;
                    }

                    location.replace(action + objMain.objWorkspace.objContent.selectedContractId);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //退回修改
            this.returnModify = function (id) {
                if (confirm("<%: InnoSoft.LS.Resources.Strings.ReturnModifyContractConfirm %>") == true) {
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

                    $.post("/chenxk/Contract/ReturnModifyContract/", { id: id }, function (ret) {
                        $.unblockUI();

                        if (ret != null && ret != "") {
                            alert(ret);
                        }
                        else {
                            //重新加载合同表格
                            objMain.objWorkspace.objContent.selectedContractId = null;

                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                        }
                    });

                }
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //生成待打印合同表格
            $("#grid1").jqGrid({
                url: "/chenxk/Contract/LoadPrintContractsGrid/",
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.ContractId %>",
                    "<%: InnoSoft.LS.Resources.Labels.ContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.OriginalContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarType %>",
                    "<%: InnoSoft.LS.Resources.Labels.DriverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.MobileTel %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalTunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalTransportCharges %>",
                    ""],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "ContractNo", index: "ContractNo", width: 100, align: "center" },
                    { name: "OriginalContractNo", index: "OriginalContractNo", width: 100, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 80, align: "center", hidden: true },
                    { name: "CarType", index: "CarType", width: 60, align: "center" },
                    { name: "DriverName", index: "DriverName", width: 100, align: "center" },
                    { name: "DriverMobileTel", index: "DriverMobileTel", width: 120, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "TotalTunnages", index: "TotalTunnages", width: 100, align: "center" },
                    { name: "TotalPiles", index: "TotalPiles", width: 100, align: "center" },
                    { name: "TotalTransportCharges", index: "TotalTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","}},
                    { name: "Actions", index: "Actions", width: 80, align: "center", sortable: false}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "ContractNo",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    var ids = $("#grid1").jqGrid("getDataIDs");
                    for (var i = 0; i < ids.length; i++) {
                        var s = "<input style='height:22px;width:75px;' type='button' value='<%: InnoSoft.LS.Resources.Buttons.ReturnModify %>' onclick='objMain.objWorkspace.objContent.returnModify(" + ids[i] + ");' />";
                        $("#grid1").jqGrid("setRowData", ids[i], { Actions: s });
                    }
                    objMain.objWorkspace.objContent.grid1Complete = true;
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedContractId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

        });

    </script>
</asp:Content>
