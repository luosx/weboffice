package com.klspta.web.xuzhouNW.report;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class ReportBean {
	public Date getSAVETIME() {
		return SAVETIME;
	}

	public void setSAVETIME(Date sAVETIME) {
		SAVETIME = sAVETIME;
	}

	public String getSAVEROLE() {
		return SAVEROLE;
	}

	public void setSAVEROLE(String sAVEROLE) {
		SAVEROLE = sAVEROLE;
	}

	private String TZID;
	private String WFZT;
	private String SZQY;
	private String MJ;
	private String YT;
	private String AJLY;
	private String AYDJRQ;
	private String TZWFTZSBH;
	private String TZWFTZSXDRQ;
	private String LABH;
	private String LARQ;
	private String TZGZSBH;
	private String TZGZSXDRQ;
	private String CFGZSBH;
	private String CFGZSXDRQ;
	private String CFJDSBH;
	private String CFJDSXDRQ;
	private String ZLLXTZSBH;
	private String ZLLXTZSXDRQ;
	private String YSJJBH;
	private String YSJJSJ;
	private String YSGABH;
	private String YSGASJ;
	private String QZZXSBH;
	private String QZZXSSJ;
	private String CWYJSBH;
	private String CWYJSSJ;
	private String JACPBH;
	private String JASJ;
	private String WLAYY;
	private String QYJGZRR;
	private String BZ;

	private String SBZT = "1";
	private Date SBSJ;
	private String SBYJ;
	private String SAVEROLE;
	private Date SAVETIME;// =new Date(new java.util.Date().getTime());

	private String SFLA;
	private String QZNR;

	private Map<String, Object> map;

	public ReportBean() {
	}

	public ReportBean(Map<String, Object> map) {
		resetBean(map);
	}

	public void resetBean(Map<String, Object> map) {
		this.map = map;
		if (map.containsKey("TZID")) {
			this.TZID =  map.get("TZID").toString();
		} else {
			this.TZID = "";
		}
		if (map.containsKey("wfzt")) {
			this.WFZT = (String) map.get("WFZT");
		} else {
			this.WFZT = "";
		}
		if (map.containsKey("szqy")) {
			this.SZQY = (String) map.get("SZQY");
		} else {
			this.SZQY = "";
		}
		if (map.containsKey("MJ")) {
			this.MJ = (String) map.get("MJ");
		} else {
			this.MJ = "";
		}
		if (map.containsKey("YT")) {
			this.YT = (String) map.get("YT");
		} else {
			this.YT = "";
		}
		if (map.containsKey("AJLY")) {
			this.AJLY = (String) map.get("AJLY");
		} else {
			this.AJLY = "";
		}
		if (map.containsKey("AJDJRQ")) {
			this.AYDJRQ = (String) map.get("AYDJRQ");
		} else {
			this.AYDJRQ = "";
		}
		if (map.containsKey("TZWFTZSBH")) {
			this.TZWFTZSBH = (String) map.get("TZWFTZSBH");
		} else {
			this.TZWFTZSBH = "";
		}
		if (map.containsKey("TZWFTZSXDRQ")) {
			this.TZWFTZSXDRQ = (String) map.get("TZWFTZSXDRQ");
		} else {
			this.TZWFTZSXDRQ = "";
		}
		if (map.containsKey("LABH")) {
			this.LABH = (String) map.get("LABH");
		} else {
			this.LABH = "";
		}
		if (map.containsKey("LARQ")) {
			this.LARQ = (String) map.get("LARQ");
		} else {
			this.LARQ = "";
		}
		if (map.containsKey("TZGZSBH")) {
			this.TZGZSBH = (String) map.get("TZGZSBH");
		} else {
			this.TZGZSBH = "";
		}
		if (map.containsKey("TZGZSXDRQ")) {
			this.TZGZSXDRQ = (String) map.get("TZGZSXDRQ");
		} else {
			this.TZGZSXDRQ = "";
		}
		if (map.containsKey("CFGZSBH")) {
			this.CFGZSBH = (String) map.get("CFGZSBH");
		} else {
			this.CFGZSBH = "";
		}
		if (map.containsKey("CFGZSXDRQ")) {
			this.CFGZSXDRQ = (String) map.get("CFGZSXDRQ");
		} else {
			this.CFGZSXDRQ = "";
		}
		if (map.containsKey("CFJDSBH")) {
			this.CFJDSBH = (String) map.get("CFJDSBH");
		} else {
			this.CFJDSBH = "";
		}
		if (map.containsKey("CFJDSXDRQ")) {
			this.CFJDSXDRQ = (String) map.get("CFJDSXDRQ");
		} else {
			this.CFJDSXDRQ = "";
		}
		if (map.containsKey("ZLLXTZSBH")) {
			this.ZLLXTZSBH = (String) map.get("ZLLXTZSBH");
		} else {
			this.ZLLXTZSBH = "";
		}
		if (map.containsKey("ZLLXTZSXDRQ")) {
			this.ZLLXTZSXDRQ = (String) map.get("ZLLXTZSXDRQ");
		} else {
			this.ZLLXTZSXDRQ = "";
		}
		if (map.containsKey("YSJJBH")) {
			this.YSJJBH = (String) map.get("YSJJBH");
		} else {
			this.YSJJBH = "";
		}
		if (map.containsKey("YSJJSJ")) {
			this.YSJJSJ = (String) map.get("YSJJSJ");
		} else {
			this.YSJJSJ = "";
		}
		if (map.containsKey("YSGABH")) {
			this.YSGABH = (String) map.get("YSGABH");
		} else {
			this.YSGABH = "";
		}
		if (map.containsKey("YSGASJ")) {
			this.YSGASJ = (String) map.get("YSGASJ");
		} else {
			this.YSGASJ = "";
		}
		if (map.containsKey("QZZXSBH")) {
			this.QZZXSBH = (String) map.get("QZZXSBH");
		} else {
			this.QZZXSBH = "";
		}
		if (map.containsKey("QZZXSSJ")) {
			this.QZZXSSJ = (String) map.get("QZZXSSJ");
		} else {
			this.QZZXSSJ = "";
		}
		if (map.containsKey("CWYJSBH")) {
			this.CWYJSBH = (String) map.get("CWYJSBH");
		} else {
			this.CWYJSBH = "";
		}
		if (map.containsKey("CWYJSSJ")) {
			this.CWYJSSJ = (String) map.get("CWYJSSJ");
		} else {
			this.CWYJSSJ = "";
		}
		if (map.containsKey("JACPBH")) {
			this.JACPBH = (String) map.get("JACPBH");
		} else {
			this.JACPBH = "";
		}
		if (map.containsKey("JASJ")) {
			this.JASJ = (String) map.get("JASJ");
		} else {
			this.JASJ = "";
		}
		if (map.containsKey("WLAYY")) {
			this.WLAYY = (String) map.get("WLAYY");
		} else {
			this.WLAYY = "";
		}
		if (map.containsKey("QYJGZRR")) {
			this.QYJGZRR = (String) map.get("QYJGZRR");
		} else {
			this.QYJGZRR = "";
		}
		if (map.containsKey("BZ")) {
			this.BZ = (String) map.get("BZ");
		} else {
			this.BZ = "";
		}

		if (map.containsKey("SFLA")) {
			this.SFLA = (String) map.get("SFLA");
		} else {
			this.SFLA = "";
		}
		if (map.containsKey("QZNR")) {
			this.SFLA = (String) map.get("QZNR");
		} else {
			this.SFLA = "";
		}

		if (map.get("SBYJ") == null) {
			this.map.put("SBYJ", this.SBYJ);
		} else
			this.SBYJ = (String) map.get("SBYJ");

		if (map.get("SBSJ") == null) {
			this.map.put("SBSJ", this.SBSJ);
		} else
		// this.BGSJ=getDateObject("SBSJ",map.get("SBSJ"));

		if (map.get("SBZT") == null) {
			this.map.put("SBZT", this.SBZT);
		} else {
			this.SBZT = (String) map.get("SBZT");
		}
		if (map.get("SAVEROLE") == null) {
			this.map.put("SAVEROLE", this.SAVEROLE);
		} else {
			this.SAVEROLE = (String) map.get("SAVEROLE");
		}
		if (map.get("SAVETIME") == null) {
			this.map.put("SAVETIME", this.SAVETIME);
		} else {
			this.SAVETIME = getDateObject("SAVETIME", map.get("SAVETIME"));
		}

	}

	private Date getDateObject(String key, Object obj) {

		Date date;
		if (obj instanceof String) {
			String time = (String) obj;
			if ("".equals(time)) {
				return null;
			}
			String[] dateStr = ((String) obj).split("-");
			Calendar ca = Calendar.getInstance();
			ca.set(Integer.parseInt(dateStr[0]),
					Integer.parseInt(dateStr[1]) - 1, 1);
			date = new Date(ca.getTimeInMillis());
			map.remove(key);
			map.put(key, date);
			return date;
		} else if (obj == null) {
			return null;
		} else if (obj instanceof Timestamp) {
			date = new Date(((Timestamp) obj).getTime());
			map.remove(key);
			map.put(key, date);
			return date;
		} else
			return (Date) obj;
	}

	public Map<String, String> getValues() {
		Map<String, String> map = new HashMap<String, String>();
		StringBuffer keys = new StringBuffer("[");
		StringBuffer values = new StringBuffer("[");

		Object obj;

		for (String key : this.map.keySet()) {
			obj = this.map.get(key);

			if (obj != null) {

				keys.append("'");
				keys.append(key);
				keys.append("',");
				values.append("'");
				if (obj instanceof String)
					values.append(obj.toString());
				else if (obj instanceof Timestamp)
					values.append(getDateString(new Date(((Timestamp) obj)
							.getTime())));
				else
					values.append(getDateString((Date) obj));
				values.append("',");
			}
		}

		map.put("key", keys.substring(0, keys.length() - 1) + "]");
		map.put("value", values.substring(0, values.length() - 1) + "]");
		return map;

	}

	public Map<String, String> getStringMap() {
		Map<String, String> map = new HashMap<String, String>();
		Object obj;
		int i=0;
		for (String key : this.map.keySet()) {
			obj = this.map.get(key);
		
			if (obj != null) {

				if (obj instanceof String) {
					map.put(key, obj.toString());
				}else if(obj instanceof BigDecimal){
					map.put(key, obj.toString());
				} else {
					if (obj instanceof Timestamp) {
						map.put(key, getDateString(new Date(((Timestamp) obj)
								.getTime())));
					} else
						map.put(key, getDateString((Date) obj));
				}
			}
		}
		return map;
	}

	private String getDateString(Date date) {
		Calendar ca = Calendar.getInstance();
		ca.setTime(date);

		return ca.get(Calendar.YEAR) + "-" + (ca.get(Calendar.MONTH) + 1);
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

	public String getTZID() {
		return TZID;
	}

	public void setTZID(String tZID) {
		TZID = tZID;
	}

	public String getSBYJ() {
		return SBYJ;
	}

	public void setSBYJ(String sBYJ) {
		SBYJ = sBYJ;
	}

	public Date getSBSJ() {
		return SBSJ;
	}

	public void setSBSJ(Date sBSJ) {
		SBSJ = sBSJ;
	}

	public String getSBZT() {
		return SBZT;
	}

	public void setSBZT(String sBZT) {
		SBZT = sBZT;
	}

	public String getWFZT() {
		return WFZT;
	}

	public void setWFZT(String wfzt) {
		WFZT = wfzt;
	}

	public String getSZQY() {
		return SZQY;
	}

	public void setSZQY(String szqy) {
		SZQY = szqy;
	}

	public String getMJ() {
		return MJ;
	}

	public void setMJ(String mj) {
		MJ = mj;
	}

	public String getYT() {
		return YT;
	}

	public void setYT(String yt) {
		YT = yt;
	}

	public String getAJLY() {
		return AJLY;
	}

	public void setAJLY(String ajly) {
		AJLY = ajly;
	}

	public String getAYDJRQ() {
		return AYDJRQ;
	}

	public void setAYDJRQ(String aydjrq) {
		AYDJRQ = aydjrq;
	}

	public String getTZWFTZSBH() {
		return TZWFTZSBH;
	}

	public void setTZWFTZSBH(String tzwftzsbh) {
		TZWFTZSBH = tzwftzsbh;
	}

	public String getTZWFTZSXDRQ() {
		return TZWFTZSXDRQ;
	}

	public void setTZWFTZSXDRQ(String tzwftzsxdrq) {
		TZWFTZSXDRQ = tzwftzsxdrq;
	}

	public String getLABH() {
		return LABH;
	}

	public void setLABH(String labh) {
		LABH = labh;
	}

	public String getLARQ() {
		return LARQ;
	}

	public void setLARQ(String larq) {
		LARQ = larq;
	}

	public String getTZGZSBH() {
		return TZGZSBH;
	}

	public void setTZGZSBH(String tzgzsbh) {
		TZGZSBH = tzgzsbh;
	}

	public String getTZGZSXDRQ() {
		return TZGZSXDRQ;
	}

	public void setTZGZSXDRQ(String tzgzsxdrq) {
		TZGZSXDRQ = tzgzsxdrq;
	}

	public String getCFGZSBH() {
		return CFGZSBH;
	}

	public void setCFGZSBH(String cfgzsbh) {
		CFGZSBH = cfgzsbh;
	}

	public String getCFGZSXDRQ() {
		return CFGZSXDRQ;
	}

	public void setCFGZSXDRQ(String cfgzsxdrq) {
		CFGZSXDRQ = cfgzsxdrq;
	}

	public String getCFJDSBH() {
		return CFJDSBH;
	}

	public void setCFJDSBH(String cfjdsbh) {
		CFJDSBH = cfjdsbh;
	}

	public String getCFJDSXDRQ() {
		return CFJDSXDRQ;
	}

	public void setCFJDSXDRQ(String cfjdsxdrq) {
		CFJDSXDRQ = cfjdsxdrq;
	}

	public String getZLLXTZSBH() {
		return ZLLXTZSBH;
	}

	public void setZLLXTZSBH(String zllxtzsbh) {
		ZLLXTZSBH = zllxtzsbh;
	}

	public String getZLLXTZSXDRQ() {
		return ZLLXTZSXDRQ;
	}

	public void setZLLXTZSXDRQ(String zllxtzsxdrq) {
		ZLLXTZSXDRQ = zllxtzsxdrq;
	}

	public String getYSJJBH() {
		return YSJJBH;
	}

	public void setYSJJBH(String ysjjbh) {
		YSJJBH = ysjjbh;
	}

	public String getYSJJSJ() {
		return YSJJSJ;
	}

	public void setYSJJSJ(String ysjjsj) {
		YSJJSJ = ysjjsj;
	}

	public String getYSGABH() {
		return YSGABH;
	}

	public void setYSGABH(String ysgabh) {
		YSGABH = ysgabh;
	}

	public String getYSGASJ() {
		return YSGASJ;
	}

	public void setYSGASJ(String ysgasj) {
		YSGASJ = ysgasj;
	}

	public String getQZZXSBH() {
		return QZZXSBH;
	}

	public void setQZZXSBH(String qzzxsbh) {
		QZZXSBH = qzzxsbh;
	}

	public String getQZZXSSJ() {
		return QZZXSSJ;
	}

	public void setQZZXSSJ(String qzzxssj) {
		QZZXSSJ = qzzxssj;
	}

	public String getCWYJSBH() {
		return CWYJSBH;
	}

	public void setCWYJSBH(String cwyjsbh) {
		CWYJSBH = cwyjsbh;
	}

	public String getCWYJSSJ() {
		return CWYJSSJ;
	}

	public void setCWYJSSJ(String cwyjssj) {
		CWYJSSJ = cwyjssj;
	}

	public String getJACPBH() {
		return JACPBH;
	}

	public void setJACPBH(String jacpbh) {
		JACPBH = jacpbh;
	}

	public String getJASJ() {
		return JASJ;
	}

	public void setJASJ(String jasj) {
		JASJ = jasj;
	}

	public String getWLAYY() {
		return WLAYY;
	}

	public void setWLAYY(String wlayy) {
		WLAYY = wlayy;
	}

	public String getQYJGZRR() {
		return QYJGZRR;
	}

	public void setQYJGZRR(String qyjgzrr) {
		QYJGZRR = qyjgzrr;
	}

	public String getSFLA() {
		return SFLA;
	}

	public void setSFLA(String sfla) {
		SFLA = sfla;
	}

	public String getQZNR() {
		return QZNR;
	}

	public void setQZNR(String qznr) {
		QZNR = qznr;
	}

	public String getBZ() {
		return BZ;
	}

	public void setBZ(String bz) {
		BZ = bz;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return this.LABH +" : "+ this.TZGZSBH +" : " + this.CFGZSBH;
	}


}