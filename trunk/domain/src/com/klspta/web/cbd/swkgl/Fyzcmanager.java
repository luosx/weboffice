package com.klspta.web.cbd.swkgl;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.model.CBDReport.CBDReportManager;
import com.klspta.model.CBDReport.tablestyle.ITableStyle;
import com.klspta.web.cbd.yzt.jc.report.TableStyleEditRow;

public class Fyzcmanager extends AbstractBaseBean {
	private static Fyzcmanager Fyzcmanager;
	private DecimalFormat df = new DecimalFormat(".00");

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

	public void addFyzc_fy() {
		String parent_id = request.getParameter("parent_id");
		String fymc = request.getParameter("fymc");
		String fy = request.getParameter("fy");
		String jzgm = request.getParameter("jzgm");
		String djzyzj = request.getParameter("djzyzj");
		String qtfy = request.getParameter("qtfy_child");
		String zj = request.getParameter("zj_child");
		String yw_guid = request.getParameter("yw_guid_child");
		
		fymc = fymc.equals("")?"无":fymc;
		
		fymc = UtilFactory.getStrUtil().unescape(fymc);

		int i = 0;

		if ("".equals(yw_guid) || "null".equals(yw_guid) || yw_guid == null) {
			String queryAll = "select distinct yw_guid from fyzc";
			List<Map<String, Object>> list = query(queryAll, YW);
			StringBuffer insertAll = new StringBuffer("insert all ");
			for (Map<String, Object> sub : list) {
				insertAll.append("into fyzc_fy (parent_id,fymc) values('")
						.append(sub.get("yw_guid"))
						.append("','" + fymc + "') ");

			}
			insertAll.append("select 'a','b' from dual");
			System.out.println(insertAll.toString());
			i = update(insertAll.toString(), YW);
			// String insertString =
			// "insert into fyzc_fy (fymc,fy,jzgm,djzyzj,qtfy,zj,parent_id) values(?,?,?,?,?,?,?)";
			// i = update(insertString,YW,new
			// Object[]{fymc,fy,jzgm,djzyzj,qtfy,zj,parent_id});
		}
		if (i > 0) {
			response("{success:true}");
		} else {
			response("{success:false}");
		}

	}

	public void modifyFyzc_fy() {
		String yw_guid = request.getParameter("yw_guid_child_modify");
		String parent_id = request.getParameter("parent_id_modify2");
		String fymc = request.getParameter("fymc_modify");
		String fy = request.getParameter("fy_modify");
		String jzgm = request.getParameter("jzgm_modify");
		String djzyzj = request.getParameter("djzyzj_modify");
		String qtfy = request.getParameter("qtfy_child_modify");
		String zj = request.getParameter("zj_child_modify");
		String dj = request.getParameter("dj");

		fymc = UtilFactory.getStrUtil().unescape(fymc);

		int i = 0;
		
		try {
			flushData(yw_guid, parent_id, fy, jzgm, dj);
			
			String updateSQL = "update fyzc_fy set fymc=?,fy=?,jzgm=?,djzyzj=?,qtfy=?,zj=? where yw_guid=?";
		i = update(updateSQL, YW, new Object[] { fymc, fy, jzgm, djzyzj, qtfy,
				zj, yw_guid });
			
		} catch (Exception e) {
			e.printStackTrace();
			response("{success:false}");
		}

		if (i > 0) {
			response("{success:true}");
		} else {
			response("{success:false}");
		}
	}

