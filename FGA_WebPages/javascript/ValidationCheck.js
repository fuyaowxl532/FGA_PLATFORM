/*方法概要
RequiredStrValidator(message) 必填项校验
StrLengthValidator(message,strMaxLength,strMinLength) 字符串长度校验
DateValidator(message) 日期格式校验
DateTimeValidator(message) 日期时间格式校验
IntegerValidator(message,min,max) 整型数字校验
FloatValidator(message,min,max) 浮点数数字校验
DigitsValidator(message,min,max) 数字类型校验
MailValidator(message) Email地址校验
IPValidator(message) IP地址校验
RegExpValidator(message,regExpStr) 自定义正则校验
CallBackValidator(message,callBackFunc) 自定义回调函数校验

add by niudongling in 2014-11-17
缺少：
url 校验
电话号码校验

*/

//提交时进行form的check
function checkFormData(formValidation){
    
	return formValidation.showErrorMsg();				
}

//trim字符串
function trimStr(str)
{
	if (str == undefined || str == null){
		return "";
	}
	return str.replace(/(^\s*)|(\s*$)/g, "");
}

//isEmptyStr字符串
function isEmptyStr(str)
{
	if (str == undefined || str == null ||str==""){
		return true;
	}
	return false;
}

//定义错误信息
//fieldObj:字段对象
//msg:错误消息
function ErrorMsgObj(fieldObj,msg){
	this.fieldObj  =  fieldObj;
	this.msg  =  msg;
}

//定义字段信息
//formId:form id
//findFieldType:查找field的方法 1 by name(default) 2 by id
function FormValidation(formId,findFieldType)   {
	this.formId  =  formId;
	this.findFieldType = findFieldType;
	if (findFieldType==undefined){
		this.findFieldType = "1";
	}
	this.fieldValInfoArray  =  new Array();
	//定义校验函数
	//form:form的对象
	//fieldId:field的Id
	this.addFieldValInfo = function(fieldId,validator1,validator2,validator3,validator4,validator5,validator6) {
		var fieldValInfo = new FieldValInfo(fieldId,validator1,validator2,validator3,validator4,validator5,validator6);
		this.fieldValInfoArray.push(fieldValInfo);
	}
	//定义显示错误消息函数
	this.showErrorMsg= function(){
		var msgErrorArray = this.getMsgErrorArray();
		if (msgErrorArray.length>0){
			//显示错误消息
			var msgString = "";
			for(var i=0;i<msgErrorArray.length;i++){
			    msgString+=msgErrorArray[i].msg+"<br/>";
				//加边框颜色做提醒
				if (("undefined" != typeof(msgErrorArray[i].fieldObj))&&(msgErrorArray[i].fieldObj.type!="hidden")){
					msgErrorArray[i].fieldObj.style.borderColor = 'red';
				}
					if (("undefined" != typeof(msgErrorArray[i].fieldObj))&&(msgErrorArray[i].fieldObj.type=="hidden")){			
					if(msgErrorArray[i].fieldObj.parentNode.childNodes[1].style!=null)
					{
					    msgErrorArray[i].fieldObj.parentNode.childNodes[1].style.borderColor="red";
					}
					else
					{
					    if(msgErrorArray[i].fieldObj.parentNode.childNodes[0].style!=null)
					    {
					        msgErrorArray[i].fieldObj.parentNode.childNodes[0].style.borderColor="red";
					    }
					}

				}
			}
		    //qmalert("错误信息", msgString);
			showTopMessage("错误信息："+msgString,"auto","100%");
			if (("undefined" != typeof(msgErrorArray[0].fieldObj))&&(msgErrorArray[0].fieldObj.type!="hidden")&&(msgErrorArray[0].fieldObj.type!="select-one")){
				msgErrorArray[0].fieldObj.select();
				try{
				msgErrorArray[0].fieldObj.focus();
			}
			catch(e){
			}
			}
			if (("undefined" != typeof(msgErrorArray[0].fieldObj))&&(msgErrorArray[0].fieldObj.type=="hidden")){
				if(msgErrorArray[0].fieldObj.parentNode.childNodes[1].style!=null)
				{
				    msgErrorArray[0].fieldObj.parentNode.childNodes[1].select();
				}
			}
			return false;
		}else{
			return true;
		}
	}
	//定义遍历错误消息函数
	this.getMsgErrorArray= function(){
		var msgErrorArray = new Array();
		//debugger;
		for(var i=0;i<this.fieldValInfoArray.length;i++){
			fieldValInfo = this.fieldValInfoArray[i];
			var formObj = document.getElementById(this.formId);
			var fieldObjs = getElementsByKey(fieldValInfo.fieldName,this.findFieldType,formObj);
	        for (var j=0;j<fieldObjs.length;j++){
	            fieldObject = fieldObjs[j];
	            //恢复边框颜色
	            if (("undefined" != typeof(fieldObject))&&(fieldObject.type!="hidden")){
					fieldObject.style.borderColor = '';
				}
				if (("undefined" != typeof(fieldObject))&&(fieldObject.type=="hidden")){
					if(fieldObject.parentNode.childNodes[1].style!=null)
					{
					    fieldObject.parentNode.childNodes[1].style.borderColor = '';
					}
					else
					{
					    if(fieldObject.parentNode.childNodes[0].style!=null)
					    {
					        fieldObject.parentNode.childNodes[0].style.borderColor = '';
					    }
					}
				}
	            for (var k=0;k<fieldValInfo.validatorArray.length;k++){
			        var msg = fieldValInfo.validatorArray[k].validate(fieldObject);
			        if (msg != null){
				        msgErrorArray.push(new ErrorMsgObj(fieldObject,msg));
			        }
		        }
		    }
		}
		return msgErrorArray;
	}
	
}



