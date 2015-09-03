<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.DeliverBillCarrierTransportPriceViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.NewDeliverBillCarrierTransportPrice %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.save();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("NewDeliverBillCarrierTransportPrice", "Settlement", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset style="border: none;">
        <%: Html.HiddenFor(model => model.DeliverBillId) %>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DeliverBillNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.DeliverBillNo) %>
                        <%: Html.ValidationMessageFor(model => model.DeliverBillNo) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="DeliveryNo">
                            <%: InnoSoft.LS.Resources.Labels.DeliveryNo %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" id="DeliveryNo" name="DeliveryNo" type="text"
                            readonly="readonly" value="" /><br />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="CarrierName">
                            <%: InnoSoft.LS.Resources.Labels.CarrierName %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" id="CarrierName" name="CarrierName" type="text" readonly="readonly"
                            value="" /><br />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="CarNo">
                            <%: InnoSoft.LS.Resources.Labels.CarNo %></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" id="CarNo" name="CarNo" type="text" readonly="readonly"
                            value="" /><br />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <label for="DispatchedTransportPrice">
                            <%: InnoSoft.LS.Resources.Labels.DispatchedTransportPrice%></label>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <input class="text-box single-line" id="DispatchedTransportPrice" name="DispatchedTransportPrice"
                            type="text" readonly="readonly" value="" /><br />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ActualTransportPrice)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ActualTransportPrice)%>
                        <%: Html.ValidationMessageFor(model => model.ActualTransportPrice)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ActualTransportCharges)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ActualTransportCharges)%>
                        <%: Html.ValidationMessageFor(model => model.ActualTransportCharges)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Remark)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Remark)%><br />
                        <%: Html.ValidationMessageFor(model => model.Remark)%>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <% } %>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认送货单号获得焦点
                $("#form1 #DeliverBillNo").focus().select();
            };
            //保存数据
            this.save = function () {
                if ($("#form1").valid()) {
                    //检查送货单编码
                    if ($("#form1 #DeliverBillId").val().trim() == "" || $("#form1 #DeliverBillId").val().trim() == "0") {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotEnterDeliverBillNo %>");
                        return;
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

                    //生成JSON数据
                    var o = {
                        "DeliverBillId": $("#form1 #DeliverBillId").val().trim(),
                        "DeliverBillNo": $("#form1 #DeliverBillNo").val().trim(),
                        "ActualTransportPrice": $("#form1 #ActualTransportPrice").val().trim(),
                        "ActualTransportCharges": $("#form1 #ActualTransportCharges").val().trim(),
                        "Remark": $("#form1 #Remark").val().trim()
                    };
                    var postData = JSON.stringify(o);

                    //发送数据
                    $.ajax({
                        type: "POST",
                        url: "/chenxk/Settlement/NewDeliverBillCarrierTransportPrice/",
                        data: postData,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceedNextAddNew %>");
                                location.replace("/chenxk/Settlement/NewDeliverBillCarrierTransportPrice/");
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
            //设置送货单号自动完成
            $("#form1 #DeliverBillNo").autocomplete({
                source: "/Autocomplete/LoadDeliverBillNos/",
                minLength: 1,
                change: function (event, ui) {
                    //填充送货单信息
                    $("#form1 #DeliverBillId").val("0");
                    $("#form1 #DeliveryNo").val("");
                    $("#form1 #CarrierName").val("");
                    $("#form1 #CarNo").val("");
                    $("#form1 #DispatchedTransportPrice").val("0");
                    $("#form1 #ActualTransportPrice").val("0");
                    $("#form1 #ActualTransportCharges").val("0");
                    $("#form1 #Remark").val("");

                    $.get("/Common/LoadDeliverBillByNo", { strDeliverBillNo: $("#form1 #DeliverBillNo").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #DeliverBillId").val(ret.Id);
                            $("#form1 #CarrierName").val(ret.CarrierName);
                            $("#form1 #CarNo").val(ret.CarNo);
                            $("#form1 #DispatchedTransportPrice").val(ret.TransportPrice);
                            var planId = ret.PlanId;

                            //读取发货计划数据
                            $.get("/Common/LoadDeliverPlan", { nPlanId: planId }, function (ret) {
                                if (ret != null) {
                                    $("#form1 #DeliveryNo").val(ret.DeliveryNo);
                                }
                            }, "text json").error(function (xhr, status, error) {
                                $("#form1 #DeliverBillNo").val("");
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                return;
                            });

                            //如果已有特殊结算价格，则填充
                            $.get("/chenxk/Settlement/LoadDeliverBillCarrierTransportPriceByDeliverBillId", { deliverBillId: $("#form1 #DeliverBillId").val().trim() }, function (ret) {
                                if (ret != null) {
                                    $("#form1 #ActualTransportPrice").val(ret.TransportPrice);
                                    $("#form1 #ActualTransportCharges").val(ret.TransportCharges);
                                    $("#form1 #Remark").val(ret.Remark);
                                }
                            }, "text json").error(function (xhr, status, error) {
                                $("#form1 #DeliverBillNo").val("");
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            });
                        }
                        else {
                            alert("<%: InnoSoft.LS.Resources.Strings.DeliverBillNoNotExists %>");
                            $("#form1 #DeliverBillNo").val("");
                            $("#form1 #DeliverBillNo").focus().select();
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #DeliverBillNo").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });
        });

    </script>
</asp:Content>
