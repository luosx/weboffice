<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<% String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String returnPath = request.getParameter("returnPath");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>基表详细信息</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link rel="stylesheet"
			href="<%=basePath%>base/form/css/commonForm.css" type="text/css" />
	    <%@ include file="/base/include/formbase.jspf"%>
</head>
<script type="text/javascript">
	//初始化
	function firstInit(){
	    init();
	}
//返回原来列表
function back(){
	  this.location.href="<%=returnPath%>";
}
</script>

  <body onLoad="firstInit();">
  <div align="right">
			<br>
			<input type="button" id="fanhui"  value="返回" onclick="back()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</div>

  <div align="center" id="title" style="font-weight: bold; font-size: 18pt; font-family: 宋体">
			<br />
			
				案件信息基本表
			
		</div>
		<form id="form" name="form" method="post" action="">
<table class="lefttopborder1" cellspacing="0" cellpadding="0" border="1" bgcolor="#FFFFFF" bordercolor="#000000" width="540" height="1042">
 <tr>
    <td width="120" height="21" align="center">案件年度时间</td>
    <td width="150">
    <input id="ajndsj" name="ajndsj" readonly="readonly" type="text" />
  </td>
    <td width="120" align="center">案&nbsp;&nbsp;件&nbsp;&nbsp;来&nbsp;&nbsp;源</td>
    <td width="150"> <input id="ajly" name="ajly" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td height="21" align="center">专项项目名称</td>
    <td> <input id="zxxmmc" name="zxxmmc" readonly="readonly" type="text" /></td>
    <td align="center">案件办理人员</td>
    <td> <input id="ajblr" name="ajblr" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">用&nbsp;&nbsp;地&nbsp;&nbsp;单&nbsp;&nbsp;位</td>
    <td colspan="3"> <input id="yddw" name="yddw" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">被&nbsp;用&nbsp;地&nbsp;单&nbsp;位</td>
    <td colspan="3"> <input id="byddw" name="byddw" readonly="readonly" type="text" /></td>
  </tr>

    <tr>
    <td align="center">宗&nbsp;&nbsp;地&nbsp;&nbsp;位&nbsp;&nbsp;置</td>
    <td colspan="3"><input id="zdwz" name="zdwz" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">宗&nbsp;&nbsp;地&nbsp;&nbsp;坐&nbsp;&nbsp;标</td>
    <td colspan="3"><input id="zdzb" name="zdzb" readonly="readonly" type="text" /></td>
  </tr>
  
  
  <tr>
    <td align="center">违法用地时间</td>
    <td> <input id="wfydsj" name="wfydsj" readonly="readonly" type="text" /></td>
    <td align="center">违法用地性质</td>
    <td> <input id="wfydxz" name="wfydxz" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">违法主体类型</td>
    <td> <input id="wfztlx" name="wfztlx" readonly="readonly" type="text" /></td>
    <td align="center">土地实际用途</td>
    <td> <input id="tdsjyt" name="tdsjyt" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">土&nbsp;&nbsp;地&nbsp;&nbsp;性&nbsp;&nbsp;质</td>
    <td> <input id="tdxz" name="tdxz" readonly="readonly" type="text" /></td>
    <td align="center">总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;面&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;积</td>
    <td> <input id="zmianji" name="zmianji" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td rowspan="2" align="center">是否符合土地<br/>利用总体规划</td>
    <td height="28" align="center">符合规划面积</td>
    <td> <input id="fhghmj" name="fhghmj" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="33" align="center">不符合规划面积</td>
    <td> <input id="bfhghmj" name="bfhghmj" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td rowspan="7" align="center">占&nbsp;&nbsp;用&nbsp;&nbsp;类&nbsp;&nbsp;型</td>
    <td rowspan="5" align="center">农用地</td>
    <td align="center">耕&nbsp;&nbsp;地&nbsp;&nbsp;面&nbsp;&nbsp;积</td>
    <td> <input id="gdmj" name="gdmj" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">其中基本农田</td>
    <td> <input id="qzjbntmianji" name="qzjbntmianji" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">园&nbsp;&nbsp;地&nbsp;&nbsp;面&nbsp;&nbsp;积</td>
    <td> <input id="ydmianji" name="ydmianji" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">林&nbsp;&nbsp;地&nbsp;&nbsp;面&nbsp;&nbsp;积</td>
    <td> <input id="ldmianji" name="ldmianji" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">其&nbsp;他&nbsp;农&nbsp;用&nbsp;地</td>
    <td> <input id="qtnydmianji" name="qtnydmianji" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">建&nbsp;&nbsp;设&nbsp;&nbsp;用&nbsp;&nbsp;地</td>
    <td> <input id="jsydmianji" name="jsydmianji" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">未&nbsp;&nbsp;利&nbsp;&nbsp;用&nbsp;&nbsp;地</td>
    <td> <input id="wlydmianji" name="wlydmianji" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">建&nbsp;&nbsp;筑&nbsp;&nbsp;面&nbsp;&nbsp;积</td>
    <td> <input id="jzmianji" name="jzmianji" readonly="readonly" type="text" /></td>
    <td align="center">案&nbsp;&nbsp;件&nbsp;&nbsp;查&nbsp;&nbsp;处<br/>发&nbsp;&nbsp;现&nbsp;&nbsp;时&nbsp;&nbsp;间</td>
    <td> <input id="ajccfxsj" name="ajccfxsj" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td height="20" align="center">停工通知编号</td>
    <td> <input id="tgtzbm" name="tgtzbm" readonly="readonly" type="text" /></td>
    <td align="center">立&nbsp;&nbsp;案&nbsp;&nbsp;时&nbsp;&nbsp;间 </td>
    <td> <input id="lasj" name="lasj" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">立&nbsp;&nbsp;案&nbsp;&nbsp;编&nbsp;&nbsp;号</td>
    <td> <input id="yw_guid" name="yw_guid" readonly="readonly" type="text" /></td>
    <td align="center">处罚告知编号</td>
    <td> <input id="cfgzbh" name="cfgzbh" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">听&nbsp;&nbsp;证&nbsp;&nbsp;时&nbsp;&nbsp;间</td>
    <td> <input id="tzsj" name="tzsj" readonly="readonly" type="text" /></td>
    <td align="center">处&nbsp;&nbsp;罚&nbsp;&nbsp;时&nbsp;&nbsp;间</td>
    <td> <input id="cfsj" name="cfsj" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">听证告知编号</td>
    <td> <input id="tzgzbh" name="tzgzbh" readonly="readonly" type="text" /></td>
    <td align="center">有&nbsp;&nbsp;关&nbsp;&nbsp;部&nbsp;&nbsp;门<br/>完&nbsp;&nbsp;善&nbsp;&nbsp;手&nbsp;&nbsp;续</td>
    <td> <input id="ygbmwssx" name="ygbmwssx" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">转&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;征&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用<br/>批&nbsp;&nbsp;准&nbsp;&nbsp;文&nbsp;&nbsp;号</td>
    <td> <input id="zzypzwh" name="zzypzwh" readonly="readonly" type="text" /></td>
    <td align="center">转&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;征&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用<br/>批&nbsp;&nbsp;准&nbsp;&nbsp;时&nbsp;&nbsp;间</td>
    <td> <input id="zzypzsj" name="zzypzsj" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">供地批准文号</td>
    <td> <input id="gdpzwh" name="gdpzwh" readonly="readonly" type="text" /></td>
    <td align="center">供地批准时间</td>
    <td> <input id="gdpzsj" name="gdpzsj" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">卫&nbsp;&nbsp;片&nbsp;&nbsp;次&nbsp;&nbsp;数</td>
    <td> <input id="wpcs" name="wpcs" readonly="readonly" type="text" /></td>
    <td align="center">图&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;斑&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号</td>
    <td> <input id="tbbh" name="tbbh" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">具&nbsp;&nbsp;体&nbsp;&nbsp;建&nbsp;&nbsp;设<br/>项&nbsp;&nbsp;目&nbsp;&nbsp;名&nbsp;&nbsp;称</td>
    <td colspan="3"><input id="jtzsxmmc" name="jtzsxmmc" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td rowspan="6" align="center">移送情况</td>
    <td align="center">纪检移送时间</td>
    <td><input id="jjyssj" name="jjyssj" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">纪检移送文号</td>
    <td><input id="jjyswh" name="jjyswh" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">党&nbsp;&nbsp;纪&nbsp;&nbsp;人&nbsp;&nbsp;数</td>
    <td><input id="djry" name="djry" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">行&nbsp;&nbsp;政&nbsp;&nbsp;人&nbsp;&nbsp;数</td>
    <td><input id="xzry" name="xzry" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">公安移送时间</td>
    <td><input id="gayssj" name="gayssj" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">公安移送文号</td>
    <td><input id="gayswh" name="gayswh" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">催&nbsp;督&nbsp;办&nbsp;时&nbsp;间</td>
    <td><input id="cdbsj" name="cdbsj" readonly="readonly" type="text" /></td>
    <td align="center">催&nbsp;督&nbsp;办&nbsp;文&nbsp;号 </td>
    <td><input id="cdbwh" name="cdbwh" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">公&nbsp;&nbsp;安&nbsp;&nbsp;人&nbsp;&nbsp;数 </td>
    <td><input id="gary" name="gary" readonly="readonly" type="text" /></td>
    <td align="center">强制执行时间 </td>
    <td><input id="qzzxsj" name="qzzxsj" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">强制执行文号 </td>
    <td><input id="qzzxwh" name="qzzxwh" readonly="readonly" type="text" /></td>
    <td align="center">补&nbsp;&nbsp;办&nbsp;&nbsp;时&nbsp;&nbsp;间 </td>
    <td><input id="bbsj" name="bbsj" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">省&nbsp;&nbsp;补&nbsp;&nbsp;办&nbsp;&nbsp;局<br/>请&nbsp;&nbsp;示&nbsp;&nbsp;文&nbsp;&nbsp;号</td>
    <td><input id="sbbjqswh" name="sbbjqswh" readonly="readonly" type="text" /></td>
    <td align="center">省&nbsp;&nbsp;补&nbsp;&nbsp;办&nbsp;&nbsp;省<br/>批&nbsp;&nbsp;准&nbsp;&nbsp;文&nbsp;&nbsp;号 </td>
    <td><input id="sbbspzwh" name="sbbspzwh" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">省&nbsp;&nbsp;补&nbsp;&nbsp;办&nbsp;&nbsp;市<br/>请&nbsp;&nbsp;示&nbsp;&nbsp;文&nbsp;&nbsp;号 </td>
    <td><input id="sbbsqswh" name="sbbsqswh" readonly="readonly" type="text" /></td>
    <td align="center">市&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;补&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办<br/>批&nbsp;&nbsp;准&nbsp;&nbsp;文&nbsp;&nbsp;号 </td>
    <td><input id="shibbpzwh" name="shibbpzwh" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">市&nbsp;补&nbsp;&nbsp;办&nbsp;&nbsp;局<br/>请&nbsp;&nbsp;示&nbsp;&nbsp;文&nbsp;&nbsp;号</td>
    <td><input id="shibbjqswh" name="shibbjqswh" readonly="readonly" type="text" /></td>
    <td align="center">市&nbsp;补&nbsp;办&nbsp;征&nbsp;用<br/>土地协议文号 </td>
    <td><input id="shibbzytdxywh" name="shibbzytdxywh" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">市&nbsp;补&nbsp;办&nbsp;划&nbsp;拨<br/>土地协议文号 </td>
    <td><input id="shibbhbtdxywh" name="shibbhbtdxywh" readonly="readonly" type="text" /></td>
    <td align="center">市&nbsp;&nbsp;补&nbsp;&nbsp;办&nbsp;&nbsp;局<br/>批&nbsp;&nbsp;准&nbsp;&nbsp;文&nbsp;&nbsp;号</td>
    <td><input id="shibbjpzwh" name="shibbjpzwh" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td rowspan="4" align="center">土&nbsp;地&nbsp;证&nbsp;情&nbsp;况</td>
    <td align="center">土&nbsp;&nbsp;地&nbsp;&nbsp;证&nbsp;&nbsp;号</td>
    <td><input id="tdzh" name="tdzh" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">土地证颁发日期</td>
    <td><input id="tdzdfrq" name="tdzdfrq" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">补办土地证号 </td>
    <td><input id="bbtdzh" name="bbtdzh" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">补办土地证日期</td>
    <td><input id="bbtdzrq" name="bbtdzrq" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="21" align="center">案&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;卷&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号</td>
    <td><input id="ajh" name="ajh" readonly="readonly" type="text" /></td>
    <td align="center">序&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号 </td>
    <td><input id="xh" name="xh" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td rowspan="9" align="center">集体占有情况</td>
    <td rowspan="7" align="center">农用地</td>
    <td align="center">集&nbsp;&nbsp;体&nbsp;&nbsp;符&nbsp;&nbsp;合<br/>规&nbsp;&nbsp;划&nbsp;&nbsp;面&nbsp;&nbsp;积 </td>
    <td><input id="jtfhghmianji" name="jtfhghmianji" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">集&nbsp;&nbsp;体&nbsp;不&nbsp;符&nbsp;合<br/>规&nbsp;&nbsp;划&nbsp;&nbsp;面&nbsp;&nbsp;积 </td>
    <td><input id="jtbfhghmianji" name="jtbfhghmianji" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">集体耕地面积 </td>
    <td><input id="jygtmianji" name="jygtmianji" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">集&nbsp;&nbsp;体&nbsp;&nbsp;其&nbsp;&nbsp;中<br/>基&nbsp;&nbsp;本&nbsp;&nbsp;农&nbsp;&nbsp;田 </td>
    <td><input id="jtqzjbntmianji" name="jtqzjbntmianji" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">集&nbsp;&nbsp;体&nbsp;&nbsp;园&nbsp;&nbsp;地 </td>
    <td><input id="jtydmianji" name="jtydmianji" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">集&nbsp;&nbsp;体&nbsp;&nbsp;林&nbsp;&nbsp;地 </td>
    <td><input id=jtldmianji name="jtldmianji" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">集体其他农用地 </td>
    <td><input id="jtqtyydmianji" name="jtqtyydmianji" readonly="readonly" type="text" /></td>
  </tr>
  <tr>
    <td align="center">集体建设用地 </td>
    <td><input id="jtjsydmianji" name="jtjsydmianji" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">集体未利用地 </td>
    <td><input id="jtwlydmianji" name="jtwlydmianji" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="23" align="center">集体建筑面积 </td>
    <td><input id="jtzzmianji" name="jtzzmianji" readonly="readonly" type="text" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">法院执行种类</td>
    <td><input id="fyzxlx" name="fyzxlx" readonly="readonly" type="text" /></td>
    <td align="center">法院执行时间</td>
    <td><input id="fyzxsj" name="fyzxsj" readonly="readonly" type="text" /></td>
  </tr>
</table>
        </form>	
	</body>
</html>
	