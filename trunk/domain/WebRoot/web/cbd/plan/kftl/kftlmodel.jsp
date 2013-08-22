<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//String xmmc = new String(request.getParameter("xmmc").getBytes("iso-8859-1"), "UTF-8");
String xmmc = "联合大学商学院";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>开发体量登记表</title>
    
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
		
		//添加楼面价、成交价的值
		for(var i = 1; i < 5; i++){
			var loumName = document.getElementById("lm_" + i);
			var cjName = document.getElementById("cj_" + i);
			loumName.value = lmj;
			cjName.value = cjj;
		}
		
	}
	
	//添加选项
	function Addopt(selectname, value){
		var name = document.getElementById(selectname);
		var opt = document.createElement('option');
		opt.text = value;
		opt.value = value;
		name.options.add(opt);
	}
	
	//根据输入的百分比计算对应的值
	//计算户数对应的值
	function hushu(check){
		var value = check.value;
		var name = check.name;
		name = name.replace(/hs/,"hsz");
		value = parseFloat(zhs)*parseFloat(value)* 0.01;
		document.getElementById(name).value = value;
	}
	
	//计算地量的值
	function diliang(check){
		var value = check.value;
		var name = check.name;
		name = name.replace(/dl/,"dlz");
		value = parseFloat(zdl)*parseFloat(value)* 0.01;
		document.getElementById(name).value = value;
	}
	
	//计算规模的值
	function guimo(check){
		var value = check.value;
		var name = check.name;
		name = name.replace(/gm/,"gmz");
		value = parseFloat(zgm)*parseFloat(value)* 0.01;
		document.getElementById(name).value = value;
	}
	
	//计算住的值
	function zhu(check){
		var value = check.value;
		var name = check.name;
		name = name.replace(/zhu/,"zhuz");
		value = parseFloat(zzf)*parseFloat(value)* 0.01;
		if(value == "" || isNaN(value)){
			value = 0;
		}
		document.getElementById(name).value = value;
		
		//计算投资值
		var tzzname = name.replace(/zhu/, "tz");
		var tzname = name.replace(/zhu/, "t"); 
		var qizname = name.replace(/zhu/,"qi");
		var qivalue = document.getElementById(qizname).value;
		if(qivalue == "" || isNaN(qivalue)){
			qivalue = 0;
		}
		if(value == "" || isNaN(value)){
			value = 0;
		}
		var tzzvalue = parseFloat(qivalue)+parseFloat(value);
		document.getElementById(tzzname).value = tzzvalue;
		
		var tzvalue = (parseFloat(tzzvalue)*100)/parseFloat(cqhbtz);
		tzvalue = tzvalue + '%';
		
		document.getElementById(tzname).value = tzvalue;	
	}
	
	function qi(check){
		var value = check.value;
		var name = check.name;
		name = name.replace(/qi/,"qiz");
		value = parseFloat(zqf)*parseFloat(value)* 0.01;
		if(value == "" || isNaN(value)){
			value = 0;
		}
		document.getElementById(name).value = value;
		
				//计算投资值
		var tzzname = name.replace(/qi/, "tz");
		var tzname = name.replace(/qi/, "t"); 
		var zhuzname = name.replace(/qi/,"zhu");
		var qivalue = document.getElementById(zhuzname).value;
		if(qivalue == "" || qivalue == 'NaN'){
			qivalue = 0;
		}

		var tzzvalue = parseFloat(qivalue)+parseFloat(value);
		document.getElementById(tzzname).value = tzzvalue;
		
		var tzvalue = (parseFloat(tzzvalue)* 100)/parseFloat(cqhbtz);
		tzvalue = tzvalue + '%';
		
		document.getElementById(tzname).value = tzvalue;	
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
  				
      <button>删除</button></td>
          </tr>
          <tr>
            <td><label>属性名\年度</label>            </td>
            <td><select name="nd_1">
                <option ></option>
                 </select>
              &nbsp;
              <select name="jd_1">
              	<option checked></option>
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
              </select>            </td>
            <td><select name="nd_2">
                <option checked></option>
              </select>
              &nbsp;
              <select name="jd_2">
              	<option checked></option>
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
              </select>            </td>
            <td><select name="nd_3" >
                <option checked></option>
              </select>
              &nbsp;
              <select name="jd_3" >
              	<option checked></option>
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
              </select>            </td>
            <td><select name="nd_4">
                <option checked></option>
              </select>
              &nbsp;
              <select name="jd_4">
              	<option checked></option>
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
              </select>            </td>
          </tr>
          <tr>
            <td><label>户数(百分比)</label>            </td>
            <td><input type="text" id="hs_1" name="hs_1" onBlur="hushu(this)" style="width:80px" />
                <input type="text" id="hsz_1" name="hsz_1" style="width:80px" /></td>
            <td><input type="text" id="hs_2" name="hs_2" style="width:80px" />
                <input type="text" id="hsz_2" name="hsz_2" style="width:80px" /></td>
            <td><input type="text" id="hs_3" name="hs_3" style="width:80px" />
                <input type="text" id="hsz_3" name="hsz_3" style="width:80px" /></td>
            <td><input type="text" id="hs_4" name="hs_4" style="width:80px" />
                <input type="text" id="hsz_4" name="hsz_42" style="width:80px" /></td>
          </tr>
          <tr>
            <td><label>地量(百分比)</label>            </td>
            <td><input type="text" id="dl_1" name="dl_1" onBlur="diliang(this)" style="width:80px" />   
			    <input type="text" id="dlz_1" name="dlz_1" style="width:80px" />       </td>
            <td><input type="text" id="dl_2" name="dl_2" style="width:80px" />
                <input type="text" id="dlz_2" name="dlz_2" style="width:80px" /></td>
            <td><input type="text" id="dl_3" name="dl_3" style="width:80px" />
                <input type="text" id="dlz_3" name="dlz_3" style="width:80px" /></td>
            <td><input type="text" id="dl_4" name="dl_4" style="width:80px" />
                <input type="text" id="dlz_4" name="dlz_4" style="width:80px" /></td>
          </tr>
          <tr>
            <td><label>规模(百分比)</label>            </td>
            <td><input type="text" id="gm_1" name="gm_1" onBlur="guimo(this)" style="width:80px" />
                <input type="text" id="gmz_1" name="gmz_1" style="width:80px" />            </td>
            <td><input type="text" id="gm_2" name="gm_2" style="width:80px" />
                <input type="text" id="gmz_2" name="gmz_2" style="width:80px" />            </td>
            <td><input type="text" id="gm_3" name="gm_3" style="width:80px" />
                <input type="text" id="gmz_3" name="gmz_3" style="width:80px" />            </td>
            <td><input type="text" id="gm_4" name="gm_4" style="width:80px" />
                <input type="text" id="gmz_4" name="gmz_4" style="width:80px" />            </td>
          </tr>
          <tr>
            <td><label>住(百分比)</label>            </td>
            <td><input type="text" name="zhu_1" onBlur="zhu(this)" style="width:80px" />
                <input type="text" name="zhuz_1" style="width:80px" /></td>
            <td><input type="text" name="zhu_2" style="width:80px" />
                <input type="text" name="zhuz_2" style="width:80px" /></td>
            <td><input type="text" name="zhu_3" style="width:80px" />
                <input type="text" name="zhuz_3" style="width:80px" /></td>
            <td><input type="text" name="zhu_4" style="width:80px" />
                <input type="text" name="zhuz_4" style="width:80px" /></td>
          </tr>
          <tr>
            <td><label>企(百分比)</label>            </td>
            <td><input type="text" id="qi_1" name="qi_1" onBlur="qi(this)" style="width:80px" />
              <input type="text" id="qiz_1" name="qiz_1" style="width:80px" /></td>
            <td><input type="text" id="qi_2" name="qi_2" style="width:80px" />
              <input type="text" id="qiz_2" name="qiz_2" style="width:80px" /></td>
            <td><input type="text" id="qi_3" name="qi_3" style="width:80px" />
              <input type="text" id="qiz_3" name="qiz_3" style="width:80px" /></td>
            <td><input type="text" id="qi_4" name="qi_4" style="width:80px" />
              <input type="text" id="qiz_4" name="qiz_4" style="width:80px" /></td>
          </tr>
		  <tr>
            <td><label>投资</label>            </td>
            <td><input type="text" id="tz_1" name="tz_1" style="width:80px" />
              <input type="text" id="tzz_1" name="tzz_1" style="width:80px" /></td>
            <td><input type="text" id="tz_2" name="tz_2" style="width:80px" />
              <input type="text" id="tzz_2" name="tzz_2" style="width:80px" /></td>
            <td><input type="text" id="tz_3" name="tz_3" style="width:80px" />
              <input type="text" id="tzz_3" name="tzz_3" style="width:80px" /></td>
            <td><input type="text" id="tz_4" name="tz_4" style="width:80px" />
              <input type="text" id="tzz_4" name="tzz_4" style="width:80px" /></td>
          </tr>
		  
		  <tr>
            <td><label>楼面价</label>            </td>
            <td><input type="text" id="lm_1" name="lm_1" style="width:80px" />
             </td>
            <td><input type="text" id="lm_2" name="lm_2" style="width:80px" />
              </td>
            <td><input type="text" id="lm_3" name="lm_3" style="width:80px" />
              </td>
            <td><input type="text" id="lm_4" name="lm_4" style="width:80px" />
              </td>
          </tr>
		  		  <tr>
            <td><label>成交价</label>            </td>
            <td><input type="text" id="cj_1" name="cj_1" style="width:80px" />
             </td>
            <td><input type="text" id="cj_2" name="cj_2" style="width:80px" />
              </td>
            <td><input type="text" id="cj_3" name="cj_3" style="width:80px" />
              </td>
            <td><input type="text" id="cj_4" name="cj_4" style="width:80px" />
              </td>
          </tr>
        </table>
  	</form>
  </body>
</html>
