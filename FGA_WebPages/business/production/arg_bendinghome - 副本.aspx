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
    <style type="text/css">
        body
        {
            margin: 0;
            padding: 0;
            background-color: #101010 /*页面背景*/
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
        #rightdiv {
            float:left;
            padding-top:18px;
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
        .ntdisable{
            filter:alpha(opacity=50); 
            -moz-opacity:0.5; 
            opacity:0.5;        
        }
        .nthightlight{
            border-color:red;
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
                height:32px;
                border:none;
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
    </style>
</head>

<body>
    <form id="form1" runat="server">
    <div>
        <div class="top">
            <div style="width: 32%; float: left; height: 16px;font-weight: 900">WorkCenter:&nbsp;
                <select id="selectwkct" name="sltworkcenter">
                    <!--<option value="F420-1">F420-1</option>
                    <option value="F420-2">F420-2</option>
                    <option value="F420-3">F420-3</option>
                    <option value="F420-4">F420-4</option>
                    <option value="F420-5">F420-5</option>
                    <option value="F420-6">F420-6</option>
                    <option value="F420-7">F420-7</option>
                    <option value="F420-8">F420-8</option>
                    <option value="F420-9">F420-9</option>
                    <option value="F420-10">F420-10</option>-->
                </select>
            </div>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <div style="width: 30%; float: left;font-weight: 900">Shift:&nbsp;
                <select id="select2" name="sltshift">
                    <option value="1st">1st</option>
                    <option value="2nd">2nd</option>
                    <option value="3th">3th</option>
                </select>
            </div>
        </div>

        <div id="cnt">

            <ul>
                <li>
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
                            <div class="rightbottom" style="">1</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                           <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1342SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1342SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">2</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="codeitemClick('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">3</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">4</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">5</div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">6</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">7</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">8</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">9</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">10</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">11</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">12</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">13</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">14</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">15</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">16</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">17</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">18</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">19</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">20</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">21</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">22</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">23</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">24</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">25</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">26</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">27</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">28</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">29</div>
                        </div>
                    </div>
                </li>

                <li>
                    <div class="note">
                        <div class="leftpart" style="">
                            <div class="lefttop" style="">Job No#</div>
                            <div class="leftbottom" style="" onclick="adddata('1342SGTY',this);">1341SGTY</div>
                            <!--添加onclick事件即实现按钮功能-->
                        </div>
                        <div class="rightpart" style="">
                            <div class="righttop" style="">
                                <div class="scap" style="" onclick="javascript: reasonCommand('1341SGTY',this);">Scap</div>
                                <!--添加onclick事件即实现按钮功能-->
                            </div>
                            <div class="rightbottom" style="">30</div>
                        </div>
                    </div>
                </li>

            </ul>

        </div>

        <div id="rightdiv">
            <textarea style="background-color:#101010;color:yellow; "  id="txtone" rows="16" cols="20" readonly="true">当前炉子信息</textarea> <br />
            <textarea style="background-color:#101010;color:yellow; "  id="txttwo" rows="11" cols="20" readonly="true">当前轮数品种信息</textarea> 
         
             </div>
        <div style="clear:both"></div>
        <div style="width:200px;height:50px;" >

                  <div class="img" onclick="openjbslct()">
                      <img src="/images/1.png" width="35" height="35">
                  </div>
                  <div class="img" onclick="moveobject()">
                      <img src="/images/2.png" width="35" height="35">
                  </div>
                  <div class="img" >
                      <img src="/images/3.png" width="35" height="35">
                  </div>
                  <div class="img">
                      <img src="/images/4.png" width="35" height="35">
                  </div>
                  <div class="img">
                      <img src="/images/lock.png" width="35" height="35">
                  </div>
        </div>

    </div>
    <script>
      

        $(function () {
            $('.note').addClass('ntdisable').first().addClass('nthightlight').removeClass('ntdisable');
            $('.note').each(function () {
                $(this).click(function () {
                    if ($(this).attr('class').indexOf('disable') == -1) {
                        $('.note').addClass('ntdisable');
                        $(this).removeClass('ntdisable').addClass('nthightlight');
                    }
                })
            });
            InitWkct();
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
                async: true,
                success: function (data) {
                    if (data.d != "") {
                        
                        var json = $.parseJSON(data.d);
                        for (var i = 0; i < json.length; i++) {
                            slct += '<option value=' + json[i].WORKCENTER + '>' + json[i].WORKCENTER + '</option>';
                        }
                        $("#selectwkct").html(slct);
                    }
                }
            });
            
            
        }
        //click scap select reason 记录废品 向录机表sequencerecord记录一片废品信息
        function reasonCommand(pno, obj) {
            if ($(obj).parent().parent().parent().attr('class').indexOf('disable') != -1)
                return;
            window.parent.showDialog('ReasonCode', 'reasoncode.aspx?pno=' + pno, 450, 570, function (res) {
                if (res == window.ST_OK) {
                    //alert('success');
                    $('.note').addClass('ntdisable');
                    $(obj).parent().parent().parent().parent().next().find('.note').removeClass('ntdisable').addClass('nthightlight');
                }
            });
        }
        //点击本厂编号向录机表sequencerecord记录一片成品信息
        function codeitemClick(pno, obj) {
            if ($(obj).parent().parent().attr('class').indexOf('disable') != -1)
                return;
            if (confirm("Confirm?")) {
                $.ajax({
                    type: "Post",
                    url: "arg_bendinghome.aspx/AddToSqrd",
                    data: "{pno:'" + pno + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d == "1") {
                            alert('success');
                            $('.note').addClass('ntdisable');
                            $(obj).parent().parent().parent().next().find('.note').removeClass('ntdisable').addClass('nthightlight');
                        }
                    }
                });
            }
        }

        function openjbslct() {
            window.showDialog('jobnoselect', 'jobnoselect.aspx', 550, 570, function (res) {
                //if (res == window.ST_OK) {
                //    alert('success');
                //    $('.note').addClass('ntdisable');
                //    $(obj).parent().parent().parent().parent().next().find('.note').removeClass('ntdisable').addClass('nthightlight');
                //}
            });

        }
        function moveobject() {
            //first get the current CarNO
            $.ajax({
                type: "Post",
                url: "arg_bendinghome.aspx/GetCurrentCarNO",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    if (data.d != "") {
                        var json = $.parseJSON(data.d);
                    }
                }
            });
        }
    </script>
    </form>
</body>
</html>

