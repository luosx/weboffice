package com.klspta.base.util.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.Vector;
import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.api.IXzqhUtil;
import com.klspta.base.util.bean.xzqhutil.XzqhBean;

public class XzqhUtil extends AbstractBaseBean implements IXzqhUtil {

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

    /**
     * 
     * <br>Description:获取数据库中的所有数据。
     * <br>Author:黎春行
     * <br>Date:2012-5-24
     */
    private XzqhUtil() {
        String sql = "select t.* from  CODE_XZQH t order by qt_ctn_code asc";
        List<Map<String, Object>> rs = query(sql, CORE);
        for (int i = 0; i < rs.size(); i++) {
            XzqhBean oneBean = new XzqhBean();
            Map<String, Object> oneMap = rs.get(i);
            oneBean.setCatoncode(String.valueOf(oneMap.get("qt_ctn_code")));
            oneBean.setCatonname(String.valueOf(oneMap.get("na_ctn_name")));
            oneBean.setCatonsimpleName(String.valueOf(oneMap.get("na_ctn_abb")));
            oneBean.setFullname(String.valueOf(oneMap.get("na_full_name")));
            oneBean.setGovname(String.valueOf(oneMap.get("na_gov_name")));
            oneBean.setLandname(String.valueOf(oneMap.get("na_landdp_name")));
            oneBean.setParentcode(String.valueOf(oneMap.get("qt_parent_code")));
            oneBean.setStateflag(String.valueOf(oneMap.get("qt_state_flag")));
            oneBean.setPostalcode(String.valueOf(oneMap.get("qt_postal_code")));
            xzqhList.add(oneBean);
        }
    }

    @Override
    public boolean deleteByCantonCode(String cantonCode) {
        return false;
    }

    @Override
    public String generateOptionByList() {
        return generateOptionByList(getProvinceList());
    }

