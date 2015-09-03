<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.EnterWarehouseBillViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.EnterStockEndDifferences %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.save();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("EnterWarehouse", "Stock", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.BasicInfo %></legend>
        <%: Html.HiddenFor(model => model.CustomerId) %>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CustomerName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CustomerName) %>
                        <%: Html.ValidationMessageFor(model => model.CustomerName) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DeliveryNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.DeliveryNo) %>
                        <%: Html.ValidationMessageFor(model => model.DeliveryNo) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.UnloadingForceFeePrice)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.UnloadingForceFeePrice)%>
                        <%: Html.ValidationMessageFor(model => model.UnloadingForceFeePrice)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ForceFee) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ForceFee) %>
                        <%: Html.ValidationMessageFor(model => model.ForceFee) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.StorageFeePrice) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.StorageFeePrice)%>
                        <%: Html.ValidationMessageFor(model => model.StorageFeePrice)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.HasDrayage) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.HasDrayage) %>
                        <%: Html.ValidationMessageFor(model => model.HasDrayage) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Remark) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Remark) %>
                        <%: Html.ValidationMessageFor(model => model.Remark) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CreateTime) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CreateTime)%>
                        <%: Html.ValidationMessageFor(model => model.CreateTime)%>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.GoodsList %></legend>
        <div>
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnDeleteGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <% } %>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中货物记录编码
            this.selectedGoodsId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认客户名称获得焦点
                $("#form1 #CustomerName").focus().select();
            };
            //删除货物信息
            this.deleteGoods = function () {
                if (this.selectedGoodsId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedGoods %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteGoodsConfirm %>") == true) {
                    $("#grid1").jqGrid("delRowData", this.selectedGoodsId);

                    //重置合计数
                    var totalPackages = 0;
                    var totalTunnages = 0;
                    var rows = $("#grid1").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        totalPackages += parseInt(row.Packages);
                        totalTunnages = add(totalTunnages, parseFloat(row.Tunnages));
                    }

                    $("#grid1").jqGrid("footerData", "set", {
                        GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>",
                        Packages: totalPackages,
                        Tunnages: totalTunnages
                    });

                    this.selectedGoodsId = null;

                    //计算力支费
                    ComputeForceFee();
                }
            };
            //保存数据
            this.save = function () {
                $("#form1").submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //1.设置客户名称自动完成
            $("#form1 #CustomerName").autocomplete({
                source: "/Autocomplete/LoadCustomerNames/",
                minLength: 1,
                change: function (event, ui) {
                    //填充客户编码、下力支费价格和仓储费价格
                    $.get("/Common/LoadCustomerByName", { strName: $("#form1 #CustomerName").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #CustomerId").val(ret.Id);
                            $("#form1 #UnloadingForceFeePrice").val(ret.UnloadingForceFeePrice);
                            $("#form1 #StorageFeePrice").val(ret.StorageFeePrice);

                            //读取库存尾差记录
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Stock/LoadGoodsStockEndDifferencesGrid/",
                                datatype: "json",
                                postData: {
                                    customerName: $("#form1 #CustomerName").val().trim()
                                }
                            });
                            $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                        }
                        else {
                            alert("<%: InnoSoft.LS.Resources.Strings.CustomerNameNotExists %>");
                            $("#form1 #CustomerId").val("0");
                            $("#form1 #CustomerName").val("");
                            $("#form1 #CustomerName").focus().select();
                            $("#form1 #UnloadingForceFeePrice").val("0.00");
                            $("#form1 #ForceFee").val("0.00");
                            $("#form1 #StorageFeePrice").val("0.00");
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #CustomerName").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //2.设置下力支费价格改变事件
            $("#form1 #UnloadingForceFeePrice").change(function () {
                //检查价格
                var unloadingForceFeePrice = parseFloat($("#form1 #UnloadingForceFeePrice").val().trim());
                if (isNaN(unloadingForceFeePrice) || unloadingForceFeePrice <= 0) {
                    $("#form1 #UnloadingForceFeePrice").val("0.00");
                }

                //计算力支费
                ComputeForceFee();
            });

            //3.设置力支费改变事件
            $("#form1 #ForceFee").change(function () {
                //检查力支费
                var forceFee = parseFloat($("#form1 #ForceFee").val().trim());
                if (isNaN(forceFee) || forceFee <= 0) {
                    $("#form1 #ForceFee").val("0.00");
                }

                //计算下力支费价格
                ComputeUnloadingForceFeePrice();
            });

            //4.设置录入日期
            $("#form1 #CreateTime").datepicker($.datepicker.regional["zh-CN"]);

            //5.创建货物表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    customerName: ""
                },
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
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.PieceWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
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
                    { name: "Packages", index: "Packages", width: 60, align: "center", hidden: true },
                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center", hidden: true },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center" },
                    { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center"}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "",
                sortorder: "asc",
                pager: "#pager1",
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
                    //计算力支费
                    ComputeForceFee();
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedGoodsId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //6.设置删除按钮事件
            $("#btnDeleteGoods").button().click(function () {
                objMain.objWorkspace.objContent.deleteGoods();
            });

            //7.提交事件
            $("#form1").submit(function () {
                if ($(this).valid()) {
                    //检查录入时间
                    var createTime = $("#form1 #CreateTime").val().trim();
                    var today = formatDate(new Date(), "yyyy-MM-dd");
                    if (createTime > today) {
                        alert("<%: InnoSoft.LS.Resources.Strings.CreateTimeCantNotGreaterThanSystemTime %>");
                        return false;
                    }

                    //检查货物数据
                    var rows = $("#grid1").jqGrid("getRowData");
                    if (rows.length == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterGoods %>");
                        return false;
                    }

                    //检查仓库是否一致
                    var warehouse = "";
                    for (var i = 0; i < rows.length; i++) {
                        if (warehouse != "" && rows[i].Warehouse != warehouse) {
                            alert("<%: InnoSoft.LS.Resources.Strings.WarehouseIsDiscrepancy %>");
                            return false;
                        }
                        warehouse = rows[i].Warehouse;
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

                    //生成货物JSON数据
                    var goods = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var g = {
                            "Id": row.Id,
                            "EnterWarehouseBillId": "0",
                            "GoodsId": row.GoodsId,
                            "GoodsNo": row.GoodsNo,
                            "GoodsName": row.GoodsName,
                            "Brand": row.Brand,
                            "SpecModel": row.SpecModel,
                            "GWeight": row.GWeight,
                            "Grade": row.Grade,
                            "PieceWeight": row.PieceWeight,
                            "Packing": row.Packing,
                            "BatchNo": row.BatchNo,
                            "Location": row.Location,
                            "Packages": row.Packages,
                            "Tunnages": parseFloat(row.Tunnages) * (-1),
                            "Piles": "0",
                            "TenThousands": "0",
                            "ProductionDate": row.ProductionDate
                        };
                        goods.push(g);
                    }

                    //生成入库单JSON数据
                    var o = {
                        "Id": "0",
                        "BillNo": "",
                        "PlanId": "0",
                        "CustomerId": $("#form1 #CustomerId").val().trim(),
                        "CustomerName": $("#form1 #CustomerName").val().trim(),
                        "DeliveryNo": $("#form1 #DeliveryNo").val().trim(),
                        "EnterType": "<%: InnoSoft.LS.Resources.Options.EndDifferencesInStorage %>",
                        "IsConsigning": false,
                        "Warehouse": warehouse,
                        "UnloadingForceFeePrice": $("#form1 #UnloadingForceFeePrice").val().trim(),
                        "ForceFee": $("#form1 #ForceFee").val().trim(),
                        "StorageFeePrice": $("#form1 #StorageFeePrice").val().trim(),
                        "HasDrayage": ($("#form1 #HasDrayage").attr("checked") == "checked"),
                        "Remark": $("#form1 #Remark").val().trim(),
                        "CreateTime": $("#form1 #CreateTime").val().trim(),
                        "Goods": goods
                    };
                    var postData = JSON.stringify(o);

                    //发送数据
                    $.ajax({
                        type: "POST",
                        url: $(this).attr("action"),
                        data: postData,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (ret) {
                            $.unblockUI();

                            if (ret.ErrorText != null && ret.ErrorText != "") {
                                alert(ret.ErrorText);
                            }
                            else {
                                alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceedNextAddNew %>");
                                location.replace("/chenxk/Stock/EnterStockEndDifferences/");
                            }
                        },
                        error: function (xhr, status, error) {
                            $.unblockUI();

                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        }
                    });
                }
                return false;
            });
        });

        //计算力支费
        function ComputeForceFee() {
            var unloadingForceFeePrice = parseFloat($("#form1 #UnloadingForceFeePrice").val().trim());
            if (isNaN(unloadingForceFeePrice) || unloadingForceFeePrice <= 0) {
                unloadingForceFeePrice = 0;
            }

            var footerData = $("#grid1").jqGrid("footerData");
            var tunnages = parseFloat(footerData.Tunnages);
            if (isNaN(tunnages)) {
                tunnages = 0;
            }
            tunnages = tunnages * (-1);

            var forceFee = mul(tunnages, unloadingForceFeePrice);
            if (isNaN(forceFee)) {
                forceFee = 0;
            }

            $("#form1 #ForceFee").val(Math.round(forceFee * Math.pow(10, 2)) / Math.pow(10, 2));
        }

        //计算下力支费价格
        function ComputeUnloadingForceFeePrice() {
            var forceFee = parseFloat($("#form1 #ForceFee").val().trim());
            if (isNaN(forceFee) || forceFee <= 0) {
                forceFee = 0;
            }

            var footerData = $("#grid1").jqGrid("footerData");

            var tunnages = parseFloat(footerData.Tunnages);
            if (isNaN(tunnages)) {
                tunnages = 0;
            }
            tunnages = tunnages * (-1);

            var unloadingForceFeePrice = div(forceFee, tunnages);
            if (isNaN(unloadingForceFeePrice)) {
                unloadingForceFeePrice = 0;
            }

            $("#form1 #UnloadingForceFeePrice").val(Math.round(unloadingForceFeePrice * Math.pow(10, 2)) / Math.pow(10, 2));
        }

    </script>
</asp:Content>
