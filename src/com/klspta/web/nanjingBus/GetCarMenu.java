package com.klspta.web.nanjingBus;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;

public class GetCarMenu extends AbstractBaseBean{
	public void getBusList(){
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> map1 = new HashMap<String,Object>();
		
		//长途东站
		map1.put("busCard","苏A929R28");
		map1.put("location", "118.828008,32.089514");
		map1.put("status", "停运");
		map1.put("towards", "0");
		
		//中华门
Map<String,Object> map2 = new HashMap<String,Object>();
		
		map2.put("busCard","苏A77G58R");
		map2.put("location", "118.78303,32.013223");
		map2.put("status", "停运");
		map2.put("towards", "2");
		
		//镇淮桥
Map<String,Object> map3 = new HashMap<String,Object>();
		
		map3.put("busCard","苏A685E33");
		map3.put("location", "118.788901,32.019817");
		map3.put("status", "在运行");
		map3.put("towards", "7");
		
		//新街口东
Map<String,Object> map4 = new HashMap<String,Object>();
		
		map4.put("busCard","苏A369C85");
		map4.put("location", "118.794578,32.047749");
		map4.put("status", "在运行");
		map4.put("towards", "0");
		
		//鸡鸣寺南
Map<String,Object> map5 = new HashMap<String,Object>();
		
		map5.put("busCard","苏A9K53D5");
		map5.put("location", "118.80419,32.061926");
		map5.put("status", "在运行");
		map5.put("towards", "4");
		
		//国博
Map<String,Object> map6 = new HashMap<String,Object>();
		
		map6.put("busCard","苏A37H8D5");
		map6.put("location", "118.817233,32.08134");
		map6.put("status", "在运行");
		map6.put("towards", "3");

		
		
		
		list.add(map1);
		list.add(map2);
		list.add(map3);
		list.add(map4);
		list.add(map5);
		list.add(map6);
		
		
		response(list);
	}
	
		
	
	
}
