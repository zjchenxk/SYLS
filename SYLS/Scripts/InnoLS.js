//加法运算
function add(n1, n2) {
    var r1;
    try {
        r1 = n1.toString().split(".")[1].length;
    }
    catch (e) {
        r1 = 0;
    }

    var r2;
    try {
        r2 = n2.toString().split(".")[1].length;
    }
    catch (e) {
        r2 = 0;
    }

    var m = Math.pow(10, Math.max(r1, r2));
    return (n1 * m + n2 * m) / m;
}

//减法算法
function sub(n1, n2) {
    var r1;
    try {
        r1 = n1.toString().split(".")[1].length;
    }
    catch (e) {
        r1 = 0;
    }

    var r2;
    try {
        r2 = n2.toString().split(".")[1].length;
    }
    catch (e) {
        r2 = 0;
    }

    var m = Math.pow(10, Math.max(r1, r2));

    //last modify by deeka
    //动态控制精度长度
    var n = (r1 >= r2) ? r1 : r2;

    return ((n1 * m - n2 * m) / m).toFixed(n);
}

//乘法运算
function mul(n1, n2) {
    var m = 0, s1 = n1.toString(), s2 = n2.toString();

    try {
        m += s1.split(".")[1].length
    }
    catch (e) {
    }

    try {
        m += s2.split(".")[1].length
    }
    catch (e) {
    }

    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
}

//除法运算
function div(n1, n2) {
    var t1 = 0, t2 = 0;

    try {
        t1 = n1.toString().split(".")[1].length
    }
    catch (e) {
    }

    try {
        t2 = n2.toString().split(".")[1].length
    }
    catch (e) {
    }

    with (Math) {
        var r1 = Number(n1.toString().replace(".", ""))
        var r2 = Number(n2.toString().replace(".", ""))
        return (r1 / r2) * pow(10, t2 - t1);
    }
}

//拼接字符串
stringFormat = function () {
    if (arguments.length == 0)
        return null;

    var str = arguments[0];
    for (var i = 1; i < arguments.length; i++) {
        var re = new RegExp('\\{' + (i - 1) + '\\}', 'gm');
        str = str.replace(re, arguments[i]);
    }
    return str;
}

//jqGrid小数汇总累计方法
function myNumberSum(val, name, record) {
    var tunnages = add(parseFloat(val || 0), parseFloat((record[name] || 0)));
    return Math.round(tunnages * Math.pow(10, 6)) / Math.pow(10, 6);
}

//写Cookies
function SetCookie(name, value) {
    var exp = new Date(2999, 11, 31);
    document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
}

//读Cookies
function GetCookie(name) {
    var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
    if (arr = document.cookie.match(reg))
        return unescape(arr[2]);
    else
        return null;
}

//删除Cookies
function DeleteCookie(name) {
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval = GetCookie(name);
    document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
}
