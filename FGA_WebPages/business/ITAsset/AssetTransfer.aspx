<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetTransfer.aspx.cs" Inherits="FGA_PLATFORM.business.ITAsset.AssetTransfer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>AssetTransfer</title>
<link href="../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
<link id="pageskinstyle" href="../../css/style/style_gray.css" rel="stylesheet" />
<link href="../../css/style/mystyle.css" rel="stylesheet" />
<link rel='shortcut icon' type='image/x-icon' href='../../images/favicon.ico' />
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet"/>
<link href="../../css/style.css" rel="stylesheet" />
<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/plugins/datepicker/bootstrap-datepicker.css" rel="stylesheet"/>

<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/bootstrap.min.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/metismenu/jquery.metisMenu.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/blockui-master/jquery.blockUI.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/blockui-master/jquery-ui.js"></script>

<script src="../../mouldifi-v-2.0/js/tableExport.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.base64.js"></script>
<script src="../../javascript/jquery-3.1.0.min.js"></script>
<script src="../../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
<script src="../../javascript/common.js" type="text/javascript"></script>
<script src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<script src="../../javascript/ValidationCheck.js"></script>

</head>

<body>

    <input type="hidden" id="hidPageSize" value='<%= pagesize %>' />

     <!--页面内容-->
    <div style="margin-top:10px;">
        <h3>
            <input type ="text" id ="_filter" style="height:100%;width:100%;background-color:yellow" onkeyup="SearchData()"/>
        </h3>
        
    </div>

    <div>
         <table id ="edittable" style="width:600px;height: 530px" border="0" class="table table-striped table-bordered table-hover dataTables-example dataTable">
           
            <thead>
                <tr>
                    <th style ="text-align :left">First Name</th>
                    <th style ="text-align :left">Last Name</th>
                    <th style ="text-align :left">Department</th>
                    <th style ="text-align :left">PLEX ID</th>
                </tr>
            </thead>
            <tbody id ="tby"></tbody>
        </table>
    </div>

    <!-- 分页 -->
<div class="clear"></div>
<div class="pagination" id="pager1"></div>


<!-- Input Mask-->
<script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="http://oss.sheetjs.com/js-xlsx/xlsx.full.min.js"></script>
<script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
<link href="../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
<script src="../../javascript/JSPager.js"></script>
<script src="../../javascript/DateOperate.js"></script>

    <script  type="text/javascript">

        /* 页面加载 */
        $(document).ready(function () {

            //按钮事件  $('#btnSearch').click(function () {
            JSPager.currentIndex = 1;
            JSPager.pageSize = $('#hidPageSize').val();
            SearchData();
            $('input').focus();
        });

        function SearchData() {

            var filter = $('#_filter').val();

            $.ajax({
                type: "Post",
                url: "AssetTransfer.aspx/SearchData",
                data: "{CurrentPageIndex:'" + JSPager.currentIndex + "',PageSize:'" + JSPager.pageSize + "',filter:'" + filter + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    if (data.d != "") {
                        var json = $.parseJSON(data.d);
                        var slct = "";

                        for (var i = 0; i < json.length; i++) {

                            slct = slct + '<tr onclick="setTransfer(this)">' +
                                '<td>' + json[i].FirstName + '</td> ' +
                                '<td>' + json[i].LastName + '</td> ' +
                                '<td>' + json[i].Department + '</td> ' +
                                '<td>' + json[i].PlexID + '</td> ' +
                                '</tr>';
                        }
                        $("#tby").html(slct);

                        //pager2
                        JSPager.totalRecord = 5000;
                        JSPager.doPager = SearchData;
                        JSPager.initPager('pager1');
                    }
                }
            });
        }

        //Asset Move to 
        function setTransfer(obj) {
            var plexid = obj.cells[3].childNodes[0].data;
            var key = '<%= _assetKey %>';

            if (confirm("Transfer")) {
                $.ajax({
                    type: "post",
                    url: "AssetTransfer.aspx/DoTransfer",
                    data: "{assetKeys:'" + key + "',plexid:'" + plexid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        var json = data.d;
                        if (json != '') {

                        }

                    }
                });

                window.parent.ymPrompt.doHandler('ok', true);
            }


        }

    </script>

</body>
</html>