//定义字段信息
//fieldId:字段id
//validatorArray:校验器
function FieldValInfo(fieldName,validator1,validator2,validator3,validator4,validator5,validator6)   {
	this.fieldName  =  fieldName;
	this.validatorArray  =  new Array();
	if (validator1 != undefined){
	    this.validatorArray.push(validator1);
	}
	if (validator2 != undefined){
	    this.validatorArray.push(validator2);
	}
	if (validator3 != undefined){
	    this.validatorArray.push(validator3);
	}
	if (validator4 != undefined){
	    this.validatorArray.push(validator4);
	}
	if (validator5 != undefined){
	    this.validatorArray.push(validator5);
	}
	if (validator6 != undefined){
	    this.validatorArray.push(validator6);
	}
	
	
}
//字段长度校验信息
//message:提示消息(必须)
//strMaxLength:字段最大长度（必须）
//strMinString:最小长度，可以不用
function  StrLengthValidator(message,strMaxLength,strMinLength)   {
	this.message  =  message;
	this.strMaxLength  =  strMaxLength;
	this.strMinLength  =  strMinLength;
	
	//定义被回调的校验函数
	//fieldObject:field的对象
	this.validate = function(fieldObject) {
		setElementValue(fieldObject,trimStr(getElementValue(fieldObject)));
		var fieldStringValue = getElementValue(fieldObject);
		if (trimStr(fieldStringValue) == "") {
		    return null;
		}
		if (fieldStringValue.length>this.strMaxLength){
		    var errorMsg = message + " 的最大长度为 " + strMaxLength + "！";
			return errorMsg;
		}
		if (this.strMinLength!=null&&fieldStringValue.length<this.strMinLength){
		    var errorMsg = message + " 的最小长度为 " + strMinLength + "！";
			return errorMsg;
		}
		return null;
	};
}

//字符串为必填项校验信息
//message:提示消息(必须)
function RequiredStrValidator(message)   {
	this.message  =  message;
	
	//定义被回调的校验函数
	//fieldObject:field的对象
	this.validate = function(fieldObject) {
		setElementValue(fieldObject,trimStr(getElementValue(fieldObject)));
		var fieldStringValue = getElementValue(fieldObject);
		if (fieldStringValue.length==0){
		    var errorMsg = "请输入" + message + "！";
			return errorMsg;
		}
		return null;
	};
}

