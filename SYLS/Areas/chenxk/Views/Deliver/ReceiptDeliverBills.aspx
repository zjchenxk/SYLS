<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ReceiptDeliverBills %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.receipt();return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Receipt %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <div id="dialogReceipt" title="">
        <form id="formReceipt" action="">
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="ReturnTime">
                            <%: InnoSoft.LS.Resources.Labels.ReturnTime %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-regex="<%: InnoSoft.LS.Resources.Strings.NotValidDate %>"
                            data-val-regex-pattern="^((((19|20)(([02468][048])|([13579][26]))-02-29))|((20[0-9][0-9])|(19[0-9][0-9]))-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))$"
                            data-val-required="<%: InnoSoft.LS.Resources.Strings.ReturnTimeRequired %>" id="ReturnTime"
                            name="ReturnTime" type="text" value="" /><br />
                        <span class="field-validation-valid" data-valmsg-for="ReturnTime" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="DamageInfo">
                            <%: InnoSoft.LS.Resources.Labels.DamageInfo %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-length="<%: InnoSoft.LS.Resources.Strings.DamageInfoMaxLengthIs200  %>"
                            data-val-length-max="200" id="DamageInfo" name="DamageInfo" type="text" value="" /><br />
                        <span class="field-validation-valid" data-valmsg-for="DamageInfo" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
        </table>
        </form>
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
                        <label for="CustomerName">
                            <%: InnoSoft.LS.Resources.Labels.CustomerName %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-length="<%: InnoSoft.LS.Resources.Strings.CustomerNameMaxLengthIs50  %>"
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
                            <%: InnoSoft.LS.Resources.Labels.CarNo %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-length="<%: InnoSoft.LS.Resources.Strings.CarNoMaxLengthIs10  %>"
                            data-val-length-max="10" id="CarNo" name="CarNo" type="text" value="" /><br />
                        <span class="field-validation-valid" data-valmsg-for="CarNo" data-valmsg-replace="true">
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="DeliveryNo">
                            <%: InnoSoft.LS.Resources.Labels.DeliveryNo %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" data-val="true" data-val-length="<%: InnoSoft.LS.Resources.Strings.DeliveryNoMaxLengthIs20  %>"
                            data-val-length-max="20" id="DeliveryNo" name="DeliveryNo" type="text" value="" /><br />
                        <span class="field-validation-valid" data-valmsg-for="DeliveryNo" data-valmsg-replace="true">
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
            //查询
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 3050, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    $("#StartTime").val($.jStorage.get("ReceiptDeliverBillsCondition_StartTime", ""));
                    $("#EndTime").val($.jStorage.get("ReceiptDeliverBillsCondition_EndTime", ""));
                    $("#CustomerName").val($.jStorage.get("ReceiptDeliverBillsCondition_CustomerName", ""));
                    $("#CarNo").val($.jStorage.get("ReceiptDeliverBillsCondition_CarNo", ""));
                    $("#DeliveryNo").val($.jStorage.get("ReceiptDeliverBillsCondition_DeliveryNo", ""));

                    //打开查询条件输入对话框
                    $("#dialogSearch").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogSearch").dialog("open");

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //回单信息录入
            this.receipt = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 3050, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //检查是否选择送货单
                    var ids = $("#grid1").jqGrid("getGridParam", "selarrrow");
                    if (ids.length == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedDeliverBill %>");
                        return;
                    }

                    $("#ReturnTime").val("");
                    $("#DamageInfo").val("");

                    //打开回单信息输入对话框
                    $("#dialogReceipt").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterReceipt %>");
                    $("#dialogReceipt").dialog("open");

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
                    customerName: "",
                    carNo: "",
                    deliveryNo: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "BillNo", index: "BillNo", width: 100, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 80, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center"}],
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
                multiselect: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建回单信息录入对话框
            $("#dialogReceipt").dialog({
                autoOpen: false,
                height: 200,
                width: 520,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formReceipt").valid()) {
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

                            var ids = $("#grid1").jqGrid("getGridParam", "selarrrow");

                            $.post("/chenxk/Deliver/ReceiptDeliverBill/", {
                                ids: ids.toString(),
                                returnTime: $("#ReturnTime").val().trim(),
                                damageInfo: $("#DamageInfo").val().trim()
                            }, function (ret) {
                                $.unblockUI();

                                if (ret != null && ret != "") {
                                    alert(ret);
                                }
                                else {
                                    alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceed %>");
                                    $(this).dialog("close");
                                    location.replace("/chenxk/Deliver/ReceiptDeliverBills/");
                                }
                            });
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

            //设置回单时间
            $("#ReturnTime").datepicker($.datepicker.regional["zh-CN"]);

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

                            $.jStorage.set("ReceiptDeliverBillsCondition_StartTime", $("#StartTime").val().trim());
                            $.jStorage.set("ReceiptDeliverBillsCondition_EndTime", $("#EndTime").val().trim());
                            $.jStorage.set("ReceiptDeliverBillsCondition_CustomerName", $("#CustomerName").val().trim());
                            $.jStorage.set("ReceiptDeliverBillsCondition_CarNo", $("#CarNo").val().trim());
                            $.jStorage.set("ReceiptDeliverBillsCondition_DeliveryNo", $("#DeliveryNo").val().trim());

                            //重新加载送货单表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Deliver/LoadReceiptDeliverBillsGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#StartTime").val().trim(),
                                    endTime: $("#EndTime").val().trim(),
                                    customerName: $("#CustomerName").val().trim(),
                                    carNo: $("#CarNo").val().trim(),
                                    deliveryNo: $("#DeliveryNo").val().trim()
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

            //设置起止日期
            $("#StartTime").datepicker($.datepicker.regional["zh-CN"]);
            $("#EndTime").datepicker($.datepicker.regional["zh-CN"]);

            //设置客户名称自动完成
            $("#CustomerName").autocomplete({
                source: "/Autocomplete/LoadCustomerNames/",
                minLength: 1
            });

            //设置车号自动完成
            $("#CarNo").autocomplete({
                source: "/Autocomplete/LoadCarNos/",
                minLength: 1
            });
        });

    </script>
</asp:Content>
