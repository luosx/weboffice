package com.klspta.web.cbd.dtjc;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import sun.tools.jar.resources.jar;

import net.sf.jasperreports.components.barbecue.BarcodeProviders.NW7Provider;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:创建统计报表修改页面
 * <br>Description:TODO 类功能描述
 * <br>Author:黎春行
 * <br>Date:2013-10-29
 */
public class TjbbBuild {
	public static final int MIN_YEAR = 2011;
	
	/**
	 * 
	 * <br>Description:生成前台展现页面table
	 * <br>Author:黎春行
	 * <br>Date:2013-10-29
	 * @return
	 */
	public static String buildTable(){
		StringBuffer tableBuffer = new StringBuffer();
		tableBuffer.append(buildTitle());
		tableBuffer.append(buildKFTL());
		tableBuffer.append(buildGDTL());
		System.out.println("tablebuffer:" + tableBuffer.toString());
		return tableBuffer.toString();
	}
	
	
	/**
	 * 
	 * <br>Description:创建开发时序表格抬头
	 * <br>Author:黎春行
	 * <br>Date:2013-10-29
	 * @return
	 */
	private static StringBuffer buildTitle(){
		StringBuffer title = new StringBuffer();
		TjbbData tjbbData = new TjbbData();
		title.append("<thead>").append(
				"<tr  style='background: #C0C0C0; text-align: center; font: normal 18px verdana;'>");
		title.append("<td colspan='2' rowspan='2' style='border-bottom:1px #ffffff solid;' ><label>项目名称</label></td>");
		int max_year = Integer.parseInt(tjbbData.getMaxYear());
		//缓存季度行
		StringBuffer quarter = new StringBuffer();
		//添加年度行
		for(int i = MIN_YEAR; i <= max_year; i++){
			title.append("<td colspan=4 width='200'><label>").append(i).append("</label></td>");
			quarter.append("<td class='spring'><label>1</label></td>");
			quarter.append("<td class='summer'><label>2</label></td>");
			quarter.append("<td class='fall'><label>3</label></td>");
			quarter.append("<td class='winter'><label>4</label></td>");
		}
		title.append("</tr><tr>").append(quarter);
		title.append("</tr></thead>");
		return title;
	}
	
	/**
	 * 
	 * <br>Description:创建开发体量tbody
	 * <br>Author:黎春行
	 * <br>Date:2013-10-29
	 * @return
	 */
	private static StringBuffer buildKFTL(){
		StringBuffer kftlBody = new StringBuffer();
		TjbbData tjbbData = new TjbbData();
		int max_year = Integer.parseInt(tjbbData.getMaxYear());
		Map<String, Map<String, Object>> kftlPlanMap = tjbbData.getKFTLPlan();
		Set<String> kftlProjectSet = tjbbData.getKFTLProject();
		kftlBody.append("<tbody id='kftl' style='border-bottom:1px #000000 solid'>");
		Iterator<String> proIterator = kftlProjectSet.iterator();
		for(int i = 0; i < kftlProjectSet.size(); i++){
			String projectName = proIterator.next();
			if(kftlPlanMap.containsKey(projectName)){
				Map<String, Object> plan = kftlPlanMap.get(projectName);
				if(0 == i){
					kftlBody.append("<tr style='background: #E5FFE5;'><td rowspan='").append(kftlProjectSet.size()).append("' width='20px' align='center' style='background: #C0C0C0;border-bottom:1px #ffffff solid' ><label>开发体量</label></td>");
				}else{
					if(i/2 == 0){
						kftlBody.append("<tr  style='background: #FFFFE5;' >");
					}else{
						kftlBody.append("<tr  style='background: #E5FFE5;' >");
					}
				}
				kftlBody.append("<td style='background: #C0C0C0;border-bottom:1px #ffffff solid;'><label>").append(projectName).append("</label></td>");
				for(int j = MIN_YEAR; j <= max_year; j++){
					for(int t = 1; t <=4; t++){
						if(plan.containsKey(j + "##" + t)){
							kftlBody.append("<td class='yes' onMouseOver='changePlan(this, 1); return false;'' ></td>");
						}else{
							kftlBody.append("<td class='no'  onMouseOver='hiddleDiv(); return false;' onDblClick='addDetail(this); return false;'></td>");
						}
					}
				}
				kftlBody.append("</tr>");
			}else{
				continue;
			}
		}
		kftlBody.append("</tbody>");
		return kftlBody;
	}
	
	/**
	 * 
	 * <br>Description:创建开发体量tbody
	 * <br>Author:黎春行
	 * <br>Date:2013-10-29
	 * @return
	 */
	private static StringBuffer buildGDTL(){
		StringBuffer gdtlBody = new StringBuffer();
		TjbbData tjbbData = new TjbbData();
		int max_year = Integer.parseInt(tjbbData.getMaxYear());
		Map<String, Map<String, Object>> gdtlPlanMap = tjbbData.getGDTLPlan();
		Set<String> gdtlProjectSet = tjbbData.getGDTLProject();
		gdtlBody.append("<tbody id='gdtl'>");
		Iterator<String> proIterator = gdtlProjectSet.iterator();
		for(int i = 0; i < gdtlProjectSet.size(); i++){
			String projectName = proIterator.next();
			if(gdtlPlanMap.containsKey(projectName)){
				Map<String, Object> plan = gdtlPlanMap.get(projectName);
				if(0 == i){
					gdtlBody.append("<tr style='background: #E5FFE5;'><td rowspan='").append(gdtlProjectSet.size()).append("' width='20px' align='center' style='background: #C0C0C0;' ><label>供地体量</label></td>");
				}else{
					if(i/2 == 0){
						gdtlBody.append("<tr  style='background: #FFFFE5;' >");
					}else{
						gdtlBody.append("<tr  style='background: #E5FFE5;' >");
					}
				}
				gdtlBody.append("<td style='background: #C0C0C0;border-bottom:1px #ffffff solid;'><label>").append(projectName).append("</label></td>");
				for(int j = MIN_YEAR; j <= max_year; j++){
					for(int t = 1; t <=4; t++){
						if(plan.containsKey(j + "##" + t)){
							gdtlBody.append("<td class='yes' onMouseOver='changePlan(this, 1); return false;'' ></td>");
						}else{
							gdtlBody.append("<td class='no'  onMouseOver='hiddleDiv(); return false;' onDblClick='addDetail(this); return false;'></td>");
						}
					}
				}
				gdtlBody.append("</tr>");
			}else{
				continue;
			}
		}
		gdtlBody.append("</tbody>");
		return gdtlBody;
	}

}
