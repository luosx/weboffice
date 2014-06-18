package com.klspta.web.cbd.xmgl;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.xmgl.zjgl.XmzjglTreeBean;

public class Xmmanager extends AbstractBaseBean {
	public static String ZJGL_LR[] = { "LB", "YSFY", "LJ", "YFSDZ", "ZJJD",
			"CQYE", "YY", "EY", "SANY", "SIY", "WY", "LY", "QY", "BAY", "JY",
			"SIYUE", "SYY", "SEY", "LRSP" };

	public static String ZJGL_ZC[] = { "LB", "YSFY",  "YFSDZ",
			"ZJJD", "CQYE", "YY", "EY", "SANY", "SIY", "WY", "LY", "QY", "BAY",
			"JY", "SIYUE", "SYY", "SEY", "LRSP" };

	public static String ZJGL_ZJZC;

	public static Xmmanager instens;

	private Xmmanager() {
	}

	public static Xmmanager getXmmanager() {
		if (instens == null) {
			return new Xmmanager();
		} else {
			return instens;
		}
	}

	public void init() {
		// ArrayList<?> arrayList = new ArrayList<?>();
		// 获取全部支出yw_guid
		String sql = "select distinct yw_guid  from  xmzjgl where status='zc'";
		List<Map<String, Object>> list = query(sql, YW);
		// t.zcstatus
		for (int i = 0; i < list.size(); i++) {
			String yw_guid = list.get(i).get("yw_guid").toString();
			// 一个项目的所有lb
			String lxsql = "select distinct lb  from  xmzjgl where status='zc' and yw_guid=?";
			List<Map<String, Object>> lblist = query(lxsql, YW,
					new Object[] { yw_guid });
			for (int j = 0; j < lblist.size(); j++) {

			}

		}

	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:项目管理中——办理过程 <br>
	 * Author:朱波海 <br>
	 * Date:2013-12-16
	 */
	public List<Map<String, Object>> getBLGC(String yw_guid) {
		String sql = "select * from xmblgc where xmid=?  order  by  blsj ";
		List<Map<String, Object>> list = query(sql, YW,
				new Object[] { yw_guid });
		return list;
	}
	
	/***************************************************************************
	 * 
	 * <br>
	 * Description:项目管理中——办理过程 <br>
	 * Author:李国明 <br>
	 * Date:2014-2-16
	 */
	public void getBLGCByKey() {
		String key = request.getParameter("key");
		String xmid = request.getParameter("xmid");
		key = UtilFactory.getStrUtil().unescape(key);
		String sql  = "";
		List<Map<String,Object>> list = null;
		if(key==""){
			sql = "select * from xmblgc where xmid=? order by blsj";
			list = query(sql, YW,new Object[]{xmid});
		}else{
			sql = "select * from xmblgc where xmid=? and blsj||sjbl||bmjbr||bz like ?  order  by  blsj ";
			list = query(sql, YW,
					new Object[] { xmid,"%"+key+"%" });
		}
		 
		StringBuffer sb = new StringBuffer();
		sb.append("<table width='800' cellpadding='1' cellspacing='0' id='esftable' border='1'>"+
				"<tr class='title' onclick='showMap(this); return false;' ondblclick='editMap(this); return false;'>"+
					"<td align='center' width='80px' height='50px' ><h3>序号</h3></td>"+
					"<td align='center' width='90px'><h3>时间</h3></td>"+
					"<td align='center' width='500px><h3>事件</h3></td>"+
					"<td align='center' width='120px'><h3>部门/经办人</h3></td>"+
					"<td align='center' width='200px'><h3>备注</h3></td>"+
					"<td align='center' width='200px' style='display: none;><h3>yw_guid</h3></td>"+
				"</tr>");
		if (list != null) {
	        for (int i = 0; i < list.size(); i++) {
	        	sb.append("<tr align='center' class='trsingle' id='row").append(i).append("' onclick='showMap(this); return false;' ondblclick='editMap(this); return false;'>")
					.append("<td align='center' width='80px' >").append(i+1).append("</td>")
					.append("<td align='center' width='80px>").append(list.get(i).get("blsj")).append("</td>")
					.append("<td align='center' width='500px'>").append(list.get(i).get("sjbl")).append("</td>")
					.append("<td align='center' width='80px'>").append(list.get(i).get("bmjbr")).append("</td>")
					.append("<td align='center' width='200px'>").append(list.get(i).get("bz")).append("</td>")
					.append("<td align='center' width='200px' style='display: none;'>").append(list.get(i).get("yw_guid")).append("</td>")
				.append("</tr>");
	        }
		}
		sb.append("</table>");
		response(sb.toString());
		
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:项目管理——保存办理过程 <br>
	 * Author:朱波海 <br>
	 * Date:2013-12-16
	 */
	public void saveBLGC() {
		String rq = request.getParameter("rq");
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = format.parse(rq);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String sj = request.getParameter("sj");
		String jbr = request.getParameter("jbr");
		String bz = request.getParameter("bz");
		String xmid = request.getParameter("xmid").trim();
		String yw_guid = request.getParameter("yw_guid").trim();
		sj = UtilFactory.getStrUtil().unescape(sj);
		jbr = UtilFactory.getStrUtil().unescape(jbr);
		bz = UtilFactory.getStrUtil().unescape(bz);
		int i = 0;
		if (yw_guid != null && !"".equals(yw_guid)) {
			String sql = "update  xmblgc set blsj='" + rq + "',sjbl='" + sj
					+ "',bmjbr='" + jbr + "',bz='" + bz
					+ "' where yw_guid=? and  xmid=?";
			i = update(sql, YW, new Object[] {  yw_guid,xmid });
		} else {
			String sql = "insert into xmblgc (blsj,sjbl,bmjbr,bz,xmid )values(?,?,?,?,?)";
			i = update(sql, YW, new Object[] { rq, sj, jbr, bz, xmid });
		}
		if (i > 0) {
			response("{success:true}");
		} else {
			response("{success:false}");
		}
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:删除 <br>
	 * Author:朱波海 <br>
	 * Date:2013-12-30
	 */
	public void delBLGC() {
		String yw_guid = request.getParameter("yw_guid").trim();
		String sql = "delete xmblgc where YW_GUID=? ";
		int i = update(sql, YW, new Object[] { yw_guid });
		if (i > 0) {
			response("{success:true}");
		} else {
			response("{success:false");
		}

	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:获取红线项目 <br>
	 * Author:朱波海 <br>
	 * Date:2013-12-16
	 */
	public List<Map<String, Object>> getHXXM() {
		String sql = "select xmname,yw_guid,rownum from jc_xiangmu order by xh";
		List<Map<String, Object>> list = query(sql, YW);
		return list;

	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:项目管理——资金管理——资金流入 <br>
	 * Author:朱波海 <br>
	 * Date:2013-12-17
	 */
	public List<Map<String, Object>> getZJGL_ZJLR(String yw_guid) {
		String sql = "select * from  xmzjgl where status='lr' and yw_guid=?";
		List<Map<String, Object>> list = query(sql, YW,
				new Object[] { yw_guid });
		return list;
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:保存资金管理——资金流入 <br>
	 * Author:朱波海 <br>
	 * Date:2013-12-17
	 * @throws Exception 
	 */
	public void saveZJGL_ZJLR() throws Exception {
		String yw_guid = request.getParameter("yw_guid");
		String year = request.getParameter("year");
		String val = request.getParameter("val");
		val = UtilFactory.getStrUtil().unescape(val);
		String[] values = val.split(":");
		String sql = "";
		for(int i =0 ; i < values.length ; i++){
			String[] idsvalue = values[i].split("_");
			String ids[] = idsvalue[0].split("@");
			String value = idsvalue[1];
			String tree_id = ids[0];
			String column = ids[2];
			sql = "update xmzjgl_lr set " + column + "=? where yw_guid =? and  tree_id=? and rq = ?";
			update(sql, YW, new Object[]{value,yw_guid,tree_id,year});
			
		}
		response("true");
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:项目管理——资金管理——资金支出 <br>
	 * Author:朱波海 <br>
	 * Date:2013-12-17
	 */
	public List<Map<String, Object>> getZJGL_ZJZC(String yw_guid) {
		String sql = "select distinct lb,yw_guid  from  xmzjgl where status='zc' and yw_guid=?";
		List<Map<String, Object>> list = query(sql, YW,
				new Object[] { yw_guid });
		// t.zcstatus
		for (int i = 0; i < list.size(); i++) {
			list.get(i).get("lb").toString();

		}
		return list;
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:保存资金管理——资金支出 <br>
	 * Author:朱波海 <br>
	 * Date:2013-12-17
	 */
	public void saveZJGL_ZJZC() {
		String yw_guid = request.getParameter("yw_guid");
		String year = request.getParameter("year");
		String val = request.getParameter("val");
		String sumtext = request.getParameter("sumtext");
		val = UtilFactory.getStrUtil().unescape(val);
		sumtext = UtilFactory.getStrUtil().unescape(sumtext);
		saveLevel3(yw_guid, sumtext, year);
		String[] values = val.split(":");
		String sql = "";
		for(int i =0 ; i < values.length ; i++){
			String[] idsvalue = values[i].split("#");
			String ids[] = idsvalue[0].split("@");
			if(ids.length == 5){
				String value = idsvalue[1];
				String tree_id = ids[0];
				String sort = ids[3];
				String column = ids[4];
				sql = "update xmzjgl_zc set " + column + "=? where yw_guid =? and  tree_id=? and sort=? and rq = ?";
				update(sql, YW, new Object[]{value,yw_guid,tree_id,sort,year});
			}else if(ids.length==4){
				String value = idsvalue[1];
				String tree_id = ids[0];
				String column = ids[3];
				sql = "update xmzjgl_lr set " + column + "=? where yw_guid =? and  tree_id=? and rq = ?";
				update(sql, YW, new Object[]{value,yw_guid,tree_id,year});
			}
		}
		response("true");
	}
	
	public void saveLevel3(String yw_guid, String sumtext, String year){
		String sql = "delete XMZJGL_MXB where yw_guid = ? and rq = ?";
		update(sql, YW,new Object[]{ yw_guid, year});
		sql = "insert into XMZJGL_MXB (tree_name ,ysfy, jl2, yfsdz, cqye, yy, ey, sany,siy,wy,ly,qy,bay,jy,siyue,syy,sey,lrsp,leval,sort,yw_guid, rq) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		String[] rowsum = sumtext.split("@");
		Object[] obj = new Object[22];
		for(int i = 0 ; i < rowsum.length ; i++){
			String[] colsum = rowsum[i].split("#");
			for(int j = 0 ; j < colsum.length; j++){
				obj[j] = colsum[j];
			}
			obj[obj.length - 2] = yw_guid;
			obj[obj.length - 1] = year;
			update(sql, YW, obj);
		}
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:保存树 <br>
	 * Author:朱波海 <br>
	 * Date:2013-12-25
	 */
	public void saveZjglTree() {
		String st[] = {"总计划审批", "贷款审批", "实施主体带资审批", "国有土地收益基金审批", "出让回笼资金审批", "其他资金审批", "实际支付",
				"已批未付" };
		String yw_guid = request.getParameter("yw_guid").trim();
		String parent_id = request.getParameter("tree_id");
		String selet_year = request.getParameter("selet_year");
		String tree_name = request.getParameter("tree_name");
		tree_name = UtilFactory.getStrUtil().unescape(tree_name).trim();
		String roorId = request.getParameter("rootID");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");
		String tree_id = dateFormat.format(new Date());
		if(roorId.equals("ZJLR")){
			String sql = "select leval from xmzjgl_lr where tree_id=? and yw_guid=? and rq=?";
			int leval = Integer.parseInt(query(sql, YW,new Object[]{parent_id,yw_guid,selet_year}).get(0).get("leval").toString());
			sql = " insert into xmzjgl_lr (yw_guid,parent_id,tree_id,tree_name,rq,leval)values (?,?,?,?,?,?)";
			update(sql, YW, new Object[] { yw_guid, parent_id, tree_id,tree_name,selet_year ,leval + 1 + ""});
		}else{
			String sql = "select leval from xmzjgl_zc where tree_id=? and yw_guid=? and rq=?";
			int leval = Integer.parseInt(query(sql, YW,new Object[]{parent_id,yw_guid,selet_year}).get(0).get("leval").toString());
			sql = " insert into xmzjgl_zc (yw_guid,parent_id,tree_id,tree_name,rq,lj,sort,leval)values (?,?,?,?,?,?,?,?)";
			for(int i = 1; i <= st.length ; i++){
				update(sql, YW, new Object[] { yw_guid, parent_id, tree_id,tree_name,selet_year ,st[i-1],i ,leval + 1 + ""});
			}
		}
	}

	public void delt_tree() {
		String yw_guid = request.getParameter("yw_guid").trim();
		String parent_id = request.getParameter("parent_id");
		String selet_year = request.getParameter("selet_year");
		String tree_text = request.getParameter("tree_text");
		tree_text = UtilFactory.getStrUtil().unescape(tree_text);
		String roorId = request.getParameter("rootId");
		tree_text = UtilFactory.getStrUtil().unescape(tree_text).trim();
		if(roorId.equals("ZJLR")){
			String delet = "delete XMZJGL_LR where yw_guid=? and tree_name=? and parent_id=? and rq=?  ";
			update(delet, YW, new Object[] { yw_guid, tree_text, parent_id,selet_year });
		}else{
			String delet = "delete XMZJGL_ZC where yw_guid=? and tree_name=? and parent_id=? and rq=?  ";
			update(delet, YW, new Object[] { yw_guid, tree_text, parent_id,selet_year });
		}
	}

	public void modify_tree() {
		String yw_guid = request.getParameter("yw_guid").trim();
		String parent_id = request.getParameter("parent_id");
		String selet_year = request.getParameter("selet_year");
		String tree_text = request.getParameter("tree_text");
		tree_text = UtilFactory.getStrUtil().unescape(tree_text).trim();
		String rootId = request.getParameter("rootID");
		if("ZJZC".equals(rootId)){
			String delet = "update XMZJGL_ZC set tree_name=? where yw_guid=? and parent_id =? and rq = ?";
			update(delet, YW,new Object[] {  tree_text ,yw_guid,parent_id,selet_year });
		}else{
			String delet = "update XMZJGL_LR set tree_name=? where yw_guid=? and parent_id =? and rq = ?";
			update(delet, YW,new Object[] {  tree_text ,yw_guid,parent_id,selet_year });
		}
	}


	public String dellNull(String str) {
		if (str.equals("null")) {
			return "";
		} else {
			return str;
		}

	}
	
	
	public void getTreeMap(){
		String yw_guid = request.getParameter("yw_guid");
		String year = request.getParameter("year");
		response(bulidTreeMap(yw_guid, year));
	}
	
	public void getTreeMapLR(){
		String yw_guid = request.getParameter("yw_guid");
		String year = request.getParameter("year");
		response(bulidTreeMapLR(yw_guid, year));
	}
	
	public List<XmzjglTreeBean> getBeanList(String yw_guid , String year,String sql){
		List<XmzjglTreeBean> arrayList = new ArrayList<XmzjglTreeBean>();
		List<Map<String, Object>> queryList = null;
		if(yw_guid == null){
			queryList = query(sql, YW, new Object[]{year});
		}else{
			queryList = query(sql, YW, new Object[]{yw_guid, year});
		}
		for(int i = 0; i < queryList.size(); i++){
			arrayList.add(new XmzjglTreeBean(queryList.get(i)));
		}
		return arrayList;
	}
	
	public List<Map<String,Object>> bulidTreeMap(String yw_guid,String year){
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		String sql_zc = "";
		List<Map<String,Object>> treeList = null;
		List<XmzjglTreeBean> treebean = null;
		if(yw_guid == null){
			sql_zc = "select distinct tree_id as tree_id,tree_name as tree_name ,parent_id as parent_id,leval as leval from xmzjgl_zc where tree_id  in (select distinct parent_id from xmzjgl_zc where rq=?) and rq=? order by leval asc";
			treeList = query(sql_zc, YW,new Object[]{ year,  year});
			sql_zc = "select distinct t.yw_guid ,t.tree_id, t.tree_name,t.rq,t.parent_id,t.leval  from xmzjgl_zc t where  t.rq=? order by t.parent_id, t.tree_name";
			treebean = getBeanList(null, year, sql_zc);
		}else{
			sql_zc = "select distinct tree_id as tree_id,tree_name as tree_name ,parent_id as parent_id,leval as leval from xmzjgl_zc where tree_id  in (select distinct parent_id from xmzjgl_zc where yw_guid=? and rq=?) and yw_guid=? and rq=? order by leval asc";
			treeList = query(sql_zc, YW,new Object[]{yw_guid, year, yw_guid, year});
			sql_zc = "select distinct t.yw_guid ,t.tree_id, t.tree_name,t.rq,t.parent_id,t.leval  from xmzjgl_zc t where t.yw_guid=? and t.rq=? order by t.parent_id, t.tree_name";
			treebean = getBeanList(yw_guid, year, sql_zc);
		}
		Map<String,Object> treeMap = new TreeMap<String, Object>();
		for(int i = 0; i < treeList.size(); i++){
			String childs = "";
			for(int j = 0; j < treebean.size() ; j++){
				if(treebean.get(j).getParent_id().equals(treeList.get(i).get("tree_id").toString())){
					childs += treebean.get(j).getTree_id()+"@" + treebean.get(j).getTree_name() + "@" + treebean.get(j).getParent_id() + ",";
				}
			}
			treeMap.put(treeList.get(i).get("TREE_ID").toString()+"@"+treeList.get(i).get("TREE_NAME").toString()+"@"+treeList.get(i).get("PARENT_ID").toString(),childs.substring(0,childs.length()-1));
		}
		result.add(treeMap);
		return result;
	}
	

	public List<Map<String,Object>> bulidTreeMapLR(String yw_guid,String year){
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		String sql_zc = null;
		List<Map<String,Object>> treeList = null;
		List<XmzjglTreeBean> treebean = null;
		if(yw_guid == null){
			sql_zc = "select distinct tree_id as tree_id,tree_name as tree_name ,parent_id as parent_id,leval as leval from xmzjgl_lr where tree_id  in (select distinct parent_id from xmzjgl_lr where rq=?)  and rq=? order by leval asc";
			treeList = query(sql_zc, YW,new Object[]{year,  year});
			sql_zc = "select distinct t.yw_guid ,t.tree_id, t.tree_name,t.rq,t.parent_id,t.leval  from xmzjgl_lr t where t.rq=? order by t.parent_id, t.tree_name";
			treebean = getBeanList(null, year, sql_zc);
		}else{
			sql_zc = "select distinct tree_id as tree_id,tree_name as tree_name ,parent_id as parent_id,leval as leval from xmzjgl_lr where tree_id  in (select distinct parent_id from xmzjgl_lr where yw_guid=? and rq=?) and yw_guid=? and rq=? order by leval asc";
			treeList = query(sql_zc, YW,new Object[]{yw_guid, year, yw_guid, year});
			sql_zc = "select distinct t.yw_guid ,t.tree_id, t.tree_name,t.rq,t.parent_id,t.leval  from xmzjgl_lr t where t.yw_guid=? and t.rq=? order by t.parent_id, t.tree_name";
			treebean = getBeanList(yw_guid, year, sql_zc);
		}
		Map<String,Object> treeMap = new TreeMap<String, Object>();
		for(int i = 0; i < treeList.size(); i++){
			String childs = "";
			for(int j = 0; j < treebean.size() ; j++){
				if(treebean.get(j).getParent_id().equals(treeList.get(i).get("tree_id").toString())){
					childs += treebean.get(j).getTree_id()+"@" + treebean.get(j).getTree_name() + "@" + treebean.get(j).getParent_id() + ",";
				}
			}
			treeMap.put(treeList.get(i).get("TREE_ID").toString()+"@"+treeList.get(i).get("TREE_NAME").toString()+"@"+treeList.get(i).get("PARENT_ID").toString(),childs.substring(0,childs.length()-1));
		}
		result.add(treeMap);
		return result;
	}
}