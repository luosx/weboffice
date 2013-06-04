package com.klspta.model.customQuery;

import java.util.Map;
//查询条件类
public class QueryCondition {
	private String userId; //用户id
	private String statisticsName;//查询的名称
	private String statisticsValue;//查询的字段
	
	public QueryCondition(Map<String,Object> map)
	{
		this.userId=(String)map.get("userId");
		this.statisticsName=(String)map.get("statisticName");
		this.statisticsValue=(String)map.get("statisticValue");
	}
	public QueryCondition(String userId,String statisticsName,String statisticsValue)
	{
		this.userId=userId;
		this.statisticsName=statisticsName;
		this.statisticsValue=statisticsValue;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getStatisticsName() {
		return statisticsName;
	}

	public void setStatisticsName(String statisticsName) {
		this.statisticsName = statisticsName;
	}

	public String getStatisticsValue() {
		return statisticsValue;
	}

	public void setStatisticsValue(String statisticsValue) {
		this.statisticsValue = statisticsValue;
	}
	


}
