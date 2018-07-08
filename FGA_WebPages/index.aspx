<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="FGA_PLATFORM.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>FGA INFORMATION PLATFORM</title>
    <link rel='shortcut icon' type='image/x-icon' href='images/favicon.ico' />
    <link href="mouldifi-v-2.0/css/entypo.css" rel="stylesheet" />
    <link href="mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />
    <link href="mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet" />
    <script src="mouldifi-v-2.0/js/html5shiv.min.js"></script>
    <script src="mouldifi-v-2.0/js/respond.min.js"></script>
	<script src="mouldifi-v-2.0/js/plugins/flot/excanvas.min.js"></script>

</head>
<body>
    <!-- Page container -->
    <div class="page-container sidebar-collapsed">

        <!-- Page Sidebar -->
        <div class="page-sidebar" style="">

            <!-- Site header  -->
            <header class="site-header">
                <div class="site-logo" style="color: white; font-weight: 700; font-size: 18px">FGA_PLATFORM</div>
                <div class="sidebar-collapse hidden-xs"><a class="sidebar-collapse-icon" href="#"><i class="icon-menu"></i></a></div>
                <div class="sidebar-mobile-menu visible-xs"><a data-target="#side-nav" data-toggle="collapse" class="mobile-menu-icon" href="#"><i class="icon-menu"></i></a></div>
            </header>
            <!-- /site header -->

            <!-- Main navigation -->
            <ul id="side-nav" class="main-menu navbar-collapse collapse">
                <%=menustr%>
            </ul>
            <!-- /main navigation -->
        </div>
        <!-- /page sidebar -->

        <!-- Main container -->
        <div class="main-container gray-bg">

            <!-- Main header -->
            <div class="main-header row">
                <div class="col-sm-6 col-xs-7">

                    <!-- User info -->
                    <ul class="user-info pull-left">
                        <li class="profile-info dropdown"><a data-toggle="dropdown" class="dropdown-toggle" href="#" aria-expanded="false">
                            <asp:Literal runat="server" ID="ltusername"></asp:Literal><span class="caret"></span></a>

                            <!-- User action menu -->
                            <ul class="dropdown-menu">
                                <li><a href="system/changepsd.aspx"><i class="icon-vcard"></i>ChangePsd</a></li>
                                <li><a href="javascript:systemout()"><i class="icon-logout"></i>Logout</a></li>
                            </ul>
                            <!-- /user action menu -->
                        </li>
                    </ul>
                    <!-- /user info -->

                </div>

            </div>
            <!-- /main header -->

            <!-- Main content -->
            <div class="main-content" style="margin: 0; padding: 0">
                <iframe id="fcontent" name="fcontent" src="" scrolling="auto" border="0" width="100%" style="border: 0 none"></iframe>

            </div>

        </div>

    </div>

    <!--Load JQuery-->
    <script src="javascript/jquery-1.11.1.min.js"></script>
   

    <link href="javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
    <script src="javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
    <script src="javascript/common.js" type="text/javascript"></script>

    <script>
        <!--window.open('index.aspx', 'newwindow', 'height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no')-->
        //模块图标定义
        var iconList = {
            "001001": "icon-note",          //SystemAdmin
            "001002": "icon-tools",         //Production
            //"001003": "icon-chart-bar",   
            "001004": "icon-book-open",     //Financial
            "001005": "icon-chart-bar",     //ReportHome
            //"001009": "icon-tools",       
            //"001010": "icon-tools",
            "001006": "icon-keyboard",       //IT Assets Managemant
            "001020": "icon-monitor"       //Home

        }
        //$(function () {
        //    //加载菜单
        //    getmenu();
        //})
        $(document).ready(function () {
            loadIcon();
            iFrameHeight();
            //selectFirstNode();

        });
        window.onresize = iFrameHeight;
        function iFrameHeight() {
            //高度是 整体高度- 头部
            var height = document.body.parentNode.clientHeight - $(".row").height() - 30 + "px";
            document.getElementById("fcontent").style.height = height;
            $(".page-sidebar").css('height', height);

            //宽度是  整体宽度-左边-1px ；-1px是为避免在火狐浏览器下缩放窗体时frame会跳动到下方
            //if ($("#menu-toggler").css('display') != 'none') {//宽度变窄时菜单完全收起不在同一层，不占当前层宽度
            //    document.getElementById("fright").style.width = document.body.parentNode.clientWidth - 1 + "px";
            //}
            //else {
            //    document.getElementById("fright").style.width = document.body.parentNode.clientWidth - $(".page-sidebar").offsetWidth - 1 + "px";
            //}
            //document.getElementById("fright").style.width = document.body.parentNode.clientWidth - document.getElementById("sidebar").offsetWidth + "px";

        }
        /*首次加载默认选中项*/
        function selectFirstNode() {
            var lis = $("#side-nav").find('li').first().find('ul').first().find('li');
            var href = '';
            if (lis.length > 0) {
                $("#side-nav").find('li').first().find('ul').addClass('in');;
                $("#side-nav").find('li').first().addClass('active');
                $(lis[0]).addClass('active');
                href = $(lis[0]).find("a").attr("href");
                $("#fcontent").attr("src", href);
            }
            else {
                $("#side-nav").find('li').first().addClass('active');
                href = $("#side-nav").find('li').first().find("a").attr("href");
                $("#fcontent").attr("src", href);
            }
        }

       
        /* 退出 */
        function systemout() {

            $.ajax({
                type: "Post",
                url: "index.aspx/LoginOut",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                }
            });

            window.location.href = 'login.aspx';
        }
        /*加载菜单*/
        function getmenu() {
            $.ajax({
                type: "Post",
                url: "index.aspx/LoadMenu",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#side-nav").html(data.d);
                }
            });
        }
        /*加载菜单图标*/
        function loadIcon() {
            var icon = $(".icon");
            icon.each(function (i) {
                var ids = $(this).attr("id");
                $(this).addClass(iconList[ids]);
            });
        }
    </script>
     <script src="mouldifi-v-2.0/js/jquery.min.js"></script>
    <script src="mouldifi-v-2.0/js/bootstrap.min.js"></script>
    <script src="mouldifi-v-2.0/js/plugins/metismenu/jquery.metisMenu.js"></script>
    <script src="mouldifi-v-2.0/js/plugins/blockui-master/jquery-ui.js"></script>
    <script src="mouldifi-v-2.0/js/plugins/blockui-master/jquery.blockUI.js"></script>
    <!--Float Charts-->
    <script src="mouldifi-v-2.0/js/plugins/flot/jquery.flot.min.js"></script>
    <script src="mouldifi-v-2.0/js/plugins/flot/jquery.flot.tooltip.min.js"></script>
    <script src="mouldifi-v-2.0/js/plugins/flot/jquery.flot.resize.min.js"></script>
    <script src="mouldifi-v-2.0/js/plugins/flot/jquery.flot.selection.min.js"></script>
    <script src="mouldifi-v-2.0/js/plugins/flot/jquery.flot.pie.min.js"></script>
    <script src="mouldifi-v-2.0/js/plugins/flot/jquery.flot.time.min.js"></script>
    <script src="mouldifi-v-2.0/js/functions.js"></script>
</body>
</html>

