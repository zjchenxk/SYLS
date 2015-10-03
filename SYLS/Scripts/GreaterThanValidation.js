$.validator.addMethod("greaterthan", function (value, element, param) {
    if (value == null) {
        return true;
    }
    else if ($("#" + param).val() == null) {
        return true;
    }
    else {
        return parseFloat(value) > parseFloat($("#" + param).val());
    }
});
$.validator.unobtrusive.adapters.addSingleVal("greaterthan", "otherproperty");
