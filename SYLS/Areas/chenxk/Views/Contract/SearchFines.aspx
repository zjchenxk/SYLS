<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchFines %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Contract/DeleteContractFine/" onclick="javascript:objMain.objWorkspace.objContent.deleteContractFine(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete%></a></li>
        <li><a href="/chenxk/Contract/ExportFines/" onclick="javascript:objMain.objWorkspace.objContent.export(this.href);return false;">
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
    <div id="dialogSearch" title="">
        <form id="formSearch" action="">
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="StartTime">
                            <%: InnoSoft.LS.Resources.Labels.StartTime %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-regex="<%: InnoSoft.LS.Resources.Strings.NotValidDate %>"
                            data-val-regex-pattern="^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$"
                            id="StartTime" name="StartTime" type="text" value="" /><br />
                        <span class="field-validation-valid" data-valmsg-for="StartTime" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="EndTime">
                            <%: InnoSoft.LS.Resources.Labels.EndTime %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-regex="<%: InnoSoft.LS.Resources.Strings.NotValidDate %>"
                            data-val-regex-pattern="^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$"
                            id="EndTime" name="EndTime" type="text" value="" /><br />
                        <span class="field-validation-valid" data-valmsg-for="EndTime" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="StaffName">
                            <%: InnoSoft.LS.Resources.Labels.StaffName %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <select id="StaffName" name="StaffName" style="font-family: Arial;">
                            <option value=""></option>
                        </select><br />
                        <span class="field-validation-valid" data-valmsg-for="StaffName" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
        </table>
        </form>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询罚款记录
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4070, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    $("#formSearch #StartTime").val("");
                    $("#formSearch #EndTime").val("");
                    $("#formSearch #StaffName").get(0).selectedIndex = 0;

                    //打开查询条件输入对话框
                    $("#dialogSearch").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogSearch").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除罚款记录
            this.deleteContractFine = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4070, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    var id = $("#grid1").jqGrid("getGridParam", "selrow");
                    if (id == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedContractFine %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteContractFineConfirm %>") == true) {
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
                                location.replace("/chenxk/Contract/SearchFines/");
                            }
                        });
                    }

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //导出罚款记录
            this.export = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4070, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#grid1").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.ExportMustAfterSearch %>");
                        return;
                    }

                    var url = action + "?" +
                    "startTime=" + $("#formSearch #StartTime").val().trim() + "&" +
                    "endTime=" + $("#formSearch #EndTime").val().trim() + "&" +
                    "creatorId=" + $("#formSearch #StaffName").val().trim();

                    location.replace(url);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //创建罚款记录表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    creatorId: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.StaffName %>",
                    "<%: InnoSoft.LS.Resources.Labels.FineTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.ContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.OriginalContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.FineAmount %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CreatorName", index: "CreatorName", width: 80, align: "center" },
                    { name: "FineTime", index: "FineTime", width: 80, align: "center" },
                    { name: "ContractNo", index: "ContractNo", width: 100, align: "center" },
                    { name: "OriginalContractNo", index: "OriginalContractNo", width: 100, align: "center" },
                    { name: "FineAmount", index: "FineAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "FineTime",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                grouping: true,
                groupingView: {
                    groupField: ["CreatorName"],
                    groupSummary: [true],
                    groupColumnShow: [true],
                    groupText: ["<b>{0}</b>"],
                    groupCollapse: false,
                    groupOrder: ["asc"]
                },
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建查询条件录入对话框
            $("#dialogSearch").dialog({
                autoOpen: false,
                height: 250,
                width: 520,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearch").valid()) {
                            $(this).dialog("close");

                            //重新加载罚款记录表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Contract/LoadSearchContractFinesGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearch #StartTime").val().trim(),
                                    endTime: $("#formSearch #EndTime").val().trim(),
                                    creatorId: $("#formSearch #StaffName").val().trim()
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

            //设置起止时间
            $("#formSearch #StartTime").datepicker($.datepicker.regional["zh-CN"]);
            $("#formSearch #EndTime").datepicker($.datepicker.regional["zh-CN"]);

            //设置员工下拉列表
            $.get("/Common/LoadStaffs", function (ret) {
                if (ret.length > 0) {
                    $.each(ret, function (i, staff) {
                        var option = $("<option></option>").val(staff.Id).text(staff.FullName);
                        option.appendTo($("#formSearch #StaffName"));
                    });
                }
            }, "text json").error(function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

    </script>
</asp:Content>
