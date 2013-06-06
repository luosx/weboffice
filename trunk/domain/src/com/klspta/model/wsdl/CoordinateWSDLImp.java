package com.klspta.model.wsdl;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.net.MalformedURLException;
import java.nio.charset.Charset;
import java.rmi.server.UID;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.codehaus.xfire.XFireFactory;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;
import org.geotools.data.DataUtilities;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.Transaction;
import org.geotools.data.shapefile.ShapefileDataStore;
import org.geotools.data.shapefile.ShapefileDataStoreFactory;
import org.geotools.data.shapefile.ShapefileFeatureLocking;
import org.geotools.data.shapefile.ShpFiles;
import org.geotools.data.shapefile.dbf.DbaseFileHeader;
import org.geotools.data.shapefile.dbf.DbaseFileReader;
import org.geotools.data.shapefile.shp.ShapefileException;
import org.geotools.data.shapefile.shp.ShapefileReader;
import org.geotools.feature.FeatureCollection;
import org.geotools.feature.FeatureCollections;
import org.geotools.feature.simple.SimpleFeatureBuilder;
import org.geotools.geometry.jts.JTSFactoryFinder;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.api.ICoordinateChangeUtil;
import com.klspta.base.util.bean.shapeutil.ShpParameters;
import com.klspta.base.wkt.Point;
import com.scand.fileupload.ProgressMonitorFileItemFactory;
import com.vividsolutions.jts.geom.Coordinate;
import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.GeometryFactory;

public class CoordinateWSDLImp extends AbstractBaseBean implements ICoordinateWSDL {
    Vector<Map<String, Object>> v = new Vector<Map<String, Object>>();

    ShpParameters sp = new ShpParameters();

    private String tempPath = UtilFactory.getConfigUtil().getShapefileTempPathFloder();

    private String type = "";

    private String toShpPath = new UID().toString().replaceAll(":", "-");

    private String currentTime = "";

    /**
     * <br>Description: 坐标转换
     * <br>Author:李如意
     * <br>DateTime:2013-4-24 下午03:02:22
     * @see com.klspta.base.util.api.ICoordinateWSDL#changeMe(java.lang.String, java.lang.String, java.lang.String)
     */
    public String changeMe(Double x, Double y, String type) {
        double longitude = x; //经度
        double latitude = y; //维度
        String typeVaue = null; //坐标转换类型

        try {
            if ("84bl_80bl".equalsIgnoreCase(type))
                typeVaue = ICoordinateChangeUtil.BL84_TO_BL80;
            if ("84bl_80plant".equalsIgnoreCase(type))
                typeVaue = ICoordinateChangeUtil.GPS84_TO_BALIN80;
            if ("84bl_baidu".equalsIgnoreCase(type)) {
                //调用百度地图转换接口

            }
            if ("84bl_google".equalsIgnoreCase(type)) {
                //调用谷歌地图转换接口

            }
            if ("80bl_80plant".equalsIgnoreCase(type))
                typeVaue = ICoordinateChangeUtil.BL80_TO_PLAIN80;
            if ("80plant_80bl".equalsIgnoreCase(type))
                typeVaue = ICoordinateChangeUtil.PLAIN80_TO_BL80;
            if ("84PLAINTO80PLAIN".equalsIgnoreCase(type))
                typeVaue = ICoordinateChangeUtil.PLAIN84_TO_PLAIN80;
            if ("grid".equalsIgnoreCase(type))
                typeVaue = ICoordinateChangeUtil.GRID;
            if ("84gps_84bl".equalsIgnoreCase(type))
                //typeVaue=ChangeCoordsSysUtil.GPS84_TO_BL84;
                if ("84gps_xian80bl".equalsIgnoreCase(type)) {
                    //typeVaue=ChangeCoordsSysUtil.GPS84_TO_BL84;
                    Point p = UtilFactory.getCoordinateChangeUtil().changePoint(
                            new Point(longitude, latitude), typeVaue);
                    longitude = p.getX();
                    latitude = p.getY();
                    typeVaue = ICoordinateChangeUtil.BL84_TO_BL80;
                }
            if ("84gps_xian80plant".equalsIgnoreCase(type)) {
                // typeVaue=ChangeCoordsSysUtil.GPS84_TO_BL84;
                Point p = UtilFactory.getCoordinateChangeUtil().changePoint(new Point(longitude, latitude),
                        typeVaue);
                longitude = p.getX();
                latitude = p.getY();
                typeVaue = ICoordinateChangeUtil.GPS84_TO_BALIN80;
            }

            Point p = UtilFactory.getCoordinateChangeUtil().changePoint(new Point(longitude, latitude),
                    typeVaue);
            return p.getX() + "," + p.getY();

        } catch (Exception e) {

        }
        return "";
    }

