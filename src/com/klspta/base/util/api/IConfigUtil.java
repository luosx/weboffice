/**
 * Create Date:2009-7-29
 */
package com.klspta.base.util.api;

public interface IConfigUtil {
	public String getShapefileTempPathFloder();
	
	public boolean isSecurityUseable();
	
	public String getSecurityVerifyURL();
	
	public String getSecurityPassIPs();
	
	public String getSQL(String key);
	
	public String getConfig(String key);
	
	public double getConfigDouble(String key);
	
	public String getApppath();
}
