package com.klspta.web.cbd.yzt.utilList;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface IData  {
	public List<Map<String, Object>> getAllList(HttpServletRequest request);
	public List<Map<String, Object>> getQuery(HttpServletRequest request);
}
