<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchReverses %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Contract/DeleteContractReverse/" onclick="javascript:objMain.objWorkspace.objContent.deleteContractReverse(this.href);return false;">
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
    <div id="dialogSearch" title="">
        <form id="formSearch" action="">
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="StartTime">
                            <%: InnoSoft.LS.Resources.Labels.StartTime%></label>
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
                        <label for="ContractNo">
                            <%: InnoSoft.LS.Resources.Labels.ContractNo %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-length="<%: InnoSoft.LS.Resources.Strings.ContractNoMaxLengthIs20 %>"
                            data-val-length-max="20" id="ContractNo" name="ContractNo" type="text" value="" /><br />
                        <span class="field-validation-valid" data-valmsg-for="ContractNo" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="OriginalContractNo">
                            <%: InnoSoft.LS.Resources.Labels.OriginalContractNo%></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-length="<%: InnoSoft.LS.Resources.Strings.OriginalContractNoMaxLengthIs20 %>"
                            data-val-length-max="20" id="OriginalContractNo" name="OriginalContractNo" type="text"
                            value="" /><br />
                        <span class="field-validation-valid" data-valmsg-for="OriginalContractNo" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="ReverserName">
                            <%: InnoSoft.LS.Resources.Labels.ReverserName %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <select id="ReverserName" name="ReverserName" style="font-family: Arial;">
                            <option value=""></option>
                        </select><br />
                        <span class="field-validation-valid" data-valmsg-for="ReverserName" data-valmsg-replace="true">
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
            //当前选中冲帐记录编码
            this.selectedReverseId = null;
            //表格1完成标志
            this.grid1Complete = false;
            //表格2完成标志
            this.grid2Complete = false;
            //自动选择定时器
            this.timerId = null;
            //调整布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                var h1 = $("#divWorkspaceContent").height() / 2;
                var h2 = $("#divWorkspaceContent").height() - h1;

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", h1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));

                $("#grid2").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid2").jqGrid("setGridHeight", h2 - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) + 1) - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")) - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) + 1) - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询冲帐记录
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4051, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    $("#formSearch #StartTime").val($.jStorage.get("SearchContractReversesCondition_StartTime", ""));
                    $("#formSearch #EndTime").val($.jStorage.get("SearchContractReversesCondition_EndTime", ""));
                    $("#formSearch #ContractNo").val($.jStorage.get("SearchContractReversesCondition_ContractNo", ""));
                    $("#formSearch #OriginalContractNo").val($.jStorage.get("SearchContractReversesCondition_OriginalContractNo", ""));
                    $("#formSearch #ReverserName").val($.jStorage.get("SearchContractReversesCondition_ReverserId", ""));

                    //打开查询条件输入对话框
                    $("#dialogSearch").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogSearch").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除冲帐记录
            this.deleteContractReverse = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4051, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedReverseId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedContractReverse %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteContractReverseConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedReverseId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                location.replace("/chenxk/Contract/SearchReverses/");
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
            //创建冲帐记录表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    contractNo: "",
                    originalContractNo: "",
                    reverserId: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReverserName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReverseTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReverseAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.WithholdAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.FactpaymentAmount %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CreatorName", index: "CreatorName", width: 80, align: "center" },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "ReverseAmount", index: "ReverseAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "WithholdAmount", index: "WithholdAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "FactpaymentAmount", index: "FactpaymentAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CreateTime",
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
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid1Complete = true;
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedReverseId = rowid;

                    //加载当前选中冲帐记录的明细数据
                    $("#grid2").jqGrid("setGridParam", {
                        url: "/chenxk/Contract/LoadSearchContractReverseDetailsGrid/",
                        postData: {
                            reverseId: objMain.objWorkspace.objContent.selectedReverseId
                        }
                    });
                    $("#grid2").trigger("reloadGrid", [{ page: 1}]);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建冲帐记录明细表格
            $("#grid2").jqGrid({
                url: "/chenxk/Contract/LoadSearchContractReverseDetailsGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { reverseId: "0" },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.ContractId %>",
                    "<%: InnoSoft.LS.Resources.Labels.ContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.OriginalContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DriverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.MobileTel %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalTunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReverseAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.WithholdAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.FactpaymentAmount %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "ContractId", index: "ContractId", width: 100, hidden: true },
                    { name: "ContractNo", index: "ContractNo", width: 100, align: "center" },
                    { name: "OriginalContractNo", index: "OriginalContractNo", width: 100, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "StartPlace", index: "StartPlace", width: 80, align: "center" },
                    { name: "DestPlace", index: "DestPlace", width: 80, align: "center" },
                    { name: "ShipmentTime", index: "ShipmentTime", width: 80, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 80, align: "center", hidden: true },
                    { name: "DriverName", index: "DriverName", width: 100, align: "center" },
                    { name: "DriverMobileTel", index: "DriverMobileTel", width: 120, align: "center" },
                    { name: "TotalTunnages", index: "TotalTunnages", width: 100, align: "center" },
                    { name: "TotalPiles", index: "TotalPiles", width: 100, align: "center" },
                    { name: "TotalTransportCharges", index: "TotalTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "ReverseAmount", index: "ReverseAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "WithholdAmount", index: "WithholdAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum" },
                    { name: "FactpaymentAmount", index: "FactpaymentAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," }, summaryType: "sum"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "ContractNo",
                sortorder: "asc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid2Complete = true;
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

            //创建查询条件录入对话框
            $("#dialogSearch").dialog({
                autoOpen: false,
                height: 300,
                width: 520,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearch").valid()) {
                            $(this).dialog("close");

                            //缓存查询条件
                            $.jStorage.set("SearchContractReversesCondition_StartTime", $("#formSearch #StartTime").val().trim());
                            $.jStorage.set("SearchContractReversesCondition_EndTime", $("#formSearch #EndTime").val().trim());
                            $.jStorage.set("SearchContractReversesCondition_ContractNo", $("#formSearch #ContractNo").val().trim());
                            $.jStorage.set("SearchContractReversesCondition_OriginalContractNo", $("#formSearch #OriginalContractNo").val().trim());
                            $.jStorage.set("SearchContractReversesCondition_ReverserId", $("#formSearch #ReverserName").val().trim());

                            objMain.objWorkspace.objContent.selectedReverseId = null;
                            objMain.objWorkspace.objContent.grid1Complete = false;
                            objMain.objWorkspace.objContent.grid2Complete = false;

                            //重新加载冲帐记录表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Contract/LoadSearchContractReversesGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearch #StartTime").val().trim(),
                                    endTime: $("#formSearch #EndTime").val().trim(),
                                    contractNo: $("#formSearch #ContractNo").val().trim(),
                                    originalContractNo: $("#formSearch #OriginalContractNo").val().trim(),
                                    reverserId: $("#formSearch #ReverserName").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                            //重新加载冲帐记录明细表格
                            $("#grid2").jqGrid("setGridParam", {
                                postData: { reverseId: "0" }
                            });
                            $("#grid2").trigger("reloadGrid", [{ page: 1}]);

                            //重新选中第一个冲帐记录
                            objMain.objWorkspace.objContent.timerId = setInterval("selectContractReverse();", 500);
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

            //设置冲帐人下拉列表
            $.get("/Common/LoadStaffs", function (ret) {
                if (ret.length > 0) {
                    $.each(ret, function (i, staff) {
                        var option = $("<option></option>").val(staff.Id).text(staff.FullName);
                        option.appendTo($("#formSearch #ReverserName"));
                    });
                }
            }, "text json").error(function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });
        });

        //默认选中第一个冲帐记录
        objMain.objWorkspace.objContent.timerId = setInterval("selectContractReverse();", 500);
        function selectContractReverse() {
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
