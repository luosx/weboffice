package com.klspta.web.cbd.zcgl.tdzcgl;

import com.klspta.base.AbstractBaseBean;
import com.klspta.web.cbd.yzt.cbjhzhb.Cbjhzhb;

/**
 * 
 * <br>Title:TODO 类标题
 * <br>Description:TODO 类功能描述
 * <br>Author:黎春行
 * <br>Date:2014-1-19
 */
public class TdzcglManager extends AbstractBaseBean{
	private String[][] fields = {{"dkmc","false","null"},{"jsydmj","false","sum"},{"rjl","false","avg"},{"ghjzgm","false","sum"},{"jzkzgd","false","avg"},{"DJZJ","true","sum"},{"DJYJLY","true","sum"},{"DJYJLB","true","null"},{"ZFSYZE","true","sum"},{"ZFSYYJLY","true","sum"}
	,{"ZFSYYJLB","true","sum"},{"ZFSYHTYD","true","null"},{"ZFSYWYJ","true","sum"},{"BCFZE","true","sum"},{"BCFYJLY","true","sum"},{"BCFYJLB","true","null"},{"BCFHTYD","true","null"},{"BCFYCSWY","true","sum"},{"DJKJLSJ","true","null"},{"CBZH","true","null"}
	,{"ZCMJ","true","sum"},{"CRSJ","true","null"},{"ZBR","true","null"},{"JDSJ","true","null"},{"YJSJ","true","null"},{"KGSJ","true","null"},{"TDXZSJ","true","null"},{"YT","true","null"},{"SFYL","true","null"},{"DGDW","true","null"}
	,{"SX","true","null"},{"bz","true","null"}};
	/**
	 * 
	 * <br>Description:TODO 方法功能描述
	 * <br>Author:黎春行
	 * <br>Date:2014-1-19
	 * @throws Exception
	 */
	public void add() throws Exception{
		String xmmc = new String(request.getParameter("xmmc").getBytes("iso-8859-1"),"utf-8");
		String dkmc = new String(request.getParameter("dkmc").getBytes("iso-8859-1"),"utf-8");
		String status = new String(request.getParameter("status").getBytes("iso-8859-1"),"utf-8");
		TdzcglData tdzcglData = new TdzcglData();
		boolean result = tdzcglData.insertXMMC(xmmc, dkmc, status);
		 response("{success:true}");
	}
	
	public void update() throws Exception{
    	String dkmc =new String(request.getParameter("key").getBytes("iso-8859-1"), "UTF-8");
    	String index = request.getParameter("vindex");
    	String value = new String(request.getParameter("value").getBytes("iso-8859-1"), "UTF-8");
    	String field = fields[Integer.parseInt(index)][0];
    	TdzcglData tdzcglData = new TdzcglData();
    	boolean result = tdzcglData.update(dkmc, field, value);
    	 response("{success:true}");
	}
}
