<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SetReceiver %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/System/NewReceiver" onclick="javascript:objMain.objWorkspace.objContent.newReceiver(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.New%></a></li>
        <li><a href="/chenxk/System/ModifyReceiver/" onclick="javascript:objMain.objWorkspace.objContent.modifyReceiver(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/chenxk/System/DeleteReceiver/" onclick="javascript:objMain.objWorkspace.objContent.deleteReceiver(this.href);return false;">
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
    <div id="tabs">
        <ul>
            <li><a href="#tabDistances">
                <%: InnoSoft.LS.Resources.Tabs.DistanceList%></a></li>
        </ul>
        <div id="tabDistances">
            <div id="Grid2">
                <table id="grid2">
                </table>
                <div id="pager2">
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中收货单位编码
            this.selectedReceiverId = null;
            //表格1完成标志
            this.grid1Complete = false;
            //表格2完成标志
            this.grid2Complete = false;
            //自动选择定时器
            this.timerId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                var h1 = $("#divWorkspaceContent").height() / 2;

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", h1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);

                var h2 = $("#divWorkspaceContent").height() - h1;

                $("#tabs").css("height", (h2 - parseInt($("#tabs").css("border-top-width")) - parseInt($("#tabs").css("margin-top")) - parseInt($("#tabs").css("padding-top")) - parseInt($("#tabs").css("padding-bottom")) - parseInt($("#tabs").css("margin-bottom")) - parseInt($("#tabs").css("border-bottom-width"))) + "px");

                var w3 = parseInt($(".ui-tabs .ui-tabs-panel").css("width"));
                if (w3 == 0) {
                    w3 = $("#divWorkspaceContent").width() - parseInt($("#tabs").css("border-left-width")) - parseInt($("#tabs").css("margin-left")) - parseInt($("#tabs").css("padding-left")) - parseInt($(".ui-tabs .ui-tabs-nav").css("padding-left")) - parseInt($(".ui-tabs .ui-tabs-nav").css("padding-right")) - parseInt($("#tabs").css("padding-right")) - parseInt($("#tabs").css("margin-right")) - parseInt($("#tabs").css("border-right-width"));
                }
                var h3 = parseInt($("#tabs").css("height")) - parseInt($(".ui-tabs .ui-tabs-nav").css("border-top-width")) - parseInt($(".ui-tabs .ui-tabs-nav").css("padding-top")) - parseInt($(".ui-tabs .ui-tabs-nav").css("height")) - parseInt($(".ui-tabs .ui-tabs-nav").css("padding-bottom")) - parseInt($(".ui-tabs .ui-tabs-nav").css("border-bottom-width")) - parseInt($(".ui-tabs .ui-tabs-panel").css("padding-top")) - parseInt($(".ui-tabs .ui-tabs-panel").css("padding-bottom"));

                $("#grid2").jqGrid("setGridWidth", w3);
                $("#grid2").jqGrid("setGridHeight", h3 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //新增收货单位
            this.newReceiver = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9151, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace(action);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //修改收货单位
            this.modifyReceiver = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9151, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedReceiverId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedReceiver %>");
                        return;
                    }

                    location.replace(action + objMain.objWorkspace.objContent.selectedReceiverId);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除收货单位
            this.deleteReceiver = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9151, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedReceiverId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedReceiver %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteReceiverConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedReceiverId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                objMain.objWorkspace.objContent.grid1Complete = false;
                                $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                                objMain.objWorkspace.objContent.grid2Complete = false;
                                $("#grid2").trigger("reloadGrid", [{ page: 1}]);

                                objMain.objWorkspace.objContent.timerId = setInterval("selectReceiver();", 500);
                                objMain.objWorkspace.objContent.selectedReceiverId = null;
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
            //创建TAB控件
            $("#tabs").tabs();

            //创建收货单位表格
            $("#grid1").jqGrid({
                url: "/chenxk/System/LoadReceiversGrid/",
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverId %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.CountryName %>",
                    "<%: InnoSoft.LS.Resources.Labels.StateName %>",
                    "<%: InnoSoft.LS.Resources.Labels.CityName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Address %>",
                    "<%: InnoSoft.LS.Resources.Labels.ContactName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ContactTel %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "Name", index: "Name", width: 200 },
                    { name: "Country", index: "Country", width: 80, align: "center" },
                    { name: "Province", index: "Province", width: 120, align: "center" },
                    { name: "City", index: "City", width: 100, align: "center" },
                    { name: "Address", index: "Address", width: 300 },
                    { name: "Contact", index: "Contact", width: 80, align: "center" },
                    { name: "ContactTel", index: "ContactTel", width: 100, align: "center"}],
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
                    objMain.objWorkspace.objContent.selectedReceiverId = rowid;

                    //加载当前选中收货单位的距离数据
                    $("#grid2").jqGrid("setGridParam", {
                        url: "/chenxk/System/LoadReceiverDistancesGrid/",
                        postData: {
                            receiverId: objMain.objWorkspace.objContent.selectedReceiverId
                        }
                    });
                    $("#grid2").trigger("reloadGrid", [{ page: 1}]);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建收货单位距离表格
            $("#grid2").jqGrid({
                url: "/chenxk/System/LoadReceiverDistancesGrid/",
                datatype: "json",
                mtype: "GET",
                postData: {
                    receiverId: "0"
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartCountry %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartProvince %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartCity %>",
                    "<%: InnoSoft.LS.Resources.Labels.KM %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "StartCountry", index: "StartCountry", width: 80, align: "center" },
                    { name: "StartProvince", index: "StartProvince", width: 150, align: "center" },
                    { name: "StartCity", index: "StartCity", width: 100, align: "center" },
                    { name: "KM", index: "KM", width: 60, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "Id",
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

            $.unblockUI();
        });

        //默认选中第一个收货单位
        objMain.objWorkspace.objContent.timerId = setInterval("selectReceiver();", 500);
        function selectReceiver() {
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
