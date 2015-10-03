<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.PrintDeliverBills %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Deliver/ModifyDeliverBill/" onclick="javascript:objMain.objWorkspace.objContent.modify(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify %></a></li>
        <li><a href="/chenxk/Deliver/CancelDeliverBill/" onclick="javascript:objMain.objWorkspace.objContent.cancel(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete %></a></li>
        <li><a href="/chenxk/Deliver/PrintDeliverBill/" onclick="javascript:objMain.objWorkspace.objContent.print(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/062.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Print %></a></li>
    </ul>
    <select id="ddlCarNo" style="position: relative; float: right; width: 200px; margin-top: -25px;
        margin-right: 5px; font-family: Arial;">
    </select>
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
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中送货单编码
            this.selectedDeliverBillId = null;
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
                $("#grid1").jqGrid("setGridHeight", h1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);

                $("#grid2").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid2").jqGrid("setGridHeight", h2 - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) + 1) - parseInt($(".ui-jqgrid .ui-jqgrid-sdiv").css("height")) - (1 + parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) + 1) - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //修改送货单
            this.modify = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 3040, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedDeliverBillId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedDeliverBill %>");
                        return;
                    }

                    location.replace(action + objMain.objWorkspace.objContent.selectedDeliverBillId);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //取消送货单
            this.cancel = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 3040, strPermission: "AllowCancel" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedDeliverBillId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedDeliverBill %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.CancelDeliverBillConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedDeliverBillId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                location.replace("/chenxk/Deliver/PrintDeliverBills/");
                            }
                        });
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //打印送货单
            this.print = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 3040, strPermission: "AllowPrint" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#ddlCarNo").val().trim() == "") {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCarNo %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedDeliverBillId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedDeliverBill %>");
                        return;
                    }

                    location.replace(action + objMain.objWorkspace.objContent.selectedDeliverBillId);

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
                url: "/chenxk/Deliver/LoadPrintDeliverBillsGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { carNo: "" },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.TrailerNo %>",
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
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                gridComplete: function () {
                    objMain.objWorkspace.objContent.grid1Complete = true;
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedDeliverBillId = rowid;

                    //加载当前选中送货单的货物数据
                    $("#grid2").jqGrid("setGridParam", {
                        url: "/chenxk/Deliver/LoadDeliverBillAllGoodsGrid/",
                        postData: {
                            deliverBillId: objMain.objWorkspace.objContent.selectedDeliverBillId
                        }
                    });
                    $("#grid2").trigger("reloadGrid", [{ page: 1}]);
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //生成送货单货物表格
            $("#grid2").jqGrid({
                url: "/chenxk/Deliver/LoadDeliverBillAllGoodsGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { deliverBillId: "0" },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Brand %>",
                    "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                    "<%: InnoSoft.LS.Resources.Labels.GrammeWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Grade %>",
                    "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.PackingSpecification %>",
                    "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                    "<%: InnoSoft.LS.Resources.Labels.Location %>",
                    "<%: InnoSoft.LS.Resources.Labels.PiecesOrBoxes %>",
                    "<%: InnoSoft.LS.Resources.Labels.PieceWeightOrConvertCoefficient %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "Brand", index: "Brand", width: 80, align: "center" },
                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                    { name: "GWeight", index: "GWeight", width: 50, align: "center" },
                    { name: "Grade", index: "Grade", width: 50, align: "center" },
                    { name: "BatchNo", index: "BatchNo", width: 100, align: "center" },
                    { name: "Packing", index: "Packing", width: 50, align: "center" },
                    { name: "Warehouse", index: "Warehouse", width: 80, align: "center" },
                    { name: "Location", index: "Location", width: 50, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                    { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "GoodsNo",
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

            //初始化车号下拉列表
            $.get("/chenxk/Deliver/LoadPrintDeliverBillsCarNo/", function (ret) {
                $("#ddlCarNo").empty();
                $("#ddlCarNo").append("<option value=''><%: InnoSoft.LS.Resources.Options.SelectCarNo %></option>");

                if (ret.length > 0) {
                    $.each(ret, function (i, carNo) {
                        var option = $("<option></option>").val(carNo).text(carNo);
                        option.appendTo($("#ddlCarNo"));
                    });
                }

                $("#ddlCarNo").get(0).selectedIndex = 0;
            }, "text json").error(function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });

            //车号选择事件
            $("#ddlCarNo").change(function () {
                //重新加载送货单表格
                $("#grid1").jqGrid("setGridParam", {
                    url: "/chenxk/Deliver/LoadPrintDeliverBillsGrid/",
                    postData: { carNo: $("#ddlCarNo").val().trim() }
                });
                $("#grid1").trigger("reloadGrid", [{ page: 1}]);

                //重新选中第一个送货单
                objMain.objWorkspace.objContent.timerId = setInterval("selectDeliverBill();", 500);
            });

        });

        //默认选中第一个送货单
        objMain.objWorkspace.objContent.timerId = setInterval("selectDeliverBill();", 500);
        function selectDeliverBill() {
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
