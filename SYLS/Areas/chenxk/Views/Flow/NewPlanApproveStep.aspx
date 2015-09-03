<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.ApproveFlowStepViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.NewPlanApproveStep %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Flow/SetPlanApproveFlow/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveFlow();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("NewPlanApproveStep", "Flow", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.BasicInfo %></legend>
        <%: Html.HiddenFor(model => model.StepNum)%>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.StepName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.StepName) %>
                        <%: Html.ValidationMessageFor(model => model.StepName) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DisposerId) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.DisposerId, ViewData["Disposers"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.DisposerId) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ConditionExpression) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ConditionExpression) %>
                        <%: Html.ValidationMessageFor(model => model.ConditionExpression) %>
                        <%: InnoSoft.LS.Resources.Strings.ConditionExpression %>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.ConditionList %></legend>
        <div>
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnNewCondition" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.New %>
            </button>
            <button id="btnModifyCondition" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
            <button id="btnDeleteCondition" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <% } %>
    <div id="dialogConditions" title="">
        <% Html.RenderPartial("PlanApproveFlowStepCondition", Model.Conditions[0]); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //新增条件标志
            this.isNewCondition = true;
            //当前选中条件记录编码
            this.selectedConditionId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认步骤名称获得焦点
                $("#form1 #StepName").focus().select();
            };
            //新增条件信息
            this.newCondition = function () {
                //设置编辑模式为新增
                this.isNewCondition = true;

                //初始化控件数据
                $("#formPlanApproveFlowStepCondition #FieldValue").val("");

                //打开对话框
                $("#dialogConditions").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewApproveFlowStepCondition %>");
                $("#dialogConditions").dialog("open");
            };
            //修改条件信息
            this.modifyCondition = function () {
                //读取选中的条件记录
                if (this.selectedConditionId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedApproveFlowStepCondition %>");
                    return;
                }
                var data = $("#grid1").jqGrid("getRowData", this.selectedConditionId);

                //初始化控件数据
                $("#formPlanApproveFlowStepCondition #FieldName").val(data.FieldName);
                $("#formPlanApproveFlowStepCondition #CompareOperator").val(data.CompareOperator);
                $("#formPlanApproveFlowStepCondition #FieldValue").val(data.FieldValue);

                //设置编辑模式为修改
                this.isNewCondition = false;

                //打开对话框
                $("#dialogConditions").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyApproveFlowStepCondition %>");
                $("#dialogConditions").dialog("open");
            };
            //删除条件信息
            this.deleteCondition = function () {
                if (this.selectedConditionId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedApproveFlowStepCondition %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteApproveFlowStepConditionConfirm %>") == true) {
                    //debugger;
                    //获取当前选中条件在列表中的索引
                    var ind = $("#grid1").jqGrid("getInd", this.selectedConditionId);
                    var rowids = $("#grid1").jqGrid("getDataIDs");
                    //删除选中的条件
                    $("#grid1").jqGrid("delRowData", this.selectedConditionId);
                    this.selectedConditionId = null;
                    //修改其它条件的序号
                    var rowcount = $("#grid1").jqGrid("getGridParam", "records");
                    while (ind <= rowcount) {
                        $("#grid1").jqGrid("setRowData", rowids[ind], { ConditionNum: ind });
                        ind++;
                    }
                }
            };
            //保存数据
            this.saveFlow = function () {
                $("#form1").submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //创建条件表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                colNames: ["<%: InnoSoft.LS.Resources.Labels.ConditionNum %>", "<%: InnoSoft.LS.Resources.Labels.FieldName %>", "<%: InnoSoft.LS.Resources.Labels.CompareOperator %>", "<%: InnoSoft.LS.Resources.Labels.FieldValue %>"],
                colModel: [
                    { name: "ConditionNum", index: "ConditionNum", width: 80, align: "center" },
                    { name: "FieldName", index: "FieldName", width: 100, align: "center" },
                    { name: "CompareOperator", index: "CompareOperator", width: 80, align: "center" },
                    { name: "FieldValue", index: "FieldValue", width: 200, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedConditionId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //新增条件按钮点击事件
            $("#btnNewCondition").button().click(function () {
                objMain.objWorkspace.objContent.newCondition();
            });

            //修改条件按钮点击事件
            $("#btnModifyCondition").button().click(function () {
                objMain.objWorkspace.objContent.modifyCondition();
            });

            //删除条件按钮点击事件
            $("#btnDeleteCondition").button().click(function () {
                objMain.objWorkspace.objContent.deleteCondition();
            });

            //创建条件编辑对话框
            $("#dialogConditions").dialog({
                autoOpen: false,
                height: 250,
                width: 520,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formPlanApproveFlowStepCondition").valid()) {
                            //debugger;
                            //新增条件信息
                            if (objMain.objWorkspace.objContent.isNewCondition) {
                                var rowcount = $("#grid1").jqGrid("getGridParam", "records");
                                if (rowcount == 0) {
                                    $("#grid1").jqGrid("addRowData", 1, { ConditionNum: 1, FieldName: $("#formPlanApproveFlowStepCondition #FieldName").val().trim(), CompareOperator: $("#formPlanApproveFlowStepCondition #CompareOperator").val().trim(), FieldValue: $("#formPlanApproveFlowStepCondition #FieldValue").val().trim() });
                                }
                                else {
                                    var rowids = $("#grid1").jqGrid("getDataIDs");
                                    var rowidLast = rowids[rowcount - 1];

                                    $("#grid1").jqGrid("addRowData", parseFloat(rowidLast) + 1, { ConditionNum: rowcount + 1, FieldName: $("#formPlanApproveFlowStepCondition #FieldName").val().trim(), CompareOperator: $("#formPlanApproveFlowStepCondition #CompareOperator").val().trim(), FieldValue: $("#formPlanApproveFlowStepCondition #FieldValue").val().trim() });
                                }
                            }
                            //修改条件信息
                            else {
                                $("#grid1").jqGrid("setRowData", objMain.objWorkspace.objContent.selectedConditionId, { FieldName: $("#formPlanApproveFlowStepCondition #FieldName").val().trim(), CompareOperator: $("#formPlanApproveFlowStepCondition #CompareOperator").val().trim(), FieldValue: $("#formPlanApproveFlowStepCondition #FieldValue").val().trim() });
                            }
                            $(this).dialog("close");
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

            //提交事件
            $("#form1").submit(function () {
                if ($(this).valid()) {
                    $.blockUI({
                        message: '<h1><img src="<%=Url.Content("~/Content/busy.gif")%>" /><%: InnoSoft.LS.Resources.Strings.PleaseWait %></h1>',
                        css: {
                            border: "none",
                            padding: "15px",
                            backgroundColor: "#000",
                            "-webkit-border-radius": "10px",
                            "-moz-border-radius": "10px",
                            opacity: .5,
                            color: "#fff"
                        }
                    });

                    //获取所有条件数据
                    var rows = $("#grid1").jqGrid("getRowData");
                    var conditions = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var c = { "Id": 0, "ConditionNum": row.ConditionNum, "FieldName": row.FieldName, "CompareOperator": row.CompareOperator, "FieldValue": row.FieldValue };
                        conditions.push(c);
                    }

                    //生成JSON数据
                    var o = { "Id": 0, "StepNum": $("#form1 #StepNum").val().trim(), "StepName": $("#form1 #StepName").val().trim(), "DisposerId": $("#form1 #DisposerId").val().trim(), "ConditionExpression": $("#form1 #ConditionExpression").val().trim(), "Conditions": conditions };
                    var postData = JSON.stringify(o);

                    //发送数据
                    $.ajax({
                        type: "POST",
                        url: $(this).attr("action"),
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
                                location.replace("/chenxk/Flow/SetPlanApproveFlow/");
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
