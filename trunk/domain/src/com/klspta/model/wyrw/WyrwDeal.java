package com.klspta.model.wyrw;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.rmi.server.UID;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.dao.DataAccessException;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.scand.fileupload.ProgressMonitorFileItemFactory;

/**
 * <br>Description:外业任务获取、下发、导出、导入
 * <br>Author:姚建林
 * <br>Date:2012-8-10
 * @return
 */
public class WyrwDeal extends AbstractBaseBean {
    /**
     * 临时位置
     */
    private String tempPath;

    public WyrwDeal() {
        tempPath = UtilFactory.getConfigUtil().getShapefileTempPathFloder();
    }

    /**
     * Description:手持端获取任务 <br>
     * Author:姚建林 <br>
     * Date:2012-8-10
     * @return
     */
    public void getTaskJson() {
        String sql = "select guid,xmmc,dwmc,rwlx,wfdd,rwms from WY_DEVICE_DATA where ajstatus=0";
        List<Map<String, Object>> list = query(sql, YW);
        response(list);
    }

    /**
     * Description:下发核查任务 <br>
     * Author:姚建林 <br>
     * Date:2012-8-10
     * @return
     */
    public void addWyrw() {
        String flag = request.getParameter("flag");//判断是卫片还是信访举报
        String ids = request.getParameter("ids");//页面传过来的id数组
        int result = 0;
        String sql = "";
        //下发卫片核查任务
        if (flag.equals("wp")) {
            sql = "insert into WY_DEVICE_DATA(GUID,XMMC,DWMC,WFDD,RWMS,XCQKMC) select TBBH,XZQHMC,XZQHMC,XZQHMC,XZQHMC,XZQHMC from WPZF_TB where WPZF_TB.TBBH=?";//业务id，项目名称，单位名称，违法地点，任务描述，现场情况描述
            String[] yw_guid = ids.split(",");
            for (int i = 0; i < yw_guid.length; i++) {
                result = update(sql, YW, new Object[] { yw_guid[0] });
            }
        }
        //下发信访举报核查任务
        if (flag.equals("xfjb")) {
            sql = "insert into WY_DEVICE_DATA(GUID,XMMC,DWMC,WFDD,RWMS,XCQKMC) select YW_GUID,XSH,XSH,XSH,XSH,XSH from wfxsdjbl where wfxsdjbl.YW_GUID=?";//业务id，项目名称，单位名称，违法地点，任务描述，现场情况描述
            String[] yw_guid = ids.split(",");
            for (int i = 0; i < yw_guid.length; i++) {
                result = update(sql, YW, new Object[] { yw_guid[0] });
            }
        }
        //向前台返回判断成功还是失败
        if (result > 0) {//成功
            response("0");
        } else {//失败
            response("1");
        }
    }

