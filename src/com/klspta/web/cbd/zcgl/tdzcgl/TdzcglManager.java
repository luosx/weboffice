package com.klspta.web.cbd.zcgl.tdzcgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.web.cbd.yzt.cbjhzhb.Cbjhzhb;

/**
 * 
 * <br>
 * Title:TODO 类标题 <br>
 * Description:TODO 类功能描述 <br>
 * Author:黎春行 <br>
 * Date:2014-1-19
 */
public class TdzcglManager extends AbstractBaseBean {
	private String[][] fields = { { "dkmc", "false", "null" },
			{ "jsydmj", "false", "sum" }, { "rjl", "false", "avg" },
			{ "ghjzgm", "false", "sum" }, { "jzkzgd", "false", "avg" },
			{ "DJZJ", "true", "sum" }, { "DJYJLY", "true", "sum" },
			{ "DJYJLB", "true", "null" }, { "ZFSYZE", "true", "sum" },
			{ "ZFSYYJLY", "true", "sum" }, { "ZFSYYJLB", "true", "sum" },
			{ "ZFSYHTYD", "true", "null" }, { "ZFSYWYJ", "true", "sum" },
			{ "BCFZE", "true", "sum" }, { "BCFYJLY", "true", "sum" },
			{ "BCFYJLB", "true", "null" }, { "BCFHTYD", "true", "null" },
			{ "BCFYCSWY", "true", "sum" }, { "DJKJLSJ", "true", "null" },
			{ "CBZH", "true", "null" }, { "ZCMJ", "true", "sum" },
			{ "CRSJ", "true", "null" }, { "ZBR", "true", "null" },
			{ "JDSJ", "true", "null" }, { "YJSJ", "true", "null" },
			{ "KGSJ", "true", "null" }, { "TDXZSJ", "true", "null" },
			{ "YT", "true", "null" }, { "SFYL", "true", "null" },
			{ "DGDW", "true", "null" }, { "SX", "true", "null" },
			{ "bz", "true", "null" } };

	/**
	 * 
	 * <br>
	 * Description:TODO 方法功能描述 <br>
	 * Author:黎春行 <br>
	 * Date:2014-1-19
	 * 
	 * @throws Exception
	 */

	/**
	 * public void add() throws Exception{ String xmmc = new
	 * String(request.getParameter("xmmc").getBytes("iso-8859-1"),"utf-8");
	 * String dkmc = new
	 * String(request.getParameter("dkmc").getBytes("iso-8859-1"),"utf-8");
	 * String status = new
	 * String(request.getParameter("status").getBytes("iso-8859-1"),"utf-8");
	 * TdzcglData tdzcglData = new TdzcglData(); boolean result =
	 * tdzcglData.insertXMMC(xmmc, dkmc, status); response("{success:true}"); }
	 * 
	 * public void update() throws Exception{ String dkmc =new
	 * String(request.getParameter("key").getBytes("iso-8859-1"), "UTF-8");
	 * String index = request.getParameter("vindex"); String value = new
	 * String(request.getParameter("value").getBytes("iso-8859-1"), "UTF-8");
	 * String field = fields[Integer.parseInt(index)][0]; TdzcglData tdzcglData =
	 * new TdzcglData(); boolean result = tdzcglData.update(dkmc, field, value);
	 * response("{success:true}"); }
	 */

