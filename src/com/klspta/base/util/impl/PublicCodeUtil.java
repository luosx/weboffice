package com.klspta.base.util.impl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.AbstractDataBaseSupport;
import com.klspta.base.util.api.IPublicCodeUtil;



/**
 * 
 * <br>Title:通用编码操作工具
 * <br>Description:
 * <br>Author:郭
 * <br>Date:2010-12-14
 */
public class PublicCodeUtil extends AbstractBaseBean implements IPublicCodeUtil {
    private static PublicCodeUtil instance;    
    private PublicCodeUtil(){
        
    }
    public static IPublicCodeUtil getInstance(String key) throws Exception {
        if (!key.equals("NEW WITH UTIL FACTORY!")) {
            throw new Exception("请通过UtilFactory获取实例.");
        }
        if (instance == null) {
            return new PublicCodeUtil();
        } else {
            return instance;
        }
    }   
    /**
     * 
     * <br>Description:根据通用编码id，以list方式，返回CodeBean
     * <br>Author:郭
     * <br>Date:2010-12-14
     * @param id
     * @return
     */
public  List<CodeBean> getCodeByID(String id){	
	//JdbcTemplate jt=Globals.getYwJdbcTemplate();
	//String sql="select * from public_code where id=?";
	//Object[] args={id};
	//return jt.query(sql, args, new CodeBeanRowMapper());
	return null;
}


/**
 
 * <br>Description: 根据行政区id，获取行政区list并转换成html需要的option下拉框
 * <br>Author:李如意
 * <br>Date:2012-7-20
 * @see com.klspta.base.util.api.IPublicCodeUtil#getCodeByIDAndRank2Option(java.lang.String)
 */
public  String getCodeByIDAndRank2Option(String id){
	String sql="select QT_CTN_CODE, NA_CTN_NAME from CODE_XZQH t where QT_PARENT_CODE=?  order by t.QT_CTN_CODE asc";
    Object[] args = { id };
    List<Map<String,Object>> listmap = query(sql,AbstractDataBaseSupport.CORE,args);
	StringBuffer strs=new StringBuffer();
    for(int i=0;i<listmap.size();i++){
    	strs.append("<option value=\""+listmap.get(i).get("QT_CTN_CODE")+"\">"+"<span class=\"STYLE2\">"+(String)listmap.get(i).get("NA_CTN_NAME")+"</span></option>");
    }
	return strs.toString();
}



/**
 * 
 * <br>Description:将list格式的codeBean转换为html需要的option下拉框
 * <br>Author:郭
 * <br>Date:2010-12-14
 * @param codeBeans
 * @return
 */
public  String transferCodeBeans2Option(List<CodeBean> codeBeans){
	StringBuffer strs=new StringBuffer();
	if (codeBeans.size()==0) {
		return "";
	}
	for (int i = 0; i < codeBeans.size(); i++) {
		CodeBean codeBean=codeBeans.get(i);
		strs.append("<option value=\""+codeBean.getChild_id()+"\">"+"<span class=\"STYLE2\">"+codeBean.getChild_name()+"</span></option>");
	}
	return strs.toString();
}
/**
 * <br>Description:以显示列表项的值替换下拉列表框的默认索引值
 * <br>Author:李如意
 * <br>Date:2011-07-07
 */
	public  String transferCodeBeans2OptionValue(List<CodeBean> codeBeans){
		StringBuffer strs=new StringBuffer();
		if (codeBeans.size()==0) {
			return "";
		}
		for (int i = 0; i < codeBeans.size(); i++) {
			CodeBean codeBean=codeBeans.get(i);
			strs.append("<option value=\""+codeBean.getChild_name()+"\">"+"<span class=\"STYLE2\">"+codeBean.getChild_name()+"</span></option>");
		}
		return strs.toString();
	}
}
