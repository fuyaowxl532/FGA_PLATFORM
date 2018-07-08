<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jobnoselect.aspx.cs" Inherits="FGA_PLATFORM.business.production.jobnoselect" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<style type="text/css">
* { margin:0; padding:0; }
div.centent {
   float:left;
   text-align: center;
   margin: 10px;
}
span { 
	display:block; 
	margin:2px 2px;
	padding:4px 10px; 
	background:#898989;
	cursor:pointer;
	font-size:12px;
	color:white;
}
#search-box {
  font-size: 13px;
  width: 120px;
  background: #E6E6E6 url('../images/search.jpg') no-repeat 3px 3px;
  padding: 3px 3px 3px 22px;
}

</style>
<!--   引入jQuery -->
<script src="../../javascript/jquery-1.11.1.min.js"></script>
<link href="../../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
<script src="../../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
<script src="../../javascript/common.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        //移到右边
        $('#add').click(function () {
            //获取选中的选项，删除并追加给对方
            $('#select1 option:selected').appendTo('#select2');
        });
        //移到左边
        $('#remove').click(function () {
            $('#select2 option:selected').appendTo('#select1');
        });
        //全部移到右边
        $('#add_all').click(function () {
            //获取全部的选项,删除并追加给对方
            $('#select1 option').appendTo('#select2');
        });
        //全部移到左边
        $('#remove_all').click(function () {
            $('#select2 option').appendTo('#select1');
        });
        //双击选项
        $('#select1').dblclick(function () { //绑定双击事件
            //获取全部的选项,删除并追加给对方
            $("option:selected", this).appendTo('#select2'); //追加给对方
        });
        //双击选项
        $('#select2').dblclick(function () {
            $("option:selected", this).appendTo('#select1');
        });
        //文本框双击
        $('#search-box').dblclick(function () {
            window.showDialog('jobnolist', 'jobnolist.aspx', 550, 530, function (res) {
                $('#search-box').val(res);
            });
        });
    });
    function savedata() {//已经分配 过的小车或者是已经做过的还能重新分？
        var cars = "";
        var jobnoandcodeitem = $("#search-box").val();
        $("#select2 option").each(function () {
            if (cars == "")
                cars = $(this).val();
            else
                cars += "," + $(this).val();
        });
        if (cars == "") {
            alert('please select carno!');
            return;
        }
        if (jobnoandcodeitem == "") {
            alert('please select jobno!');
            return;
        }
        var workcenter = GetQueryString('workcenter');
        $.ajax({
            type: "Post",
            url: "jobnoselect.aspx/SaveData",
            data: "{cars:'" + cars + "',jobnoandcodeitem:'" + jobnoandcodeitem + "',workcenter:'" + workcenter + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d == "success") {
                    $("#search-box").val("");
                    $('#remove_all').click();
                }
                alert(data.d);
            }
        });
    }
</script>

</head>
<body>
    
    <div class="top">
        <input id="search-box" type="text" placeholder="双击选择" name="search-box" style="width:260px" />
    </div>
    
	<div class="centent">
		<select multiple="multiple" id="select1" style="width:100px;height:240px;">
			<option value="1">NO1</option>
			<option value="2">NO2</option>
			<option value="3">NO3</option>
			<option value="4">NO4</option>
			<option value="5">NO5</option>
			<option value="6">NO6</option>
			<option value="7">NO7</option>
            <option value="8">NO8</option>
			<option value="9">NO9</option>
			<option value="10">NO10</option>
			<option value="11">NO11</option>
			<option value="12">NO12</option>
			<option value="13">NO13</option>
			<option value="14">NO14</option>
            <option value="15">NO15</option>
			<option value="16">NO16</option>
			<option value="17">NO17</option>
			<option value="18">NO18</option>
			<option value="19">NO19</option>
			<option value="20">NO20</option>
			<option value="21">NO21</option>
			<option value="22">NO22</option>
			<option value="23">NO23</option>
			<option value="24">NO24</option>
            <option value="25">NO25</option>
			<option value="26">NO26</option>
			<option value="27">NO27</option>
			<option value="28">NO28</option>
			<option value="29">NO29</option>
			<option value="30">NO30</option>
		</select>
		<div>
			<span id="add" >add &gt;&gt;</span>
			<span id="add_all" >add_all &gt;&gt;</span>
		</div>
	</div>

	<div class="centent">
		<div>
		<select multiple="multiple" id="select2" style="width: 100px;height:240px;" name="D1">
		</select><span id="remove">&lt;&lt; remove</span>
			<span id="remove_all">&lt;&lt; remove_all</span>
		</div>
	</div>
    <div style="clear:both"></div>
    <div class="bottom">
        <input type="button" class="btn btn-primary"   value=" save " onclick="savedata()" />
        <input type="button" class="btn btn-red"   value=" close " onclick="window.parent.ymPrompt.doHandler('close', true);" />
    </div>
</body>
</html>