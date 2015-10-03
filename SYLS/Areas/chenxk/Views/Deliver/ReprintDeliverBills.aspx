<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ReprintDeliverBills %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Deliver/ReprintDeliverBill/" onclick="javascript:objMain.objWorkspace.objContent.print(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/062.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Print %></a></li>
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
                            <%: InnoSoft.LS.Resources.Labels.EndTime%></label>
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
                        <label for="DeliverBillNo">
                            <%: InnoSoft.LS.Resources.Labels.DeliverBillNo %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-length="<%: InnoSoft.LS.Resources.Strings.DeliverBillNoMaxLengthIs20 %>"
                            data-val-length-max="20" id="DeliverBillNo" name="DeliverBillNo" type="text"
                            value="" /><br />
                        <span class="field-validation-valid" data-valmsg-for="DeliverBillNo" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="CustomerName">
                            <%: InnoSoft.LS.Resources.Labels.CustomerName %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-length="<%: InnoSoft.LS.Resources.Strings.CustomerNameMaxLengthIs50 %>"
                            data-val-length-max="50" id="CustomerName" name="CustomerName" type="text" value="" /><br />
                        <span class="field-validation-valid" data-valmsg-for="CustomerName" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="CarNo">
                            <%: InnoSoft.LS.Resources.Labels.CarNo%></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-length="<%: InnoSoft.LS.Resources.Strings.CarNoMaxLengthIs10 %>"
                            data-val-length-max="10" id="CarNo" name="CarNo" type="text" value="" /><br />
                        <span class="field-validation-valid" data-valmsg-for="CarNo" data-valmsg-replace="true">
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
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询送货单
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 3080, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    $("#formSearch #StartTime").val($.jStorage.get("ReprintDeliverBillsCondition_StartTime", ""));
                    $("#formSearch #EndTime").val($.jStorage.get("ReprintDeliverBillsCondition_EndTime", ""));
                    $("#formSearch #DeliverBillNo").val($.jStorage.get("ReprintDeliverBillsCondition_DeliverBillNo", ""));
                    $("#formSearch #CustomerName").val($.jStorage.get("ReprintDeliverBillsCondition_CustomerName", ""));
                    $("#formSearch #CarNo").val($.jStorage.get("ReprintDeliverBillsCondition_CarNo", ""));

                    //打开查询条件输入对话框
                    $("#dialogSearch").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogSearch").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //打印送货单
            this.print = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 3080, strPermission: "AllowPrint" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //读取所有选中的送货单数据
                    var ids = $("#grid1").jqGrid("getGridParam", "selarrrow");
                    if (ids.length == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedDeliverBill %>");
                        return;
                    }

                    //送货单不能混合打印
                    var planType = "";
                    for (var i = 0; i < ids.length; i++) {
                        var data = $("#grid1").jqGrid("getRowData", ids[i]);
                        if (data.PlanType != planType) {
                            if (planType == "") {
                                planType = data.PlanType;
                            }
                            else {
                                alert("<%: InnoSoft.LS.Resources.Strings.CanNotPrintDeliverBillMixed %>");
                                return;
                            }
                        }
                    }

                    //不能打印除纸发货计划和罐发货计划之外的送货单
                    if (planType != "<%: InnoSoft.LS.Resources.Options.PaperPlan %>" && planType != "<%: InnoSoft.LS.Resources.Options.CanPlan %>") {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSupportDeliverBillPrint %>");
                        return;
                    }

                    location.replace(action + ids.toString());
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //生成送货单表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    deliverBillNo: "",
                    customerName: "",
                    carNo: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "BillNo", index: "BillNo", width: 100, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 80, align: "center" },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "BillNo",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                multiselect: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

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
                            $.jStorage.set("ReprintDeliverBillsCondition_StartTime", $("#formSearch #StartTime").val().trim());
                            $.jStorage.set("ReprintDeliverBillsCondition_EndTime", $("#formSearch #EndTime").val().trim());
                            $.jStorage.set("ReprintDeliverBillsCondition_DeliverBillNo", $("#formSearch #DeliverBillNo").val().trim());
                            $.jStorage.set("ReprintDeliverBillsCondition_CustomerName", $("#formSearch #CustomerName").val().trim());
                            $.jStorage.set("ReprintDeliverBillsCondition_CarNo", $("#formSearch #CarNo").val().trim());

                            objMain.objWorkspace.objContent.selectedReverseId = null;
                            objMain.objWorkspace.objContent.grid1Complete = false;
                            objMain.objWorkspace.objContent.grid2Complete = false;

                            //重新加载送货单表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Deliver/LoadReprintDeliverBillsGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearch #StartTime").val().trim(),
                                    endTime: $("#formSearch #EndTime").val().trim(),
                                    deliverBillNo: $("#formSearch #DeliverBillNo").val().trim(),
                                    customerName: $("#formSearch #CustomerName").val().trim(),
                                    carNo: $("#formSearch #CarNo").val().trim()
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

            //设置客户名称自动完成
            $("#formSearch #CustomerName").autocomplete({
                source: "/Autocomplete/LoadCustomerNames/",
                minLength: 1
            });

            //设置车号自动完成
            $("#formSearch #CarNo").autocomplete({
                source: "/Autocomplete/LoadCarNos/",
                minLength: 1
            });
        });

    </script>
</asp:Content>
