<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.SetCity %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/shancl/System/NewCity" onclick="javascript:objMain.objWorkspace.objContent.newCity(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.New%></a></li>
        <li><a href="/shancl/System/ModifyCity/" onclick="javascript:objMain.objWorkspace.objContent.modifyCity(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Modify%></a></li>
        <li><a href="/shancl/System/DeleteCity/" onclick="javascript:objMain.objWorkspace.objContent.deleteCity(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Delete%></a></li>
    </ul>
    <select id="ddlCountry" style="position: relative; float: right; width: 100px; margin-top: -25px;
        margin-right: 205px; font-family: Arial;">
    </select>
    <select id="ddlProvince" style="position: relative; float: right; width: 200px; margin-top: -25px;
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
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //当前选中城市编码
            this.selectedCityId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#divWorkspaceContent").css("overflow", "hidden");

                $("#grid1").jqGrid("setGridWidth", $("#divWorkspaceContent").width() - 2);
                $("#grid1").jqGrid("setGridHeight", $("#divWorkspaceContent").height() - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-htable th").css("height")) - 1 - 1 - parseInt($(".ui-jqgrid .ui-jqgrid-pager").css("height")) - 1 - 1);
            };
            //设置输入焦点
            this.setFocus = function () {
            };
            //新增城市
            this.newCity = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9100, strPermission: "AllowNew" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    location.replace(action);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //修改城市
            this.modifyCity = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9100, strPermission: "AllowModify" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedCityId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCity %>");
                        return;
                    }

                    location.replace(action + objMain.objWorkspace.objContent.selectedCityId);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            };
            //删除城市
            this.deleteCity = function (action) {
                //检查权限
                $.get("/Common/LoadAccountPermission", { strFuncId: 9100, strPermission: "AllowDelete" }, function (ret) {
                    if (ret == false) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NoPermission %>");
                        return;
                    }

                    if (objMain.objWorkspace.objContent.selectedCityId == null) {
                        alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedCity %>");
                        return;
                    }

                    if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteCityConfirm %>") == true) {
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

                        $.post(action, { id: objMain.objWorkspace.objContent.selectedCityId }, function (ret) {
                            $.unblockUI();

                            if (ret != null && ret != "") {
                                alert(ret);
                            }
                            else {
                                $("#grid1").trigger("reloadGrid", [{ page: 1}]);
                                objMain.objWorkspace.objContent.selectedCityId = null;
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

            //生成国家下拉列表
            $("#ddlCountry").empty();
            $("#ddlCountry").append("<option value='<%: InnoSoft.LS.Resources.Options.SelectCountry %>'><%: InnoSoft.LS.Resources.Options.SelectCountry %></option>");

            $.get("/Common/LoadCountrys", function (ret) {
                $.each(ret, function (i, country) {
                    var option = $("<option></option>").val(country).text(country);
                    option.appendTo($("#ddlCountry"));
                });
            }, "text json").error(function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            });

            //生成省份下拉列表
            $("#ddlProvince").empty();
            $("#ddlProvince").append("<option value='<%: InnoSoft.LS.Resources.Options.SelectProvince %>'><%: InnoSoft.LS.Resources.Options.SelectProvince %></option>");

            //生成表格
            $("#grid1").jqGrid({
                url: "/shancl/System/LoadCitysGrid/",
                datatype: "json",
                mtype: "GET",
                colNames: ["<%: InnoSoft.LS.Resources.Labels.Id %>", "<%: InnoSoft.LS.Resources.Labels.Name %>", "<%: InnoSoft.LS.Resources.Labels.CountryName %>", "<%: InnoSoft.LS.Resources.Labels.StateName %>", "<%: InnoSoft.LS.Resources.Labels.Remark %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100 },
                    { name: "Name", index: "Name", width: 200, align: "center" },
                    { name: "CountryName", index: "CountryName", width: 200, align: "center" },
                    { name: "ProvinceName", index: "ProvinceName", width: 200, align: "center" },
                    { name: "Remark", index: "Remark", width: 400, sortable: false}],
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
                    objMain.objWorkspace.objContent.selectedCityId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            $.unblockUI();

            //国家选择事件
            $("#ddlCountry").change(function () {
                //生成省份下拉列表
                $("#ddlProvince").empty();
                $("#ddlProvince").append("<option value='<%: InnoSoft.LS.Resources.Options.SelectProvince %>'><%: InnoSoft.LS.Resources.Options.SelectProvince %></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() != "<%: InnoSoft.LS.Resources.Options.SelectCountry %>" ? $(this).val().trim() : "" }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $("<option></option>").val(province).text(province);
                        option.appendTo($("#ddlProvince"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#ddlCountry").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    return;
                });

                //重新生成表格数据
                $("#grid1").jqGrid("setGridParam", { url: "/shancl/System/LoadCitysGrid/" + encodeURI($(this).val().trim()) + "/" + encodeURI($("#ddlProvince").val().trim()) });
                $("#grid1").trigger("reloadGrid", [{ page: 1}]);
            });

            //省份选择事件
            $("#ddlProvince").change(function () {
                //重新生成表格数据
                $("#grid1").jqGrid("setGridParam", { url: "/shancl/System/LoadCitysGrid/" + encodeURI($("#ddlCountry").val().trim()) + "/" + encodeURI($(this).val().trim()) });
                $("#grid1").trigger("reloadGrid", [{ page: 1}]);
            });

        });

    </script>
</asp:Content>
