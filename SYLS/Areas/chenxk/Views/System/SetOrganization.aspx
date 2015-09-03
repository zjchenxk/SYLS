<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SetOrganization %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/System/NewOrganization" onclick="javascript:objMain.objWorkspace.objContent.newOrganization(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.New%></a></li>
        <li><a href="/chenxk/System/ModifyOrganization/" onclick="javascript:objMain.objWorkspace.objContent.modifyOrganization(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/chenxk/System/DeleteOrganization/" onclick="javascript:objMain.objWorkspace.objContent.deleteOrganization(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete%></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div style="text-align: center; margin-top: 10px;">
        <div id="container" style="display: inline-block;">
        </div>
        <div id="chart" style="display: inline-block;">
        </div>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中组织部门编码
            this.selectedOrganId = null;
            //调整工作内容布局
            this.resizeContent = function () {
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //新增组织部门
            this.newOrganization = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9010, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }
                    location.replace(action);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //修改组织部门
            this.modifyOrganization = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9010, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedOrganId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedOrgan %>");
                        return;
                    }
                    location.replace(action + objMain.objWorkspace.objContent.selectedOrganId);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除组织部门
            this.deleteOrganization = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9010, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedOrganId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedOrgan %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteOrganConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedOrganId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                location.replace("/chenxk/System/SetOrganization");
                            }
                        });
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

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

            //生成组织结构图
            $.get("/chenxk/System/LoadOrganizationsChart", function (ret) {
                $("#container").html(ret);

                $("#org").jOrgChart({
                    chartElement: "#chart"
                });

                $(".jOrgChart .node").click(function () {
                    var node = $(this);
                    var organId = node.find("input").val().trim();

                    //正常显示原选中的组织部门
                    if (objMain.objWorkspace.objContent.selectedOrganId != 0) {
                        $(".jOrgChart .node").each(function () {
                            if ($(this).find("input").val().trim() == objMain.objWorkspace.objContent.selectedOrganId) {
                                $(this).css("background-image", "url(/Content/redmond/images/ui-bg_gloss-wave_75_2191c0_500x100.png)");
                                $(this).css("border", "2px solid #77d5f7");
                                return false;
                            }
                        });
                    }

                    //突出显示选中的组织部门
                    node.css("background-image", "url(/Content/redmond/images/ui-bg_gloss-wave_45_e14f1c_500x100.png)");
                    node.css("border", "2px solid #e78f08");

                    objMain.objWorkspace.objContent.selectedOrganId = organId;
                });

                $.unblockUI();

            }).error(function (xhr, status, error) {
                $.unblockUI();
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "")
                    alert(xhr.responseText);
            });
        });

    </script>
</asp:Content>