//制表符和回车键检测
//message：提示消息(必须)
function TabAndEnterValidator(message)   {
	this.message  =  message;
	
	this.validate = function(fieldObject) {
		var fieldStringValue = getElementValue(fieldObject);
		var tab="\t"; 
        var enter="\r\n\r\n";
        if(fieldStringValue.indexOf(tab)>0 || fieldStringValue.indexOf(enter)>0)
        {
            var errorMsg = message + "中不允许输入制表符和回车键！";
		    return errorMsg;
         }
         else
         {
         
         }
      
		return null;
	};
}

//日期格式校验信息
//message:提示消息(必须)
function  DateValidator(message)   {
	this.message  =  message;
	//定义被回调的校验函数
	//fieldObject:field的对象
	this.validate = function(fieldObject) {
		setElementValue(fieldObject,trimStr(getElementValue(fieldObject)));
		
		var fieldStringValue = getElementValue(fieldObject);
		if (trimStr(fieldStringValue)==""){
			return null;
		}
		if (invalidDate(fieldStringValue)==false){
		    var errorMsg = message + " 不是有效的日期格式！";
			return errorMsg;
		}
		return null;
	};
}

//日期时间格式校验信息(精确到分钟)
//message:提示消息(必须)
function  DateTimeValidator(message)   {
	this.message  =  message;
	//定义被回调的校验函数
	//fieldObject:field的对象
	this.validate = function(fieldObject) {
		setElementValue(fieldObject,trimStr(getElementValue(fieldObject)));
		
		var fieldStringValue = getElementValue(fieldObject);
		if (trimStr(fieldStringValue)==""){
			return null;
		}
		if (invalidTime(fieldStringValue)==false){
		    var errorMsg = message + " 不是有效的日期时间格式！";
			return errorMsg;
		}
		return null;
	};
}

//email校验信息
//message:提示消息(必须)
function  MailValidator(message)   {
	this.message  =  message;
	
	//定义被回调的校验函数
	//fieldObject:field的对象
	this.validate = function(fieldObject) {
		setElementValue(fieldObject,trimStr(getElementValue(fieldObject)));
		var fieldStringValue = getElementValue(fieldObject);
		if (trimStr(fieldStringValue)==""){
			return null;
		}					
		if (invalidEmail(fieldStringValue)==true){
		    var errorMsg = message + " 不是有效的Email格式！";
			return errorMsg;
		}
		return null;
	};
}

//IP地址校验信息
//message:提示消息(必须)
function IPValidator(message) {
    this.message = message;

    //定义被回调的校验函数
    //fieldObject:field的对象
    this.validate = function (fieldObject) {
        setElementValue(fieldObject, trimStr(getElementValue(fieldObject)));
        var fieldStringValue = getElementValue(fieldObject);
        if (trimStr(fieldStringValue) == "") {
            return null;
        }
        if (invalidIP(fieldStringValue) == true) {
            var errorMsg = message + " 不是有效的IP格式！";
            return errorMsg;
        }
        return null;
    };
}

//整型校验信息
//message:提示消息(必须)
//min:最小(非必须)
//max:最大(非必须)
function  IntegerValidator(message,min,max)   {
	this.message  =  message;
	this.min  =  min;
	this.max  =  max;
	//定义被回调的校验函数
	//fieldObject:field的对象
	this.validate = function(fieldObject) {
		setElementValue(fieldObject,trimStr(getElementValue(fieldObject)));
		
		var fieldStringValue = getElementValue(fieldObject);
		if (trimStr(fieldStringValue)==""){
			return null;
		}
		if (invalidInteger(fieldStringValue)==true){
		    var errorMsg = message + " 不是有效的整型数据！";
			return errorMsg;
		}
		if ((this.max!=undefined)&&(invalidIntMax(fieldStringValue,this.max)==true)){
		    var errorMsg = message + " 必须小于等于 " + this.max + "！";
			return errorMsg;
		}
		if ((this.min!=undefined)&&(invalidIntMin(fieldStringValue,this.min)==true)){
		    var errorMsg = message + " 必须大于等于 " + this.min + "！";
			return errorMsg;
		}
		return null;
	};
}

