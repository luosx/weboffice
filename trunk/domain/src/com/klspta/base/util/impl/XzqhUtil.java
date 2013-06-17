package com.klspta.base.util.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.klspta.base.util.api.IXzqhUtil;
import com.klspta.base.util.bean.xzqhutil.XzqhBean;

public class XzqhUtil implements IXzqhUtil {
	
	private static Vector<XzqhBean> xzqhList = new Vector<XzqhBean>();
	private static XzqhUtil instance;
	
    public static IXzqhUtil getInstance(String key) throws Exception {
        if (!key.equals("NEW WITH UTIL FACTORY!")) {
            throw new Exception("请通过UtilFactory获取实例.");
        }
        if (instance == null) {
            instance = new XzqhUtil();
        }
        return instance;
    }
	
	
	
	@Override
	public boolean deleteByCantonCode(String cantonCode) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<XzqhBean> getChildListById(String code) {
		List<XzqhBean> childList = new ArrayList<XzqhBean>();
		XzqhBean choseBean;
		for(int i = 0; i < xzqhList.size(); i++){
			choseBean = xzqhList.get(i);
			if(choseBean.getParentcode() == null)
				continue;
			if(choseBean.getParentcode().equals(code)){
				childList.add(choseBean);
			}
		}
		return childList;
	}

	@Override
	public XzqhBean getBeanById(String id) {
		List<XzqhBean> choseBean = new ArrayList<XzqhBean>();
		for(int i = 0; i < xzqhList.size(); i++){
			if(xzqhList.get(i).getCatoncode().equals(id)){
				return xzqhList.get(i);
			}
		}
		return null;
	}

	@Override
	public List<XzqhBean> getProvinceList() {
		List<XzqhBean> proviceList = new ArrayList<XzqhBean>();
		XzqhBean choseBean;
		for(int i = 0; i < xzqhList.size(); i++){
			choseBean = xzqhList.get(i);
			if(choseBean.getParentcode() == null)
				continue;
			if(choseBean.getParentcode().equals("0")){
				proviceList.add(choseBean);
			}
		}
		
		return proviceList;
	}

	@Override
	public boolean save(XzqhBean xzqh) {
		// TODO Auto-generated method stub
		return false;
	}

}