	// 子项目更新后导致父项目改变。子项目更新后必须执行一次的方法。
	public void flushData(String yw_guid, String parent_id, String fy,
			String jzgm, String dj) {
		String querySQL = "select * from fyzc_fy where yw_guid='" + yw_guid
				+ "'";
		List<Map<String, Object>> list = query(querySQL, YW);
		System.out.println("list:" + list.size());
		int fy_ora = Integer.parseInt(list.get(0).get("FY").toString());
		double jzgm_ora = Double.parseDouble(list.get(0).get("JZGM").toString());
		// double djzyzj_ora =
		// Double.parseDouble(list.get(0).get("DJZYZJ").toString());

		int fy_change = fy_ora - Integer.parseInt(fy);
		double jzgm_change = jzgm_ora - Double.parseDouble(jzgm);
		System.out.println("fy_ora :"+fy_ora);
		System.out.println("fy_change :"+fy_change);
		
		System.out.println("jzgm_ora :"+jzgm_ora);
		System.out.println("jzgm_change :"+jzgm_change);
		// double djzyzj_change = djzyzj_ora - Double.parseDouble(djzyzj);
		if (fy_change != 0 || jzgm_change != 0) {
			System.out.println("parent_id:" + parent_id);
			/* jyfy,jyjzgm,zyzj,zj */
			List<Map<String, Object>> list2 = query(
					"select * from fyzc where yw_guid='" + parent_id + "'", YW);
			System.out.println(list2.size());
			String updateSQL = "update fyzc set yw_guid='" + parent_id + "'";

			DecimalFormat df = new DecimalFormat(".00");

			if (fy_change != 0) {
				int jyfy = Integer
						.parseInt(list2.get(0).get("JYFY").toString())
						+ fy_change;
				updateSQL = updateSQL + ",jyfy='" + jyfy + "'";
			}
			if (jzgm_change != 0) {
				double jyjzgm = Double.parseDouble(list2.get(0).get("JYJZGM")
						.toString())
						+ jzgm_change;
				updateSQL = updateSQL + ",jyjzgm='" + df.format(jyjzgm) + "'";
				double price_change = jzgm_change * Double.parseDouble(dj);
				double zyzj = Double.parseDouble(list2.get(0).get("ZYZJ")
						.toString())
						+ price_change;
				updateSQL = updateSQL + ",zyzj='" + df.format(zyzj) + "'";
				double zj_parent = Double.parseDouble(list2.get(0).get("ZJ")
						.toString())
						+ price_change;
				System.out.println("zj_parent:"+zj_parent);
				updateSQL = updateSQL + ",zj='" + df.format(zj_parent) + "'";
			}

			updateSQL = updateSQL + " where yw_guid='" + parent_id + "'";
			System.out.println(updateSQL);

			int j = update(updateSQL, YW);
			System.out.println("j=" + j);

		}

	}

	public void addFyzc() {
		String yw_guid = request.getParameter("yw_guid");
		String mc = request.getParameter("mc");
		String gzly = request.getParameter("gzly");
		String gzfy = request.getParameter("gzfy");
		String gzjzgm = request.getParameter("gzjzgm");
		String dycbzj = request.getParameter("dycbzj");
		String fwdj = request.getParameter("fwdj");
		String qtfy = request.getParameter("qtfy");
		String jyqtfy = request.getParameter("jyqtfy");




		
		
		mc = UtilFactory.getStrUtil().unescape(mc);
		gzly = UtilFactory.getStrUtil().unescape(gzly);

		int i = 0;
		// String sql = "select mc from fyzc where mc=?";
		// List<Map<String, Object>> list = query(sql, YW, new Object[] { mc });
		if (!"".equals(yw_guid) && !"null".equals(yw_guid) && yw_guid != null) {
		
		} else {

			String myguid = "";
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
			myguid = sdf.format(date);
			
			try {
				String insertString = "insert into fyzc(mc,gzly,gzfy,gzjzgm,dycbzj,fwdj,qtfy,jyqtfy,zj,yw_guid,jyfy,jyjzgm,zyzj) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
				i = update(insertString, YW, new Object[] {
						mc.equals("")?"无":mc, 
								gzly.equals("")?"无":gzly, 
										gzfy.equals("")?"0":gzfy,
												gzjzgm.equals("")?"0":gzjzgm, 
														dycbzj.equals("")?"0":dycbzj, 
																fwdj.equals("")?"0":fwdj, 
																		qtfy.equals("")?"0":qtfy, 
																				jyqtfy.equals("")?"0":jyqtfy,
																						df.format(Double.parseDouble(jyqtfy.equals("")?"0":jyqtfy) + Double.parseDouble(fwdj.equals("")?"0":fwdj) * Double.parseDouble(gzjzgm.equals("")?"0":gzjzgm)),
																								myguid,
																									gzfy.equals("")?"0":gzfy,
																											gzjzgm.equals("")?"0":gzjzgm,
																													df.format(Double.parseDouble(fwdj.equals("")?"0":fwdj) * Double.parseDouble(gzjzgm.equals("")?"0":gzjzgm)) 
																													});

				String queryAll = "select distinct fymc from fyzc_fy";
				List<Map<String, Object>> list = query(queryAll, YW);
				StringBuffer insertAll = new StringBuffer("insert all ");
				for (Map<String, Object> sub : list) {
					insertAll.append("into fyzc_fy (parent_id,fymc) values('")
							.append(myguid)
							.append("','" + sub.get("fymc") + "') ");

				}
				insertAll.append("select 'a','b' from dual");
				System.out.println(insertAll.toString());
				i = update(insertAll.toString(), YW);

				// String insertString2 =
				// "insert into fyzc_fy (fymc,fy,jzgm,djzyzj,qtfy,zj,parent_id) values(?,?,?,?,?,?,?)";
				// update(insertString2,YW,new
				// Object[]{"二期项目",0,0,0,0,0,myguid});
				// update(insertString2,YW,new
				// Object[]{"垂杨柳项目",0,0,0,0,0,myguid});
			} catch (Exception e) {
				e.printStackTrace();
				String deleteString = "delete fyzc where yw_guid=?";
				String deleteString2 = "delete fyzc_fy where parent_id=?";
				update(deleteString, YW, new Object[] { myguid });
				update(deleteString2, YW, new Object[] { myguid });
			}

		}
		if (i > 0) {
			response("{success:true}");
		} else {
			response("{success:false}");
		}
	}

