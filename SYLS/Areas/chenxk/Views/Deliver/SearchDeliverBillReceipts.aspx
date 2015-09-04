<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchDeliverBillReceipts %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/Deliver/ExportDeliverBillReceipts/" onclick="javascript:objMain.objWorkspace.objContent.export(this.href);return false;">
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
        <% Html.RenderPartial("SearchDeliverBillReceiptsCondition"); %>
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
                $.get("/Common/LoadAccountPermission", { strFuncId: 3060, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formSearchDeliverBillReceiptsCondition #StartTime").val($.jStorage.get("SearchDeliverBillReceiptsCondition_StartTime", ""));
                    $("#formSearchDeliverBillReceiptsCondition #EndTime").val($.jStorage.get("SearchDeliverBillReceiptsCondition_EndTime", ""));
                    $("#formSearchDeliverBillReceiptsCondition #CustomerName").val($.jStorage.get("SearchDeliverBillReceiptsCondition_CustomerName", ""));
                    $("#formSearchDeliverBillReceiptsCondition #DeliveryNo").val($.jStorage.get("SearchDeliverBillReceiptsCondition_DeliveryNo", ""));
                    $("#formSearchDeliverBillReceiptsCondition #CarNo").val($.jStorage.get("SearchDeliverBillReceiptsCondition_CarNo", ""));

                    $("#formSearchDeliverBillReceiptsCondition #DestCountry").val($.jStorage.get("SearchDeliverBillReceiptsCondition_DestCountry", ""));

                    $("#formSearchDeliverBillReceiptsCondition #DestProvince").empty();
                    $("#formSearchDeliverBillReceiptsCondition #DestProvince").append("<option value=''></option>");

                    $("#formSearchDeliverBillReceiptsCondition #DestCity").empty();
                    $("#formSearchDeliverBillReceiptsCondition #DestCity").append("<option value=''></option>");

                    if ($("#formSearchDeliverBillReceiptsCondition #DestCountry").val().trim() != "") {
                        $.get("/Common/LoadProvincesByCountry", { strCountryName: $("#formSearchDeliverBillReceiptsCondition #DestCountry").val().trim() }, function (ret) {
                            $.each(ret, function (i, province) {
                                var option = $("<option></option>").val(province).text(province);
                                option.appendTo($("#formSearchDeliverBillReceiptsCondition #DestProvince"));
                            });
                            $("#formSearchDeliverBillReceiptsCondition #DestProvince").val($.jStorage.get("SearchDeliverBillReceiptsCondition_DestProvince", ""));

                            if ($("#formSearchDeliverBillReceiptsCondition #DestProvince").val().trim() != "") {
                                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formSearchDeliverBillReceiptsCondition #DestCountry").val().trim(), strProvinceName: $("#formSearchDeliverBillReceiptsCondition #DestProvince").val().trim() }, function (ret) {
                                    $.each(ret, function (i, city) {
                                        var option = $("<option></option>").val(city).text(city);
                                        option.appendTo($("#formSearchDeliverBillReceiptsCondition #DestCity"));
                                    });
                                    $("#formSearchDeliverBillReceiptsCondition #DestCity").val($.jStorage.get("SearchDeliverBillReceiptsCondition_DestCity", ""));
                                }, "text json").error(function (xhr, status, error) {
                                    $("#formSearchDeliverBillReceiptsCondition #DestProvince").val("");
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#formSearchDeliverBillReceiptsCondition #DestCountry").val("");
                        });
                    }

                    $("#formSearchDeliverBillReceiptsCondition #OrganId").val($.jStorage.get("SearchDeliverBillReceiptsCondition_OrganId", ""));

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //导出数据
            this.export = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 3060, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if ($("#grid1").jqGrid("getGridParam", "records") == 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.ExportMustAfterSearch %>");
                        return;
                    }

                    var url = action + "?" +
                    "startTime=" + $("#formSearchDeliverBillReceiptsCondition #StartTime").val().trim() + "&" +
                    "endTime=" + $("#formSearchDeliverBillReceiptsCondition #EndTime").val().trim() + "&" +
                    "customerName=" + $("#formSearchDeliverBillReceiptsCondition #CustomerName").val().trim() + "&" +
                    "deliveryNo=" + $("#formSearchDeliverBillReceiptsCondition #DeliveryNo").val().trim() + "&" +
                    "carNo=" + $("#formSearchDeliverBillReceiptsCondition #CarNo").val().trim() + "&" +
                    "destCountry=" + $("#formSearchDeliverBillReceiptsCondition #DestCountry").val().trim() + "&" +
                    "destProvince=" + $("#formSearchDeliverBillReceiptsCondition #DestProvince").val().trim() + "&" +
                    "destCity=" + $("#formSearchDeliverBillReceiptsCondition #DestCity").val().trim() + "&" +
                    "organId=" + $("#formSearchDeliverBillReceiptsCondition #OrganId").val().trim();

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
                    carNo: "",
                    destCountry: "",
                    destProvince: "",
                    destCity: "",
                    organId: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverBillNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliverDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.Pieces %>",
                    "<%: InnoSoft.LS.Resources.Labels.Tunnages %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReturnTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.DamageInfo %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "BillNo", index: "BillNo", width: 100, align: "center" },
                    { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                    { name: "CustomerName", index: "CustomerName", width: 200 },
                    { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                    { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                    { name: "ReceiverName", index: "ReceiverName", width: 200 },
                    { name: "CarNo", index: "CarNo", width: 80, align: "center" },
                    { name: "Packages", index: "Packages", width: 60, align: "center" },
                    { name: "Tunnages", index: "Tunnages", width: 100, align: "center" },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                    { name: "ReturnTime", index: "ReturnTime", width: 80, align: "center" },
                    { name: "DamageInfo", index: "DamageInfo", width: 200 }],
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
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 400,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formSearchDeliverBillReceiptsCondition").valid()) {
                            //缓存查询条件
                            $.jStorage.set("SearchDeliverBillReceiptsCondition_StartTime", $("#formSearchDeliverBillReceiptsCondition #StartTime").val().trim());
                            $.jStorage.set("SearchDeliverBillReceiptsCondition_EndTime", $("#formSearchDeliverBillReceiptsCondition #EndTime").val().trim());
                            $.jStorage.set("SearchDeliverBillReceiptsCondition_CustomerName", $("#formSearchDeliverBillReceiptsCondition #CustomerName").val().trim());
                            $.jStorage.set("SearchDeliverBillReceiptsCondition_DeliveryNo", $("#formSearchDeliverBillReceiptsCondition #DeliveryNo").val().trim());
                            $.jStorage.set("SearchDeliverBillReceiptsCondition_CarNo", $("#formSearchDeliverBillReceiptsCondition #CarNo").val().trim());
                            $.jStorage.set("SearchDeliverBillReceiptsCondition_DestCountry", $("#formSearchDeliverBillReceiptsCondition #DestCountry").val().trim());
                            $.jStorage.set("SearchDeliverBillReceiptsCondition_DestProvince", $("#formSearchDeliverBillReceiptsCondition #DestProvince").val().trim());
                            $.jStorage.set("SearchDeliverBillReceiptsCondition_DestCity", $("#formSearchDeliverBillReceiptsCondition #DestCity").val().trim());
                            $.jStorage.set("SearchDeliverBillReceiptsCondition_OrganId", $("#formSearchDeliverBillReceiptsCondition #OrganId").val().trim());

                            //重新加载表格
                            $("#grid1").jqGrid("setGridParam", {
                                url: "/chenxk/Deliver/LoadSearchDeliverBillReceiptsGrid/",
                                datatype: "json",
                                postData: {
                                    startTime: $("#formSearchDeliverBillReceiptsCondition #StartTime").val().trim(),
                                    endTime: $("#formSearchDeliverBillReceiptsCondition #EndTime").val().trim(),
                                    customerName: $("#formSearchDeliverBillReceiptsCondition #CustomerName").val().trim(),
                                    deliveryNo: $("#formSearchDeliverBillReceiptsCondition #DeliveryNo").val().trim(),
                                    carNo: $("#formSearchDeliverBillReceiptsCondition #CarNo").val().trim(),
                                    destCountry: $("#formSearchDeliverBillReceiptsCondition #DestCountry").val().trim(),
                                    destProvince: $("#formSearchDeliverBillReceiptsCondition #DestProvince").val().trim(),
                                    destCity: $("#formSearchDeliverBillReceiptsCondition #DestCity").val().trim(),
                                    organId: $("#formSearchDeliverBillReceiptsCondition #OrganId").val().trim()
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

    </script>
</asp:Content>