//数字校验信息
//message:提示消息(必须)
//min:最小(非必须)
//max:最大(非必须)
function  DigitsValidator(message,min,max)   {
	this.message  =  message;
	this.min  =  min;
	this.max  =  max;
	//定义被回调的校验函数
	//fieldObject:field的对象
	this.validate = function(fieldObject) {
		setElementValue(fieldObject,trimStr(getElementValue(fieldObject)));
		
		var fieldStringValue = getElementValue(fieldObject);
		if (trimStr(fieldStringValue)==""){
			return null;
		}
		if (invalidDigits(fieldStringValue)==true){
		    var errorMsg = message + " 不是有效的数字类型！";
			return errorMsg;
		}
		return null;
	};
}

//浮点数校验信息
//message:提示消息(必须)
//min:最小
//max:最大
function  FloatValidator(message,min,max)   {
	this.message  =  message;
	this.min  =  min;
	this.max  =  max;
	//定义被回调的校验函数
	//fieldObject:field的对象
	this.validate = function(fieldObject) {
		setElementValue(fieldObject,trimStr(getElementValue(fieldObject)));
		
		var fieldStringValue = getElementValue(fieldObject);
		if (trimStr(fieldStringValue)==""){
			return null;
		}					
		if (invalidFloat(fieldStringValue)==true){
		    var errorMsg = message + " 不是有效的浮点数！";
			return errorMsg;
		}
		if ((this.max!=undefined)&&(invalidFloatMax(fieldStringValue,this.max)==true)){
		    var errorMsg = message + " 必须小于等于 " + this.max + "！";
			return errorMsg;
		}
		if ((this.min!=undefined)&&(invalidFloatMin(fieldStringValue,this.min)==true)){
		    var errorMsg = message + " 必须大于等于 " + this.min + "！";
			return errorMsg;
		}
		return null;
	};
}



//正则校验信息
//message:完整提示消息
//regExpStr:正则表达式
function  RegExpValidator(message,regExpStr)   {
	this.message  =  message;
	this.regExpStr  =  regExpStr;
	//定义被回调的校验函数
	//fieldObject:field的对象
	this.validate = function(fieldObject) {
	    setElementValue(fieldObject, trimStr(getElementValue(fieldObject)));

		var fieldStringValue = getElementValue(fieldObject);
		if (new RegExp(this.regExpStr,"g").test(fieldStringValue) == false){
			var errorMsg = message ;
			return errorMsg;
		}
		return null;
	};
}

//自定义回调校验信息
//message:完整提示消息
//callBackFunc:自定义的回调function
function  CallBackValidator(message,callBackFunc)   {
	this.message  =  message;
	//定义被回调的校验函数
	this.validate  =  callBackFunc;
}

//比较校验信息
//message:部分提示消息
//compareFieldName:被比较的元素名称
//compareFieldShowName:被比较的元素提示名称
//compareType:比较类型:==,!=,>,<,>=,<=，默认为==
//findFieldType:查找field的方? 1 by name(default) 2 by id
function  CompareValidator(message,compareFieldName,compareFieldShowName,compareType,formId,findFieldType)   {
	this.message  =  message;
	this.compareFieldName  =  compareFieldName;
	this.compareFieldShowName  =  compareFieldShowName;
	this.compareType  =  compareType;
	if (compareType == undefined){
		this.compareType = "==";
	}
	this.findFieldType  =  findFieldType;
	this.formId  =  formId;
	if (findFieldType== undefined){
		this.findFieldType="1";
	}
	//定义被回调的校验函数
	//fieldObject:field的对?
	this.validate = function(fieldObject) {
	    var formObj = document.getElementById(this.formId);
	    var compareFieldObject = document.getElementById(this.compareFieldName);
	    var fieldStringValue = getElementValue(fieldObject);
	    var compareStringValue = getElementValue(compareFieldObject);
	    var ret = eval("('" + fieldStringValue + "'" + this.compareType + "'" + compareStringValue + "')");
	    if (ret == false) {
	        var errorMsg = "";
	        if (this.compareType != undefined && this.compareType == "==") {
	            errorMsg =this.message + " must be identical to " + this.compareFieldShowName + "!";
	        }
	        else {
	            errorMsg = this.message + this.compareType + this.compareFieldShowName + " must true!";
	        }
	        return errorMsg;
	    }
	    return null;
	};
}