	public void modifyFyzc() {
		String yw_guid = request.getParameter("yw_guid_modify");

		String gzly = request.getParameter("gzly_modify");
		String gzfy = request.getParameter("gzfy_modify");
		String gzjzgm = request.getParameter("gzjzgm_modify");
		String dycbzj = request.getParameter("dycbzj_modify");
		String fwdj = request.getParameter("fwdj_modify");
		String qtfy = request.getParameter("qtfy_modify");
		String jyqtfy = request.getParameter("jyqtfy_modify");
		String jyfy = request.getParameter("jyfy_modify");
		String jyjzgm = request.getParameter("jyjzgm_modify");
		String zj = request.getParameter("zj_modify");
		String zyzj = request.getParameter("zyzj_modify");

		gzly = UtilFactory.getStrUtil().unescape(gzly);

		int i = 0;

		String updateSQL = "update fyzc set "
				+ "gzfy=?,zyzj=?,gzly=?,gzjzgm=?,fwdj=?,dycbzj=?,qtfy=?,jyfy=?,jyjzgm=?,jyqtfy=?,zj=? "
				+ "where yw_guid=?";

		i = update(updateSQL, YW, new Object[] { gzfy, zyzj, gzly, gzjzgm,
				fwdj, dycbzj, qtfy, jyfy, jyjzgm, jyqtfy, zj, yw_guid });

		if (i > 0) {
			response("{success:true}");
		} else {
			response("{success:false}");
		}
	}

