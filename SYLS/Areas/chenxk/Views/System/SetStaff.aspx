<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SetStaff %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/System/NewStaff" onclick="javascript:objMain.objWorkspace.objContent.newStaff(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.New%></a></li>
        <li><a href="/chenxk/System/ModifyStaff/" onclick="javascript:objMain.objWorkspace.objContent.modifyStaff(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/chenxk/System/DeleteStaff/" onclick="javascript:objMain.objWorkspace.objContent.deleteStaff(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete%></a></li>
        <li><a href="/chenxk/System/ExportStaffs/" onclick="javascript:objMain.objWorkspace.objContent.exportStaffs(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/049.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Export%></a></li>
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
            //当前选中员工编码
            this.selectedStaffId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //新增员工
            this.newStaff = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9030, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace(action);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //修改员工
            this.modifyStaff = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9030, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedStaffId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedStaff %>");
                        return;
                    }

                    location.replace(action + objMain.objWorkspace.objContent.selectedStaffId);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除员工
            this.deleteStaff = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9030, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedStaffId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedStaff %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteStaffConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedStaffId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                                objMain.objWorkspace.objContent.selectedStaffId = null;
                            }
                        });
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //查看员工详细信息
            this.viewStaffDetails = function (rowid) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9030, strPermission: "AllowDetail" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace("/chenxk/System/ViewStaffDetails/" + rowid);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //导出员工
            this.exportStaffs = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9030, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace(action);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            $("#grid1").jqGrid({
                url: "/chenxk/System/LoadStaffsGrid/",
                datatype: "json",
                mtype: "GET",
                colNames: ["<%: InnoSoft.LS.Resources.Labels.StaffId %>", "<%: InnoSoft.LS.Resources.Labels.StaffName %>", "<%: InnoSoft.LS.Resources.Labels.Sex %>", "<%: InnoSoft.LS.Resources.Labels.OrganName %>", "<%: InnoSoft.LS.Resources.Labels.PositionName %>", "<%: InnoSoft.LS.Resources.Labels.BossName %>", "<%: InnoSoft.LS.Resources.Labels.Tel %>", "<%: InnoSoft.LS.Resources.Labels.TelExt %>", "<%: InnoSoft.LS.Resources.Labels.MobileTel %>", "<%: InnoSoft.LS.Resources.Labels.QQ %>", ""],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "FullName", index: "FullName", width: 80, align: "center" },
                    { name: "Sex", index: "Sex", width: 50, align: "center" },
                    { name: "OrganFullName", index: "OrganName", width: 300 },
                    { name: "PositionName", index: "PositionName", width: 150, align: "center" },
                    { name: "BossStaffName", index: "BossStaffName", width: 80, align: "center" },
                    { name: "OfficeTel", index: "OfficeTel", width: 120 },
                    { name: "TelExt", index: "TelExt", width: 60 },
                    { name: "MobileTel1", index: "MobileTel1", width: 100 },
                    { name: "QQ", index: "QQ", width: 100 },
                    { name: "Actions", index: "Actions", width: 80, align: "center", sortable: false}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "OrganFullName",
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
                        var s = "<input style='height:22px;width:60px;' type='button' value='<%: InnoSoft.LS.Resources.Buttons.View %>' onclick='objMain.objWorkspace.objContent.viewStaffDetails(" + ids[i] + ");' />";
                        $("#grid1").jqGrid("setRowData", ids[i], { Actions: s });
                    }
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedStaffId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

        });

    </script>
</asp:Content>