    @Override
    public String generateOptionByList(List<XzqhBean> list) {
        XzqhBean choseBean;
        String msgString = "";
        Vector<Map<String, String>> province = new Vector<Map<String, String>>();

        for (int i = 0; i < list.size(); i++) {
            choseBean = list.get(i);
            Map<String, String> formatMap = new TreeMap<String, String>();
            formatMap.clear();
            formatMap.put("code", choseBean.getCatoncode());
            formatMap.put("name", choseBean.getCatonname());
            province.add(formatMap);
        }

        try {
            msgString = UtilFactory.getJSONUtil().objectToJSON(province);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return msgString;
    }

    @Override
    public List<XzqhBean> getChildListByParentId(String canton_code) {
        List<XzqhBean> childList = new ArrayList<XzqhBean>();
        XzqhBean choseBean;
        for (int i = 0; i < xzqhList.size(); i++) {
            choseBean = xzqhList.get(i);
            if (choseBean.getParentcode() == null)
                continue;
            if (choseBean.getParentcode().equals(canton_code)) {
                childList.add(choseBean);
            }
        }
        return childList;
    }

    @Override
    public List<XzqhBean> getProvinceList() {
        List<XzqhBean> proviceList = new ArrayList<XzqhBean>();
        XzqhBean choseBean;
        for (int i = 0; i < xzqhList.size(); i++) {
            choseBean = xzqhList.get(i);
            if (choseBean.getParentcode() == null)
                continue;
            if (choseBean.getParentcode().equals("0")) {
                proviceList.add(choseBean);
            }
        }

        return proviceList;
    }

    @Override
    public boolean save(XzqhBean xzqh) {
        boolean flag = false;
        String xzqcode = xzqh.getCatoncode();
        XzqhBean choseBean;
        for (int i = 0; i < xzqhList.size(); i++) {
            choseBean = xzqhList.get(i);
            if (choseBean.getCatoncode().equals(xzqcode)) {//说明内存中存在这个行政区划，要更新数据，并刷新内存
                String sql = "update code_xzqh t set t.NA_CTN_NAME = ?, t.NA_CTN_ABB = ?, t.NA_GOV_NAME = ?, t.NA_LANDDP_NAME = ?, t.QT_PARENT_CODE = ?, t.QT_STATE_FLAG = ?, t.NA_FULL_NAME = ?, t.QT_POSTAL_CODE = ? where t.QT_CTN_CODE = ?";
                int t = update(sql, CORE, new Object[] { xzqh.getCatonname(), xzqh.getCatonsimpleName(),
                        xzqh.getGovname(), xzqh.getLandname(), Double.valueOf(xzqh.getParentcode()),
                        Integer.valueOf(xzqh.getStateflag()), xzqh.getFullname(), xzqh.getPostalcode(),
                        Double.valueOf(xzqh.getCatoncode()) });
                xzqhList.set(i, xzqh);//刷新内存
                if (t == 1) {
                    flag = true;
                }
            }
        }
        if (flag == false) {//说明内存中不存在这个行政区划，要插入数据，并刷新内存
            String sql = "insert into code_xzqh values(?,?,?,?,?,?,?,?,?)";
            int t = update(sql, CORE, new Object[] { Double.valueOf(xzqh.getCatoncode()),
                    xzqh.getCatonname(), xzqh.getCatonsimpleName(), xzqh.getGovname(), xzqh.getLandname(),
                    Double.valueOf(xzqh.getParentcode()), Integer.valueOf(xzqh.getStateflag()),
                    xzqh.getFullname(), xzqh.getPostalcode() });
            xzqhList.add(xzqh);//刷新内存
            if (t == 1) {
                flag = true;
            }
        }
        return flag;
    }

    @Override
    public List<XzqhBean> getNameById(String id) {
        List<XzqhBean> choseBean = new ArrayList<XzqhBean>();
        for (int i = 0; i < xzqhList.size(); i++) {
            if (xzqhList.get(i).getCatoncode().equals(id)) {
                choseBean.add(xzqhList.get(i));
                return choseBean;
            }
        }
        return null;
    }

    @Override
    public List<XzqhBean> getParentByChildId(String code) {
        List<XzqhBean> choseBean = new ArrayList<XzqhBean>();
        String parentCode = "";
        for (int i = 0; i < xzqhList.size(); i++) {
            if (xzqhList.get(i).getCatoncode().equals(code)) {
                parentCode = xzqhList.get(i).getParentcode();
            }
        }
        choseBean = getNameById(parentCode);
        return choseBean;
    }

    @Override
    public String getNameByCode(String code) {
        String result = null;
        for (int i = 0; i < xzqhList.size(); i++) {
            if (xzqhList.get(i).getCatoncode().equals(code)) {
                result = xzqhList.get(i).getCatonname();
                return result;
            }
        }
        return result;
    }

    @Override
    public XzqhBean getBeanById(String id) {
        XzqhBean xzqhbean = null;
        XzqhBean choseBean;
        for (int i = 0; i < xzqhList.size(); i++) {
            choseBean = xzqhList.get(i);
            if (choseBean.getParentcode() == null)
                continue;
            if (choseBean.getCatoncode().equals(id)) {
                xzqhbean = choseBean;
                break;
            }
        }
        return xzqhbean;
    }

    @Override
    public String getPostalCode(String id) {
        XzqhBean xzqhBean = getBeanById(id);
        String postalCode = xzqhBean.getPostalcode();
        if (postalCode == null) {
            return null;
        }
        return UtilFactory.getJSONUtil().format(postalCode);
    }

    @Override
    public List<XzqhBean> getListByName(String[] name) {
        List<XzqhBean> childList = new ArrayList<XzqhBean>();
        for (int j = 0; j < name.length; j++) {
            for (int i = 0; i < xzqhList.size(); i++) {
                if (xzqhList.get(i).getCatonname().contains(name[j])) {
                    childList.add(xzqhList.get(i));
                }
            }
        }
        return childList;
    }

    /**
     * Title: <br>
     * Description:根据行政区划代码set集合返回可以在ext的ComboBox中直接展现的数据<br>
     * Author:姚建林 <br>
     * Date:2012-9-19
     */
    @Override
    public String getXzqhDataByCodes(HashSet<String> hs) {
        //返回的数据
        String XzqhData = "";
        //迭代器
        Iterator<String> it = hs.iterator();
        Vector<Map<String, String>> province = new Vector<Map<String, String>>();
        //用于存储行政区划编码
        String temp = "";
        while (it.hasNext()) {
            Map<String, String> formatMap = new TreeMap<String, String>();
            temp = it.next();
            formatMap.put("code", temp);
            formatMap.put("name", getNameByCode(temp));
            province.add(formatMap);
        }
        try {
            XzqhData = UtilFactory.getJSONUtil().objectToJSON(province);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return XzqhData;
    }

    @Override
    public String getXzqhNamesByCodes(HashSet<String> hs) {
        String XzqhData = "";
        //迭代器
        Iterator<String> it = hs.iterator();
        String temp = "";
        boolean flag = false;
        while (it.hasNext()) {
            temp = it.next();
            if (temp.equals("370100")) {
                flag = true;
                break;
            }
            XzqhData += getNameByCode(temp) + ",";
        }
        if (flag) {
            XzqhData = "";
            List<XzqhBean> arr = getChildListByParentId("370100");
            for (XzqhBean xzqhBean : arr) {
                XzqhData += xzqhBean.getCatonname() + ",";
            }
        }
        return XzqhData;
    }

    @Override
    public String getPublicCode(String id) {
        String sql = "select t.child_name,t.child_id from PUBLIC_CODE t where t.id='" + id
                + "' and t.in_flag=1 order by t.child_id";
        List<Map<String, Object>> rows = query(sql, YW);
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < rows.size(); i++) {
            Map<String, Object> map = (Map<String, Object>) rows.get(i);
            sb.append("{text:'" + map.get("child_name") + "',value:'" + map.get("child_id") + "'}");
            if ((i + 1) < rows.size()) {
                sb.append(",");
            }
        }
        return sb.toString();
    }

}
