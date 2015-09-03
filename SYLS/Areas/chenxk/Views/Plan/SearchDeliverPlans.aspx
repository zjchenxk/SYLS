<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SearchDeliverPlans %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.modifyDeliverPlan();return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/chenxk/Plan/DeleteDeliverPlan/" onclick="javascript:objMain.objWorkspace.objContent.deleteDeliverPlan(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete %></a></li>
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
        <% Html.RenderPartial("SearchDeliverPlanCondition"); %>
    </div>
    <div id="dialogRemark" title="">
        <% Html.RenderPartial("DeliverPlanRemark"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中计划编码
            this.selectedPlanId = null;
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
                $.get("/Common/LoadAccountPermission", { strFuncId: 1070, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formSearchDeliverPlanCondition #StartTime").val($.jStorage.get("SearchPlanCondition_StartTime", ""));
                    $("#formSearchDeliverPlanCondition #EndTime").val($.jStorage.get("SearchPlanCondition_EndTime", ""));
                    $("#formSearchDeliverPlanCondition #PlanNo").val($.jStorage.get("SearchPlanCondition_PlanNo", ""));
                    $("#formSearchDeliverPlanCondition #CustomerName").val($.jStorage.get("SearchPlanCondition_CustomerName", ""));
                    $("#formSearchDeliverPlanCondition #ShipmentNo").val($.jStorage.get("SearchPlanCondition_ShipmentNo", ""));
                    $("#formSearchDeliverPlanCondition #DeliveryNo").val($.jStorage.get("SearchPlanCondition_DeliveryNo", ""));
                    $("#formSearchDeliverPlanCondition #DeliverType").val($.jStorage.get("SearchPlanCondition_DeliverType", ""));
                    $("#formSearchDeliverPlanCondition #ReceiverName").val($.jStorage.get("SearchPlanCondition_ReceiverName", ""));

                    $("#formSearchDeliverPlanCondition #StartCountry").val($.jStorage.get("SearchPlanCondition_StartCountry", ""));

                    $("#formSearchDeliverPlanCondition #StartProvince").empty();
                    $("#formSearchDeliverPlanCondition #StartProvince").append("<option value=''></option>");

                    $("#formSearchDeliverPlanCondition #StartCity").empty();
                    $("#formSearchDeliverPlanCondition #StartCity").append("<option value=''></option>");

                    if ($("#formSearchDeliverPlanCondition #StartCountry").val().trim() != "") {
                        $.get("/Common/LoadProvincesByCountry", { strCountryName: $("#formSearchDeliverPlanCondition #StartCountry").val().trim() }, function (ret) {
                            $.each(ret, function (i, province) {
                                var option = $("<option></option>").val(province).text(province);
                                option.appendTo($("#formSearchDeliverPlanCondition #StartProvince"));
                            });
                            $("#formSearchDeliverPlanCondition #StartProvince").val($.jStorage.get("SearchPlanCondition_StartProvince", ""));

                            if ($("#formSearchDeliverPlanCondition #StartProvince").val().trim() != "") {
                                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formSearchDeliverPlanCondition #StartCountry").val().trim(), strProvinceName: $("#formSearchDeliverPlanCondition #StartProvince").val().trim() }, function (ret) {
                                    $.each(ret, function (i, city) {
                                        var option = $("<option></option>").val(city).text(city);
                                        option.appendTo($("#formSearchDeliverPlanCondition #StartCity"));
                                    });
                                    $("#formSearchDeliverPlanCondition #StartCity").val($.jStorage.get("SearchPlanCondition_StartCity", ""));
                                }, "text json").error(function (xhr, status, error) {
                                    $("#formSearchDeliverPlanCondition #StartProvince").val("");
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#formSearchDeliverPlanCondition #StartCountry").val("");
                        });
                    }

                    $("#formSearchDeliverPlanCondition #DestCountry").val($.jStorage.get("SearchPlanCondition_DestCountry", ""));

                    $("#formSearchDeliverPlanCondition #DestProvince").empty();
                    $("#formSearchDeliverPlanCondition #DestProvince").append("<option value=''></option>");

                    $("#formSearchDeliverPlanCondition #DestCity").empty();
                    $("#formSearchDeliverPlanCondition #DestCity").append("<option value=''></option>");

                    if ($("#formSearchDeliverPlanCondition #DestCountry").val().trim() != "") {
                        $.get("/Common/LoadProvincesByCountry", { strCountryName: $("#formSearchDeliverPlanCondition #DestCountry").val().trim() }, function (ret) {
                            $.each(ret, function (i, province) {
                                var option = $("<option></option>").val(province).text(province);
                                option.appendTo($("#formSearchDeliverPlanCondition #DestProvince"));
                            });
                            $("#formSearchDeliverPlanCondition #DestProvince").val($.jStorage.get("SearchPlanCondition_DestProvince", ""));

                            if ($("#formSearchDeliverPlanCondition #DestProvince").val().trim() != "") {
                                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#formSearchDeliverPlanCondition #DestCountry").val().trim(), strProvinceName: $("#formSearchDeliverPlanCondition #DestProvince").val().trim() }, function (ret) {
                                    $.each(ret, function (i, city) {
                                        var option = $("<option></option>").val(city).text(city);
                                        option.appendTo($("#formSearchDeliverPlanCondition #DestCity"));
                                    });
                                    $("#formSearchDeliverPlanCondition #DestCity").val($.jStorage.get("SearchPlanCondition_DestCity", ""));
                                }, "text json").error(function (xhr, status, error) {
                                    $("#formSearchDeliverPlanCondition #DestProvince").val("");
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#formSearchDeliverPlanCondition #DestCountry").val("");
                        });
                    }

                    $("#formSearchDeliverPlanCondition #CarNo").val($.jStorage.get("SearchPlanCondition_CarNo", ""));
                    $("#formSearchDeliverPlanCondition #GoodsNo").val($.jStorage.get("SearchPlanCondition_GoodsNo", ""));

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //修改计划
            this.modifyDeliverPlan = function () {
                if (objMain.objWorkspace.objContent.selectedPlanId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedPlan %>");
                    return;
                }

                $.get("/Common/LoadDeliverPlan", { nPlanId: objMain.objWorkspace.objContent.selectedPlanId }, function (ret) {
                    if (ret != null) {
                        //初始化控件数据
                        $("#formDeliverPlanRemark #Id").val(objMain.objWorkspace.objContent.selectedPlanId);
                        $("#formDeliverPlanRemark #Remark").val(ret.Remark);

                        //打开备注修改对话框
                        $("#dialogRemark").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyRemark %>");
                        $("#dialogRemark").dialog("open");
                    }
                    else {
                        alert("<%: InnoSoft.LS.Resources.Strings.LoadDeliverPlanFailed %>");
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除计划
            this.deleteDeliverPlan = function (action) {
                $.get("/Common/LoadAccountPermission", { strFuncId: 1070, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedPlanId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedPlan %>");
                        return;
                    }

                    var data = $("#grid1").jqGrid("getRowData", objMain.objWorkspace.objContent.selectedPlanId);
                    if (data.IsDelete == "Yes") {
                        alert("<%: InnoSoft.LS.Resources.Strings.PlanHadDeleted %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.CancelPlanConfirm2 %>") == true) {
                        if (data.IsContractReversed.toLowerCase() == "true") {
                            if (confirm("<%: InnoSoft.LS.Resources.Strings.CancelPlanConfirm3 %>") != true) {
                                return;
                            }
                        }

                        if (data.IsCustomerTransportChargesSettled.toLowerCase() == "true") {
                            if (confirm("<%: InnoSoft.LS.Resources.Strings.CancelPlanConfirm4 %>") != true) {
                                return;
                            }
                        }

                        if (data.IsCarrierTransportChargesSettled.toLowerCase() == "true") {
                            if (confirm("<%: InnoSoft.LS.Resources.Strings.CancelPlanConfirm5 %>") != true) {
                                return;
                            }
                        }

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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedPlanId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                location.replace("/chenxk/Plan/SearchDeliverPlans/");
                            }
                        });
                    }

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //查看详细信息
            this.viewDetails = function (rowid) {
                var data = $("#grid1").jqGrid("getRowData", rowid);
                if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.PaperPlan %>" || data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverPaperPlan %>") {
                    location.replace("/chenxk/Plan/ViewPaperPlanDetails/" + rowid);
                }
                else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.CanPlan %>" || data.PlanType == "<%: InnoSoft.LS.Resources.Options.NotDeliverCanPlan %>") {
                    location.replace("/chenxk/Plan/ViewCanPlanDetails/" + rowid);
                }
                else if (data.PlanType == "<%: InnoSoft.LS.Resources.Options.NoodlePlan %>") {
                    location.replace("/chenxk/Plan/ViewNoodlePlanDetails/" + rowid);
                }
                else {
                    location.replace("/chenxk/Plan/ViewOtherPlanDetails/" + rowid);
                }
            };
    };
    objMain.objWorkspace.objContent = new WorkspaceContent();

    //页面初始化
    $(document).ready(function () {
        //创建计划表格
        $("#grid1").jqGrid({
            url: "",
            datatype: "local",
            mtype: "GET",
            postData: {
                startTime: $.jStorage.get("SearchPlanCondition_StartTime", ""),
                endTime: $.jStorage.get("SearchPlanCondition_EndTime", ""),
                customerName: $.jStorage.get("SearchPlanCondition_CustomerName", ""),
                shipmentNo: $.jStorage.get("SearchPlanCondition_ShipmentNo", ""),
                deliveryNo: $.jStorage.get("SearchPlanCondition_DeliveryNo", ""),
                deliverType: $.jStorage.get("SearchPlanCondition_DeliverType", ""),
                receiverName: $.jStorage.get("SearchPlanCondition_ReceiverName", ""),
                startCountry: $.jStorage.get("SearchPlanCondition_StartCountry", ""),
                startProvince: $.jStorage.get("SearchPlanCondition_StartProvince", ""),
                startCity: $.jStorage.get("SearchPlanCondition_StartCity", ""),
                destCountry: $.jStorage.get("SearchPlanCondition_DestCountry", ""),
                destProvince: $.jStorage.get("SearchPlanCondition_DestProvince", ""),
                destCity: $.jStorage.get("SearchPlanCondition_DestCity", ""),
                carNo: $.jStorage.get("SearchPlanCondition_CarNo", ""),
                goodsNo: $.jStorage.get("SearchPlanCondition_GoodsNo", ""),
                planNo: $.jStorage.get("SearchPlanCondition_PlanNo", "")
            },
            colNames: [
                "<%: InnoSoft.LS.Resources.Labels.PlanId %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.CustomerName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ShipmentNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.DeliveryNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverName %>",
                    "<%: InnoSoft.LS.Resources.Labels.ReceiverAddress %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestPlace %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.CreateTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanState %>",
                    "<%: InnoSoft.LS.Resources.Labels.IsDelete %>",
                    "<%: InnoSoft.LS.Resources.Labels.IsContractReversed %>",
                    "<%: InnoSoft.LS.Resources.Labels.IsCustomerTransportChargesSettled %>",
                    "<%: InnoSoft.LS.Resources.Labels.IsCarrierTransportChargesSettled %>",
                    ""],
            colModel: [
                { name: "Id", index: "Id", width: 100, hidden: true },
                { name: "PlanNo", index: "PlanNo", width: 100, align: "center" },
                { name: "CustomerName", index: "CustomerName", width: 200 },
                { name: "ShipmentNo", index: "ShipmentNo", width: 120, align: "center" },
                { name: "DeliveryNo", index: "DeliveryNo", width: 120, align: "center" },
                { name: "ReceiverName", index: "ReceiverName", width: 200 },
                { name: "ReceiverAddress", index: "ReceiverAddress", width: 300 },
                { name: "StartCity", index: "StartCity", width: 60, align: "center" },
                { name: "ReceiverCity", index: "ReceiverCity", width: 60, align: "center" },
                { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                { name: "CreateTime", index: "CreateTime", width: 80, align: "center" },
                { name: "PlanState", index: "PlanState", width: 80, align: "center" },
                { name: "IsDelete", index: "IsDelete", width: 60, align: "center", formatter: "checkbox" },
                { name: "IsContractReversed", index: "IsContractReversed", width: 100, hidden: true },
                { name: "IsCustomerTransportChargesSettled", index: "IsCustomerTransportChargesSettled", width: 100, hidden: true },
                { name: "IsCarrierTransportChargesSettled", index: "IsCarrierTransportChargesSettled", width: 100, hidden: true },
                { name: "Actions", index: "Actions", width: 80, align: "center", sortable: false }],
            rowNum: 500,
            rowList: [50, 100, 500, 1000, 5000],
            sortname: "CreateTime",
            sortorder: "desc",
            pager: "#pager1",
            viewrecords: true,
            emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
            shrinkToFit: false,
            loadError: function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            },
            gridComplete: function () {
                var ids = $("#grid1").jqGrid("getDataIDs");
                for (var i = 0; i < ids.length; i++) {
                    var s = "<input style='height:22px;width:60px;' type='button' value='<%: InnoSoft.LS.Resources.Buttons.View %>' onclick='objMain.objWorkspace.objContent.viewDetails(" + ids[i] + ");' />";
                    $("#grid1").jqGrid("setRowData", ids[i], { Actions: s });

                    var data = $("#grid1").jqGrid("getRowData", ids[i]);
                    if (data.IsDelete == "Yes") {
                        $("#" + ids[i] + " > td:not(.jqgrid-rownum)").css({ "text-decoration": "line-through", "color": "red" });
                    }
                }
            },
            onSelectRow: function (rowid, status) {
                objMain.objWorkspace.objContent.selectedPlanId = rowid;
            }
        });
        $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

        //创建查询条件输入对话框
        $("#dialogCondition").dialog({
            autoOpen: false,
            height: 650,
            width: 540,
            modal: true,
            resizable: false,
            buttons: {
                "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                    //缓存查询条件
                    $.jStorage.set("SearchPlanCondition_StartTime", $("#formSearchDeliverPlanCondition #StartTime").val().trim());
                    $.jStorage.set("SearchPlanCondition_EndTime", $("#formSearchDeliverPlanCondition #EndTime").val().trim());
                    $.jStorage.set("SearchPlanCondition_PlanNo", $("#formSearchDeliverPlanCondition #PlanNo").val().trim());
                    $.jStorage.set("SearchPlanCondition_CustomerName", $("#formSearchDeliverPlanCondition #CustomerName").val().trim());
                    $.jStorage.set("SearchPlanCondition_ShipmentNo", $("#formSearchDeliverPlanCondition #ShipmentNo").val().trim());
                    $.jStorage.set("SearchPlanCondition_DeliveryNo", $("#formSearchDeliverPlanCondition #DeliveryNo").val().trim());
                    $.jStorage.set("SearchPlanCondition_DeliverType", $("#formSearchDeliverPlanCondition #DeliverType").val().trim());
                    $.jStorage.set("SearchPlanCondition_ReceiverName", $("#formSearchDeliverPlanCondition #ReceiverName").val().trim());
                    $.jStorage.set("SearchPlanCondition_StartCountry", $("#formSearchDeliverPlanCondition #StartCountry").val().trim());
                    $.jStorage.set("SearchPlanCondition_StartProvince", $("#formSearchDeliverPlanCondition #StartProvince").val().trim());
                    $.jStorage.set("SearchPlanCondition_StartCity", $("#formSearchDeliverPlanCondition #StartCity").val().trim());
                    $.jStorage.set("SearchPlanCondition_DestCountry", $("#formSearchDeliverPlanCondition #DestCountry").val().trim());
                    $.jStorage.set("SearchPlanCondition_DestProvince", $("#formSearchDeliverPlanCondition #DestProvince").val().trim());
                    $.jStorage.set("SearchPlanCondition_DestCity", $("#formSearchDeliverPlanCondition #DestCity").val().trim());
                    $.jStorage.set("SearchPlanCondition_CarNo", $("#formSearchDeliverPlanCondition #CarNo").val().trim());
                    $.jStorage.set("SearchPlanCondition_GoodsNo", $("#formSearchDeliverPlanCondition #GoodsNo").val().trim());

                    //重新加载表格
                    $("#grid1").jqGrid("setGridParam", {
                        url: "/chenxk/Plan/LoadSearchDeliverPlansGrid/",
                        datatype: "json",
                        postData: {
                            startTime: $("#formSearchDeliverPlanCondition #StartTime").val().trim(),
                            endTime: $("#formSearchDeliverPlanCondition #EndTime").val().trim(),
                            customerName: $("#formSearchDeliverPlanCondition #CustomerName").val().trim(),
                            shipmentNo: $("#formSearchDeliverPlanCondition #ShipmentNo").val().trim(),
                            deliveryNo: $("#formSearchDeliverPlanCondition #DeliveryNo").val().trim(),
                            deliverType: $("#formSearchDeliverPlanCondition #DeliverType").val().trim(),
                            receiverName: $("#formSearchDeliverPlanCondition #ReceiverName").val().trim(),
                            startCountry: $("#formSearchDeliverPlanCondition #StartCountry").val().trim(),
                            startProvince: $("#formSearchDeliverPlanCondition #StartProvince").val().trim(),
                            startCity: $("#formSearchDeliverPlanCondition #StartCity").val().trim(),
                            destCountry: $("#formSearchDeliverPlanCondition #DestCountry").val().trim(),
                            destProvince: $("#formSearchDeliverPlanCondition #DestProvince").val().trim(),
                            destCity: $("#formSearchDeliverPlanCondition #DestCity").val().trim(),
                            carNo: $("#formSearchDeliverPlanCondition #CarNo").val().trim(),
                            goodsNo: $("#formSearchDeliverPlanCondition #GoodsNo").val().trim(),
                            planNo: $("#formSearchDeliverPlanCondition #PlanNo").val().trim()
                        }
                    });
                    $("#grid1").trigger("reloadGrid", [{ page: 1 }]);

                    $(this).dialog("close");

                },
                "<%: InnoSoft.LS.Resources.Buttons.Cancel %>": function () {
                    $(this).dialog("close");
                }
            },
            close: function () {
            }
        });

        //创建修改备注对话框
        $("#dialogRemark").dialog({
            autoOpen: false,
            height: 200,
            width: 520,
            modal: true,
            resizable: false,
            buttons: {
                "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
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

                    var o = {
                        "Id": $("#formDeliverPlanRemark #Id").val().trim(),
                        "Remark": $("#formDeliverPlanRemark #Remark").val().trim()
                    };
                    var postData = JSON.stringify(o);

                    //发送数据
                    $.ajax({
                        type: "POST",
                        url: "/chenxk/Plan/ModifyDeliverPlanRemark",
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

                                $("#dialogRemark").dialog("close");
                            }
                        },
                        error: function (xhr, status, error) {
                            $.unblockUI();

                            if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);

                            $("#dialogRemark").dialog("close");
                        }
                    });
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
