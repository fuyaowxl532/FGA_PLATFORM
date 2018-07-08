<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="echarts001.aspx.cs" Inherits="FGA_PLATFORM.report.echarts001" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>echarts</title>
    <script src="echarts.js" type ="text/javascript"></script>
</head>
<body>
    <div id="main" style="width: 600px;height:400px;float:left">demo</div>

     <script type="text/javascript">
         // 基于准备好的dom，初始化echarts实例
         var myChart = echarts.init(document.getElementById('main'));

         // 指定图表的配置项和数据
         var option = {
             title: {
                 text: 'FGA各工厂产量一览'
             },
             tooltip: {},
             legend: {
                 data:['产量']
             },
             xAxis: {
                 data: ["F1","F2","F3","F4"]
             },
             yAxis: {},
             series: [{
                 name: '产量',
                 type: 'bar',
                 data: [5, 20, 36, 10]
             }]
         };
         // 使用刚指定的配置项和数据显示图表。
         myChart.setOption(option);
    </script>

     <div id="Div1" style="width: 600px;height:400px;float:left">demo</div>

     <script type="text/javascript">
         // 基于准备好的dom，初始化echarts实例
         var myChart = echarts.init(document.getElementById('Div1'));

         // 指定图表的配置项和数据
         var option = {
             title: {
                 text: 'FGA各工厂产量一览'
             },
             tooltip: {},
             legend: {
                 data: ['产量']
             },
             xAxis: {
                 data: ["F1", "F2", "F3", "F4"]
             },
             yAxis: {},
             series: [{
                 name: '产量',
                 type: 'bar',
                 data: [5, 20, 36, 10]
             }]
         };
         // 使用刚指定的配置项和数据显示图表。
         myChart.setOption(option);
    </script>
</body>
</html>
