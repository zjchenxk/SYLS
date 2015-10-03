<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.CustomerViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ModifyCustomer %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/System/SetCustomer/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveCustomer();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("ModifyCustomer", "System", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.BasicInfo %></legend>
        <%: Html.HiddenFor(model => model.Id)%>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Name) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Name)%>
                        <%: Html.ValidationMessageFor(model => model.Name) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.FullName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.FullName)%>
                        <%: Html.ValidationMessageFor(model => model.FullName)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.WarningStock) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.WarningStock)%>
                        <%: Html.ValidationMessageFor(model => model.WarningStock)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.StopStock) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.StopStock)%>
                        <%: Html.ValidationMessageFor(model => model.StopStock)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.SettlementExpression) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.SettlementExpression)%>
                        <span class="formInfo"><a href="/Help/SettlementExpression/?width=350" class="jTip"
                            id="tooltipSettlementExpression" name="<%: InnoSoft.LS.Resources.Titles.Tooltip %>">?</a></span>
                        <%: Html.ValidationMessageFor(model => model.SettlementExpression)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ValuationMode) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.ValuationMode, new SelectListItem[] { new SelectListItem { Text = InnoSoft.LS.Resources.Options.ValuationMode1, Value = InnoSoft.LS.Resources.Options.ValuationMode1, Selected = true }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.ValuationMode2, Value = InnoSoft.LS.Resources.Options.ValuationMode2 }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.ValuationMode3, Value = InnoSoft.LS.Resources.Options.ValuationMode3 } }, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.ValuationMode)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.GrossWeightRate) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.GrossWeightRate)%>
                        <%: Html.ValidationMessageFor(model => model.GrossWeightRate)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.OwnOrganId) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.OwnOrganId, ViewData["OwnOrgans"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.OwnOrganId)%>
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
                        <%: Html.EditorFor(model => model.Remark)%>
                        <%: Html.ValidationMessageFor(model => model.Remark) %>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.SettlementPriceList%></legend>
        <div>
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnNewTransportPrice" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.New %>
            </button>
            <button id="btnModifyTransportPrice" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
            <button id="btnDeleteTransportPrice" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.ForceFeePriceList%></legend>
        <div>
            <table id="grid2">
            </table>
            <div id="pager2">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnNewForceFeePrice" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.New %>
            </button>
            <button id="btnModifyForceFeePrice" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
            <button id="btnDeleteForceFeePrice" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.StorageFeePriceList%></legend>
        <div>
            <table id="grid3">
            </table>
            <div id="pager3">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnNewStorageFeePrice" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.New %>
            </button>
            <button id="btnModifyStorageFeePrice" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
            <button id="btnDeleteStorageFeePrice" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <% } %>
    <div id="dialogTransportPrice" title="">
        <% Html.RenderPartial("CustomerTransportPrice", Model.TransportPrices[0]); %>
    </div>
    <div id="dialogForceFeePrice" title="">
        <% Html.RenderPartial("CustomerForceFeePrice", Model.ForceFeePrices[0]); %>
    </div>
    <div id="dialogStorageFeePrice" title="">
        <% Html.RenderPartial("CustomerStorageFeePrice", Model.StorageFeePrices[0]); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //新增客户结算价格标志
            this.isNewCustomerTransportPrice = true;
            //当前选中客户结算价格记录编码
            this.selectedCustomerTransportPriceId = null;
            //新增客户力支费价格标志
            this.isNewCustomerForceFeePrice = true;
            //当前选中客户力支费价格记录编码
            this.selectedCustomerForceFeePriceId = null;
            //新增客户仓储费价格标志
            this.isNewCustomerStorageFeePrice = true;
            //当前选中客户仓储费价格记录编码
            this.selectedCustomerStorageFeePriceId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
                $("#grid2").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
                $("#grid3").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认名称获得焦点
                $("#Name").focus().select();
            };
            //新增客户结算价格
            this.newCustomerTransportPrice = function () {
                //设置编辑模式为新增
                this.isNewCustomerTransportPrice = true;

                //初始化控件数据
                $("#formTransportPrice #StartCountry").val("");

                $("#formTransportPrice #StartProvince").empty();
                $("#formTransportPrice #StartProvince").append("<option value=''></option>");

                $("#formTransportPrice #StartCity").empty();
                $("#formTransportPrice #StartCity").append("<option value=''></option>");

                $("#formTransportPrice #DestCountry").val("");

                $("#formTransportPrice #DestProvince").empty();
                $("#formTransportPrice #DestProvince").append("<option value=''></option>");

                $("#formTransportPrice #DestCity").empty();
                $("#formTransportPrice #DestCity").append("<option value=''></option>");

                $("#formTransportPrice #MinTunnagesOrPiles").val("");

                $("#formTransportPrice #MaxTunnagesOrPiles").val("");

                var today = new Date();
                $("#formTransportPrice #StartTime").val(formatDate(today, "yyyy-MM-dd"));

                $("#formTransportPrice #EndTime").val("9999-12-31");

                $("#formTransportPrice #CarType").val("");

                $("#formTransportPrice #TransportPrice").val("");
                $("#formTransportPrice #RiverCrossingCharges").val("");

                //打开对话框
                $("#dialogTransportPrice").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewCustomerTransportPrice %>");
                $("#dialogTransportPrice").dialog("open");
            };
            //修改客户结算价格
            this.modifyCustomerTransportPrice = function () {
                //读取选中的结算价格数据
                if (this.selectedCustomerTransportPriceId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCustomerTransportPrice %>");
                    return;
                }
                var data = $("#grid1").jqGrid("getRowData", this.selectedCustomerTransportPriceId);

                //初始化控件数据
                $("#formTransportPrice #StartCountry").val(data.StartCountry);

                $("#formTransportPrice #StartProvince").empty();
                $("#formTransportPrice #StartProvince").append("<option value=''></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: data.StartCountry }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $("<option></option>").val(province).text(province);
                        option.appendTo($("#formTransportPrice #StartProvince"));
                    });
                    $("#formTransportPrice #StartProvince").val(data.StartProvince);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    return;
                });

                $("#formTransportPrice #StartCity").empty();
                $("#formTransportPrice #StartCity").append("<option value=''></option>");

                $.get("/Common/LoadCitysByProvince", { strCountryName: data.StartCountry, strProvinceName: data.StartProvince }, function (ret) {
                    $.each(ret, function (i, city) {
                        var option = $("<option></option>").val(city).text(city);
                        option.appendTo($("#formTransportPrice #StartCity"));
                    });
                    $("#formTransportPrice #StartCity").val(data.StartCity);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    return;
                });

                $("#formTransportPrice #DestCountry").val(data.DestCountry);

                $("#formTransportPrice #DestProvince").empty();
                $("#formTransportPrice #DestProvince").append("<option value=''></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: data.DestCountry }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $("<option></option>").val(province).text(province);
                        option.appendTo($("#formTransportPrice #DestProvince"));
                    });
                    $("#formTransportPrice #DestProvince").val(data.DestProvince);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    return;
                });

                $("#formTransportPrice #DestCity").empty();
                $("#formTransportPrice #DestCity").append("<option value=''></option>");

                $.get("/Common/LoadCitysByProvince", { strCountryName: data.DestCountry, strProvinceName: data.DestProvince }, function (ret) {
                    $.each(ret, function (i, city) {
                        var option = $("<option></option>").val(city).text(city);
                        option.appendTo($("#formTransportPrice #DestCity"));
                    });
                    $("#formTransportPrice #DestCity").val(data.DestCity);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    return;
                });

                $("#formTransportPrice #MinTunnagesOrPiles").val(data.MinTunnagesOrPiles);

                $("#formTransportPrice #MaxTunnagesOrPiles").val(data.MaxTunnagesOrPiles);

                $("#formTransportPrice #StartTime").val(data.StartTime);

                $("#formTransportPrice #EndTime").val(data.EndTime);

                $("#formTransportPrice #CarType").val(data.CarType);

                $("#formTransportPrice #TransportPrice").val(data.TransportPrice);

                $("#formTransportPrice #RiverCrossingCharges").val(data.RiverCrossingCharges);

                //设置编辑模式为修改
                this.isNewCustomerTransportPrice = false;

                //打开对话框
                $("#dialogTransportPrice").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyCustomerTransportPrice %>");
                $("#dialogTransportPrice").dialog("open");
            };
            //删除客户结算价格
            this.deleteCustomerTransportPrice = function () {
                if (this.selectedCustomerTransportPriceId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCustomerTransportPrice %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteCustomerTransportPriceConfirm %>") == true) {
                    $("#grid1").jqGrid("delRowData", this.selectedCustomerTransportPriceId);
                    this.selectedCustomerTransportPriceId = null;
                }
            };
            //新增客户力支费价格
            this.newCustomerForceFeePrice = function () {
                //设置编辑模式为新增
                this.isNewCustomerForceFeePrice = true;

                //初始化控件数据
                var today = new Date();
                $("#formForceFeePrice #ForceFeePriceStartTime").val(formatDate(today, "yyyy-MM-dd"));

                $("#formForceFeePrice #ForceFeePriceEndTime").val("9999-12-31");

                $("#formForceFeePrice #LoadingForceFeePrice").val("");

                $("#formForceFeePrice #UnloadingForceFeePrice").val("");

                //打开对话框
                $("#dialogForceFeePrice").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewCustomerForceFeePrice %>");
                $("#dialogForceFeePrice").dialog("open");
            };
            //修改客户力支费价格
            this.modifyCustomerForceFeePrice = function () {
                //读取选中的力支费价格数据
                if (this.selectedCustomerForceFeePriceId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCustomerForceFeePrice %>");
                    return;
                }
                var data = $("#grid2").jqGrid("getRowData", this.selectedCustomerForceFeePriceId);

                //初始化控件数据
                $("#formForceFeePrice #ForceFeePriceStartTime").val(data.StartTime);

                $("#formForceFeePrice #ForceFeePriceEndTime").val(data.EndTime);

                $("#formForceFeePrice #LoadingForceFeePrice").val(data.LoadingForceFeePrice);

                $("#formForceFeePrice #UnloadingForceFeePrice").val(data.UnloadingForceFeePrice);

                //设置编辑模式为修改
                this.isNewCustomerForceFeePrice = false;

                //打开对话框
                $("#dialogForceFeePrice").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyCustomerForceFeePrice %>");
                $("#dialogForceFeePrice").dialog("open");
            };
            //删除客户力支费价格
            this.deleteCustomerForceFeePrice = function () {
                if (this.selectedCustomerForceFeePriceId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCustomerForceFeePrice %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteCustomerForceFeePriceConfirm %>") == true) {
                    $("#grid2").jqGrid("delRowData", this.selectedCustomerForceFeePriceId);
                    this.selectedCustomerForceFeePriceId = null;
                }
            };
            //新增客户仓储费价格
            this.newCustomerStorageFeePrice = function () {
                //设置编辑模式为新增
                this.isNewCustomerStorageFeePrice = true;

                //初始化控件数据
                var today = new Date();
                $("#formStorageFeePrice #StorageFeePriceStartTime").val(formatDate(today, "yyyy-MM-dd"));

                $("#formStorageFeePrice #StorageFeePriceEndTime").val("9999-12-31");

                $("#formStorageFeePrice #StorageFeePrice").val("");

                //打开对话框
                $("#dialogStorageFeePrice").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewCustomerStorageFeePrice %>");
                $("#dialogStorageFeePrice").dialog("open");
            };
            //修改客户仓储费价格
            this.modifyCustomerStorageFeePrice = function () {
                //读取选中的仓储费价格数据
                if (this.selectedCustomerStorageFeePriceId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCustomerStorageFeePrice %>");
                    return;
                }
                var data = $("#grid3").jqGrid("getRowData", this.selectedCustomerStorageFeePriceId);

                //初始化控件数据
                $("#formStorageFeePrice #StorageFeePriceStartTime").val(data.StartTime);

                $("#formStorageFeePrice #StorageFeePriceEndTime").val(data.EndTime);

                $("#formStorageFeePrice #StorageFeePrice").val(data.StorageFeePrice);

                //设置编辑模式为修改
                this.isNewCustomerStorageFeePrice = false;

                //打开对话框
                $("#dialogStorageFeePrice").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyCustomerStorageFeePrice %>");
                $("#dialogStorageFeePrice").dialog("open");
            };
            //删除客户仓储费价格
            this.deleteCustomerStorageFeePrice = function () {
                if (this.selectedCustomerStorageFeePriceId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCustomerStorageFeePrice %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteCustomerStorageFeePriceConfirm %>") == true) {
                    $("#grid3").jqGrid("delRowData", this.selectedCustomerStorageFeePriceId);
                    this.selectedCustomerStorageFeePriceId = null;
                }
            };
            //保存数据
            this.saveCustomer = function () {
                $("#form1").submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //#region 结算价格代码

            //设置结算公式自动完成
            var transportChargeExpressions = [
                "<%: InnoSoft.LS.Resources.Strings.TransportChargeExpression1 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportChargeExpression2 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportChargeExpression3 %>",
                "<%: InnoSoft.LS.Resources.Strings.TransportChargeExpression4 %>"
            ];
            $("#SettlementExpression").autocomplete({
                source: transportChargeExpressions
            });

            //创建结算价格表格
            $("#grid1").jqGrid({
                url: "/chenxk/System/LoadCustomerTransportPriceGrid/" + $("#Id").val().trim(),
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartCountry %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartProvince %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartCity %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestCountry %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestProvince %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestCity %>",
                    "<%: InnoSoft.LS.Resources.Labels.MinTunnagesOrPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.MaxTunnagesOrPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.EndTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarType %>",
                    "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.RiverCrossingCharges %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "StartCountry", index: "StartCountry", width: 80, align: "center" },
                    { name: "StartProvince", index: "StartProvince", width: 150, align: "center" },
                    { name: "StartCity", index: "StartCity", width: 100, align: "center" },
                    { name: "DestCountry", index: "DestCountry", width: 80, align: "center" },
                    { name: "DestProvince", index: "DestProvince", width: 150, align: "center" },
                    { name: "DestCity", index: "DestCity", width: 100, align: "center" },
                    { name: "MinTunnagesOrPiles", index: "MinTunnagesOrPiles", width: 100, align: "center" },
                    { name: "MaxTunnagesOrPiles", index: "MaxTunnagesOrPiles", width: 100, align: "center" },
                    { name: "StartTime", index: "StartTime", width: 80 },
                    { name: "EndTime", index: "EndTime", width: 80 },
                    { name: "CarType", index: "CarType", width: 60, align: "center" },
                    { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right" },
                    { name: "RiverCrossingCharges", index: "RiverCrossingCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedCustomerTransportPriceId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //新增结算价格按钮点击事件
            $("#btnNewTransportPrice").button().click(function () {
                objMain.objWorkspace.objContent.newCustomerTransportPrice();
            });

            //修改结算价格按钮点击事件
            $("#btnModifyTransportPrice").button().click(function () {
                objMain.objWorkspace.objContent.modifyCustomerTransportPrice();
            });

            //删除结算价格按钮点击事件
            $("#btnDeleteTransportPrice").button().click(function () {
                objMain.objWorkspace.objContent.deleteCustomerTransportPrice();
            });

            //创建结算价格编辑对话框
            $("#dialogTransportPrice").dialog({
                autoOpen: false,
                height: 550,
                width: 580,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formTransportPrice").valid()) {
                            if (objMain.objWorkspace.objContent.isNewCustomerTransportPrice) {
                                //新增客户结算价格
                                var rowcount = $("#grid1").jqGrid("getGridParam", "records");
                                if (rowcount == 0) {
                                    $("#grid1").jqGrid("addRowData", 1, {
                                        StartCountry: $("#formTransportPrice #StartCountry").val().trim(),
                                        StartProvince: $("#formTransportPrice #StartProvince").val().trim(),
                                        StartCity: $("#formTransportPrice #StartCity").val().trim(),
                                        DestCountry: $("#formTransportPrice #DestCountry").val().trim(),
                                        DestProvince: $("#formTransportPrice #DestProvince").val().trim(),
                                        DestCity: $("#formTransportPrice #DestCity").val().trim(),
                                        MinTunnagesOrPiles: $("#formTransportPrice #MinTunnagesOrPiles").val().trim(),
                                        MaxTunnagesOrPiles: $("#formTransportPrice #MaxTunnagesOrPiles").val().trim(),
                                        StartTime: $("#formTransportPrice #StartTime").val().trim(),
                                        EndTime: $("#formTransportPrice #EndTime").val().trim(),
                                        CarType: $("#formTransportPrice #CarType").val().trim(),
                                        TransportPrice: $("#formTransportPrice #TransportPrice").val().trim(),
                                        RiverCrossingCharges: $("#formTransportPrice #RiverCrossingCharges").val().trim()
                                    });
                                }
                                else {
                                    //检查记录是否重复
                                    var rows = $("#grid1").jqGrid("getRowData");
                                    for (var i = 0; i < rows.length; i++) {
                                        var row = rows[i];
                                        if (row.StartCountry == $("#formTransportPrice #StartCountry").val().trim() &&
                                            row.StartProvince == $("#formTransportPrice #StartProvince").val().trim() &&
                                            row.StartCity == $("#formTransportPrice #StartCity").val().trim() &&
                                            row.DestCountry == $("#formTransportPrice #DestCountry").val().trim() &&
                                            row.DestProvince == $("#formTransportPrice #DestProvince").val().trim() &&
                                            row.DestCity == $("#formTransportPrice #DestCity").val().trim() &&
                                            parseFloat(row.MinTunnagesOrPiles) < parseFloat($("#formTransportPrice #MaxTunnagesOrPiles").val().trim()) &&
                                            parseFloat(row.MaxTunnagesOrPiles) > parseFloat($("#formTransportPrice #MinTunnagesOrPiles").val().trim()) &&
                                            row.StartTime < $("#formTransportPrice #EndTime").val().trim() &&
                                            row.EndTime > $("#formTransportPrice #StartTime").val().trim() &&
                                            row.CarType == $("#formTransportPrice #CarType").val().trim()) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.CustomerTransportPriceIsExists %>");
                                            return;
                                        }
                                    }

                                    //添加数据
                                    var rowids = $("#grid1").jqGrid("getDataIDs");
                                    var rowidLast = rowids[rowcount - 1];

                                    $("#grid1").jqGrid("addRowData", parseFloat(rowidLast) + 1, {
                                        StartCountry: $("#formTransportPrice #StartCountry").val().trim(),
                                        StartProvince: $("#formTransportPrice #StartProvince").val().trim(),
                                        StartCity: $("#formTransportPrice #StartCity").val().trim(),
                                        DestCountry: $("#formTransportPrice #DestCountry").val().trim(),
                                        DestProvince: $("#formTransportPrice #DestProvince").val().trim(),
                                        DestCity: $("#formTransportPrice #DestCity").val().trim(),
                                        MinTunnagesOrPiles: $("#formTransportPrice #MinTunnagesOrPiles").val().trim(),
                                        MaxTunnagesOrPiles: $("#formTransportPrice #MaxTunnagesOrPiles").val().trim(),
                                        StartTime: $("#formTransportPrice #StartTime").val().trim(),
                                        EndTime: $("#formTransportPrice #EndTime").val().trim(),
                                        CarType: $("#formTransportPrice #CarType").val().trim(),
                                        TransportPrice: $("#formTransportPrice #TransportPrice").val().trim(),
                                        RiverCrossingCharges: $("#formTransportPrice #RiverCrossingCharges").val().trim()
                                    });
                                }
                            }
                            else {
                                //检查记录是否重复
                                var rowids = $("#grid1").jqGrid("getDataIDs");
                                var rows = $("#grid1").jqGrid("getRowData");
                                for (var i = 0; i < rows.length; i++) {
                                    var rowid = rowids[i];
                                    var row = rows[i];
                                    if (row.StartCountry == $("#formTransportPrice #StartCountry").val().trim() &&
                                        row.StartProvince == $("#formTransportPrice #StartProvince").val().trim() &&
                                        row.StartCity == $("#formTransportPrice #StartCity").val().trim() &&
                                        row.DestCountry == $("#formTransportPrice #DestCountry").val().trim() &&
                                        row.DestProvince == $("#formTransportPrice #DestProvince").val().trim() &&
                                        row.DestCity == $("#formTransportPrice #DestCity").val().trim() &&
                                        parseFloat(row.MinTunnagesOrPiles) < parseFloat($("#formTransportPrice #MaxTunnagesOrPiles").val().trim()) &&
                                        parseFloat(row.MaxTunnagesOrPiles) > parseFloat($("#formTransportPrice #MinTunnagesOrPiles").val().trim()) &&
                                        row.StartTime < $("#formTransportPrice #EndTime").val().trim() &&
                                        row.EndTime > $("#formTransportPrice #StartTime").val().trim() &&
                                        row.CarType == $("#formTransportPrice #CarType").val().trim() &&
                                        rowid != objMain.objWorkspace.objContent.selectedCustomerTransportPriceId) {
                                        alert("<%: InnoSoft.LS.Resources.Strings.CustomerTransportPriceIsExists %>");
                                        return;
                                    }
                                }

                                //修改客户结算价格
                                $("#grid1").jqGrid("setRowData", objMain.objWorkspace.objContent.selectedCustomerTransportPriceId, {
                                    StartCountry: $("#formTransportPrice #StartCountry").val().trim(),
                                    StartProvince: $("#formTransportPrice #StartProvince").val().trim(),
                                    StartCity: $("#formTransportPrice #StartCity").val().trim(),
                                    DestCountry: $("#formTransportPrice #DestCountry").val().trim(),
                                    DestProvince: $("#formTransportPrice #DestProvince").val().trim(),
                                    DestCity: $("#formTransportPrice #DestCity").val().trim(),
                                    MinTunnagesOrPiles: $("#formTransportPrice #MinTunnagesOrPiles").val().trim(),
                                    MaxTunnagesOrPiles: $("#formTransportPrice #MaxTunnagesOrPiles").val().trim(),
                                    StartTime: $("#formTransportPrice #StartTime").val().trim(),
                                    EndTime: $("#formTransportPrice #EndTime").val().trim(),
                                    CarType: $("#formTransportPrice #CarType").val().trim(),
                                    TransportPrice: $("#formTransportPrice #TransportPrice").val().trim(),
                                    RiverCrossingCharges: $("#formTransportPrice #RiverCrossingCharges").val().trim()
                                });
                            }
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

            //#endregion

            //#region 力支费价格代码

            //创建力支费价格表格
            $("#grid2").jqGrid({
                url: "/chenxk/System/LoadCustomerForceFeePriceGrid/" + $("#Id").val().trim(),
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.EndTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.LoadingForceFeePrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.UnloadingForceFeePrice %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "StartTime", index: "StartTime", width: 80 },
                    { name: "EndTime", index: "EndTime", width: 80 },
                    { name: "LoadingForceFeePrice", index: "LoadingForceFeePrice", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } },
                    { name: "UnloadingForceFeePrice", index: "UnloadingForceFeePrice", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "",
                sortorder: "asc",
                pager: "#pager2",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedCustomerForceFeePriceId = rowid;
                }
            });
            $("#grid2").jqGrid("navGrid", "#pager2", { edit: false, add: false, del: false, search: false });

            //新增力支费价格按钮点击事件
            $("#btnNewForceFeePrice").button().click(function () {
                objMain.objWorkspace.objContent.newCustomerForceFeePrice();
            });

            //修改力支费价格按钮点击事件
            $("#btnModifyForceFeePrice").button().click(function () {
                objMain.objWorkspace.objContent.modifyCustomerForceFeePrice();
            });

            //删除力支费价格按钮点击事件
            $("#btnDeleteForceFeePrice").button().click(function () {
                objMain.objWorkspace.objContent.deleteCustomerForceFeePrice();
            });

            //创建力支费价格编辑对话框
            $("#dialogForceFeePrice").dialog({
                autoOpen: false,
                height: 350,
                width: 580,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formForceFeePrice").valid()) {
                            if (objMain.objWorkspace.objContent.isNewCustomerForceFeePrice) {
                                //新增客户力支费价格
                                var rowcount = $("#grid2").jqGrid("getGridParam", "records");
                                if (rowcount == 0) {
                                    $("#grid2").jqGrid("addRowData", 1, {
                                        StartTime: $("#formForceFeePrice #ForceFeePriceStartTime").val().trim(),
                                        EndTime: $("#formForceFeePrice #ForceFeePriceEndTime").val().trim(),
                                        LoadingForceFeePrice: $("#formForceFeePrice #LoadingForceFeePrice").val().trim(),
                                        UnloadingForceFeePrice: $("#formForceFeePrice #UnloadingForceFeePrice").val().trim()
                                    });
                                }
                                else {
                                    //检查记录是否重复
                                    var rows = $("#grid2").jqGrid("getRowData");
                                    for (var i = 0; i < rows.length; i++) {
                                        var row = rows[i];
                                        if (row.StartTime < $("#formForceFeePrice #ForceFeePriceEndTime").val().trim() &&
                                            row.EndTime > $("#formForceFeePrice #ForceFeePriceStartTime").val().trim()) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.CustomerForceFeePriceIsExists %>");
                                            return;
                                        }
                                    }

                                    //添加数据
                                    var rowids = $("#grid2").jqGrid("getDataIDs");
                                    var rowidLast = rowids[rowcount - 1];

                                    $("#grid2").jqGrid("addRowData", parseFloat(rowidLast) + 1, {
                                        StartTime: $("#formForceFeePrice #ForceFeePriceStartTime").val().trim(),
                                        EndTime: $("#formForceFeePrice #ForceFeePriceEndTime").val().trim(),
                                        LoadingForceFeePrice: $("#formForceFeePrice #LoadingForceFeePrice").val().trim(),
                                        UnloadingForceFeePrice: $("#formForceFeePrice #UnloadingForceFeePrice").val().trim()
                                    });
                                }
                            }
                            else {
                                //检查记录是否重复
                                var rowids = $("#grid2").jqGrid("getDataIDs");
                                var rows = $("#grid2").jqGrid("getRowData");
                                for (var i = 0; i < rows.length; i++) {
                                    var rowid = rowids[i];
                                    var row = rows[i];
                                    if (row.StartTime < $("#formForceFeePrice #ForceFeePriceEndTime").val().trim() &&
                                        row.EndTime > $("#formForceFeePrice #ForceFeePriceStartTime").val().trim() &&
                                        rowid != objMain.objWorkspace.objContent.selectedCustomerForceFeePriceId) {
                                        alert("<%: InnoSoft.LS.Resources.Strings.CustomerForceFeePriceIsExists %>");
                                        return;
                                    }
                                }

                                //修改客户力支费价格
                                $("#grid2").jqGrid("setRowData", objMain.objWorkspace.objContent.selectedCustomerForceFeePriceId, {
                                    StartTime: $("#formForceFeePrice #ForceFeePriceStartTime").val().trim(),
                                    EndTime: $("#formForceFeePrice #ForceFeePriceEndTime").val().trim(),
                                    LoadingForceFeePrice: $("#formForceFeePrice #LoadingForceFeePrice").val().trim(),
                                    UnloadingForceFeePrice: $("#formForceFeePrice #UnloadingForceFeePrice").val().trim()
                                });
                            }
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

            //#endregion

            //#region 仓储费价格代码

            //创建仓储费价格表格
            $("#grid3").jqGrid({
                url: "/chenxk/System/LoadCustomerStorageFeePriceGrid/" + $("#Id").val().trim(),
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.EndTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.StorageFeePrice %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "StartTime", index: "StartTime", width: 80 },
                    { name: "EndTime", index: "EndTime", width: 80 },
                    { name: "StorageFeePrice", index: "StorageFeePrice", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: "," } }],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "",
                sortorder: "asc",
                pager: "#pager3",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedCustomerStorageFeePriceId = rowid;
                }
            });
            $("#grid3").jqGrid("navGrid", "#pager3", { edit: false, add: false, del: false, search: false });

            //新增仓储费价格按钮点击事件
            $("#btnNewStorageFeePrice").button().click(function () {
                objMain.objWorkspace.objContent.newCustomerStorageFeePrice();
            });

            //修改仓储费价格按钮点击事件
            $("#btnModifyStorageFeePrice").button().click(function () {
                objMain.objWorkspace.objContent.modifyCustomerStorageFeePrice();
            });

            //删除仓储费价格按钮点击事件
            $("#btnDeleteStorageFeePrice").button().click(function () {
                objMain.objWorkspace.objContent.deleteCustomerStorageFeePrice();
            });

            //创建仓储费价格编辑对话框
            $("#dialogStorageFeePrice").dialog({
                autoOpen: false,
                height: 350,
                width: 580,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formStorageFeePrice").valid()) {
                            if (objMain.objWorkspace.objContent.isNewCustomerStorageFeePrice) {
                                //新增客户仓储费价格
                                var rowcount = $("#grid3").jqGrid("getGridParam", "records");
                                if (rowcount == 0) {
                                    $("#grid3").jqGrid("addRowData", 1, {
                                        StartTime: $("#formStorageFeePrice #StorageFeePriceStartTime").val().trim(),
                                        EndTime: $("#formStorageFeePrice #StorageFeePriceEndTime").val().trim(),
                                        StorageFeePrice: $("#formStorageFeePrice #StorageFeePrice").val().trim()
                                    });
                                }
                                else {
                                    //检查记录是否重复
                                    var rows = $("#grid3").jqGrid("getRowData");
                                    for (var i = 0; i < rows.length; i++) {
                                        var row = rows[i];
                                        if (row.StartTime < $("#formStorageFeePrice #StorageFeePriceEndTime").val().trim() &&
                                            row.EndTime > $("#formStorageFeePrice #StorageFeePriceStartTime").val().trim()) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.CustomerStorageFeePriceIsExists %>");
                                            return;
                                        }
                                    }

                                    //添加数据
                                    var rowids = $("#grid3").jqGrid("getDataIDs");
                                    var rowidLast = rowids[rowcount - 1];

                                    $("#grid3").jqGrid("addRowData", parseFloat(rowidLast) + 1, {
                                        StartTime: $("#formStorageFeePrice #StorageFeePriceStartTime").val().trim(),
                                        EndTime: $("#formStorageFeePrice #StorageFeePriceEndTime").val().trim(),
                                        StorageFeePrice: $("#formStorageFeePrice #StorageFeePrice").val().trim()
                                    });
                                }
                            }
                            else {
                                //检查记录是否重复
                                var rowids = $("#grid3").jqGrid("getDataIDs");
                                var rows = $("#grid3").jqGrid("getRowData");
                                for (var i = 0; i < rows.length; i++) {
                                    var rowid = rowids[i];
                                    var row = rows[i];
                                    if (row.StartTime < $("#formStorageFeePrice #StorageFeePriceEndTime").val().trim() &&
                                        row.EndTime > $("#formStorageFeePrice #StorageFeePriceStartTime").val().trim() &&
                                        rowid != objMain.objWorkspace.objContent.selectedCustomerStorageFeePriceId) {
                                        alert("<%: InnoSoft.LS.Resources.Strings.CustomerStorageFeePriceIsExists %>");
                                        return;
                                    }
                                }

                                //修改客户仓储费价格
                                $("#grid3").jqGrid("setRowData", objMain.objWorkspace.objContent.selectedCustomerStorageFeePriceId, {
                                    StartTime: $("#formStorageFeePrice #StorageFeePriceStartTime").val().trim(),
                                    EndTime: $("#formStorageFeePrice #StorageFeePriceEndTime").val().trim(),
                                    StorageFeePrice: $("#formStorageFeePrice #StorageFeePrice").val().trim()
                                });
                            }
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

            //#endregion

            //#region 提交代码

            //提交事件
            $("#form1").submit(function () {
                if ($(this).valid()) {
                    //检查结算公式
                    var arrTokens = Tokanize($("#SettlementExpression").val().trim());
                    if (arrTokens == null || arrTokens == undefined) {
                        alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                        return false;
                    }
                    if (arrTokens.length <= 0) {
                        alert("<%: InnoSoft.LS.Resources.Strings.CanNotTokanizeExpression %>");
                        return false;
                    }
                    for (var i = 0; i < arrTokens.length; i++) {
                        if (arrTokens[i] != "(" && arrTokens[i] != ")" && IsVariable(arrTokens[i])) {
                            if (arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.KM %>" && arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Tunnages %>" && arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.Piles %>" && arrTokens[i] != "<%: InnoSoft.LS.Resources.Labels.TransportPrice %>") {
                                alert("<%: InnoSoft.LS.Resources.Strings.NotValidSettlementExpressionVariable %>");
                                return false;
                            }
                        }
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

                    //获取所有结算价格数据
                    var rows = $("#grid1").jqGrid("getRowData");
                    var transportPrices = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var p = {
                            "CustomerId": $("#Id").val().trim(),
                            "StartCountry": row.StartCountry,
                            "StartProvince": row.StartProvince,
                            "StartCity": row.StartCity,
                            "DestCountry": row.DestCountry,
                            "DestProvince": row.DestProvince,
                            "DestCity": row.DestCity,
                            "MinTunnagesOrPiles": row.MinTunnagesOrPiles,
                            "MaxTunnagesOrPiles": row.MaxTunnagesOrPiles,
                            "StartTime": row.StartTime,
                            "EndTime": row.EndTime,
                            "CarType": row.CarType,
                            "TransportPrice": row.TransportPrice,
                            "RiverCrossingCharges": row.RiverCrossingCharges
                        };
                        transportPrices.push(p);
                    }

                    //获取所有力支费价格数据
                    var rows = $("#grid2").jqGrid("getRowData");
                    var forceFeePrices = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var p = {
                            "CustomerId": $("#Id").val().trim(),
                            "ForceFeePriceStartTime": row.StartTime,
                            "ForceFeePriceEndTime": row.EndTime,
                            "LoadingForceFeePrice": row.LoadingForceFeePrice,
                            "UnloadingForceFeePrice": row.UnloadingForceFeePrice
                        };
                        forceFeePrices.push(p);
                    }

                    //获取所有仓储费价格数据
                    var rows = $("#grid3").jqGrid("getRowData");
                    var storageFeePrices = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var p = {
                            "CustomerId": $("#Id").val().trim(),
                            "StorageFeePriceStartTime": row.StartTime,
                            "StorageFeePriceEndTime": row.EndTime,
                            "StorageFeePrice": row.StorageFeePrice
                        };
                        storageFeePrices.push(p);
                    }

                    //生成JSON数据
                    var o = {
                        "Id": $("#Id").val().trim(),
                        "Name": $("#Name").val().trim(),
                        "FullName": $("#FullName").val().trim(),
                        "WarningStock": $("#WarningStock").val().trim(),
                        "StopStock": $("#StopStock").val().trim(),
                        "SettlementExpression": $("#SettlementExpression").val().trim(),
                        "ValuationMode": $("#ValuationMode").val().trim(),
                        "GrossWeightRate": $("#GrossWeightRate").val().trim(),
                        "Remark": $("#Remark").val().trim(),
                        "OwnOrganId": $("#OwnOrganId").val().trim(),
                        "TransportPrices": transportPrices,
                        "ForceFeePrices": forceFeePrices,
                        "StorageFeePrices": storageFeePrices
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

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceed %>");
                                location.replace("/chenxk/System/SetCustomer/");
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

            //#endregion

        });

    </script>
</asp:Content>
