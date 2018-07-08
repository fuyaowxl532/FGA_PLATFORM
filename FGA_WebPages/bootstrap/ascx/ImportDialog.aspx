<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImportDialog.aspx.cs" Inherits="FGA_PLATFORM.ascx.ImportDialog" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../css/style/crumbs.css" rel="stylesheet" type="text/css" />
    <link id="pageskinstyle" href="../css/style/style_gray.css" rel="stylesheet" />
    <script src="../javascript/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../javascript/common.js"></script>

    <title></title>
    <script type="text/javascript">
        function changeTab() {
            try {
                if ($("#AllHead").html() == "" || $("#AllHead").html() == null) {

                    var opertype = GetQueryString("opertype");
                    var pagename = GetQueryString("pagename");

                    $.ajax({
                        url: "ImportDialog.aspx/GetAllHead",
                        data: "{pagename:'" + pagename + "'}",
                        method: 'post',
                        contentType: "application/json; charset=utf-8",
                        dataType: 'json',
                        async: true,
                        success: function (data) {
                            var res = data.d;
                            if (res != "" && res != null) {
                                var sz = res.split(",");
                                var htmlString = "";
                                for (var i = 0; i < sz.length; i++) {
                                    if ((i + 1) % 3 == 1) {
                                        htmlString += "<div style=\"height:30px;margin-left:56px;\">";
                                    }
                                    htmlString += "<div  style=\"width:100px;float:left;text-align:left\"><input type=\"checkbox\" name=\"head\" value=\"" + sz[i] + "\" /> " + sz[i] + "</div>";

                                    if ((i + 1) % 3 == 0) {
                                        htmlString += "</div>";
                                    }
                                }

                                htmlString += "</div>";

                                $("#AllHead").html(htmlString);

                            }
                        }
                    });
                }

                $("#AllHead").css("display", "block");
                $("#title").css("display", "block");

            } catch (e) {
                $("#error").html(e.message);
            }
        }



        function Default() {
            $("#AllHead").css("display", "none");
            $("#title").css("display", "none");
        }


        function AddLog() {
            //先写日志
            var pagename = GetQueryString("pagename");
            $.ajax({
                url: "ImportDialog.aspx/AddLog",
                data: "{pagename:'" + pagename + "'}",
                method: 'post',
                contentType: "application/json; charset=utf-8",
                dataType: 'json',
                async: false,
                success: function (data) {
                    var t = data.d;
                }
            });
        }

        function Import() {

            try {

                if ($("#rdoDefault").is(":checked")) { //导出所选按照以前的
                    AddLog();
                    location.href = "../ajaxhandle/GlobalHandle.ashx?opertype=" + GetQueryString("opertype") + "&r=" + Math.random();
                }
                if ($("#rdoCustom").is(":checked")) { //导出全部

                    var t = "";
                    $('input[name="head"]:checked').each(function () {
                        t += $(this).val() + ",";
                    });
                    if (t == "") {
                        alert('未选择任何数据');
                        return;
                    } else {
                        AddLog();
                        location.href = "../ajaxhandle/GlobalHandle.ashx?opertype=" + GetQueryString("opertype") + "&custom=" + t + "&pagename=" + GetQueryString("pagename") + "&r=" + Math.random();
                    }
                }

            } catch (e) {
                $("#error").html(e.message);
            }

           
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%; margin-top: 20px;" border="0">
            <tr>
                <td style="height: 30px; width: 50%;" align="center">
                    <input type="radio" name="g" id="rdoDefault" checked="checked" onclick="Default();" />
                    默认格式导出</td>
                <td align="center">
                    <input type="radio" name="g" id="rdoCustom" onclick="changeTab();" />
                    自定义格式导出</td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <div style="display: none; border-bottom: 1px dotted #767676; width: 94%;" id="title"></div>
                    <div id="AllHead" style="display: none; margin-top: 18px;"></div>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input name="" id="btnSearch" type="button" value="导&nbsp;出" onclick="Import();" class="btn1"></td>
            </tr>

        </table>
        <div id="error"></div>

    </form>
</body>
</html>
