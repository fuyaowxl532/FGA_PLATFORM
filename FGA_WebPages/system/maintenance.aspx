<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="maintenance.aspx.cs" Inherits="FGA_PLATFORM.system.maintenance" %>

<%@ Register Src="~/ascx/boottom.ascx" TagPrefix="uc1" TagName="boottom" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>日常维护</title>
    <!--站内样式-->

    <script src="../javascript/jquery-3.1.0.min.js"></script>
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <script src="../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
    <link href="../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
    <script src="../javascript/common.js"></script>
    <link href="../mouldifi-v-2.0/css/style.css" rel="stylesheet" />
    <!-- Font awesome stylesheet -->
    <link href="../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- /font awesome stylesheet -->

    <!-- Bootstrap stylesheet min version -->
    <link href="../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        fieldset {
            border-radius: 5px 5px 5px 5px;
            border: solid 1px #ccc;
        }

        legend {
            padding-left: 5px;
            padding-right: 5px;
            margin-bottom: 0px;
            font-size: 13px;
            font-weight: bold;
            width: auto;
            border: 0;
            color: #03498f;
            margin-left: 10px;
        }
        .divlegend {
            padding:5px;
            padding-left:15px;
            line-height:30px;
        }
        .ul-v {
            padding: 15px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="divcontent">
            <div class="divmain">
                <div class="tab">
                    <div class="head"><i class="fa fa-wrench"></i>&nbsp;&nbsp;系统管理 /&nbsp;<i class="fa fa-refresh"></i>&nbsp;日常维护</div>
                    <div class="content">
                        <fieldset>
                            <legend>刷新缓存</legend>
                            <div class="divlegend">
                                <asp:Button Text=" 刷 新 " runat="server" ID="btnRefresh" CssClass="btn btn-primary" OnClick="btnRefresh_Click" Width="80" />
                                <div class="tab-tooltip">
                                    <i class="icon-volume-down"></i>&nbsp;点击刷新按钮,刷新系统相关基础数据缓存。
                                </div>
                            </div>
                        </fieldset>

                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

