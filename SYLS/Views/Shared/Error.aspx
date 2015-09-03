<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<System.Web.Mvc.HandleErrorInfo>" %>

<asp:Content ID="errorTitle" ContentPlaceHolderID="TitleContent" runat="server">
    <%: InnoSoft.LS.Resources.Titles.Error %>
</asp:Content>
<asp:Content ID="errorContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="dialog" title="<%: InnoSoft.LS.Resources.Titles.Error %>">
        <div style="text-align: center;">
            <img src="<%: Url.Content("~/Content/Images/072.png") %>" alt="" />
            <div style="text-align: left;">
                <h3>
                    <%: Html.DisplayTextFor(m=>m.Exception.Message) %>
                </h3>
                <p>
                    <%: Html.DisplayTextFor(m=>m.Exception.StackTrace) %>
                </p>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#dialog").dialog({ width: 650, draggable: false, resizable: false });
        });

    </script>
</asp:Content>
