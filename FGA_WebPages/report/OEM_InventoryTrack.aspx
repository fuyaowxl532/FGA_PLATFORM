<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OEM_InventoryTrack.aspx.cs" Inherits="FGA_PLATFORM.report.OEM_InventoryTrack" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>
<title>OEM_Order Tracking System</title>
 <link rel="stylesheet" href="http://localhost:17147/code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>

     <script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
     <script src="../../mouldifi-v-2.0/js/tableExport.js"></script>
     <script src="../../mouldifi-v-2.0/js/jquery.base64.js"></script>
     <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
     <script src="echarts.js" type ="text/javascript"></script>
    
    <script>
        $(function () {
            $("#_fdtxt").datepicker();
            $("#_tdtxt").datepicker();
        });
     </script>
<style>

    body{ color: rgb(119, 119, 119); background-color:#EEEEEE;width:1200px}
    thead
    {
        background:#F6F6E6;
        color:black;
    }
    input
    {
        background-color:white;
    }
    .head
    {
        border-style:solid;
        border-width:2px;
        border-color:#4A81AA;
        background:#F6F6E6;
        width:900px;
    }
    .table_area
    {
        border-style:solid;
        border-width:2px;
        border-color:#4A81AA;
        width:1163px;
        position:absolute; 
        height:450px; 
        caption-side:bottom;
        overflow:auto;
        margin-left: 0px;
        float:left;
    }
    .visual
    {
       float:left;
       margin-left:900px;
       
    }

    #editable
    {
        width:1163px;
        background-color:#F6F6E6;
    }

    .block
    {
        height:10px;
        width:900px;
    }
    label
    {
        color:black;
        font-size:small;
    }
    #_dttxt,#_user
    {
        position:relative;
        left:19px;
    }
    #_usertxt
    {
        position:relative;
        left:53px;
    }
    .btnl
    {
        border:1px solid;
        border-color:#006DC5;
        border-radius:2px;
        position:relative;
        left:150px;
        background-color:#006DC5;
        font-size:12px;
        font-weight:600;
    }
    #_syn
    {
        position:relative;
        left:355px;
        background-color:#2212f8;
        font-weight:700;
    }
    th{border:solid #4A81AA; border-width:0px 0px 0px 1px;}

    td{border:solid #4A81AA; border-width:1px 0px 0px 1px;color:black}

        tr:nth-child(even)
    {
        background-color:white;
    }
    
</style>
</head>
<body>
	<form id="form1" runat="server">
	<!--查询-->
    <div class ="head" style="padding:5px;">
             <label id = "_org" for= "floc">OrderNO:</label> <input type="text" id = "_fltxt" size="10"/>
             <label id = "_opt" for= "tloc">PartNO:</label><input type="text" id = "_tltxt" size="10"/>
             <label id = "Label1" for= "fddate">PlanningDate:</label>
             <input type="text" id = "_fdtxt" size="10"/>
             <label id = "Label2" for= "tddate">To</label>
             <input type="text" id = "_tdtxt" size="10"/>
             </p>
             <label id = "_lbn" for= "bn">Customer:</label><input type="text" id = "_bn" size="10"/>
             <label id = "Label4" for= "bn">Factory:</label><input type="text" id = "Text1" size="10"/>
             <label id = "Label5" for= "sts">OrderStatus:</label><select id ="Select1">
                        <option value="All">All</option>
						<option>Release</option>
						<option selected>In process</option>
						<option>Closed</option>
                        </select>
             <label id = "Label3" for= "sts">DeliveryStatus:</label><select id ="sid">
                        <option value="All" selected>All</option>
						<option selected>Normal</option>
						<option>Delayed</option>
                        </select>
           
             <input type="button" class="btnl" name="search" value="Search" onclick="SearchData()" />
             <input type="button" class="btnl" name="export" value="Export" onclick="$('#editable').tableExport({ type: 'excel',tableName:'OEM', escape: 'false' })" />
    </div>
    <!--****-->
    <div class ="clearfix"></div>

    <!--中间内容-->
    <div id="center">
    <!--表内容-->
    <div class ="table_area">
	    <table id ="editable" class="table table-striped">
		    <thead>
			    <tr>
                    <th>*</th>
                    <th>No</th>
				    <th>OrderNo</th>
				    <th>PartNo</th>
                    <th>Customer</th>
                    <th>Program</th>
				    <th>AddressCode</th>
				    <th>BoxType</th>
				    <th>StandardQTY</th>
				    <th>OrderQty</th>
                    <th>BoxNum</th>
                    <th>InboundQty</th>
                    <th>UnInBoundQty</th>
                    <th>UnInBoundBox</th>
				    <th>PlanningDate</th>
				    <th>ShipmentDate</th>
                    <th>OrderStatus</th>
                    <th>DeliveryStatus</th>
                    <th>LastInBoundTime</th>
				    <th>LastInBoundUser</th>
                    <th>LastLocation</th>
				    <th>Organization</th>
				    <th>Notes</th>
                    <th>Creater</th>
				    <th>CreateDate</th>
                    <th>OrderNoID</th>
			    </tr>
		    </thead>
		    <tbody id ="tby">
					
		    </tbody>
	    </table>
    </div>

    <!--可视化   <div class ="visual" style=" height:470px;width:235px;border:2px solid #4A81AA; margin-left:930px ">
        <div id="main1" style="width: 225px;height:225px; "></div>
        <div id="main2" style="width: 225px;height:225px; "></div>
    </div>-->
  
    </div> 
    <div class ="clearfix"></div>
   
    <div>
        <div  class = "it_div" style="float:left; overflow:scroll; height:150px;width:690px; margin-top:460px;border:2px solid #4A81AA; ">
            <table id ="inbounddetail">
		    <thead>
			    <tr>
                    <th>No</th>
				    <th>OrderNo</th>
                    <th>SerialNO</th>
				    <th>PartNo</th>
                    <th>Qty</th>
                    <th>InBoundTime</th>
				    <th>InBoundUser</th>
                    <th>Location   </th>
				    <th>TeamLeader</th>
				    <th>Supervisor</th>
			    </tr>
		    </thead>
		    <tbody>
					
		    </tbody>
	    </table>
        </div>
        
        <div  style="float:left; height:150px;width:460px; margin-top:460px; border:2px solid #4A81AA; margin-left:10px " >b</div>
    </div>

    <div class ="clearfix"></div>
    
        <div  id = "irInfo" style="height:250px;width:1163px;border:2px solid #4A81AA; margin-top:620px;"  >
            
        </div>
   
    
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    //var myChart1 = echarts.init(document.getElementById('main1'));
    //var myChart2 = echarts.init(document.getElementById('main2'));
    var myChart3 = echarts.init(document.getElementById('irInfo'));

    // 指定图表的配置项和数据
    var option1 = {
        tooltip: {
            formatter: "{a} <br/>{b} : {c}%"
        },
        toolbox: {
            feature: {
                restore: {},
                saveAsImage: {}
            }
        },
        series: [
            {
                name: 'Finished Rate',
                type: 'gauge',
                detail: { formatter: '{value}%' },
                data: [{ value: 33.3, name: 'Finished Rate' }]
            }
        ]
    };

    var option2 = {
        tooltip: {
            formatter: "{a} <br/>{b} : {c}%"
        },
        toolbox: {
            feature: {
                restore: {},
                saveAsImage: {}
            }
        },
        series: [
            {
                name: 'Total Rate',
                type: 'gauge',
                detail: { formatter: '{value}%' },
                data: [{ value: 5.82, name: 'Total Rate' }]
            }
        ]
    };
    option3 = {
        title: {
            text: '04-2017 OEM InBound Information'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: { // 坐标轴指示器，坐标轴触发有效
                type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        legend: {
            data: ['OrderQty', 'InboundQty', 'Return'],
            align: 'right',
            right: 10
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: [{
            type: 'category',
            data: ['02-04-2017','03-04-2017', '04-04-2017', '05-04-2017', '06-04-2017', '07-04-2017','08-04-2017']
        }],
        yAxis: [{
            type: 'value',
            name: 'Quantity(PCS)',
            axisLabel: {
                formatter: '{value}'
            }
        }],
        series: [{
            name: 'OrderQty',
            type: 'bar',
            data: [780, 100, 200, 500, 300,210,420]
        }, {
            name: 'InboundQty',
            type: 'bar',
            data: [200, 50, 120, 100, 300,260,300]
        }, {
            name: 'Return',
            type: 'bar',
            data: [0, 10, 30, 60, 50,60,80]
        }]
    };
    // 使用刚指定的配置项和数据显示图表。
    //myChart1.setOption(option1);
    //myChart2.setOption(option2);
    myChart3.setOption(option3);

    //界面查询数据
    function SearchData() {
        $("#editable tr:not(:first)").remove();
        var _orderno   = $("#_fltxt").val();       //订单号
        var _partno    = $("#_tltxt").val();       //本厂编号
        var _factory   = $("#Text1").val();        //工厂
        var _ostatus   = $("#Select1").val();      //订单状态
        var _dstatus   = $("#sid").val();          //交付状态
        var _cst       = $("#_bn").val();          //客户
        var _fdate     = $("#_fdtxt").val();       //交付日期F
        var _tdate     = $("#_tdtxt").val();       //交付日期T

        if (_fdate != "" && _tdate == "") {
            alert("Please input date!");
            return;
        }
        if (_fdate == "" && _tdate != "") {
            alert("Please input date!");
            return;
        }

        $.ajax({
            type: "Post",
            url: "OEM_InventoryTrack.aspx/SearchData",
            data: "{orderno:'" + _orderno + "',partno:'" + _partno + "',factory:'" + _factory + "',cst:'" + _cst + "',ordersts:'" + _ostatus + "',deliverysts:'" + _dstatus + "',fdate:'" + _fdate + "',tdate:'" + _tdate + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {
                        slct = slct + '<tr><td><input type="checkbox" name = "cb1" /</td> ' +
                                       '<td> ' + (i + 1) + '</td> ' +
                                       '<td> ' + json[i].OrderNO + '</td> ' +
                                       '<td> ' + json[i].PartNO + '</td> ' +
                                       '<td> ' + json[i].Customer + '</td> ' +
                                       '<td> ' + json[i].Program + '</td> ' +
                                       '<td> ' + json[i].AddressCode + '</td> ' +
                                       '<td>' + json[i].BoxType + '</td> ' +
                                       '<td> ' + json[i].StandardQuantity + '</td> ' +
                                       '<td> ' + json[i].OrderQuantity + '</td> ' +
                                       '<td> ' + json[i].BoxNum + '</td> ' +
                                       '<td><a href="#inbounddetail" onclick = "querySerialno(this)">' + json[i].InBoundQty + '</a></td> ' +
                                       '<td> ' + json[i].UnInBoundQty + '</td> ' +
                                       '<td> ' + json[i].UnInBoundBox + '</td> ' +
                                       '<td>' + new Date(parseInt(json[i].PlanningDate)).toLocaleString() + '</td> ' +
                                       '<td>' + new Date(parseInt(json[i].ShipmentDate)).toLocaleString() + '</td> ' +
                                       '<td> ' + json[i].OrderStatus + '</td> ' +
                                       '<td> ' + json[i].DeliveryStatus + '</td> ' +
                                       '<td> ' + json[i].LastInBoundUser + '</td> ' +
                                       '<td> ' + new Date(parseInt(json[i].LastInBoundTime)).toLocaleString() + '</td> ' +
                                       '<td> ' + json[i].Lastlocation + '</td> ' +
                                       '<td> ' + json[i].Organization + '</td> ' +
                                       '<td> ' + json[i].Notes + '</td> ' +
                                       '<td> ' + json[i].Creater + '</td> ' +
                                       '<td>' + new Date(parseInt(json[i].Createdate)).toLocaleString() + '</td> ' + 
                                       '<td> ' + json[i].OrderNoID + '</td> ' +
                            '</tr>';
                    }
                    $("#tby").html(slct);
                }
            }
        });
    }

    function querySerialno(obj) {

        $("#inbounddetail tr:not(:first)").remove();


        $.ajax({
            type: "Post",
            url: "OEM_InventoryTrack.aspx/querySerialno",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    for (var i = 0; i < json.length; i++) {

                        var table = document.getElementById("inbounddetail");
                        var nextIndex = table.rows.length;
                        var nextRow = table.insertRow(nextIndex);
                        nextRow.insertCell(0).innerHTML = nextIndex;
                        nextRow.insertCell(1).innerHTML = json[i].OrderNO;
                        nextRow.insertCell(2).innerHTML = json[i].SerialNO;
                        nextRow.insertCell(3).innerHTML = json[i].PartNO;
                        nextRow.insertCell(4).innerHTML = json[i].InBoundQty;
                        nextRow.insertCell(5).innerHTML = '<input type="text" value = "' + new Date(parseInt(json[i].LastInBoundTime)).toLocaleString() + '"style="border:none;width:100%;height:100%" size = "5"/>';
                        nextRow.insertCell(6).innerHTML = json[i].LastInBoundUser;
                        nextRow.insertCell(7).innerHTML = json[i].Location;
                        nextRow.insertCell(8).innerHTML = "";
                        nextRow.insertCell(9).innerHTML = "";
                       }
                }
            }
        });
    }

</script>
    </form>
</body>
</html>
