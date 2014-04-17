package com.klspta.console.flex;

import java.io.IOException;
import java.io.StringWriter;

import org.dom4j.Document;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;

import com.klspta.base.AbstractBaseBean;
import com.klspta.console.ManagerFactory;

/**
 * 
 * <br>Title:Flex相关调用人口
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2014-4-17
 */
public class FlexAction extends AbstractBaseBean {

    /**
     * 
     * <br>Description:保存角色授权图层
     * <br>Author:陈强峰
     * <br>Date:2014-4-16
     */
    public void saveLayerRoleMap() {
        String roleId = request.getParameter("roleId");
        String treeIdList = request.getParameter("layerList");
        int count = 0;
        try {
            count = ManagerFactory.getFlexManage().saveLayerRoleMap(roleId, treeIdList);
            if (count > 0 || treeIdList.length() == 0) {
                response("success");
                return;
            }
        } catch (Exception e) {
        }
        response("failure");
    }

    /**
     * 
     * <br>Description:保存角色授权组件
     * <br>Author:陈强峰
     * <br>Date:2014-4-16
     */
    public void saveWidgetRoleMap() {
        String roleId = request.getParameter("roleId");
        String treeIdList = request.getParameter("widgetList");
        int count = 0;
        try {
            count = ManagerFactory.getFlexManage().saveWidgetRoleMap(roleId, treeIdList);
            if (count > 0 || treeIdList.length() == 0) {
                response("success");
                return;
            }
        } catch (Exception e) {
        }
        response("failure");
    }

    /**
     * 
     * <br>Description:获取角色授权组件树
     * <br>Author:陈强峰
     * <br>Date:2014-4-16
     */
    public void getWidgetCheckTreeByRoleId() {
        String roleId = request.getParameter("roleId");
        try {
            response(ManagerFactory.getFlexManage().getWidgetCheckTreeByRoleId(roleId));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 
     * <br>Description:获取角色授权图层树
     * <br>Author:陈强峰
     * <br>Date:2014-4-16
     */
    public void getLayerCheckTreeByRoleId() {
        String roleId = request.getParameter("roleId");
        try {
            response(ManagerFactory.getFlexManage().getLayerCheckTreeByRoleId(roleId));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 
     * <br>Description:获取角色xml信息
     * <br>Author:陈强峰
     * <br>Date:2014-4-16
     */
    public void getXmlString() {
        String roleId = request.getParameter("roleId");
        XMLWriter xmlWriter = null;
        StringWriter out = null;
        String xml = "";
        try {
            Document document = ManagerFactory.getFlexManage().getRoleXMLDom(roleId);
            out = new StringWriter(1024);
            OutputFormat format = OutputFormat.createPrettyPrint();
            format.setEncoding("UTF-8");
            xmlWriter = new XMLWriter(out, format);
            xmlWriter.write(document);
            xml = out.toString();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (xmlWriter != null) {
                try {
                    xmlWriter.close();
                } catch (IOException ex) {

                }
            }
            if (out != null) {
                try {
                    out.close();
                } catch (IOException ex) {

                }
            }
        }
        response(xml);
    }
}
