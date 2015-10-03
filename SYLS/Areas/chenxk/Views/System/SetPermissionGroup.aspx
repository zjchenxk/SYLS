<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SetPermissionGroup %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/System/NewPermissionGroup" onclick="javascript:objMain.objWorkspace.objContent.newPermissionGroup(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.New%></a></li>
        <li><a href="/chenxk/System/ModifyPermissionGroup/" onclick="javascript:objMain.objWorkspace.objContent.modifyPermissionGroup(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/chenxk/System/DeletePermissionGroup/" onclick="javascript:objMain.objWorkspace.objContent.deletePermissionGroup(this.href);return false;">
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
    <div id="Grid2" style="margin-top: 1px;">
        <table id="grid2">
        </table>
        <div id="pager2">
        </div>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中组编码
            this.selectedGroupId = null;
            //表格1加载完成标志
            this.grid1Complete = false;
            //表格2加载完成标志
            this.grid2Complete = false;
            //自动选择定时器
            this.timerId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                var h1 = $("#divWorkspaceContent").height() / 3;
                var h2 = $("#divWorkspaceContent").height() - h1;

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", h1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
                $("#grid2").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid2").jqGrid("setGridHeight", h2 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //新增权限组
            this.newPermissionGroup = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9060, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace(action);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //修改权限组
            this.modifyPermissionGroup = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9060, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedGroupId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedPermissionGroup %>");
                        return;
                    }

                    location.replace(action + objMain.objWorkspace.objContent.selectedGroupId);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除权限组
            this.deletePermissionGroup = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9060, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedGroupId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedPermissionGroup %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeletePermissionGroupConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedGroupId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                objMain.objWorkspace.objContent.grid1Complete = false;
                                $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                                objMain.objWorkspace.objContent.timerId = setInterval("selectGroup();", 500);
                                objMain.objWorkspace.objContent.selectedGroupId = null;
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
            //生成组表格
            $("#grid1").jqGrid({
                url: "/chenxk/System/LoadPermissionGroupsGrid/",
                datatype: "json",
                mtype: "GET",
                colNames: ["<%: InnoSoft.LS.Resources.Labels.GroupId %>", "<%: InnoSoft.LS.Resources.Labels.GroupName %>", "<%: InnoSoft.LS.Resources.Labels.Remark %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "Name", index: "Name", width: 200 },
                    { name: "Remark", index: "Remark", width: 400, sortable: false}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "Id",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid1Complete = true;
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedGroupId = rowid;
                    $("#grid2").jqGrid("setGridParam", {
                        url: "/chenxk/System/LoadGroupPermissionsGrid/" + objMain.objWorkspace.objContent.selectedGroupId
                    });
                    $("#grid2").trigger("reloadGrid", [{ page: 1}]);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //生成组权限表格
            $("#grid2").jqGrid({
                url: "/chenxk/System/LoadGroupPermissionsGrid/" + "0",
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.FuncId %>",
                    "<%: InnoSoft.LS.Resources.Labels.FuncName %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllowOpen %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllowNew %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllowModify %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllowDelete %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllowCancel %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllowDetail %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllowSearch %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllowSubmit %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllowApprove %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllowDispatch %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllowExport %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllowImport %>",
                    "<%: InnoSoft.LS.Resources.Labels.AllowPrint %>"],
                colModel: [
                    { name: "FuncId", index: "FuncId", width: 100 },
                    { name: "FuncName", index: "FuncName", width: 200 },
                    { name: "AllowOpen", index: "AllowOpen", width: 60, sortable: false, align: "center", formatter: "checkbox" },
                    { name: "AllowNew", index: "AllowNew", width: 60, sortable: false, align: "center", formatter: "checkbox" },
                    { name: "AllowModify", index: "AllowModify", width: 60, sortable: false, align: "center", formatter: "checkbox" },
                    { name: "AllowDelete", index: "AllowDelete", width: 60, sortable: false, align: "center", formatter: "checkbox" },
                    { name: "AllowCancel", index: "AllowCancel", width: 90, sortable: false, align: "center", formatter: "checkbox" },
                    { name: "AllowDetail", index: "AllowDetail", width: 80, sortable: false, align: "center", formatter: "checkbox" },
                    { name: "AllowSearch", index: "AllowSearch", width: 60, sortable: false, align: "center", formatter: "checkbox" },
                    { name: "AllowSubmit", index: "AllowSubmit", width: 60, sortable: false, align: "center", formatter: "checkbox" },
                    { name: "AllowApprove", index: "AllowApprove", width: 60, sortable: false, align: "center", formatter: "checkbox" },
                    { name: "AllowDispatch", index: "AllowDispatch", width: 60, sortable: false, align: "center", formatter: "checkbox" },
                    { name: "AllowExport", index: "AllowExport", width: 60, sortable: false, align: "center", formatter: "checkbox" },
                    { name: "AllowImport", index: "AllowImport", width: 60, sortable: false, align: "center", formatter: "checkbox" },
                    { name: "AllowPrint", index: "AllowPrint", width: 60, sortable: false, align: "center", formatter: "checkbox"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "FuncId",
                sortorder: "asc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid2Complete = true;
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

        });

        //默认选中第一个权限组
        objMain.objWorkspace.objContent.timerId = setInterval("selectGroup();", 500);
        function selectGroup() {
            if (objMain.objWorkspace.objContent.grid1Complete && objMain.objWorkspace.objContent.grid2Complete) {
                clearInterval(objMain.objWorkspace.objContent.timerId);

                if ($("#grid1").jqGrid("getGridParam", "records") > 0) {
                    var rowid = $("#grid1").jqGrid("getRowData")[0].Id;
                    $("#grid1").jqGrid("setSelection", rowid, true);
                }
                else {
                    $("#grid2").jqGrid("clearGridData", false);
                }
            }
        }

    </script>
</asp:Content>