//根据元素获得元素的value
//elementObj:元素对象
//return:元素的value
function getElementValue(elementObj){
	if (elementObj.type=="select-one"){
		
		return elementObj.value;
	}else{
		return elementObj.value;
	}
}

//定义根据元素名称和查找方式获得元素对象数据
//elementKey:元素key
//findFieldType:查找field的方法 1 by name(default) 2 by id
//formObject:form对象
function getElementsByKey(elementKey,findType,formObject){
	//debugger;
	var elementsArray = new Array();
	var fieldObjs = null;
	if (findType=="1"){
		fieldObjs = formObject.elements[elementKey];
	}else if (findType=="2"){
		fieldObjs = formObject[elementKey];
	}
	if (fieldObjs==undefined){
		alert("Validation Func:Form["+elementKey+"] is undefined, please have check!");
	}
    if (fieldObjs.length == undefined || fieldObjs.length == 0 || fieldObjs.type=="select-one"){
    	elementsArray.push(fieldObjs);
    }else{
    	for (var j=0;j<fieldObjs.length;j++){
    		elementsArray.push(fieldObjs[j]);
    	}
    }
	return elementsArray;
}

//设置元素?
function setElementValue(elementObj,elementValue){
	if (elementObj.type=="select-one"){
		
		elementObj.value = elementValue;
	}else{
		elementObj.value = elementValue;
	}
}

//日期校验
function invalidDate(strDate)
{
	var strSeparator = "-"; //日期分隔符
	var strDateArray;
	var intYear;
	var intMonth;
	var intDay;
	var boolLeapYear;

	strDateArray = strDate.split(strSeparator);

	if(strDateArray.length!=3) return false;
	
	if (isNaN(strDateArray[0])||
		isNaN(strDateArray[1])||
		isNaN(strDateArray[2]))return false;
	
	intYear = parseInt(strDateArray[0],10);
	intMonth = parseInt(strDateArray[1],10);
	intDay = parseInt(strDateArray[2],10);

	if(isNaN(intYear)||isNaN(intMonth)||isNaN(intDay)) return false;

	if (intYear > 9999 || intYear < 1753) return false;
    
	if(intMonth>12||intMonth<1) return false;

	if((intMonth==1||intMonth==3||intMonth==5||intMonth==7||intMonth==8||intMonth==10||intMonth==12)&&(intDay>31||intDay<1)) return false;

	if((intMonth==4||intMonth==6||intMonth==9||intMonth==11)&&(intDay>30||intDay<1)) return false;

    if(intMonth==2){
	   if(intDay<1) return false;

	   boolLeapYear = false;
	   if((intYear%100)==0){
		  if((intYear%400)==0) boolLeapYear = true;
	   }
	   else{
		  if((intYear%4)==0) boolLeapYear = true;
	   }

	   if(boolLeapYear){
		  if(intDay>29) return false;
	   }
	   else{
		  if(intDay>28) return false;
	   }
   }

   return true;
}

