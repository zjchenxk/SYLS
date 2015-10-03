<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.PermissionGroupViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.NewPermissionGroup %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/System/SetPermissionGroup/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.savePermissionGroup();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("NewPermissionGroup", "System", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.BasicInfo %></legend>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Name)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Name)%>
                        <%: Html.ValidationMessageFor(model => model.Name)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Remark)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Remark)%>
                        <%: Html.ValidationMessageFor(model => model.Remark)%>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.FunctionList %></legend>
        <div id="Grid">
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
    </fieldset>
    <% } %>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                var h = $("#divWorkspaceContent").height();
                var o1 = $("fieldset:first").outerHeight(true);
                var h1 = $("fieldset:first").height();
                var h2 = h - o1 - (o1 - h1);

                $("fieldset:last").css("height", h2 + "px");

                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("fieldset:last").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - 8);
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认名称获得焦点
                $("#Name").focus().select();
            };
            //保存数据
            this.savePermissionGroup = function () {
                $('#form1').submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //生成组表格
            $("#grid1").jqGrid({
                url: "/chenxk/System/LoadFunctionsGrid/",
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
                    { name: "Id", index: "Id", width: 100 },
                    { name: "Name", index: "Name", width: 200 },
                    { name: "AllowOpen", index: "AllowOpen", width: 60, align: "center", sortable: false, editable: true, edittype: "checkbox", editoptions: { value: "O:X"} },
                    { name: "AllowNew", index: "AllowNew", width: 60, align: "center", sortable: false, editable: true, edittype: "checkbox", editoptions: { value: "O:X"} },
                    { name: "AllowModify", index: "AllowModify", width: 60, align: "center", sortable: false, editable: true, edittype: "checkbox", editoptions: { value: "O:X"} },
                    { name: "AllowDelete", index: "AllowDelete", width: 60, align: "center", sortable: false, editable: true, edittype: "checkbox", editoptions: { value: "O:X"} },
                    { name: "AllowCancel", index: "AllowCancel", width: 90, align: "center", sortable: false, editable: true, edittype: "checkbox", editoptions: { value: "O:X"} },
                    { name: "AllowDetail", index: "AllowDetail", width: 80, align: "center", sortable: false, editable: true, edittype: "checkbox", editoptions: { value: "O:X"} },
                    { name: "AllowSearch", index: "AllowSearch", width: 60, align: "center", sortable: false, editable: true, edittype: "checkbox", editoptions: { value: "O:X"} },
                    { name: "AllowSubmit", index: "AllowSubmit", width: 60, align: "center", sortable: false, editable: true, edittype: "checkbox", editoptions: { value: "O:X"} },
                    { name: "AllowApprove", index: "AllowApprove", width: 60, align: "center", sortable: false, editable: true, edittype: "checkbox", editoptions: { value: "O:X"} },
                    { name: "AllowDispatch", index: "AllowDispatch", width: 60, align: "center", sortable: false, editable: true, edittype: "checkbox", editoptions: { value: "O:X"} },
                    { name: "AllowExport", index: "AllowExport", width: 60, align: "center", sortable: false, editable: true, edittype: "checkbox", editoptions: { value: "O:X"} },
                    { name: "AllowImport", index: "AllowImport", width: 60, align: "center", sortable: false, editable: true, edittype: "checkbox", editoptions: { value: "O:X"} },
                    { name: "AllowPrint", index: "AllowPrint", width: 60, align: "center", sortable: false, editable: true, edittype: "checkbox", editoptions: { value: "O:X"}}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "Id",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                cellEdit: true,
                cellsubmit: "clientArray",
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                afterInsertRow: function (rowid, rowdata, rowelem) {
                    if (rowdata.AllowOpen == "X") {
                        $("#grid1").jqGrid("setCell", rowid, "AllowOpen", "", { color: "LightGray" });
                    }
                    if (rowdata.AllowNew == "X") {
                        $("#grid1").jqGrid("setCell", rowid, "AllowNew", "", { color: "LightGray" });
                    }
                    if (rowdata.AllowModify == "X") {
                        $("#grid1").jqGrid("setCell", rowid, "AllowModify", "", { color: "LightGray" });
                    }
                    if (rowdata.AllowDelete == "X") {
                        $("#grid1").jqGrid("setCell", rowid, "AllowDelete", "", { color: "LightGray" });
                    }
                    if (rowdata.AllowCancel == "X") {
                        $("#grid1").jqGrid("setCell", rowid, "AllowCancel", "", { color: "LightGray" });
                    }
                    if (rowdata.AllowDetail == "X") {
                        $("#grid1").jqGrid("setCell", rowid, "AllowDetail", "", { color: "LightGray" });
                    }
                    if (rowdata.AllowSearch == "X") {
                        $("#grid1").jqGrid("setCell", rowid, "AllowSearch", "", { color: "LightGray" });
                    }
                    if (rowdata.AllowSubmit == "X") {
                        $("#grid1").jqGrid("setCell", rowid, "AllowSubmit", "", { color: "LightGray" });
                    }
                    if (rowdata.AllowApprove == "X") {
                        $("#grid1").jqGrid("setCell", rowid, "AllowApprove", "", { color: "LightGray" });
                    }
                    if (rowdata.AllowDispatch == "X") {
                        $("#grid1").jqGrid("setCell", rowid, "AllowDispatch", "", { color: "LightGray" });
                    }
                    if (rowdata.AllowExport == "X") {
                        $("#grid1").jqGrid("setCell", rowid, "AllowExport", "", { color: "LightGray" });
                    }
                    if (rowdata.AllowImport == "X") {
                        $("#grid1").jqGrid("setCell", rowid, "AllowImport", "", { color: "LightGray" });
                    }
                    if (rowdata.AllowPrint == "X") {
                        $("#grid1").jqGrid("setCell", rowid, "AllowPrint", "", { color: "LightGray" });
                    }
                },
                beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
                    //检查数据库配置中当前选中功能权限是否有效
                    $.get("/Common/LoadFunctionPermission", { strFuncId: rowid, strPermission: cellname }, function (ret) {
                        if (ret == false) {
                            $("#grid1").jqGrid("editCell", iRow, iCol, false);
                        }
                    }, "text json").error(function (xhr, status, error) {
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                },
                afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
                    if (cellname == "AllowOpen" && value == "X") {
                        $("#grid1").jqGrid("setRowData", rowid, { AllowNew: "X", AllowModify: "X", AllowDelete: "X", AllowCancel: "X", AllowDetail: "X", AllowSearch: "X", AllowSubmit: "X", AllowApprove: "X", AllowDispatch: "X", AllowExport: "X", AllowImport: "X", AllowPrint: "X" });
                    }
                    if (cellname != "AllowOpen" && value == "O") {
                        $("#grid1").jqGrid("setRowData", rowid, { AllowOpen: "O" });
                    }
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //提交事件
            $('#form1').submit(function () {
                if ($(this).valid()) {
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

                    //读取所有权限数据
                    var rows = $("#grid1").jqGrid("getRowData");
                    var functions = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var f = { "Id": row.Id, "Name": row.Name, "AllowOpen": row.AllowOpen == "O", "AllowNew": row.AllowNew == "O", "AllowModify": row.AllowModify == "O", "AllowDelete": row.AllowDelete == "O", "AllowCancel": row.AllowCancel == "O", "AllowDetail": row.AllowDetail == "O", "AllowSearch": row.AllowSearch == "O", "AllowSubmit": row.AllowSubmit == "O", "AllowApprove": row.AllowApprove == "O", "AllowDispatch": row.AllowDispatch == "O", "AllowExport": row.AllowExport == "O", "AllowImport": row.AllowImport == "O", "AllowPrint": row.AllowPrint == "O" };
                        functions.push(f);
                    }

                    //生成JSON数据
                    var o = { "Id": 0, "Name": $("#Name").val().trim(), "Remark": $("#Remark").val().trim(), "Functions": functions };
                    var postData = JSON.stringify(o);

                    //发送数据
                    $.ajax({
                        type: "POST",
                        url: $(this).attr('action'),
                        data: postData,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                location.replace("/chenxk/System/SetPermissionGroup/");
                            }
                        },
                        error: function (xhr, status, error) {
                            $.unblockUI();

                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        }
                    });
                }
                return false;
            });
        });

    </script>
</asp:Content>
