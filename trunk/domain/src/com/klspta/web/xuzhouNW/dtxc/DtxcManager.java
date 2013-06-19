package com.klspta.web.xuzhouNW.dtxc;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class DtxcManager extends AbstractBaseBean {
	
	/**
	 * 
	 * <br>Title: 生成巡查日志
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-18
	 */
	public void buildXcrq() {
		String yw_guid= UtilFactory.getStrUtil().getGuid();
		String sql = "insert into xcrz(yw_guid) values ('" + yw_guid + "')";
		update(sql, YW);
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + request.getContextPath()
				+ "/";
		StringBuffer url = new StringBuffer();
		url.append(basePath);
		url.append("/web/xuzhouNW/dtxc/xcrz/xcrz.jsp?jdbcname=YWTemplate&yw_guid=");
		url.append(yw_guid);
		redirect(url.toString());
	}
	
	/**
	 * 
	 * <br>Title: 生成巡查编号
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-18
	 */
	public String buildXcbh(){
		StringBuffer xcbh = new StringBuffer();
		//添加编号头"XC"
		xcbh.append("XC");
		//添加日期
		
		//添加流水号
		String sql = "select count(yw_guid) cou from xcrz";
		List<Map<String, Object>> result = query(sql, YW);
		String strCou = result.get(0).get("cou").toString();//数据库中日志条数
		int intCou = Integer.parseInt(strCou) + 1;//新生成日志是数据库中日志条数+1
		String strtemp = intCou + "";
		int i = strtemp.length();
		int j = 6 - i;
		for (int n = 0; n < j; n++) {
			xcbh.append("0");
		}
		xcbh.append(strtemp);
		
		return xcbh.toString();
	}
	
	public static void main(String[] args) {
		DtxcManager dm = new DtxcManager();
		//System.out.println(dm.buildXcbh());
		System.out.println(dm.arrayFlag("-77c524e9-13f5a0cd5ee--7ff3"));
	}
	
	/**
	 * 
	 * <br>Title: 生成标示前台抄告单显示个数的标识字符串
	 * <br>Description: 
	 * <br>Author: 姚建林
	 * <br>Date: 2013-6-19
	 */
	public String arrayFlag(String yw_guid){
		//用五个抄告单的 建设项目 是否为空标示
		String sql = "select jsxm1,jsxm2,jsxm3,jsxm4,jsxm5 from xcrz where yw_guid = '"+yw_guid+"'";
		List<Map<String, Object>> result = query(sql, YW);
		StringBuffer sb = new StringBuffer();
		if(result.get(0).get("jsxm1") == null){
			sb.append("0,");
		}
		if(result.get(0).get("jsxm1") != null){
			sb.append("1,");
		}
		if(result.get(0).get("jsxm2") == null){
			sb.append("0,");
		}
		if(result.get(0).get("jsxm2") != null){
			sb.append("1,");
		}
		if(result.get(0).get("jsxm3") == null){
			sb.append("0,");
		}
		if(result.get(0).get("jsxm3") != null){
			sb.append("1,");
		}
		if(result.get(0).get("jsxm4") == null){
			sb.append("0,");
		}
		if(result.get(0).get("jsxm4") != null){
			sb.append("1,");
		}
		if(result.get(0).get("jsxm5") == null){
			sb.append("0");
		}
		if(result.get(0).get("jsxm5") != null){
			sb.append("1");
		}
		return sb.toString(); 
	}
	
	/**
	 * <br>
	 * Description:根据yw_guid获取巡查日志 <br>
	 * Author:黎春行 <br>
	 * Date:2013-06-18
	 * 
	 * @return
	 */
	public List<Map<String, Object>> getXzrqbyYw_guid(String yw_guid){
		String sql = "select * from xcrz t where t.yw_guid = ?";
		return query(sql, YW, new Object[]{yw_guid});
	}
    /**
     * 
     * <br>Description:查询回传内容能
     * <br>Author:陈强峰
     * <br>Date:2013-4-9
     * @param yw_guid
     * @return
     */
    public Map<String, Object> getXckcqkData(String yw_guid) {
        String sql = "select * from pad_xcxcqkb t where t.yw_guid=?";
        List<Map<String, Object>> result = query(sql, YW,
                new String[] { yw_guid });
        return result.get(0);
    }
}