//时间校验
function invalidTime(strDatetime)
{
	var split=" ";//日期与时间的分隔符
	var temp = strDatetime.split(split);
	if (temp.length >= 3)return false;
	
	//验证日期部分
	var intYear;
	var intMonth;
	var intDay;
	var strSeparator = "-"; //日期分隔符
	var strDateArray = temp[0].split(strSeparator);
	if(strDateArray.length!=3) return false;
	if (isNaN(strDateArray[0])||
		isNaN(strDateArray[1])||
		isNaN(strDateArray[2]))return false;
	intYear = parseInt(strDateArray[0],10);
	intMonth = parseInt(strDateArray[1],10);
	intDay = parseInt(strDateArray[2],10);

	if(isNaN(intYear)||isNaN(intMonth)||isNaN(intDay)) return false;

	if(intMonth>12||intMonth<1) return false;

	if((intMonth==1||intMonth==3||intMonth==5||intMonth==7||intMonth==8||intMonth==10||intMonth==12)&&(intDay>31||intDay<1)) return false;

	if((intMonth==4||intMonth==6||intMonth==9||intMonth==11)&&(intDay>30||intDay<1)) return false;

    if(intMonth==2){
	   if(intDay<1) return false;

	   boolLeapYear = false;
	   if((intYear%100)==0){
		  if((intYear%400)==0) boolLeapYear = true;
	   }
	   else{
		  if((intYear%4)==0) boolLeapYear = true;
	   }

	   if(boolLeapYear){
		  if(intDay>29) return false;
	   }
	   else{
		  if(intDay>28) return false;
	   }
	}
	
	//如果有时间就验证时间部分
	var intHour;
	var intMinute;
//	var intSecond;
	if (temp[1]==null || temp[1]=="")return true;
	
	var strTimeSeparator = ":"; //日期分隔符
	var strTimeArray = temp[1].split(strTimeSeparator);
	if(strTimeArray.length>2) return false;
	if (strTimeArray[0]==null || strTimeArray[0]=="" || isNaN(strTimeArray[0]))return false;
	if (strTimeArray[1]==null || strTimeArray[1]=="" || isNaN(strTimeArray[1]))return false;
//	if (strTimeArray[2]!=null && strTimeArray[2]!="" && isNaN(strTimeArray[2]))return false;

	intHour = parseInt(strTimeArray[0],10);
	intMinute = parseInt(strTimeArray[1],10);
	intSecond = parseInt(strTimeArray[2],10);
	
	if (intHour < 0 || intHour >23)return false;
	if (intMinute < 0 || intMinute >59)return false;
//	if (intSecond < 0 || intSecond >59)return false;

	return true;
}

//trim string
function _trim(s)
{    
    return s.replace( /^\s*/, "" ).replace( /\s*$/, "" );
}


//is legal number:not support -0x
function _isAllDigits(argvalue)
{
    argvalue = argvalue.toString();
    var validChars = "0123456789";
    var startFrom = 0;
    if (argvalue.substring(0, 2) == "0x")
    {
        validChars = "0123456789abcdefABCDEF";
        startFrom = 2;
    }
    //不支持8进制
//    else if (argvalue.charAt(0) == "0")
//    {
//        validChars = "01234567";
//        startFrom = 1;
//    }
    else if (argvalue.charAt(0) == "-")
    {
        startFrom = 1;
    }

    for (var n = startFrom; n < argvalue.length; n++)
    {
        if (validChars.indexOf(argvalue.substring(n, n + 1)) ==  - 1)
            return false;
    }
    return true;
}


//is legal float number,not support -0x
function _isAllFloatDigits(argvalue)
{
    argvalue = argvalue.toString();
    var validChars = "0123456789";
    var startFrom = 0;
    
    if (argvalue.charAt(0) == "-")
    {
        startFrom = 1;
    }

    for (var n = startFrom; n < argvalue.length; n++)
    {
        if (validChars.indexOf(argvalue.substring(n, n + 1)) ==  - 1)
            return false;
    }
    return true;
}


//check integer,plusint,byte,short
function invalidInteger(aInt)
{
	//validator output this 
	//if(aInt.length==0) { return false; }
    
    if (!_isAllDigits(aInt))
    {
        return true;
    }
    else
    {
        var iValue = parseInt(aInt);
        if (isNaN(iValue) )
        { return true; }
    }
    return false;
}

