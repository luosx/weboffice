package com.klspta.model.signlog;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

public class WlogUtil extends AbstractBaseBean  implements IWlogUtil {
	
	private static WlogUtil instance;
	
	public static IWlogUtil getInstance(){
		if(instance == null){
			instance = new WlogUtil();
		}
		return instance;
	}
	
	@Override
	public int addLog(WfxsdjbllogBean signBean) {
		String sql = "insert into wfxsdjbl_log(yw_guid, blr, blms,bljb) values (?, ?, ?, ?)";
		Object[] args = {signBean.getYw_guid(), signBean.getBlr(), signBean.getBlms(), signBean.getBljb()};
		int result = update(sql, YW, args);
		return result;
	}

	@Override
	public List<WfxsdjbllogBean> getWfxsdjbllogBean(String yw_guid) {
		String sql = "select * from wfxsdjbl_log t where t.yw_guid=? order by t.blsj asc ";
		Object[] args = {yw_guid};
		List<Map<String, Object>> resultList = query(sql, YW, args);
		List<WfxsdjbllogBean> beanList = new ArrayList<WfxsdjbllogBean>();
		for (int i = 0; i < resultList.size(); i++) {
			Map<String, Object> resultMap = resultList.get(i);
			WfxsdjbllogBean signBean = new WfxsdjbllogBean();
			signBean.setBlms(String.valueOf(resultMap.get("blms")));
			signBean.setBlr(String.valueOf(resultMap.get("blr")));
			signBean.setYw_guid(String.valueOf(resultMap.get("yw_guid")));
			signBean.setBlsj(Date.valueOf(String.valueOf(resultMap.get("blsj"))));
			signBean.setBljb(String.valueOf(resultMap.get("bljb")));
			beanList.add(signBean);
		}
		return beanList;
	}

	@Override
	public int deleteLog(WfxsdjbllogBean signBean) {
		// TODO Auto-generated method stub
		return 0;
	}

}
