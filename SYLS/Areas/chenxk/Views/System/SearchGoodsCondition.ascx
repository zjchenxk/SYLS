<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SYLS.Areas.chenxk.ViewModels.SearchGoodsConditionViewModel>" %>
<% using (Html.BeginForm("", "", FormMethod.Post, new { id = "formSearchGoodsCondition" }))
   { %>
<table>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.GoodsNo) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.GoodsNo) %><br />
                <%: Html.ValidationMessageFor(model => model.GoodsNo) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.GoodsName) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.GoodsName)%><br />
                <%: Html.ValidationMessageFor(model => model.GoodsName)%>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.SpecModel) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.SpecModel) %><br />
                <%: Html.ValidationMessageFor(model => model.SpecModel) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.GWeight) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.GWeight) %><br />
                <%: Html.ValidationMessageFor(model => model.GWeight) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.Grade) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Grade) %><br />
                <%: Html.ValidationMessageFor(model => model.Grade) %>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="editor-label-right">
                <%: Html.LabelFor(model => model.Packing) %>
            </div>
        </td>
        <td>
            <div class="editor-field">
                <%: Html.DropDownListFor(model => model.Packing, new SelectListItem[] { new SelectListItem { Text = string.Empty, Value = string.Empty }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.HaveReam, Value = InnoSoft.LS.Resources.Options.HaveReam }, new SelectListItem { Text = InnoSoft.LS.Resources.Options.NoReam, Value = InnoSoft.LS.Resources.Options.NoReam } }, new { style = "font-family: Arial;" })%>
                <%: Html.ValidationMessageFor(model => model.Packing) %>
            </div>
        </td>
    </tr>
</table>
<% } %>
