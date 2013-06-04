package com.klspta.model.impText;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.servlet.ServletRequestContext;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.wkt.Polygon;

public class ParseText extends AbstractBaseBean {
    /**
     * 
     * <br>Description:解析文本坐标定位
     * <br>Author:陈强峰
     * <br>Date:2012-8-17
     */
    public void parseText() {
        BufferedReader reader = null;
        File file = null;
        try {
            String filePath = uploadFileToTempFloder();
            file = new File(filePath);
            reader = new BufferedReader(new FileReader(file));
            String text = null;
            List<String> list = new ArrayList<String>();
            while ((text = reader.readLine()) != null) {
                list.add(text);
            }
            String sql = "select t.*, t.rowid from gis_extent t where t.flag = '1'";
            List<Map<String, Object>> mapConfigList = query(sql, CORE);
            int wkid = ((BigDecimal)(mapConfigList.get(0).get("wkid"))).intValue();
            Polygon polygon = new Polygon(list,wkid,true);
            String str = polygon.toJson();
            response.getWriter().write("{success:true,msg:'" + str + "'}");
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (reader != null) {
                    reader.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            file.delete();
        }

    }

    private String uploadFileToTempFloder() {
        String filepath = "";
        UtilFactory.getConfigUtil().getShapefileTempPathFloder();
        try {
            ServletRequestContext ctx = new ServletRequestContext(request);
            boolean isMultiPart = FileUpload.isMultipartContent(ctx);// 必须是multi的表单模式才行
            if (isMultiPart) {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                factory.setSizeThreshold(10000 * 1024); // 设置保存到内存中的大小：10M
                ServletFileUpload upload = new ServletFileUpload(factory);
                upload.setSizeMax(1024 * 1024 * 1024);// 设置最大上传文件的大小1GB
                List<?> items = upload.parseRequest(ctx);// 解析请求里的上传文件单元
                if (items != null && items.size() > 0) {
                    Iterator<?> it = items.iterator();
                    while (it.hasNext()) {
                        FileItem item = (FileItem) it.next();
                        boolean isForm = item.isFormField();// 是否是表单域
                        if (!isForm) {// 如果不适表单域，则是文件上传
                            String fileName = item.getName();// 获取上传的文件名
                            if (!fileName.equals("")) {
                                if (!(fileName.toLowerCase()).endsWith("txt")) {
                                    return "";
                                }
                                File shpfile = new File(UtilFactory.getConfigUtil()
                                        .getShapefileTempPathFloder()
                                        + System.currentTimeMillis() + ".txt");
                                item.write(shpfile);// 上传文件
                                filepath = shpfile.getPath();
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return filepath;
    }

}
