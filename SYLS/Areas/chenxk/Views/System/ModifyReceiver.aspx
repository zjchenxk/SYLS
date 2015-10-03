<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.ReceiverViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ModifyReceiver %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/System/SetReceiver/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveReceiver();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("ModifyReceiver", "System", FormMethod.Post, new { id = "form1" }))
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
                        <%: Html.EditorFor(model => model.Name) %>
                        <%: Html.ValidationMessageFor(model => model.Name) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Country)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.Country, ViewData["Countrys"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.Country)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Province)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.Province, ViewData["Provinces"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.Province)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.City)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.City, ViewData["Citys"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.City)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Address)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.TextBoxFor(model => model.Address)%>
                        <%: Html.ValidationMessageFor(model => model.Address)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Contact)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.TextBoxFor(model => model.Contact)%>
                        <%: Html.ValidationMessageFor(model => model.Contact)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ContactTel)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.TextBoxFor(model => model.ContactTel)%>
                        <%: Html.ValidationMessageFor(model => model.ContactTel)%>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.DistanceList%></legend>
        <div id="Grid">
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnNew" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.New %>
            </button>
            <button id="btnModify" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
            <button id="btnDelete" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <% } %>
    <div id="dialogDistance" title="">
        <% Html.RenderPartial("ReceiverDistance", Model.Distances[0]); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //新增收货单位距离标志
            this.isNewReceiverDistance = true;
            //当前选中收货单位距离记录编码
            this.selectedReceiverDistanceId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认名称获得焦点
                $("#Name").focus().select();
            };
            //新增收货单位距离
            this.newReceiverDistance = function () {
                //设置编辑模式为新增
                this.isNewReceiverDistance = true;

                //初始化控件数据
                $("#formReceiverDistance #StartCountry").val("");

                $("#formReceiverDistance #StartProvince").empty();
                $("#formReceiverDistance #StartProvince").append("<option value=''></option>");

                $("#formReceiverDistance #StartCity").empty();
                $("#formReceiverDistance #StartCity").append("<option value=''></option>");

                $("#formReceiverDistance #KM").val("");

                //打开对话框
                $("#dialogDistance").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewReceiverDistance %>");
                $("#dialogDistance").dialog("open");
            };
            //修改收货单位距离
            this.modifyReceiverDistance = function () {
                //读取选中的距离数据
                if (this.selectedReceiverDistanceId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedReceiverDistance %>");
                    return;
                }
                var data = $("#grid1").jqGrid("getRowData", this.selectedReceiverDistanceId);

                //初始化控件数据
                $("#formReceiverDistance #StartCountry").val(data.StartCountry);

                $("#formReceiverDistance #StartProvince").empty();
                $("#formReceiverDistance #StartProvince").append("<option value=''></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: data.StartCountry }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $("<option></option>").val(province).text(province);
                        option.appendTo($("#formReceiverDistance #StartProvince"));
                    });
                    $("#formReceiverDistance #StartProvince").val(data.StartProvince);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    return;
                });

                $("#formReceiverDistance #StartCity").empty();
                $("#formReceiverDistance #StartCity").append("<option value=''></option>");

                $.get("/Common/LoadCitysByProvince", { strCountryName: data.StartCountry, strProvinceName: data.StartProvince }, function (ret) {
                    $.each(ret, function (i, city) {
                        var option = $("<option></option>").val(city).text(city);
                        option.appendTo($("#formReceiverDistance #StartCity"));
                    });
                    $("#formReceiverDistance #StartCity").val(data.StartCity);
                }, "text json").error(function (xhr, status, error) {
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    return;
                });

                $("#formReceiverDistance #KM").val(data.KM);

                //设置编辑模式为修改
                this.isNewReceiverDistance = false;

                //打开对话框
                $("#dialogDistance").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyReceiverDistance %>");
                $("#dialogDistance").dialog("open");
            };
            //删除收货单位距离
            this.deleteReceiverDistance = function () {
                if (this.selectedReceiverDistanceId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedReceiverDistance %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteReceiverDistanceConfirm %>") == true) {
                    $("#grid1").jqGrid("delRowData", this.selectedReceiverDistanceId);
                    this.selectedReceiverDistanceId = null;
                }
            };
            //保存数据
            this.saveReceiver = function () {
                $("#form1").submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //设置国家选择事件
            $("#form1 #Country").change(function () {
                $("#form1 #Province").empty();
                $("#form1 #Province").append("<option value=''></option>");

                $("#form1 #City").empty();
                $("#form1 #City").append("<option value=''></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $('<option></option>').val(province).text(province);
                        option.appendTo($('#form1 #Province'));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #Country").val("");
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //设置省份选择事件
            $("#form1 #Province").change(function () {
                $("#form1 #City").empty();
                $("#form1 #City").append("<option value=''></option>");

                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#form1 #Country").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, city) {
                        var option = $('<option></option>').val(city).text(city);
                        option.appendTo($('#form1 #City'));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #Province").val("");
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //创建距离表格
            $("#grid1").jqGrid({
                url: "/chenxk/System/LoadReceiverDistancesGrid/",
                datatype: "json",
                mtype: "GET",
                postData: { receiverId: $("#form1 #Id").val().trim() },
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.Id %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartCountry %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartProvince %>",
                    "<%: InnoSoft.LS.Resources.Labels.StartCity %>",
                    "<%: InnoSoft.LS.Resources.Labels.KM %>"],
                colModel: [
                    { name: "Id", index: "Id", width: 100, hidden: true },
                    { name: "StartCountry", index: "StartCountry", width: 80, align: "center" },
                    { name: "StartProvince", index: "StartProvince", width: 150, align: "center" },
                    { name: "StartCity", index: "StartCity", width: 100, align: "center" },
                    { name: "KM", index: "KM", width: 60, align: "center"}],
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
                    objMain.objWorkspace.objContent.selectedReceiverDistanceId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //新增距离按钮点击事件
            $("#btnNew").button().click(function () {
                objMain.objWorkspace.objContent.newReceiverDistance();
            });

            //修改距离按钮点击事件
            $("#btnModify").button().click(function () {
                objMain.objWorkspace.objContent.modifyReceiverDistance();
            });

            //删除距离按钮点击事件
            $("#btnDelete").button().click(function () {
                objMain.objWorkspace.objContent.deleteReceiverDistance();
            });

            //创建距离编辑对话框
            $("#dialogDistance").dialog({
                autoOpen: false,
                height: 300,
                width: 600,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formReceiverDistance").valid()) {
                            if (objMain.objWorkspace.objContent.isNewReceiverDistance) {
                                //新增收货单位距离
                                var rowcount = $("#grid1").jqGrid("getGridParam", "records");
                                if (rowcount == 0) {
                                    $("#grid1").jqGrid("addRowData", 1, {
                                        StartCountry: $("#formReceiverDistance #StartCountry").val().trim(),
                                        StartProvince: $("#formReceiverDistance #StartProvince").val().trim(),
                                        StartCity: $("#formReceiverDistance #StartCity").val().trim(),
                                        KM: $("#formReceiverDistance #KM").val().trim()
                                    });
                                }
                                else {
                                    //检查记录是否重复
                                    var rows = $("#grid1").jqGrid("getRowData");
                                    for (var i = 0; i < rows.length; i++) {
                                        var row = rows[i];
                                        if (row.StartCountry == $("#formReceiverDistance #StartCountry").val().trim() &&
                                            row.StartProvince == $("#formReceiverDistance #StartProvince").val().trim() &&
                                            row.StartCity == $("#formReceiverDistance #StartCity").val().trim()) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.ReceiverDistanceIsExists %>");
                                            return;
                                        }
                                    }

                                    //添加数据
                                    var rowids = $("#grid1").jqGrid("getDataIDs");
                                    var rowidLast = rowids[rowcount - 1];

                                    $("#grid1").jqGrid("addRowData", parseFloat(rowidLast) + 1, {
                                        StartCountry: $("#formReceiverDistance #StartCountry").val().trim(),
                                        StartProvince: $("#formReceiverDistance #StartProvince").val().trim(),
                                        StartCity: $("#formReceiverDistance #StartCity").val().trim(),
                                        KM: $("#formReceiverDistance #KM").val().trim()
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
                                    if (row.StartCountry == $("#formReceiverDistance #StartCountry").val().trim() &&
                                        row.StartProvince == $("#formReceiverDistance #StartProvince").val().trim() &&
                                        row.StartCity == $("#formReceiverDistance #StartCity").val().trim() &&
                                        rowid != objMain.objWorkspace.objContent.selectedReceiverDistanceId) {
                                        alert("<%: InnoSoft.LS.Resources.Strings.ReceiverDistanceIsExists %>");
                                        return;
                                    }
                                }

                                //修改收货单位距离
                                $("#grid1").jqGrid("setRowData", objMain.objWorkspace.objContent.selectedReceiverDistanceId, {
                                    StartCountry: $("#formReceiverDistance #StartCountry").val().trim(),
                                    StartProvince: $("#formReceiverDistance #StartProvince").val().trim(),
                                    StartCity: $("#formReceiverDistance #StartCity").val().trim(),
                                    KM: $("#formReceiverDistance #KM").val().trim()
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

            //提交事件
            $("#form1").submit(function () {
                if ($(this).valid()) {
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

                    //获取所有距离数据
                    var rows = $("#grid1").jqGrid("getRowData");
                    var distances = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var d = {
                            "StartCountry": row.StartCountry,
                            "StartProvince": row.StartProvince,
                            "StartCity": row.StartCity,
                            "KM": row.KM
                        };
                        distances.push(d);
                    }

                    //生成JSON数据
                    var o = {
                        "Id": $("#form1 #Id").val().trim(),
                        "Name": $("#form1 #Name").val().trim(),
                        "Country": $("#form1 #Country").val().trim(),
                        "Province": $("#form1 #Province").val().trim(),
                        "City": $("#form1 #City").val().trim(),
                        "Address": $("#form1 #Address").val().trim(),
                        "Contact": $("#form1 #Contact").val().trim(),
                        "ContactTel": $("#form1 #ContactTel").val().trim(),
                        "Distances": distances
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
                                location.replace("/chenxk/System/SetReceiver/");
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

    </script>
</asp:Content>
