package com.klspta.model.wyrw;

import com.klspta.base.AbstractBaseBean;

public class GPSDeviceBean extends AbstractBaseBean{
    
    private static String sql = "insert into car_location_history t values ( ?,  ?,  ?,  sysdate)";

    
    private String name = "";

    private String unit = "";

    private String person = "";

    private String personphone = "";
    
    private String cantoncode = "";

    private String number = "";

    private String infoxzqhname = "";

    private String lx="";

    private String id = "";

    private String style = "";

    private java.util.Date gmrq = null;
    
    private String x = "0";
    
    private String y = "0";
    
    private String speed = "0";
    
    private String dir = "0";
    
    private boolean engine = false;
    
    public void setGPSInfo(String x, String y) {
        this.x = x;
        this.y = y;
        update(sql, YW, new Object[] { id, x, y});    
        System.out.println("获取外业设备位置:" + id + ":" + x + "," + y);
    }
    
    public String getname() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    public String getPersonphone() {
        return personphone;
    }

    public void setPersonphone(String personphone) {
        this.personphone = personphone;
    }

    public String getCantoncode() {
        return cantoncode;
    }

    public void setCantoncode(String cantoncode) {
        this.cantoncode = cantoncode;
    }
    
    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getinfoxzqhname() {
        return infoxzqhname;
    }

    public void setInfoxzqhname(String infoxzqhname) {
        this.infoxzqhname = infoxzqhname;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public String getX() {
        return x;
    }

    public void setX(String x) {
        this.x = x;
    }

    public String getY() {
        return y;
    }

    public void setY(String y) {
        this.y = y;
    }

    public void setXY(String x, String y){
    	this.x = x;
    	this.y = y;
    }
    
    public String getSpeed() {
        return speed;
    }

    public void setSpeed(String speed) {
        this.speed = speed;
    }

    public String getDir() {
        return dir;
    }

    public void setDir(String dir) {
        this.dir = dir;
    }
    
    public String getInfo(){
        return id + "," + x + "," + y;
    }

	public String getLx() {
		return lx;
	}

	public void setLx(String lx) {
		this.lx = lx;
	}

	public boolean isEngine() {
		return engine;
	}

	public void setEngine(boolean engine) {
		this.engine = engine;
	}

	public java.util.Date getGmrq() {
		return gmrq;
	}

	public void setGmrq(java.util.Date gmrq) {
		this.gmrq = gmrq;
	}

}
