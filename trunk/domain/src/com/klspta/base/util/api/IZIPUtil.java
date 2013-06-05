/**
 * Create Date:2009-7-29
 */
package com.klspta.base.util.api;

import java.util.Vector;

/**
 * <br>Title:压缩工具
 * <br>Description:压缩和解压缩
 * <br>Author:陈强峰
 * <br>Date:2013-6-5
 */
public interface IZIPUtil {
     
	/**
	 * <br>Description:压缩
	 * <br>Author:陈强峰
	 * <br>Date:2013-6-5
	 * @param zipFileName 
	 * @param inputFile
	 */
	public void zip(String zipFileName,String inputFile);

	   
	/**
	 * <br>Description:解压缩
	 * <br>Author:陈强峰
	 * <br>Date:2013-6-5
	 * @param zipFileName
	 * @param outputDirectory
	 */
	public void unZip(String zipFileName,String outputDirectory);
}
