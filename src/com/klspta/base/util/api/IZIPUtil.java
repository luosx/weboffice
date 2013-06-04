/**
 * Create Date:2009-7-29
 */
package com.klspta.base.util.api;

import java.util.Vector;

public interface IZIPUtil {

	public void zip(String zipFileName,String inputFile);

	//public Vector<String> unzip(String zipFileName,String outputDirectory);
	
	public void unZip(String zipFileName,String outputDirectory);
}
