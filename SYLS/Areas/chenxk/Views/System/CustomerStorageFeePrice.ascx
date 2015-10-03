<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.CustomerStorageFeePriceViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formStorageFeePrice" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.StorageFeePriceStartTime)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.StorageFeePriceStartTime)%><br />
                <%: Html.ValidationMessageFor(model => model.StorageFeePriceStartTime)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.StorageFeePriceEndTime)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.StorageFeePriceEndTime)%><br />
                <%: Html.ValidationMessageFor(model => model.StorageFeePriceEndTime)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.StorageFeePrice)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.StorageFeePrice)%><br />
                <%: Html.ValidationMessageFor(model => model.StorageFeePrice)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置起始时间
        $("#formStorageFeePrice #StorageFeePriceStartTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置截止时间
        $("#formStorageFeePrice #StorageFeePriceEndTime").datepicker({
            changeYear: true,
            yearRange: "2010:9999"
        });
        $("#formStorageFeePrice #StorageFeePriceEndTime").datepicker("option", $.datepicker.regional["zh-CN"]);

    });

</script>