	public void add() throws Exception {
		String xmmc = request.getParameter("xmmc");
		String dkmc = request.getParameter("dkmc");
		String status = request.getParameter("status");
		String ydxz = request.getParameter("ydxz");
		String jsydmj = request.getParameter("jsydmj");
		String rjl = request.getParameter("rjl");
		String ghjzgm = request.getParameter("ghjzgm");
		String jzkzgd = request.getParameter("jzkzgd");
		String djkzj = request.getParameter("djkzj");
		String djkyjn = request.getParameter("djkyjn");
		String djkyjnbl = request.getParameter("djkyjnbl");
		String zfsyze = request.getParameter("zfsyze");
		String zfsyyjn = request.getParameter("zfsyyjn");
		String zfsyyjnbl = request.getParameter("zfsyyjnbl");
		String zfsyydjnsj = request.getParameter("zfsyydjnsj");
		String zfsywyj = request.getParameter("zfsywyj");
		String bcfze = request.getParameter("bcfze");
		String bcfyjn = request.getParameter("bcfyjn");
		String bcfyjnbl = request.getParameter("bcfyjnbl");
		String bcfydjnsj = request.getParameter("bcfydjnsj");
		String bcfwyj = request.getParameter("bcfwyj");
		String djkjnsj = request.getParameter("djkjnsj");
		String cbzh = request.getParameter("cbzh");
		String zzmj = request.getParameter("zzmj");
		String crsj = request.getParameter("crsj");
		String zbr = request.getParameter("zbr");
		String xyydjdsj = request.getParameter("xyydjdsj");
		String tdyjsj = request.getParameter("tdyjsj");
		String xmkgsj = request.getParameter("xmkgsj");
		String tdxzsj = request.getParameter("tdxzsj");
		String yt = request.getParameter("yt");
		String sfyl = request.getParameter("sfyl");
		String dgdw = request.getParameter("dgdw");
		String sx = request.getParameter("sx");
		String bz = request.getParameter("bz");
		String sql = "select t.xmmc as xmmc ,t.dkmc as dkmc from ZCGL_TDZCGL t where t.xmmc=? and t.dkmc=?";

		List<Map<String, Object>> list = query(sql, YW, new Object[] { xmmc,
				dkmc });
		if (list.size() == 0) {
			sql = "insert into ZCGL_TDZCGL(xmmc,thirsta,dkmc,djzj,"
					+ "djyjly,djyjlb,zfsyze,zfsyyjly,zfsyyjlb,zfsyhtyd,zfsywyj,bcfze,bcfyjly,bcfyjlb,"
					+ "bcfhtyd,bcfycswy,djkjlsj,cbzh,zcmj,crsj,zbr,jdsj,yjsj,kgsj,tdxzsj,yt,sfyl,dgdw,sx,bz)"
					+ " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			update(sql, YW, new Object[] { xmmc, status, dkmc, djkzj, djkyjn,
					djkyjnbl, zfsyze, zfsyyjn, zfsyyjnbl, zfsyydjnsj, zfsywyj,
					bcfze, bcfyjn, bcfyjnbl, bcfydjnsj, bcfwyj, djkjnsj, cbzh,
					zzmj, crsj, zbr, xyydjdsj, tdyjsj, xmkgsj, tdxzsj, yt,
					sfyl, dgdw, sx, bz });
		} else {
			sql = "update ZCGL_TDZCGL set thirsta=?,djzj=?,"
					+ "djyjly=?,djyjlb=?,zfsyze=?,zfsyyjly=?,zfsyyjlb=?,zfsyhtyd=?,zfsywyj=?,bcfze=?,bcfyjly=?,bcfyjlb=?,"
					+ "bcfhtyd=?,bcfycswy=?,djkjlsj=?,cbzh=?,zcmj=?,crsj=?,zbr=?,jdsj=?,yjsj=?,kgsj=?,tdxzsj=?"
					+ ",yt=?,sfyl=?,dgdw=?,sx=?,bz=? where xmmc=? and dkmc=?";
			update(sql, YW, new Object[] { status, djkzj, djkyjn, djkyjnbl,
					zfsyze, zfsyyjn, zfsyyjnbl, zfsyydjnsj, zfsywyj, bcfze,
					bcfyjn, bcfyjnbl, bcfydjnsj, bcfwyj, djkjnsj, cbzh, zzmj,
					crsj, zbr, xyydjdsj, tdyjsj, xmkgsj, tdxzsj, yt, sfyl,
					dgdw, sx, bz, xmmc, dkmc });
		}
		response("{success:true}");
	}

	public void getGHSJByDKMC() {
		String dkmc = request.getParameter("dkmc");
		String sql = "select * from dcsjk_kgzb where dkmc = ?";
		List<Map<String, Object>> list = query(sql, YW, new Object[] { dkmc });
		response(list);
	}

	public void deleteByDKMC() {
		try {
			String dkmc = request.getParameter("dkmc");
			dkmc = UtilFactory.getStrUtil().unescape(dkmc);
			String sql = "delete from ZCGL_TDZCGL where dkmc=?";
			update(sql, YW, new Object[] { dkmc });
			response("{success:true}");
		} catch (Exception e) {
			response("{success:false}");
		}

	}
	
	public void addAZF(){
	    String ydmc = request.getParameter("ydmc");
	    String tdyjkfzt = request.getParameter("tdyjkfzt");
	    String zdmj = request.getParameter("zdmj");
	    String jsyd = request.getParameter("jsyd");
	    String ghrjl = request.getParameter("ghrjl");
	    String ghjzgm = request.getParameter("ghjzgm");
	    String ghyt = request.getParameter("ghyt");
	    String kg = request.getParameter("kg");
	    String tdcb = request.getParameter("tdcb");
	    String yjkxcazfts = request.getParameter("yjkxcazfts");
	    String gdfs = request.getParameter("gdfs");
	    String tdkfjsbcxy = request.getParameter("tdkfjsbcxy");
	    String tdyj = request.getParameter("tdyj");
	    String azfjsdw = request.getParameter("azfjsdw");
	    String tdcrht = request.getParameter("tdcrht");
	    String crhtydkgsj = request.getParameter("crhtydkgsj");
	    String tdz = request.getParameter("tdz");
	    String bz = request.getParameter("bz");
	    String sql = "insert into ZC_AZFZC(ydmc,tdyjkfzt,zdmj,jsyd,ghrjl,ghjzgm,ghyt,kg,tdcb,yjkxcazfts,gdfs,tdkfjsbcxy,tdyj,azfjsdw,tdcrht,crhtydkgsj,tdz,bz) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	    this.update(sql, YW, new Object[]{ydmc,tdyjkfzt,zdmj,jsyd,ghrjl,ghjzgm,ghyt,kg,tdcb,yjkxcazfts,gdfs,tdkfjsbcxy,tdyj,azfjsdw,tdcrht,crhtydkgsj,tdz,bz});
	    response("{success:true}");
	}
}
