package com.klspta.web.cbd.yzt.jbb;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;


public class JbdkValueChange extends AbstractBaseBean {
	private String source_name = "JC_JIBEN";
	private String impress_name = "JC_XIANGMU";
	private String fields = "zd,jsyd,rjl,jzgm,gjjzgm,jzjzgm,szjzgm,zzsgm,zzzsgm,zzzshs,hjmj,fzzzsgm,fzzjs,kfcb,dmcb,yjcjj,yjzftdsy,cxb,cqqd,cbfgl";
	private String sql =  "select round(sum(t.zzsgm),2) as zzsgm, round(sum(t.zzzsgm),2) as zzzsgm, round(sum(t.zzzshs),2) as zzzshs, "
		+ "case when sum(t.zzzshs)=0 then 0 else round(sum(t.zzzsgm)/sum(t.zzzshs)*10000,2) end as hjmj,"
		+ " round(sum(t.fzzzsgm),2) as fzzzsgm, round(sum(t.fzzjs),2) as fzzjs,round(sum(t.zd),2) as zd,"
		+ "round(sum(t.jsyd),2) as jsyd, case when sum(t.jsyd)=0 then 0 else  round(sum(t.jzgm)/sum(t.jsyd),2) end as rjl,"
		+ " round(sum(t.jzgm),2) as jzgm,'--' as kzgd, '--' as ghyt, round(sum(t.gjjzgm),2) as gjjzgm,"
		+ " round(sum(t.jzjzgm),2) as jzjzgm, round(sum(t.szjzgm),2) as szjzgm,"
		+ "round(sum(t.szjzgm),2) as szjzgm,round(sum(t.kfcb),2) as kfcb,  round(sum(t.lmcb),2) as lmcb , "
		+ "case when sum(t.jsyd)=0 then 0 when sum(t.kfcb)=0 then 0 else round(sum(t.kfcb)/sum(t.jsyd)*10000,2) end as dmcb,round(avg(t.yjcjj),2) as yjcjj,"
		+ "round(avg(t.yjcjj)*sum(t.jzgm)/10000-sum(t.kfcb),2) as yjzftdsy,"
		+ "case when (avg(t.yjcjj)*sum(t.jzgm))=0 then '0' when avg(t.yjcjj)*sum(t.jzgm)=0 then '0' else round(((avg(t.yjcjj)*sum(t.jzgm)/10000-sum(t.kfcb))/"
		+ "(avg(t.yjcjj)*sum(t.jzgm)/10000))*100,2)||'%' end as cxb,case when sum(t.zd)=0 then 0 else round(sum(t.zzsgm)/sum(t.zd),2) end as cqqd,"
		+ "case when sum(t.kfcb)=0 then '0' when sum(t.jzgm)=0 then '0' else round((sum(t.jzgm)*2.4/sum(t.kfcb))*100,2)||'%' end as cbfgl,'--' as gnfq from jc_jiben t where t.dkmc in ";
	public boolean add(String ywGuid) {
		//根据地块编号找到对应项目编号
		String jbdkSql = "select t.dkmc,t.xmname from " + impress_name + " t where  t.dkmc like '%" + ywGuid + "%'";
		List<Map<String, Object>> jbdkList = query(jbdkSql, YW);
		if(jbdkList.size() < 1){
			return true;
		}else{
			Map<String, Object> jbdkMap = jbdkList.get(0);
			String xmmc = String.valueOf(jbdkMap.get("xmname"));
			String bhdk = String.valueOf(jbdkMap.get("dkmc"));
			String[] values = getValues(bhdk, xmmc);
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append("update ").append(impress_name).append(" t set ");
			String[] field = fields.split(",");
			for(int i = 0; i < field.length - 1; i++){
				sqlBuffer.append(" t.").append(field[i]).append("=?,");
			}
			sqlBuffer.append("t.").append(field[field.length - 1]).append("=? where t.xmname = ?");
			int i = update(sqlBuffer.toString(), YW, values);
			return i==1?true:false;
		}
	}

	public boolean delete(String ywGuid) {
		return false;
	}

	public boolean modify(String ywGuid) {
		return add(ywGuid);
	}

	public boolean modifyguid(String oldguid, String newguid) {
		// TODO Auto-generated method stub
		return false;
	}
	
	private String[] getValues(String bhdk, String xmmc){
		String[] field = fields.split(",");  
		String[] values = new String[field.length + 1];
		StringBuffer bhdkBuffer = new StringBuffer();
		String[] bhdks = bhdk.split(",");
		bhdkBuffer.append("(");
		for(int i = 0; i < bhdks.length - 1; i++){
			bhdkBuffer.append("'").append(bhdks[i]).append("',");
		}
		bhdkBuffer.append("'").append(bhdks[bhdks.length - 1]).append("')");
		String querySql = sql + bhdkBuffer;
		List<Map<String, Object>> resultList = query(querySql, YW);
		Map<String, Object> resultMap = resultList.get(0);
		for(int i = 0; i < field.length; i++){
			String fieldValue = String.valueOf(resultMap.get(field[i]));
			fieldValue = fieldValue=="null"||"%".equals(fieldValue)?"0":fieldValue;
			values[i] = fieldValue;
		}
		values[field.length] = xmmc;
		return values;
	}

}
