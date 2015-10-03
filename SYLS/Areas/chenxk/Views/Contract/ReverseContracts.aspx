<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ReverseContracts %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.searchContracts();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.addReverse();return false;">
            <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Reverse%></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveReverses();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %><label
                id="lblContractCount"></label></a></li>
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
            <li><a href="#tabPlans">
                <%: InnoSoft.LS.Resources.Tabs.DeliveryList %></a></li>
            <li><a href="#tabReverses">
                <%: InnoSoft.LS.Resources.Tabs.ReverseList %></a></li>
        </ul>
        <div id="tabPlans">
            <div>
                <table id="grid2">
                </table>
                <div id="pager2">
                </div>
            </div>
        </div>
        <div id="tabReverses">
            <div>
                <table id="grid3">
                </table>
                <div id="pager3">
                </div>
            </div>
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
                            <span class="field-validation-valid" data-valmsg-for="StartTime" data-valmsg-replace="true"></span>
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
                            <span class="field-validation-valid" data-valmsg-for="EndTime" data-valmsg-replace="true"></span>
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
                            <span class="field-validation-valid" data-valmsg-for="ContractNo" data-valmsg-replace="true"></span>
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
                            <span class="field-validation-valid" data-valmsg-for="OriginalContractNo" data-valmsg-replace="true"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="editor-label-right">
                            <label for="CarrierName">
                                <%: InnoSoft.LS.Resources.Labels.CarrierName %></label>
                        </div>
                    </td>
                    <td>
                        <div class="editor-field">
                            <input class="text-box single-line" data-val="true" data-val-length="<%: InnoSoft.LS.Resources.Strings.CarrierNameMaxLengthIs50 %>"
                                data-val-length-max="50" id="CarrierName" name="CarrierName" type="text" value="" /><br />
                            <span class="field-validation-valid" data-valmsg-for="CarrierName" data-valmsg-replace="true"></span>
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
                            <input class="text-box single-line" data-val="true" data-val-length="<%: InnoSoft.LS.Resources.Strings.CarNoMaxLengthIs10 %>"
                                data-val-length-max="10" id="CarNo" name="CarNo" type="text" value="" /><br />
                            <span class="field-validation-valid" data-valmsg-for="CarNo" data-valmsg-replace="true"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="editor-label-right">
                            <label for="OrganName">
                                <%: InnoSoft.LS.Resources.Labels.OrganName %></label>
                        </div>
                    </td>
                    <td>
                        <div class="editor-field">
                            <select id="OrganName" name="OrganName" style="font-family: Arial;">
                                <option value=""></option>
                            </select><br />
                            <span class="field-validation-valid" data-valmsg-for="OrganName" data-valmsg-replace="true"></span>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div id="dialogNewReverse" title="">
        <form id="formNewReverse" action="">
            <input type="hidden" id="ContractId" name="ContractId" value="" />
            <table>
                <tr>
                    <td>
                        <div class="editor-label-right">
                            <label for="ReverseAmount">
                                <%: InnoSoft.LS.Resources.Labels.ReverseAmount %></label>
                        </div>
                    </td>
                    <td>
                        <div class="editor-field">
                            <input class="text-box single-line" data-val="true" data-val-notequalzero="<%: InnoSoft.LS.Resources.Strings.ReverseAmountCanNotEqualZero %>"
                                data-val-number="<%: InnoSoft.LS.Resources.Strings.ReverseAmountMustbeNumber %>"
                                data-val-regex="<%: InnoSoft.LS.Resources.Strings.NotValidCurrency %>" data-val-regex-pattern="^[-+]?[0-9]+(\.[0-9]{1,2})?$"
                                data-val-required="<%: InnoSoft.LS.Resources.Strings.ReverseAmountRequired %>"
                                id="ReverseAmount" name="ReverseAmount" type="text" value="0" /><br />
                            <span class="field-validation-valid" data-valmsg-for="ReverseAmount" data-valmsg-replace="true"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="editor-label-right">
                            <label for="WithholdAmount">
                                <%: InnoSoft.LS.Resources.Labels.WithholdAmount %></label>
                        </div>
                    </td>
                    <td>
                        <div class="editor-field">
                            <input class="text-box single-line" data-val="true" data-val-greaterthanorequalzero="<%: InnoSoft.LS.Resources.Strings.WithholdAmountNotGreaterThanOrEqualZero %>"
                                data-val-number="<%: InnoSoft.LS.Resources.Strings.WithholdAmountMustbeNumber %>"
                                data-val-regex="<%: InnoSoft.LS.Resources.Strings.NotValidCurrency %>" data-val-regex-pattern="^[0-9]+(\.[0-9]{1,2})?$"
                                data-val-required="<%: InnoSoft.LS.Resources.Strings.WithholdAmountRequired %>"
                                id="WithholdAmount" name="WithholdAmount" type="text" value="0" /><br />
                            <span class="field-validation-valid" data-valmsg-for="WithholdAmount" data-valmsg-replace="true"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="editor-label-right">
                            <label for="FactpaymentAmount">
                                <%: InnoSoft.LS.Resources.Labels.FactpaymentAmount %></label>
                        </div>
                    </td>
                    <td>
                        <div class="editor-field">
                            <input class="text-box single-line" data-val="true" data-val-number="<%: InnoSoft.LS.Resources.Strings.FactpaymentAmountMustbeNumber %>"
                                data-val-regex="<%: InnoSoft.LS.Resources.Strings.NotValidCurrency %>" data-val-regex-pattern="^[-+]?[0-9]+(\.[0-9]{1,2})?$"
                                data-val-required="<%: InnoSoft.LS.Resources.Strings.FactpaymentAmountRequired %>"
                                id="FactpaymentAmount" name="FactpaymentAmount" type="text" value="0" readonly="readonly" /><br />
                            <span class="field-validation-valid" data-valmsg-for="FactpaymentAmount" data-valmsg-replace="true"></span>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div id="dialogSaveReverse" title="">
        <div>
            <table id="grid4">
            </table>
            <div id="pager4">
            </div>
        </div>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="CreatorName">
                            <%: InnoSoft.LS.Resources.Labels.ReverserName%></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <select id="CreatorName" name="CreatorName" style="font-family: Arial;">
                            <option value=""></option>
                        </select>
                        <span class="field-validation-valid" data-valmsg-for="CreatorName" data-valmsg-replace="true"></span>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中合同编码
            this.selectedContractId = null;
            //表格1完成标志
            this.grid1Complete = false;
            //表格2完成标志
            this.grid2Complete = false;
            //表格3完成标志
            this.grid3Complete = false;
            //自动选择定时器
            this.timerId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                var h1 = $("#divWorkspaceContent").height() / 2;

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", h1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));

                var h2 = $("#divWorkspaceContent").height() - h1;

                $("#tabs").css("height", (h2 - parseInt($("#tabs").css("border-top-width")) - parseInt($("#tabs").css("margin-top")) - parseInt($("#tabs").css("padding-top")) - parseInt($("#tabs").css("padding-bottom")) - parseInt($("#tabs").css("margin-bottom")) - parseInt($("#tabs").css("border-bottom-width"))) + "px");

                var w3 = parseInt($(".ui-tabs .ui-tabs-panel").css("width"));
                if (w3 == 0) {
                    w3 = $("#divWorkspaceContent").width() - parseInt($("#tabs").css("border-left-width")) - parseInt($("#tabs").css("margin-left")) - parseInt($("#tabs").css("padding-left")) - parseInt($(".ui-tabs .ui-tabs-nav").css("padding-left")) - parseInt($(".ui-tabs .ui-tabs-nav").css("padding-right")) - parseInt($("#tabs").css("padding-right")) - parseInt($("#tabs").css("margin-right")) - parseInt($("#tabs").css("border-right-width"));
                }
                var h3 = parseInt($("#tabs").css("height")) - parseInt($(".ui-tabs .ui-tabs-nav").css("border-top-width")) - parseInt($(".ui-tabs .ui-tabs-nav").css("padding-top")) - parseInt($(".ui-tabs .ui-tabs-nav").css("height")) - parseInt($(".ui-tabs .ui-tabs-nav").css("padding-bottom")) - parseInt($(".ui-tabs .ui-tabs-nav").css("border-bottom-width")) - parseInt($(".ui-tabs .ui-tabs-panel").css("padding-top")) - parseInt($(".ui-tabs .ui-tabs-panel").css("padding-bottom"));

                $("#grid2").jqGrid("setGridWidth", w3);
                $("#grid2").jqGrid("setGridHeight", h3 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));

                $("#grid3").jqGrid("setGridWidth", w3);
                $("#grid3").jqGrid("setGridHeight", h3 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询待冲帐合同
            this.searchContracts = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4050, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    $("#formSearch #StartTime").val($.jStorage.get("SearchReverseContractsCondition_StartTime", ""));
                    $("#formSearch #EndTime").val($.jStorage.get("SearchReverseContractsCondition_EndTime", ""));
                    $("#formSearch #ContractNo").val($.jStorage.get("SearchReverseContractsCondition_ContractNo", ""));
                    $("#formSearch #OriginalContractNo").val($.jStorage.get("SearchReverseContractsCondition_OriginalContractNo", ""));
                    $("#formSearch #CarrierName").val($.jStorage.get("SearchReverseContractsCondition_CarrierName", ""));
                    $("#formSearch #CarNo").val($.jStorage.get("SearchReverseContractsCondition_CarNo", ""));
                    $("#formSearch #OrganName").val($.jStorage.get("SearchReverseContractsCondition_OrganId", ""));

                    //打开查询条件输入对话框
                    $("#dialogSearch").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogSearch").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除所有冲帐记录
            this.clearReverses = function () {
                var ids = new Array();
                $.jStorage.set("ReverseContracts_SaveReverses", ids.toString())

                $("#lblContractCount").text("");
            };
            //添加冲帐记录
            this.addReverse = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4050, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedContractId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedContract %>");
                        return;
                    }

                    //打开冲帐金额输入对话框
                    var data = $("#grid1").jqGrid("getRowData", objMain.objWorkspace.objContent.selectedContractId);

                    $("#formNewReverse #ContractId").val(objMain.objWorkspace.objContent.selectedContractId);
                    $("#formNewReverse #ReverseAmount").val(data.ResidualReverseAmount);
                    $("#formNewReverse #WithholdAmount").val("0");
                    $("#formNewReverse #FactpaymentAmount").val(data.ResidualReverseAmount);

                    $("#dialogNewReverse").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterReverseAmount %>");
                    $("#dialogNewReverse").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //保存冲帐记录
            this.saveReverses = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4050, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //刷新待保存冲帐记录表格
                    $("#grid4").jqGrid("setGridParam", {
                        url: "/chenxk/Contract/LoadSaveReversesGrid/",
                        postData: { saveReverses: $.jStorage.get("ReverseContracts_SaveReverses", "") }
                    });
                    $("#grid4").trigger("reloadGrid", [{ page: 1 }]);

                    //打开对话框
                    $("#dialogSaveReverse").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.SaveReverses %>");
                    $("#dialogSaveReverse").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除冲帐记录
            this.deleteReverse = function (id) {
                //删除表格记录
                $("#grid4").jqGrid("delRowData", id);

                //刷新冲帐金额、扣款金额和实付金额合计
                var totalReverseAmount = 0;
                var totalWithholdAmount = 0;
                var totalFactpaymentAmount = 0;
                var rows = $("#grid4").jqGrid("getRowData");
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    totalReverseAmount = add(totalReverseAmount, parseFloat(row.ReverseAmount));
                    totalWithholdAmount = add(totalWithholdAmount, parseFloat(row.WithholdAmount));
                    totalFactpaymentAmount = add(totalFactpaymentAmount, parseFloat(row.FactpaymentAmount));
                }
                $("#grid4").jqGrid("footerData", "set", { ReverseAmount: totalReverseAmount, WithholdAmount: totalWithholdAmount, FactpaymentAmount: totalFactpaymentAmount });

                //刷新冲帐记录缓存
                var ids = null;
                if ($.jStorage.get("ReverseContracts_SaveReverses", "") == "") {
                    ids = new Array();
                }
                else {
                    ids = $.jStorage.get("ReverseContracts_SaveReverses", "").split(",");
                }

                var ids2 = new Array();

                for (var i = 0; i < ids.length; i++) {
                    if (ids[i].split("|")[0] != id) {
                        ids2.push(ids[i]);
                    }
                }
                $.jStorage.set("ReverseContracts_SaveReverses", ids2.toString())

                if (ids2.length > 0) {
                    $("#lblContractCount").text("(" + ids2.length + ")");
                }
                else {
                    $("#lblContractCount").text("");
                }
            };
            //退回修改
            this.returnModify = function (id) {
                if (confirm("<%: InnoSoft.LS.Resources.Strings.ReturnModifyContractConfirm %>") == true) {
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

                    $.post("/chenxk/Contract/ReturnModifyContract/", { id: id }, function (ret) {
                        $.unblockUI();

                        if (ret != null && ret != "") {
                            alert(ret);
                        }
                        else {
                            //重新加载冲帐合同表格
                            objMain.objWorkspace.objContent.selectedContractId = null;
                            objMain.objWorkspace.objContent.grid1Complete = false;
                            objMain.objWorkspace.objContent.grid2Complete = false;
                            objMain.objWorkspace.objContent.grid3Complete = false;

                            $("#grid1").trigger("reloadGrid", [{ page: 1 }]);

                            //重新加载合同发货记录表格
                            $("#grid2").jqGrid("setGridParam", {
                                postData: { contractId: "0" }
                            });
                            $("#grid2").trigger("reloadGrid", [{ page: 1 }]);

                            //重新加载合同冲帐记录表格
                            $("#grid3").jqGrid("setGridParam", {
                                postData: { contractId: "0" }
                            });
                            $("#grid3").trigger("reloadGrid", [{ page: 1 }]);

                            //重新选中第一个合同
                            objMain.objWorkspace.objContent.timerId = setInterval("selectContract();", 500);

                            //删除冲帐记录缓存
                            var ids = null;
                            if ($.jStorage.get("ReverseContracts_SaveReverses", "") == "") {
                                ids = new Array();
                            }
                            else {
                                ids = $.jStorage.get("ReverseContracts_SaveReverses", "").split(",");
                            }

                            var ids2 = new Array();

                            for (var i = 0; i < ids.length; i++) {
                                if (ids[i].split("|")[0] != id) {
                                    ids2.push(ids[i]);
                                }
                            }
                            $.jStorage.set("ReverseContracts_SaveReverses", ids2.toString())

                            if (ids2.length > 0) {
                                $("#lblContractCount").text("(" + ids2.length + ")");
                            }
                            else {
                                $("#lblContractCount").text("");
                            }
                        }
                    });

                }
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            $.jStorage.deleteKey("ReverseContracts_SaveReverses");

            //创建TAB控件
            $("#tabs").tabs();

            //生成待冲帐合同表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    contractNo: "",
                    originalContractNo: "",
                    carrierName: "",
                    carNo: "",
                    organId: ""
                },
                colNames: [
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
                    "<%: InnoSoft.LS.Resources.Labels.PrepayTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.ResidualTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReversedAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.ResidualReverseAmount %>",
                    ""],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
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
                    { name: "TotalTransportCharges", index: "TotalTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "PrepayTransportCharges", index: "PrepayTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "ResidualTransportCharges", index: "ResidualTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "ReverseAmount", index: "ReverseAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "ResidualReverseAmount", index: "ResidualReverseAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "Actions", index: "Actions", width: 80, align: "center", sortable: false }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "ContractNo",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    var ids = $("#grid1").jqGrid("getDataIDs");
                    for (var i = 0; i < ids.length; i++) {
                        var s = "<input style='height:22px;width:75px;' type='button' value='<%: InnoSoft.LS.Resources.Buttons.ReturnModify %>' onclick='objMain.objWorkspace.objContent.returnModify(" + ids[i] + ");' />";
                        $("#grid1").jqGrid("setRowData", ids[i], { Actions: s });
                    }
                    objMain.objWorkspace.objContent.grid1Complete = true;
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedContractId = rowid;

                    //加载当前选中合同的发货数据
                    $("#grid2").jqGrid("setGridParam", {
                        url: "/chenxk/Contract/LoadReverseContractDeliverPlansGrid/",
                        datatype: "json",
                        postData: {
                            contractId: objMain.objWorkspace.objContent.selectedContractId
                        }
                    });
                    $("#grid2").trigger("reloadGrid", [{ page: 1 }]);

                    //加载当前选中合同的冲帐数据
                    $("#grid3").jqGrid("setGridParam", {
                        url: "/chenxk/Contract/LoadContractReverseDetailsGrid/",
                        datatype: "json",
                        postData: {
                            contractId: objMain.objWorkspace.objContent.selectedContractId
                        }
                    });
                    $("#grid3").trigger("reloadGrid", [{ page: 1 }]);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建合同发货记录表格
            $("#grid2").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: { contractId: "0" },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverAddress %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiveType %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiptReceived %>",
                    "<%: InnoSoft.LS.Resources.Labels.DamageInfo %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "PlanId", index: "PlanId", width: 100, hidden: true },
                    { name: "PlanNo", index: "PlanNo", width: 100, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "ReceiverAddress", index: "ReceiverAddress", width: 300 },
                    { name: "ReceiveType", index: "ReceiveType", width: 60, align: "center" },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                    { name: "FinalTransportPrice", index: "FinalTransportPrice", width: 100, align: "right" },
                    { name: "FinalTransportCharges", index: "FinalTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "Remark", index: "Remark", width: 200 },
                    { name: "DeliverBillReceiptReceived", index: "DeliverBillReceiptReceived", width: 60, align: "center", formatter: "checkbox" },
                    { name: "DamageInfo", index: "DamageInfo", width: 400 }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "PlanNo",
                sortorder: "asc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                height: 300,
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

            //创建合同已冲帐记录表格
            $("#grid3").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: { contractId: "0" },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReverseTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReverserName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReverseAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.WithholdAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.FactpaymentAmount %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "CreatorName", index: "CreatorName", width: 80, align: "center" },
                    { name: "ReverseAmount", index: "ReverseAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "WithholdAmount", index: "WithholdAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "FactpaymentAmount", index: "FactpaymentAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CreateTime",
                sortorder: "asc",
                pager: "#pager3",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid3Complete = true;
                }
            });
            $("#grid3").jqGrid("navGrid", "#pager3", { edit: false, add: false, del: false, search: false });

            //创建查询条件录入对话框
            $("#dialogSearch").dialog({
                autoOpen: false,
                height: 350,
                width: 520,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearch").valid()) {
                            $(this).dialog("close");

                            //缓存查询条件
                            $.jStorage.set("SearchReverseContractsCondition_StartTime", $("#formSearch #StartTime").val().trim());
                            $.jStorage.set("SearchReverseContractsCondition_EndTime", $("#formSearch #EndTime").val().trim());
                            $.jStorage.set("SearchReverseContractsCondition_ContractNo", $("#formSearch #ContractNo").val().trim());
                            $.jStorage.set("SearchReverseContractsCondition_OriginalContractNo", $("#formSearch #OriginalContractNo").val().trim());
                            $.jStorage.set("SearchReverseContractsCondition_CarrierName", $("#formSearch #CarrierName").val().trim());
                            $.jStorage.set("SearchReverseContractsCondition_CarNo", $("#formSearch #CarNo").val().trim());
                            $.jStorage.set("SearchReverseContractsCondition_OrganId", $("#formSearch #OrganName").val().trim());

                            objMain.objWorkspace.objContent.selectedContractId = null;
                            objMain.objWorkspace.objContent.grid1Complete = false;
                            objMain.objWorkspace.objContent.grid2Complete = false;
                            objMain.objWorkspace.objContent.grid3Complete = false;

                            //重新加载冲帐合同表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Contract/LoadReverseContractsGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearch #StartTime").val().trim(),
                                    endTime: $("#formSearch #EndTime").val().trim(),
                                    contractNo: $("#formSearch #ContractNo").val().trim(),
                                    originalContractNo: $("#formSearch #OriginalContractNo").val().trim(),
                                    carrierName: $("#formSearch #CarrierName").val().trim(),
                                    carNo: $("#formSearch #CarNo").val().trim(),
                                    organId: $("#formSearch #OrganName").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1 }]);

                            //重新加载合同发货记录表格
                            $("#grid2").jqGrid("setGridParam", {
                                url: "/chenxk/Contract/LoadReverseContractDeliverPlansGrid/",
                                datatype: "json",
                                postData: { contractId: "0" }
                            });
                            $("#grid2").trigger("reloadGrid", [{ page: 1 }]);

                            //重新加载合同冲帐记录表格
                            $("#grid3").jqGrid("setGridParam", {
                                url: "/chenxk/Contract/LoadContractReverseDetailsGrid/",
                                datatype: "json",
                                postData: { contractId: "0" }
                            });
                            $("#grid3").trigger("reloadGrid", [{ page: 1 }]);

                            //重新选中第一个合同
                            objMain.objWorkspace.objContent.timerId = setInterval("selectContract();", 500);

                            //删除所有冲帐记录缓存
                            //objMain.objWorkspace.objContent.clearReverses();
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

            //设置查询起止时间
            $("#formSearch #StartTime").datepicker($.datepicker.regional["zh-CN"]);
            $("#formSearch #EndTime").datepicker($.datepicker.regional["zh-CN"]);

            //设置承运单位名称自动完成
            $("#formSearch #CarrierName").autocomplete({
                source: "/Autocomplete/LoadCarrierNames/",
                minLength: 1
            });

            //设置车号自动完成
            $("#formSearch #CarNo").autocomplete({
                source: "/Autocomplete/LoadCarNos/",
                minLength: 1
            });

            //设置组织部门下拉列表
            $.get("/Common/LoadOrganizations", function (ret) {
                if (ret.length > 0) {
                    $.each(ret, function (i, organ) {
                        var option = $("<option></option>").val(organ.Id).text(organ.FullName);
                        option.appendTo($("#formSearch #OrganName"));
                    });
                }
            }, "text json").error(function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });

            //创建冲帐金额录入对话框
            $("#dialogNewReverse").dialog({
                autoOpen: false,
                height: 200,
                width: 520,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formNewReverse").valid()) {
                            //检查冲帐金额
                            var data = $("#grid1").jqGrid("getRowData", $("#formNewReverse #ContractId").val().trim());
                            var reversedAmount = add(data.ReverseAmount, $("#formNewReverse #ReverseAmount").val().trim());
                            if (Math.abs(parseFloat(reversedAmount)) > Math.abs(parseFloat(data.TotalTransportCharges))) {
                                alert("<%: InnoSoft.LS.Resources.Strings.ReverseAmountCanNotGreaterThanTransportCharges %>");
                                return;
                            }

                            $(this).dialog("close");

                            //缓存冲帐记录
                            var ids = null;
                            if ($.jStorage.get("ReverseContracts_SaveReverses", "") == "") {
                                ids = new Array();
                            }
                            else {
                                ids = $.jStorage.get("ReverseContracts_SaveReverses", "").split(",");
                            }

                            var i = 0;
                            while (i < ids.length) {
                                if (ids[i].split("|")[0] == $("#formNewReverse #ContractId").val().trim()) {
                                    ids[i] = $("#formNewReverse #ContractId").val().trim() + "|" + $("#formNewReverse #ReverseAmount").val().trim() + "|" + $("#formNewReverse #WithholdAmount").val().trim() + "|" + $("#formNewReverse #FactpaymentAmount").val().trim();
                                    break;
                                }
                                i++;
                            }
                            if (i >= ids.length) {
                                ids.push($("#formNewReverse #ContractId").val().trim() + "|" + $("#formNewReverse #ReverseAmount").val().trim() + "|" + $("#formNewReverse #WithholdAmount").val().trim() + "|" + $("#formNewReverse #FactpaymentAmount").val().trim());
                            }
                            $.jStorage.set("ReverseContracts_SaveReverses", ids.toString())

                            $("#lblContractCount").text("(" + ids.length + ")");
                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

            //设置冲帐金额改变事件
            $("#formNewReverse #ReverseAmount").change(function () {
                //检查冲帐金额
                var reverseAmount = parseFloat($("#formNewReverse #ReverseAmount").val().trim());
                if (isNaN(reverseAmount)) {
                    reverseAmount = 0;
                    $("#formNewReverse #ReverseAmount").val(reverseAmount);
                }

                //获取扣款金额
                var withholdAmount = parseFloat($("#formNewReverse #WithholdAmount").val().trim());
                if (isNaN(withholdAmount) || withholdAmount <= 0) {
                    withholdAmount = 0;
                    $("#formNewReverse #WithholdAmount").val(withholdAmount);
                }

                //计算实付金额
                $("#formNewReverse #FactpaymentAmount").val(sub(reverseAmount, withholdAmount));
            });

            //设置扣款金额改变事件
            $("#formNewReverse #WithholdAmount").change(function () {
                //检查扣款金额
                var withholdAmount = parseFloat($("#formNewReverse #WithholdAmount").val().trim());
                if (isNaN(withholdAmount) || withholdAmount <= 0) {
                    withholdAmount = 0;
                    $("#formNewReverse #WithholdAmount").val(withholdAmount);
                }

                //获取冲帐金额
                var reverseAmount = parseFloat($("#formNewReverse #ReverseAmount").val().trim());
                if (isNaN(reverseAmount)) {
                    reverseAmount = 0;
                    $("#formNewReverse #ReverseAmount").val(reverseAmount);
                }

                //计算实付金额
                $("#formNewReverse #FactpaymentAmount").val(sub(reverseAmount, withholdAmount));
            });

            //创建保存冲帐记录对话框
            $("#dialogSaveReverse").dialog({
                autoOpen: false,
                height: 650,
                width: 1000,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        //检查冲帐金额
                        //debugger;
                        var footerData = $("#grid4").jqGrid("footerData");
                        var totalReverseAmount = footerData.ReverseAmount.replace(/,/g, "");
                        var totalWithholdAmount = footerData.WithholdAmount.replace(/,/g, "");
                        var totalFactpaymentAmount = footerData.FactpaymentAmount.replace(/,/g, "");

                        if (parseFloat(totalReverseAmount) == 0) {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterReverses %>");
                            return;
                        }

                        //检查冲帐人
                        if ($("#CreatorName").val().trim() == "") {
                            alert("<%: InnoSoft.LS.Resources.Strings.NotEnterReverser %>");
                            return;
                        }

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

                        //生成冲帐明细记录JSON数据
                        var rows = $("#grid4").jqGrid("getRowData");
                        var details = new Array();
                        for (var i = 0; i < rows.length; i++) {
                            var row = rows[i];
                            var d = {
                                "Id": "0",
                                "ReverseId": "0",
                                "ContractId": row.Id,
                                "ReverseAmount": row.ReverseAmount.replace(/,/g, ""),
                                "WithholdAmount": row.WithholdAmount.replace(/,/g, ""),
                                "FactpaymentAmount": row.FactpaymentAmount.replace(/,/g, "")
                            };
                            details.push(d);
                        }

                        //生成冲帐记录JSON数据
                        var o = {
                            "Id": "0",
                            "ReverseAmount": totalReverseAmount,
                            "WithholdAmount": totalWithholdAmount,
                            "FactpaymentAmount": totalFactpaymentAmount,
                            "CreatorId": $("#CreatorName").val().trim(),
                            "CreatorName": $("#CreatorName").find("option:selected").text(),
                            "Details": details
                        };

                        var postData = JSON.stringify(o);

                        //发送数据
                        $.ajax({
                            type: "POST",
                            url: "/chenxk/Contract/ReverseContracts/",
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

                                    $(this).dialog("close");

                                    location.replace("/chenxk/Contract/ReverseContracts/");
                                }
                            },
                            error: function (xhr, status, error) {
                                $.unblockUI();

                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            }
                        });
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                open: function () {
                    $("#grid4").jqGrid("setGridWidth", parseInt($("#dialogSaveReverse").width()) - 2);
                    //$("#grid4").jqGrid("setGridHeight", parseInt($("#dialogSaveReverse").height()) - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));
                },
                close: function () {
                }
            });

            //创建待保存冲帐记录表格
            $("#grid4").jqGrid({
                url: "/chenxk/Contract/LoadSaveReversesGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { saveReverses: "" },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.ContractId %>",
                    "<%: InnoSoft.LS.Resources.Labels.ContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.OriginalContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DriverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.MobileTel %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReverseAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.WithholdAmount %>",
                    "<%: InnoSoft.LS.Resources.Labels.FactpaymentAmount %>",
                    ""],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "ContractNo", index: "ContractNo", width: 100, align: "center" },
                    { name: "OriginalContractNo", index: "OriginalContractNo", width: 100, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 80, align: "center", hidden: true },
                    { name: "DriverName", index: "DriverName", width: 100, align: "center" },
                    { name: "DriverMobileTel", index: "DriverMobileTel", width: 120, align: "center" },
                    { name: "ReverseAmount", index: "ReverseAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "WithholdAmount", index: "WithholdAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "FactpaymentAmount", index: "FactpaymentAmount", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "Actions", index: "Actions", width: 80, align: "center", sortable: false }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "ContractNo",
                sortorder: "asc",
                pager: "#pager4",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                height: 400,
                footerrow: true,
                userDataOnFooter: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    var ids = $("#grid4").jqGrid("getDataIDs");
                    for (var i = 0; i < ids.length; i++) {
                        var s = "<input style='height:22px;width:60px;' type='button' value='<%: InnoSoft.LS.Resources.Buttons.Delete %>' onclick='objMain.objWorkspace.objContent.deleteReverse(" + ids[i] + ");' />";
                        $("#grid4").jqGrid("setRowData", ids[i], { Actions: s });
                    }
                }
            });
            $("#grid4").jqGrid("navGrid", "#pager4", { edit: false, add: false, del: false, search: false });

            //设置冲帐人下拉列表框
            $.get("/Common/LoadStaffs", function (ret) {
                if (ret.length > 0) {
                    $.each(ret, function (i, staff) {
                        var option = $("<option></option>").val(staff.Id).text(staff.FullName);
                        option.appendTo($("#CreatorName"));
                    });
                }
            }, "text json").error(function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });

        });

        //默认选中第一个合同
        objMain.objWorkspace.objContent.timerId = setInterval("selectContract();", 500);
        function selectContract() {
            if (objMain.objWorkspace.objContent.grid1Complete && objMain.objWorkspace.objContent.grid2Complete && objMain.objWorkspace.objContent.grid3Complete) {
                clearInterval(objMain.objWorkspace.objContent.timerId);

                if ($("#grid1").jqGrid("getGridParam", "records") > 0) {
                    var rowid = $("#grid1").jqGrid("getRowData")[0].Id;
                    $("#grid1").jqGrid("setSelection", rowid, true);
                }
            }
        }

    </script>
</asp:Content>
