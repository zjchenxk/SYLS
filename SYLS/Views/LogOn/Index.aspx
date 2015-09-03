<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<SYLS.ViewModels.LogOnViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.AppName %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="divBar" style="background-color: #2A5182; width: 100%; position: absolute;
        display: none;">
    </div>
    <div id="divSlogan" style="width: 100%; position: absolute; text-align: center; display: none;">
        <h2>
            <%: InnoSoft.LS.Resources.Strings.Philosophy %></h2>
    </div>
    <div id="divLogOn" style="width: 400px; height: 350px; position: absolute; z-index: 101;
        display: none;">
        <table border="0" cellpadding="0" cellspacing="0" style="height: 100px; width: 100%;">
            <tr>
                <td style="vertical-align: middle;">
                    <img src="<%: Url.Content("~/Content/Images/005.png") %>" alt="" />
                </td>
            </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0" style="height: 250px; width: 100%;">
            <tr style="height: 6px;">
                <td class="RoundCornerLeftTop">
                </td>
                <td class="RoundCornerTop">
                </td>
                <td class="RoundCornerRightTop">
                </td>
            </tr>
            <tr>
                <td class="RoundCornerLeft">
                </td>
                <td align="center" valign="top" style="background-color: #F5F8FB;">
                    <% using (Html.BeginForm("Index", "LogOn", FormMethod.Post, new { id = "form1" }))
                       { %>
                    <div style="width: 300px;">
                        <div class="editor-label">
                            <%: Html.LabelFor(m => m.LoginAccount)%>
                        </div>
                        <div class="editor-field">
                            <%: Html.TextBoxFor(m => m.LoginAccount, new { @style = "width:300px;" })%><br />
                            <%: Html.ValidationMessageFor(m => m.LoginAccount) %>
                        </div>
                        <div class="editor-label">
                            <%: Html.LabelFor(m => m.Password) %>
                        </div>
                        <div class="editor-field">
                            <%: Html.PasswordFor(m => m.Password, new { @style = "width:300px;" })%><br />
                            <%: Html.ValidationMessageFor(m => m.Password) %>
                        </div>
                        <div class="editor-label">
                            <%: Html.LabelFor(m => m.IndentifyCode) %>
                        </div>
                        <div class="editor-field">
                            <%: Html.TextBoxFor(m => m.IndentifyCode, new { @style = "width:300px;" })%><br />
                            <img id="imgIndentifyCode" src="<%= Url.Action("CreateImageCode", "LogOn")%>" alt=""
                                title="<%: InnoSoft.LS.Resources.ToolTips.ClicktoChangeIndentifyCode %>" /><br />
                            <%: Html.ValidationMessageFor(m => m.IndentifyCode)%>
                        </div>
                        <p style="text-align: right;">
                            <button id="btnLogin" type="button">
                                <img src="<%: Url.Content("~/Content/Images/080.png") %>" alt="" />
                                <%: InnoSoft.LS.Resources.Buttons.Login %>
                            </button>
                        </p>
                    </div>
                    <% } %>
                </td>
                <td class="RoundCornerRight">
                </td>
            </tr>
            <tr style="height: 6px;">
                <td class="RoundCornerLeftBottom">
                </td>
                <td class="RoundCornerBottom">
                </td>
                <td class="RoundCornerRightBottom">
                </td>
            </tr>
        </table>
    </div>
    <script language="javascript" type="text/javascript">

        function AdjustLayout() {
            var bar = $("#divBar");
            var heightBar = $(window).height() * 0.3;
            var topBar = $(window).height() * 0.6;
            bar.css("height", heightBar + "px");
            bar.css("top", topBar + "px");
            bar.css("display", "block");

            var slogan = $("#divSlogan");
            var heightSlogan = $(window).height() * 0.1;
            var topSlogan = $(window).height() * 0.9;
            slogan.css("height", heightSlogan + "px");
            slogan.css("top", topSlogan + "px");
            slogan.css("display", "block");

            var logon = $("#divLogOn");
            var topLogOn = (topBar + heightBar * 0.5) - logon.height();
            var leftLogOn = ($(window).width() - logon.width()) / 2;
            logon.css("top", topLogOn + "px");
            logon.css("left", leftLogOn + "px");
            logon.css("display", "block");
        }

        $(document).ready(function () {
            $.ajaxSetup({ cache: false });

            //$.jStorage.deleteKey("ActivedAccordionHead");

            $(window).resize(AdjustLayout);

            //回车转TAB
            $(document).keydown(function (evt) {
                var key;
                var srcobj;

                if ($.browser.msie && parseInt($.browser.version, 10) < 9) {
                    key = event.keyCode;
                    srcobj = event.srcElement;
                }
                else {
                    key = evt.which;
                    srcobj = evt.target;
                }
                if (key == 13 && srcobj.type != "textarea" && srcobj.type != "") {
                    if ($.browser.msie && parseInt($.browser.version, 10) < 9) {
                        event.keyCode = 9;
                    }
                    else {
                        var el = getNextElement(evt.target);
                        if (el != null) {
                            el.focus();
                            return false;
                        }
                    }
                }
            });

            //点击更换验证码
            $("#imgIndentifyCode").click(function () {
                $("#imgIndentifyCode").attr("src", '<%=Url.Content("~/LogOn/CreateImageCode?")%>' + Math.random());
                $("#IndentifyCode").focus().select();
            });

            //登录按钮点击事件
            $("#btnLogin").button().click(function () {
                $('#form1').submit();
            });

            //提交事件
            $('#form1').submit(function () {
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
                    $.post($(this).attr('action'), $(this).serialize(), function (ret) {
                        $.unblockUI();

                        if (ret != null && ret != "") {
                            alert(ret);
                            $("#imgIndentifyCode").attr("src", '<%=Url.Content("~/LogOn/CreateImageCode?")%>' + Math.random());
                        }
                        else {
                            location.replace("/Home/Main/");
                        }
                    });
                }
                return false;
            });

        });

        function getNextElement(field) {
            //debugger; //启动javascript调试器
            while (true) {
                var form = field.form;
                if (form == undefined) {
                    return null;
                }

                for (var e = 0; e < form.elements.length; e++) {
                    if (field == form.elements[e])
                        break;
                }

                var el = form.elements[++e % form.elements.length];

                if (el.id == null || el.id == "") {
                    field = el;
                }
                else if (el.type == "hidden") {
                    field = el;
                }
                //else if ($("#" + el.id).attr("readonly") == true || $("#" + el.id).attr("readonly") == "readonly") {
                //    field = el;
                //}
                else if ($("#" + el.id).attr("disabled") == true || $("#" + el.id).attr("disabled") == "disabled") {
                    field = el;
                }
                else if ($("#" + el.id).css("display") == "none") {
                    field = el;
                }
                else {
                    return el;
                }
            }
        }

        $(window).load(function () {
            //调整窗口布局
            AdjustLayout();

            //默认帐户名获得焦点
            $("#LoginAccount").focus().select();
        });

    </script>
</asp:Content>
