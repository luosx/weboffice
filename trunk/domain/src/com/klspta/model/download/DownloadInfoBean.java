package com.klspta.model.download;

/**
 * <br>Title:下载信息Bean
 * <br>Description:TODO 类功能描述
 * <br>Author:尹宇星
 * <br>Date:2011-6-20
 */
public class DownloadInfoBean {

	private String title;
	private String people;
	private String date;
	private String type;
	private String section;
	private String content;
	private String isHaveAccessory;

	public String getIsHaveAccessory() {
		return isHaveAccessory;
	}
	public void setIsHaveAccessory(String isHaveAccessory) {
		this.isHaveAccessory = isHaveAccessory;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPeople() {
		return people;
	}
	public void setPeople(String people) {
		this.people = people;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSection() {
		return section;
	}
	public void setSection(String section) {
		this.section = section;
	}
	
	public DownloadInfoBean(){}
	
	public DownloadInfoBean(String title, String people, String date, String type, String section, String content, String isHaveAccessory){
		this.title = title;
		this.people = people;
		this.date = date;
		this.type = type;
		this.section = section;
		this.content = content;
		this.isHaveAccessory = isHaveAccessory;
	}
}
