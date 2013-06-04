package com.klspta.model.wyrw;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.rmi.server.UID;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.wkt.Point;
import com.klspta.base.wkt.Polygon;
import com.klspta.base.wkt.Ring;
import com.scand.fileupload.ProgressMonitorFileItemFactory;

/**
 * 
 * <br>Title:pad成果回传
 * <br>Description:
 * <br>Author:陈强峰
 * <br>Date:2012-7-2
 */
@Component
public class ResultImp extends AbstractBaseBean {
    /**
     * 临时位置
     */
    private String tempPath;

    public ResultImp() {
        tempPath = getTemp();
    }

    //获取任务
    public void getTask() {
        List allList = new ArrayList();
        LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
        map.put("任务编号", "21");
        map.put("信访类型", "32");
        map.put("信访日期", "43");
        map.put("反映问题类型", "问题");
        map.put("问题的详细类型", "类型");
        map.put("反映问题摘要", "问题摘要");
        allList.add(map);
        map = new LinkedHashMap<String, Object>();
        map.put("任务编号", "21");
        map.put("信访类型", "32");
        map.put("信访日期", "43");
        map.put("反映问题类型", "问题");
        map.put("问题的详细类型", "类型");
        map.put("反映问题摘要", "问题摘要");
        allList.add(map);
        StringBuffer bf = new StringBuffer();
        try {
            bf = new StringBuffer(UtilFactory.getJSONUtil().objectToJSON(allList));
        } catch (Exception e) {
            e.printStackTrace();
        }
        response(bf.toString());
    }

    /**
     * 
     * <br>Description:成果数据保存
     * <br>Author:陈强峰
     * <br>Date:2012-7-2
     */
    public void saveData() {
        String zipPath = tempFile();
        if (zipPath != null) {
            File zipFile = new File(zipPath);
            String folderpath = tempPath + zipFile.getName().substring(0, zipFile.getName().length() - 4);
            //解压缩
            UtilFactory.getZIPUtil().unZip(zipPath, folderpath);
            //json信息读取
            int count = importData(folderpath + "//exp");
            //上传附件
            importAccessoryField(folderpath + "//exp");
            response("{success:true,msg:" + count + "}");
        } else {
            response("{success:false}");
        }
    }

