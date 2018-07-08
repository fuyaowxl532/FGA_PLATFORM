﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExcelTest.aspx.cs" Inherits="FGA_PLATFORM.business.Test.ExcelTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
   <button onclick="downloadExl(jsono)">导出</button>
   <input type="file" onchange="importf(this)" />
   <div id="demo"></div>

   <div class="content">
      <table id ="editable">
                <thead style="">
                    <tr>
                        <th>JobNO</th>
                        <th>JobKey</th>
                        <th>PartNO</th>
                        <th>PartName</th>
                        <th>PartGroup</th>
                        <th>DueDate</th>
                        <th>JobStatus</th>
                        <th>Note</th>
                        <th>Creater</th>
                        <th>CreateDate</th>
                    </tr>
                </thead>
                <tbody>
                 
                </tbody>
        </table>
          <div class="clear"></div>
    </div>
    

    <script src="http://oss.sheetjs.com/js-xlsx/xlsx.full.min.js"></script>
    <!--调用FileSaver saveAs函数可以实现文件下载-->
    <!--<script src="http://sheetjs.com/demos/Blob.js"></script>
    <script src="http://sheetjs.com/demos/FileSaver.js"></script>-->
    <script>

        //导入
        var rABS = false; //是否将文件读取为二进制字符串
        function importf(obj) {//导入
            if (!obj.files) { return; }
            var f = obj.files[0];
            {
                var reader = new FileReader();
                var name = f.name;
                reader.onload = function (e) {
                    var data = e.target.result;
                    var wb;
                    if (rABS) {
                        wb = XLSX.read(data, { type: 'binary' });
                    } else {
                        var arr = fixdata(data);
                        wb = XLSX.read(btoa(arr), { type: 'base64' });
                    }
                    document.getElementById("demo").innerHTML = JSON.stringify(XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]));
                    //将json值显示在界面

                };
                if (rABS) reader.readAsBinaryString(f);
                else reader.readAsArrayBuffer(f);
            }
        }
        function fixdata(data) {
            var o = "", l = 0, w = 10240;
            for (; l < data.byteLength / w; ++l) o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w, l * w + w)));
            o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w)));
            return o;
        }


        //导出
        //如果使用 FileSaver.js 就不要同时使用以下函数
        function saveAs(obj, fileName) {//当然可以自定义简单的下载文件实现方式 
            var tmpa = document.createElement("a");
            tmpa.download = fileName || "下载";
            tmpa.href = URL.createObjectURL(obj); //绑定a标签
            tmpa.click(); //模拟点击实现下载
            setTimeout(function () { //延时释放
                URL.revokeObjectURL(obj); //用URL.revokeObjectURL()来释放这个object URL
            }, 100);
        }
        var jsono = [{ //测试数据
            "保质期临期预警(天)": "adventLifecycle",
            "商品标题": "title",
            "建议零售价": "defaultPrice",
            "高(cm)": "height",
            "商品描述": "Description",
            "保质期禁售(天)": "lockupLifecycle",
            "商品名称": "skuName",
            "商品简介": "brief",
            "宽(cm)": "width",
            "阿达": "asdz",
            "货号": "goodsNo",
            "商品条码": "skuNo",
            "商品品牌": "brand",
            "净容积(cm^3)": "netVolume",
            "是否保质期管理": "isShelfLifeMgmt",
            "是否串号管理": "isSNMgmt",
            "商品颜色": "color",
            "尺码": "size",
            "是否批次管理": "isBatchMgmt",
            "商品编号": "skuCode",
            "商品简称": "shortName",
            "毛重(g)": "grossWeight",
            "长(cm)": "length",
            "英文名称": "englishName",
            "净重(g)": "netWeight",
            "商品分类": "categoryId",
            "这里超过了": 1111.0,
            "保质期(天)": "expDate"
        }];
        const wopts = { bookType: 'xlsx', bookSST: false, type: 'binary' };//这里的数据是用来定义导出的格式类型
        // const wopts = { bookType: 'csv', bookSST: false, type: 'binary' };//ods格式
        // const wopts = { bookType: 'ods', bookSST: false, type: 'binary' };//ods格式
        // const wopts = { bookType: 'xlsb', bookSST: false, type: 'binary' };//xlsb格式
        // const wopts = { bookType: 'fods', bookSST: false, type: 'binary' };//fods格式
        // const wopts = { bookType: 'biff2', bookSST: false, type: 'binary' };//xls格式

        function downloadExl(data, type) {
            const wb = { SheetNames: ['Sheet1'], Sheets: {}, Props: {} };
            wb.Sheets['Sheet1'] = XLSX.utils.json_to_sheet(data);//通过json_to_sheet转成单页(Sheet)数据
            saveAs(new Blob([s2ab(XLSX.write(wb, wopts))], { type: "application/octet-stream" }), "IR" + '.' + (wopts.bookType=="biff2"?"xls":wopts.bookType));
        }
        function s2ab(s) {
            if (typeof ArrayBuffer !== 'undefined') {
                var buf = new ArrayBuffer(s.length);
                var view = new Uint8Array(buf);
                for (var i = 0; i != s.length; ++i) view[i] = s.charCodeAt(i) & 0xFF;
                return buf;
            } else {
                var buf = new Array(s.length);
                for (var i = 0; i != s.length; ++i) buf[i] = s.charCodeAt(i) & 0xFF;
                return buf;
            }
        }
    </script>
</body>
</html>
