<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ApproveContracts %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Contract/ApproveContract/" onclick="javascript:objMain.objWorkspace.objContent.approve(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Approve %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("ApproveContractsCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //表格1完成标志
            this.grid1Complete = false;
            //自动选择定时器
            this.timerId = null;
            //当前选中合同编码
            this.selectedContractId = null;
            //调整布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询条件
            this.search = function () {
                //初始化控件数据
                $("#formApproveContractsCondition #StartTime").val($.jStorage.get("ApproveContracts_StartTime", ""));
                $("#formApproveContractsCondition #EndTime").val($.jStorage.get("ApproveContracts_EndTime", ""));
                $("#formApproveContractsCondition #ContractNo").val($.jStorage.get("ApproveContracts_ContractNo", ""));
                $("#formApproveContractsCondition #OriginalContractNo").val($.jStorage.get("ApproveContracts_OriginalContractNo", ""));

                $("#formApproveContractsCondition #DestCountry").val($.jStorage.get("ApproveContracts_DestCountry", ""));

                $("#formApproveContractsCondition #DestProvince").empty();
                $("#formApproveContractsCondition #DestProvince").append("<option value=''></option>");

                $("#formApproveContractsCondition #DestCity").empty();
                $("#formApproveContractsCondition #DestCity").append("<option value=''></option>");

                if ($.jStorage.get("ApproveContracts_DestCountry", "") != "") {
                    $.get("/Common/LoadProvincesByCountry", { strCountryName: $.jStorage.get("ApproveContracts_DestCountry", "") }, function (ret) {
                        $.each(ret, function (i, province) {
                            var option = $("<option></option>").val(province).text(province);
                            option.appendTo($("#formApproveContractsCondition #DestProvince"));
                        });
                        $("#formApproveContractsCondition #DestProvince").val($.jStorage.get("ApproveContracts_DestProvince", ""));

                        if ($.jStorage.get("ApproveContracts_DestProvince", "") != "") {
                            $.get("/Common/LoadCitysByProvince", { strCountryName: $.jStorage.get("ApproveContracts_DestCountry", ""), strProvinceName: $.jStorage.get("ApproveContracts_DestProvince", "") }, function (ret) {
                                $.each(ret, function (i, city) {
                                    var option = $("<option></option>").val(city).text(city);
                                    option.appendTo($("#formApproveContractsCondition #DestCity"));
                                });
                                $("#formApproveContractsCondition #DestCity").val($.jStorage.get("ApproveContracts_DestCity", ""));
                            }, "text json").error(function (xhr, status, error) {
                                $("#formApproveContractsCondition #DestProvince").val("");
                            });
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#formApproveContractsCondition #DestCountry").val("");
                    });
                }

                $("#formApproveContractsCondition #CarNo").val($.jStorage.get("ApproveContracts_CarNo", ""));

                $("#formApproveContractsCondition #OrganId").empty();
                $("#formApproveContractsCondition #OrganId").append("<option value=''></option>");

                if ($.jStorage.get("ApproveContracts_StartTime", "") != "" && $.jStorage.get("ApproveContracts_EndTime", "") != "") {
                    $.get("/chenxk/Contract/LoadApproveContractsOwnOrgansByTimespan", { startTime: $.jStorage.get("ApproveContracts_StartTime", ""), endTime: $.jStorage.get("ApproveContracts_EndTime", "") }, function (ret) {
                        $.each(ret, function (i, organ) {
                            var option = $("<option></option>").val(organ.Id).text(organ.FullName);
                            option.appendTo($("#formApproveContractsCondition #OrganId"));
                        });
                        $("#formApproveContractsCondition #OrganId").val($.jStorage.get("ApproveContracts_OrganId", ""));
                    }, "text json").error(function (xhr, status, error) {
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }

                //打开条件输入对话框
                $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                $("#dialogCondition").dialog("open");
            };
            //审批合同
            this.approve = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 4040, strPermission: "AllowApprove" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedContractId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedContract %>");
                        return;
                    }

                    location.replace(action + objMain.objWorkspace.objContent.selectedContractId);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //生成待审批合同表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    contractNo: "",
                    originalContractNo: "",
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
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarType %>",
                    "<%: InnoSoft.LS.Resources.Labels.DriverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.MobileTel %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalTunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TotalTransportCharges %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "ContractNo", index: "ContractNo", width: 100, align: "center" },
                    { name: "OriginalContractNo", index: "OriginalContractNo", width: 100, align: "center" },
                    { name: "ShipmentTime", index: "ShipmentTime", width: 80, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "TrailerNo", index: "TrailerNo", width: 80, align: "center", hidden: true },
                    { name: "CarType", index: "CarType", width: 60, align: "center" },
                    { name: "DriverName", index: "DriverName", width: 100, align: "center" },
                    { name: "DriverMobileTel", index: "DriverMobileTel", width: 120, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "TotalTunnages", index: "TotalTunnages", width: 100, align: "center" },
                    { name: "TotalPiles", index: "TotalPiles", width: 100, align: "center" },
                    { name: "TotalTransportCharges", index: "TotalTransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "ShipmentTime",
                sortorder: "desc",
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
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 450,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formApproveContractsCondition").valid()) {
                            //缓存查询条件
                            $.jStorage.set("ApproveContracts_StartTime", $("#formApproveContractsCondition #StartTime").val().trim());
                            $.jStorage.set("ApproveContracts_EndTime", $("#formApproveContractsCondition #EndTime").val().trim());
                            $.jStorage.set("ApproveContracts_ContractNo", $("#formApproveContractsCondition #ContractNo").val().trim());
                            $.jStorage.set("ApproveContracts_OriginalContractNo", $("#formApproveContractsCondition #OriginalContractNo").val().trim());
                            $.jStorage.set("ApproveContracts_DestCountry", $("#formApproveContractsCondition #DestCountry").val().trim());
                            $.jStorage.set("ApproveContracts_DestProvince", $("#formApproveContractsCondition #DestProvince").val().trim());
                            $.jStorage.set("ApproveContracts_DestCity", $("#formApproveContractsCondition #DestCity").val().trim());
                            $.jStorage.set("ApproveContracts_CarNo", $("#formApproveContractsCondition #CarNo").val().trim());
                            $.jStorage.set("ApproveContracts_OrganId", $("#formApproveContractsCondition #OrganId").val().trim());

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Contract/LoadApproveContractsGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formApproveContractsCondition #StartTime").val().trim(),
                                    endTime: $("#formApproveContractsCondition #EndTime").val().trim(),
                                    contractNo: $("#formApproveContractsCondition #ContractNo").val().trim(),
                                    originalContractNo: $("#formApproveContractsCondition #OriginalContractNo").val().trim(),
                                    destCountry: $("#formApproveContractsCondition #DestCountry").val().trim(),
                                    destProvince: $("#formApproveContractsCondition #DestProvince").val().trim(),
                                    destCity: $("#formApproveContractsCondition #DestCity").val().trim(),
                                    carNo: $("#formApproveContractsCondition #CarNo").val().trim(),
                                    organId: $("#formApproveContractsCondition #OrganId").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1 }]);

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

        });

        //初始化待审批合同表格数据
        objMain.objWorkspace.objContent.timerId = setInterval("loadApproveContracts();", 500);
        function loadApproveContracts() {
            if (objMain.objWorkspace.objContent.grid1Complete) {
                clearInterval(objMain.objWorkspace.objContent.timerId);

                if ($.jStorage.get("ApproveContracts_StartTime", "") != "" ||
                    $.jStorage.get("ApproveContracts_EndTime", "") != "" ||
                    $.jStorage.get("ApproveContracts_ContractNo", "") != "" ||
                    $.jStorage.get("ApproveContracts_OriginalContractNo", "") != "" ||
                    $.jStorage.get("ApproveContracts_DestCountry", "") != "" ||
                    $.jStorage.get("ApproveContracts_DestProvince", "") != "" ||
                    $.jStorage.get("ApproveContracts_DestCity", "") != "" ||
                    $.jStorage.get("ApproveContracts_CarNo", "") != "" ||
                    $.jStorage.get("ApproveContracts_OrganId", "") != "") {

                    $("#grid1").jqGrid("setGridParam", {
                        url: "/chenxk/Contract/LoadApproveContractsGrid/",
                        datatype: "json",
                        postData: {
                            startTime: $.jStorage.get("ApproveContracts_StartTime", ""),
                            endTime: $.jStorage.get("ApproveContracts_EndTime", ""),
                            contractNo: $.jStorage.get("ApproveContracts_ContractNo", ""),
                            originalContractNo: $.jStorage.get("ApproveContracts_OriginalContractNo", ""),
                            destCountry: $.jStorage.get("ApproveContracts_DestCountry", ""),
                            destProvince: $.jStorage.get("ApproveContracts_DestProvince", ""),
                            destCity: $.jStorage.get("ApproveContracts_DestCity", ""),
                            carNo: $.jStorage.get("ApproveContracts_CarNo", ""),
                            organId: $.jStorage.get("ApproveContracts_OrganId", "")
                        }
                    });
                    $("#grid1").trigger("reloadGrid", [{ page: 1 }]);
                }
            }
        }

    </script>
</asp:Content>
