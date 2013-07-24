package com.klspta.base;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 
 * <br>Title: 抽象rest类，留着以后扩展用
 * <br>Description:rest入口三层过滤之一，目前无具体内容，用于以后扩展
 * <br>Author:王瑛博
 * <br>Date:2011-5-3
 */
public abstract class AbstractBaseBean extends AbstractRestRequestSupport {
    public void responseException(Object obj, String methodName, Exception e){
    	error(obj, e.getMessage());
    	List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
    	response(list);
    }
}