    /**
     * 
     * <br>Description:临时文件
     * <br>Author:陈强峰
     * <br>Date:2012-7-4
     * @return
     */
    private String tempFile() {
        try {
            boolean ismulti = FileUpload.isMultipartContent(request);
            if (!ismulti) {
            } else {
                //取得临时文件夹
                String uploadFolder = tempPath;
                String file_id = new UID().toString().replaceAll(":", "-");
                String fileSuffix;
                String fileFullPath;
                //String fileId = request.getParameter("sessionId").toString().trim();
                //创建上传句柄
                FileItemFactory factory = new ProgressMonitorFileItemFactory(request, "");
                ServletFileUpload upload = new ServletFileUpload(factory);
                upload.setHeaderEncoding("utf-8");
                List items = upload.parseRequest(request);
                //处理上传文件
                Iterator iter = items.iterator();
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.isFormField()) {
                    } else {
                        String fileName = item.getName();
                        fileSuffix = fileName.substring(fileName.lastIndexOf(".")); //获取文件后缀
                        int i2 = fileName.lastIndexOf("\\");
                        if (i2 > -1)
                            fileName = fileName.substring(i2 + 1);
                        File dirs = new File(uploadFolder);
                        if (!dirs.isFile()) {
                            dirs.mkdirs();
                        }
                        int flag = fileName.lastIndexOf(".");
                        String temp = fileName.replaceFirst(fileName, file_id);
                        if (flag >= 0) {
                            temp = fileName.replaceFirst(fileName.substring(0, fileName.lastIndexOf(".")),
                                    file_id);
                        }
                        temp = file_id + fileSuffix; //转换上传的文件名称
                        File uploadedFile = new File(dirs, temp);
                        item.write(uploadedFile);
                        fileFullPath = uploadFolder + temp;
                        return fileFullPath;
                    }
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }

    /**
     * 
     * <br>
     * Description:获取临时路径 <br>
     * Author:陈强峰 <br>
     * Date:2012-2-24
     * 
     * @return
     */
    private String getTemp() {
        String temppath = "";
        temppath = UtilFactory.getConfigUtil().getShapefileTempPathFloder();
        return temppath;
    }

    /**
     * 
     * <br>Description:巡查日志保存
     * <br>Author:陈强峰
     * <br>Date:2012-9-24
     * @param path
     */
    private void xcrzImport(String path) {
        InputStreamReader read = null;
        BufferedReader reader = null;
        try {
            read = new InputStreamReader(new FileInputStream(path), "UTF-8");
            reader = new BufferedReader(read);
            String jsonText = null;
            while ((jsonText = reader.readLine()) != null) {
                JSONArray jsonArray = UtilFactory.getJSONUtil().jsonToObjects(
                        jsonText.substring(jsonText.indexOf('[')));
                for (int m = 0; m < jsonArray.size(); m++) {
                    JSONObject obj = jsonArray.getJSONObject(m);
                    System.out.println("巡查日志：" + obj);
                    //入库操作   先删除  (数据删除   附件删除？)
                    String yw_guid = obj.get("YW_GUID").toString();
                    String gtzyj = obj.get("GTZYJ").toString();
                    String gtzys = obj.get("GTZYS").toString();
                    String xcsj = obj.get("XCSJ").toString();
                    String xcqy = obj.get("XCQY").toString();
                    String djr = obj.get("DJR").toString();
                    String cjry = obj.get("CJRY").toString();
                    String xcqk = obj.get("XCQK").toString();
                    xcqk = xcqk.replace("#", "\n   ");
                    //String xcqk = "";
                    String clyj = obj.get("CLYJ").toString();
                    String xcdw = gtzyj + gtzys;
                    String sqlhas = "select x.gtzys from PAD_XCRZ x  where yw_guid=?";
                    List<Map<String, Object>> list = query(sqlhas, YW, new Object[] { yw_guid });
                    String sql = "";
                    Object[] objs = null;
                    if (list.size() > 0) {
                        sql = "update PAD_XCRZ x set XSH=?, XCDW=?,GTZYJ=?,XCQY=?,DJR=?,CJRY=?,XCQK=?,CLYJ=?,GTZYS=?,XCSJ=to_date(?,'yyyy-mm-dd') where yw_guid=?";
                        objs = new Object[] { yw_guid, xcdw, gtzyj, xcqy, djr, cjry, xcqk, clyj, gtzys, xcsj,
                                yw_guid };
                    } else {
                        sql = "insert into PAD_XCRZ(XSH,XCDW,GTZYS,XCSJ,GTZYJ,XCQY,DJR,CJRY,XCQK,CLYJ,YW_GUID) values(?,?,?,to_date(?,'yyyy-mm-dd'),?,?,?,?,?,?,?)";
                        objs = new Object[] { yw_guid, xcdw, gtzys, xcsj, gtzyj, xcqy, djr, cjry, xcqk, clyj,
                                yw_guid };
                    }
                    update(sql, YW, objs);
                }
            }
        } catch (DataAccessException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (reader != null) {
                    reader.close();
                }
                if (read != null) {
                    read.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 
     * <br>Description:文本信息入库 附件上传
     * <br>Author:陈强峰
     * <br>Date:2012-7-4
     * @param path
     */
    private int importData(String path) {
        int count = 0;
        File f = new File(path);
        File[] files = f.listFiles();
        for (int i = 0; i < files.length; i++) {
            File file = new File(files[i].getAbsolutePath());
            if (file.getName().endsWith("xcrz.txt")) {
                xcrzImport(file.getAbsolutePath());
                continue;
            }
            File[] childList = file.listFiles();
            for (int j = 0; j < childList.length; j++) {
                String str = childList[j].getAbsolutePath();
                if (str.toLowerCase().endsWith("txt")) {
                    InputStreamReader read = null;
                    BufferedReader reader = null;
                    try {
                        read = new InputStreamReader(new FileInputStream(str), "UTF-8");
                        reader = new BufferedReader(read);
                        String jsonText = null;
                        while ((jsonText = reader.readLine()) != null) {
                            JSONArray jsonArray = UtilFactory.getJSONUtil().jsonToObjects(
                                    jsonText.substring(jsonText.indexOf('[')));
                            for (int m = 0; m < jsonArray.size(); m++) {
                                JSONObject obj = jsonArray.getJSONObject(m);
                                System.out.println("数据：" + obj);
                                String yw_guid = obj.get("YW_GUID").toString();
                                String xcx = obj.get("XCX").toString();
                                String xcs = obj.get("XCS").toString();
                                String xcsj = obj.get("XCSJ").toString();
                                String xcdd = obj.get("XCDD").toString();
                                String jsdw = obj.get("JSDW").toString();
                                String jsxm = obj.get("JSXM").toString();
                                String jsqk = obj.get("JSQK").toString();
                                String pzwh = obj.get("PZWH").toString();
                                String gdwh = obj.get("GDWH").toString();
                                String tdzbh = obj.get("TDZBH").toString();
                                String sjclyj = obj.get("SJCLYJ").toString();
                                String sjbz = obj.get("SJBZ").toString();
                                String usetype = obj.get("USETYPE").toString();
                                String kczbh = obj.get("KCZBH").toString();
                                String cjzb = obj.get("CJZB").toString();
                                String jwzb = obj.get("JWZB").toString();
                                String cjmj = obj.get("ZMJ").toString();
                                String kcdd = obj.get("KCDD").toString();
                                String kcdw = obj.get("KCDW").toString();
                                String kckz = obj.get("KCKZ").toString();
                                String kcqk = obj.get("KCQK").toString();
                                //String cjmj = obj.get("CJMJ").toString();
                                //...wf
                                String nyd = obj.get("NYD").toString();
                                String gd = obj.get("GD").toString();
                                String jsyd = obj.get("JSYD").toString();
                                String wlyd = obj.get("WLYD").toString();
                                String xzjsyd = obj.get("XZJSYD").toString();
                                String xjsyd = obj.get("XJSYD").toString();
                                String ytjjsq = obj.get("YTJJSQ").toString();
                                String xzjsq = obj.get("XZJSQ").toString();
                                String jzjsq = obj.get("JZJSQ").toString();
                                String zyjbnt = obj.get("ZYJBNT").toString();
                                String zmj = obj.get("ZMJ").toString();
                                String location = obj.get("LOCATION").toString();
                                //...

                                String sqlhas = "select yw_guid from PAD_XCXCQKB where yw_guid=?";
                                List<Map<String, Object>> list = query(sqlhas, YW, new Object[] { yw_guid });
                                String sql = "";
                                Object[] objs = null;
                                if (list.size() > 0) {
                                    sql = "update PAD_XCXCQKB set USETYPE=?,KCZBH=?,CJMJ=?,XCX=?,XCS=?,XCSJ=?,XCDD=?,JSDW=?,JSXM=?,JSQK=?,PZWH=?,GDWH=?,TDZBH=?,SJCLYJ=?,JWZB=?,CJZB=?,SJBZ=?,KCDD=?,KCDW=?, KCKZ=?, KCQK=?, XZJSYD=? , XJSYD=? , YTJJSQ=? , XZJSQ=? , JZJSQ=? , ZYJBNT=? , ZMJ=? , NYD=? , GD=? , JSYD=? , WLYD=?  where YW_GUID=?";
                                    delAcc(yw_guid);
                                    objs = new Object[] { usetype, kczbh, cjmj, xcx, xcs, xcsj, xcdd, jsdw,
                                            jsxm, jsqk, pzwh, gdwh, tdzbh, sjclyj, jwzb, cjzb, sjbz, kcdd,
                                            kcdw, kckz, kcqk, xzjsyd, xjsyd, ytjjsq, xzjsq, jzjsq, zyjbnt,
                                            zmj,nyd,gd,jsyd,wlyd,yw_guid };
                                } else {
                                    sql = "insert into PAD_XCXCQKB(YW_GUID,CJMJ,XCX,XCS,XCSJ,XCDD,JSDW,JSXM,JSQK,PZWH,GDWH,TDZBH,SJCLYJ,JWZB,CJZB,SJBZ,USETYPE,KCZBH,KCDD,KCKZ,KCDW,KCQK,XZJSYD,XJSYD,YTJJSQ,XZJSQ,JZJSQ,ZYJBNT,ZMJ,NYD,GD,JSYD,WLYD) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                                    objs = new Object[] { yw_guid, cjmj, xcx, xcs, xcsj, xcdd, jsdw, jsxm,
                                            jsqk, pzwh, gdwh, tdzbh, sjclyj, jwzb, cjzb, sjbz, usetype,
                                            kczbh, kcdd, kckz, kcdw, kcqk, xzjsyd, xjsyd, ytjjsq, xzjsq,
                                            jzjsq, zyjbnt, zmj,nyd,gd,jsyd,wlyd};
                                }
                                count += update(sql, YW, objs);
                                //上图操作
                                // savePolygon(cjzb,yw_guid);
                                //保存图层属性
                                // saveProperties(yw_guid);

                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (reader != null) {
                                reader.close();
                            }
                            if (read != null) {
                                read.close();
                            }
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        return count;
    }

    /**
     * 
     * <br>Description:根据回传的类型  修改案件管理中的相应信息状态
     * <br>Author:陈强峰
     * <br>Date:2012-8-17
     * @param rwlx
     * @param guid
     */
    private void changeYwStatus(String rwlx, String guid) {
        String sql = "";
        if (rwlx.equals("立案查处")) {
            sql = "update lacpb l set l.checked='2' where YW_GUID=?";
            update(sql, YW, new Object[] { guid });
        } else {
            if (rwlx.equals("卫片")) {
                sql = "update wpzf_tb t set  t.ajstatus=? where t.tbbh=?";
            } else if (rwlx.equals("信访")) {
                sql = "update wfxsdjbl t set t.ajstatus=? where t.xsh=?";
            }
            if (sql.length() > 0) {
                update(sql, YW, new Object[] { "6", guid });
            }
        }
    }

    /**
     * 
     * <br>Description:删除附件信息
     * <br>Author:陈强峰
     * <br>Date:2012-7-29
     * @param rwbh
     */
    private void delAcc(String rwbh) {
        String sql = "select file_id,file_path from atta_accessory where yw_guid=? ";
        List<Map<String, Object>> list = query(sql, CORE, new Object[] { rwbh });
        for (int i = 0; i < list.size(); i++) {
            String ftpFileName = list.get(i).get("file_path").toString();
            String fileId = list.get(i).get("file_id").toString();
            boolean delFlag = UtilFactory.getFtpUtil().deleteFile(ftpFileName);
            // if (delFlag) {
            sql = "delete from atta_accessory where file_id=?";
            update(sql, CORE, new Object[] { fileId });
            // }
        }
    }

    /**
     * 
     * <br>Description:遍历任务文件夹
     * <br>Author:陈强峰
     * <br>Date:2012-7-4
     * @param path
     */
    private void importAccessoryField(String path) {
        File f = new File(path);
        File[] files = f.listFiles();
        for (int i = 0; i < files.length; i++) {
            if (files[i].getAbsolutePath().endsWith(".txt")) {
                continue;
            }
            accUpload(files[i]);
        }
    }

    /**
     * 
     * <br>Description:根据文件夹名上传相应文件夹下的附件
     * <br>Author:陈强峰
     * <br>Date:2012-7-4
     * @param file
     */
    private void accUpload(File file) {
        File[] files = file.listFiles();
        String ywguid = file.getName();
        for (int i = 0; i < files.length; i++) {
            if (files[i].getAbsolutePath().endsWith(".txt")) {
                continue;
            }
            dealAcc(files[i], ywguid);
        }
        String yw_guid = file.getName();
        String sql = "select file_id,file_name from atta_accessory where yw_guid=?";
        List<Map<String, Object>> list = query(sql, CORE, new Object[] { yw_guid });
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = list.get(i);
            if (map.get("file_name").toString().endsWith("jpg")) {
                if (i == list.size() - 1) {
                    sb.append(map.get("file_id"));
                } else {
                    sb.append(map.get("file_id")).append(",");
                }
            }
        }
        //sql = "update wy_device_data set imgname=? where guid=?";
        sql = "update PAD_XCXCQKB set ZPBH=? where yw_guid=?";
        update(sql, YW, new Object[] { sb.toString(), yw_guid });
    }

    /**
     * 
     * <br>Description:处理附件名等参数
     * <br>Author:陈强峰
     * <br>Date:2012-7-4
     * @param file
     */
    private void dealAcc(File file, String ywguid) {
        String filename = file.getName();
        String fileSuffix = filename.substring(filename.lastIndexOf("."));
        String file_id = new UID().toString().replaceAll(":", "-");
        String newFilePath = file_id + fileSuffix;
        File newFile = new File(newFilePath);
        file.renameTo(newFile);
        if (UtilFactory.getFtpUtil().uploadFile(newFilePath)) {
            String sql = "insert into atta_accessory(file_id,file_type,file_name,file_path,yw_guid) values(?,?,?,?,?)";
            update(sql, CORE, new Object[] { file_id, "file", filename, newFilePath, ywguid });
        }
    }

    /**
     * 
     * <br>Description:上图操作
     * <br>Author:王雷
     * <br>Date:2012-10-18
     * @param file
     */
    public void savePolygon(String cjzb, String yw_guid) {
        String wkt = "";
        String[] allPoint = cjzb.split(",");
        Polygon polygon = new Polygon();
        Ring ring = new Ring();
        if (allPoint.length > 2) {
            for (int i = 0; i < allPoint.length; i += 2) {
                double x = Double.parseDouble(allPoint[i]);
                double y = Double.parseDouble(allPoint[i + 1]);
                Point p = new Point(x, y);
                ring.putPoint(p);
            }
            Point p2 = new Point(Double.parseDouble(allPoint[0]), Double.parseDouble(allPoint[1]));
            ring.putPoint(p2);
            polygon.addRing(ring);
            wkt = polygon.toWKT();
        }

        String querySrid = "select t.srid from sde.st_geometry_columns t where t.table_name = 'WYXCHC'";
        String srid = null;
        List<Map<String, Object>> rs = query(querySrid, GIS);
        try {
            if (rs.size() > 0) {
                srid = rs.get(0).get("srid") + "";
            }
            String sql = "INSERT INTO WYXCHC(OBJECTID,yw_guid,SHAPE) VALUES ((select nvl(max(OBJECTID)+1,1) from WYXCHC),'"
                    + yw_guid + "',sde.st_geometry ('" + wkt + "', " + srid + "))";
            String selSql = "select * from WYXCHC where yw_guid='" + yw_guid + "'";
            List<Map<String, Object>> rs1 = query(selSql, GIS);
            if (rs1.size() > 0) {
                sql = "update WYXCHC set shape=sde.st_geometry ('" + wkt + "', " + srid + ") where yw_guid='"
                        + yw_guid + "'";
            }
            update(sql, GIS);

        } catch (Exception e) {
            System.out.println("采集坐标出错");
            //e.printStackTrace();
        }

    }

    /**
     * 
     * <br>Description:保存图层属性
     * <br>Author:王雷
     * <br>Date:2012-10-18
     * @param file
     */
    public void saveProperties(String yw_guid) {
        String sql1 = "select t.JSXM,t.JSDW,t.XCDD,t.CJMJ,t.JSQK,t.XCX||t.XCS XCR,t.XCSJ from XCXCQKB t where yw_guid='"
                + yw_guid + "'";
        List<Map<String, Object>> list = query(sql1, YW);
        if (list.size() > 0) {
            Map<String, Object> map = (Map<String, Object>) list.get(0);
            String sql2 = "update wyxchc set yw_xmmc=?,yw_dwmc=?,yw_tdwz=?,yw_sjzdmj=?,yw_xcqkms=?,yw_xcr=?,yw_xcsj=to_date(?,'rrrr-mm-dd') where yw_guid='"
                    + yw_guid + "'";
            String cjmj = (String) map.get("CJMJ");
            if (cjmj != null && !"null".equals(cjmj)) {
                cjmj = cjmj.substring(0, cjmj.length() - 2);
            }
            update(sql2, GIS, new Object[] { map.get("JSXM"), map.get("JSDW"), map.get("XCDD"), cjmj,
                    map.get("JSQK"), map.get("XCR"), map.get("XCSJ") });
        }
    }

}
