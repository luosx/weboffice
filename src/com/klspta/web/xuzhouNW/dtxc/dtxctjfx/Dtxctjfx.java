package com.klspta.web.xuzhouNW.dtxc.dtxctjfx;


import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;

import jxl.CellView;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:动态巡查管理类
 * <br>Description:实现动态巡查统计功能
 * <br>Author:黎春行
 * <br>Date:2013-4-10
 */
public class Dtxctjfx extends AbstractBaseBean{
	
	private ByteArrayOutputStream  responseStream;
	private String title = "";
	private String[] columns = new String[]{"xcr","xcs", "xcdd", "xcsj", "null", "null", "jsdw", "jsxm", "jsqk", "zmj", "null", "gdwh", "tdzbh", "pzwh", "null", "null"};
	/**
	 * 
	 * <br>Description:返回前台Excel附件
	 * <br>Author:黎春行
	 * <br>Date:2013-4-10
	 * @throws Exception
	 */
	public void getExcel() throws Exception{
		request.setCharacterEncoding("UTF-8");
		String treeList = new String(request.getParameter("area").getBytes("iso-8859-1"), "utf-8");
		String[] treeArray = treeList.split(",");
		String beginDate = request.getParameter("beginDate");
		String endDate = request.getParameter("endDate");
		
		//时间处理
		String[] beginDates;
		if(!"".equals(beginDate))
		{	
			beginDates=beginDate.split("-");
			title="徐州市"+beginDates[0] + "年度" + beginDates[1]+ "月--" +endDate.split("-")[1]+"月国土资源动态巡查台账";
		}
		
		ServletOutputStream out = response.getOutputStream();
		buildExcel(treeArray, beginDate, endDate);
		if(responseStream != null){
			String fileName = "巡查成果汇总";
			fileName = new String(fileName.getBytes(), "ISO-8859-1");
			response.setContentType("application/x-msdownload");
			response.setHeader("Content-Disposition", "attachment;filename=" + fileName+ ".xls");
			out.write(responseStream.toByteArray());
		}else{
			response("error");
		}
	}
	
	public void getResult() throws Exception{
		//request.setCharacterEncoding("UTF-8");
		//String treeList = new String(request.getParameter("area").getBytes("iso-8859-1"), "utf-8");
		String treeList = java.net.URLDecoder.decode(request.getParameter("area"), "UTF-8"); 
		treeList = treeList.replaceAll("\"", "");
		String[] treeArray = treeList.split(",");
		String beginDate = request.getParameter("beginDate");
		String endDate = request.getParameter("endDate");
		//时间处理
		String[] beginDates;
		if(!"".equals(beginDate))
		{	
			beginDates=beginDate.split("-");
			title="徐州市"+beginDates[0] + "年度" + beginDates[1]+ "月--" +endDate.split("-")[1]+"月国土资源动态巡查台账";
		}
		String responseTable = buildTable(treeArray, beginDate, endDate);
		response(responseTable);
	}
	
