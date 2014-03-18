package com.klspta.web.cbd.zcgl.tdzcgl;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.model.CBDReport.CBDReportManager;
import com.klspta.model.CBDReport.tablestyle.ITableStyle;
import com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow;

/**
 * 
 * <br>
 * Title:TODO 类标题 <br>
 * Description:TODO 类功能描述 <br>
 * Author:黎春行 <br>
 * Date:2014-1-19
 */
public class TdzcglManager extends AbstractBaseBean {
	private String[][] fields = { { "dkmc", "false", "null" },
			{ "jsydmj", "false", "sum" }, { "rjl", "false", "avg" },
			{ "ghjzgm", "false", "sum" }, { "jzkzgd", "false", "avg" },
			{ "DJZJ", "false", "sum" }, { "DJYJLY", "false", "sum" },
			{ "DJYJLB", "false", "null" }, { "ZFSYZE", "false", "sum" },
			{ "ZFSYYJLY", "false", "sum" }, { "ZFSYYJLB", "false", "sum" },
			{ "ZFSYHTYD", "false", "null" }, { "ZFSYWYJ", "false", "sum" },
			{ "BCFZE", "false", "sum" }, { "BCFYJLY", "false", "sum" },
			{ "BCFYJLB", "false", "null" }, { "BCFHTYD", "false", "null" },
			{ "BCFYCSWY", "false", "sum" }, { "DJKJLSJ", "false", "null" },
			{ "CBZH", "false", "null" }, { "ZCMJ", "false", "sum" },
			{ "CRSJ", "false", "null" }, { "ZBR", "false", "null" },
			{ "JDSJ", "false", "null" }, { "YJSJ", "false", "null" },
			{ "KGSJ", "false", "null" }, { "TDXZSJ", "false", "null" },
			{ "YT", "false", "null" }, { "SFYL", "false", "null" },
			{ "DGDW", "false", "null" }, { "SX", "false", "null" },
			{ "bz", "false", "null" } };

	private static TdzcglManager tdzcglManager;

    public static TdzcglManager getInstcne() {
        if (tdzcglManager == null) {
        	tdzcglManager = new TdzcglManager();
        }
        return tdzcglManager;
    }
	/**
	 * 
	 * <br>
	 * Description:TODO 方法功能描述 <br>
	 * Author:黎春行 <br>
	 * Date:2014-1-19
	 * 
	 * @throws Exception
	 */

	/**
	 * public void add() throws Exception{ String xmmc = new
	 * String(request.getParameter("xmmc").getBytes("iso-8859-1"),"utf-8");
	 * String dkmc = new
	 * String(request.getParameter("dkmc").getBytes("iso-8859-1"),"utf-8");
	 * String status = new
	 * String(request.getParameter("status").getBytes("iso-8859-1"),"utf-8");
	 * TdzcglData tdzcglData = new TdzcglData(); boolean result =
	 * tdzcglData.insertXMMC(xmmc, dkmc, status); response("{success:true}"); }
	 * 
	 * public void update() throws Exception{ String dkmc =new
	 * String(request.getParameter("key").getBytes("iso-8859-1"), "UTF-8");
	 * String index = request.getParameter("vindex"); String value = new
	 * String(request.getParameter("value").getBytes("iso-8859-1"), "UTF-8");
	 * String field = fields[Integer.parseInt(index)][0]; TdzcglData tdzcglData =
	 * new TdzcglData(); boolean result = tdzcglData.update(dkmc, field, value);
	 * response("{success:true}"); }
	 */

