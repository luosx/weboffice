package com.klspta.web.xiamen.device.job;

import java.sql.Timestamp;

public class InsertToSDEBean {
    private String sqlString;
    private String bh;
    private String year; 
    private String month; 
    private String day;
    private String hour; 
    private int srid; 
    private String wktString; 
    private String xzqString; 
    private Timestamp beginDate; 
    private Timestamp endDate;
    
    public String getSqlString() {
        return sqlString;
    }
    public void setSqlString(String sqlString) {
        this.sqlString = sqlString;
    }
    public String getBh() {
        return bh;
    }
    public void setBh(String bh) {
        this.bh = bh;
    }
    public String getYear() {
        return year;
    }
    public void setYear(String year) {
        this.year = year;
    }
    public String getMonth() {
        return month;
    }
    public void setMonth(String month) {
        this.month = month;
    }
    public String getDay() {
        return day;
    }
    public void setDay(String day) {
        this.day = day;
    }
    public String getHour() {
        return hour;
    }
    public void setHour(String hour) {
        this.hour = hour;
    }
    public int getSrid() {
        return srid;
    }
    public void setSrid(int srid) {
        this.srid = srid;
    }
    public String getWktString() {
        return wktString;
    }
    public void setWktString(String wktString) {
        this.wktString = wktString;
    }
    public String getXzqString() {
        return xzqString;
    }
    public void setXzqString(String xzqString) {
        this.xzqString = xzqString;
    }
    public Timestamp getBeginDate() {
        return beginDate;
    }
    public void setBeginDate(Timestamp beginDate) {
        this.beginDate = beginDate;
    }
    public Timestamp getEndDate() {
        return endDate;
    }
    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

}
