<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.ContractViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ModifyContract %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Contract/SubmitContracts/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.save();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("ModifyContract", "Contract", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.BasicInfo %></legend>
        <%: Html.HiddenFor(model => model.Id) %>
        <%: Html.HiddenFor(model => model.DispatchBillId)%>
        <%: Html.HiddenFor(model => model.CarrierId) %>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ContractNo)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ContractNo)%>
                        <%: Html.ValidationMessageFor(model => model.ContractNo)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CarNo)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CarNo)%>
                        <%: Html.ValidationMessageFor(model => model.CarNo)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TrailerNo)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TrailerNo)%>
                        <%: Html.ValidationMessageFor(model => model.TrailerNo)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CarType)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.CarType, new SelectListItem[] { new SelectListItem { Text = string.Empty, Value = string.Empty }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.VanTruck, Value = InnoSoft.LS.Resources.Options.VanTruck }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.WoodenHandCart, Value = InnoSoft.LS.Resources.Options.WoodenHandCart } }, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.CarType)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DriverName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.TextBoxFor(model => model.DriverName, new { id = "txtDriverName" })%>
                        <%: Html.DropDownListFor(model => model.DriverName, new SelectListItem[] { new SelectListItem { Text = string.Empty, Value = string.Empty, Selected = true } }, new { id = "selDriverName", style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.DriverName)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DriverLicenseNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.DriverLicenseNo)%>
                        <%: Html.ValidationMessageFor(model => model.DriverLicenseNo)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DriverMobileTel) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.DriverMobileTel)%>
                        <%: Html.ValidationMessageFor(model => model.DriverMobileTel)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DriverHomeTel) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.DriverHomeTel)%>
                        <%: Html.ValidationMessageFor(model => model.DriverHomeTel)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CarrierName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CarrierName)%>
                        <%: Html.ValidationMessageFor(model => model.CarrierName)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.GoodsName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.GoodsName)%>
                        <%: Html.ValidationMessageFor(model => model.GoodsName)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Packing) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Packing)%>
                        <%: Html.ValidationMessageFor(model => model.Packing)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TotalPackages) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TotalPackages)%>
                        <%: Html.ValidationMessageFor(model => model.TotalPackages)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TotalTunnages) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TotalTunnages)%>
                        <%: Html.ValidationMessageFor(model => model.TotalTunnages)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TotalPiles) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TotalPiles)%>
                        <%: Html.ValidationMessageFor(model => model.TotalPiles)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TotalTenThousands) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TotalTenThousands)%>
                        <%: Html.ValidationMessageFor(model => model.TotalTenThousands)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.StartPlace) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.StartPlace)%>
                        <%: Html.ValidationMessageFor(model => model.StartPlace)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DestPlace) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.DestPlace)%>
                        <%: Html.ValidationMessageFor(model => model.DestPlace)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ShipmentTime) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ShipmentTime)%>
                        <%: Html.ValidationMessageFor(model => model.ShipmentTime)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ArrivalTime) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ArrivalTime)%>
                        <%: Html.ValidationMessageFor(model => model.ArrivalTime)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.TotalTransportCharges) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.TotalTransportCharges)%>
                        <%: Html.ValidationMessageFor(model => model.TotalTransportCharges)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.PrepayTransportCharges) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.PrepayTransportCharges)%>
                        <%: Html.ValidationMessageFor(model => model.PrepayTransportCharges)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ResidualTransportCharges) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ResidualTransportCharges)%>
                        <%: Html.ValidationMessageFor(model => model.ResidualTransportCharges)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.OriginalContractNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.OriginalContractNo)%>
                        <%: Html.ValidationMessageFor(model => model.OriginalContractNo)%>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.DeliveryList %></legend>
        <div>
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnModify" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
        </div>
    </fieldset>
    <% } %>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                $("#form1 #CarNo").focus().select();
            };
            //修改货物信息
            this.modify = function () {
                //读取选中的发货记录
                var id = $("#grid1").jqGrid("getGridParam", "selrow");
                if (id == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedContractDeliverPlan %>");
                    return;
                }
                var data = $("#grid1").jqGrid("getRowData", id);

                var url = "/chenxk/Contract/ModifyContractGoods/?" +
                            "id=" + data.Id + "&" +
                            "contractId=" + $("#form1 #Id").val().trim() + "&" +
                            "dispatchBillId=" + $("#form1 #DispatchBillId").val().trim() + "&" +
                            "planId=" + data.PlanId + "&" +
                            "planType=" + data.PlanType + "&" +
                            "receiveType=" + data.ReceiveType + "&" +
                            "transportChargeExpression=" + data.TransportChargeExpression + "&" +
                            "transportPriceExpression=" + data.TransportPriceExpression + "&" +
                            "km=" + data.KM + "&" +
                            "transportPrice=" + data.TransportPrice + "&" +
                            "transportCharges=" + data.TransportCharges + "&" +
                            "remark=" + data.Remark;

                location.replace(url);
            };
            //保存数据
            this.save = function () {
                //设置驾驶员姓名编辑框和下拉选择框相同数据，便于通过客户端验证
                if ($("#form1 #txtDriverName").css("display") == "none") {
                    $("#form1 #txtDriverName").val($("#form1 #selDriverName").find("option:selected").text());
                }
                else {
                    $("#form1 #selDriverName").empty();
                    $("#form1 #selDriverName").append("<option value='0'>" + $("#form1 #txtDriverName").val().trim() + "</option>");
                    $("#form1 #selDriverName").get(0).selectedIndex = 0;
                }

                if ($("#form1").valid()) {
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

                    //生成合同JSON数据
                    var o = {
                        "Id": $("#form1 #Id").val().trim(),
                        "DispatchBillId": $("#form1 #DispatchBillId").val().trim(),
                        "ContractNo": $("#form1 #ContractNo").val().trim(),
                        "CarNo": $("#form1 #CarNo").val().trim(),
                        "TrailerNo": $("#form1 #TrailerNo").val().trim(),
                        "CarType": $("#form1 #CarType").val().trim(),
                        "DriverName": $("#form1 #txtDriverName").val().trim(),
                        "DriverLicenseNo": $("#form1 #DriverLicenseNo").val().trim(),
                        "DriverMobileTel": $("#form1 #DriverMobileTel").val().trim(),
                        "DriverHomeTel": $("#form1 #DriverHomeTel").val().trim(),
                        "CarrierId": $("#form1 #CarrierId").val().trim(),
                        "CarrierName": $("#form1 #CarrierName").val().trim(),
                        "GoodsName": $("#form1 #GoodsName").val().trim(),
                        "Packing": $("#form1 #Packing").val().trim(),
                        "StartPlace": $("#form1 #StartPlace").val().trim(),
                        "DestPlace": $("#form1 #DestPlace").val().trim(),
                        "ShipmentTime": $("#form1 #ShipmentTime").val().trim(),
                        "ArrivalTime": $("#form1 #ArrivalTime").val().trim(),
                        "TotalPackages": $("#form1 #TotalPackages").val().trim(),
                        "TotalTunnages": $("#form1 #TotalTunnages").val().trim(),
                        "TotalPiles": $("#form1 #TotalPiles").val().trim(),
                        "TotalTenThousands": $("#form1 #TotalTenThousands").val().trim(),
                        "TotalTransportCharges": $("#form1 #TotalTransportCharges").val().trim(),
                        "PrepayTransportCharges": $("#form1 #PrepayTransportCharges").val().trim(),
                        "ResidualTransportCharges": $("#form1 #ResidualTransportCharges").val().trim(),
                        "OriginalContractNo": $("#form1 #OriginalContractNo").val().trim()
                    };
                    var postData = JSON.stringify(o);

                    //发送数据
                    $.ajax({
                        type: "POST",
                        url: "/chenxk/Contract/ModifyContract/",
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
                                location.replace("/chenxk/Contract/SubmitContracts/");
                            }
                        },
                        error: function (xhr, status, error) {
                            $.unblockUI();

                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        }
                    });
                }
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //设置控件只读
            $("#form1 #ContractNo").attr("disabled", "disabled");
            $("#form1 #GoodsName").attr("disabled", "disabled");
            $("#form1 #TotalPackages").attr("disabled", "disabled");
            $("#form1 #TotalTunnages").attr("disabled", "disabled");
            $("#form1 #TotalPiles").attr("disabled", "disabled");
            $("#form1 #TotalTenThousands").attr("disabled", "disabled");
            $("#form1 #StartPlace").attr("disabled", "disabled");
            $("#form1 #DestPlace").attr("disabled", "disabled");
            $("#form1 #TotalTransportCharges").attr("disabled", "disabled");
            $("#form1 #ResidualTransportCharges").attr("readonly", "readonly");
            document.getElementById("selDriverName").style.display = "none";

            //设置车号自动完成
            $("#form1 #CarNo").autocomplete({
                source: "/Autocomplete/LoadCarNos/",
                minLength: 1,
                change: function (event, ui) {
                    //填充挂号
                    $.get("/Common/LoadCarByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #TrailerNo").val(ret.TrailerNo);
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #CarNo").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        return;
                    });

                    //填充驾驶员姓名下拉列表
                    $.get("/Common/LoadDriversByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (ret) {
                        if (ret.length > 0) {
                            $("#form1 #txtDriverName").val("");
                            $("#form1 #selDriverName").empty();
                            $("#form1 #selDriverName").append("<option value=''></option>");

                            $.each(ret, function (i, driver) {
                                var option = $("<option></option>").val(driver.Id).text(driver.Name);
                                option.appendTo($("#form1 #selDriverName"));
                            });
                            $("#form1 #selDriverName").append("<option value='<%: InnoSoft.LS.Resources.Options.NewDriver %>'><%: InnoSoft.LS.Resources.Options.NewDriver %></option>");

                            //选中当前驾驶员
                            var count = $("#form1 #selDriverName option").length;
                            for (var i = 0; i < count; i++) {
                                if ($("#form1 #selDriverName").get(0).options[i].text == $("#form1 #txtDriverName").val().trim()) {
                                    $("#form1 #selDriverName").get(0).options[i].selected = true;
                                    break;
                                }
                            }

                            document.getElementById("txtDriverName").style.display = "none";
                            document.getElementById("selDriverName").style.display = "inline";
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #CarNo").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });

                    //填充承运单位、结算公式、单价和运费
                    $.get("/Common/LoadCarrierByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #CarrierId").val(ret.Id);
                            $("#form1 #CarrierName").val(ret.Name);
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #CarNo").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                        return;
                    });
                }
            });

            //设置驾驶员姓名信息
            if ($("#form1 #CarNo").val().trim() != "") {
                $.get("/Common/LoadDriversByCarNo", { strCarNo: $("#form1 #CarNo").val().trim() }, function (ret) {
                    if (ret.length > 0) {
                        $.each(ret, function (i, driver) {
                            var option = $("<option></option>").val(driver.Id).text(driver.Name);
                            option.appendTo($("#form1 #selDriverName"));
                        });
                        $("#form1 #selDriverName").append("<option value='<%: InnoSoft.LS.Resources.Options.NewDriver %>'><%: InnoSoft.LS.Resources.Options.NewDriver %></option>");

                        document.getElementById("txtDriverName").style.display = "none";
                        document.getElementById("selDriverName").style.display = "inline";

                        //选中当前驾驶员
                        var count = $("#form1 #selDriverName option").length;
                        for (var i = 0; i < count; i++) {
                            if ($("#form1 #selDriverName").get(0).options[i].text == $("#form1 #txtDriverName").val().trim()) {
                                $("#form1 #selDriverName").get(0).options[i].selected = true;
                                break;
                            }
                        }
                    }
                    else {
                        document.getElementById("txtDriverName").style.display = "inline";
                        document.getElementById("selDriverName").style.display = "none";
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            }

            //驾驶员姓名选择事件
            $("#form1 #selDriverName").change(function () {
                if ($("#form1 #selDriverName").val().trim() == "<%: InnoSoft.LS.Resources.Options.NewDriver %>") {
                    $("#form1 #txtDriverName").val("");

                    document.getElementById("selDriverName").style.display = "none";
                    document.getElementById("txtDriverName").style.display = "inline";

                    $("#form1 #txtDriverName").focus().select();
                }
                else if ($("#form1 #selDriverName").val().trim() != "") {
                    //读取选中驾驶员信息
                    $.get("/Common/LoadDriver", { nId: $("#form1 #selDriverName").val().trim() }, function (ret) {
                        $("#form1 #txtDriverName").val($("#form1 #selDriverName").val().trim());
                        $("#form1 #DriverLicenseNo").val(ret.LicenseNo);
                        $("#form1 #DriverMobileTel").val(ret.MobileTel);
                        $("#form1 #DriverHomeTel").val(ret.HomeTel);
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #txtDriverName").val("");
                        $("#form1 #selDriverName").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
                else {
                    $("#form1 #txtDriverName").val("");
                    $("#form1 #DriverLicenseNo").val("");
                    $("#form1 #DriverMobileTel").val("");
                    $("#form1 #DriverHomeTel").val("");
                }
            });

            //设置装运时间
            $("#form1 #ShipmentTime").datepicker($.datepicker.regional["zh-CN"]);

            //设置到达时间
            $("#form1 #ArrivalTime").datepicker($.datepicker.regional["zh-CN"]);

            //设置预付运费改变事件
            $("#form1 #PrepayTransportCharges").change(function () {
                //检查预付运费
                var prepayTransportCharges = parseFloat($("#form1 #PrepayTransportCharges").val().trim());
                if (isNaN(prepayTransportCharges)) {
                    $("#form1 #PrepayTransportCharges").val("");
                    return;
                }

                //计算剩余运费
                var totalTransportCharges = parseFloat($("#form1 #TotalTransportCharges").val().trim());
                $("#form1 #ResidualTransportCharges").val(totalTransportCharges - prepayTransportCharges);
            });

            //创建发货表格
            $("#grid1").jqGrid({
                url: "/chenxk/Contract/LoadContractDeliverPlansGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { contractId: $("#form1 #Id").val().trim() },
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
                    "",
                    "",
                    ""],
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
                    { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right" },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right", formatter: "currency", formatoptions: { thousandsSeparator: ","} },
                    { name: "Remark", index: "Remark", width: 200 },
                    { name: "TransportChargeExpression", index: "TransportChargeExpression", width: 100, hidden: true },
                    { name: "TransportPriceExpression", index: "TransportPriceExpression", width: 100, hidden: true },
                    { name: "KM", index: "KM", width: 60, hidden: true}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "PlanNo",
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
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //修改货物按钮点击事件
            $("#btnModify").button().click(function () {
                objMain.objWorkspace.objContent.modify();
            });

        });

    </script>
</asp:Content>
