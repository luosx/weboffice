package com.klspta.model.giscomponents.pda;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;

/**
 * 
 * <br>Title:PDAUtil
 * <br>Description:PDAUtil工具类
 * <br>Author:王雷
 * <br>Date:2012-2-7
 */
public class PDAUtil extends AbstractBaseBean{
	
    public static List<PDABean> pdaBeanList;
	
    private static PDAUtil pdaUtil;
    
    private PDAUtil(){
        
    }  
    /**
     * <br>Description:获取实例
     * <br>Author:王峰
     * <br>Date:2011-4-14
     * @return
     */
    public static PDAUtil getInstance() {
        if (pdaUtil == null) {
        	pdaUtil = new PDAUtil();
           // flush();
        }
        return pdaUtil;
    }
    
    /**
     * <br>Description:判断PDAID是否存在！
     * <br>Author:王峰
     * <br>Date:2011-4-14
     * @param pdaId
     */
    public String getId(String pdaId){  	
    	String sql="select * from wy_pda_info where pda_id="+pdaId;
    	//List<PDABean> list=Globals.getYwJdbcTemplate().query(sql,new PDABeanRowMapper());
    	List<Map<String,Object>> list=query(sql,YW);
    	if(list.size()==0)return null;
    	///PDABean p=list.get(0);
    	Map<String,Object> map=list.get(0);
    	PDABean p=new PDABean();
    	p.setFlag((String)map.get("FLAG"));
    	p.setPDACantonCode((String)map.get("PDA_CANTONCODE"));
    	p.setPDAId((String)map.get("PDA_ID"));
    	p.setPDAName((String)map.get("PDA_NAME"));
    	p.setPDAPerson((String)map.get("PDA_PERSON"));
    	p.setPDAPersonPhone((String)map.get("PDA_PERSON_PHONE"));
    	p.setPDAPhone((String)map.get("PDA_PHONE"));
    	p.setPDAType((String)map.get("PDA_TYPE"));
    	p.setPDAUnit((String)map.get("PDA_UNIT"));
        return p.getPDAId();
    }
    /**
     * <br>Description:更新(根据pdaId是否存在，判断新增或修改！)
     * <br>Author:王峰
     * <br>Date:2011-4-14
     * @param pdaBean
     */
    public void save(PDABean pdaBean) {
    	String pdaId=pdaBean.getPDAId();
    	String id=this.getId(pdaId);
        String sql="update wy_pda_info set pda_name=?,pda_type=?,pda_unit=?,pda_person=?,flag=?,pda_person_phone=?,pda_phone=?,pda_cantoncode=? where pda_id=?";
    	if(id==null){
    	   sql="insert into wy_pda_info(pda_name,pda_type,pda_unit,pda_person,flag,pda_person_phone,pda_phone,pda_cantoncode,pda_id) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    	}
        Object[] args = { 
            		pdaBean.getPDAName(),
            		pdaBean.getPDAType(),
            		pdaBean.getPDAUnit(),
            		pdaBean.getPDAPerson(),
            		pdaBean.getFlag(),
            		pdaBean.getPDAPersonPhone(),
            		pdaBean.getPDAPhone(),
            		pdaBean.getPDACantonCode(),
            		pdaBean.getPDAId()
              };
        update(sql, YW,args);
        flush();
    }
    
    /**
     * <br>Description:通过pdaId删除
     * <br>Author:王峰
     * <br>Date:2011-4-14
     * @param pdaId
     */
    public void deleteByPdaId(String pdaId) {
        String sql = "delete from wy_pda_data t where t.dataid =?";
        Object[] args = {pdaId};
        update(sql,YW, args);
    }
    /**
     * <br>Description:刷新内存pdaBeanList
     * <br>Author:王峰
     * <br>Date:2011-4-14
     */
    public static void flush() {
        String sql = "select * from wy_pda_info p order by p.pda_id ";
        //List<Map<String,Object>> list=query(sql,YW);
        //pdaBeanList=Globals.getYwJdbcTemplate().query(sql, new PDABeanRowMapper());
    }
}
