<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SetGoods %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.searchGoods();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="/chenxk/System/NewGoods" onclick="javascript:objMain.objWorkspace.objContent.newGoods(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.New%></a></li>
        <li><a href="/chenxk/System/ModifyGoods/" onclick="javascript:objMain.objWorkspace.objContent.modifyGoods(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/chenxk/System/DeleteGoods/" onclick="javascript:objMain.objWorkspace.objContent.deleteGoods(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete%></a></li>
        <li><a href="/chenxk/System/ImportGoods/" onclick="javascript:objMain.objWorkspace.objContent.importGoods(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/050.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Import%></a></li>
        <li><a href="/chenxk/System/ExportGoods/" onclick="javascript:objMain.objWorkspace.objContent.exportGoods(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/049.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Export%></a></li>
    </ul>
    <select id="ddlGoodsType" style="position: relative; float: right; width: 200px;
        margin-top: -25px; margin-right: 5px; font-family: Arial;">
    </select>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="Grid">
        <table id="grid1">
        </table>
        <div id="pager1">
        </div>
    </div>
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("SearchGoodsCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中货物编码
            this.selectedGoodsId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询货物
            this.searchGoods = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9120, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formSearchGoodsCondition #GoodsNo").val("");
                    $("#formSearchGoodsCondition #GoodsName").val("");
                    $("#formSearchGoodsCondition #SpecModel").val("");
                    $("#formSearchGoodsCondition #GWeight").val("");
                    $("#formSearchGoodsCondition #Grade").val("");
                    $("#formSearchGoodsCondition #Packing").val("");

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //新增货物
            this.newGoods = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9120, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace(action);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //修改货物
            this.modifyGoods = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9120, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedGoodsId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedGoods %>");
                        return;
                    }

                    location.replace(action + objMain.objWorkspace.objContent.selectedGoodsId);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除货物
            this.deleteGoods = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9120, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedGoodsId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedGoods %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteGoodsConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedGoodsId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                                objMain.objWorkspace.objContent.selectedGoodsId = null;
                            }
                        });
                    }
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //导入货物
            this.importGoods = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9120, strPermission: "AllowImport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace(action);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //导出货物
            this.exportGoods = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9120, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    var url = action + "?" +
                        "typeId=" + $("#ddlGoodsType").val().trim() + "&" +
                        "goodsNo=" + $("#formSearchGoodsCondition #GoodsNo").val().trim() + "&" +
                        "goodsName=" + $("#formSearchGoodsCondition #GoodsName").val().trim() + "&" +
                        "specModel=" + $("#formSearchGoodsCondition #SpecModel").val().trim() + "&" +
                        "gWeight=" + $("#formSearchGoodsCondition #GWeight").val().trim() + "&" +
                        "grade=" + $("#formSearchGoodsCondition #Grade").val().trim() + "&" +
                        "packing=" + $("#formSearchGoodsCondition #Packing").val().trim();

                    location.replace(url);

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //生成货物类别下拉列表
            $("#ddlGoodsType").empty();
            $("#ddlGoodsType").append("<option value=''><%: InnoSoft.LS.Resources.Options.SelectGoodsType %></option>");

            $.get("/Common/LoadGoodsTypes", function (ret) {
                $.each(ret, function (i, type) {
                    var option = $("<option></option>").val(type.Id).text(type.FullName);
                    option.appendTo($("#ddlGoodsType"));
                });
            }, "text json").error(function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });

            //生成表格
            $("#grid1").jqGrid({
                url: "/chenxk/System/LoadGoodsGrid/",
                datatype: "json",
                mtype: "GET",
                postData: {
                    typeId: "",
                    goodsNo: "",
                    goodsName: "",
                    specModel: "",
                    gWeight: "",
                    grade: "",
                    packing: ""
                },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.TypeName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                    "<%: InnoSoft.LS.Resources.Labels.GrammeWeight %>",
                    "<%: InnoSoft.LS.Resources.Labels.Grade %>",
                    "<%: InnoSoft.LS.Resources.Labels.Brand %>",
                    "<%: InnoSoft.LS.Resources.Labels.PieceWeightOrConvertCoefficient %>",
                    "<%: InnoSoft.LS.Resources.Labels.PackingSpecification %>",
                    "<%: InnoSoft.LS.Resources.Labels.Remark %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                    { name: "Name", index: "Name", width: 150, align: "center" },
                    { name: "TypeFullName", index: "TypeFullName", width: 100, align: "center" },
                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                    { name: "GWeight", index: "GWeight", width: 50, align: "center" },
                    { name: "Grade", index: "Grade", width: 50, align: "center" },
                    { name: "Brand", index: "Brand", width: 80, align: "center" },
                    { name: "PieceWeight", index: "PieceWeight", width: 100, align: "center" },
                    { name: "Packing", index: "Packing", width: 50, align: "center" },
                    { name: "Remark", index: "Remark", width: 400, sortable: false}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "GoodsNo",
                sortorder: "asc",
                pager: "#pager1",
                viewrecords: true,
                emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
                shrinkToFit: false,
                loadError: function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedGoodsId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //货物类别选择事件
            $("#ddlGoodsType").change(function () {
                $("#grid1").jqGrid("setGridParam", {
                    postData: {
                        typeId: $("#ddlGoodsType").val().trim(),
                        goodsNo: "",
                        goodsName: "",
                        specModel: "",
                        gWeight: "",
                        grade: "",
                        packing: ""
                    }
                });
                $("#grid1").trigger("reloadGrid", [{ page: 1}]);
            });

            //创建查询条件输入对话框
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 350,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        //重新加载表格
                        $("#grid1").jqGrid("setGridParam", {
                            postData: {
                                typeId: $("#ddlGoodsType").val().trim(),
                                goodsNo: $("#formSearchGoodsCondition #GoodsNo").val().trim(),
                                goodsName: $("#formSearchGoodsCondition #GoodsName").val().trim(),
                                specModel: $("#formSearchGoodsCondition #SpecModel").val().trim(),
                                gWeight: $("#formSearchGoodsCondition #GWeight").val().trim(),
                                grade: $("#formSearchGoodsCondition #Grade").val().trim(),
                                packing: $("#formSearchGoodsCondition #Packing").val().trim()
                            }
                        });
                        $("#grid1").trigger("reloadGrid", [{ page: 1}]);

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

    </script>
</asp:Content>
