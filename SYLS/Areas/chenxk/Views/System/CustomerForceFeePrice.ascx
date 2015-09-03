<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.CustomerForceFeePriceViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formForceFeePrice" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.ForceFeePriceStartTime)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.ForceFeePriceStartTime)%><br />
                <%: Html.ValidationMessageFor(model => model.ForceFeePriceStartTime)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.ForceFeePriceEndTime)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.ForceFeePriceEndTime)%><br />
                <%: Html.ValidationMessageFor(model => model.ForceFeePriceEndTime)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.LoadingForceFeePrice)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.LoadingForceFeePrice)%><br />
                <%: Html.ValidationMessageFor(model => model.LoadingForceFeePrice)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.UnloadingForceFeePrice)%>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.UnloadingForceFeePrice)%><br />
                <%: Html.ValidationMessageFor(model => model.UnloadingForceFeePrice)%>
            </div>
        </td>
    </tr>
</table>
<% } %>
<script type="text/javascript">

    //页面初始化
    $(document).ready(function () {
        //设置起始时间
        $("#formForceFeePrice #ForceFeePriceStartTime").datepicker($.datepicker.regional["zh-CN"]);

        //设置截止时间
        $("#formForceFeePrice #ForceFeePriceEndTime").datepicker({
            changeYear: true,
            yearRange: "2010:9999"
        });
        $("#formForceFeePrice #ForceFeePriceEndTime").datepicker("option", $.datepicker.regional["zh-CN"]);

    });

</script>