	public String getList(String keyword) {
		StringBuffer result = new StringBuffer();
		result.append(getFirstTile());
		result.append(getSecondTile());
		result.append(getThirdTitle());

		result.append(getBody(keyword));
		result.append(getTotal(keyword));

		/*
		 * 
		 * String sumsql =
		 * "select sum(gzfy)as gzfy,sum(gzgm)as gzgm,sum(cbzj)as cbzj,sum(gzdj)as gzdj,sum(lyfy)as lyfy,sum(lygm)as lygm,sum(qmfy)as qmfy,sum(jzmj)as jzmj,sum(zyzj)as zyzj,sum(ftlx)as ftlx,'--' as fymc,sum(ze)as ze,sum(pmft)as pmft,sum(lyft)as lyft,sum(jzft)as jzft,sum(jkzj)as jkzj,sum(dj)as dj from fyzc t"
		 * ; List<Map<String, Object>> sumlist = query(sumsql, YW); for (int i =
		 * 0; i < sumlist.size(); i++) { String sumgzfy =
		 * (sumlist.get(i)).get("gzfy") == null ? "" :
		 * (sumlist.get(i)).get("gzfy").toString(); String sumgzgm =
		 * (sumlist.get(i)).get("gzgm") == null ? "" :
		 * (sumlist.get(i)).get("gzgm").toString(); String sumcbzj =
		 * (sumlist.get(i)).get("cbzj") == null ? "" :
		 * (sumlist.get(i)).get("cbzj").toString(); String sumgzdj =
		 * (sumlist.get(i)).get("gzdj") == null ? "" :
		 * (sumlist.get(i)).get("gzdj").toString(); String sumlyfy =
		 * (sumlist.get(i)).get("lyfy") == null ? "" :
		 * (sumlist.get(i)).get("lyfy").toString(); String sumlygm =
		 * (sumlist.get(i)).get("lygm") == null ? "" :
		 * (sumlist.get(i)).get("lygm").toString(); String sumqmfy =
		 * (sumlist.get(i)).get("qmfy") == null ? "" :
		 * (sumlist.get(i)).get("qmfy").toString(); String sumjzmj =
		 * (sumlist.get(i)).get("jzmj") == null ? "" :
		 * (sumlist.get(i)).get("jzmj").toString(); String sumzyzj =
		 * (sumlist.get(i)).get("zyzj") == null ? "" :
		 * (sumlist.get(i)).get("zyzj").toString(); String sumftlx =
		 * (sumlist.get(i)).get("ftlx") == null ? "" :
		 * (sumlist.get(i)).get("ftlx").toString(); String sumfymc =
		 * (sumlist.get(i)).get("fymc") == null ? "" :
		 * (sumlist.get(i)).get("fymc").toString(); String sumze =
		 * (sumlist.get(i)).get("ze") == null ? "" : (sumlist
		 * .get(i)).get("ze").toString(); String sumpmft =
		 * (sumlist.get(i)).get("pmft") == null ? "" :
		 * (sumlist.get(i)).get("pmft").toString(); String sumlyft =
		 * (sumlist.get(i)).get("lyft") == null ? "" :
		 * (sumlist.get(i)).get("lyft").toString(); String sumjzft =
		 * (sumlist.get(i)).get("jzft") == null ? "" :
		 * (sumlist.get(i)).get("jzft").toString(); String jkzj =
		 * (sumlist.get(i)).get("jkzj") == null ? "" : (sumlist
		 * .get(i)).get("jkzj").toString(); String sumdj =
		 * (sumlist.get(i)).get("dj") == null ? "" : (sumlist
		 * .get(i)).get("dj").toString();
		 * result.append("<tr><td class='tr01'>总计</td><td class='tr01'>" +
		 * sumgzfy + "</td><td class='tr01'>" + sumgzgm +
		 * "</td><td class='tr01'>" + sumcbzj + "</td><td class='tr01'>" +
		 * sumgzdj + "</td><td class='tr01'>" + sumlyfy +
		 * "</td><td class='tr01'>" + sumlygm + "</td><td class='tr01'>" +
		 * sumqmfy + "</td><td class='tr01'>" + sumjzmj +
		 * "</td><td class='tr01'>" + sumzyzj + "</td><td class='tr01'>" +
		 * sumftlx + "</td><td class='tr01'>" + sumfymc +
		 * "</td><td class='tr01'>" + sumze + "</td><td class='tr01'>" + sumpmft
		 * + "</td><td class='tr01'>" + sumlyft + "</td><td class='tr01'>" +
		 * sumjzft + "</td><td class='tr01'>" + jkzj + "</td><td class='tr01'>"
		 * + sumdj + "</td><td class='tr01'></td><td class='tr01'></td></tr>");
		 * }
		 */
		result.append("</table>");
		return result.toString().replaceAll("null", "");
	}

	public String getBody(String keyword) {
		return getBody(false, keyword);
	}

	private List<String> ids = new ArrayList<String>();

