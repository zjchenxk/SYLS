<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Workspace.master"
    Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.ImportCustomers %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul id="menu">
        <li><a href="/chenxk/System/SetCustomer/" onclick="javascript:location.replace(this.href);return false;">
            <img src="<%: Url.Content("~/Content/Images/051.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Back %></a></li>
        <li><a href="#" onclick="javascript:objMain.objWorkspace.objContent.saveFile();return false;">
            <img src="<%: Url.Content("~/Content/Images/053.png") %>" alt="" style="border: none;" /><%:InnoSoft.LS.Resources.Menus.Save %></a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="WorkspaceContent" runat="server">
    <form id="form1" action="/chenxk/System/UploadCustomersFile" method="post" enctype="multipart/form-data">
    <fieldset style="border: none;">
        <div class="editor-label">
            <%: InnoSoft.LS.Resources.Labels.UploadFileName %>(<a href="/chenxk/System/DownloadCustomersFile/"><%: InnoSoft.LS.Resources.Labels.ImportFileExample %></a>)
        </div>
        <div class="editor-field">
            <input id="FileName" name="FileName" type="file" />
        </div>
        <div id="outputdiv">
        </div>
    </fieldset>
    </form>
    <script type="text/javascript">

        //工作区内容对象
        function WorkspaceContent() {
            //调整工作内容布局
            this.resizeContent = function () {
            };
            //设置输入焦点
            this.setFocus = function () {
                //默认名称获得焦点
                $("#FileName").focus().select();
            };
            //保存数据
            this.saveFile = function () {
                var fileName = $("#FileName").val().trim();
                if (fileName == "") {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotEnterExcelFileName %>");
                }
                else if (fileName.split(".")[1].toUpperCase() == "XLS" || fileName.split(".")[1].toUpperCase() == "XLSX") {
                    $("#form1").submit();
                }
                else {
                    alert("<%: InnoSoft.LS.Resources.Strings.NotValidExcelFile %>");
                }
            };
        };
        objMain.objWorkspace.objContent = new WorkspaceContent();

        //页面初始化
        $(document).ready(function () {
            var options = {
                target: null,
                beforeSubmit: showRequest,
                success: showResponse
            };

            $('#form1').submit(function () {
                $(this).ajaxSubmit(options);
                return false;
            });
        });

        //发送前
        function showRequest(formData, jqForm, options) {
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
            return true;
        }

        //发送后
        function showResponse(responseText, statusText) {
            $.unblockUI();

            if (responseText != null && responseText != "") {
                alert(responseText);
            }
            else {
                alert("<%: InnoSoft.LS.Resources.Strings.SaveSucceed %>");
                location.replace("/chenxk/System/SetCustomer/");
            }
        } 

    </script>
</asp:Content>
