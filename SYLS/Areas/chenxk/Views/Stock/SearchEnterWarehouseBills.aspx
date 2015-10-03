<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchEnterWarehouseBills %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Stock/EnterWarehouse/" onclick="javascript:objMain.objWorkspace.objContent.modifyEnterWarehouseBill(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/chenxk/Stock/DeleteEnterWarehouseBill/" onclick="javascript:objMain.objWorkspace.objContent.deleteEnterWarehouseBill(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete%></a></li>
        <li><a href="/chenxk/Stock/ExportEnterWarehouseBills/" onclick="javascript:objMain.objWorkspace.objContent.export(this.href);return false;">
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
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("SearchEnterWarehouseBillsCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")));
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询条件
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5030, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formSearchEnterWarehouseBillsCondition #StartTime").val($.jStorage.get("SearchEnterWarehouseBillsCondition_StartTime", ""));
                    $("#formSearchEnterWarehouseBillsCondition #EndTime").val($.jStorage.get("SearchEnterWarehouseBillsCondition_EndTime", ""));
                    $("#formSearchEnterWarehouseBillsCondition #CustomerName").val($.jStorage.get("SearchEnterWarehouseBillsCondition_CustomerName", ""));
                    $("#formSearchEnterWarehouseBillsCondition #DeliveryNo").val($.jStorage.get("SearchEnterWarehouseBillsCondition_DeliveryNo", ""));
                    $("#formSearchEnterWarehouseBillsCondition #EnterWarehouseBillNo").val($.jStorage.get("SearchEnterWarehouseBillsCondition_EnterWarehouseBillNo", ""));
                    $("#formSearchEnterWarehouseBillsCondition #GoodsNo").val($.jStorage.get("SearchEnterWarehouseBillsCondition_GoodsNo", ""));
                    $("#formSearchEnterWarehouseBillsCondition #GoodsName").val($.jStorage.get("SearchEnterWarehouseBillsCondition_GoodsName", ""));
                    $("#formSearchEnterWarehouseBillsCondition #SpecModel").val($.jStorage.get("SearchEnterWarehouseBillsCondition_SpecModel", ""));
                    $("#formSearchEnterWarehouseBillsCondition #BatchNo").val($.jStorage.get("SearchEnterWarehouseBillsCondition_BatchNo", ""));
                    $("#formSearchEnterWarehouseBillsCondition #EnterType").val($.jStorage.get("SearchEnterWarehouseBillsCondition_EnterType", ""));
                    $("#formSearchEnterWarehouseBillsCondition #Warehouse").val($.jStorage.get("SearchEnterWarehouseBillsCondition_Warehouse", ""));
                    $("#formSearchEnterWarehouseBillsCondition #IsConsigning").attr("checked", $.jStorage.get("SearchEnterWarehouseBillsCondition_IsConsigning", false));
                    $("#formSearchEnterWarehouseBillsCondition #HasDrayage").val($.jStorage.get("SearchEnterWarehouseBillsCondition_HasDrayage", ""));

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //修改入库单
            this.modifyEnterWarehouseBill = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5030, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    var id = $("#grid1").jqGrid("getGridParam", "selrow");
                    if (id == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedEnterWarehouseBill %>");
                        return;
                    }

                    var data = $("#grid1").jqGrid("getRowData", id);
                    if (data.EnterType == "<%: InnoSoft.LS.Resources.Options.EndDifferencesInStorage %>") {
                        alert("<%: InnoSoft.LS.Resources.Strings.CanNotModifyStockEndDifferencesEnterWarehouseBill %>");
                        return;
                    }

                    $.jStorage.set("EnterWarehouse_SaveSucceedNext", "/chenxk/Stock/SearchEnterWarehouseBills/");

                    location.replace(action + data.EnterWarehouseBillId);

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除入库单
            this.deleteEnterWarehouseBill = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5030, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    var id = $("#grid1").jqGrid("getGridParam", "selrow");
                    if (id == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedEnterWarehouseBill %>");
                        return;
                    }
                    var data = $("#grid1").jqGrid("getRowData", id);

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteEnterWarehouseBillConfirm %>") == true) {
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

                        $.post(action, { id: data.EnterWarehouseBillId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                location.replace("/chenxk/Stock/SearchEnterWarehouseBills/");
                            }
                        });
                    }

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //导出数据
            this.export = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5030, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#grid1").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.ExportMustAfterSearch %>");
                        return;
                    }

                    var url = action + "?" +
                        "startTime=" + $("#formSearchEnterWarehouseBillsCondition #StartTime").val().trim() + "&" +
                        "endTime=" + $("#formSearchEnterWarehouseBillsCondition #EndTime").val().trim() + "&" +
                        "customerName=" + $("#formSearchEnterWarehouseBillsCondition #CustomerName").val().trim() + "&" +
                        "deliveryNo=" + $("#formSearchEnterWarehouseBillsCondition #DeliveryNo").val().trim() + "&" +
                        "enterWarehouseBillNo=" + $("#formSearchEnterWarehouseBillsCondition #EnterWarehouseBillNo").val().trim() + "&" +
                        "goodsNo=" + $("#formSearchEnterWarehouseBillsCondition #GoodsNo").val().trim() + "&" +
                        "goodsName=" + $("#formSearchEnterWarehouseBillsCondition #GoodsName").val().trim() + "&" +
                        "specModel=" + $("#formSearchEnterWarehouseBillsCondition #SpecModel").val().trim() + "&" +
                        "batchNo=" + $("#formSearchEnterWarehouseBillsCondition #BatchNo").val().trim() + "&" +
                        "enterType=" + $("#formSearchEnterWarehouseBillsCondition #EnterType").val().trim() + "&" +
                        "warehouse=" + $("#formSearchEnterWarehouseBillsCondition #Warehouse").val().trim() + "&" +
                        "isConsigning=" + ($("#formSearchEnterWarehouseBillsCondition #IsConsigning").attr("checked") == "checked").toString() + "&" +
                        "hasDrayage=" + $("#formSearchEnterWarehouseBillsCondition #HasDrayage").val().trim()

                    location.replace(url);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //创建入库单表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    customerName: "",
                    deliveryNo: "",
                    enterWarehouseBillNo: "",
                    goodsNo: "",
                    goodsName: "",
                    specModel: "",
                    batchNo: "",
                    enterType: "",
                    warehouse: "",
                    isConsigning: "false",
                    hasDrayage: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterType %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Brand %>",
                    "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                    "<%: InnoSoft.LS.Resources.Labels.GrammeWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Grade %>",
                    "<%: InnoSoft.LS.Resources.Labels.PackingSpecification %>",
                    "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                    "<%: InnoSoft.LS.Resources.Labels.Location %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.PieceWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "EnterType", index: "EnterType", width: 60, hidden: true },
                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "Brand", index: "Brand", width: 80, align: "center" },
                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                    { name: "GWeight", index: "GWeight", width: 50, align: "center" },
                    { name: "Grade", index: "Grade", width: 50, align: "center" },
                    { name: "Packing", index: "Packing", width: 50, align: "center" },
                    { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                    { name: "Warehouse", index: "Warehouse", width: 80, align: "center" },
                    { name: "Location", index: "Location", width: 50, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center"}],
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
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 520,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearchEnterWarehouseBillsCondition").valid()) {
                            //缓存查询条件
                            $.jStorage.set("SearchEnterWarehouseBillsCondition_StartTime", $("#formSearchEnterWarehouseBillsCondition #StartTime").val().trim());
                            $.jStorage.set("SearchEnterWarehouseBillsCondition_EndTime", $("#formSearchEnterWarehouseBillsCondition #EndTime").val().trim());
                            $.jStorage.set("SearchEnterWarehouseBillsCondition_CustomerName", $("#formSearchEnterWarehouseBillsCondition #CustomerName").val().trim());
                            $.jStorage.set("SearchEnterWarehouseBillsCondition_DeliveryNo", $("#formSearchEnterWarehouseBillsCondition #DeliveryNo").val().trim());
                            $.jStorage.set("SearchEnterWarehouseBillsCondition_EnterWarehouseBillNo", $("#formSearchEnterWarehouseBillsCondition #EnterWarehouseBillNo").val().trim());
                            $.jStorage.set("SearchEnterWarehouseBillsCondition_GoodsNo", $("#formSearchEnterWarehouseBillsCondition #GoodsNo").val().trim());
                            $.jStorage.set("SearchEnterWarehouseBillsCondition_GoodsName", $("#formSearchEnterWarehouseBillsCondition #GoodsName").val().trim());
                            $.jStorage.set("SearchEnterWarehouseBillsCondition_SpecModel", $("#formSearchEnterWarehouseBillsCondition #SpecModel").val().trim());
                            $.jStorage.set("SearchEnterWarehouseBillsCondition_BatchNo", $("#formSearchEnterWarehouseBillsCondition #BatchNo").val().trim());
                            $.jStorage.set("SearchEnterWarehouseBillsCondition_EnterType", $("#formSearchEnterWarehouseBillsCondition #EnterType").val().trim());
                            $.jStorage.set("SearchEnterWarehouseBillsCondition_Warehouse", $("#formSearchEnterWarehouseBillsCondition #Warehouse").val().trim());
                            $.jStorage.set("SearchEnterWarehouseBillsCondition_IsConsigning", ($("#formSearchEnterWarehouseBillsCondition #IsConsigning").attr("checked") == "checked"));
                            $.jStorage.set("SearchEnterWarehouseBillsCondition_HasDrayage", $("#formSearchEnterWarehouseBillsCondition #HasDrayage").val().trim());

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Stock/LoadSearchEnterWarehouseBillsGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearchEnterWarehouseBillsCondition #StartTime").val().trim(),
                                    endTime: $("#formSearchEnterWarehouseBillsCondition #EndTime").val().trim(),
                                    customerName: $("#formSearchEnterWarehouseBillsCondition #CustomerName").val().trim(),
                                    deliveryNo: $("#formSearchEnterWarehouseBillsCondition #DeliveryNo").val().trim(),
                                    enterWarehouseBillNo: $("#formSearchEnterWarehouseBillsCondition #EnterWarehouseBillNo").val().trim(),
                                    goodsNo: $("#formSearchEnterWarehouseBillsCondition #GoodsNo").val().trim(),
                                    goodsName: $("#formSearchEnterWarehouseBillsCondition #GoodsName").val().trim(),
                                    specModel: $("#formSearchEnterWarehouseBillsCondition #SpecModel").val().trim(),
                                    batchNo: $("#formSearchEnterWarehouseBillsCondition #BatchNo").val().trim(),
                                    enterType: $("#formSearchEnterWarehouseBillsCondition #EnterType").val().trim(),
                                    warehouse: $("#formSearchEnterWarehouseBillsCondition #Warehouse").val().trim(),
                                    isConsigning: ($("#formSearchEnterWarehouseBillsCondition #IsConsigning").attr("checked") == "checked"),
                                    hasDrayage: $("#formSearchEnterWarehouseBillsCondition #HasDrayage").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);

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

    </script>
</asp:Content>