	public String getBody(boolean istoal, String keyword) {

		StringBuffer result = new StringBuffer();
		String sql = "";
		if (!istoal) {
			if ("".equals(keyword)) {
				sql = "select t.* from fyzc t";
			} else {
				// sql =
				// "select t.* from fyzc t where t.mc like '%#keyword%' or t.gzfy like '%#keyword%' or t.zyzj like '%#keyword%' or "
				// +
				// "t.bz like '%#keyword%' or t.gzly like '%#keyword%' or t.gzjzgm like '%#keyword%' or t.fwdj like '%#keyword%' or "
				// +
				// "t.dycbzj like '%#keyword%' or t.qtfy like '%#keyword%' or t.jyfy like '%#keyword%' or t.jyjzgm like '%#keyword%' or "
				// +
				// "t.jyqtfy like '%#keyword%' or t.zj like '%#keyword%'";
				sql = "select t.* from fyzc t where t.mc like '%#keyword%' or t.gzfy like '%#keyword%' or t.zyzj like '%#keyword%' or "
						+ "t.bz like '%#keyword%' or t.gzly like '%#keyword%' or t.gzjzgm like '%#keyword%' or t.fwdj like '%#keyword%' or "
						+ "t.dycbzj like '%#keyword%' or t.qtfy like '%#keyword%' or t.jyfy like '%#keyword%' or t.jyjzgm like '%#keyword%' or "
						+ "t.jyqtfy like '%#keyword%' or t.zj like '%#keyword%'";
				sql = sql.replace("#keyword", keyword);
				System.out.println(sql);
			}

		} else {
			if ("".equals(keyword)) {
				sql = "select '总计' as mc ,'--' as gzly,sum(m.gzfy) as gzfy ,sum(m.gzjzgm) as gzjzgm ,'--' as fwdj,"
						+ "sum(m.dycbzj) as dycbzj,sum(m.qtfy) as qtfy,sum(m.jyfy) as jyfy,sum(m.jyjzgm) as jyjzgm,"
						+ "sum(m.zyzj) as zyzj,sum(m.jyqtfy) as jyqtfy ,sum(m.zj) as zj from fyzc m";
			} else {
				sql = "select '总计' as mc ,'--' as gzly,sum(m.gzfy) as gzfy ,sum(m.gzjzgm) as gzjzgm ,'--' as fwdj,"
						+ "sum(m.dycbzj) as dycbzj,sum(m.qtfy) as qtfy,sum(m.jyfy) as jyfy,sum(m.jyjzgm) as jyjzgm,"
						+ "sum(m.zyzj) as zyzj,sum(m.jyqtfy) as jyqtfy ,sum(m.zj) as zj from ("
						+ "select t.* from fyzc t where t.mc like '%#keyword%' or t.gzfy like '%#keyword%' or t.zyzj like '%#keyword%' or "
						+ "t.bz like '%#keyword%' or t.gzly like '%#keyword%' or t.gzjzgm like '%#keyword%' or t.fwdj like '%#keyword%' or "
						+ "t.dycbzj like '%#keyword%' or t.qtfy like '%#keyword%' or t.jyfy like '%#keyword%' or t.jyjzgm like '%#keyword%' or "
						+ "t.jyqtfy like '%#keyword%' or t.zj like '%#keyword%') m";
				sql = sql.replace("#keyword", keyword);
			}
		}
		List<Map<String, Object>> alllist = query(sql, YW);

		System.out.println("第一次查询:" + alllist.size());
		if (!istoal) {
			ids.clear();
			for (int i = 0; i < alllist.size(); i++) {
				ids.add(alllist.get(i).get("yw_guid").toString());
			}
			System.out.println("进入了获取ids的方法，ids:" + ids.size());
		}

		for (int i = 0; i < alllist.size(); i++) {
			String mc = alllist.get(i).get("mc") == null ? "" : alllist.get(i)
					.get("mc").toString();
			String gzly = alllist.get(i).get("gzly") == null ? "" : alllist
					.get(i).get("gzly").toString();
			String gzfy = alllist.get(i).get("gzfy") == null ? "" : alllist
					.get(i).get("gzfy").toString();
			String gzjzgm = alllist.get(i).get("gzjzgm") == null ? "" : alllist
					.get(i).get("gzjzgm").toString();
			String fwdj = alllist.get(i).get("fwdj") == null ? "" : alllist
					.get(i).get("fwdj").toString();
			String dycbzj = alllist.get(i).get("dycbzj") == null ? "" : alllist
					.get(i).get("dycbzj").toString();
			String gzqtfy = alllist.get(i).get("qtfy") == null ? "" : alllist
					.get(i).get("qtfy").toString();
			String jyfy = alllist.get(i).get("jyfy") == null ? "" : alllist
					.get(i).get("jyfy").toString();
			String jyjzgm = alllist.get(i).get("jyjzgm") == null ? "" : alllist
					.get(i).get("jyjzgm").toString();
			String zyzj = alllist.get(i).get("zyzj") == null ? "" : alllist
					.get(i).get("zyzj").toString();
			String jyqtfy = alllist.get(i).get("jyqtfy") == null ? "" : alllist
					.get(i).get("jyqtfy").toString();
			String zj = alllist.get(i).get("zj") == null ? "" : alllist.get(i)
					.get("zj").toString();
			String bz = alllist.get(i).get("bz") == null ? "" : alllist.get(i)
					.get("bz").toString();
			String yw_guid = alllist.get(i).get("yw_guid") == null ? ""
					: alllist.get(i).get("yw_guid").toString();
			result.append(
					"<tr class='trsingle' onclick='showMap(this); return false;' ondblclick='editMap(this); return false;'>")
					.append("<td>").append(mc).append("</td><td>").append(gzly)
					.append("</td><td>").append(gzfy).append("</td><td>")
					.append(gzjzgm).append("</td><td>").append(fwdj)
					.append("</td><td>").append(dycbzj).append("</td><td>")
					.append(gzqtfy).append("</td>");
			List<Map<String, Object>> listitem = getfyxm();
			for (int j = 0; j < listitem.size(); j++) {
				List<Map<String, Object>> list = null;
				if (!istoal) {
					// if("".equals(keyword)){
					sql = "select * from fyzc_fy f where f.fymc = ? and parent_id=?";
					list = query(
							sql,
							YW,
							new Object[] { listitem.get(j).get("fymc"), yw_guid });
					// }else{
					// sql =
					// "select * from fyzc_fy f where f.fymc = ? and parent_id=? and( f.fymc like '%#keyword%' or "
					// +
					// "f.fy like '%#keyword%' or f.jzgm like '%#keyword%' or f.djzyzj like '%#keyword%' or f.qtfy like '%#keyword%' or "
					// +
					// "f.zj like '%#keyword%')";
					// sql = sql.replace("#keyword",keyword);
					// System.out.println(sql);
					// list = query(sql, YW,new
					// Object[]{listitem.get(j).get("fymc"),yw_guid});
					// System.out.println("第二次查询:" + list.size());
					// }

				} else {
					if ("".equals(keyword)) {
						sql = "select sum(fy) as fy,sum(jzgm) as jzgm ,sum(djzyzj) as djzyzj ,sum(qtfy) as qtfy,sum(zj) as zj from fyzc_fy where fymc=?  ";
						list = query(sql, YW, new Object[] { listitem.get(j)
								.get("fymc") });
					} else {
						sql = "select sum(fy) as fy,sum(jzgm) as jzgm ,sum(djzyzj) as djzyzj ,sum(qtfy) as qtfy,sum(zj) as zj from fyzc_fy where fymc=? and(";
						System.out
								.println("进入循环IDS方法之前的Flag ids：" + ids.size());
						for (int k = 0; k < ids.size(); k++) {
							if (k == 0) {
								sql = sql + "parent_id='" + ids.get(k) + "'";
							} else {
								sql = sql + " or parent_id='" + ids.get(k)
										+ "'";
							}
							System.out.println("进入了循环IDS组装SQL方法  k:" + k);
							if (k == ids.size()) {
								System.out.println("清空了ids");
								ids.clear();
							}
						}
						sql += ")";
						list = query(sql, YW, new Object[] { listitem.get(j)
								.get("fymc") });

					}
				}

				result.append("<td>").append(list.get(0).get("fy"))
						.append("</td><td>").append(list.get(0).get("jzgm"))
						.append("</td><td>").append(list.get(0).get("djzyzj"))
						.append("</td><td>").append(list.get(0).get("qtfy"))
						.append("</td><td>").append(list.get(0).get("zj"))
						.append("</td>");
			}
			result.append("<td>").append(jyfy).append("</td><td>")
					.append(jyjzgm).append("</td><td>").append(zyzj)
					.append("</td><td>").append(jyqtfy).append("</td><td>")
					.append(zj).append("</td><td>").append(bz).append("</td>")
					.append("<td style='display:none'>").append(yw_guid)
					.append("</td>");
		}
		return result.toString();
	}

