<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetsCard.aspx.cs" Inherits="FGA_PLATFORM.business.ITAsset.AssetsCard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>AssetsCard</title>
    <link href="../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
    <link id="pageskinstyle" href="../../css/style/style_gray.css" rel="stylesheet" />
    <link href="../../css/style/mystyle.css" rel="stylesheet" />
    <!-- Font awesome stylesheet -->
    <link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
    <link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
    <!-- /font awesome stylesheet -->
    <!-- Bootstrap stylesheet min version -->
    <link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />
    <link href="../../css/style.css" rel="stylesheet" />
    <!--弹消息窗样式-->
    <link href="../../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
    <link href="../../javascript/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
    <link href="../../javascript/My97DatePicker/skin/default/datepicker.css" rel="stylesheet" />
    <!-- jquery脚本库 -->
    <script src="../../javascript/jquery-3.1.0.min.js"></script>

    <script src="../../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
    <script src="../../javascript/common.js" type="text/javascript"></script>
    <script src="../../javascript/My97DatePicker/WdatePicker.js"></script>
    <!--验证-->
    <script src="../../javascript/ValidationCheck.js"></script>
</head>
<body>
    <input type="hidden" id="hidPageSize" value='<%= pagesize %>' />

    <div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Assets Managemant=> Assets Card</div>
    <div class="Box">
        <div class="outsideBox">
            <input name="" id="txtITassetno" type="text" value="" placeholder="input IT_AssetNO..." class="txtAll" />
        </div>
        <div class="outsideBox">
            <input name="" id="txtFinassetno" type="text" value="" placeholder="input Fin_AssetNO..." class="txtAll" />
        </div>
        <div class="outsideBox">
            <input name="" id="txtAssetKey" type="text" value="" placeholder="input AssetKey..." class="txtAll" />
        </div>
        <div class="outsideBox">
            <input name="" id="txtSN" type="text" value="" placeholder="input SerialNO..." class="txtAll" />
        </div>
        <div class="outsideBox">
            <input name="" id="ddpStatus" type="text" value="All" class="txtAll" style="cursor: not-allowed" disabled="disabled" />
            <input name="" type="button" class="listBtn" style="left:190px"/>
            <ul class="boxContent" style="display: none">
                <li><a href="javascript:void(0)">All</a></li>
                <li><a href="javascript:void(0)">Idle</a></li>
                <li><a href="javascript:void(0)">InUse</a></li>
                <li><a href="javascript:void(0)">Damage</a></li>
                <li><a href="javascript:void(0)">Scrapped</a></li>
                <li><a href="javascript:void(0)">Missing</a></li>
            </ul>
        </div>
        <div class="outsideBox outBox2" id="btnSearch" style="cursor: pointer">
            <div class="insideBox insideBox2">
                <img src="../../images/condition_icon3.png" /></div>
            <input name="" type="button" value="Search" class="search"/>
        </div>
        <div class=" " style="float: right; margin-right: 1%;">
            <div class="outsideBox outBox4">
                <div class="insideBox insideBox4">
                    <img src="../../images/condition_icon6.png"/></div>
                <input name="" type="button" value="AddAsset" onclick="javascript: assetCommand('add', '1');" class="search" style="cursor: pointer" />
            </div>
        </div>
        <div class="clear"></div>
    </div>
    <div class="clear"></div>
    <!-- 资产编号、资产名称、资产类别、品牌、序列号、财务资产编号、IT资产编号、Mac地址、入库日期
        -->
    <table class="bordered">
        <thead>
            <tr>
                <th></th>
                <th>*</th>
                <th>AssetKey</th>
                <th>AssectName</th>
                <th>Category</th>
                <th>Brand</th>
                <th>SerialNO</th>
                <th>IT_AssetNO</th>
                <th>Fin_AssetNO</th>
                <th>MacID</th>
                <th>Status</th>
                <th>InBoundDate</th>
                <th>Creator</th>
                <th>Operation</th>
            </tr>
        </thead>
        <tbody id="tabResult">
        </tbody>

    </table>
    <div class="clear"></div>
     <div class="pagination" id="pager1">
    </div>

    <script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
    <link href="../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
    <script src="../../javascript/JSPager.js"></script>
    <script src="../../javascript/DateOperate.js"></script>

    <script>
        var state = {
            'Active': '0',
            'Inactive': '1'
        };
        /* 页面加载 */
        $(document).ready(function () {
            $(".listBtn").click(function () {
                var isplay = $(".boxContent").css('display');
                if (isplay != 'none')
                    $(".boxContent").css('display', 'none');
                else
                    $(".boxContent").css('display', '');
            });
            $(".boxContent li").each(function () {
                $(this).click(function () {
                    $("#ddpStatus").val($(this).find("a").html());
                    $(".boxContent").css('display', 'none');
                })
            });
            //按钮事件
            $('#btnSearch').click(function () {
                JSPager.currentIndex = 1;
                JSPager.pageSize = $('#hidPageSize').val();
                Search();
            });
            //加载自动检索
            $('#btnSearch').click();
        });

        function Search() {
            $('#tabResult').html('<tr class="tr_loading"><td colspan="8"><img src="../../images/loading.gif" alt="" />Loading...</td></tr>');
            //var curstate = state[$.trim($("#ddpStatus").val())];
            var itsn   = $('#txtITassetno').val();
            var finsn  = $('#txtFinassetno').val();
            var akey   = $('#txtAssetKey').val();
            var sn     = $('#txtSN').val();
            var status = $('#ddpStatus').val();

            $.ajax({
                type: "post",
                url: "AssetsCard.aspx/SearchData",
                data: "{itsn:'" + itsn + "',finsn:'" + finsn + "',assetkey:'" + akey + "',sn:'" + sn + "',status:'" + status + "',CurrentPageIndex:'" + JSPager.currentIndex + "',PageSize:'" + JSPager.pageSize + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    try {
                        $('#tabResult').html('');
                        var json = data.d;
                        if (json == "") {
                            $('#tabResult').html('<tr class="tr_loading"><td colspan="8">No data</td></tr>');
                            JSPager.resetPager('pager1');
                            return;
                        }
                        json = $.parseJSON(json);
                        var html = '';
                        for (var i = 0; i < json.length; i++) {


                            html += '<tr><td>' + json[i].Indexs + '</td>';
                            html += '<td><input type="checkbox" name = "cb1" /></td>';
                            html += '<td>' + json[i].AssetKey + '</td>';
                            html += '<td>' + json[i].AssetName + '</td>';
                            html += '<td>' + json[i].Category + '</td>';
                            html += '<td>' + json[i].Brand + '</td>';
                            html += '<td>' + json[i].SerialNO + '</td>';
                            html += '<td>' + json[i].IT_AssetNO + '</td>';
                            html += '<td>' + json[i].FIN_AssetNO + '</td>';
                            html += '<td>' + json[i].MacAddress + '</td>';
                            html += '<td>' + json[i].Status + '</td>';
                            html += '<td>' + new Date(parseInt(json[i].InBoundDate)).toLocaleString() + '</td>';
                            html += '<td>' + json[i].Creator + '</td>';
                            html += '<td>';

                            html += '<button title="View" class="btn btn-info  btn-sm" type="button" onclick="javascript:assetCommand(\'view\',\'' + json[i].AssetKey + '\');"><i class="icon-info"></i></button>&nbsp;&nbsp;';
                            html += '<button title="Edit" class="btn btn-success  btn-sm" type="button"  onclick="javascript:assetCommand(\'edit\',\'' + json[i].AssetKey + '\');"><i class="icon-pencil"></i></button>&nbsp;&nbsp;';
                            html += '<button title="Scrap" class="btn btn-red  btn-sm" type="button"  onclick="javascript:assetCommand(\'scrapped\',\'1\');"><i class="icon-trash"></i></button>';
                            html += '<a href="javascript:;" onclick="toHistory(\'' + json[i].AssetKey + '\')"> Asset History</a>';

                            html += '</td>';
                            html += '</tr>';
                        }
                        $('#tabResult').html(html);
                        //pager2
                        JSPager.totalRecord = json[0].RecordCnt;
                        JSPager.doPager = Search;
                        JSPager.initPager('pager1');
                    }
                    catch (e) {
                        $('#tabResult').html('<tr class="tr_loading"><td colspan="8">' + e.message + '</td></tr>');
                        JSPager.resetPager('pager1');
                    }
                }
            });
        }
        function assetCommand(cmd, obj) {

            if (cmd == "add") {
                location.href = "AssetCardAdd.aspx";
            }

            if (cmd == "edit") {
                window.showDialog('Asset Card Detail', 'AssetCardDetail.aspx?id=' + obj, 1000, 600, function (res) {
                    if (res == window.ST_OK) {
                        $("#ddpStatus").attr("value", "All");
                        $('#btnSearch').click();

                    }
                });
            }

            if (cmd == "view") {
                window.showDialog('Asset Card Detail', 'AssetCardDetailView.aspx?id=' + obj, 1000, 600, function (res) {
                    if (res == window.ST_OK) {

                    }
                });
            }

        }

        function toHistory(obj) {

            window.showDialog('Asset History', 'AssetEditHistory.aspx?id=' + obj, 1500, 600, function (res) {
                if (res == window.ST_OK) {

                }
            });
        }

    </script>
   
</body>
</html>
