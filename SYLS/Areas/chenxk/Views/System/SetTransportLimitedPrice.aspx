<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SetTransportLimitedPrice %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.searchTransportLimitedPrices();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/System/NewTransportLimitedPrice" onclick="javascript:objMain.objWorkspace.objContent.newTransportLimitedPrice(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.New%></a></li>
        <li><a href="/chenxk/System/ModifyTransportLimitedPrice/" onclick="javascript:objMain.objWorkspace.objContent.modifyTransportLimitedPrice(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/chenxk/System/DeleteTransportLimitedPrice/" onclick="javascript:objMain.objWorkspace.objContent.deleteTransportLimitedPrice(this.href);return false;">
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
        <% Html.RenderPartial("SearchTransportLimitedPricesCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中运费限价记录编码
            this.selectedTransportLimitedPriceId = null;
            //表格完成标志
            this.gridComplete = false;
            //自动选择定时器
            this.timerId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询运费限价记录
            this.searchTransportLimitedPrices = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9150, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formSearchTransportLimitedPricesCondition #PlanType").val($.jStorage.get("SearchTransportLimitedPricesCondition_PlanType", ""));

                    $("#formSearchTransportLimitedPricesCondition #StartCountry").val($.jStorage.get("SearchTransportLimitedPricesCondition_StartCountry", ""));

                    $("#formSearchTransportLimitedPricesCondition #StartProvince").empty();
                    $("#formSearchTransportLimitedPricesCondition #StartProvince").append("<option value=''></option>");

                    $("#formSearchTransportLimitedPricesCondition #StartCity").empty();
                    $("#formSearchTransportLimitedPricesCondition #StartCity").append("<option value=''></option>");

                    if ($.jStorage.get("SearchTransportLimitedPricesCondition_StartCountry", "") != "") {
                        $.get("/Common/LoadProvincesByCountry", {
                            strCountryName: $.jStorage.get("SearchTransportLimitedPricesCondition_StartCountry", "")
                        }, function (ret) {
                            $.each(ret, function (i, province) {
                                var option = $("<option></option>").val(province).text(province);
                                option.appendTo($("#formSearchTransportLimitedPricesCondition #StartProvince"));
                            });
                            $("#formSearchTransportLimitedPricesCondition #StartProvince").val($.jStorage.get("SearchTransportLimitedPricesCondition_StartProvince", ""));

                            if ($.jStorage.get("SearchTransportLimitedPricesCondition_StartProvince", "") != "") {
                                $.get("/Common/LoadCitysByProvince", {
                                    strCountryName: $.jStorage.get("SearchTransportLimitedPricesCondition_StartCountry", ""),
                                    strProvinceName: $.jStorage.get("SearchTransportLimitedPricesCondition_StartProvince", "")
                                }, function (ret) {
                                    $.each(ret, function (i, city) {
                                        var option = $("<option></option>").val(city).text(city);
                                        option.appendTo($("#formSearchTransportLimitedPricesCondition #StartCity"));
                                    });
                                    $("#formSearchTransportLimitedPricesCondition #StartCity").val($.jStorage.get("SearchTransportLimitedPricesCondition_StartCity", ""));
                                }, "text json").error(function (xhr, status, error) {
                                    $("#formSearchTransportLimitedPricesCondition #StartProvince").val("");
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#formSearchTransportLimitedPricesCondition #StartCountry").val("");
                        });
                    }

                    $("#formSearchTransportLimitedPricesCondition #DestCountry").val($.jStorage.get("SearchTransportLimitedPricesCondition_DestCountry", ""));

                    $("#formSearchTransportLimitedPricesCondition #DestProvince").empty();
                    $("#formSearchTransportLimitedPricesCondition #DestProvince").append("<option value=''></option>");

                    $("#formSearchTransportLimitedPricesCondition #DestCity").empty();
                    $("#formSearchTransportLimitedPricesCondition #DestCity").append("<option value=''></option>");

                    if ($.jStorage.get("SearchTransportLimitedPricesCondition_DestCountry", "") != "") {
                        $.get("/Common/LoadProvincesByCountry", {
                            strCountryName: $.jStorage.get("SearchTransportLimitedPricesCondition_DestCountry", "")
                        }, function (ret) {
                            $.each(ret, function (i, province) {
                                var option = $("<option></option>").val(province).text(province);
                                option.appendTo($("#formSearchTransportLimitedPricesCondition #DestProvince"));
                            });
                            $("#formSearchTransportLimitedPricesCondition #DestProvince").val($.jStorage.get("SearchTransportLimitedPricesCondition_DestProvince", ""));

                            if ($.jStorage.get("SearchTransportLimitedPricesCondition_DestProvince", "") != "") {
                                $.get("/Common/LoadCitysByProvince", {
                                    strCountryName: $.jStorage.get("SearchTransportLimitedPricesCondition_DestCountry", ""),
                                    strProvinceName: $.jStorage.get("SearchTransportLimitedPricesCondition_DestProvince", "")
                                }, function (ret) {
                                    $.each(ret, function (i, city) {
                                        var option = $("<option></option>").val(city).text(city);
                                        option.appendTo($("#formSearchTransportLimitedPricesCondition #DestCity"));
                                    });
                                    $("#formSearchTransportLimitedPricesCondition #DestCity").val($.jStorage.get("SearchTransportLimitedPricesCondition_DestCity", ""));
                                }, "text json").error(function (xhr, status, error) {
                                    $("#formSearchTransportLimitedPricesCondition #DestProvince").val("");
                                });
                            }
                        }, "text json").error(function (xhr, status, error) {
                            $("#formSearchTransportLimitedPricesCondition #DestCountry").val("");
                        });
                    }

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //新增运费限价记录
            this.newTransportLimitedPrice = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9150, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace(action);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //修改运费限价记录
            this.modifyTransportLimitedPrice = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9150, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedTransportLimitedPriceId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedTransportLimitedPrice %>");
                        return;
                    }

                    location.replace(action + objMain.objWorkspace.objContent.selectedTransportLimitedPriceId);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除运费限价记录
            this.deleteTransportLimitedPrice = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9150, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedTransportLimitedPriceId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedTransportLimitedPrice %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteTransportLimitedPriceConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedTransportLimitedPriceId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                $("#grid1").trigger("reloadGrid", [{ page: 1 }]);
                                objMain.objWorkspace.objContent.selectedTransportLimitedPriceId = null;
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
            //创建运费限价表格
            $("#grid1").jqGrid({
                url: "",
                datatype: "local",
                mtype: "GET",
                postData: {
                    planType: "",
                    startCountry: "",
                    startProvince: "",
                    startCity: "",
                    destCountry: "",
                    destProvince: "",
                    destCity: "",
                    modifiedIds: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.PlanType %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartCountry %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartProvince %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartCity %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestCountry %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestProvince %>",
                    "<%: InnoSoft.LS.Resources.Labels.DestCity %>",
                    "<%: InnoSoft.LS.Resources.Labels.CarType %>",
                    "<%: InnoSoft.LS.Resources.Labels.MinTunnagesOrPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.MaxTunnagesOrPiles %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.EndTime %>",
                    "<%: InnoSoft.LS.Resources.Labels.LimitedTransportPrice %>",
                    "<%: InnoSoft.LS.Resources.Labels.LimitedTransportCharges %>"
                ],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "PlanType", index: "PlanType", width: 60, align: "center" },
                    { name: "StartCountry", index: "StartCountry", width: 80, align: "center" },
                    { name: "StartProvince", index: "StartProvince", width: 150, align: "center" },
                    { name: "StartCity", index: "StartCity", width: 100, align: "center" },
                    { name: "DestCountry", index: "StartCountry", width: 80, align: "center" },
                    { name: "DestProvince", index: "StartProvince", width: 150, align: "center" },
                    { name: "DestCity", index: "StartCity", width: 100, align: "center" },
                    { name: "CarType", index: "CarType", width: 60, align: "center" },
                    { name: "MinTunnagesOrPiles", index: "MinTunnagesOrPiles", width: 100, align: "center" },
                    { name: "MaxTunnagesOrPiles", index: "MaxTunnagesOrPiles", width: 100, align: "center" },
                    { name: "StartTime", index: "StartTime", width: 80 },
                    { name: "EndTime", index: "EndTime", width: 80 },
                    { name: "TransportPrice", index: "TransportPrice", width: 100, align: "right" },
                    { name: "TransportCharges", index: "TransportCharges", width: 100, align: "right" }
                ],
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
                gridComplete: function () {
                    objMain.objWorkspace.objContent.gridComplete = true;
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedTransportLimitedPriceId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 350,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        //缓存查询条件
                        $.jStorage.set("SearchTransportLimitedPricesCondition_InitGrid", "0");
                        $.jStorage.set("SearchTransportLimitedPricesCondition_PlanType", $("#formSearchTransportLimitedPricesCondition #PlanType").val().trim());
                        $.jStorage.set("SearchTransportLimitedPricesCondition_StartCountry", $("#formSearchTransportLimitedPricesCondition #StartCountry").val().trim());
                        $.jStorage.set("SearchTransportLimitedPricesCondition_StartProvince", $("#formSearchTransportLimitedPricesCondition #StartProvince").val().trim());
                        $.jStorage.set("SearchTransportLimitedPricesCondition_StartCity", $("#formSearchTransportLimitedPricesCondition #StartCity").val().trim());
                        $.jStorage.set("SearchTransportLimitedPricesCondition_DestCountry", $("#formSearchTransportLimitedPricesCondition #DestCountry").val().trim());
                        $.jStorage.set("SearchTransportLimitedPricesCondition_DestProvince", $("#formSearchTransportLimitedPricesCondition #DestProvince").val().trim());
                        $.jStorage.set("SearchTransportLimitedPricesCondition_DestCity", $("#formSearchTransportLimitedPricesCondition #DestCity").val().trim());

                        //重新加载表格
                        $("#grid1").jqGrid("setGridParam", {
                            url: "/chenxk/System/LoadTransportLimitedPriceGrid/",
                            datatype: "json",
                            postData: {
                                planType: $.jStorage.get("SearchTransportLimitedPricesCondition_PlanType", ""),
                                startCountry: $.jStorage.get("SearchTransportLimitedPricesCondition_StartCountry", ""),
                                startProvince: $.jStorage.get("SearchTransportLimitedPricesCondition_StartProvince", ""),
                                startCity: $.jStorage.get("SearchTransportLimitedPricesCondition_StartCity", ""),
                                destCountry: $.jStorage.get("SearchTransportLimitedPricesCondition_DestCountry", ""),
                                destProvince: $.jStorage.get("SearchTransportLimitedPricesCondition_DestProvince", ""),
                                destCity: $.jStorage.get("SearchTransportLimitedPricesCondition_DestCity", ""),
                                modifiedIds: $.jStorage.get("SearchTransportLimitedPricesCondition_ModifiedIds", "")
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
        });

        //初始化表格数据
        objMain.objWorkspace.objContent.timerId = setInterval("initGrid();", 500);
        function initGrid() {
            if (objMain.objWorkspace.objContent.gridComplete) {
                clearInterval(objMain.objWorkspace.objContent.timerId);

                if ($.jStorage.get("SearchTransportLimitedPricesCondition_InitGrid", "1") == "0") {
                    //加载表格
                    $("#grid1").jqGrid("setGridParam", {
                        url: "/chenxk/System/LoadTransportLimitedPriceGrid/",
                        datatype: "json",
                        postData: {
                            planType: $.jStorage.get("SearchTransportLimitedPricesCondition_PlanType", ""),
                            startCountry: $.jStorage.get("SearchTransportLimitedPricesCondition_StartCountry", ""),
                            startProvince: $.jStorage.get("SearchTransportLimitedPricesCondition_StartProvince", ""),
                            startCity: $.jStorage.get("SearchTransportLimitedPricesCondition_StartCity", ""),
                            destCountry: $.jStorage.get("SearchTransportLimitedPricesCondition_DestCountry", ""),
                            destProvince: $.jStorage.get("SearchTransportLimitedPricesCondition_DestProvince", ""),
                            destCity: $.jStorage.get("SearchTransportLimitedPricesCondition_DestCity", ""),
                            modifiedIds: $.jStorage.get("SearchTransportLimitedPricesCondition_ModifiedIds", "")
                        }
                    });
                    $("#grid1").trigger("reloadGrid", [{ page: 1 }]);
                }
            }
        }

    </script>
</asp:Content>
