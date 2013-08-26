<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String xmmc = new String(request.getParameter("xmmc").getBytes("iso-8859-1"), "UTF-8");
//String xmmc = "联合大学商学院";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>安置房建设</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/base/include/newformbase.jspf"%>
	<link rel="stylesheet" href="/base/form/css/commonForm.css" type="text/css" />
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
  </head>
  <style type="text/css">
  		table{
			border-left-color:#000000;
			border-left-style:solid;
			border-left-width:1px;
			border-top-color:#000000;
			border-top-style:solid;
			border-top-width:1px;
			background-color:#FFFFFF;
			font-family:"宋体";
			font-size:16px;
			}
		td{
			border-bottom-color:#000000;
			border-bottom-style:solid;
			border-bottom-width:1px;
			border-right-color:#000000;
			border-right-style:solid;
			border-right-width:1px;
			margin-bottom:5px;
			margin-top:5px;
			}
		select{
			background:#FFFFFF;
			border:none;
			}
		input{
			background:#FFFFFF;
			border:none;
			}
  </style>
  <script type="text/javascript">
  	function save(){
		 //保存之前，删除数据库中已经存在的数据
  		for(var i = 0; i < document.getElementById("num").value; i++){
  			putClientCommond("azfjsHandle", "deleteExist");
			putRestParameter("year", document.getElementById("nd_" + (i + 1)));
			putRestParameter("quarter", document.getElementById("jd_" + (i + 1)));
			baseInformation = restRequest();
  		}
		document.forms[0].submit();
	}
	
	//获取相同年份和季节数据
	function getSameData(check){
	
	
	}
	
	//初始化,获取相同项目名称的基本数据
	function onInit(){
		putClientCommond("jcsjHandler", "getProjectList");
		putRestParameter("xmmc", "<%=xmmc%>");
		baseInformation = restRequest();
		baseInformation = eval(baseInformation);
		//总户数
		zhs = baseInformation[0].HS;
		//总地量
		zdl = baseInformation[0].ZD;
		//总规模
		zgm = baseInformation[0].GM;
		//住
		zzf = baseInformation[0].ZZCQFY;
		//企
		zqf = baseInformation[0].QYCQFY;
		//楼面价
		lmj = baseInformation[0].LMCB;
		//成交价
		cjj = baseInformation[0].LMCJJ;
		
		//拆迁货币投资
		cqhbtz = baseInformation[0].ZZHBTZCB;
		
		for(var i = 2012; i < 2022; i++){
			Addopt("nd_1", i);
			Addopt("nd_2", i);
			Addopt("nd_3", i);
			Addopt("nd_4", i);
		}
		
		init();
	}
	
	
	
	//添加选项
	function Addopt(selectname, value){
		var name = document.getElementById(selectname);
		var opt = document.createElement('option');
		opt.text = value;
		opt.value = value;
		name.options.add(opt);
	}
	
	
	function kg(check){
		var value = check.value;
		var name = check.name;
		name = name.replace(/kgbfb/,"kg");
		value = 50*parseFloat(value)* 0.01;
		if(value == "" || isNaN(value)){
			value = 0;
		}
		document.getElementById(name).value = format(value);
	}

  	  	//选择年度和季度时，查询是否有历史数据
	function changeQuarter(check){
		var value = check.value;
		var name = check.name;
		var yearname = name.replace(/jd/,"nd");
		var yearValue = document.getElementById(yearname).value;
		//当年度和季度不确定时，不做处理
		if(yearValue == "" || value == ""){
			return;
		}
		putClientCommond("azfjsHandle", "getAzfjsByQuarter");
		putRestParameter("year", yearValue);
		putRestParameter("quarter", value);
		baseInformation = restRequest();
		baseInformation = eval(baseInformation);
		
		if(baseInformation.length > 0){
			document.getElementById(name.replace(/jd/, "kgbfb")).value = format(baseInformation[0].KGBFB);
			document.getElementById(name.replace(/jd/, "kg")).value = format(baseInformation[0].KG);
			document.getElementById(name.replace(/jd/, "tz")).value = format(baseInformation[0].TZ);
		}		
	}
	
			//数据格式化
	function format(value){
		if(value == null || value == "" || value == undefined || isNaN(value)){
			return "";
		}else{
			return value;
		}
	}
  </script>
  <body onLoad="onInit();">
  	<div id="fixed" class="Noprn" style="position: fixed; top: 5px; left: 0px"></div>
  	<form method="post">
		
  	    <table align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><label>项目名称</label>            </td>
            <td id="xmmctd" colspan="4"><input type="text" id="xmmc" name="xmmc" value="<%=xmmc%>" style="width:100px">
              &nbsp;&nbsp;
              <button>增加</button>
  				<input type="text" id="num" value="4" style="display:none" />
      <button>删除</button></td>
          </tr>
          <tr>
            <td><label>属性名\年度</label>            </td>
            <td><select id="nd_1" name="nd_1">
                <option ></option>
                 </select>
              &nbsp;
              <select id="jd_1" name="jd_1" onChange="changeQuarter(this);return false;">
              	<option checked></option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select>            </td>
            <td><select id="nd_2" name="nd_2">
                <option checked></option>
              </select>
              &nbsp;
              <select id="jd_2" name="jd_2" onChange="changeQuarter(this);return false;">
              	<option checked></option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select>            </td>
            <td><select id="nd_3" name="nd_3" >
                <option checked></option>
              </select>
              &nbsp;
              <select id="jd_3" name="jd_3" onChange="changeQuarter(this);return false;">
              	<option checked></option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select>            </td>
            <td><select id="nd_4" name="nd_4">
                <option checked></option>
              </select>
              &nbsp;
              <select id="jd_4" name="jd_4" onChange="changeQuarter(this);return false;">
              	<option checked></option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
              </select>            </td>
          </tr>
          <tr>
            <td><label>开工(百分比)</label>            </td>
            <td><input type="text" id="kgbfb_1" name="kgbfb_1" onBlur="kg(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="kg_1" name="kg_1" style="width:80px" /></td> 
            <td><input type="text" id="kgbfb_2" name="kgbfb_2" onBlur="kg(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="kg_2" name="kg_2"  style="width:80px" /></td>
            <td><input type="text" id="kgbfb_3" name="kgbfb_3" onBlur="kg(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="kg_3" name="kg_3"  style="width:80px" /></td>
            <td><input type="text" id="kgbfb_4" name="kgbfb_4" onBlur="kg(this)" style="width:50px; text-align:right; padding-right:5px" />
				<label>%</label>
                <input type="text" id="kg_4" name="kg_42" style="width:80px" /></td>
          </tr>
          <tr>
            <td><label>投资</label>            </td>
            <td><input type="text" id="tz_1" name="tz_1"  style="width:80px" /></td>
            <td><input type="text" id="tz_2" name="tz_2"  style="width:80px" /></td>
            <td><input type="text" id="tz_3" name="tz_3"  style="width:80px" /></td>
            <td><input type="text" id="tz_4" name="tz_4"  style="width:80px" /></td>
          </tr>
        </table>
  	</form>
  </body>
</html>
