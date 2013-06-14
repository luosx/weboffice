package com.klspta.web.xuzhouNW.lacc;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.console.role.Role;
import com.klspta.console.role.RoleManager;

public class TjfxManager extends AbstractBaseBean{

	/**
	 *根据登陆人的行政区划来构建区域的tree
	 * @author 李国明
	 * 2013-03-29
    */
	public String getQyTreeByXzqh(String userID){
		String qyTree = "";
		String xzqhNames="";
		//根据用户id得到角色列表（一个用户可能有多个角色）
	    List<Role> roleList;
		try {
			roleList = RoleManager.getInstance("NEW WITH MANAGER FACTORY!").getRoleWithUserID(userID);
	
	    //接收行政区划编码字符串（得到用户角色列表的行政区划）
		String Strxzqh = "";
		for(int i=0;i<roleList.size();i++){
			Strxzqh = Strxzqh + roleList.get(i).getXzqh() + ",";
		}
		String[] xzqh_array = Strxzqh.split(",");
		//处理行政区划时的标志位（默认是xian）
		String flag = "xian";
		//用于去掉数组中可能存在的重复的行政区划编码
		HashSet<String> hs = new HashSet<String>();
		for(int j=0;j<xzqh_array.length;j++){
			if(xzqh_array[j].equals("320300")){//如果这个用户的角色的行政区划编码有370100（济南）则将标志位修改
				flag = "xuzhou";
			}
			//将数组中的数据放到set中去掉重复项
			hs.add(xzqh_array[j]);
		}

		if(flag.equals("xian")){
			 xzqhNames = "";//UtilFactory.getXzqhUtil().getXzqhNamesByCodes(hs);
			 String xzqhArray[]=xzqhNames.split(",");
			 StringBuffer sbuff = new StringBuffer();
			 sbuff.append("[{text:'本辖区',src:'sxq',checked:false,leaf:0,id:'3203',children:[");
			 int n=0;
			 for (int i = 0; i < xzqhArray.length; i++) {
				 if(n>0){
					 sbuff.append(",");
				 }
				 sbuff.append("{text:'"+xzqhArray[i]+"',checked:false,leaf:1,id:'3203"+(i+1)+"',parentId:'3203'}");
				 n++;
			}
			 sbuff.append("]}]");
			 qyTree=sbuff.toString();
		}
		if(flag.equals("xuzhou")){
			qyTree="[{text:'徐州市',src:'sxq',checked:false,leaf:0,id:'3200',"+
							 "children:["+
							  // "{text:'市本级',checked:false,leaf:0,id:'3203',parentId:'3200',"+
							   // "  children:["+
								//"	{text:'市辖区',checked:false,leaf:1,id:'320301',parentId:'3200'},"+
								"	{text:'鼓楼区',checked:false,leaf:1,id:'320302',parentId:'3200'},"+
								"	{text:'云龙区',checked:false,leaf:1,id:'320303',parentId:'3200'},"+
								"	{text:'泉山区',checked:false,leaf:1,id:'320311',parentId:'3200'},"+
								"	{text:'开发区',checked:false,leaf:1,id:'320313',parentId:'3200'},"+
								"	{text:'新城区',checked:false,leaf:1,id:'320314',parentId:'3200'}"+
								//"	{text:'长清区',checked:false,leaf:1,id:'370113',parentId:'3203'}"+
								//"]}"+
								//"{text:'县市',checked:false,leaf:0,id:'3204',parentId:'3200',"+
							 	// " children:["+
								//	"{text:'丰县',checked:false,leaf:1,id:'320321',parentId:'3204'},"+
								//	"{text:'沛县',checked:false,leaf:1,id:'320322',parentId:'3204'},"+
								//	"{text:'睢宁县',checked:false,leaf:1,id:'320324',parentId:'3204'},"+
								//	"{text:'新沂市',checked:false,leaf:1,id:'320381',parentId:'3204'},"+
								//	"{text:'邳州市',checked:false,leaf:1,id:'320382',parentId:'3204'}"+
							//"	]}"+
							"]}]";		
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return qyTree;
	}
	private int[] days={31,28,31,30,31,30,31,31,30,31,30,31};
	public void getResult(){
		String treeList=UtilFactory.getStrUtil().unescape(request.getParameter("treeList"));
		//前台传入的时间格式：2000-10
		String beginDate=request.getParameter("beginDate");
		String endDate=request.getParameter("endDate");
		String[] endDt = null;
		String[] startDt = null;
		beginDate=beginDate+"-1";
		if(!"".equals(beginDate)){
			if("".equals(endDate)){
//				endDate=beginDate;
			}else{
				endDt=endDate.split("-");
				startDt = beginDate.split("-");
				if(endDt.length==2){
					int month=Integer.parseInt(endDt[1]);
					if(month==2){
						int year=Integer.parseInt(endDt[0]);
						if((year%4==0 && year%100!=0)||year%400==0){
							endDate+="-29";
						}else{
							endDate+="-28";
						}
					}else{
						month--;
						endDate=endDate+"-"+days[month];
					}
				}
			}
		}
		String[]xzqs=treeList.split(",");
		String where = " where  ";
		if(xzqs.length>1){
			where += "(";
		   for(int i=0;i<xzqs.length-1;i++){
			  where += "  t.qy= '" + xzqs[i]+"' or ";
		   }
		   where += " t.qy= '" + xzqs[xzqs.length-1]+"')";
		}else {
			where += " t.qy= '" + xzqs[0]+ "' ";
		}
		where += " and (to_char(t.sjfgjzrq,'yyyy-MM-dd') between '"+beginDate+"' and '"+endDate+"') ";
		StringBuffer columStr=new StringBuffer();
		StringBuffer dataStr=new StringBuffer();
		columStr.append("<table border='1' cellspacing='0' cellpadding='0' width='1880'  ");
		columStr.append("<tr >");	
		columStr.append("<td height='38' colspan='32' style='font-size:30px'>");
		  		    
		if(startDt[0].equals(endDt[0])){
			columStr.append("<strong>徐州市"+ startDt[0]+"年度"+startDt[1]+"月——"+endDt[1]+"月国土资源违法案件登记表</strong>");
		}else {
			columStr.append("<strong>徐州市"+ startDt[0]+"年度"+startDt[1]+"月——"+endDt[0]+"年度"+endDt[1]+"月国土资源违法案件登记表</strong>");
		}
		columStr.append("</td></tr>");
		columStr.append("<tr > <td rowspan='3'>序号</td><td rowspan='3'>违法主体</td><td rowspan='3'>所在区/坐落</td>" +
				"<td rowspan='3'>面积(亩)</td><td rowspan='3'>用途</td><td rowspan='3'>案件来源</td><td colspan='5'>受理和立案</td>" +
				"<td colspan='8'>处罚和执行</td><td colspan='8'>移送和移交</td><td colspan='2'>结案</td>" +
				"<td rowspan='3'>未立案(结案)原因</td><td rowspan='3'>区域监管责任人</td><td rowspan='3'>备注</td></tr>");
		
		columStr.append("<tr ><td rowspan='2'>案源登记日期</td><td colspan='2'>责令停止(改正)违法行为通知书</td>" +
				"<td colspan='2'>立案</td><td colspan='2'>听证告知书</td><td colspan='2'>处罚告知书</td><td colspan='2'>处罚决定书</td>" +
				"<td colspan='2'>责令履行法定义务通知书</td><td colspan='2'>党政纪处分建议书(纪检、监察部门)</td>" +
				"<td colspan='2'>涉嫌犯罪案件移送书(公安、检查机关)</td><td colspan='2'>强制执行申请书(法院)</td>" +
				"<td colspan='2'>非法财物移交书(国资、财政部门)</td><td colspan='2'>结案呈批表</td></tr>");
		
		columStr.append("<tr ><td>编号</td><td>下达日期</td><td>编号</td><td>批准日期</td><td>编号</td><td>下达日期</td><td>编号</td><td>下达日期</td>" +
				"<td>编号</td><td>下达日期</td><td>编号</td><td>下达日期</td><td>编号</td><td>移送日期</td><td>编号</td><td>移送日期</td><td>编号</td><td>移送日期</td>" +
				"<td>编号</td><td>移送日期</td><td>编号</td><td>结案日期</td></tr>");
		String sql = "select t.qy as szqy,t.yw_guid,t.ajly,t.bh as labh,to_char(t.sjfgjzrq,'yyyy-MM-dd') as larq,c.zdmjhj as mj,c.sjyt as yt from lacpb t left join cfjdzysx c on t.yw_guid = c.yw_guid";
		sql +=  where ;
		String tzgzsSQL = "select t.file_bh as tzgzsbh from atta_accessory t where t.yw_guid = ? and t.file_name like '%听证告知书%'";
		String cfgzsSQL = "select t.file_bh as cfgzsbh from atta_accessory t where t.yw_guid = ? and t.file_name like '%处罚告知书%'";
		List rows = new ArrayList();
		List<Map<String,Object>> list1 = query(sql, YW);
		
		if(list1.size()>0){
			int size =list1.size();
			for(int i = 0 ; i<size ;i++){
				List<Map<String,Object>> tzgzslist = query(tzgzsSQL, CORE,new Object[]{list1.get(i).get("yw_guid")});
				List<Map<String,Object>> cfgzslist = query(cfgzsSQL, CORE,new Object[]{list1.get(i).get("yw_guid")});
				columStr.append("<tr class='trtd'>");
				columStr.append("<td>"+(i+1)+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("szqy")==null?"&nbsp":list1.get(i).get("szqy"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("MJ")==null?"&nbsp":list1.get(i).get("MJ"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("YT")==null?"&nbsp":list1.get(i).get("YT"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("AJLY")==null?"&nbsp":list1.get(i).get("AJLY"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("AYDJRQ")==null?"&nbsp":list1.get(i).get("AYDJRQ"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("TZWFTZSBH")==null?"&nbsp":list1.get(i).get("TZWFTZSBH"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("TZWFTZSXDRQ")==null?"&nbsp":list1.get(i).get("TZWFTZSXDRQ"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("labh")==null?"&nbsp":list1.get(i).get("labh"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("larq")==null?"&nbsp":list1.get(i).get("larq"))+"</td>");
				if(tzgzslist.size()>0){
					columStr.append("<td>"+(tzgzslist.get(0).get("tzgzsbh")==null?"&nbsp":tzgzslist.get(0).get("tzgzsbh"))+"</td>");
				}else {
					columStr.append("<td>&nbsp</td>");
				}
				columStr.append("<td>"+(list1.get(i).get("TZGZSXDRQ")==null?"&nbsp":list1.get(i).get("TZGZSXDRQ"))+"</td>");
				if(cfgzslist.size()>0){
					columStr.append("<td>"+(cfgzslist.get(0).get("cfgzsbh")==null?"&nbsp":cfgzslist.get(0).get("cfgzsbh"))+"</td>");
				}else {
					columStr.append("<td>&nbsp</td>");
				}
				columStr.append("<td>"+(list1.get(i).get("CFGZSXDRQ")==null?"&nbsp":list1.get(i).get("CFGZSXDRQ"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("<td>"+(list1.get(i).get("wfzt")==null?"&nbsp":list1.get(i).get("wfzt"))+"</td>");
				columStr.append("</tr>");
			}
		}
		columStr.append("</table>");		
		String column = columStr.toString();
		response(column);
		
	}
}
