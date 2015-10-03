<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchOutWarehouseBills %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Stock/DeleteOutWarehouseBill/" onclick="javascript:objMain.objWorkspace.objContent.deleteOutWarehouseBill(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete%></a></li>
        <li><a href="/chenxk/Stock/ExportOutWarehouseBills/" onclick="javascript:objMain.objWorkspace.objContent.export(this.href);return false;">
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
        <% Html.RenderPartial("SearchOutWarehouseBillsCondition"); %>
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
                $.get("/Common/LoadAccountPermission", { strFuncId: 5040, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formSearchOutWarehouseBillsCondition #StartTime").val($.jStorage.get("SearchOutWarehouseBillsCondition_StartTime", ""));
                    $("#formSearchOutWarehouseBillsCondition #EndTime").val($.jStorage.get("SearchOutWarehouseBillsCondition_EndTime", ""));
                    $("#formSearchOutWarehouseBillsCondition #CustomerName").val($.jStorage.get("SearchOutWarehouseBillsCondition_CustomerName", ""));
                    $("#formSearchOutWarehouseBillsCondition #DeliveryNo").val($.jStorage.get("SearchOutWarehouseBillsCondition_DeliveryNo", ""));
                    $("#formSearchOutWarehouseBillsCondition #OutWarehouseBillNo").val($.jStorage.get("SearchOutWarehouseBillsCondition_OutWarehouseBillNo", ""));
                    $("#formSearchOutWarehouseBillsCondition #GoodsNo").val($.jStorage.get("SearchOutWarehouseBillsCondition_GoodsNo", ""));
                    $("#formSearchOutWarehouseBillsCondition #BatchNo").val($.jStorage.get("SearchOutWarehouseBillsCondition_BatchNo", ""));
                    $("#formSearchOutWarehouseBillsCondition #CarNo").val($.jStorage.get("SearchOutWarehouseBillsCondition_CarNo", ""));
                    $("#formSearchOutWarehouseBillsCondition #ReceiverName").val($.jStorage.get("SearchOutWarehouseBillsCondition_ReceiverName", ""));
                    $("#formSearchOutWarehouseBillsCondition #OutType").val($.jStorage.get("SearchOutWarehouseBillsCondition_OutType", ""));
                    $("#formSearchOutWarehouseBillsCondition #Warehouse").val($.jStorage.get("SearchOutWarehouseBillsCondition_Warehouse", ""));
                    $("#formSearchOutWarehouseBillsCondition #ReceiveType").val($.jStorage.get("SearchOutWarehouseBillsCondition_ReceiveType", ""));

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除出库单
            this.deleteOutWarehouseBill = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5040, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    var id = $("#grid1").jqGrid("getGridParam", "selrow");
                    if (id == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedOutWarehouseBill %>");
                        return;
                    }
                    var data = $("#grid1").jqGrid("getRowData", id);

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteOutWarehouseBillConfirm %>") == true) {
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

                        $.post(action, { id: data.OutWarehouseBillId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                location.replace("/chenxk/Stock/SearchOutWarehouseBills/");
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
                $.get("/Common/LoadAccountPermission", { strFuncId: 5040, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#grid1").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.ExportMustAfterSearch %>");
                        return;
                    }

                    var url = action + "?" +
                        "startTime=" + $("#formSearchOutWarehouseBillsCondition #StartTime").val().trim() + "&" +
                        "endTime=" + $("#formSearchOutWarehouseBillsCondition #EndTime").val().trim() + "&" +
                        "customerName=" + $("#formSearchOutWarehouseBillsCondition #CustomerName").val().trim() + "&" +
                        "deliveryNo=" + $("#formSearchOutWarehouseBillsCondition #DeliveryNo").val().trim() + "&" +
                        "outWarehouseBillNo=" + $("#formSearchOutWarehouseBillsCondition #OutWarehouseBillNo").val().trim() + "&" +
                        "goodsNo=" + $("#formSearchOutWarehouseBillsCondition #GoodsNo").val().trim() + "&" +
                        "batchNo=" + $("#formSearchOutWarehouseBillsCondition #BatchNo").val().trim() + "&" +
                        "carNo=" + $("#formSearchOutWarehouseBillsCondition #CarNo").val().trim() + "&" +
                        "receiverName=" + $("#formSearchOutWarehouseBillsCondition #ReceiverName").val().trim() + "&" +
                        "outType=" + $("#formSearchOutWarehouseBillsCondition #OutType").val().trim() + "&" +
                        "warehouse=" + $("#formSearchOutWarehouseBillsCondition #Warehouse").val().trim() + "&" +
                        "receiveType=" + $("#formSearchOutWarehouseBillsCondition #ReceiveType").val().trim()

                    location.replace(url);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    customerName: "",
                    deliveryNo: "",
                    outWarehouseBillNo: "",
                    goodsNo: "",
                    batchNo: "",
                    carNo: "",
                    receiverName: "",
                    outType: "",
                    warehouse: "",
                    receiveType: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.OutWarehouseTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.OutWarehouseBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.OutWarehouseBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverAddress %>",
                    "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Brand %>",
                    "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                    "<%: InnoSoft.LS.Resources.Labels.GrammeWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Grade %>",
                    "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.PackingSpecification %>",
                    "<%: InnoSoft.LS.Resources.Labels.Location %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.PieceWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "OutWarehouseBillId", index: "OutWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "OutWarehouseBillNo", index: "OutWarehouseBillNo", width: 100, align: "center" },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "ReceiverAddress", index: "ReceiverAddress", width: 300 },
                    { name: "Warehouse", index: "Warehouse", width: 80, align: "center" },
                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "Brand", index: "Brand", width: 80, align: "center" },
                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                    { name: "GWeight", index: "GWeight", width: 50, align: "center" },
                    { name: "Grade", index: "Grade", width: 50, align: "center" },
                    { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                    { name: "Packing", index: "Packing", width: 50, align: "center" },
                    { name: "Location", index: "Location", width: 50, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center"}],
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
                        if ($("#formSearchOutWarehouseBillsCondition").valid()) {
                            //缓存查询条件
                            $.jStorage.set("SearchOutWarehouseBillsCondition_StartTime", $("#formSearchOutWarehouseBillsCondition #StartTime").val().trim());
                            $.jStorage.set("SearchOutWarehouseBillsCondition_EndTime", $("#formSearchOutWarehouseBillsCondition #EndTime").val().trim());
                            $.jStorage.set("SearchOutWarehouseBillsCondition_CustomerName", $("#formSearchOutWarehouseBillsCondition #CustomerName").val().trim());
                            $.jStorage.set("SearchOutWarehouseBillsCondition_DeliveryNo", $("#formSearchOutWarehouseBillsCondition #DeliveryNo").val().trim());
                            $.jStorage.set("SearchOutWarehouseBillsCondition_OutWarehouseBillNo", $("#formSearchOutWarehouseBillsCondition #OutWarehouseBillNo").val().trim());
                            $.jStorage.set("SearchOutWarehouseBillsCondition_GoodsNo", $("#formSearchOutWarehouseBillsCondition #GoodsNo").val().trim());
                            $.jStorage.set("SearchOutWarehouseBillsCondition_BatchNo", $("#formSearchOutWarehouseBillsCondition #BatchNo").val().trim());
                            $.jStorage.set("SearchOutWarehouseBillsCondition_CarNo", $("#formSearchOutWarehouseBillsCondition #CarNo").val().trim());
                            $.jStorage.set("SearchOutWarehouseBillsCondition_ReceiverName", $("#formSearchOutWarehouseBillsCondition #ReceiverName").val().trim());
                            $.jStorage.set("SearchOutWarehouseBillsCondition_OutType", $("#formSearchOutWarehouseBillsCondition #OutType").val().trim());
                            $.jStorage.set("SearchOutWarehouseBillsCondition_Warehouse", $("#formSearchOutWarehouseBillsCondition #Warehouse").val().trim());
                            $.jStorage.set("SearchOutWarehouseBillsCondition_ReceiveType", $("#formSearchOutWarehouseBillsCondition #ReceiveType").val().trim());

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Stock/LoadSearchOutWarehouseBillsGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearchOutWarehouseBillsCondition #StartTime").val().trim(),
                                    endTime: $("#formSearchOutWarehouseBillsCondition #EndTime").val().trim(),
                                    customerName: $("#formSearchOutWarehouseBillsCondition #CustomerName").val().trim(),
                                    deliveryNo: $("#formSearchOutWarehouseBillsCondition #DeliveryNo").val().trim(),
                                    outWarehouseBillNo: $("#formSearchOutWarehouseBillsCondition #OutWarehouseBillNo").val().trim(),
                                    goodsNo: $("#formSearchOutWarehouseBillsCondition #GoodsNo").val().trim(),
                                    batchNo: $("#formSearchOutWarehouseBillsCondition #BatchNo").val().trim(),
                                    carNo: $("#formSearchOutWarehouseBillsCondition #CarNo").val().trim(),
                                    receiverName: $("#formSearchOutWarehouseBillsCondition #ReceiverName").val().trim(),
                                    outType: $("#formSearchOutWarehouseBillsCondition #OutType").val().trim(),
                                    warehouse: $("#formSearchOutWarehouseBillsCondition #Warehouse").val().trim(),
                                    receiveType: $("#formSearchOutWarehouseBillsCondition #ReceiveType").val().trim()
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