function invalidDigits(aInt)
{
	//validator output this 
	//if(aInt.length==0) { return false; }
    
    if (!_isAllFloatDigits(aInt))
    {
        return true;
    }
    return false;
}

//check one integer not bigger than maxValue or not
function invalidIntMax(aInt,aMax)
{
    var fValue = parseInt(aInt);
    return (fValue > aMax);
}

//check one number is not smaller than min
function invalidIntMin(aInt,aMin)
{	
    var fValue = parseInt(aInt);
    return (fValue < aMin );
}

//check one string length is not longer than maxlen
function invalidStringMaxLen(aValue,aMaxLen,willTrim)
{
  if(willTrim) { aValue = _trim(aValue); }	
  return (aValue.length>aMaxLen);
}

//check one string length is not shorter than minLen
function invalidStringMinLen(aValue,aMinLen,willTrim)
{
  if(willTrim) { aValue = _trim(aValue); }	
  return (aValue.length<aMinLen);
}

//is Unicode char
function _isUnicode(aLetter)
{
	var cLetter = escape(aLetter);	
    return ( (cLetter.charAt(0) == '%') && ( cLetter.charAt(1) == 'u' ) );
}


//get length of one string,one unicode char length deal by lengthbyOneMultiByteChar
function _getStringSaveLen(aStr,lengthByOneMultiByteChar,willTrim)
{
  var count ;
  var aLetter ;
  
  var allLength = 0;
  if(willTrim)  {  	aStr = _trim(aStr);  }
  
  for( count=0; count < aStr.length; count++ )
  {
     	aLetter = aStr.charAt( count ) ;
        if( aLetter.length==1 && _isUnicode(aLetter)==true )
        {
	  		allLength= allLength + lengthByOneMultiByteChar ;
	  	}
		else
		{
	  		allLength++;
	  	}
  }
  
  return allLength;
}

//check one string length is not longer than MaxLen:for multibyte language
function invalidMByteStrMaxLen(aStr,aMaxLen,lengthByOneMultiByteChar,willTrim)
{
  var allLength = _getStringSaveLen(aStr,lengthByOneMultiByteChar,willTrim);
  return (allLength > aMaxLen);
}

//check one string length is not shorter than MinLen:for multibyte language
function invalidMByteStrMinLen(aStr,aMinLen,lengthByOneMultiByteChar,willTrim)
{
  var allLength = _getStringSaveLen(aStr,lengthByOneMultiByteChar,willTrim);
  return (allLength < aMinLen);
}

//check float
function invalidFloat(aValue)
{  	
	//validator output this ?
	//if(aValue.length==0){ return false; }
	
	var tempArray = aValue.split('.');
	var joinedString = tempArray.join('');
	
	if (!_isAllFloatDigits(joinedString))
	{
		return true;
	}
	else
	{
	    var iValue = parseFloat(aValue);
	    if(isNaN(iValue) ) { return true; }
	}	
  	return false;
}

//check float max range
function invalidFloatMax(aFloat,aMax)
{
    var fValue = parseFloat(aFloat);
    return (fValue > aMax);
}

//check float min range
function invalidFloatMin(aFloat,aMin)
{
    var fValue = parseFloat(aFloat);
    return (fValue < aMin );
}

//check url,for convience,user can change script,if writen in code,can't change. 
function invalidURL(aUrl)
{
	//if(aUrl.length==0){ return false; }
	
	var aRE = /^http:\/\/.*\..*/i;
	return !aRE.test(aUrl);
}
//check email
function invalidEmail(aEmail)
{
	//if(aEmail.length==0) return false;
	
	return !( /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w+)+$/.test(aEmail) );
}

//check IP
function invalidIP(aIP)
{
    return !(/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/.test(aIP));
}

//
function invalidDataMask(aValue,adatamask)
{
	//if(aValue.length==0) return false;
	
    return (!_matchPattern(aValue,adatamask))
    {
      return true;
    }
}

//one string is fine for maks rule
function _matchPattern(value, mask) 
{   return mask.exec(value);}