    /**
     * Description:导出核查任务 <br>
     * Author:姚建林 <br>
     * Date:2012-8-10
     * @return
     */
    public void expTaskTxt() {
        String ids = request.getParameter("ids");
        String flag = request.getParameter("flag");
        String[] ywids;
        if (ids.contains("@")) {
            ywids = ids.split("@");
        } else {
            ywids = new String[] { ids };
        }
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();//txt文本中存放的数据

        String selSql = "";
        String updSql = "";
        if ("wp".equals(flag)) {
            selSql = "select t.tbbh as RWBH,t.tbmj ,t.x,t.y,t.xzqhdm,t.xzqhmc,t.year,'wp' as RWLX  from wpzf_tb t where tbbh=?";
            updSql = "update wpzf_tb set ajstatus='2' where tbbh=?";
        } else if ("xf".equals(flag)) {
            selSql = "select t.*,'xf' as RWLX from wfxsdjbl t where xsh=?";
            updSql = "update wfxsdjbl set ajstatus='2' where xsh=?";
        } else {
            selSql = "select t.*,'hc' as RWLX from wy_device_data t where guid=?";
            updSql = "update aydjb set ajstatus='2' where xsh=?";
        }

        for (int i = 0; i < ywids.length; i++) {
            //selSql="select t.*,'xf' as RWLX from aydjb t where yw_guid=?";
            //updSql="update lacpb set checked='1' where yw_guid=?"; 
            /*
            if("卫片执法".equals(ajlys[i])){
                selSql="select t.*,'wp' as RWLX  from wpzf_tb t where tbbh=?";
                updSql="update wpzf_tb set ajstatus='2' where tbbh=?";
            }else if("巡查发现".equals(ajlys[i])){
                selSql="select t.*,'xc' as RWLX  from WY_DEVICE_DATA t where guid=?";
                updSql="update WY_DEVICE_DATA set ajstatus='2' where guid=?";
            }else if("群众举报".equals(ajlys[i])){
                selSql="select t.*,'xf' as RWLX from wfxsdjbl t where xsh=?";
                updSql="update wfxsdjbl set ajstatus='2' where xsh=?";
            }*/
            List<Map<String, Object>> listSim = query(selSql, YW, new Object[] { ywids[i] });
            update(updSql, YW, new Object[] { ywids[i] });
            if (listSim.size() > 0) {
                list.add(listSim.get(0));
            }
        }

        File delFile = new File(tempPath + "renwu.zip");
        delFile.deleteOnExit();//在虚拟机终止时，请求删除此抽象路径名表示的文件或目录
        File file = new File(tempPath);
        //输出流，创建一个txt文本
        OutputStreamWriter writer = null;
        if (!file.exists()) {
            file.mkdirs();
        }
        String file_id = new UID().toString().replaceAll(":", "-");
        String filepath = tempPath + file_id;
        File dirs = new File(filepath);
        if (!dirs.isFile()) {
            dirs.mkdirs();
        }
        try {
            writer = new OutputStreamWriter(new FileOutputStream(filepath + "//result.txt"), "UTF-8");
            writer.write(new String(UtilFactory.getJSONUtil().objectToJSON(list).getBytes("UTF-8"), "UTF-8"));
            writer.flush();
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
                writer.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        File oldFile = new File(tempPath + "renwu.zip");
        if (oldFile.exists()) {
            oldFile.delete();
        }
        //将txt文本打成zip包
        UtilFactory.getZIPUtil().zip(tempPath + "renwu.zip", filepath + "//result.txt");
        response(tempPath + "renwu.zip");
    }

    public void ExpLaTask() {

    }

    /**
     * Description:导入核查任务 <br>
     * Author:姚建林 <br>
     * Date:2012-8-10
     * @return
     */
    public void impTaskTxt() {
        String zipPath = tempFile();
        if (zipPath != null) {
            File zipFile = new File(zipPath);
            String folderpath = tempPath + zipFile.getName().substring(0, zipFile.getName().length() - 4);
            //解压缩
            UtilFactory.getZIPUtil().unZip(zipPath, folderpath);
            int count = impTxtInfo(folderpath + "//result.txt");
            response("{success:true,msg:'" + count + "'}");
        }
    }

    /**
     * 
     * <br>Description:导入文本信息
     * <br>Author:陈强峰
     * <br>Date:2012-8-13
     * @return
     */
    private int impTxtInfo(String filepath) {
        int count = 0;
        InputStreamReader read = null;
        BufferedReader reader = null;
        try {
            read = new InputStreamReader(new FileInputStream(filepath), "UTF-8");
            reader = new BufferedReader(read);
            String jsonText = null;
            if ((jsonText = reader.readLine()) != null) {
            }
            //json 串对象                         
            JSONArray objects = UtilFactory.getJSONUtil().jsonToObjects(jsonText);
            // 通过json 对象获取参数值obj.get(key)
            System.out.println(jsonText);
            for (int i = 0; i < objects.size(); i++) {
                JSONObject obj = (JSONObject) objects.get(i);
                //入库操作   先删除  (数据删除   附件删除？)
                String guid = obj.get("GUID").toString();
                String xmmc = obj.get("XMMC").toString();
                String dwmc = obj.get("DWMC").toString();
                String rwlx = obj.get("RWLX").toString();
                String dlwz = obj.get("DLWZ").toString();
                String rwms = obj.get("RWMS").toString();
                String sqlhas = "select guid from wy_pad_data where guid=?";
                List list = query(sqlhas, YW, new Object[] { guid });
                if (list.size() > 0) {
                    String sqldel = "delete from wy_pad_data where guid=?";
                    update(sqldel, YW, new Object[] { guid });
                }
                String sql = "insert into wy_pad_data(guid,xmmc,dwmc,rwlx,wfdd,rwms) values(?,?,?,?,?,?)";
                Object[] objs = new Object[] { guid, xmmc, dwmc, rwlx, dlwz, rwms };
                update(sql, YW, objs);
                count++;
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
        return count;
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
            request.setCharacterEncoding("UTF-8");
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

    public void expTasks() {
        String ids = request.getParameter("ids");
        String flag = request.getParameter("flag");
        String[] ywids;
        String[] lyids;
        if (ids.contains("@")) {
            ywids = ids.split("@");
        } else {
            ywids = new String[] { ids };
        }

        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();//txt文本中存放的数据

        String selSql = "";
        String updSql = "";
        if (flag.equals("cc")) {
            selSql = "select t.YW_GUID as RWBH,t.AJFL as RWMC,'济南' as XZQH,'cc' as RWLX  from aydjb t where YW_GUID=?";
            updSql = "update lacpb l set l.checked='1' where YW_GUID=? ";
        }
        for (int i = 0; i < ywids.length; i++) {
            List<Map<String, Object>> listSim = query(selSql, YW, new Object[] { ywids[i] });
            update(updSql,YW, new Object[] { ywids[i]});
            if (listSim.size() > 0) {
                list.add(listSim.get(0));
            }
        }

        File delFile = new File(tempPath + "renwu.zip");
        delFile.deleteOnExit();//在虚拟机终止时，请求删除此抽象路径名表示的文件或目录
        File file = new File(tempPath);
        //输出流，创建一个txt文本
        OutputStreamWriter writer = null;
        if (!file.exists()) {
            file.mkdirs();
        }
        String file_id = new UID().toString().replaceAll(":", "-");
        String filepath = tempPath + file_id;
        File dirs = new File(filepath);
        if (!dirs.isFile()) {
            dirs.mkdirs();
        }
        try {
            writer = new OutputStreamWriter(new FileOutputStream(filepath + "//result.txt"), "UTF-8");
            writer.write(new String(UtilFactory.getJSONUtil().objectToJSON(list).getBytes("UTF-8"), "UTF-8"));
            writer.flush();
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
                writer.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        File oldFile = new File(tempPath + "renwu.zip");
        if (oldFile.exists()) {
            oldFile.delete();
        }
        //将txt文本打成zip包
        UtilFactory.getZIPUtil().zip(tempPath + "renwu.zip", filepath + "//result.txt");
        response(tempPath + "renwu.zip");
    }

}
