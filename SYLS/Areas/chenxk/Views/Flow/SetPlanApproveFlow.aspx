<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SetPlanApproveFlow %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Flow/NewPlanApproveStep" onclick="javascript:objMain.objWorkspace.objContent.newPlanApproveStep(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.New%></a></li>
        <li><a href="/chenxk/Flow/ModifyPlanApproveStep/" onclick="javascript:objMain.objWorkspace.objContent.modifyPlanApproveStep(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/chenxk/Flow/DeletePlanApproveStep/" onclick="javascript:objMain.objWorkspace.objContent.deletePlanApproveStep(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete%></a></li>
        <li><a href="/chenxk/Flow/MoveUpPlanApproveStep/" onclick="javascript:objMain.objWorkspace.objContent.moveUpPlanApproveStep(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/036.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.MoveUp%></a></li>
        <li><a href="/chenxk/Flow/MoveDownPlanApproveStep/" onclick="javascript:objMain.objWorkspace.objContent.moveDownPlanApproveStep(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/035.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.MoveDown%></a></li>
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
            //当前选中步骤编码
            this.selectedStepId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //新增步骤
            this.newPlanApproveStep = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9071, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace(action);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //修改步骤
            this.modifyPlanApproveStep = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9071, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedStepId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedApproveFlowStep %>");
                        return;
                    }

                    location.replace(action + objMain.objWorkspace.objContent.selectedStepId);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除步骤
            this.deletePlanApproveStep = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9071, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedStepId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedApproveFlowStep %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteApproveFlowStepConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedStepId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                                objMain.objWorkspace.objContent.selectedStepId = null;
                            }
                        });
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //上移审批步骤
            this.moveUpPlanApproveStep = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9071, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedStepId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedApproveFlowStep %>");
                        return;
                    }

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

                    $.post(action, { id: objMain.objWorkspace.objContent.selectedStepId }, function (ret) {
                        $.unblockUI();

                        if (ret != null && ret != "") {
                            alert(ret);
                        }
                        else {
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                            objMain.objWorkspace.objContent.selectedStepId = null;
                        }
                    });
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //下移审批步骤
            this.moveDownPlanApproveStep = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9071, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedStepId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedApproveFlowStep %>");
                        return;
                    }

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

                    $.post(action, { id: objMain.objWorkspace.objContent.selectedStepId }, function (ret) {
                        $.unblockUI();

                        if (ret != null && ret != "") {
                            alert(ret);
                        }
                        else {
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                            objMain.objWorkspace.objContent.selectedStepId = null;
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

            $("#grid1").jqGrid({
                url: "/chenxk/Flow/LoadPlanApproveStepsGrid/",
                datatype: "json",
                mtype: "GET",
                colNames: ["<%: InnoSoft.LS.Resources.Labels.StepId %>", "<%: InnoSoft.LS.Resources.Labels.StepNum %>", "<%: InnoSoft.LS.Resources.Labels.StepName %>", "<%: InnoSoft.LS.Resources.Labels.DisposerName %>", "<%: InnoSoft.LS.Resources.Labels.Conditions %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "StepNum", index: "StepNum", width: 80, align: "center" },
                    { name: "StepName", index: "StepName", width: 150, align: "center" },
                    { name: "DisposerName", index: "DisposerName", width: 100, align: "center" },
                    { name: "Conditions", index: "Conditions", width: 500, sortable: false}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "StepNum",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedStepId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            $.unblockUI();
        });

    </script>
</asp:Content>
