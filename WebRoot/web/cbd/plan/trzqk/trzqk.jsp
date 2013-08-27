<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//String xmmc = new String(request.getParameter("xmmc").getBytes("iso-8859-1"), "UTF-8");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>投融资情况</title>
    
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
		input{
			font-size:16px;
			font-family:"宋体";
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
  			putClientCommond("trzqkHandle", "deleteExist");
			putRestParameter("year", document.getElementById("nd_" + i));
			putRestParameter("quarter", document.getElementById("jd_" + i));
			baseInformation = restRequest();
  		}
		document.forms[0].submit();
	}
	
	//获取相同年份和季节数据
	function getSameData(check){
	
	
	}
	
	//初始化,获取相同项目名称的基本数据
	function onInit(){
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
		putClientCommond("trzqkHandle", "getAzfjsByQuarter");
		putRestParameter("year", yearValue);
		putRestParameter("quarter", value);
		baseInformation = restRequest();
		baseInformation = eval(baseInformation);
		
		if(baseInformation.length > 0){
			document.getElementById(name.replace(/jd/, "bqtzxq")).value = format(baseInformation[0].BQTZXQ);
			document.getElementById(name.replace(/jd/, "bqhlcb")).value = format(baseInformation[0].BQHLCB);
			document.getElementById(name.replace(/jd/, "zftdsy")).value = format(baseInformation[0].ZFTDSY);
			document.getElementById(name.replace(/jd/, "bqrzxq")).value = format(baseInformation[0].BQRZXQ);
			document.getElementById(name.replace(/jd/, "bqhkxq")).value = format(baseInformation[0].BQHKXQ);
			document.getElementById(name.replace(/jd/, "qyxzjzr")).value = format(baseInformation[0].QYXZJZR);
			document.getElementById(name.replace(/jd/, "fzye")).value = format(baseInformation[0].FZYE);
			document.getElementById(name.replace(/jd/, "cbkrzqk")).value = format(baseInformation[0].CBRZQK);
			document.getElementById(name.replace(/jd/, "zjfx")).value = format(baseInformation[0].ZJFX);
			document.getElementById(name.replace(/jd/, "bqzmye")).value = format(baseInformation[0].BQZMYE);
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
	<div align="center"><h1 style="font-size: 25">投融资情况</h1></div>
  	<form method="post">
		
  	    <table align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><label>属性名\年度</label>            </td>
            <td width="138"><select id="nd_1" name="nd_1">
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
            <td width="163"><select id="nd_2" name="nd_2">
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
            <td width="163"><select id="nd_3" name="nd_3" >
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
            <td width="167"><select id="nd_4" name="nd_4">
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
            <td><label>本期投资需求(亿元)</label></td>
            <td><input type="text" id="bqtzxq_1" name="bqtzxq_1"  style="width:80px" /></td>
            <td><input type="text" id="bqtzxq_2" name="bqtzxq_2" style="width:80px" /></td>
            <td><input type="text" id="bqtzxq_3" name="bqtzxq_3" style="width:80px" /></td>
            <td><input type="text" id="bqtzxq_4" name="bqtzxq_4" style="width:80px" /></td>
          </tr>
          <tr>
            <td><label>本期回笼成本(亿元)</label>            </td>
            <td><input type="text" id="bqhlcb_1" name="bqhlcb_1"  style="width:80px" /></td>
            <td><input type="text" id="bqhlcb_2" name="bqhlcb_2" style="width:80px" /></td>
            <td><input type="text" id="bqhlcb_3" name="bqhlcb_3" style="width:80px" /></td>
            <td><input type="text" id="bqhlcb_4" name="bqhlcb_4" style="width:80px" /></td>
          </tr>
          <tr>
            <td><label>政府土地收益(亿元)</label>            </td>
            <td><input type="text" id="zftdsy_1" name="zftdsy_1"  style="width:80px" /></td>
            <td><input type="text" id="zftdsy_2" name="zftdsy_2" style="width:80px" /></td>
            <td><input type="text" id="zftdsy_3" name="zftdsy_3" style="width:80px" /></td>
            <td><input type="text" id="zftdsy_4" name="zftdsy_4" style="width:80px" /></td>
          </tr>
          <tr>
            <td><label>本期融资需求(亿元)</label>            </td>
            <td><input type="text" id="bqrzxq_1" name="bqrzxq_1" style="width:80px" /></td>
            <td><input type="text" id="bqrzxq_2" name="bqrzxq_2" style="width:80px" /></td>
            <td><input type="text" id="bqrzxq_3" name="bqrzxq_3" style="width:80px" /></td>
            <td><input type="text" id="bqrzxq_4" name="bqrzxq_4" style="width:80px" /></td>
          </tr>
          <tr>
            <td><label>本期还款需求(亿元)</label>            </td>
            <td><input type="text" id="bqhkxq_1" name="bqhkxq_1"  style="width:80px" /></td>
            <td><input type="text" id="bqhkxq_2" name="bqhkxq_2" style="width:80px" /></td>
            <td><input type="text" id="bqhkxq_3" name="bqhkxq_3" style="width:80px" /></td>
            <td><input type="text" id="bqhkxq_4" name="bqhkxq_4" style="width:80px" /></td>
          </tr>
		  <tr>
            <td><label>权益性资金注入(注入)</label>            </td>
            <td><input type="text" id="qyxzjzr_1" name="qyxzjzr_1" style="width:80px" /></td>
            <td><input type="text" id="qyxzjzr_2" name="qyxzjzr_2" style="width:80px" /></td>
            <td><input type="text" id="qyxzjzr_3" name="qyxzjzr_3" style="width:80px" /></td>
            <td><input type="text" id="qyxzjzr_4" name="qyxzjzr_4" style="width:80px" /></td>
		  </tr>
		  
		  <tr>
            <td><label>负债余额(亿元)</label>            </td>
            <td><input type="text" id="fzye_1" name="fzye_1" style="width:80px" />
             </td>
            <td><input type="text" id="fzye_2" name="fzye_2" style="width:80px" />
              </td>
            <td><input type="text" id="fzye_3" name="fzye_3" style="width:80px" />
              </td>
            <td><input type="text" id="fzye_4" name="fzye_4" style="width:80px" />
              </td>
          </tr>
		  <tr>
            <td><label>储备库融资缺口(亿元)</label>            </td>
            <td><input type="text" id="cbkrzqk_1" name="cbkrzqk_1" style="width:80px" />
             </td>
            <td><input type="text" id="cbkrzqk_2" name="cbkrzqk_2" style="width:80px" />
              </td>
            <td><input type="text" id="cbkrzqk_3" name="cbkrzqk_3" style="width:80px" />
              </td>
            <td><input type="text" id="cbkrzqk_4" name="cbkrzqk_4" style="width:80px" />
              </td>
          </tr>
		  <tr>
            <td><label>资金风险(亿元)</label>            </td>
            <td><input type="text" id="zjfx_1" name="zjfx_1" style="width:80px" />
             </td>
            <td><input type="text" id="zjfx_2" name="zjfx_2" style="width:80px" />
              </td>
            <td><input type="text" id="zjfx_3" name="zjfx_3" style="width:80px" />
              </td>
            <td><input type="text" id="zjfx_4" name="zjfx_4" style="width:80px" />
              </td>
          </tr>
		  <tr>
            <td><label>本期账面余额(亿元)</label>            </td>
            <td><input type="text" id="bqzmye_1" name="bqzmye_1" style="width:80px" />
             </td>
            <td><input type="text" id="bqzmye_2" name="bqzmye_2" style="width:80px" />
              </td>
            <td><input type="text" id="bqzmye_3" name="bqzmye_3" style="width:80px" />
              </td>
            <td><input type="text" id="bqzmye_4" name="bqzmye_4" style="width:80px" />
              </td>
          </tr>
        </table>
  	</form>
  </body>
</html>