	public String getTotal(String keyword) {
		return getBody(true, keyword);
	}

	public void delByYwGuid() {
		String yw_guid = request.getParameter("yw_guid");
		yw_guid = UtilFactory.getStrUtil().unescape(yw_guid);
		String[] mcs = yw_guid.substring(0, yw_guid.length() - 1).split(",");
		try {
			for (int i = 0; i < mcs.length; i++) {
				String sql_sub = "delete from fyzc_fy t where t.parent_id='"
						+ mcs[i] + "'";
				this.update(sql_sub, YW);
				String sql = "delete from fyzc t where t.yw_guid='" + mcs[i]
						+ "'";
				this.update(sql, YW);
			}
			response("success");
		} catch (Exception e) {
			response("false");
		}

	}

	public void quryKeyWord() {
		String keyword = UtilFactory.getStrUtil().unescape(
				request.getParameter("keyword"));
		keyword = keyword.replace(" ", "");
		String queryResult = getList(keyword);

		response(queryResult);
		/*
		 * String keyword = request.getParameter("keyword"); keyword =
		 * UtilFactory.getStrUtil().unescape(keyword); String sql =
		 * "select distinct jzrq from fyzc"; List<Map<String, Object>> list2 =
		 * query(sql, YW); String jzrq = (String) (list2.get(0)).get("jzrq");
		 * StringBuffer result = new StringBuffer(
		 * "<table id='FYZC' width='2000' border='1' cellpadding='1' cellspacing='0'>"
		 * +
		 * "<tr class='title' onclick='showMap(this); return false;' ondblclick='editMap(this); return false;'><td rowspan='2' colspan='1' class='tr01'>名称</td><td colspan='4' rowspan='1' class='tr01'>购置情况</td><td colspan='2' rowspan='1' class='tr01'>利用情况</td><td colspan='3' rowspan='1' class='tr01'>期末存量情况</td><td  class='tr01'><input id='jzrq' style='border:0;background:transparent;' value="
		 * + jzrq +
		 * "></td><td rowspan='1' colspan='5' class='tr01'>其他费用</td><td rowspan='2' colspan='1' class='tr01'>房屋价款总计</td><td rowspan='2' colspan='1' class='tr01'>当前单价</td><td rowspan='2' colspan='1' class='tr01'>备注</td></tr><tr><td colspan='1' rowspan='1' class='tr01'>房源套数</td><td colspan='1' rowspan='1' class='tr01'>建筑规模</td><td colspan='1' rowspan='1' class='tr01'>动用储备资金</td><td colspan='1' rowspan='1' class='tr01'>购置单价</td><td colspan='1' rowspan='1' class='tr01'>房源套数</td><td colspan='1' rowspan='1' class='tr01'>建筑规模</td><td colspan='1' rowspan='1' class='tr01'>房源套数</td><td colspan='1' rowspan='1' class='tr01'>建筑面积</td><td colspan='1' rowspan='1' class='tr01'>占压资金</td><td colspan='1' rowspan='1' class='tr01'>分摊利息</td><td colspan='1' rowspan='1' class='tr01'>费用名称</td><td colspan='1' rowspan='1' class='tr01'>总金额</td><td colspan='1' rowspan='1' class='tr01'>每平米分摊</td><td colspan='1' rowspan='1' class='tr01'>已利用房源分摊</td><td colspan='1' rowspan='1' class='tr01'>结转房源分摊</td></tr>"
		 * ); String qurysql =
		 * "select t.mc,t.gzfy,t.gzgm,t.cbzj,t.gzdj,t.jzmj,t.zyzj,t.pmft,t.lyft,t.ze,t.lyfy,t.lygm,t.dj,t.qmfy,t.ftlx,t.fymc,t.jzft,t.jkzj,t.bz,t.yw_guid from fyzc t where t.mc like '%"
		 * + keyword + "%'"; List<Map<String, Object>> qurylist = query(qurysql,
		 * YW); for (int i = 0; i < qurylist.size(); i++) { String mc = (String)
		 * (qurylist.get(i)).get("mc"); String gzfy = (String)
		 * (qurylist.get(i)).get("gzfy"); String gzgm = (String)
		 * (qurylist.get(i)).get("gzgm"); String cbzj = (String)
		 * (qurylist.get(i)).get("cbzj"); String gzdj = (String)
		 * (qurylist.get(i)).get("gzdj"); String jzmj = (String)
		 * (qurylist.get(i)).get("jzmj"); String zyzj = (String)
		 * (qurylist.get(i)).get("zyzj"); String pmft = (String)
		 * (qurylist.get(i)).get("pmft"); String lyft = (String)
		 * (qurylist.get(i)).get("lyft"); String ze = (String)
		 * (qurylist.get(i)).get("ze"); String lyfy = (String)
		 * (qurylist.get(i)).get("lyfy"); String lygm = (String)
		 * (qurylist.get(i)).get("lygm"); String dj = (String)
		 * (qurylist.get(i)).get("dj"); String qmfy = (String)
		 * (qurylist.get(i)).get("qmfy"); String ftlx = (String)
		 * (qurylist.get(i)).get("ftlx"); String fymc = (String)
		 * (qurylist.get(i)).get("fymc"); String jzft = (String)
		 * (qurylist.get(i)).get("jzft"); String jkzj = (String)
		 * (qurylist.get(i)).get("jkzj"); String bz = (String)
		 * (qurylist.get(i)).get("bz"); result .append(
		 * "<tr class='trsingle' onclick='showMap(this); return false;' ondblclick='editMap(this); return false;'><td>"
		 * + mc + "</td><td>" + gzfy + "</td><td>" + gzgm + "</td><td>" + cbzj +
		 * "</td><td>" + gzdj + "</td><td>" + lyfy + "</td><td>" + lygm +
		 * "</td><td>" + qmfy + "</td><td>" + jzmj + "</td><td>" + zyzj +
		 * "</td><td>" + ftlx + "</td><td>" + fymc + "</td><td>" + ze +
		 * "</td><td>" + pmft + "</td><td>" + lyft + "</td><td>" + jzft +
		 * "</td><td>" + jkzj + "</td><td>" + dj + "</td><td>" + bz +
		 * "</td></tr>"); } result .append(
		 * "<tr><td class='tr01'>总计</td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td><td class='tr01'></td></tr></table>"
		 * ); response(result.toString().replaceAll("null", ""));
		 */
	}

