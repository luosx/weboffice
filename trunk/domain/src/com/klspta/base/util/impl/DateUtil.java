package com.klspta.base.util.impl;

import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import com.klspta.base.util.api.IDateUtil;

public class DateUtil implements IDateUtil{
    private static DateUtil instance;

    public static IDateUtil getInstance(String key) throws Exception {
        if (!key.equals("NEW WITH UTIL FACTORY!")) {
            throw new Exception("请通过UtilFactory获取实例.");
        }
        if (instance == null) {
            return new DateUtil();
        } else {
            return instance;
        }
    }

    @Override
    public String getChineseDate(Date d) {
        if (d == null) {
            return "";
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", new DateFormatSymbols());

        String dtrDate = df.format(d);
        return dtrDate.substring(0, 4) + "年" + Integer.parseInt(dtrDate.substring(4, 6)) + "月"
                + Integer.parseInt(dtrDate.substring(6, 8)) + "日";
    }

    @Override
    public String getCurrentChineseDate() {
        Calendar calendar= Calendar.getInstance(); 
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
        return sdf.format(calendar.getTime()); 
    }
    
    @Override
	public String getSimpleDate(Date d) {
		   SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", new DateFormatSymbols());
	       String dtrDate = df.format(d);
	       return dtrDate.substring(0, 4) + "-" + Integer.parseInt(dtrDate.substring(4, 6)) + "-"
	                + Integer.parseInt(dtrDate.substring(6, 8)) + "-";
	}
    
    
}
