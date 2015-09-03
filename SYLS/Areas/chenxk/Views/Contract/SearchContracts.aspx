<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchContracts %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
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
        <% Html.RenderPartial("SearchContractsCondition"); %>
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
            //自动选择定时器
            this.timerId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                var h1 = $("#divWorkspaceContent").height() / 2;
                var h2 = $("#divWorkspaceContent").height() - h1;

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", h1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);

                $("#grid2").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid2").jqGrid("setGridHeight", h2 - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) + 1) - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")) - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) + 1) - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询合同
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4080, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    $("#formSearchContractsCondition #StartTime").val($.jStorage.get("SearchContractsCondition_StartTime", ""));
                    $("#formSearchContractsCondition #EndTime").val($.jStorage.get("SearchContractsCondition_EndTime", ""));
                    $("#formSearchContractsCondition #ContractNo").val($.jStorage.get("SearchContractsCondition_ContractNo", ""));
                    $("#formSearchContractsCondition #OriginalContractNo").val($.jStorage.get("SearchContractsCondition_OriginalContractNo", ""));

                    $("#formSearchContractsCondition #StartCountry").val($.jStorage.get("SearchContractsCondition_StartCountry", ""));

                    $("#formSearchContractsCondition #StartProvince").empty();
                    $("#formSearchContractsCondition #StartProvince").append("<option value=''></option>");

                    $("#formSearchContractsCondition #StartCity").empty();
                    $("#formSearchContractsCondition #StartCity").append("<option value=''></option>");

                    if ($.jStorage.get("SearchContractsCondition_StartCountry", "") != "") {
                        $.get("/Common/LoadProvincesByCountry", { strCountryName: $.jStorage.get("SearchContractsCondition_StartCountry", "") }, function (ret) {
                            $.each(ret, function (i, province) {
                                var option = $("<option></option>").val(province).text(province);
                                option.appendTo($("#formSearchContractsCondition #StartProvince"));
                            });
                            $("#formSearchContractsCondition #StartProvince").val($.jStorage.get("SearchContractsCondition_StartProvince", ""));

                            if ($.jStorage.get("SearchContractsCondition_StartProvince", "") != "") {
                                $.get("/Common/LoadCitysByProvince", { strCountryName: $.jStorage.get("SearchContractsCondition_StartCountry", ""), strProvinceName: $.jStorage.get("SearchContractsCondition_StartProvince", "") }, function (ret) {
                                    $.each(ret, function (i, city) {
                                        var option = $("<option></option>").val(city).text(city);
                                        option.appendTo($("#formSearchContractsCondition #StartCity"));
                                    });
                                    $("#formSearchContractsCondition #StartCity").val($.jStorage.get("SearchContractsCondition_StartCity", ""));
                                }, "text json").error(function (xhr, status, error) {
                                    $("#formSearchContractsCondition #StartProvince").val("");
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#formSearchContractsCondition #StartCountry").val("");
                        });
                    }

                    $("#formSearchContractsCondition #DestCountry").val($.jStorage.get("SearchContractsCondition_DestCountry", ""));

                    $("#formSearchContractsCondition #DestProvince").empty();
                    $("#formSearchContractsCondition #DestProvince").append("<option value=''></option>");

                    $("#formSearchContractsCondition #DestCity").empty();
                    $("#formSearchContractsCondition #DestCity").append("<option value=''></option>");

                    if ($.jStorage.get("SearchContractsCondition_DestCountry", "") != "") {
                        $.get("/Common/LoadProvincesByCountry", { strCountryName: $.jStorage.get("SearchContractsCondition_DestCountry", "") }, function (ret) {
                            $.each(ret, function (i, province) {
                                var option = $("<option></option>").val(province).text(province);
                                option.appendTo($("#formSearchContractsCondition #DestProvince"));
                            });
                            $("#formSearchContractsCondition #DestProvince").val($.jStorage.get("SearchContractsCondition_DestProvince", ""));

                            if ($.jStorage.get("SearchContractsCondition_DestProvince", "") != "") {
                                $.get("/Common/LoadCitysByProvince", { strCountryName: $.jStorage.get("SearchContractsCondition_DestCountry", ""), strProvinceName: $.jStorage.get("SearchContractsCondition_DestProvince", "") }, function (ret) {
                                    $.each(ret, function (i, city) {
                                        var option = $("<option></option>").val(city).text(city);
                                        option.appendTo($("#formSearchContractsCondition #DestCity"));
                                    });
                                    $("#formSearchContractsCondition #DestCity").val($.jStorage.get("SearchContractsCondition_DestCity", ""));
                                }, "text json").error(function (xhr, status, error) {
                                    $("#formSearchContractsCondition #DestProvince").val("");
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#formSearchContractsCondition #DestCountry").val("");
                        });
                    }

                    $("#formSearchContractsCondition #CarNo").val($.jStorage.get("SearchContractsCondition_CarNo", ""));
                    $("#formSearchContractsCondition #OrganId").val($.jStorage.get("SearchContractsCondition_OrganId", ""));

                    //打开查询条件输入对话框
                    $("#dialogSearch").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogSearch").dialog("open");

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //生成合同表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    contractNo: "",
                    originalContractNo: "",
                    startCountry: "",
                    startProvince: "",
                    startCity: "",
                    destCountry: "",
                    destProvince: "",
                    destCity: "",
                    carNo: "",
                    organId: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.ContractId %>",
                    "<%: InnoSoft.LS.Resources.Labels.ContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.OriginalContractNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalTunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.ApproveState %>",
                    "<%: InnoSoft.LS.Resources.Labels.OwnOrganName %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "ContractNo", index: "ContractNo", width: 100, align: "center" },
                    { name: "OriginalContractNo", index: "OriginalContractNo", width: 100, align: "center" },
                    { name: "ShipmentTime", index: "ShipmentTime", width: 80, align: "center" },
                    { name: "StartPlace", index: "StartPlace", width: 80, align: "center" },
                    { name: "DestPlace", index: "DestPlace", width: 80, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 80, align: "center", hidden: true },
                    { name: "GoodsName", index: "GoodsName", width: 150, align: "center" },
                    { name: "TotalTunnages", index: "TotalTunnages", width: 80, align: "center" },
                    { name: "TotalPiles", index: "TotalPiles", width: 80, align: "center" },
                    { name: "TotalTransportCharges", index: "TotalTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "ApproveState", index: "ApproveState", sortable: false, width: 100, align: "center" },
                    { name: "OwnOrganName", index: "OwnOrganName", width: 200 }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "ContractNo",
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
                    objMain.objWorkspace.objContent.selectedContractId = rowid;

                    //加载当前选中合同的发货数据
                    $("#grid2").jqGrid("setGridParam", {
                        url: "/chenxk/Contract/LoadApproveContractDeliverPlansGrid/",
                        datatype: "json",
                        postData: {
                            contractId: objMain.objWorkspace.objContent.selectedContractId
                        }
                    });
                    $("#grid2").trigger("reloadGrid", [{ page: 1 }]);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建合同发货记录表格
            $("#grid2").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    contractId: "0"
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiveType %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.KM %>",
                    "<%: InnoSoft.LS.Resources.Labels.DispatchedTransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.DispatchedTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.LimitedTransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.LimitedTransportCharges %>",
                    "<%: InnoSoft.LS.Resources.Labels.ApprovedTransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.ApprovedTransportCharges %>",
                    "",
                    ""],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "PlanId", index: "PlanId", width: 100, hidden: true },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ReceiverName", index: "ReceiverName", width: 200, hidden: true },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center", hidden: true },
                    { name: "StartCity", index: "StartCity", width: 60, align: "center" },
                    { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                    { name: "ReceiveType", index: "ReceiveType", width: 60, align: "center", hidden: true },
                    { name: "Packages", index: "Packages", width: 60, align: "center", hidden: true },
                    { name: "Tunnages", index: "Tunnages", width: 80, align: "center" },
                    { name: "Piles", index: "Piles", width: 80, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 60, align: "center", hidden: true },
                    { name: "KM", index: "KM", width: 60, align: "center", hidden: true },
                    { name: "TransportPrice", index: "TransportPrice", width: 60, align: "right" },
                    { name: "TransportCharges", index: "TransportCharges", width: 80, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "LimitedTransportPrice", index: "LimitedTransportPrice", width: 60, align: "right" },
                    { name: "LimitedTransportCharges", index: "LimitedTransportCharges", width: 80, align: "right" },
                    { name: "ApprovedTransportPrice", index: "ApprovedTransportPrice", width: 60, align: "right" },
                    { name: "ApprovedTransportCharges", index: "ApprovedTransportCharges", width: 80, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "TransportChargeExpression", index: "TransportChargeExpression", width: 100, hidden: true },
                    { name: "TransportPriceExpression", index: "TransportPriceExpression", width: 100, hidden: true }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CustomerName",
                sortorder: "asc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                footerrow: true,
                userDataOnFooter: true,
                subGrid: true,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid2Complete = true;
                },
                subGridRowExpanded: function (subgrid_id, row_id) {
                    var data = $("#grid2").jqGrid("getRowData", row_id);

                    var subgrid_table_id = subgrid_id + "_t";
                    var pager_id = "p_" + subgrid_table_id;

                    $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll'></table><div id='" + pager_id + "' class='scroll'></div>");

                    $("#" + subgrid_table_id).jqGrid({
                        url: "/chenxk/Contract/LoadContractApproveCommentsGrid/",
                        datatype: "json",
                        mtype: "GET",
                        postData: {
                            contractId: objMain.objWorkspace.objContent.selectedContractId,
                            planId: data.PlanId
                        },
                        colNames: [
                            "<%: InnoSoft.LS.Resources.Labels.Id %>",
                            "<%: InnoSoft.LS.Resources.Labels.ApproveTime %>",
                            "<%: InnoSoft.LS.Resources.Labels.ApproverName %>",
                            "<%: InnoSoft.LS.Resources.Labels.ApprovedTransportPrice %>",
                            "<%: InnoSoft.LS.Resources.Labels.ApprovedTransportCharges %>"],
                        colModel: [
                            { name: "Id", index: "Id", width: 100, hidden: true },
                            { name: "ApproveTime", index: "ApproveTime", width: 100, align: "center" },
                            { name: "ApproverName", index: "ApproverName", width: 80, align: "center" },
                            { name: "ApprovedTransportPrice", index: "ApprovedTransportPrice", width: 100, align: "right" },
                            { name: "ApprovedTransportCharges", index: "ApprovedTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } }],
                        rowNum: 500,
                        sortname: "ApproveTime",
                        sortorder: "asc",
                        height: "100%",
                        shrinkToFit: false,
                        pager: pager_id,
                        emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                        loadError: function (xhr, status, error) {
                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        }
                    });
                    $("#" + subgrid_table_id).jqGrid("navGrid", "#" + pager_id, { edit: false, add: false, del: false, search: false });
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

            //创建查询条件录入对话框
            $("#dialogSearch").dialog({
                autoOpen: false,
                height: 500,
                width: 550,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearchContractsCondition").valid()) {
                            $(this).dialog("close");

                            //缓存查询条件
                            $.jStorage.set("SearchContractsCondition_StartTime", $("#formSearchContractsCondition #StartTime").val().trim());
                            $.jStorage.set("SearchContractsCondition_EndTime", $("#formSearchContractsCondition #EndTime").val().trim());
                            $.jStorage.set("SearchContractsCondition_ContractNo", $("#formSearchContractsCondition #ContractNo").val().trim());
                            $.jStorage.set("SearchContractsCondition_OriginalContractNo", $("#formSearchContractsCondition #OriginalContractNo").val().trim());
                            $.jStorage.set("SearchContractsCondition_StartCountry", $("#formSearchContractsCondition #StartCountry").val().trim());
                            $.jStorage.set("SearchContractsCondition_StartProvince", $("#formSearchContractsCondition #StartProvince").val().trim());
                            $.jStorage.set("SearchContractsCondition_StartCity", $("#formSearchContractsCondition #StartCity").val().trim());
                            $.jStorage.set("SearchContractsCondition_DestCountry", $("#formSearchContractsCondition #DestCountry").val().trim());
                            $.jStorage.set("SearchContractsCondition_DestProvince", $("#formSearchContractsCondition #DestProvince").val().trim());
                            $.jStorage.set("SearchContractsCondition_DestCity", $("#formSearchContractsCondition #DestCity").val().trim());
                            $.jStorage.set("SearchContractsCondition_CarNo", $("#formSearchContractsCondition #CarNo").val().trim());
                            $.jStorage.set("SearchContractsCondition_OrganId", $("#formSearchContractsCondition #OrganId").val().trim());

                            objMain.objWorkspace.objContent.selectedContractId = null;
                            objMain.objWorkspace.objContent.grid1Complete = false;
                            objMain.objWorkspace.objContent.grid2Complete = false;

                            //重新加载合同表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Contract/LoadSearchContractsGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearchContractsCondition #StartTime").val().trim(),
                                    endTime: $("#formSearchContractsCondition #EndTime").val().trim(),
                                    contractNo: $("#formSearchContractsCondition #ContractNo").val().trim(),
                                    originalContractNo: $("#formSearchContractsCondition #OriginalContractNo").val().trim(),
                                    startCountry: $("#formSearchContractsCondition #StartCountry").val().trim(),
                                    startProvince: $("#formSearchContractsCondition #StartProvince").val().trim(),
                                    startCity: $("#formSearchContractsCondition #StartCity").val().trim(),
                                    destCountry: $("#formSearchContractsCondition #DestCountry").val().trim(),
                                    destProvince: $("#formSearchContractsCondition #DestProvince").val().trim(),
                                    destCity: $("#formSearchContractsCondition #DestCity").val().trim(),
                                    carNo: $("#formSearchContractsCondition #CarNo").val().trim(),
                                    organId: $("#formSearchContractsCondition #OrganId").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1 }]);

                            //重新加载合同发货记录表格
                            $("#grid2").jqGrid("setGridParam", {
                                url: "/chenxk/Contract/LoadApproveContractDeliverPlansGrid/",
                                datatype: "json",
                                postData: {
                                    contractId: "0"
                                }
                            });
                            $("#grid2").trigger("reloadGrid", [{ page: 1 }]);

                            //重新选中第一个合同
                            objMain.objWorkspace.objContent.timerId = setInterval("selectContract();", 500);

                        }
                    },
                    "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                }
            });

        });

        //默认选中第一个合同
        objMain.objWorkspace.objContent.timerId = setInterval("selectContract();", 500);
        function selectContract() {
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