	/**
	 * 获取房源资产子项的个数
	 * 
	 * @return
	 */
	public List<Map<String, Object>> getfyxm() {
		String sql = "select distinct fymc from fyzc_fy ";
		return query(sql, YW);
	}

	/**
	 * 获取所有房源资产项目的数据
	 * 
	 * @return
	 */
	public void getAllMc() {
		String sql = "select * from fyzc";
		response(query(sql, YW));
	}

	/**
	 * 获取所有房源子项目数据
	 * 
	 * @return
	 */
	public void getAllMc_fy() {
		String sql = "select * from fyzc_fy";
		response(query(sql, YW));
	}

	public String getFirstTile() {
		List<Map<String, Object>> list = getfyxm();
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer
				.append("<table id='FYZC' width='1800' border='1' cellpadding='1' cellspacing='0'>");
		stringBuffer
				.append("<tr class='title'><td rowspan='3' class='tr01'>名      称</td><td colspan='6' rowspan='2'"
						+ " class='tr01'>房源筹集情况</td><td colspan='"
						+ list.size()
						* 5
						+ "'  class='tr01'>房源使用情况</td><td colspan='5'"
						+ " rowspan='2' class='tr01'>房源结余情况</td><td rowspan='3' colspan='1' class='tr01'>备注</td><td style='display:none'>guid</td></tr>");
		return stringBuffer.toString();
	}

