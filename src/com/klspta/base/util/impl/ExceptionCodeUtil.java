package com.klspta.base.util.impl;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import com.klspta.base.util.api.IExceptionCodeUtil;

/*******************************************************************************
 * 
 * <br>
 * Title:异常编码库处理类 <br>
 * Description:对异常配置文件处理 <br>
 * Author:朱波海 <br>
 * Date:2013-7-15
 */
public class ExceptionCodeUtil implements IExceptionCodeUtil {
	private Properties props = null;
	private static ExceptionCodeUtil instance = null;

	/**
	 * 
	 * <br>
	 * Description:获取实例 <br>
	 * Author:朱波海 <br>
	 * Date:2013-7-15
	 * 
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public static ExceptionCodeUtil getInstance() throws Exception {
		if (instance == null) {
			return new ExceptionCodeUtil();
		} else {
			return instance;
		}
	}

	/***************************************************************************
	 * 
	 * <br>
	 * Description:私有构造方法，加载配置文件 <br>
	 * Author:朱波海 <br>
	 * Date:2013-7-15
	 */
	private ExceptionCodeUtil() {
		try {
			InputStream basepath = getClass().getResourceAsStream(
					"/exceptionCode.properties");
			props = new Properties();
			props.load(basepath);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * <br>
	 * Description:根据key获取value值 <br>
	 * Author:朱波海 <br>
	 * Date:2013-7-15
	 * 
	 * @param key
	 * @return
	 */
	public String getCode(String key) {
		Object[] allKey = getAllKey();
		String keys = null;
		for (int i = 0; i < allKey.length; i++) {
			if (key.equals(allKey[i])) {
				keys = allKey[i].toString();
			}
		}
		if (keys == null) {
			keys = "100001";
		}
		String code = props.getProperty(keys);
		return code;

	}

	/**
	 * 
	 * <br>
	 * Description:获取所有配置文件的key <br>
	 * Author:朱波海 <br>
	 * Date:2013-7-15
	 * 
	 * @return
	 */
	public Object[] getAllKey() {
		Set<String> set = props.stringPropertyNames();
		Object[] all_key = set.toArray();
		return all_key;
	}

}
