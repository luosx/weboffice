package com.klspta.model.dc;

import java.io.File;
import java.util.List;
import java.util.Map;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import com.klspta.base.AbstractBaseBean;

public class ExpExcelOperation extends AbstractBaseBean {
	
	public void exportClassroom(String flag){ 

		try { 
		WritableWorkbook wbook = Workbook.createWorkbook(new File("d:\\klspta\\expinfo.xls")); //建立excel文件 
		WritableSheet wsheet = wbook.createSheet("巡回督察信息表", 0); //工作表名称 
		//设置Excel字体 
		WritableFont wfont = new WritableFont(WritableFont.ARIAL, 12, 
		WritableFont.BOLD, false, 
		jxl.format.UnderlineStyle.NO_UNDERLINE, 
		jxl.format.Colour.BLACK); 
		WritableCellFormat titleFormat = new WritableCellFormat(wfont); 
		String[] title = { "编号","任务名称","坐落","坐标","用地时间","用地单位","总面积","农用地","农用地其中耕地","建设用地","未利用地","符合规划","不符合规划","占用基本农田","压盖审批面积","压盖审批比率", "压盖供地面积","压盖供地比率","审批项目名称","审批时间","供地项目名称","供地时间","建设情况","地方查处情况","违法类型","核实补录","描述","是否备案" }; 
		//设置Excel表头 
		for (int i = 0; i < title.length; i++) { 
		Label excelTitle = new Label(i, 0, title[i], titleFormat); 
		wsheet.addCell(excelTitle); 
		} 

		String sql="其他";
		if(flag.equals("0")){
		 sql="select xh,rwmc,zl,zb,to_char(ydsj,'yyyy-mm-dd') as ydsj,yddw,zl,mj,nyd,gengd,jsyd,wlyd,fhgh,bfhgh,zyjbnt,ygspmj,ygspbl,yggdmj,yggdbl,spxmmc,to_char(spsj,'yyyy-mm-dd') as spsj,gdxmmc,to_char(gdsj,'yyyy-mm-dd') as gdsj,jsqk,dfccqk,wfwglx,hcbl,bz,isbeian from DC_YDQKDCB where XH like '%XC%' and (status='1' or status='!0!1')";
		}else{
		 sql="select xh,rwmc,zl,zb,to_char(ydsj,'yyyy-mm-dd') as ydsj,yddw,zl,mj,nyd,gengd,jsyd,wlyd,fhgh,bfhgh,zyjbnt,ygspmj,ygspbl,yggdmj,yggdbl,spxmmc,to_char(spsj,'yyyy-mm-dd') as spsj,gdxmmc,to_char(gdsj,'yyyy-mm-dd') as gdsj,jsqk,dfccqk,wfwglx,hcbl,bz,isbeian from DC_YDQKDCB where XH like '%HC%' and (status='1' or status='!0!1')";	
		}
		List<Map<String,Object>> list=query(sql,YW);
		for(int i=0;i<list.size();i++){
	    Map<String,Object> map=list.get(i);
	    Label content1 = new Label(0, i+1, (String)map.get("xh"));
		Label content2 = new Label(1, i+1, (String)map.get("rwmc"));
		Label content3 = new Label(2, i+1, (String)map.get("zl")); 
		Label content4 = new Label(3, i+1, (String)map.get("zb"));
		Label content5 = new Label(4, i+1, (String)map.get("ydsj"));
		Label content6 = new Label(5, i+1, (String)map.get("yddw"));
		Label content7 = new Label(6, i+1, (String)map.get("mj"));
		Label content8 = new Label(7, i+1, (String)map.get("nyd"));
		Label content9 = new Label(8, i+1, (String)map.get("gengd"));
		Label content10 = new Label(9, i+1, (String)map.get("jsyd"));
		Label content11 = new Label(10, i+1, (String)map.get("wlyd"));
		Label content12 = new Label(11, i+1, (String)map.get("fhgh"));
		Label content13 = new Label(12, i+1, (String)map.get("bfhgh"));
		Label content14 = new Label(13, i+1, (String)map.get("zyjbnt"));
		Label content15 = new Label(14, i+1, (String)map.get("ygspmj"));
		Label content16 = new Label(15, i+1, (String)map.get("ygspbl"));
		Label content17 = new Label(16, i+1, (String)map.get("yggdmj"));
		Label content18 = new Label(17, i+1, (String)map.get("yggdbl"));
		Label content19 = new Label(18, i+1, (String)map.get("spxmmc"));
		Label content20 = new Label(19, i+1, (String)map.get("spsj"));
		Label content21 = new Label(20, i+1, (String)map.get("gdxmmc"));
		Label content22 = new Label(21, i+1, (String)map.get("gdsj"));
		String jsqk="";
		if(map.get("jsqk")!=null){
			if(((String)map.get("jsqk")).equals("PC")) jsqk="平场";
			if(((String)map.get("jsqk")).equals("ZJ")) jsqk="在建";
			if(((String)map.get("jsqk")).equals("JC")) jsqk="建成";
		}
		Label content23 = new Label(22, i+1, jsqk); 
		String dfccqk="";
		if(map.get("dfccqk")!=null){
			if(((String)map.get("dfccqk")).equals("YFCC")) dfccqk="依法查处";
			if(((String)map.get("dfccqk")).equals("WYFCC")) dfccqk="未依法查处";
		}
		Label content24 = new Label(23, i+1, dfccqk); 
		String wfwglx="";
		if(map.get("wfwglx")!=null){
			if(((String)map.get("wfwglx")).equals("FFPD")) wfwglx="非法批地";
			if(((String)map.get("wfwglx")).equals("WBJY")) wfwglx="未报即用";
			if(((String)map.get("wfwglx")).equals("BBBY")) wfwglx="边报边用";
			if(((String)map.get("wfwglx")).equals("WGXY")) wfwglx="未供先用";
			if(((String)map.get("wfwglx")).equals("WFCYZC")) wfwglx="违反产业政策";
			if(((String)map.get("wfwglx")).equals("WFZPG")) wfwglx="违法招牌挂";
			if(((String)map.get("wfwglx")).equals("BCBDW")) wfwglx="补偿不到位";
			if(((String)map.get("wfwglx")).equals("QT")) wfwglx="其它";
		}
		Label content25 = new Label(24, i+1, wfwglx); 
		String hcbl="";
		if(map.get("hcbl")!=null){
			if(((String)map.get("hcbl")).equals("PEWZ")) hcbl="批而未征";
			if(((String)map.get("hcbl")).equals("XZ")) hcbl="闲置";
			if(((String)map.get("hcbl")).equals("WFCYZC")) hcbl="违反产业政策";
			if(((String)map.get("hcbl")).equals("WFZPG")) hcbl="违反招拍挂";
			if(((String)map.get("hcbl")).equals("WFZPG")) hcbl="违反招拍挂";
			if(((String)map.get("hcbl")).equals("QT")) hcbl="其它";
		}
		Label content26 = new Label(25, i+1, hcbl); 
		Label content27 = new Label(26, i+1, (String)map.get("bz")); 
		String isbeian="";
		if(map.get("isbeian")!=null){
			if(((String)map.get("isbeian")).equals("0")) isbeian="未备案";
			if(((String)map.get("isbeian")).equals("1")) isbeian="已备案";
		}
		Label content28 = new Label(27, i+1, isbeian); 
		wsheet.addCell(content1); 
		wsheet.addCell(content2); 
		wsheet.addCell(content3); 
		wsheet.addCell(content4); 
		wsheet.addCell(content5);
		wsheet.addCell(content6);
		wsheet.addCell(content7);
		wsheet.addCell(content8);
		wsheet.addCell(content9);
		wsheet.addCell(content10);
		wsheet.addCell(content11);
		wsheet.addCell(content12);
		wsheet.addCell(content13);
		wsheet.addCell(content14);
		wsheet.addCell(content15);
		wsheet.addCell(content16);
		wsheet.addCell(content17);
		wsheet.addCell(content18);
		wsheet.addCell(content19);
		wsheet.addCell(content20);
		wsheet.addCell(content21);
		wsheet.addCell(content22);
		wsheet.addCell(content23);
		wsheet.addCell(content24);
		wsheet.addCell(content25);
		wsheet.addCell(content26);
		wsheet.addCell(content27);
		wsheet.addCell(content28);
		}

		wbook.write(); //写入文件 
		wbook.close(); 
		} catch (Exception e) { 

		} 

		} 
}
