package com.klspta.web.cbd.xmgl.zjgl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

/*******************************************************************************
 * 
 * <br>
 * Title:资金管理数据库交互类 <br>
 * Description:查、跟新等操作 <br>
 * Author:朱波海 <br>
 * Date:2013-12-26
 */
public class ZjglData extends AbstractBaseBean {
	private String lr_name[] = {"Ⅰ.资金流入", "1.1 筹融资金", "1.1.1 金融机构贷款", "1.1.2 实施主体带资",
			"1.1.3 国有土地收益基金", "1.2 出让回笼资金", "1.3 其他资金" };
	private String lr_type[] = {"ZJLR", "CRZJ", "JRJGDK", "SSZTDZ", "GYTDSYJJ", "CRHLZJ", "QTZJ" };
	private String lr_parent_id[] = {"0", "ZJLR", "CRZJ", "CRZJ", "CRZJ", "ZJLR", "ZJLR"};
	
	private String lr_leval[] = {"1","2","3","3","3","2","2"};
	
	private String zc_chaild[] = { "总计划审批", "贷款审批", "实施主体带资审批", "国有土地收益基金审批",
			"出让回笼资金审批", "其他资金审批", "实际支付", "已批未付" };
	private String zc_parent[] = {"Ⅱ.资金支出", "2.1 一级开发支出" ,"2.1.1 前期费用", "2.1.2 拆迁费用", "2.1.3 收储费用",
			"2.1.4 市政费用", "2.1.5 财务费用", "2.1.6 管理费用", "2.2 筹融资金返还", "2.3 其他支出" };
	private String zc_type[] = {"ZJZC", "YJKFZC", "QQFY", "CQFY", "SCFY", "SZFY", "CWFY",
			"GLFY", "CRZJFH", "QTZC" };
	private String zc_parent_id[] = {"0", "ZJZC", "YJKFZC", "YJKFZC", "YJKFZC", "YJKFZC", "YJKFZC", "YJKFZC", "ZJZC", "ZJZC"};
	
	private String zc_leval[] = {"1", "2" ,"3" ,"3" ,"3", "3", "3", "3", "2", "2"};
	
	static String[] months = {"CQYE", "YY", "EY", "SANY", "SIY", "WY", "LY", "QY","BAY", "JY", "SIYUE", "SYY", "SEY" ,"LRSP" };

