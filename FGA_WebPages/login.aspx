<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="FGA_PLATFORM.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
     <title>FGA INFORMATION PLATFORM</title>
    <!-- Site favicon -->
    <link rel='shortcut icon' type='image/x-icon' href='images/favicon.ico' />
    <!-- /site favicon -->

    <!-- Entypo font stylesheet -->
    <link href="mouldifi-v-2.0/css/entypo.css" rel="stylesheet">
    <!-- /entypo font stylesheet -->

    <!-- Font awesome stylesheet -->
    <link href="mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- /font awesome stylesheet -->

    <!-- Bootstrap stylesheet min version -->
    <link href="mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- /bootstrap stylesheet min version -->

    <!-- Mouldifi core stylesheet -->
    <link href="mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet">
    <!-- /mouldifi core stylesheet -->

    <link href="mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
<![endif]-->
    <style type="text/css">
    /*chrome浏览器文本框填充问题处理(记住密码)*/
    input:-webkit-autofill {
     -webkit-box-shadow: 0 0 0px 1000px white  inset;/*去除黄色背景*/
     outline:none;/*去除蓝色边框*/
     -webkit-text-fill-color: #505050;/*去除自动填充的字体颜色*/
}
</style>
</head>

<body style="background-image: url(/images/bgimage03.jpg); background-size:cover">
    <form id="form1" runat="server">
        <div class="login-container">
             <div class="login-branding">
            </div>

            <div class="login-content">
                <h3><strong>Welcome to FGA Information Platform</strong></h3>
                <div class="form-group">
                    <input runat="server" id="account" type="text" placeholder="Username" class="form-control"/>
                </div>
                <div class="form-group">
                    <input runat="server" id="pwd" type="password" placeholder="Password" class="form-control"/>
                </div>
                <div class="form-group">
                    <div class="checkbox checkbox-replace">
                        <input type="checkbox" id="remeber"/>
                        <label for="remeber">Remember me</label>
                    </div>
                </div>
                <div class="form-group">
                    <label id="lblMsg" runat="server" style="color: Red; font-size: 12px;"></label>
                </div>
                <div class="form-group">
                    <asp:Button ID="btnsub" runat="server" Text="Login" CssClass="btn btn-primary btn-block" OnClick="btnsub_Click" OnClientClick="return check()" />
                </div>
            </div>
        </div>
        <!--Load JQuery-->
        <script src="javascript/jquery-1.11.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script>
            function check() {
                var bl = true;
                try {
                    if ($.trim($("#account").val()) == '') {
                        $("#lblMsg").html('Please input Username!');
                        return false;
                    }
                    if ($.trim($("#pwd").val()) == '') {
                        $("#lblMsg").html('Please input Password!');
                        return false;
                    }

                }
                catch (e) {
                    return true;
                }
                return bl;
            }
        </script>
    </form>
</body>

</html>