	public String getSecondTile() {
		List<Map<String, Object>> list = getfyxm();
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("<tr  class='title'>");
		for (int i = 0; i < list.size(); i++) {
			stringBuffer.append("<td colspan='5' rowspan='1' class='tr01'>"
					+ list.get(i).get("fymc") + "使用情况</td>");
		}
		stringBuffer.append("</tr>");
		return stringBuffer.toString();
	}

	public String getThirdTitle() {
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer
				.append("<tr  class='title'><td colspan='1'"
						+ " rowspan='1' class='tr01'>来源</td><td colspan='1' rowspan='1' class='tr01'>房源(套)</td>"
						+ "<td colspan='1' rowspan='1' class='tr01'>建筑规模<br>(万㎡)</td><td colspan='1' rowspan='1' "
						+ "class='tr01'>房屋单价<br>(万元/㎡)</td><td colspan='1' rowspan='1' class='tr01'>动用储备<br>资金(亿元)</td><td colspan='1'"
						+ " rowspan='1' class='tr01'>其他费用<br>(亿元)</td>");
		List<Map<String, Object>> list = getfyxm();
		for (int j = 0; j < list.size(); j++) {
			for (int i = 0; i < titles.length; i++) {
				stringBuffer
						.append("<td colspan='1'"
								+ " rowspan='1' class='tr01'>" + titles[i][0]
								+ "</td>");
			}
		}
		stringBuffer
				.append("<td colspan='1' rowspan='1' class='tr01'>房源(套)</td>"
						+ "<td colspan='1' rowspan='1' class='tr01'>建筑规模<br>(万㎡)</td><td colspan='1' rowspan='1' class='tr01'>"
						+ "占压资金<br>(亿元)</td><td colspan='1' rowspan='1' class='tr01'>其他费用<br>(亿元)</td><td colspan='1' rowspan='1'"
						+ " class='tr01'>总计<br>(亿元)</td></tr>");
		return stringBuffer.toString();
	}
}
