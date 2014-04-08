package com.klspta.web.cbd.swkgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class Fyzcmanager extends AbstractBaseBean {
	private static Fyzcmanager Fyzcmanager;

	private final String[][] titles = { { "房源(套)", "true" },
			{ "建筑规模<br>(万㎡)", "true" }, { "抵减占压<br>资金(亿元)", "false" },
			{ "其他费用<br>(亿元)", "true" }, { "总计(亿元)", "false" } };

	public static Fyzcmanager getInstcne() {
		if (Fyzcmanager == null) {
			Fyzcmanager = new Fyzcmanager();
		}
		return Fyzcmanager;
	}

	public void saveFyzc() {
		String sj = request.getParameter("sj");
		String jzrq = request.getParameter("jzrq");
		jzrq = UtilFactory.getStrUtil().unescape(jzrq);
		sj = UtilFactory.getStrUtil().unescape(sj);
		if (sj != null && !sj.equals("")) {
			String[] date = sj.split("@");
			for (int i = 0; i < date.length; i++) {
				String[] split = date[i].split("_");
				String yw_guid = split[0];
				String xh = split[1];
				String value = split[2];
				String update = "update fyzc set " + xh + "='" + value
						+ "' where yw_guid=?";
				this.update(update, YW, new Object[] { yw_guid });
			}
		}
		String sql = "update fyzc set jzrq='" + jzrq + "'";
		this.update(sql, YW);
		response("success");
	}

	public void addFyzc() {
		String yw_guid = request.getParameter("yw_guid");
		String mc = request.getParameter("mc");
		String gzfyts = request.getParameter("gzfyts");
		String gzjzgm = request.getParameter("gzjzgm");
		String dycbzj = request.getParameter("dycbzj");
		String gzdj = request.getParameter("gzdj");
		String lyfyts = request.getParameter("lyfyts");
		String lyjzgm = request.getParameter("lyjzgm");
		String fyclts = request.getParameter("fyclts");
		String jzmjcl = request.getParameter("jzmjcl");
		String zyzjcl = request.getParameter("zyzjcl");
		String ftlx = request.getParameter("ftlx");
		String fymc = request.getParameter("fymc");
		String zje = request.getParameter("zje");
		String mpfmft = request.getParameter("mpfmft");
		String ylyfyft = request.getParameter("ylyfyft");
		String zjfyft = request.getParameter("zjfyft");
		String fwjkzj = request.getParameter("fwjkzj");
		String dqdj = request.getParameter("dqdj");
		String jzrq = request.getParameter("jzrq");
		String bz = request.getParameter("bz");

		mc = UtilFactory.getStrUtil().unescape(mc);
		jzrq = UtilFactory.getStrUtil().unescape(jzrq);
		bz = UtilFactory.getStrUtil().unescape(bz);
		int i = 0;
		String sql = "select mc from fyzc where mc=?";
		List<Map<String, Object>> list = query(sql, YW, new Object[] { mc });
		if (!"".equals(yw_guid) || !"null".equals(yw_guid) || yw_guid != null) {
			String updateString = "update fyzc set mc=?, gzfy=?, gzgm=?, cbzj=?, gzdj=?, lyfy=?, lygm=?, qmfy=?"
					+ ", jzmj=?,zyzj=?,ftlx=?,fymc=?,ze=?,pmft=?, lyft=?, jzft=?, jkzj=?, dj=?, bz=?,jzrq=? "
					+ "where yw_guid=?";
			i = update(updateString, YW, new Object[] { mc, gzfyts, gzjzgm,
					dycbzj, gzdj, lyfyts, lyjzgm, fyclts, jzmjcl, zyzjcl, ftlx,
					fymc, zje, mpfmft, ylyfyft, zjfyft, fwjkzj, dqdj, bz, jzrq,
					yw_guid });
		} else {
			String insertString = "insert into fyzc  (mc, gzfy, gzgm, cbzj, gzdj, lyfy, lygm, qmfy, jzmj,zyzj,ftlx,fymc,ze,pmft, lyft, jzft, jkzj, dj, bz,jzrq)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			i = update(insertString, YW,
					new Object[] { mc, gzfyts, gzjzgm, dycbzj, gzdj, lyfyts,
							lyjzgm, fyclts, jzmjcl, zyzjcl, ftlx, fymc, zje,
							mpfmft, ylyfyft, zjfyft, fwjkzj, dqdj, bz, jzrq });
		}
		if (i > 0) {
			response("{success:true}");
		} else {
			response("{success:false}");
		}
	}

	public String getList() {
		StringBuffer result = new StringBuffer();
		result.append(getFirstTile());
		result.append(getSecondTile());
		result.append(getThirdTitle());	
	
		result.append(getBody());
		result.append(getTotal());
			
		/*
		
		String sumsql = "select sum(gzfy)as gzfy,sum(gzgm)as gzgm,sum(cbzj)as cbzj,sum(gzdj)as gzdj,sum(lyfy)as lyfy,sum(lygm)as lygm,sum(qmfy)as qmfy,sum(jzmj)as jzmj,sum(zyzj)as zyzj,sum(ftlx)as ftlx,'--' as fymc,sum(ze)as ze,sum(pmft)as pmft,sum(lyft)as lyft,sum(jzft)as jzft,sum(jkzj)as jkzj,sum(dj)as dj from fyzc t";
		List<Map<String, Object>> sumlist = query(sumsql, YW);
		for (int i = 0; i < sumlist.size(); i++) {
			String sumgzfy = (sumlist.get(i)).get("gzfy") == null ? ""
					: (sumlist.get(i)).get("gzfy").toString();
			String sumgzgm = (sumlist.get(i)).get("gzgm") == null ? ""
					: (sumlist.get(i)).get("gzgm").toString();
			String sumcbzj = (sumlist.get(i)).get("cbzj") == null ? ""
					: (sumlist.get(i)).get("cbzj").toString();
			String sumgzdj = (sumlist.get(i)).get("gzdj") == null ? ""
					: (sumlist.get(i)).get("gzdj").toString();
			String sumlyfy = (sumlist.get(i)).get("lyfy") == null ? ""
					: (sumlist.get(i)).get("lyfy").toString();
			String sumlygm = (sumlist.get(i)).get("lygm") == null ? ""
					: (sumlist.get(i)).get("lygm").toString();
			String sumqmfy = (sumlist.get(i)).get("qmfy") == null ? ""
					: (sumlist.get(i)).get("qmfy").toString();
			String sumjzmj = (sumlist.get(i)).get("jzmj") == null ? ""
					: (sumlist.get(i)).get("jzmj").toString();
			String sumzyzj = (sumlist.get(i)).get("zyzj") == null ? ""
					: (sumlist.get(i)).get("zyzj").toString();
			String sumftlx = (sumlist.get(i)).get("ftlx") == null ? ""
					: (sumlist.get(i)).get("ftlx").toString();
			String sumfymc = (sumlist.get(i)).get("fymc") == null ? ""
					: (sumlist.get(i)).get("fymc").toString();
			String sumze = (sumlist.get(i)).get("ze") == null ? "" : (sumlist
					.get(i)).get("ze").toString();
			String sumpmft = (sumlist.get(i)).get("pmft") == null ? ""
					: (sumlist.get(i)).get("pmft").toString();
			String sumlyft = (sumlist.get(i)).get("lyft") == null ? ""
					: (sumlist.get(i)).get("lyft").toString();
			String sumjzft = (sumlist.get(i)).get("jzft") == null ? ""
					: (sumlist.get(i)).get("jzft").toString();
			String jkzj = (sumlist.get(i)).get("jkzj") == null ? "" : (sumlist
					.get(i)).get("jkzj").toString();
			String sumdj = (sumlist.get(i)).get("dj") == null ? "" : (sumlist
					.get(i)).get("dj").toString();
			result.append("<tr><td class='tr01'>总计</td><td class='tr01'>"
					+ sumgzfy + "</td><td class='tr01'>" + sumgzgm
					+ "</td><td class='tr01'>" + sumcbzj
					+ "</td><td class='tr01'>" + sumgzdj
					+ "</td><td class='tr01'>" + sumlyfy
					+ "</td><td class='tr01'>" + sumlygm
					+ "</td><td class='tr01'>" + sumqmfy
					+ "</td><td class='tr01'>" + sumjzmj
					+ "</td><td class='tr01'>" + sumzyzj
					+ "</td><td class='tr01'>" + sumftlx
					+ "</td><td class='tr01'>" + sumfymc
					+ "</td><td class='tr01'>" + sumze
					+ "</td><td class='tr01'>" + sumpmft
					+ "</td><td class='tr01'>" + sumlyft
					+ "</td><td class='tr01'>" + sumjzft
					+ "</td><td class='tr01'>" + jkzj
					+ "</td><td class='tr01'>" + sumdj
					+ "</td><td class='tr01'></td><td class='tr01'></td></tr>");
		}*/
		result.append("</table>");
		return result.toString().replaceAll("null", "");
	}
	
	public String getBody(){
		return getBody(false);
	}
	
	public String getBody(boolean istoal){
		StringBuffer result = new StringBuffer();
		String sql = "";
		if(!istoal){
			sql = "select t.* from fyzc t";
		}else{
			sql = "select '总计' as mc ,'--' as gzly,sum(t.gzfy) as gzfy ,sum(t.gzjzgm) as gzjzgm ,'--' as fwdj," +
					"sum(t.dycbzj) as dycbzj,sum(t.qtfy) as qtfy,sum(t.jyfy) as jyfy,sum(t.jyjzgm) as jyjzgm," +
					"sum(t.zyzj) as zyzj,sum(t.jyqtfy) as jyqtfy ,sum(t.zj) as zj from fyzc t";
		}
		List<Map<String, Object>> alllist = query(sql, YW);
		for(int i=0;i<alllist.size() ; i++){
			String mc = alllist.get(i).get("mc")==null?"":alllist.get(i).get("mc").toString();
			String gzly = alllist.get(i).get("gzly")==null?"":alllist.get(i).get("gzly").toString();
			String gzfy = alllist.get(i).get("gzfy")==null?"":alllist.get(i).get("gzfy").toString();
			String gzjzgm = alllist.get(i).get("gzjzgm")==null?"":alllist.get(i).get("gzjzgm").toString();
			String fwdj = alllist.get(i).get("fwdj")==null?"":alllist.get(i).get("fwdj").toString();
			String dycbzj = alllist.get(i).get("dycbzj")==null?"":alllist.get(i).get("dycbzj").toString();
			String gzqtfy = alllist.get(i).get("qtfy")==null?"":alllist.get(i).get("qtfy").toString();
			String jyfy = alllist.get(i).get("jyfy")==null?"":alllist.get(i).get("jyfy").toString();
			String jyjzgm = alllist.get(i).get("jyjzgm")==null?"":alllist.get(i).get("jyjzgm").toString();
			String zyzj = alllist.get(i).get("zyzj")==null?"":alllist.get(i).get("zyzj").toString();
			String jyqtfy = alllist.get(i).get("jyqtfy")==null?"":alllist.get(i).get("jyqtfy").toString();
			String zj = alllist.get(i).get("zj")==null?"":alllist.get(i).get("zj").toString();
			String bz = alllist.get(i).get("bz")==null?"":alllist.get(i).get("bz").toString();
			String yw_guid = alllist.get(i).get("yw_guid")==null?"":alllist.get(i).get("yw_guid").toString();
			result
			.append("<tr class='trsingle' onclick='showMap(this); return false;' ondblclick='editMap(this); return false;'>")
			.append("<td>").append(mc).append("</td><td>").append(gzly).append("</td><td>").append(gzfy).append("</td><td>")
			.append(gzjzgm).append("</td><td>").append(fwdj).append("</td><td>").append(dycbzj).append("</td><td>")
			.append(gzqtfy).append("</td>");
			List<Map<String, Object>> listitem = getfyxm();
			for(int j=0;j<listitem.size();j++){
				List<Map<String,Object>> list = null;
				if(!istoal){
					sql = "select * from fyzc_fy f where f.fymc = ? and parent_id=?";
					list = query(sql, YW,new Object[]{listitem.get(j).get("fymc"),yw_guid});
				}else{
					sql = "select sum(fy) as fy,sum(jzgm) as jzgm ,sum(djzyzj) as djzyzj ,sum(qtfy) as qtfy,sum(zj) as zj from fyzc_fy where fymc=?  ";
					list = query(sql, YW,new Object[]{listitem.get(j).get("fymc")});
				}
				
				result.append("<td>").append(list.get(0).get("fy")).append("</td><td>").append(list.get(0).get("jzgm"))
				.append("</td><td>").append(list.get(0).get("djzyzj")).append("</td><td>")
				.append(list.get(0).get("qtfy")).append("</td><td>").append(list.get(0).get("zj")).append("</td>");
			}
			result.append("<td>").append(jyfy).append("</td><td>").append(jyjzgm).append("</td><td>").append(zyzj).append("</td><td>")
			.append(jyqtfy).append("</td><td>").append(zj).append("</td><td>").append(bz).append("</td>");
		}
		return result.toString();
	}
	
	public String getTotal (){
		return getBody(true);
	}

	public void delByYwGuid() {
		String yw_guid = request.getParameter("yw_guid");
		yw_guid = UtilFactory.getStrUtil().unescape(yw_guid);
		String[] mcs = yw_guid.substring(0, yw_guid.length() - 1).split(",");
		for (int i = 0; i < mcs.length; i++) {
			String sql = "delete from fyzc t where t.yw_guid='" + mcs[i] + "'";
			this.update(sql, YW);
		}
		response("success");
	}

	public void quryKeyWord() {
		/*String keyword = request.getParameter("keyword");
		keyword = UtilFactory.getStrUtil().unescape(keyword);
		String sql = "select distinct jzrq from fyzc";
		List<Map<String, Object>> list2 = query(sql, YW);
		String jzrq = (String) (list2.get(0)).get("jzrq");
		StringBuffer result = new StringBuffer(
				"<table id='FYZC' width='2000' border='1' cellpadding='1' cellspacing='0'>"
						+ "<tr class='title' onclick='showMap(this); return false;' ondblclick='editMap(this); return false;'><td rowspan='2' colspan='1' class='tr01'>名称</td><td colspan='4' rowspan='1' class='tr01'>购置情况</td><td colspan='2' rowspan='1' class='tr01'>利用情况</td><td colspan='3' rowspan='1' class='tr01'>期末存量情况</td><td  class='tr01'><input id='jzrq' style='border:0;background:transparent;' value="
						+ jzrq
						+ "></td><td rowspan='1' colspan='5' class='tr01'>其他费用</td><td rowspan='2' colspan='1' class='tr01'>房屋价款总计</td><td rowspan='2' colspan='1' class='tr01'>当前单价</td><td rowspan='2' colspan='1' class='tr01'>备注</td></tr><tr><td colspan='1' rowspan='1' class='tr01'>房源套数</td><td colspan='1' rowspan='1' class='tr01'>建筑规模</td><td colspan='1' rowspan='1' class='tr01'>动用储备资金</td><td colspan='1' rowspan='1' class='tr01'>购置单价</td><td colspan='1' rowspan='1' class='tr01'>房源套数</td><td colspan='1' rowspan='1' class='tr01'>建筑规模</td><td colspan='1' rowspan='1' class='tr01'>房源套数</td><td colspan='1' rowspan='1' class='tr01'>建筑面积</td><td colspan='1' rowspan='1' class='tr01'>占压资金</td><td colspan='1' rowspan='1' class='tr01'>分摊利息</td><td colspan='1' rowspan='1' class='tr01'>费用名称</td><td colspan='1' rowspan='1' class='tr01'>总金额</td><td colspan='1' rowspan='1' class='tr01'>每平米分摊</td><td colspan='1' rowspan='1' class='tr01'>已利用房源分摊</td><td colspan='1' rowspan='1' class='tr01'>结转房源分摊</td></tr>");
		String qurysql = "select t.mc,t.gzfy,t.gzgm,t.cbzj,t.gzdj,t.jzmj,t.zyzj,t.pmft,t.lyft,t.ze,t.lyfy,t.lygm,t.dj,t.qmfy,t.ftlx,t.fymc,t.jzft,t.jkzj,t.bz,t.yw_guid from fyzc t where t.mc like '%"
				+ keyword + "%'";
		List<Map<String, Object>> qurylist = query(qurysql, YW);
		for (int i = 0; i < qurylist.size(); i++) {
			String mc = (String) (qurylist.get(i)).get("mc");
			String gzfy = (String) (qurylist.get(i)).get("gzfy");
			String gzgm = (String) (qurylist.get(i)).get("gzgm");
			String cbzj = (String) (qurylist.get(i)).get("cbzj");
			String gzdj = (String) (qurylist.get(i)).get("gzdj");
			String jzmj = (String) (qurylist.get(i)).get("jzmj");
			String zyzj = (String) (qurylist.get(i)).get("zyzj");
			String pmft = (String) (qurylist.get(i)).get("pmft");
			String lyft = (String) (qurylist.get(i)).get("lyft");
			String ze = (String) (qurylist.get(i)).get("ze");
			String lyfy = (String) (qurylist.get(i)).get("lyfy");
			String lygm = (String) (qurylist.get(i)).get("lygm");
			String dj = (String) (qurylist.get(i)).get("dj");
			String qmfy = (String) (qurylist.get(i)).get("qmfy");
			String ftlx = (String) (qurylist.get(i)).get("ftlx");
			String fymc = (String) (qurylist.get(i)).get("fymc");
			String jzft = (String) (qurylist.get(i)).get("jzft");
			String jkzj = (String) (qurylist.get(i)).get("jkzj");
			String bz = (String) (qurylist.get(i)).get("bz");
			result
					.append("<tr class='trsingle' onclick='showMap(this); return false;' ondblclick='editMap(this); return false;'><td>"
							+ mc
							+ "</td><td>"
							+ gzfy
							+ "</td><td>"
							+ gzgm
							+ "</td><td>"
							+ cbzj
							+ "</td><td>"
							+ gzdj
							+ "</td><td>"
							+ lyfy
							+ "</td><td>"
							+ lygm
							+ "</td><td>"
							+ qmfy
							+ "</td><td>"
							+ jzmj
							+ "</td><td>"
							+ zyzj
							+ "</td><td>"
							+ ftlx
							+ "</td><td>"
							+ fymc
							+ "</td><td>"
							+ ze
							+ "</td><td>"
							+ pmft
							+ "</td><td>"
							+ lyft
							+ "</td><td>"
							+ jzft
							+ "</td><td>"
							+ jkzj
							+ "</td><td>"
							+ dj
							+ "</td><td>"
							+ bz
							+ "</td></tr>");
		}
		result
				.append("<tr><td class='tr01'>总计</td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td></tr></table>");
		response(result.toString().replaceAll("null", ""));*/
	}

	/**
	 * 获取房源资产子项的个数
	 * @return
	 */
	public List<Map<String, Object>> getfyxm() {
		String sql = "select distinct fymc from fyzc_fy ";
		return query(sql, YW);
	}

	public String getFirstTile() {
		List<Map<String,Object>> list = getfyxm();
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer
				.append("<table id='FYZC' width='1800' border='1' cellpadding='1' cellspacing='0'>");
		stringBuffer
				.append("<tr class='title'><td rowspan='3' class='tr01'>名      称</td><td colspan='6' rowspan='2'" +
						" class='tr01'>房源筹集情况</td><td colspan='"+list.size()*5+"'  class='tr01'>房源使用情况</td><td colspan='5'" +
						" rowspan='2' class='tr01'>房源结余情况</td><td rowspan='3' colspan='1' class='tr01'>备注</td></tr>");
		return stringBuffer.toString();
	}
	
	public String getSecondTile(){
		List<Map<String,Object>> list = getfyxm();
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("<tr  class='title'>");
		for(int i = 0;i<list.size();i++){
			stringBuffer.append("<td colspan='5' rowspan='1' class='tr01'>"+list.get(i).get("fymc")+"使用情况</td>");
		}
		stringBuffer.append("</tr>");
		return stringBuffer.toString();
	}

	public String getThirdTitle(){
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("<tr  class='title'><td colspan='1'" +
				" rowspan='1' class='tr01'>来源</td><td colspan='1' rowspan='1' class='tr01'>房源(套)</td>" +
				"<td colspan='1' rowspan='1' class='tr01'>建筑规模<br>(万㎡)</td><td colspan='1' rowspan='1' " +
				"class='tr01'>房屋单价<br>(万元/㎡)</td><td colspan='1' rowspan='1' class='tr01'>动用储备<br>资金(亿元)</td><td colspan='1'" +
				" rowspan='1' class='tr01'>其他费用<br>(亿元)</td>");
		List<Map<String,Object>> list = getfyxm();
		for(int j=0;j<list.size();j++){
			for(int i =0;i<titles.length;i++){
				stringBuffer.append("<td colspan='1'" +" rowspan='1' class='tr01'>"+titles[i][0]+"</td>");
			}
		}
		stringBuffer.append("<td colspan='1' rowspan='1' class='tr01'>房源(套)</td>" +
				"<td colspan='1' rowspan='1' class='tr01'>建筑规模<br>(万㎡)</td><td colspan='1' rowspan='1' class='tr01'>" +
				"占压资金<br>(亿元)</td><td colspan='1' rowspan='1' class='tr01'>其他费用<br>(亿元)</td><td colspan='1' rowspan='1'" +
				" class='tr01'>总计<br>(亿元)</td></tr>");
		return stringBuffer.toString();
	}
}
