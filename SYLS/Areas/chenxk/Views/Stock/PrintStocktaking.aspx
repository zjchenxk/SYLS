<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.PrintStocktaking %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.search();return false;">
            <img src="<%: Url.Content("~/Content/Images/061.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Search %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.print();return false;">
            <img src="<%: Url.Content("~/Content/Images/062.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Print %></a></li>
        <li><a href="/chenxk/Stock/ExportStocktaking/" onclick="javascript:objMain.objWorkspace.objContent.export(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/049.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Export %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <div id="stocktaking" style="text-align: center;">
    </div>
    <div id="dialogCondition" title="">
        <% Html.RenderPartial("PrintStocktakingCondition"); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整布局
            this.resizeContent = function () {
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //查询条件
            this.search = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5080, strPermission: "AllowSearch" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    //初始化控件数据
                    $("#formPrintStocktakingCondition #Warehouse").val($.jStorage.get("PrintStocktakingCondition_Warehouse", ""));
                    $("#formPrintStocktakingCondition #Location").val($.jStorage.get("PrintStocktakingCondition_Location", ""));

                    //打开条件输入对话框
                    $("#dialogCondition").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.EnterCondition %>");
                    $("#dialogCondition").dialog("open");
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //打印盘点表
            this.print = function () {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5080, strPermission: "AllowPrint" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    var LODOP = getLodop(document.getElementById('LODOP'), document.getElementById('LODOP_EM'));
                    if (LODOP != null) {
                        LODOP.PRINT_INIT("SYLS打印库存盘点表");
                        LODOP.SET_PRINT_PAGESIZE(2, 0, 0, "A4");
                        LODOP.SET_SHOW_MODE("LANDSCAPE_DEFROTATED", 1);

                        var strStocktakingStyle = "<style>table #stocktaking{font-size:0.75em;}</style>";
                        var strStocktakingHtml = strStocktakingStyle + "<body>" + document.getElementById("stocktaking").innerHTML + "</body>";

                        LODOP.ADD_PRINT_HTM("2mm", "0mm", "290mm", "195mm", strStocktakingHtml);
                        LODOP.SET_PRINT_STYLEA(0, "ItemType", 4);
                        LODOP.SET_PRINT_STYLEA(0, "Horient", 0);
                        LODOP.SET_PRINT_STYLEA(0, "Vorient", 0);
                        LODOP.ADD_PRINT_TEXT("155.6mm", "80mm", "20mm", "5mm", "#/&");
                        LODOP.SET_PRINT_STYLEA(0, "ItemType", 2);
                        LODOP.SET_PRINT_STYLEA(0, "Horient", 1);
                        LODOP.SET_PRINT_STYLEA(0, "Vorient", 1);
                        LODOP.PREVIEW();
                        //LODOP.PRINT_DESIGN();
                    }

                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //导出盘点表
            this.export = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 5080, strPermission: "AllowExport" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    var url = action + "?" +
                        "Warehouse=" + $("#formPrintStocktakingCondition #Warehouse").val().trim() + "&" +
                        "Location=" + $("#formPrintStocktakingCondition #Location").val().trim();

                    location.replace(url);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            $("#dialogCondition").dialog({
                autoOpen: false,
                height: 200,
                width: 540,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formPrintStocktakingCondition").valid()) {
                            //缓存查询条件
                            $.jStorage.set("PrintStocktakingCondition_Warehouse", $("#formPrintStocktakingCondition #Warehouse").val().trim());
                            $.jStorage.set("PrintStocktakingCondition_Location", $("#formPrintStocktakingCondition #Location").val().trim());

                            //重新读取盘点数据
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

                            $.get("/chenxk/Stock/LoadPrintStocktaking", {
                                warehouse: $("#formPrintStocktakingCondition #Warehouse").val().trim(),
                                location: $("#formPrintStocktakingCondition #Location").val().trim()
                            }, function (ret) {
                                $("#stocktaking").html(ret);

                                $.unblockUI();
                            }).error(function (xhr, status, error) {
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                            });

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
