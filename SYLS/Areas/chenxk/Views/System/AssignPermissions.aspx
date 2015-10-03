<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.AssignPermissions %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveAccountPermission();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
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
            //当前选中帐号编码
            this.selectedAccountId = null;
            //表格1完成标志
            this.grid1Complete = false;
            //表格2完成标志
            this.grid2Complete = false;
            //表格2改变事件
            this.grid2Change = false;
            //自动选择定时器
            this.timerId = null;
            //调整布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                var h1 = $("#divWorkspaceContent").height() / 2;
                var h2 = $("#divWorkspaceContent").height() - h1;

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", h1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
                $("#grid2").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid2").jqGrid("setGridHeight", h2 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //保存数据
            this.saveAccountPermission = function () {
                if (objMain.objWorkspace.objContent.selectedAccountId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedAccount %>");
                    return;
                }

                //读取所有选中的权限数据
                var ids = $("#grid2").jqGrid("getGridParam", "selarrrow");
                var groups = new Array();
                for (var i = 0; i < ids.length; i++) {
                    var exists = false;
                    for (var j = 0; j < groups.length; j++) {
                        if (groups[j].Id == ids[i]) {
                            exists = true;
                            break;
                        }
                    }
                    if (exists == false) {
                        var g = { "Id": ids[i], "Name": "", "Remark": "" };
                        groups.push(g);
                    }
                }

                //生成JSON数据
                var o = { "AccountId": objMain.objWorkspace.objContent.selectedAccountId, "Groups": groups };
                var postData = JSON.stringify(o);

                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9070, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        objMain.objWorkspace.objContent.grid2Change = false;
                        return;
                    }

                    //发送数据
                    $.ajax({
                        type: "POST",
                        url: "/chenxk/System/AssignPermissions",
                        data: postData,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceed %>");
                            }

                            objMain.objWorkspace.objContent.grid2Change = false;
                        },
                        error: function (xhr, status, error) {
                            $.unblockUI();

                            objMain.objWorkspace.objContent.grid2Change = false;

                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        }
                    });
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
                url: "/chenxk/System/LoadActiveAccountsGrid/",
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.AccountId %>",
                    "<%: InnoSoft.LS.Resources.Labels.AccountName %>",
                    "<%: InnoSoft.LS.Resources.Labels.AccountType %>",
                    "<%: InnoSoft.LS.Resources.Labels.AccountOrganName %>",
                    "<%: InnoSoft.LS.Resources.Labels.AccountStaffName %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "Name", index: "Name", width: 80, align: "center" },
                    { name: "AccountType", index: "AccountType", width: 80, align: "center" },
                    { name: "OrganFullName", index: "OrganFullName", width: 400 },
                    { name: "StaffName", index: "StaffName", width: 200, align: "center"}],
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
                beforeSelectRow: function (rowid, e) {
                    if (objMain.objWorkspace.objContent.grid2Change) {
                        if (confirm("<%: InnoSoft.LS.Resources.Strings.SaveAccountPermissionConfirm %>") == true) {
                            objMain.objWorkspace.objContent.saveAccountPermission();
                        }
                        else {
                            objMain.objWorkspace.objContent.grid2Change = false;
                        }
                    }
                    return true;
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedAccountId = rowid;
                    //加载当前选中帐号的权限数据
                    $("#grid2").jqGrid("resetSelection");
                    $.get("/chenxk/System/LoadAccountPermissions", {
                        nAccountId: objMain.objWorkspace.objContent.selectedAccountId
                    }, function (ret) {
                        $.each(ret, function (i, group) {
                            var ind = $("#grid2").jqGrid("getInd", group.GroupId);
                            if (ind > 0) {
                                $("#grid2").jqGrid("setSelection", group.GroupId, false);
                            }
                        });
                    }, "text json").error(function (xhr, status, error) {
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //生成组权限表格
            $("#grid2").jqGrid({
                url: "/chenxk/System/LoadPermissionGroupsGrid/",
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.GroupId %>",
                    "<%: InnoSoft.LS.Resources.Labels.GroupName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "Name", index: "Name", width: 200 },
                    { name: "Remark", index: "Remark", width: 400, sortable: false}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "Id",
                sortorder: "asc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                multiselect: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid2Complete = true;
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.grid2Change = true;
                },
                onSelectAll: function (aRowids, status) {
                    objMain.objWorkspace.objContent.grid2Change = true;
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

        });

        //默认选中第一个帐号
        objMain.objWorkspace.objContent.timerId = setInterval("selectAccount();", 500);
        function selectAccount() {
            if (objMain.objWorkspace.objContent.grid1Complete && objMain.objWorkspace.objContent.grid2Complete) {
                clearInterval(objMain.objWorkspace.objContent.timerId);

                if ($("#grid1").jqGrid("getGridParam", "records") > 0) {
                    var rowid = $("#grid1").jqGrid("getRowData")[0].Id;
                    $("#grid1").jqGrid("setSelection", rowid, true);
                }
            }
        }

    </script>
</asp:Content>
