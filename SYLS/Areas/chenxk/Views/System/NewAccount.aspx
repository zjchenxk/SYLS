<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<SYLS.Areas.chenxk.ViewModels.AccountViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.NewAccount %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/System/SetAccount/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveAccount();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <% using (Html.BeginForm("NewAccount", "System", FormMethod.Post, new { id = "form1" }))
       { %>
    <fieldset style="border: none;">
        <table>
            <tr>
                <td style="width: 100px;">
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
                        <%: Html.LabelFor(model => model.AccountType) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.AccountType, new SelectListItem[]
                        {
                            new SelectListItem{Text = InnoSoft.LS.Resources.Options.Staff, Value = InnoSoft.LS.Resources.Options.Staff, Selected = true},
                            new SelectListItem{Text = InnoSoft.LS.Resources.Options.Customer, Value = InnoSoft.LS.Resources.Options.Customer}
                        }, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.AccountType) %>
                    </div>
                </td>
            </tr>
        </table>
        <table id="tableStaff">
            <tr>
                <td style="width: 100px;">
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.OrganId) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.OrganId, ViewData["Organizations"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.OrganId) %>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.StaffId) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.StaffId, ViewData["Staffs"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.StaffId) %>
                    </div>
                </td>
            </tr>
        </table>
        <table id="tableCustomer">
            <tr>
                <td style="width: 100px;">
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.CustomerId) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.DropDownListFor(model => model.CustomerId, ViewData["Customers"] as SelectList, new { style = "font-family: Arial;" })%>
                        <%: Html.ValidationMessageFor(model => model.CustomerId)%>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="editor-label-right">
                        <%: Html.LabelFor(model => model.ContactName) %>
                    </div>
                </td>
                <td>
                    <div class="editor-field">
                        <%: Html.EditorFor(model => model.ContactName) %>
                        <%: Html.ValidationMessageFor(model => model.ContactName) %>
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
                //默认名称获得焦点
                $("#Name").focus().select();
            };
            //保存数据
            this.saveAccount = function () {
                $('#form1').submit();
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            //禁用客户信息
            document.getElementById("tableCustomer").style.display = "none";

            //帐号类别选择事件
            $("#AccountType").change(function () {
                $("#OrganId").empty();
                $("#OrganId").append("<option value='0'></option>");

                $("#StaffId").empty();
                $("#StaffId").append("<option value='0'></option>");

                $("#CustomerId").empty();
                $("#CustomerId").append("<option value='0'></option>");

                $("#ContactName").val("");

                if ($(this).val().trim() == "<%: InnoSoft.LS.Resources.Options.Staff %>") {
                    document.getElementById("tableStaff").style.display = "inline";

                    document.getElementById("tableCustomer").style.display = "none";

                    $.get("/Common/LoadOrganizations", function (ret) {
                        $.each(ret, function (i, organ) {
                            var option = $("<option></option>").val(organ.Id).text(organ.FullName);
                            option.appendTo($("#OrganId"));
                        });
                    }, "text json").error(function (xhr, status, error) {
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
                else {
                    document.getElementById("tableStaff").style.display = "none";

                    document.getElementById("tableCustomer").style.display = "inline";

                    $.get("/Common/LoadCustomers", function (ret) {
                        $.each(ret, function (i, customer) {
                            var option = $("<option></option>").val(customer.Id).text(customer.Name);
                            option.appendTo($("#CustomerId"));
                        });
                    }, "text json").error(function (xhr, status, error) {
                        if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                    });
                }
            });

            //组织部门选择事件
            $("#OrganId").change(function () {
                $("#StaffId").empty();
                $("#StaffId").append("<option value='0'></option>");

                $.get("/Common/LoadOrganizationStaffs", { nOrganId: $(this).val().trim() }, function (ret) {
                    $.each(ret, function (i, staff) {
                        var option = $("<option></option>").val(staff.Id).text(staff.FullName);
                        option.appendTo($("#StaffId"));
                    });
                }, "text json").error(function (xhr, status, error) {
                    $("#OrganId").get(0).selectedIndex = 0;
                    if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
                });
            });

            //客户选择事件
            $("#CustomerId").change(function () {
                $("#ContactName").val("");
            });

            //提交事件
            $("#form1").submit(function () {
                if ($(this).valid()) {
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
                    $.post($(this).attr("action"), $(this).serialize(), function (ret) {
                        $.unblockUI();

                        if (ret != null && ret != "") {
                            alert(ret);
                        }
                        else {
                            alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceed %>");
                            location.replace("/chenxk/System/SetAccount/");
                        }
                    });
                }
                return false;
            });
        });

    </script>
</asp:Content>