    /**
     * <br>Description: 对上传的含有shp文件的ZIP压缩包进行解压、解析
     * <br>Author:李如意
     * <br>DateTime:2013-4-24 下午03:36:00
     */
    public void shpZIP() {
        currentTime = request.getParameter("currentTime");
        type = request.getParameter("type");
        String zipPath = upload();

        if (zipPath != null) {
            File zipFile = new File(zipPath);
            String folderpath = tempPath + zipFile.getName().substring(0, zipFile.getName().length() - 4);
            UtilFactory.getZIPUtil().unZip(zipPath, folderpath);
            System.out.println("当前解压的文件夹目录： " + folderpath);
            findShpFiles(folderpath);
            response("{success:true,msg:\"" + tempPath + currentTime + "\"}");
        } else {
            response("{success:false}");
        }
    }

    /**
     * <br>Description: 	调用WS服务对坐标进行转换
     * <br>Author:李如意
     * <br>DateTime:2013-4-25 下午02:38:49
     * @param x				
     * @param y				
     * @param changeType	参考系转换类型
     * @return
     */
    public String coordinateChange(double x, double y, String changeType) {
        Service srcModel = new ObjectServiceFactory().create(ICoordinateWSDL.class);
        XFireProxyFactory factory = new XFireProxyFactory(XFireFactory.newInstance().getXFire());
        String serviceUrl = "http://localhost:8080/reduce/service/rest/coordinate/change";
        StringBuffer sb = new StringBuffer();
        try {
            ICoordinateWSDL coordsSysUtil = (ICoordinateWSDL) factory.create(srcModel, serviceUrl);
            String str = (String) coordsSysUtil.changeMe(x, y, changeType);
            sb.append(str.split(",")[0]).append(",").append(str.split(",")[1]);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

    /**
     * <br>Description: shp文件解析获取坐标
     * <br>Author:李如意
     * <br>DateTime:2013-4-25 下午02:14:53
     * @param dbfPath
     */
    public void parseShpFile(String shpAbsolutePath, String dbfAbsolutePath) {
        String tempFolder = UtilFactory.getConfigUtil().getShapefileTempPathFloder();
        String shpName = shpAbsolutePath.substring(shpAbsolutePath.lastIndexOf("\\") + 1);

        ShapefileReader r = null;
        try {
            ShpFiles shp = new ShpFiles(shpAbsolutePath);
            r = new ShapefileReader(shp, false, false, new GeometryFactory(), false);
            ShpParameters sp = new ShpParameters();

            int n = 0;
            StringBuffer sb = new StringBuffer();
            while (r.hasNext()) {
                Geometry g = (Geometry) r.nextRecord().shape();
                Coordinate[] cc = g.getCoordinates();
                double x_ = cc[0].x;
                double y_ = cc[0].y;
                double x = cc[cc.length - 1].x;
                double y = cc[cc.length - 1].y;
                if (x_ == x && y_ == y) {
                    System.out.println("第" + (++n) + "个图斑 首尾坐标点闭合.............................");
                    for (int i = 0; i < cc.length; i++) {
                        String s = coordinateChange(cc[i].x, cc[i].y, type);
                        sb.append(s).append(";");
                    }
                    sb.deleteCharAt(sb.length() - 1);
                    sb.append("@@");
                } else {
                    System.out.println("第" + (++n) + "个图斑 首尾坐标点未闭合---------------------------");
                    continue;
                }
            }
            File dirs = new File(UtilFactory.getConfigUtil().getShapefileTempPathFloder() + currentTime);
            if (!dirs.isFile()) {
                dirs.mkdirs();
            }
            String outShp = tempFolder + "\\" + currentTime + "\\" + shpName;
            createShp(sb.toString().substring(0, sb.length() - 2), shpAbsolutePath, outShp);
            sp.setFilename(shpAbsolutePath.substring(shpAbsolutePath.lastIndexOf("\\") + 1));
            UtilFactory.getZIPUtil().zip(
                    UtilFactory.getConfigUtil().getShapefileTempPathFloder() + "\\" + currentTime + ".zip",
                    UtilFactory.getConfigUtil().getShapefileTempPathFloder() + currentTime);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (ShapefileException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (r != null) {
                try {
                    r.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * <br>Description: 循环查找指定文件下的文件（从某个给定的需查找的文件夹开始，搜索该文件夹的所有子文件夹及文件查找指定类型的文件）
     * <br>Author:李如意
     * <br>DateTime:2013-4-22 下午07:33:46
     * @param baseDirName
     */
    public void findShpFiles(String unZipTempPath) {
        String tempName = null;
        File baseDir = new File(unZipTempPath);
        if (!baseDir.exists() || !baseDir.isDirectory()) {

        } else {
            String[] filelist = baseDir.list();
            for (int i = 0; i < filelist.length; i++) {
                File readfile = new File(unZipTempPath + "\\" + filelist[i]);
                if (!readfile.isDirectory()) {
                    String path = readfile.getAbsolutePath();
                    tempName = readfile.getName();
                    String fileSuffix = tempName.substring(tempName.length() - 4);
                    if (".shp".equals(fileSuffix)) {
                        String dbfpath = path.substring(0, path.length() - 4) + ".dbf";
                        parseShpFile(path, dbfpath);
                    }
                } else if (readfile.isDirectory()) {
                    findShpFiles(unZipTempPath + "\\" + filelist[i]);
                }
            }
        }
    }

    /**
     * <br>Description: 将含有shp的zip文件进行上传
     * <br>Author:李如意
     * <br>DateTime:2013-4-22 下午07:10:06
     * @return
     */
    private String upload() {
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
     * <br>Description: 生成坐标转换过的shp文件
     * <br>Author:李如意
     * <br>DateTime:2013-4-28 上午10:27:23
     * @param multiPolygonPoint
     * @param shpAbsolutePath
     * @param outPath
     */
    public void createShp(String multiPolygonPoint, String shpAbsolutePath, String outPath) {
        String dbfPath = shpAbsolutePath.substring(0, shpAbsolutePath.length() - 4) + ".dbf";
        System.out.println("dbfPath:  " + dbfPath);

        try {
            DbaseFileReader reader = new DbaseFileReader(new ShpFiles(dbfPath), false, Charset.forName("GBK"));
            DbaseFileHeader header = reader.getHeader();
            int numFields = header.getNumFields();

            StringBuffer nameAndType = new StringBuffer();
            StringBuffer names = new StringBuffer();
            for (int i = 0; i < numFields; i++) {
                String name = header.getFieldName(i);
                char type = header.getFieldType(i);
                Object value = header.getFieldLength(i);

                switch (type) {
                case 'C':
                    nameAndType.append(name).append(":").append("String").append(",");
                    names.append(name).append(",");
                    //字符串类型
                    break;
                case 'L':
                    //布尔类型
                    break;
                case 'D':
                    //日期类型
                    break;
                case 'G':
                    //各种字符
                    break;
                case 'B':
                    //二进制类型
                    break;
                case 'N':
                    nameAndType.append(name).append(":").append("double").append(",");
                    names.append(name).append(",");
                    //数字类型
                    break;
                default:
                    //其他 
                }

            }
            final SimpleFeatureType TYPE3 = DataUtilities.createType("Location", "location:Polygon,"
                    + nameAndType);
            FeatureCollection<SimpleFeatureType, SimpleFeature> collection = FeatureCollections
                    .newCollection();
            GeometryFactory geometryFactory = new GeometryFactory();
            SimpleFeatureBuilder featureBuilder3 = new SimpleFeatureBuilder(TYPE3);
            geometryFactory = JTSFactoryFinder.getGeometryFactory(null);
            String[] polygonsPoint = multiPolygonPoint.split("@@");
            for (int i = 0; i < polygonsPoint.length; i++) {
                String[] arrPoint = polygonsPoint[i].split(";");
                Coordinate[] coords = new Coordinate[arrPoint.length];
                for (int n = 0; n < arrPoint.length; n++) {
                    double x = Double.parseDouble(arrPoint[n].split(",")[0]);
                    double y = Double.parseDouble(arrPoint[n].split(",")[1]);
                    coords[n] = new Coordinate(x, y);
                }
                com.vividsolutions.jts.geom.LinearRing ring = geometryFactory.createLinearRing(coords);
                com.vividsolutions.jts.geom.LinearRing holes[] = null;
                com.vividsolutions.jts.geom.Polygon polygon = geometryFactory.createPolygon(ring, holes);
                Object[] obj = new Object[numFields + 1];
                obj[0] = polygon;
                while (reader.hasNext()) {
                    try {
                        Object[] entry = reader.readEntry();
                        for (int j = 0; j < numFields; j++) {
                            String title = header.getFieldName(j);
                            Object value = entry[j];
                            String name = title.toString(); // column
                            String info = value.toString(); // value
                            obj[j + 1] = info;
                        }
                        SimpleFeature feature3 = featureBuilder3.buildFeature(null, obj);
                        collection.add(feature3);
                        break;
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

            }

            File newFile = new File(outPath);
            Map<String, Serializable> params = new HashMap<String, Serializable>();
            params.put("url", (Serializable) newFile.toURI().toURL());
            params.put("create spatial index", (Serializable) Boolean.TRUE);
            ShapefileDataStoreFactory dataStoreFactory = new ShapefileDataStoreFactory();
            ShapefileDataStore newDataStore = (ShapefileDataStore) dataStoreFactory
                    .createNewDataStore(params);
            newDataStore.createSchema(TYPE3);
            newDataStore.setStringCharset(Charset.forName("GBK"));
            //newDataStore.forceSchemaCRS(DefaultGeographicCRS.WGS84);
            String typeName = newDataStore.getTypeNames()[0];
            ShapefileFeatureLocking featureSource = (ShapefileFeatureLocking) newDataStore
                    .getFeatureSource(typeName);
            // 创建一个事务
            Transaction transaction = new DefaultTransaction("create");
            featureSource.setTransaction(transaction);
            try {
                featureSource.addFeatures(collection);
                // 提交事务
                transaction.commit();
            } catch (Exception problem) {
                problem.printStackTrace();
                transaction.rollback();
            } finally {
                transaction.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void changeMe(String changetype, Byte[] data) {

    }

}
