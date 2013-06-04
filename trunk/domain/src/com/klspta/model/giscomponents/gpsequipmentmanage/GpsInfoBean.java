package com.klspta.model.giscomponents.gpsequipmentmanage;
/**
 * @Description 运行统计查询结构Bean
 * @author 尹
 * @version 1.0
 * @since JDK.6
 */
public class GpsInfoBean {
	private String type;
	private String name;
	private String x;
	private String y;
	private String time;
	private String speed;
	private String direction;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getSpeed() {
		return speed;
	}
	public void setSpeed(String speed) {
		this.speed = speed;
	}
	public String getDirection() {
		return direction;
	}
	public void setDirection(String direction) {
		this.direction = direction;
	}
	
	public GpsInfoBean(){}
	
	public GpsInfoBean(String type, String name, String x, String y, String time, String speed, String direction){
		this.type = type;
		this.name = name;
		this.x = x;
		this.y = y;
		this.time = time;
		this.speed = speed;
		this.direction = direction;
	}
}
