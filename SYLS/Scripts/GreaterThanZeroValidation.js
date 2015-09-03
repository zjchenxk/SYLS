$.validator.addMethod("greaterthanzero", function (value, element) {
    if (value == null) {
        return false;
    }
    else {
        return (parseFloat(value) > 0);
    }
});
$.validator.unobtrusive.adapters.addBool("greaterthanzero");
