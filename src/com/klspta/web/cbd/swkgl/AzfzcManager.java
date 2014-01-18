package com.klspta.web.cbd.swkgl;

import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class AzfzcManager extends AbstractBaseBean {

	private static AzfzcManager AzfzcManager;

	public static AzfzcManager getInstcne() {
		if (AzfzcManager == null) {
			AzfzcManager = new AzfzcManager();
		}
		return AzfzcManager;
	}

	public String getList() {
		String sql = "select t.*  from azfzc t ";
		List<Map<String, Object>> list = query(sql, YW);
		StringBuffer result = new StringBuffer(
				"<table id='azftable' name='esftable' ><tr id='-1'><td class='tr01'>序号</td><td class='tr01'>用地名称</td><td  class='tr01'>土地一级开发主体</td><td  class='tr01'>占地面积</td><td width=300 class='tr01'>建设用地</td><td  class='tr01'>规划容积率</td><td class='tr01'>规划建筑规模</td> ");
		result
				.append("<td class='tr01'>规划用途</td><td  class='tr01'>控高</td><td  class='tr01'>土地成本</td><td  class='tr01'>预计可形成安置房套数</td><td class='tr01'>供地方式</td><td class='tr01'>土地开发建设补偿协议</td><td class='tr01'>土地移交</td><td class='tr01'>安置房建设单位</td><td class='tr01'>土地出让合同</td><td class='tr01'>出让合同约定开工时间</td><td class='tr01'>土地证</td><td class='tr01'>备注</td><td class='tr01'>操作</td></tr> ");
		String add = "<tr id='newRow' class='tr02' style='display:none;'><td align='center' height='10' width='10'></td>"
				+ "<td align='center' height='10' width='10'><input id='ydmc' size=10 type='text'/></td>"
				+ "<td align='center' height='10' width='10'><input id='tdyjkfzt' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='5'><input id='zdmj' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='5'><input id='jsyd' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='5'><input id='ghrjl' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='5'><input id='ghjzgm' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='5'><input id='ghyt' size=10 type='text'/></td>"
				+ "<td align='center' height='10' width='5'><input id='kg' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='10'><input id='tdcb' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='10'><input id='yjkxcazfts' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='10'><input id='gdfs' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='10'><input id='tdkfjsbcxy' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='10'><input id='tdyj' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='10'><input id='azfjsdw' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='10'><input id='tdcrht' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='10'><input id='crhtydkgsj' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='10'><input id='tdz' size=10 type='text' /></td>"
				+ "<td align='center' height='10' width='10'><input id='bz' size=10 type='text' /></td>"
				+ "<td style='display:none;'><input  id='yw_guid'></td>"
				+ "<td><a href='javascript:save()'>保存</a>&nbsp;&nbsp;<a href='javascript:cancel()'>取消</a></td>  "
				+ "</tr>";
		result.append(add);
		for (int i = 0; i < list.size(); i++) {
			String rownum = i + 1 + "";
			String yw_guid = (String) (list.get(i)).get("YW_GUID");
			result.append("<tr id=row" + i + "><td class='tr02'>" + rownum
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("YDMC")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("TDYJKFZT")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("ZDMJ")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("JSYD")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("GHRJL")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("GHJZGM")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("GHYT")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("KG")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("TDCB")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("YJKXCAZFTS")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("GDFS")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("TDKFJSBCXY")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("TDYJ")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("AZFJSDW")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("TDCRHT")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("CRHTYDKGSJ")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("TDZ")
					+ "</td><td class='tr02'>"
					+ (String) (list.get(i)).get("BZ")
					+ "</td><td style='display:none;'>" + yw_guid
					+ "</td><td><a href='javascript:modify(" + i
					+ ")'>修改</a>&nbsp;&nbsp;<a href=\"javascript:del('"
					+ yw_guid + "')\">删除</a></td></tr>");

		}

		result.append("</table>");
		return result.toString().replaceAll("null", "").replaceAll("\r\n",
				" ; ");
	}

	public void addAZFzc() {
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

		ydmc = UtilFactory.getStrUtil().unescape(ydmc);
		tdyjkfzt = UtilFactory.getStrUtil().unescape(tdyjkfzt);
		ghyt = UtilFactory.getStrUtil().unescape(ghyt);
		gdfs = UtilFactory.getStrUtil().unescape(gdfs);
		tdkfjsbcxy = UtilFactory.getStrUtil().unescape(tdkfjsbcxy);
		tdyj = UtilFactory.getStrUtil().unescape(tdyj);
		azfjsdw = UtilFactory.getStrUtil().unescape(azfjsdw);
		tdcrht = UtilFactory.getStrUtil().unescape(tdcrht);
		tdz = UtilFactory.getStrUtil().unescape(tdz);
		bz = UtilFactory.getStrUtil().unescape(bz);
		String insertString = "insert into azfzc  (ydmc,tdyjkfzt,zdmj,jsyd,ghrjl,ghjzgm,ghyt,kg,tdcb,yjkxcazfts,gdfs,tdkfjsbcxy,tdyj,azfjsdw,tdcrht,crhtydkgsj,tdz,bz)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		int i = update(insertString, YW, new Object[] { ydmc, tdyjkfzt, zdmj,
				jsyd, ghrjl, ghjzgm, ghyt, kg, tdcb, yjkxcazfts, gdfs,
				tdkfjsbcxy, tdyj, azfjsdw, tdcrht, crhtydkgsj, tdz, bz });
		if (i > 0) {
			response("success");
		} else {
			response("failure");
		}
	}

	public void updateAZFzc() {
		String yw_guid = request.getParameter("yw_guid");
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

		ydmc = UtilFactory.getStrUtil().unescape(ydmc);
		tdyjkfzt = UtilFactory.getStrUtil().unescape(tdyjkfzt);
		ghyt = UtilFactory.getStrUtil().unescape(ghyt);
		gdfs = UtilFactory.getStrUtil().unescape(gdfs);
		tdkfjsbcxy = UtilFactory.getStrUtil().unescape(tdkfjsbcxy);
		tdyj = UtilFactory.getStrUtil().unescape(tdyj);
		azfjsdw = UtilFactory.getStrUtil().unescape(azfjsdw);
		tdcrht = UtilFactory.getStrUtil().unescape(tdcrht);
		tdz = UtilFactory.getStrUtil().unescape(tdz);
		bz = UtilFactory.getStrUtil().unescape(bz);
		String insertString = "update azfzc  set ydmc=?,tdyjkfzt=?,zdmj=?,jsyd=?,ghrjl=?,ghjzgm=?,ghyt=?,kg=?,tdcb=?,yjkxcazfts=?,gdfs=?,tdkfjsbcxy=?,tdyj=?,azfjsdw=?,tdcrht=?,crhtydkgsj=?,tdz=?,bz=? where yw_guid=?";
		int i = update(insertString, YW, new Object[] { ydmc, tdyjkfzt, zdmj,
				jsyd, ghrjl, ghjzgm, ghyt, kg, tdcb, yjkxcazfts, gdfs,
				tdkfjsbcxy, tdyj, azfjsdw, tdcrht, crhtydkgsj, tdz, bz ,yw_guid});
		if (i > 0) {
			response("success");
		} else {
			response("failure");
		}
	}

	
	public void delByYwGuid() {
		try {
			String yw_guid = request.getParameter("yw_guid");
			String sql = "delete from azfzc where yw_guid=?";
			update(sql, YW, new Object[] { yw_guid });
			response("success");
		} catch (Exception e) {
			response("false");
			// TODO: handle exception
		}
	}
}
