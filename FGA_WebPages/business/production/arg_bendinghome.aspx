<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="arg_bendinghome.aspx.cs" Inherits="FGA_PLATFORM.business.production.arg_bendinghome" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Arg Bending Home</title>
    <script src="../../javascript/jquery-1.11.1.min.js"></script>
    <link href="../../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
    <script src="../../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
    <script src="../../javascript/common.js" type="text/javascript"></script>

    <link type="text/css" rel="stylesheet" href="../../AlertMsg/css/showBo.css" />
    <script type="text/javascript" src="../../AlertMsg/js/showBo.js"></script>

    <style type="text/css">
        body
        {
            margin: 0;
            padding: 0;
            background-color: #101010; /*页面背景*/
        }
        /*头部div*/
        .top
        {
            height: 30px;
            width: 85%;
            text-align: left;
            color: #f00;
            margin: 40px auto 0 auto;
            min-width: 480px;
        }

        #rightdiv
        {
            float: right;
            padding-top: 18px;
        }

        #cnt
        {
            float: left;
            margin-left: 20px;
            text-align: center;
            width: 1100px;
        }

            #cnt ul li
            {
                float: left;
                height: 60px;
                list-style-type: none;
                margin-bottom: 32px;
                margin-right: 30px;
                width: 150px;
                line-height: 80px;
            }

            #cnt ul
            {
                padding-left: 0;
            }

        .note
        {
            width: 150px;
            height: 80px;
            border: 1px solid #44679F;
            border-radius: 6px;
            background-color: #ede9e9;
            border-style: outset;
        }

        .ntdisable
        {
            filter: alpha(opacity=50);
            -moz-opacity: 0.5;
            opacity: 0.5;
        }

        .nthightlight
        {
            border-color: red;
        }

        .img
        {
            float: left;
        }
            /*鼠标悬浮时的效果*/
            .img:hover
            {
                cursor: pointer;
                color: #81aeed;
            }

        .leftpart
        {
            width: 110px;
            float: left;
            border-right: 1px solid #4a77ad;
            background-color: #FEFCFC;
            font-weight: bold;
        }

        .lefttop
        {
            height: 40px;
            line-height: 40px;
            border-bottom: 1px solid #4a77ad;
            color: #4a77ad;
        }

            .lefttop input
            {
                width: 102px;
                height: 32px;
                border: none;
            }

        .leftbottom
        {
            height: 39px;
            line-height: 39px;
            color: #44679F;
        }
            /*鼠标悬浮时的效果*/
            .leftbottom:hover
            {
                cursor: pointer;
                color: #81aeed;
            }

        .rightpart
        {
            width: 38px;
            float: left;
            font-weight: bold;
        }

        .righttop
        {
            width: 38px;
            height: 50px;
            line-height: 50px;
            border-bottom: 1px solid #4a77ad;
        }

        .rightbottom
        {
            width: 38px;
            height: 30px;
            line-height: 30px;
            font-size: 12px;
            font-weight: 800;
        }

        .scap
        {
            position: relative;
            top: 37%;
            line-height: 6px;
            font-size: 12px;
            color: #f00;
            font-weight: 700;
            transform: rotate(90deg);
            -ms-transform: rotate(90deg); /* Internet Explorer 9*/
            -moz-transform: rotate(90deg); /* Firefox */
            -webkit-transform: rotate(90deg); /* Safari 和 Chrome */
            -o-transform: rotate(90deg); /* Opera */
            filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=1);
        }
            /*鼠标悬浮时的效果*/
            .scap:hover
            {
                cursor: pointer;
                color: #81aeed;
            }

        .lockscreen
        {
            z-index: 1000;
            background-color: #101010;
            width: 100%;
            height: 100%;
            left: 0;
            top: 0;
            position: fixed;
            padding-left: 40%;
            padding-top: 20%;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div>
            <div class="top">
                <div style="width: 32%; float: left; height: 16px; font-weight: 900">
                    WorkCenter:&nbsp;
                <select id="selectwkct" name="sltworkcenter">
                </select>
                </div>
                &nbsp;&nbsp;&nbsp;&nbsp;
            <div style="width: 30%; float: left; font-weight: 900">
                Shift:&nbsp;
                <select id="select2" name="sltshift">
                    <option value="1st">1st</option>
                    <option value="2nd">2nd</option>
                    <option value="3th">3th</option>
                </select>
            </div>
            </div>

            <div id="cnt">

                <ul id="cntul">
                    <%--<li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="codeitemClick('1341SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">1</div>openjbslct()
                        </div>Showbo.Msg.alert('您好，请先注册或登录!');
                    </div>
                </li>--%>
                </ul>

            </div>

            <div id="rightdiv">
                <textarea style="background-color: #101010; color: yellow;" id="txtone" rows="16" cols="20" readonly="true">当前炉子信息</textarea>
                <br />
                <textarea style="background-color: #101010; color: yellow;" id="txttwo" rows="11" cols="20" readonly="true">当前轮数品种信息</textarea>
                <br />
                <div style="width: 200px; height: 50px;">

                <div class="img" onclick="openjbslct()">
                    <img src="/images/1.png" width="35" title="派工" height="35">
                </div>
                <div class="img" onclick="UpdateCurcarAndMoveToNext('emptycar','','')">
                    <img src="/images/2.png" width="35" title="空车" height="35">
                </div>
                <div class="img" onclick="UpdateCurcarAndMoveToNext('redo','','')">
                    <img src="/images/3.png" width="35" title="重烘" height="35">
                </div>
                <div class="img">
                    <img src="/images/4.png" width="35" height="35">
                </div>
                <div class="img" onclick="lockscreen()">
                    <img src="/images/lock.png" width="35" title="锁屏" height="35">
                </div>
            </div>
            </div>
            <div style="clear: both"></div>
            

        </div>
        <div class="lockscreen" style="display: none">
           
                <div>
                    <input type="password" placeholder="Password" value="" />
                </div>
                <div style="height: 20px"></div>
                <div>
                    <input class="" onclick="unlockscreen()" value="Unlock" />
                </div>
            

        </div>
        <script>

            //document.write("script language='javascript' src='../../AlertMsg/js/showBo.js'></script");
            $(function () {
                //$('.note').addClass('ntdisable').first().addClass('nthightlight').removeClass('ntdisable');
                //$('.note').each(function () {
                //    $(this).click(function () {
                //        if ($(this).attr('class').indexOf('disable') == -1) {
                //            $('.note').addClass('ntdisable');
                //            $(this).removeClass('ntdisable').addClass('nthightlight');
                //        }
                //    })
                //});
                InitWkct();
                InitCarPlan();
            })
            //根据用户初始化workcenter
            function InitWkct() {
                var slct = "";
                $.ajax({
                    type: "Post",
                    url: "arg_bendinghome.aspx/InitWkct",
                    data: "",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {

                            var json = $.parseJSON(data.d);
                            for (var i = 0; i < json.length; i++) {
                                slct += '<option value=' + json[i].WORKCENTER + '>' + json[i].WORKCENTER + '</option>';
                            }
                            $("#selectwkct").html(slct);
                            $("#selectwkct").change(function () {
                                InitCarPlan();
                            });
                        }
                    }
                });


            }
            //初始化30小车的计划派单信息
            function InitCarPlan() {
                var workcenter = $("#selectwkct").val();
                $("#cntul").html('<img src="../../images/loading.gif" alt="" />');
                $.ajax({
                    type: "Post",
                    url: "arg_bendinghome.aspx/InitBendingData",
                    data: "{workcenter:'" + workcenter + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d != "") {
                            var json = $.parseJSON(data.d);
                            LoadpageByCarPlanData(json);
                        }
                    }
                });
            }
            //生成30小车页面信息
            function LoadpageByCarPlanData(json) {
                var html = "";
                var curcarno = json.curcarno;
                var planlist = json.planlist;
                for (var i = 1; i <= planlist.length; i++) {
                    var item = planlist[i - 1];
                    html += '<li>';
                    if (item.carno == curcarno)
                        html += '<div class="note nthightlight">';
                    else
                        html += '<div class="note ntdisable">';
                    html += '<div class="leftpart" style="">';
                    html += '<div class="lefttop" style="">' + item.jobno + '</div>';
                    html += '<div class="leftbottom" style="" onclick="codeitemClick(\'' + item.codeitem + '\',\'' + i + '\',this);">' + item.codeitem + '</div>';
                    html += '</div>';
                    html += '<div class="rightpart" style="">';
                    html += '<div class="righttop" style="">';
                    html += '<div class="scap" style="" onclick="javascript: reasonCommand(\'' + item.codeitem + '\',\'' + i + '\',this);">Scap</div>';
                    html += '</div>';
                    html += ' <div class="rightbottom" style="">' + i + '</div>';
                    html += '</div>';
                    html += ' </div>';
                    html += '</li>';
                }
                $("#cntul").html(html);
            }
            //click scap select reason 记录废品 向录机表sequencerecord记录一片废品信息
            function reasonCommand(pno, carno, obj) {
                if ($(obj).parent().parent().parent().attr('class').indexOf('disable') != -1)
                    return;
                if (pno == "") {
                    Showbo.Msg.alert('no jobno!');
                    return;
                }
                var workcenter = $("#selectwkct").val();
                window.parent.showDialog('ReasonCode', 'reasoncode.aspx?pno=' + pno + "&workcenter=" + workcenter, 450, 570, function (res) {
                    if (res == window.ST_OK) {
                        UpdateCurcarAndMoveToNext('reason', carno, obj);

                    }
                });
            }
            //点击本厂编号向录机表sequencerecord记录一片成品信息
            function codeitemClick(pno, carno, obj) {
                if ($(obj).parent().parent().attr('class').indexOf('disable') != -1)
                    return;
                if (pno == "") {
                    //alert('no jobno!');
                    Showbo.Msg.alert('no jobno!');
                    return;
                }
                //confirm("Confirm?")
                if (confirm("Confirm?")) {
                    var workcenter = $("#selectwkct").val();
                    $.ajax({
                        type: "Post",
                        url: "arg_bendinghome.aspx/AddToSqrd",
                        data: "{pno:'" + pno + "',workcenter:'" + workcenter + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {
                            if (data.d == "1") {
                                UpdateCurcarAndMoveToNext('itemcode', carno, obj);

                            }
                        }
                    });
                }
            }
            //更新当前小车号并且移动到下一个小车高亮
            function UpdateCurcarAndMoveToNext(type, carno, obj) {

                var curcarno = carno = $(".nthightlight .rightbottom").html();
                curcarno = parseInt(curcarno);
                if (curcarno >= 30) {
                    //alert('Complete all');
                    $('.note').removeClass('nthightlight').addClass('ntdisable');
                    $('.note').first().addClass('nthightlight').removeClass('ntdisable');
                    updatecar(carno, $("#selectwkct").val());
                    return;
                }
                if (type == 'reason') {
                    $('.note').removeClass('nthightlight').addClass('ntdisable');
                    $(obj).parent().parent().parent().parent().next().find('.note').removeClass('ntdisable').addClass('nthightlight');
                }
                else if (type == 'itemcode') {
                    $('.note').removeClass('nthightlight').addClass('ntdisable');
                    $(obj).parent().parent().parent().next().find('.note').removeClass('ntdisable').addClass('nthightlight');
                }
                else if (type == 'emptycar') {
                    obj = $(".nthightlight");
                    var jobno = $(".nthightlight .lefttop").html();
                    if ($.trim(jobno) != "") {
                        Showbo.Msg.alert('It has not jobno cannot do this!');
                        //alert('It has jobno cannot do this!');
                        return;
                    }
                    carno = $(".nthightlight .rightbottom").html();
                    $('.note').removeClass('nthightlight').addClass('ntdisable');
                    $(obj).parent().next().find('.note').removeClass('ntdisable').addClass('nthightlight');
                }
                else if (type == 'redo') {
                    obj = $(".nthightlight");
                    var jobno = $(".nthightlight .lefttop").html();
                    if ($.trim(jobno) == "") {
                        Showbo.Msg.alert('It has not jobno cannot do this!');
                        //alert('It has not jobno cannot do this!');
                        return;
                    }
                    carno = $(".nthightlight .rightbottom").html();
                    $('.note').removeClass('nthightlight').addClass('ntdisable');
                    $(obj).parent().next().find('.note').removeClass('ntdisable').addClass('nthightlight');
                }
                carno = parseInt(carno) + 1;
                var workcenter = $("#selectwkct").val();
                updatecar(carno, workcenter);
                
            }
            //gengxin
            function updatecar(carno, workcenter) {
                $.ajax({
                    type: "Post",
                    url: "arg_bendinghome.aspx/UpdateCurcar",
                    data: "{carno:'" + carno + "',workcenter:'" + workcenter + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d == "1") {
                        }
                    }
                });
             }
            //派工
            function openjbslct() {
                var workcenter = $("#selectwkct").val();
                window.showDialog('jobnoselect', 'jobnoselect.aspx?workcenter=' + workcenter, 550, 570, function (res) {
                    if (res == 'close') {
                        //派工完成后初始化页面中小车信息
                        InitCarPlan();
                        //alert('success');
                        //$('.note').addClass('ntdisable');
                        //$(obj).parent().parent().parent().parent().next().find('.note').removeClass('ntdisable').addClass('nthightlight');
                    }
                });

            }
            //lockscreen
            function lockscreen() {
                $(".lockscreen").css('display', '');
            }
            function unlockscreen() {
                $(".lockscreen").css('display', 'none');
            }
        </script>
    </form>
</body>
</html>

