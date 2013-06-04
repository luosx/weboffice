package com.klspta.base.util.api;

import java.util.List;

import com.klspta.base.util.impl.CodeBean;


public interface IPublicCodeUtil {

    /**
    	 * 
    	 * <br>Description:根据通用编码id，以list方式，返回CodeBean
    	 * <br>Author:郭
    	 * <br>Date:2010-12-14
    	 * @param id
    	 * @return
    	 */
    public abstract List<CodeBean> getCodeByID(String id);
    
    /**
	 * 
	 * <br>Description:根据通用编码id，以list方式，返回经过排序的CodeBean
	 * <br>Author:李如意
	 * <br>Date:2012-3-19
	 * @param id
	 * @return
	 */
    public abstract String getCodeByIDAndRank2Option(String id);

    /**
     * 
     * <br>Description:将list格式的codeBean转换为html需要的option下拉框
     * <br>Author:郭
     * <br>Date:2010-12-14
     * @param codeBeans
     * @return
     */
    public abstract String transferCodeBeans2Option(List<CodeBean> codeBeans);

    /**
     * 
     * <br>Description:将list格式的codeBean转换为html需要的option下拉框,并且将显示列表项的值替换下拉列表框的默认索引值
     * <br>Author:lry
     * <br>Date:2011-07-11
     * @param codeBeans
     * @return
     */
    public abstract String transferCodeBeans2OptionValue(List<CodeBean> codeBeans);
}