	public List<Map<String, Object>> getZJGL_ZJLR(String yw_guid, String year) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		String sql = "";
		List<Map<String,Object>> querys = null;
		sql = "select * from xmzjgl_lr_view where yw_guid=? and rq=? order by tree_name desc";
		querys = query(sql, YW, new Object[] {
				yw_guid, year });
		for (int i = querys.size() - 1; i >= 0; i--) {
			list.add(querys.get(i));
		}
		return list;
	}

	public List<Map<String, Object>> getZJZC_father(String yw_guid,String type, String year) {
		int cols[] = { 0, 0, 0, 0, 0, 0, 0, 0 };
		List<Map<String, Object>> list =null;
		if("1".equals(yw_guid)){
//			String sql = "select t.tree_name as tree_name,  t.lj as lj, sum(t.YSFY) as ysfy,sum(t.ZJJD) as zjjd ,sum(t.CQYE) as cqye,sum(t.YFSDZ) as yfsdz,"+
//           "sum(t.yy) as yy ,sum(t.ey) as ey,sum(t.sany) as sany,sum(t.siy) as siy,"+
//          "sum(t.wy) as wy,sum(t.ly) as ly,sum(t.qy) as qy,sum(t.bay) as bay,sum(t.jy) as jy"+
//          ",sum(t.siyue) as siyue,sum(t.syy) as syy ,sum(t.sey) as sey ,sum(t.LRSP) as lrsp,sum(t.jl2) as jl2 "+
//           "from xmzjgl_zc_view t,jc_xiangmu j  where t.tree_id=? and t.yw_guid=j.yw_guid  and t.rq=?"+
//           "group by t.tree_name,t.lj";
			String sql = "select t.tree_name as tree_name ,t.tree_id as tree_id ,t.sort as sort,t.parent_id as parent_id from xmzjgl_zc_view t,jc_xiangmu j  where t.tree_id=? and t.yw_guid=j.yw_guid  and t.rq=? ";
			list = query(sql, YW, new Object[] { type,year });
		}else{
			String sql = "select t.tree_name as tree_name,t.tree_id as tree_id ,t.lj as lj,t.sort as sort,t.parent_id as parent_id from  XMZJGL_ZC_view t where tree_id=? and yw_guid=?  and rq=? order by  sort";
			list = query(sql, YW, new Object[] { type, yw_guid, year });
		}
		return list;
	}
	
	public List<Map<String, Object>> getZJLR_father(String yw_guid,String type, String year) {
		int cols[] = { 0, 0, 0, 0, 0, 0, 0, 0 };
		List<Map<String, Object>> list =null;
		if("1".equals(yw_guid)){
//			String sql = "select t.tree_name as tree_name,  t.lj as lj, sum(t.YSFY) as ysfy,sum(t.ZJJD) as zjjd ,sum(t.CQYE) as cqye,sum(t.YFSDZ) as yfsdz,"+
//           "sum(t.yy) as yy ,sum(t.ey) as ey,sum(t.sany) as sany,sum(t.siy) as siy,"+
//          "sum(t.wy) as wy,sum(t.ly) as ly,sum(t.qy) as qy,sum(t.bay) as bay,sum(t.jy) as jy"+
//          ",sum(t.siyue) as siyue,sum(t.syy) as syy ,sum(t.sey) as sey ,sum(t.LRSP) as lrsp,sum(t.jl2) as jl2 "+
//           "from xmzjgl_zc_view t,jc_xiangmu j  where t.tree_id=? and t.yw_guid=j.yw_guid  and t.rq=?"+
//           "group by t.tree_name,t.lj";
			String sql = "select t.tree_name as tree_name ,t.tree_id as tree_id , t.parent_id as parent_id from xmzjgl_lr_view t,jc_xiangmu j  where t.tree_id=? and t.yw_guid=j.yw_guid  and t.rq=? ";
			list = query(sql, YW, new Object[] { type,year });
		}else{
			String sql = "select t.tree_name as tree_name,t.tree_id as tree_id ,t.lj as lj,t.parent_id as parent_id from  XMZJGL_LR_view t where tree_id=? and yw_guid=?  and rq=? ";
			list = query(sql, YW, new Object[] { type, yw_guid, year });
		}
		return list;
	}

	public List<Map<String, Object>> getZJZC_child(String yw_guid,String tree_name, String parent_id, String year) {
		String sql = "";
		List<Map<String, Object>> list = null;
		if("1".equals(yw_guid)){
			sql = "select t.tree_name as tree_name,  t.lj as lj, sum(t.YSFY) as ysfy,sum(t.ZJJD) as zjjd ,sum(t.CQYE) as cqye,sum(t.YFSDZ) as yfsdz,"+
           "sum(t.yy) as yy ,sum(t.ey) as ey,sum(t.sany) as sany,sum(t.siy) as siy,"+
          "sum(t.wy) as wy,sum(t.ly) as ly,sum(t.qy) as qy,sum(t.bay) as bay,sum(t.jy) as jy"+
          ",sum(t.siyue) as siyue,sum(t.syy) as syy ,sum(t.sey) as sey ,sum(t.LRSP) as lrsp "+
           "from xmzjgl_zc_view t,jc_xiangmu j  where t.parent_id=? and t.yw_guid=j.yw_guid  and t.rq=?"+
           "group by t.tree_name,t.lj";
			list = query(sql, YW, new Object[] {  parent_id, year });
		}else{
			int cols[] = { 0, 0, 0, 0, 0, 0, 0, 0 }; 
			
			sql = "select * from  XMZJGL_ZC_view where parent_id=? and yw_guid=? and tree_name=? and rq=? " +
					" order by  sort ";
			list = query(sql, YW, new Object[] { parent_id, yw_guid, tree_name, year });
			if (list.size() == 8) {
				for( int i = 0; i < months.length; i++){
					for (int j = 0; j < 8; j++) {
						cols[j] = Integer.parseInt(list.get(j).get(months[i]).toString());
					}
					list.get(0).remove(months[i]);
					list.get(0).put(months[i], cols[1] + cols[2] + cols[3] + cols[4] + cols[5]);
					
					list.get(7).remove(months[i]);
					list.get(7).put(months[i], cols[1] + cols[2] + cols[3] + cols[4] + cols[5] - cols[6]);
				}
				for (int i = 0; i < 8; i++) {
					cols[i] = Integer.parseInt(list.get(i).get("JL2").toString());
				}
				list.get(0).remove("JL2");
				list.get(0).put("JL2", cols[1] + cols[2] + cols[3] + cols[4] + cols[5]);
				list.get(7).remove("JL2");
				list.get(7).put("JL2", cols[1] + cols[2] + cols[3] + cols[4] + cols[5] - cols[6]);
				list.get(0).remove("YFSDZ");
				list.get(0).put("YFSDZ", cols[6]+"");
				list.get(0).remove("ZJJD");
				double ysfy = Double.parseDouble(list.get(0).get("YSFY")==null? "0" :list.get(0).get("YSFY").toString());
				DecimalFormat df = new DecimalFormat("#.00");
				list.get(0).put("ZJJD",ysfy==0? "0" : df.format(cols[6]/ysfy*100) +"%");
			}
		}
		return list;
	}
	
	public List<Map<String, Object>> getZJLR_child(String yw_guid,String tree_name, String parent_id, String year) {
		String sql = "";
		List<Map<String, Object>> list = null;
		if("1".equals(yw_guid)){
			sql = "select t.tree_name as tree_name,  t.lj as lj, sum(t.YSFY) as ysfy,sum(t.ZJJD) as zjjd ,sum(t.CQYE) as cqye,sum(t.YFSDZ) as yfsdz,"+
           "sum(t.yy) as yy ,sum(t.ey) as ey,sum(t.sany) as sany,sum(t.siy) as siy,"+
          "sum(t.wy) as wy,sum(t.ly) as ly,sum(t.qy) as qy,sum(t.bay) as bay,sum(t.jy) as jy"+
          ",sum(t.siyue) as siyue,sum(t.syy) as syy ,sum(t.sey) as sey ,sum(t.LRSP) as lrsp "+
           "from xmzjgl_zc_view t,jc_xiangmu j  where t.parent_id=? and t.yw_guid=j.yw_guid  and t.rq=?"+
           "group by t.tree_name,t.lj";
			list = query(sql, YW, new Object[] {  parent_id, year });
		}else{
			sql = "select * from  XMZJGL_LR_view where parent_id=? and yw_guid=? and tree_name=? and rq=? ";
			list = query(sql, YW, new Object[] { parent_id, yw_guid, tree_name, year });
		}
		return list;
	}

	public void setMXZC(String yw_guid, String year) {
		if (yw_guid != null && !yw_guid.equals("")) {
			String sql = "select yw_guid from XMZJGL_ZC_view where yw_guid=? and rq=?";
			List<Map<String, Object>> query = query(sql, YW, new Object[] {
					yw_guid, year });
			if (query.size() > 0) {
			} else {
				for (int i = 0; i < zc_parent.length; i++) {
					for (int j = 0; j < zc_chaild.length; j++) {
						String sqlString = "insert into XMZJGL_ZC (yw_guid,tree_id,tree_name,lj,sort,rq,parent_id,leval) values(?,?,?,?,?,?,?,?)";
						update(sqlString, YW, new Object[] { yw_guid,zc_type[i], zc_parent[i], zc_chaild[j], (j + 1), year ,zc_parent_id[i],zc_leval[i]});
					}
				}
			}
		}
	}
	
	
	public void setMXLR(String yw_guid, String year) {
		if (yw_guid != null && !yw_guid.equals("")) {
			String sql = "select yw_guid from XMZJGL_LR_view where yw_guid=? and rq=?";
			List<Map<String, Object>> query = query(sql, YW, new Object[] {
					yw_guid, year });
			if (query.size() > 0) {
			} else {
				for (int i = 0; i < lr_name.length; i++) {
					String sqlString = "insert into XMZJGL_LR (yw_guid, tree_id, tree_name, rq,parent_id, leval) values(?,?,?,?,?,?)";
					update(sqlString, YW, new Object[] { yw_guid, lr_type[i], lr_name[i], year ,lr_parent_id[i], lr_leval[i]});
				}
			}
		}
	}

	public void saveNode(String tree_name, String type, String yw_guid,
			String year) {
		if (!(type.equals("ZJLR") || tree_name.startsWith("1"))) {
			for (int j = 0; j < zc_chaild.length; j++) {
				String sqlString = "insert into XMZJGL_ZC (yw_guid,tree_id,tree_name,lj,zcstatus,sort ,rq) values(?,?,?,?,?,?,?)";
				update(sqlString, YW, new Object[] { yw_guid, type, tree_name,
						zc_chaild[j], type, (j + 1), year });
			}
		} else {
			String sqlString = "insert into XMZJGL_LR (yw_guid,tree_id,tree_name,rq) values(?,?,?,?)";
			update(sqlString, YW, new Object[] { yw_guid, tree_name, tree_name,
					year });
		}
	}

	public List<Map<String, Object>> getLR_sum(String yw_guid, String year) {
		String sql = "";
		List<Map<String,Object>> query = null;
		if(!"1".equals(yw_guid)){
			sql = "select 'Ⅰ.资金流入' as tree_name,sum(ysfy) as ysfy,sum(lj) as lj,sum(yfsdz)as yfsdz,sum(zjjd) as zjjd," +
					"sum(cqye)as cqye ,sum(yy)as yy,sum(ey)as ey,sum(sany)as sany,sum(siy)as siy,sum(wy)as wy,sum(ly)as ly ," +
					"sum(qy)as qy ,sum(bay)as bay,sum(jy)as jy,sum(siyue)as siyue,sum(syy)as syy,sum(sey)as sey ," +
					"sum(lrsp)as lrsp   from xmzjgl_lr_view t where yw_guid=? and rq=?";
			query = query(sql, YW, new Object[] {
					yw_guid, year });
		}else{
			sql = "select 'Ⅰ.资金流入' as tree_name,sum(t.ysfy) as ysfy,sum(t.lj) as lj,sum(t.yfsdz)as yfsdz," +
					"sum(t.zjjd) as zjjd,sum(t.cqye)as cqye ,sum(t.yy)as yy,sum(t.ey)as ey,sum(t.sany)as sany," +
					"sum(t.siy)as siy,sum(t.wy)as wy,sum(t.ly)as ly ,sum(t.qy)as qy ,sum(t.bay)as bay,sum(t.jy)as jy," +
					"sum(t.siyue)as siyue,sum(t.syy)as syy,sum(t.sey)as sey ,sum(t.lrsp)as lrsp   " +
					"from xmzjgl_lr_view t,jc_xiangmu j  where t.yw_guid=j.yw_guid and t.rq=?";
			query = query(sql, YW, new Object[] { year });
		}
		return query;
	}

	public List<Map<String, Object>> getZC_sum(String yw_guid, String year) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		int cols[] = { 0, 0, 0, 0, 0, 0, 0, 0 };
		if ("1".equals(yw_guid)) {
			for (int i = 1; i < 9; i++) {
				String sql = "select 'Ⅱ.资金支出' as tree_name,sum(ysfy) as ysfy,'"
						+ zc_chaild[i - 1]
						+ "' as lj,sum(jl2) as jl2 ,sum(yfsdz)as yfsdz,sum(zjjd) as zjjd,sum(cqye)as cqye ,sum(yy)as yy," +
								"sum(ey)as ey,sum(sany)as sany,sum(siy)as siy,sum(wy)as wy,sum(ly)as ly ,sum(qy)as qy ," +
								"sum(bay)as bay,sum(jy)as jy,sum(siyue)as siyue,sum(syy)as syy,sum(sey)as sey ," +
								"sum(lrsp)as lrsp   from XMZJGL_ZC_view t,jc_xiangmu j  where t.yw_guid=j.yw_guid  and sort=?" +
								" and rq=?";
				List<Map<String, Object>> query = query(sql, YW, new Object[] {i, year });
				list.add(query.get(0));
				cols[i - 1] = Integer.parseInt(query.get(0).get("JL2") == null ? "0" : query.get(0).get("JL2").toString());
			}
		} else {
			for (int i = 1; i < 9; i++) {
				String sql = "select 'Ⅱ.资金支出' as tree_name,sum(ysfy) as ysfy,'"
						+ zc_chaild[i - 1]
						+ "' as lj,sum(jl2) as jl2 ,sum(yfsdz)as yfsdz,sum(zjjd) as zjjd,sum(cqye)as cqye ,sum(yy)as yy," +
								"sum(ey)as ey,sum(sany)as sany,sum(siy)as siy,sum(wy)as wy,sum(ly)as ly ,sum(qy)as qy ," +
								"sum(bay)as bay,sum(jy)as jy,sum(siyue)as siyue,sum(syy)as syy,sum(sey)as sey ,sum(lrsp)as lrsp" +
								"   from XMZJGL_ZC_view t where yw_guid=? and sort=? and rq=?";
				List<Map<String, Object>> query = query(sql, YW, new Object[] { yw_guid, i, year });
				list.add(query.get(0));
				cols[i - 1] = Integer.parseInt(query.get(0).get("JL2") == null ? "0" : query.get(0).get("JL2").toString());
			}
		}
		list.get(0).remove("JL2");
		list.get(0).put("JL2", cols[1] + cols[2] + cols[3] + cols[4] + cols[5]);
		list.get(7).remove("JL2");
		list.get(7).put("JL2", cols[1] + cols[2] + cols[3] + cols[4] + cols[5] - cols[6]);
		list.get(0).remove("YFSDZ");
		list.get(0).put("YFSDZ", cols[6]+"");
		list.get(0).remove("ZJJD");
		double ysfy = Double.parseDouble(list.get(0).get("YSFY")==null? "0" :list.get(0).get("YSFY").toString());
		list.get(0).put("ZJJD",ysfy==0? "0" : cols[6]/ysfy +"");
		return list;
	}

	public List<Map<String, Object>> getZC_YJZC_sum(String yw_guid, String year,String type) {
		int cols[] = { 0, 0, 0, 0, 0, 0, 0, 0 };
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		if ("1".equals(yw_guid)) {
			for (int i = 1; i < 9; i++) {
				String sql = "select '"+type+"' as tree_name,sum(ysfy) as ysfy,'"
						+ zc_chaild[i - 1]
						+ "' as lj,sum(jl2) as jl2 ,sum(yfsdz)as yfsdz,sum(zjjd) as zjjd," +
								"sum(cqye)as cqye ,sum(yy)as yy,sum(ey)as ey,sum(sany)as sany," +
								"sum(siy)as siy,sum(wy)as wy,sum(ly)as ly ,sum(qy)as qy ," +
								"sum(bay)as bay,sum(jy)as jy,sum(siyue)as siyue,sum(syy)as syy," +
								"sum(sey)as sey ,sum(lrsp)as lrsp   from XMZJGL_ZC_view t,jc_xiangmu j " +
								" where ( t.yw_guid=j.yw_guid  and sort=? and tree_id !='QTZC' and tree_id !='CRZJFH' and rq=?)" +
								" or (t.yw_guid=j.yw_guid  and sort=? and parent_id in ('QQFY','CQFY,'SZFY','SCFY','GLFY','CWFY' and rq = ?) ";
				List<Map<String, Object>> query = query(sql, YW, new Object[] { i, year,i,year });
				list.add(query.get(0));
				cols[i - 1] = Integer.parseInt(query.get(0).get("JL2") == null ? "0" : query.get(0).get("JL2").toString());
			}
		} else {
			for (int i = 1; i < 9; i++) {
				String sql = "select '"+type+"' as tree_name,sum(ysfy) as ysfy,'"
						+ zc_chaild[i - 1]
						+ "' as lj,sum(jl2) as jl2 ,sum(yfsdz)as yfsdz,sum(zjjd)" +
								" as zjjd,sum(cqye)as cqye ,sum(yy)as yy,sum(ey)as" +
								" ey,sum(sany)as sany,sum(siy)as siy,sum(wy)as wy,sum(ly)as ly ," +
								"sum(qy)as qy ,sum(bay)as bay,sum(jy)as jy,sum(siyue)as siyue," +
								"sum(syy)as syy,sum(sey)as sey ,sum(lrsp)as lrsp  " +
								" from XMZJGL_ZC_view t where ( yw_guid=? and sort=? and " +
								"tree_id !='QTZC' and tree_id !='CRZJFH' and rq=?) or ( yw_guid=? " +
								"and sort=? and parent_id in ('QQFY','CQFY','SZFY','SCFY','GLFY','CWFY') and rq = ?)";
				List<Map<String, Object>> query = query(sql, YW, new Object[] { yw_guid, i, year ,yw_guid,i,year });
				list.add(query.get(0));
				cols[i - 1] = Integer.parseInt(query.get(0).get("JL2") == null ? "0" : query.get(0).get("JL2").toString());
			}
		}
		list.get(0).remove("JL2");
		list.get(0).put("JL2", cols[1] + cols[2] + cols[3] + cols[4] + cols[5]);
		list.get(7).remove("JL2");
		list.get(7).put("JL2",cols[1] + cols[2] + cols[3] + cols[4] + cols[5] - cols[6]);
		list.get(0).remove("YFSDZ");
		list.get(0).put("YFSDZ", cols[6]+"");
		list.get(0).remove("ZJJD");
		double ysfy = Double.parseDouble(list.get(0).get("YSFY")==null? "0" :list.get(0).get("YSFY").toString());
		list.get(0).put("ZJJD",ysfy==0? "0" : cols[6]/ysfy +"");
		return list;
	}
	
	public List<Map<String, Object>> getZC_3JZC_sum(String yw_guid, String year,String type) {
		int cols[] = { 0, 0, 0, 0, 0, 0, 0, 0 };
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		if ("1".equals(yw_guid)) {
			for (int i = 1; i < 9; i++) {
				String sql = "select '"+type+"' as tree_name,sum(ysfy) as ysfy,'"
						+ zc_chaild[i - 1]
						+ "' as lj,sum(jl2) as jl2 ,sum(yfsdz)as yfsdz,sum(zjjd) as zjjd," +
								"sum(cqye)as cqye ,sum(yy)as yy,sum(ey)as ey,sum(sany)as sany," +
								"sum(siy)as siy,sum(wy)as wy,sum(ly)as ly ,sum(qy)as qy ," +
								"sum(bay)as bay,sum(jy)as jy,sum(siyue)as siyue,sum(syy)as syy," +
								"sum(sey)as sey ,sum(lrsp)as lrsp   from XMZJGL_ZC_view t,jc_xiangmu j " +
								" where t.yw_guid=j.yw_guid  and sort=? and (parent_id = '"+type+"' and rq=?)";
				List<Map<String, Object>> query = query(sql, YW, new Object[] { i, year });
				list.add(query.get(0));
				cols[i - 1] = Integer.parseInt(query.get(0).get("JL2") == null ? "0" : query.get(0).get("JL2").toString());
			}
		} else {
			for (int i = 1; i < 9; i++) {
				String sql = "select '"+type+"' as tree_name,sum(ysfy) as ysfy,'"
						+ zc_chaild[i - 1]
						+ "' as lj,sum(jl2) as jl2 ,sum(yfsdz)as yfsdz,sum(zjjd)" +
								" as zjjd,sum(cqye)as cqye ,sum(yy)as yy,sum(ey)as" +
								" ey,sum(sany)as sany,sum(siy)as siy,sum(wy)as wy,sum(ly)as ly ," +
								"sum(qy)as qy ,sum(bay)as bay,sum(jy)as jy,sum(siyue)as siyue," +
								"sum(syy)as syy,sum(sey)as sey ,sum(lrsp)as lrsp  " +
								" from XMZJGL_ZC_view t where yw_guid=? and sort=? and " +
								"(parent_id = '"+type+"' and rq=?)";
				List<Map<String, Object>> query = query(sql, YW, new Object[] { yw_guid, i, year });
				list.add(query.get(0));
				cols[i - 1] = Integer.parseInt(query.get(0).get("JL2") == null ? "0" : query.get(0).get("JL2").toString());
			}
		}
		list.get(0).remove("JL2");
		list.get(0).put("JL2", cols[1] + cols[2] + cols[3] + cols[4] + cols[5]);
		list.get(7).remove("JL2");
		list.get(7).put("JL2",cols[1] + cols[2] + cols[3] + cols[4] + cols[5] - cols[6]);
		list.get(0).remove("YFSDZ");
		list.get(0).put("YFSDZ", cols[6]+"");
		list.get(0).remove("ZJJD");
		double ysfy = Double.parseDouble(list.get(0).get("YSFY")==null? "0" :list.get(0).get("YSFY").toString());
		list.get(0).put("ZJJD",ysfy==0? "0" : cols[6]/ysfy +"");
		return list;
	}
}
