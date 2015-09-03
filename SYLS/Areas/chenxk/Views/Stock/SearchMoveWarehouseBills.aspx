<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchMoveWarehouseBills %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Stock/DeleteMoveWarehouseBill/" onclick="javascript:objMain.objWorkspace.objContent.deleteMoveWarehouseBill(this.href);return false;">
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
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("SearchMoveWarehouseBillsCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
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
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5041, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formSearchMoveWarehouseBillsCondition #StartTime").val($.jStorage.get("SearchMoveWarehouseBillsCondition_StartTime", ""));
                    $("#formSearchMoveWarehouseBillsCondition #EndTime").val($.jStorage.get("SearchMoveWarehouseBillsCondition_EndTime", ""));
                    $("#formSearchMoveWarehouseBillsCondition #CustomerName").val($.jStorage.get("SearchMoveWarehouseBillsCondition_CustomerName", ""));
                    $("#formSearchMoveWarehouseBillsCondition #MoveWarehouseBillNo").val($.jStorage.get("SearchMoveWarehouseBillsCondition_MoveWarehouseBillNo", ""));
                    $("#formSearchMoveWarehouseBillsCondition #GoodsNo").val($.jStorage.get("SearchMoveWarehouseBillsCondition_GoodsNo", ""));
                    $("#formSearchMoveWarehouseBillsCondition #Warehouse").val($.jStorage.get("SearchMoveWarehouseBillsCondition_Warehouse", ""));

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除移库单
            this.deleteMoveWarehouseBill = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5041, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    var id = $("#grid1").jqGrid("getGridParam", "selrow");
                    if (id == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedMoveWarehouseBill %>");
                        return;
                    }
                    var data = $("#grid1").jqGrid("getRowData", id);

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteMoveWarehouseBillConfirm %>") == true) {
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

                        $.post(action, { id: data.MoveWarehouseBillId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                location.replace("/chenxk/Stock/SearchMoveWarehouseBills/");
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
            //创建移库单表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    startTime: "",
                    endTime: "",
                    customerName: "",
                    moveWarehouseBillNo: "",
                    goodsNo: "",
                    warehouse: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.MoveWarehouseTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.MoveWarehouseBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.MoveWarehouseBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
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
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.NewLocation %>",
                    "<%: InnoSoft.LS.Resources.Labels.NewPieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.NewTunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.NewPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.NewTenThousands %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "MoveWarehouseBillId", index: "MoveWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "MoveWarehouseBillNo", index: "MoveWarehouseBillNo", width: 100, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
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
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center" },
                    { name: "NewLocation", index: "NewLocation", width: 60, align: "center" },
                    { name: "NewPackages", index: "NewPackages", width: 60, align: "center" },
                    { name: "NewTunnages", index: "NewTunnages", width: 100, align: "center" },
                    { name: "NewPiles", index: "NewPiles", width: 100, align: "center" },
                    { name: "NewTenThousands", index: "NewTenThousands", width: 100, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "CreateTime",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 300,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearchMoveWarehouseBillsCondition").valid()) {
                            //缓存查询条件
                            $.jStorage.set("SearchMoveWarehouseBillsCondition_StartTime", $("#formSearchMoveWarehouseBillsCondition #StartTime").val().trim());
                            $.jStorage.set("SearchMoveWarehouseBillsCondition_EndTime", $("#formSearchMoveWarehouseBillsCondition #EndTime").val().trim());
                            $.jStorage.set("SearchMoveWarehouseBillsCondition_CustomerName", $("#formSearchMoveWarehouseBillsCondition #CustomerName").val().trim());
                            $.jStorage.set("SearchMoveWarehouseBillsCondition_MoveWarehouseBillNo", $("#formSearchMoveWarehouseBillsCondition #MoveWarehouseBillNo").val().trim());
                            $.jStorage.set("SearchMoveWarehouseBillsCondition_GoodsNo", $("#formSearchMoveWarehouseBillsCondition #GoodsNo").val().trim());
                            $.jStorage.set("SearchMoveWarehouseBillsCondition_Warehouse", $("#formSearchMoveWarehouseBillsCondition #Warehouse").val().trim());

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Stock/LoadSearchMoveWarehouseBillsGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearchMoveWarehouseBillsCondition #StartTime").val().trim(),
                                    endTime: $("#formSearchMoveWarehouseBillsCondition #EndTime").val().trim(),
                                    customerName: $("#formSearchMoveWarehouseBillsCondition #CustomerName").val().trim(),
                                    moveWarehouseBillNo: $("#formSearchMoveWarehouseBillsCondition #MoveWarehouseBillNo").val().trim(),
                                    goodsNo: $("#formSearchMoveWarehouseBillsCondition #GoodsNo").val().trim(),
                                    warehouse: $("#formSearchMoveWarehouseBillsCondition #Warehouse").val().trim()
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
