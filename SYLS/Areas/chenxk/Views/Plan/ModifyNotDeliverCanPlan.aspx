<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.CanPlanViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ModifyNotDeliverCanPlan %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/Plan/SubmitDeliverPlans/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.savePlan();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("ModifyNotDeliverCanPlan", "Plan", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.BasicInfo %></legend>
        <%: Html.HiddenFor(model => model.Id) %>
        <%: Html.HiddenFor(model => model.CustomerId) %>
        <table>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CustomerName)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CustomerName)%>
                        <%: Html.ValidationMessageFor(model => model.CustomerName)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.DeliveryNo) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.DeliveryNo) %>
                        <%: Html.ValidationMessageFor(model => model.DeliveryNo) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ReceiverName) %>
                        <%: Html.ValidationMessageFor(model => model.ReceiverName) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverCountry) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.ReceiverCountry, ViewData["DestCountrys"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.ReceiverCountry) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverProvince) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.ReceiverProvince, ViewData["DestProvinces"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.ReceiverProvince) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverCity) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.ReceiverCity, ViewData["DestCitys"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.ReceiverCity) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverAddress) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ReceiverAddress) %>
                        <%: Html.ValidationMessageFor(model => model.ReceiverAddress) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverContact) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ReceiverContact) %>
                        <%: Html.ValidationMessageFor(model => model.ReceiverContact) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ReceiverContactTel) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ReceiverContactTel) %>
                        <%: Html.ValidationMessageFor(model => model.ReceiverContactTel) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.Warehouse) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.Warehouse) %>
                        <%: Html.ValidationMessageFor(model => model.Warehouse) %>
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
                        <%: Html.EditorFor(model => model.ArrivalTime) %>
                        <%: Html.ValidationMessageFor(model => model.ArrivalTime) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.StartCountry)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.StartCountry, ViewData["StartCountrys"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.StartCountry)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.StartProvince)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.StartProvince, ViewData["StartProvinces"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.StartProvince)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.StartCity)%>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.StartCity, ViewData["StartCitys"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.StartCity)%>
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
                        <%: Html.ValidationMessageFor(model => model.Remark)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CreateTime) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.CreateTime)%>
                        <%: Html.ValidationMessageFor(model => model.CreateTime)%>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>
            <%: InnoSoft.LS.Resources.Tabs.GoodsList %></legend>
        <div>
            <table id="grid1">
            </table>
            <div id="pager1">
            </div>
        </div>
        <div style="margin-top: 1px;">
            <button id="btnNewGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/034.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.New %>
            </button>
            <button id="btnModifyGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/037.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Modify%>
            </button>
            <button id="btnDeleteGoods" type="button">
                <img src="<%: Url.Content("~/Content/Images/038.png") %>" alt="" /><%: InnoSoft.LS.Resources.Buttons.Delete%>
            </button>
        </div>
    </fieldset>
    <% } %>
    <div id="dialogGoods" title="">
        <% Html.RenderPartial("NotDeliverCanPlanGoods", Model.Goods[0]); %>
    </div>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //新增货物标志
            this.isNewGoods = true;
            //当前选中货物记录编码
            this.selectedGoodsId = null;
            //调整工作内容布局
            this.resizeContent = function () {
                $("#grid1").jqGrid("setGridWidth", $("fieldset:first").width() - 2);
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认客户名称获得焦点
                $("#form1 #CustomerName").focus().select();
            };
            //新增货物信息
            this.newGoods = function () {
                //检查是否输入客户名称
                if ($("#form1 #CustomerId").val().trim() == "0") {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                    return;
                }

                //设置编辑模式为新增
                this.isNewGoods = true;

                //初始化控件数据
                $("#formNotDeliverCanPlanGoods #GoodsId").val("0");
                $("#formNotDeliverCanPlanGoods #GoodsNo").val("");
                $("#formNotDeliverCanPlanGoods #GoodsName").val("");
                $("#formNotDeliverCanPlanGoods #SpecModel").val("");
                $("#formNotDeliverCanPlanGoods #Piles").val("");
                $("#formNotDeliverCanPlanGoods #TenThousands").val("");

                //打开对话框
                $("#dialogGoods").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.NewPlanGoods %>");
                $("#dialogGoods").dialog("open");
            };
            //修改货物信息
            this.modifyGoods = function () {
                //检查是否输入客户名称
                if ($("#form1 #CustomerId").val().trim() == "0") {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterCustomerName %>");
                    return;
                }

                //读取选中的货物记录
                if (this.selectedGoodsId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedGoods %>");
                    return;
                }
                var data = $("#grid1").jqGrid("getRowData", this.selectedGoodsId);

                //初始化控件数据
                $("#formNotDeliverCanPlanGoods #GoodsId").val(data.GoodsId);
                $("#formNotDeliverCanPlanGoods #GoodsNo").val(data.GoodsNo);
                $("#formNotDeliverCanPlanGoods #GoodsName").val(data.GoodsName);
                $("#formNotDeliverCanPlanGoods #SpecModel").val(data.SpecModel);
                $("#formNotDeliverCanPlanGoods #Piles").val(data.Piles);
                $("#formNotDeliverCanPlanGoods #TenThousands").val(data.TenThousands);

                //设置编辑模式为修改
                this.isNewGoods = false;

                //打开对话框
                $("#dialogGoods").dialog("option", "title", "<%: InnoSoft.LS.Resources.Titles.ModifyPlanGoods %>");
                $("#dialogGoods").dialog("open");
            };
            //删除货物信息
            this.deleteGoods = function () {
                if (this.selectedGoodsId == null) {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotSelectedGoods %>");
                    return;
                }
                if (confirm("<%: InnoSoft.LS.Resources.Strings.DeleteGoodsConfirm %>") == true) {
                    $("#grid1").jqGrid("delRowData", this.selectedGoodsId);

                    //重置合计数
                    var totalPiles = 0;
                    var totalTenThousands = 0;
                    var rows = $("#grid1").jqGrid("getRowData");
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        totalPiles = add(totalPiles, parseFloat(row.Piles));
                        totalTenThousands = add(totalTenThousands, parseFloat(row.TenThousands));
                    }

                    $("#grid1").jqGrid("footerData", "set", { GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>", Piles: totalPiles, TenThousands: totalTenThousands });

                    this.selectedGoodsId = null;
                }
            };
            //保存数据
            this.savePlan = function () {
                $("#form1").submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //设置客户名称自动完成
            $("#form1 #CustomerName").autocomplete({
                source: "/Autocomplete/LoadCustomerNames/",
                minLength: 1,
                change: function (event, ui) {
                    //填充客户编码，以及起点国家、省份和城市
                    $("#form1 #StartCountry").val("");
                    $("#form1 #StartProvince").empty();
                    $("#form1 #StartProvince").append("<option value=''></option>");
                    $("#form1 #StartCity").empty();
                    $("#form1 #StartCity").append("<option value=''></option>");

                    $.get("/Common/LoadCustomerByName", { strName: $("#form1 #CustomerName").val().trim() }, function (ret) {
                        if (ret != null) {
                            $("#form1 #CustomerId").val(ret.Id);

                            $.get("/Common/LoadOrganization", { nOrganId: ret.OwnOrganId }, function (ret) {
                                if (ret != null) {
                                    var countryName = ret.CountryName;
                                    var provinceName = ret.ProvinceName;
                                    var cityName = ret.CityName;

                                    $("#form1 #StartCountry").val(countryName);

                                    if ($("#form1 #StartCountry").val().trim() != "") {
                                        $.get("/Common/LoadProvincesByCountry", { strCountryName: $("#form1 #StartCountry").val().trim() }, function (ret) {
                                            $.each(ret, function (i, province) {
                                                var option = $("<option></option>").val(province).text(province);
                                                option.appendTo($("#form1 #StartProvince"));
                                            });
                                            $("#form1 #StartProvince").val(provinceName);

                                            if ($("#form1 #StartProvince").val().trim() != "") {
                                                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#form1 #StartCountry").val().trim(), strProvinceName: $("#form1 #StartProvince").val().trim() }, function (ret) {
                                                    $.each(ret, function (i, city) {
                                                        var option = $("<option></option>").val(city).text(city);
                                                        option.appendTo($("#form1 #StartCity"));
                                                    });
                                                    $("#form1 #StartCity").val(cityName);
                                                }, "text json").error(function (xhr, status, error) {
                                                    $("#form1 #StartProvince").val("");
                                                });
                                            }
                                        }, "text json").error(function (xhr, status, error) {
                                            $("#form1 #StartCountry").val("");
                                        });
                                    }
                                }
                            }, "text json").error(function (xhr, status, error) {
                                alert(xhr.responseText)
                            });
                        }
                        else {
                            alert("<%: InnoSoft.LS.Resources.Strings.CustomerNameNotExists %>");
                            $("#form1 #CustomerId").val("0");
                            $("#form1 #CustomerName").val("");
                            $("#form1 #CustomerName").focus().select();
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #CustomerName").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //设置提货单位名称自动完成
            $("#form1 #ReceiverName").autocomplete({
                source: "/Autocomplete/LoadReceiverNames/",
                minLength: 1,
                change: function (event, ui) {
                    //填充提货单位数据
                    $("#form1 #ReceiverCountry").val("");

                    $("#form1 #ReceiverProvince").empty();
                    $("#form1 #ReceiverProvince").append("<option value=''></option>");

                    $("#form1 #ReceiverCity").empty();
                    $("#form1 #ReceiverCity").append("<option value=''></option>");

                    $("#form1 #ReceiverAddress").val("");
                    $("#form1 #ReceiverContact").val("");
                    $("#form1 #ReceiverContactTel").val("");

                    $.get("/Common/LoadReceiverByName", { strName: $("#form1 #ReceiverName").val().trim() }, function (data) {
                        if (data != null) {
                            $("#form1 #ReceiverCountry").val(data.Country);

                            $.get("/Common/LoadProvincesByCountry", { strCountryName: data.Country }, function (ret) {
                                $.each(ret, function (i, province) {
                                    var option = $("<option></option>").val(province).text(province);
                                    option.appendTo($("#form1 #ReceiverProvince"));
                                });
                                $("#form1 #ReceiverProvince").val(data.Province);
                            }, "text json").error(function (xhr, status, error) {
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                return;
                            });

                            $.get("/Common/LoadCitysByProvince", { strCountryName: data.Country, strProvinceName: data.Province }, function (ret) {
                                $.each(ret, function (i, city) {
                                    var option = $("<option></option>").val(city).text(city);
                                    option.appendTo($("#form1 #ReceiverCity"));
                                });
                                $("#form1 #ReceiverCity").val(data.City);
                            }, "text json").error(function (xhr, status, error) {
                                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                                return;
                            });

                            $("#form1 #ReceiverAddress").val(data.Address);
                            $("#form1 #ReceiverContact").val(data.Contact);
                            $("#form1 #ReceiverContactTel").val(data.ContactTel);
                        }
                    }, "text json").error(function (xhr, status, error) {
                        $("#form1 #ReceiverName").val("");
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //讫点国家选择事件
            $("#form1 #ReceiverCountry").change(function () {
                $("#form1 #ReceiverProvince").empty();
                $("#form1 #ReceiverProvince").append("<option value=''></option>");

                $("#form1 #ReceiverCity").empty();
                $("#form1 #ReceiverCity").append("<option value=''></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $("<option></option>").val(province).text(province);
                        option.appendTo($("#form1 #ReceiverProvince"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #ReceiverCountry").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //讫点省份选择事件
            $("#form1 #ReceiverProvince").change(function () {
                $("#form1 #ReceiverCity").empty();
                $("#form1 #ReceiverCity").append("<option value=''></option>");

                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#form1 #ReceiverCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, city) {
                        var option = $("<option></option>").val(city).text(city);
                        option.appendTo($("#form1 #ReceiverCity"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #ReceiverProvince").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //设置到货日期
            $("#form1 #ArrivalTime").datepicker({
                onSelect: function (dateText, inst) {
                    $("#form1 #Remark").focus().select();
                }
            });
            $("#form1 #ArrivalTime").datepicker("option", $.datepicker.regional["zh-CN"]);

            //起点国家选择事件
            $("#form1 #StartCountry").change(function () {
                $("#form1 #StartProvince").empty();
                $("#form1 #StartProvince").append("<option value=''></option>");

                $("#form1 #StartCity").empty();
                $("#form1 #StartCity").append("<option value=''></option>");

                $.get("/Common/LoadProvincesByCountry", { strCountryName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, province) {
                        var option = $("<option></option>").val(province).text(province);
                        option.appendTo($("#form1 #StartProvince"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #StartCountry").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //起点省份选择事件
            $("#form1 #StartProvince").change(function () {
                $("#form1 #StartCity").empty();
                $("#form1 #StartCity").append("<option value=''></option>");

                $.get("/Common/LoadCitysByProvince", { strCountryName: $("#form1 #StartCountry").val().trim(), strProvinceName: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, city) {
                        var option = $("<option></option>").val(city).text(city);
                        option.appendTo($("#form1 #StartCity"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#form1 #StartProvince").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //设置录入日期
            $("#form1 #CreateTime").datepicker($.datepicker.regional["zh-CN"]);

            //创建货物表格
            $("#grid1").jqGrid({
                url: "/chenxk/Plan/LoadCanPlanGoodsGrid/" + encodeURI($("#form1 #Id").val().trim()),
                datatype: "json",
                mtype: "GET",
                colNames: [
                    "<%: InnoSoft.LS.Resources.Labels.GoodsId %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.GoodsName %>",
                    "<%: InnoSoft.LS.Resources.Labels.Specification %>",
                    "<%: InnoSoft.LS.Resources.Labels.BatchNo %>",
                    "<%: InnoSoft.LS.Resources.Labels.Warehouse %>",
                    "<%: InnoSoft.LS.Resources.Labels.Location %>",
                    "<%: InnoSoft.LS.Resources.Labels.Piles %>",
                    "<%: InnoSoft.LS.Resources.Labels.TenThousands %>",
                    "<%: InnoSoft.LS.Resources.Labels.ProductionDate %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillId %>",
                    "<%: InnoSoft.LS.Resources.Labels.EnterWarehouseBillNo %>"],
                colModel: [
                    { name: "GoodsId", index: "GoodsId", width: 100, hidden: true },
                    { name: "GoodsNo", index: "GoodsNo", width: 100, align: "center" },
                    { name: "GoodsName", index: "GoodsName", width: 100, align: "center" },
                    { name: "SpecModel", index: "SpecModel", width: 100, align: "center" },
                    { name: "BatchNo", index: "BatchNo", width: 100, align: "center", hidden: true },
                    { name: "Warehouse", index: "Warehouse", width: 80, align: "center", hidden: true },
                    { name: "Location", index: "Location", width: 80, align: "center", hidden: true },
                    { name: "Piles", index: "Piles", width: 100, align: "center" },
                    { name: "TenThousands", index: "TenThousands", width: 100, align: "center" },
                    { name: "ProductionDate", index: "ProductionDate", width: 100, align: "center", hidden: true },
                    { name: "EnterWarehouseBillId", index: "EnterWarehouseBillId", width: 100, align: "center", hidden: true },
                    { name: "EnterWarehouseBillNo", index: "EnterWarehouseBillNo", width: 100, align: "center", hidden: true}],
                rowNum: 500,
                rowList: [50, 100, 500, 1000, 5000],
                sortname: "GoodsNo",
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
                },
                onSelectRow: function (rowid, status) {
                    objMain.objWorkspace.objContent.selectedGoodsId = rowid;
                }
            });
            $("#grid1").jqGrid("navGrid", "#pager1", { edit: false, add: false, del: false, search: false });

            //新增货物按钮点击事件
            $("#btnNewGoods").button().click(function () {
                objMain.objWorkspace.objContent.newGoods();
            });

            //修改货物按钮点击事件
            $("#btnModifyGoods").button().click(function () {
                objMain.objWorkspace.objContent.modifyGoods();
            });

            //删除货物按钮点击事件
            $("#btnDeleteGoods").button().click(function () {
                objMain.objWorkspace.objContent.deleteGoods();
            });

            //创建货物编辑对话框
            $("#dialogGoods").dialog({
                autoOpen: false,
                height: 300,
                width: 520,
                modal: true,
                resizable: false,
                buttons: {
                    "<%: InnoSoft.LS.Resources.Buttons.Ok %>": function () {
                        if ($("#formNotDeliverCanPlanGoods").valid()) {
                            //新增货物信息
                            if (objMain.objWorkspace.objContent.isNewGoods) {
                                var rowcount = $("#grid1").jqGrid("getGridParam", "records");
                                if (rowcount == 0) {
                                    $("#grid1").jqGrid("addRowData", 1, { GoodsId: $("#formNotDeliverCanPlanGoods #GoodsId").val().trim(), GoodsNo: $("#formNotDeliverCanPlanGoods #GoodsNo").val().trim(), GoodsName: $("#formNotDeliverCanPlanGoods #GoodsName").val().trim(), SpecModel: $("#formNotDeliverCanPlanGoods #SpecModel").val().trim(), Piles: $("#formNotDeliverCanPlanGoods #Piles").val().trim(), TenThousands: $("#formNotDeliverCanPlanGoods #TenThousands").val().trim() });

                                    //重置合计数
                                    $("#grid1").jqGrid("footerData", "set", { GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>", Piles: $("#formNotDeliverCanPlanGoods #Piles").val().trim(), TenThousands: $("#formNotDeliverCanPlanGoods #TenThousands").val().trim() });
                                }
                                else {
                                    //检查货物是否重复并累计合计数
                                    var totalPiles = 0;
                                    var totalTenThousands = 0;
                                    var rows = $("#grid1").jqGrid("getRowData");
                                    for (var i = 0; i < rows.length; i++) {
                                        var row = rows[i];
                                        if (row.GoodsNo == $("#formNotDeliverCanPlanGoods #GoodsNo").val().trim()) {
                                            alert("<%: InnoSoft.LS.Resources.Strings.GoodsIsExists %>");
                                            return;
                                        }
                                        totalPiles = add(totalPiles, parseFloat(row.Piles));
                                        totalTenThousands = add(totalTenThousands, parseFloat(row.TenThousands));
                                    }

                                    var rowids = $("#grid1").jqGrid("getDataIDs");
                                    var rowidLast = rowids[rowcount - 1];

                                    $("#grid1").jqGrid("addRowData", parseFloat(rowidLast) + 1, { GoodsId: $("#formNotDeliverCanPlanGoods #GoodsId").val().trim(), GoodsNo: $("#formNotDeliverCanPlanGoods #GoodsNo").val().trim(), GoodsName: $("#formNotDeliverCanPlanGoods #GoodsName").val().trim(), SpecModel: $("#formNotDeliverCanPlanGoods #SpecModel").val().trim(), Piles: $("#formNotDeliverCanPlanGoods #Piles").val().trim(), TenThousands: $("#formNotDeliverCanPlanGoods #TenThousands").val().trim() });

                                    //重置合计数
                                    $("#grid1").jqGrid("footerData", "set", { GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>", Piles: add(totalPiles, parseFloat($("#formNotDeliverCanPlanGoods #Piles").val().trim())), TenThousands: totalTenThousands + parseFloat($("#formNotDeliverCanPlanGoods #TenThousands").val().trim()) });
                                }
                            }
                            //修改货物信息
                            else {
                                //检查货物是否重复并累计合计数
                                var totalPiles = 0;
                                var totalTenThousands = 0;
                                var rowids = $("#grid1").jqGrid("getDataIDs");
                                var rows = $("#grid1").jqGrid("getRowData");
                                for (var i = 0; i < rows.length; i++) {
                                    var rowid = rowids[i];
                                    var row = rows[i];
                                    if (row.GoodsNo == $("#formNotDeliverCanPlanGoods #GoodsNo").val().trim() && rowid != objMain.objWorkspace.objContent.selectedGoodsId) {
                                        alert("<%: InnoSoft.LS.Resources.Strings.GoodsIsExists %>");
                                        return;
                                    }
                                    if (rowid != objMain.objWorkspace.objContent.selectedGoodsId) {
                                        totalPiles = add(totalPiles, parseFloat(row.Piles));
                                        totalTenThousands = add(totalTenThousands, parseFloat(row.TenThousands));
                                    }
                                }

                                $("#grid1").jqGrid("setRowData", objMain.objWorkspace.objContent.selectedGoodsId, { GoodsId: $("#formNotDeliverCanPlanGoods #GoodsId").val().trim(), GoodsNo: $("#formNotDeliverCanPlanGoods #GoodsNo").val().trim(), GoodsName: $("#formNotDeliverCanPlanGoods #GoodsName").val().trim(), SpecModel: $("#formNotDeliverCanPlanGoods #SpecModel").val().trim(), Piles: $("#formNotDeliverCanPlanGoods #Piles").val().trim(), TenThousands: $("#formNotDeliverCanPlanGoods #TenThousands").val().trim() });

                                //重置合计数
                                $("#grid1").jqGrid("footerData", "set", { GoodsNo: "<%: InnoSoft.LS.Resources.Labels.Total %>", Piles: add(totalPiles, parseFloat($("#formNotDeliverCanPlanGoods #Piles").val().trim())), TenThousands: totalTenThousands + parseFloat($("#formNotDeliverCanPlanGoods #TenThousands").val().trim()) });
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
                    //检查录入时间
                    var createTime = $("#form1 #CreateTime").val().trim();
                    var today = formatDate(new Date(), "yyyy-MM-dd");
                    if (createTime > today) {
                        alert("<%: InnoSoft.LS.Resources.Strings.CreateTimeCantNotGreaterThanSystemTime %>");
                        return false;
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

                    //获取所有货物数据
                    var rows = $("#grid1").jqGrid("getRowData");
                    var goods = new Array();
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var g = {
                            "GoodsId": row.GoodsId,
                            "GoodsNo": row.GoodsNo,
                            "GoodsName": row.GoodsName,
                            "SpecModel": row.SpecModel,
                            "BatchNo": "",
                            "Warehouse": "",
                            "Location": "",
                            "Piles": row.Piles,
                            "TenThousands": row.TenThousands,
                            "ProductionDate": "",
                            "EnterWarehouseBillId": "0",
                            "EnterWarehouseBillNo": ""
                        };
                        goods.push(g);
                    }

                    //生成JSON数据
                    var o = {
                        "Id": $("#form1 #Id").val().trim(),
                        "CustomerId": $("#form1 #CustomerId").val().trim(),
                        "CustomerName": $("#form1 #CustomerName").val().trim(),
                        "DeliveryNo": $("#form1 #DeliveryNo").val().trim(),
                        "ReceiverName": $("#form1 #ReceiverName").val().trim(),
                        "ReceiverCountry": $("#form1 #ReceiverCountry").val().trim(),
                        "ReceiverProvince": $("#form1 #ReceiverProvince").val().trim(),
                        "ReceiverCity": $("#form1 #ReceiverCity").val().trim(),
                        "ReceiverAddress": $("#form1 #ReceiverAddress").val().trim(),
                        "ReceiverContact": $("#form1 #ReceiverContact").val().trim(),
                        "ReceiverContactTel": $("#form1 #ReceiverContactTel").val().trim(),
                        "ReceiveType": "<%: InnoSoft.LS.Resources.Options.PickUpDelivery %>",
                        "CarNo": "",
                        "TrailerNo": "",
                        "DriverName": "",
                        "DriverLicenseNo": "",
                        "DriverMobileTel": "",
                        "DriverHomeTel": "",
                        "Warehouse": $("#form1 #Warehouse").val().trim(),
                        "ArrivalTime": $("#form1 #ArrivalTime").val().trim(),
                        "PayerId": $("#form1 #CustomerId").val().trim(),
                        "PayerName": $("#form1 #CustomerName").val().trim(),
                        "StartCountry": $("#form1 #StartCountry").val().trim(),
                        "StartProvince": $("#form1 #StartProvince").val().trim(),
                        "StartCity": $("#form1 #StartCity").val().trim(),
                        "Remark": $("#form1 #Remark").val().trim(),
                        "CreateTime": $("#form1 #CreateTime").val().trim(),
                        "Goods": goods
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
                                location.replace("/chenxk/Plan/SubmitDeliverPlans/");
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
