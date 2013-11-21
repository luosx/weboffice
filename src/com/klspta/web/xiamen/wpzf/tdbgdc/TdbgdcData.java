package com.klspta.web.xiamen.wpzf.tdbgdc;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.xiamen.jcl.XzqHandle;

public class TdbgdcData extends AbstractBaseBean implements ItdbgdcData {
	public static final int XF_YXF = 1;
	public static final int YGFX_YSWF = 0;
	public static final int YGFX_HF = 1;
	public static final int XCHC_YSWF = 0;
	public static final int XCHC_HF = 1;
	private static final String queryString = "(upper(t.JCBH)||upper(t.JCMJ)||upper(t.XZQMC)||upper(t.SPMJ)||upper(t.GDMJ)||upper(t.WPND)";
	private String formName = "WP_TDBGDC";

	public TdbgdcData(String formName) {
		super();
		this.formName = formName;
	}
	
	public TdbgdcData() {
		super();
	}

	@Override
	public String changeXF(String yw_guid, String type) {
		String sql = "update "+formName+" t set t.isxf = ? where t.yw_guid = ?";
		int result = update(sql, YW, new Object[]{type, yw_guid});
		return String.valueOf(result);
	}

	@Override
	public String changeXF(Set guids) {
		for(Object yw_guid : guids){
			changeXF(String.valueOf(yw_guid), String.valueOf(XF_YXF));
		}
		return null;
	}

	@Override
	public List<Map<String, Object>> getDhcHF(String userId, String keyword) {
		String xzq = editXzq(userId);
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select replace(replace(t.isxf, '0', '未下发'), '1', '已下发') as xf, t.*, '合法' as ygqk from "+formName+" t where t.ygfxqk = ? and t.xchcqk is null and t.xzqdm in ");
		sqlBuffer.append(xzq);
		
		if (keyword != null) {
            keyword = UtilFactory.getStrUtil().unescape(keyword);
             sqlBuffer.append(" and").append(queryString).append(" like '%");
             sqlBuffer.append(keyword);
             sqlBuffer.append("%')");
        }
        
		List<Map<String, Object>> getList = query(sqlBuffer.toString(), YW, new Object[]{String.valueOf(YGFX_HF)});
		return getList;
	}

	@Override
	public List<Map<String, Object>> getDhcWF(String userId, String keyword) {
		String xzq = editXzq(userId);
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer.append("select replace(replace(t.isxf, '0', '未下发'), '1', '已下发') as xf, t.*, '违法' as ygqk  from "+formName+" t where t.ygfxqk = ? and t.xchcqk is null and t.xzqdm in ");
		sqlBuffer.append(xzq);
		if (keyword != null) {
            keyword = UtilFactory.getStrUtil().unescape(keyword);
             sqlBuffer.append(" and").append(queryString).append(" like '%");
             sqlBuffer.append(keyword);
             sqlBuffer.append("%')");
        }
		List<Map<String, Object>> getList = query(sqlBuffer.toString(), YW, new Object[]{String.valueOf(YGFX_YSWF)});
		return getList;
	}

	@Override
	public List<Map<String, Object>> getYhcHf(String userId) {
		String xzq = editXzq(userId);
		String sql = "select t.* from "+formName+" t where t.xchcqk = ? and t.xzqdm in ?";
		List<Map<String, Object>> getList = query(sql, YW, new Object[]{String.valueOf(XCHC_HF), xzq});
		return getList;
	}

	@Override
	public List<Map<String, Object>> getYhcWF(String userId) {
		String xzq = editXzq(userId);
		String sql = "select t.* from "+formName+" t where t.xchcqk = ? and t.xzqdm in ?";
		List<Map<String, Object>> getList = query(sql, YW, new Object[]{String.valueOf(XCHC_YSWF), xzq});
		return getList;
	}

	@Override
	public String setClqk(String yw_guid, String value) {
		String sql = "update "+formName+" t set t.clqk = ? where t.yw_guid = ?";
		int result = update(sql, YW, new Object[]{value, yw_guid});
		return String.valueOf(result);
	}

	@Override
	public String setxchcqk(String yw_guid, String value) {
		String sql = "update "+formName+" t set t.xchcqk = ? where t.yw_guid = ?";
		int result = update(sql, YW, new Object[]{value, yw_guid});
		return String.valueOf(result);
	}

	private String editXzq(String userId){
		Set<String> xzqSet = XzqHandle.getChildSetByUserId(userId);
		StringBuffer containBuffer = new StringBuffer();
		containBuffer.append("(");
		for(String xzqname : xzqSet){
			containBuffer.append("'").append(xzqname).append("',");
		}
		containBuffer.append(" 'null' )");
		return containBuffer.toString();
	}

	@Override
	public String changeFxqk(String yw_guid, String value) {
		String sql = "update "+formName+" t set t.ygfxqk = ? where t.yw_guid = ?";
		int result = update(sql, YW, new Object[]{value, yw_guid});
		return String.valueOf(result);
	}

}
