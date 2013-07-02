<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.klspta.web.xuzhouWW.PADDataList"%>
<%@page import="java.text.DecimalFormat"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%
	String yw_guid = request.getParameter("yw_guid"); 
    PADDataList padlist=new PADDataList();
	List list = padlist.getPADCompareAnalysisDataByYwguid(yw_guid); 
	String zmj="";
	String nyd="";
	String gd ="";
	String jsyd = "";
	String wlyd ="";
	String location ="";
	String xzjsyd = "";
	String xjsyd = "";
	String ytjjsq = "";
	String xzjsq = "";
	String jzjsq = "";
	String zyjbnt = "";
	if(list.size()>0){
		Map map = (Map)list.get(0);
	  	zmj = map.get("zmj")==null?"":map.get("zmj").toString();	
		nyd = (String)map.get("nyd")==null?"":(String)map.get("nyd");	
		gd = (String)map.get("gd")==null?"":(String)map.get("gd");	
		jsyd = (String)map.get("jsyd")==null?"":(String)map.get("jsyd");	
		wlyd = (String)map.get("wlyd")==null?"":(String)map.get("wlyd");	
		location = (String)map.get("location")==null?"":(String)map.get("location");	
		xzjsyd =(String)map.get("xzjsyd")==null?"":(String)map.get("xzjsyd");	
		xjsyd = (String)map.get("xjsyd")==null?"":(String)map.get("xjsyd");	
		ytjjsq = (String)map.get("ytjjsq")==null?"":(String)map.get("ytjjsq");	
		xzjsq = (String)map.get("xzjsq")==null?"":(String)map.get("xzjsq");	
		jzjsq = (String)map.get("jzjsq")==null?"":(String)map.get("jzjsq");	
		zyjbnt = (String)map.get("zyjbnt")==null?"":(String)map.get("zyjbnt");	
		
		zmj = String.format("%.2f",Double.parseDouble(zmj));
		nyd = String.format("%.2f",Double.parseDouble(nyd));
		gd = String.format("%.2f",Double.parseDouble(gd));	
		jsyd = String.format("%.2f",Double.parseDouble(jsyd));
		wlyd = String.format("%.2f",Double.parseDouble(wlyd));	
		xzjsyd = String.format("%.2f",Double.parseDouble(xzjsyd));
		xjsyd = String.format("%.2f",Double.parseDouble(xjsyd));	
		ytjjsq = String.format("%.2f",Double.parseDouble(ytjjsq));
		xzjsq = String.format("%.2f",Double.parseDouble(xzjsq));	
		jzjsq = String.format("%.2f",Double.parseDouble(jzjsq));
		zyjbnt =String.format("%.2f",Double.parseDouble(zyjbnt));
	}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<style type="text/css">
	body{height:600px;} 
	table{
	
	}
	td{	border-right:1px solid  #8470FF; 
		border-bottom:1px solid  #8470FF; 
		border-left:0; border-top:0; 
		font-size:12px;
		padding:3px 3px 3px 3px;
		text-align: center;
	}
	.tableBorder{
		border-top:1px solid #8470FF;
		border-left:1px solid #8470FF;
	}
    input{
     	border:0px;
		width:80px;
     	vertical-align: middle;
		text-align:center;
    }
</style>


<body >

<center>
<div style="width:600px;">
<div style="width600px;height:25px; font-weight:normal; font-size:12pt; font-family:黑体" align="center">系统比对分析结果</div>
<div style="width600px;height:25px; font-weight:normal; font-size:11pt;" align="right">单位：亩</div>   
  	<!-- 现状数据 -->
   	<table border="1" cellpadding="0" cellspacing="0" width="600"  style="text-align:center; vertical-align:middle;font-family: 宋体, Arial; font-size: 12px;border-collapse:collapse;border:1px #8470FF solid;margin-top:-10px;" >
	   	<tr>
	    	<td colspan="6" bgcolor="#CCCCCC" height="25">现状分析比对结果</td>
	    </tr>	
    	<tr>
        	<td width="120">总面积</td>
            <td colspan="2" width="240">农用地</td>
            <td colspan="2" width="120">建设用地</td>
            <td>未利用地</td>
        </tr>
     	<tr>
        	<td rowspan="2" width="120"><input value="<%=zmj %>" /></td>
            <td width="140" rowspan="2"><input value="<%=nyd %>" /></td>
            <td width="100">其中耕地</td>
            <td colspan="2" rowspan="2" ><input value="<%=jsyd %>"/></td>
            <td rowspan="2" width="100"><input value="<%=wlyd %>"/></td>
        </tr>
    	<tr>
        	<td><input value="<%=gd %>"/></td>
        </tr>               
		<tr height="30">
			<td>权属性质</td>
			<td colspan="6" align="left"><input id="location" value="<%=location %>" style="width:450px;" /></td>
		</tr>
		<!-- 规划数据  -->
	    <tr>
	    	<td colspan="6" bgcolor="#CCCCCC" height="25">规划分析比对结果</td>
	    </tr>	
		 <tr >
		 	<td rowspan="2">符合规划</td>
		 	<td colspan="2" rowspan="2" >&nbsp;允许建设区&nbsp;</td>
			<td width="120">&nbsp;现状建设用地</td>
		 	<td colspan="2"><input value="<%=xzjsyd %>"/></td>
	 	  </tr>
		 <tr>
		 	<td>&nbsp;新增建设用地</td>
		 	<td colspan="2"><input value="<%=xjsyd %>"/></td>
	 	  </tr>
		 <tr>
		 	<td rowspan="3">不符合规划</td>
		 	<td colspan="3">&nbsp;有条件建设区</td>
		 	<td colspan="2"><input value="<%=ytjjsq %>"/></td>
	 	  </tr>
		 <tr>
		 	<td colspan="3">&nbsp;限制建设区</td>
		 	<td colspan="2"><input value="<%=xzjsq %>"/></td>
	 	 </tr>
		 <tr>
			<td colspan="3">&nbsp;禁止建设区</td>
			<td colspan="2"><input value="<%=jzjsq %>"/></td>
	 	 </tr>
		 <tr>
		 	<td>占用基本农田</td>
		 	<td colspan="5"><input value="<%=zyjbnt %>"  style="width:450px;" /></td>
	 </table>
 </div>
 </center>

</body>
</html>