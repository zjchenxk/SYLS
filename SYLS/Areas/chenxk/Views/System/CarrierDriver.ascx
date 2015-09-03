<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.CarrierDriverViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formDriver" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.Name) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Name) %><br />
                <%: Html.ValidationMessageFor(model => model.Name) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.LicenseNo) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.LicenseNo) %><br />
                <%: Html.ValidationMessageFor(model => model.LicenseNo) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.MobileTel) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.MobileTel) %><br />
                <%: Html.ValidationMessageFor(model => model.MobileTel) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.HomeTel) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.HomeTel) %><br />
                <%: Html.ValidationMessageFor(model => model.HomeTel) %>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div>
                <table id="gridCarNo">
                </table>
                <div id="pagerCarNo">
                </div>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //创建车号表格
        $("#gridCarNo").jqGrid({
            url: "",
            datatype: "local",
            mtype: "GET",
            colNames: [
                "<%: InnoSoft.LS.Resources.Labels.CarNo %>"],
            colModel: [
                { name: "CarNo", index: "CarNo", width: 200, align: "center"}],
            rowNum: 500,
            rowList: [50, 100, 500, 1000, 5000],
            sortname: "",
            sortorder: "asc",
            pager: "#pagerCarNo",
            viewrecords: true,
            emptyrecords: "<%: InnoSoft.LS.Resources.Strings.EmptyGrid %>",
            shrinkToFit: false,
            width: 470,
            multiselect: true,
            loadError: function (xhr, status, error) {
                if (xhr != null && xhr != undefined && xhr.responseText != null && xhr.responseText != "") alert(xhr.responseText);
            }
        });
        $("#gridCarNo").jqGrid("navGrid", "#pagerCarNo", { edit: false, add: false, del: false, search: false });
    });

</script>