	/**
	 * 
	 * <br>Description:创建Excel,根据模板（xcrz.xls）创建表格，并写入responseStream
	 * <br>Author:黎春行
	 * <br>Date:2013-4-10
	 * @param treeArray
	 * @param beginDate
	 * @param endDate
	 */
	private void buildExcel(String[] treeArray, String beginDate, String endDate){
		String path = this.getClass().getResource("").getPath();
		InputStream input;
		try {
			input = new BufferedInputStream(new FileInputStream(path + "xcrz.xls"));
			HSSFWorkbook excel = new HSSFWorkbook(input);
			HSSFSheet sheet = excel.getSheetAt(0);
			HSSFRow row;
			HSSFCell cell;
			HSSFCellStyle style = excel.createCellStyle();
			HSSFFont font = excel.createFont();
			
			style.setFont(font);
			style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderRight(HSSFCellStyle.BORDER_THIN);
			
			CellView cView = new CellView();
			cView.setAutosize(true);
	
			//2012年1—9月违法用地台账	
			row=sheet.getRow(0);
			cell=row.getCell(0);
			cell.setCellValue(title);
			
			int length = columns.length;
			int index = 5;
			int sequence = 1;
			List<Map<String, Object>> queryList = getList(treeArray, beginDate, endDate);
			for(Map<String, Object> map : queryList){
				row = sheet.createRow(index);
				cell = row.createCell(0);
				cell.setCellStyle(style);
				cell.setCellValue(sequence++);
				for(int i = 1; i <= length; i++){
					cell = row.createCell(i);
					cell.setCellStyle(style);
					String name = columns[i-1];
					if(!"null".equals(name)){
						cell.setCellValue((String)map.get(name));
					}
				}
				index++;
			}
			responseStream = new ByteArrayOutputStream();
			excel.write(responseStream);
			responseStream.close();
			input.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private String buildTable(String[] treeArray, String beginDate, String endDate){
		List<Map<String, Object>> queryList = getList(treeArray, beginDate, endDate);
		StringBuffer columnStr = new StringBuffer();
		columnStr.append("<table cellpadding=0 cellspacing=0 align='center' style='border-collapse:collapse;table-layout:fixed;'>");
		columnStr.append("<tr height=18 style='height:13.5pt'>");
		columnStr.append("<td colspan='15' align='center' style=\"font-family:'宋体'; font-size:18px\">");
		columnStr.append(title);
		columnStr.append("</td></tr>");
		String[][] widthsrow = new String[][]{new String[]{"style1", "2", "null", "null", "序号"},new String[]{"style2", "2", "null", "null", "巡查人员"},new String[]{"style2", "2", "null", "null", "巡查单位"},new String[]{"style2", "2", "null", "null", "巡查区域"},new String[]{"style2", "2", "null", "null", "巡查时间"},
				new String[]{"style3", "null", "7", "center", "巡查发现的基本情况"},new String[]{"style4", "null", "3", "center", "批准文件"}, new String[]{"style5", "2", "null", "null", "现场处理情况"},new String[]{"style5", "2", "null", "null","备注说明"}}; 
		columnStr.append("<tr>");
		for(int i = 0; i < widthsrow.length; i++){
			String[] style = widthsrow[i]; 
			columnStr.append("<td ");
			if(!"null".equals(style[0])){
				columnStr.append("class='");
				columnStr.append(style[0]);
				columnStr.append("'");
			}
			if(!"null".equals(style[1])){
				columnStr.append("rowspan='");
				columnStr.append(style[1]);
				columnStr.append("'");
			}
			if(!"null".equals(style[2])){
				columnStr.append("colspan='");
				columnStr.append(style[2]);
				columnStr.append("'");
			}
			if(!"null".equals(style[3])){
				columnStr.append("align='");
				columnStr.append(style[3]);
				columnStr.append("'");
			}
			columnStr.append(">" + style[4] + "</td>");
		}
		String[] widthsRow2 = new String[]{"违法类型", "占地位置", "建设单位(个人)","建设项目","建设情况","占地面积(平方米)","动工时间", "供地文号", "土地证编号","批准文号"};
		columnStr.append("<tr>");
		for(int i = 0; i < widthsRow2.length; i++){
			columnStr.append("<td class=\"style6\"> " + widthsRow2[i] + "</td>");
		}
		columnStr.append("</tr>");
		int length = columns.length;
		int sequence = 1;
		for(Map<String, Object> map : queryList){
			columnStr.append(" <tr height=18 style='height:13.5pt'>");
			columnStr.append("<td style='border-top:none;border-left:none'>");
			columnStr.append(sequence++);
			columnStr.append("<td>");
			for(int i = 1; i <= length; i++){
				String name = columns[i-1];
				columnStr.append("<td height=18 class=xl6516651 style='height:13.5pt;border-top:none'>");
				if(!"null".equals(name)){
					columnStr.append("<td class=xl6516651 style='border-top:none;border-left:none'>");
					columnStr.append((String)map.get(name));
					columnStr.append("<td>");
				}else{
					columnStr.append("<td class=xl6516651 style='border-top:none;border-left:none'>");
					columnStr.append("<td>");
				}
			}
			columnStr.append("</tr>");
		}
		columnStr.append("</table>");
		return columnStr.toString();
	}
	
	private List<Map<String, Object>> getList(String[] treeArray, String beginDate, String endDate){
		//String sql = "select * from PAD_XCXCQKB t where ";
		StringBuffer sql = new StringBuffer();
		sql.append("select * from PAD_XCXCQKB t where (to_date(t.xcsj,'yyyy-mm-dd hh24:mi:ss') between ");
		sql.append("to_date('" + beginDate + "-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')");
		sql.append(" and ");
		sql.append("to_date('" + endDate + "-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')" );
		sql.append(") and ( t.xcs in (");
		for(int i = 0; i < treeArray.length - 1; i++){
			sql.append("'" + treeArray[i] + "',");
		}
		sql.append("'" + treeArray[treeArray.length - 1] + "'))");
		List<Map<String, Object>> resultList = query(sql.toString(), YW);
		return resultList;
	}
	
	
	
}