	public void add() throws Exception {
		String xmmc = request.getParameter("xmmc");
		String dkmc = request.getParameter("dkmc");
		String status = request.getParameter("status");
		String ydxz = request.getParameter("ydxz");
		String jsydmj = request.getParameter("jsydmj");
		String rjl = request.getParameter("rjl");
		String ghjzgm = request.getParameter("ghjzgm");
		String jzkzgd = request.getParameter("jzkzgd");
		String djkzj = request.getParameter("djkzj");
		String djkyjn = request.getParameter("djkyjn");
		String djkyjnbl = request.getParameter("djkyjnbl");
		String zfsyze = request.getParameter("zfsyze");
		String zfsyyjn = request.getParameter("zfsyyjn");
		String zfsyyjnbl = request.getParameter("zfsyyjnbl");
		String zfsyydjnsj = request.getParameter("zfsyydjnsj");
		String zfsywyj = request.getParameter("zfsywyj");
		String bcfze = request.getParameter("bcfze");
		String bcfyjn = request.getParameter("bcfyjn");
		String bcfyjnbl = request.getParameter("bcfyjnbl");
		String bcfydjnsj = request.getParameter("bcfydjnsj");
		String bcfwyj = request.getParameter("bcfwyj");
		String djkjnsj = request.getParameter("djkjnsj");
		String cbzh = request.getParameter("cbzh");
		String zzmj = request.getParameter("zzmj");
		String crsj = request.getParameter("crsj");
		String zbr = request.getParameter("zbr");
		String xyydjdsj = request.getParameter("xyydjdsj");
		String tdyjsj = request.getParameter("tdyjsj");
		String xmkgsj = request.getParameter("xmkgsj");
		String tdxzsj = request.getParameter("tdxzsj");
		String yt = request.getParameter("yt");
		String sfyl = request.getParameter("sfyl");
		String dgdw = request.getParameter("dgdw");
		String sx = request.getParameter("sx");
		String bz = request.getParameter("bz");
		String sql = "select t.xmmc as xmmc ,t.dkmc as dkmc from ZCGL_TDZCGL t where t.xmmc=? and t.dkmc=?";

		List<Map<String, Object>> list = query(sql, YW, new Object[] { xmmc,
				dkmc });
		if (list.size() == 0) {
			sql = "insert into ZCGL_TDZCGL(xmmc,thirsta,dkmc,djzj,"
					+ "djyjly,djyjlb,zfsyze,zfsyyjly,zfsyyjlb,zfsyhtyd,zfsywyj,bcfze,bcfyjly,bcfyjlb,"
					+ "bcfhtyd,bcfycswy,djkjlsj,cbzh,zcmj,crsj,zbr,jdsj,yjsj,kgsj,tdxzsj,yt,sfyl,dgdw,sx,bz)"
					+ " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			update(sql, YW, new Object[] { xmmc, status, dkmc, djkzj, djkyjn,
					djkyjnbl, zfsyze, zfsyyjn, zfsyyjnbl, zfsyydjnsj, zfsywyj,
					bcfze, bcfyjn, bcfyjnbl, bcfydjnsj, bcfwyj, djkjnsj, cbzh,
					zzmj, crsj, zbr, xyydjdsj, tdyjsj, xmkgsj, tdxzsj, yt,
					sfyl, dgdw, sx, bz });
		} else {
			sql = "update ZCGL_TDZCGL set thirsta=?,djzj=?,"
					+ "djyjly=?,djyjlb=?,zfsyze=?,zfsyyjly=?,zfsyyjlb=?,zfsyhtyd=?,zfsywyj=?,bcfze=?,bcfyjly=?,bcfyjlb=?,"
					+ "bcfhtyd=?,bcfycswy=?,djkjlsj=?,cbzh=?,zcmj=?,crsj=?,zbr=?,jdsj=?,yjsj=?,kgsj=?,tdxzsj=?"
					+ ",yt=?,sfyl=?,dgdw=?,sx=?,bz=? where xmmc=? and dkmc=?";
			update(sql, YW, new Object[] { status, djkzj, djkyjn, djkyjnbl,
					zfsyze, zfsyyjn, zfsyyjnbl, zfsyydjnsj, zfsywyj, bcfze,
					bcfyjn, bcfyjnbl, bcfydjnsj, bcfwyj, djkjnsj, cbzh, zzmj,
					crsj, zbr, xyydjdsj, tdyjsj, xmkgsj, tdxzsj, yt, sfyl,
					dgdw, sx, bz, xmmc, dkmc });
		}
		response("{success:true}");
	}

	public void getGHSJByDKMC() {
		String dkmc = request.getParameter("dkmc");
		String sql = "select * from dcsjk_kgzb where dkmc = ?";
		List<Map<String, Object>> list = query(sql, YW, new Object[] { dkmc });
		response(list);
	}

	public void deleteByDKMC() {
		try {
			String dkmc = request.getParameter("dkmc");
			dkmc = UtilFactory.getStrUtil().unescape(dkmc);
			String sql = "delete from ZCGL_TDZCGL where dkmc=?";
			update(sql, YW, new Object[] { dkmc });
			response("{success:true}");
		} catch (Exception e) {
			response("{success:false}");
		}

	}
	
	
	private Object checkNull(Object obj){
		if(obj==null){
			return 0;
		}
		return obj;
	}	
	public void query() throws Exception{
		String xmmcs = UtilFactory.getStrUtil().unescape(request.getParameter("xmmc"));
		ITableStyle its = new TableStyleEditRow();
		response(new CBDReportManager().getReport("TDZCGL",new Object[]{xmmcs},its).toString());
	}
	public String getGzfqqkhzbList() {
        String sql = "select  t.zd,t.jsyd,t.jzgm,t.kfcb,t.ssqy  from jc_jiben t ";
        List<Map<String, Object>> list = query(sql, YW);
        
        double zd1 = 0 ;
        double zd2 = 0 ;
        double zd3 = 0;
        double zd4 = 0;
        
        double jsyd1 = 0;
        double jsyd2 = 0;
        double jsyd3 = 0;
        double jsyd4 = 0;
        
        double jzgm1 = 0;
        double jzgm2 = 0;
        double jzgm3 = 0;
        double jzgm4 = 0;
        
        double kfcb1 = 0;
        double kfcb2 = 0;
        double kfcb3 = 0;
        double kfcb4 = 0;
        
        
        double lmbbd1 = 0;
        double lmbbd2 = 0;
        double lmbbd3 = 0;
        double lmbbd4 = 0;
        DecimalFormat a = new DecimalFormat("#.00");
        for(int num=0;num<list.size();num++){
			Map<String, Object> map = list.get(num);
			String ssqy =String.valueOf(map.get("ssqy"));
			if(ssqy.equals("产业功能改造区")){
				zd1 += Double.valueOf(a.format(Double.valueOf(String.valueOf( checkNull(map.get("zd"))))));
				jsyd1 += Double.valueOf(a.format(Double.valueOf(String.valueOf(  checkNull(map.get("jsyd"))))));
				jzgm1 += Double.valueOf(a.format(Double.valueOf(String.valueOf( checkNull( map.get("jzgm"))))));
				kfcb1 += Double.valueOf(a.format(Double.valueOf(String.valueOf(  checkNull(map.get("kfcb"))))));
			}else if(ssqy.equals("民生改善区")){
				zd2 += Double.valueOf(a.format(Double.valueOf(String.valueOf(  checkNull(map.get("zd"))))));
				jsyd2 +=Double.valueOf(a.format( Double.valueOf(String.valueOf( checkNull( map.get("jsyd"))))));
				jzgm2 += Double.valueOf(a.format(Double.valueOf(String.valueOf(  checkNull(map.get("jzgm"))))));
				kfcb2 += Double.valueOf(a.format(Double.valueOf(String.valueOf(  checkNull(map.get("kfcb"))))));
			}else if(ssqy.equals("城市形象提升区")){
				zd3 +=Double.valueOf(a.format( Double.valueOf(String.valueOf(  checkNull(map.get("zd"))))));
				jsyd3 += Double.valueOf(a.format(Double.valueOf(String.valueOf(  checkNull(map.get("jsyd"))))));
				jzgm3 += Double.valueOf(a.format(Double.valueOf(String.valueOf( checkNull( map.get("jzgm"))))));
				kfcb3 += Double.valueOf(a.format(Double.valueOf(String.valueOf(  checkNull(map.get("kfcb"))))));
			}else if(ssqy.equals("保留微调区")){
				zd4 += Double.valueOf(a.format(Double.valueOf(String.valueOf( checkNull( map.get("zd"))))));
				jsyd4 += Double.valueOf(a.format(Double.valueOf(String.valueOf( checkNull( map.get("jsyd"))))));
				jzgm4 += Double.valueOf(a.format(Double.valueOf(String.valueOf( checkNull( map.get("jzgm"))))));
				kfcb4 +=Double.valueOf(a.format( Double.valueOf(String.valueOf( checkNull( map.get("kfcb"))))));
			}
        }
        
        String getbbd ="select t.hsq from sys_parameter t ";
        List<Map<String, Object>> list0 = query(getbbd, YW);
        int hsq =Integer.valueOf(String.valueOf( checkNull(list0.get(0).get("hsq"))));
        
        int lmcb = 0;
        lmcb =((int) (jzgm1!=0?(kfcb1/jzgm1):0))/1000*1000;
        String sql1 ="select t.bbd from bbdfxjg t where t.lmcb = '"+lmcb+"' and t.tzhsq = '"+hsq+"'";
        List<Map<String, Object>> list1 = query(sql1, YW);
        lmbbd1 =Double.valueOf(a.format(Double.valueOf(String.valueOf( checkNull( list1.get(0).get("bbd"))))));
        
        lmcb =((int) (jzgm2!=0?(kfcb2/jzgm2):0))/1000*1000;
        String sql2 ="select t.bbd from bbdfxjg t where t.lmcb = '"+lmcb+"' and t.tzhsq = '"+hsq+"'";
        List<Map<String, Object>> list2 = query(sql2, YW);
        lmbbd2 =Double.valueOf(a.format(Double.valueOf(String.valueOf( checkNull( list2.get(0).get("bbd"))))));
        
        lmcb =((int) (jzgm3!=0?(kfcb3/jzgm3):0))/1000*1000;
        String sql3 ="select t.bbd from bbdfxjg t where t.lmcb = '"+lmcb+"' and t.tzhsq = '"+hsq+"'";
        List<Map<String, Object>> list3 = query(sql3, YW);
        lmbbd3 =Double.valueOf(a.format(Double.valueOf(String.valueOf( checkNull( list3.get(0).get("bbd"))))));
        
        lmcb =((int) (jzgm4!=0?(kfcb4/jzgm4):0))/1000*1000;
        String sql4 ="select t.bbd from bbdfxjg t where t.lmcb = '"+lmcb+"' and t.tzhsq = '"+hsq+"'";
        List<Map<String, Object>> list4 = query(sql4, YW);
        lmbbd4 =Double.valueOf(a.format(Double.valueOf(String.valueOf( checkNull( list4.get(0).get("bbd"))))));
        
        StringBuffer result = new StringBuffer(
        	"<table id='SWQFZXZJCJQKB' width='900' border='1' cellpadding='1' cellspacing='0'>"
			+"<tr class='tr01' >"
				+"<td id='0_0' height='10' width='50' class='tr01'>序号</td>"
				+"<td id='0_1' height='10' width='150' class='tr01'>类型</td>"
				+"<td id='0_2' height='10' width='100' class='tr01'>占地<br/>（公顷）</td>"
				+"<td id='0_3' height='10' width='100' class='tr01'>建设用地<br/>（公顷）</td>"
				+"<td id='0_4' height='10' width='100' class='tr01'>建筑规模<br/>（万㎡）</td>"
				+"<td id='0_5' height='10' width='100' class='tr01'>开发成本<br/>（亿元）</td>"
				+"<td id='0_6' height='10' width='150' class='tr01'>楼面成本<br/>（万元/㎡）</td>"
				+"<td id='0_7' height='10' width='150' class='tr01'>租金保本点<br/>（元/㎡·日）</td>"
			+"</tr>"
			+"<tr class='tr02' >"
				+"<td id='1_0' height='10' width='50' class='tr02'>1</td>"
				+"<td id='1_1' height='10' width='150' class='tr02'>产业功能改造区</td>"
				+"<td id='1_2' height='10' width='100' class='tr02'>"+Double.valueOf(a.format(zd1/1000))+"</td>"
				+"<td id='1_3' height='10' width='100' class='tr02'>"+jsyd1+"</td>"
				+"<td id='1_4' height='10' width='100' class='tr02'>"+jzgm1+"</td>"
				+"<td id='1_5' height='10' width='100' class='tr02'>"+kfcb1+"</td>"
				+"<td id='1_6' height='10' width='150' class='tr02'>"+Double.valueOf(a.format((jzgm1!=0?(kfcb1/jzgm1):0)))+"</td>"
				+"<td id='1_7' height='10' width='150' class='tr02'>"+lmbbd1+"</td>"
			+"</tr>"
			+"<tr class='tr02' >"
				+"<td id='2_0' height='10' width='50' class='tr02'>2</td>"
				+"<td id='2_1' height='10' width='150' class='tr02'>民生改造区</td>"
				+"<td id='2_2' height='10' width='100' class='tr02'>"+Double.valueOf(a.format(zd2/1000))+"</td>"
				+"<td id='2_3' height='10' width='100' class='tr02'>"+jsyd2+"</td>"
				+"<td id='2_4' height='10' width='100' class='tr02'>"+jzgm2+"</td>"
				+"<td id='2_5' height='10' width='100' class='tr02'>"+kfcb2+"</td>"
				+"<td id='2_6' height='10' width='150' class='tr02'>"+Double.valueOf(a.format((jzgm2!=0?(kfcb2/jzgm2):0)))+"</td>"
				+"<td id='2_7' height='10' width='150' class='tr02'>"+lmbbd2+"</td>"
			+"</tr>"
			+"<tr class='tr02' >"
				+"<td id='3_0' height='10' width='50' class='tr02'>3</td>"
				+"<td id='3_1' height='10' width='150' class='tr02'>城市形象提升区</td>"
				+"<td id='3_2' height='10' width='100' class='tr02'>"+Double.valueOf(a.format(zd3/1000))+"</td>"
				+"<td id='3_3' height='10' width='100' class='tr02'>"+jsyd3+"</td>"
				+"<td id='3_4' height='10' width='100' class='tr02'>"+jzgm3+"</td>"
				+"<td id='3_5' height='10' width='100' class='tr02'>"+kfcb3+"</td>"
				+"<td id='3_6' height='10' width='150' class='tr02'>"+Double.valueOf(a.format((jzgm3!=0?(kfcb3/jzgm3):0)))+"</td>"
				+"<td id='3_7' height='10' width='150' class='tr02'>"+lmbbd3+"</td>"
			+"</tr>"
			+"<tr class='tr03' >"
				+"<td id='4_0' height='10' width='200' colspan=2 class='tr03'>纳入规划储备资源小计</td>"
				+"<td id='4_1' height='10' width='100' class='tr03'>"+Double.valueOf(a.format((zd1+zd2+zd3)/1000))+"</td>"
				+"<td id='4_2' height='10' width='100' class='tr03'>"+(jsyd1+jsyd2+jsyd3)+"</td>"
				+"<td id='4_3' height='10' width='100' class='tr03'>"+(jzgm1+jzgm2+jzgm3)+"</td>"
				+"<td id='4_4' height='10' width='100' class='tr03'>"+(kfcb1+kfcb2+kfcb3)+"</td>"
				+"<td id='4_5' height='10' width='150' class='tr03'>"+Double.valueOf(a.format(((jzgm1+jzgm2+jzgm3)!=0?((kfcb1+kfcb2+kfcb3)/(jzgm1+jzgm2+jzgm3)):0)))+"</td>"
				+"<td id='4_6' height='10' width='150' class='tr03'>--</td>"
			+"</tr>"
			+"<tr class='tr02' >"
				+"<td id='5_0' height='10' width='50' class='tr02'>4</td>"
				+"<td id='5_1' height='10' width='150' class='tr02'>保留微调区</td>"
				+"<td id='5_2' height='10' width='100' class='tr02'>"+Double.valueOf(a.format(zd4/1000))+"</td>"
				+"<td id='5_3' height='10' width='100' class='tr02'>"+jsyd4+"</td>"
				+"<td id='5_4' height='10' width='100' class='tr02'>"+jzgm4+"</td>"
				+"<td id='5_5' height='10' width='100' class='tr02'>"+kfcb4+"</td>"
				+"<td id='5_6' height='10' width='150' class='tr02'>"+Double.valueOf(a.format((jzgm4!=0?(kfcb4/jzgm4):0)))+"</td>"
				+"<td id='5_7' height='10' width='150' class='tr02'>"+lmbbd4+"</td>"
			+"</tr>"
			+"<tr class='tr03' >"
				+"<td id='6_0' height='10' width='200' colspan=2 class='tr03'>合计</td>"
				+"<td id='6_1' height='10' width='100' class='tr03'>"+Double.valueOf(a.format((zd1+zd2+zd3+zd4)/1000))+"</td>"
				+"<td id='6_2' height='10' width='100' class='tr03'>"+(jsyd1+jsyd2+jsyd3+jsyd4)+"</td>"
				+"<td id='6_3' height='10' width='100' class='tr03'>"+(jzgm1+jzgm2+jzgm3+jzgm4)+"</td>"
				+"<td id='6_4' height='10' width='100' class='tr03'>"+(kfcb1+kfcb2+kfcb3+kfcb4)+"</td>"
				+"<td id='6_5' height='10' width='150' class='tr03'>"+Double.valueOf(a.format(((jzgm1+jzgm2+jzgm3+jzgm4)!=0?((kfcb1+kfcb2+kfcb3+kfcb4)/(jzgm1+jzgm2+jzgm3+jzgm4)):0)))+"</td>"
				+"<td id='6_6' height='10' width='150' class='tr03'>--</td>"
			+"</tr>"
			
			+"</table>");
        return  result.toString().replaceAll("null", "").replaceAll("\r\n", " ; ");
        }

}
