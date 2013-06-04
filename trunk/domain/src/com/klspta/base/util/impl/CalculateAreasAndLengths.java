package com.klspta.base.util.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.api.ICalculateAreasAndLengths;
import com.klspta.base.wkt.Point;
import com.klspta.base.wkt.Polygon;
import com.klspta.base.wkt.Ring;

public class CalculateAreasAndLengths implements ICalculateAreasAndLengths {

    private CalculateAreasAndLengths() {
    }

    public static ICalculateAreasAndLengths getInstance(String key) throws Exception {
        if (!key.equals("NEW WITH UTIL FACTORY!")) {
            throw new Exception();
        }
        return new CalculateAreasAndLengths();
    }

    @Override
    public double[] getAreasAndLengths(Polygon polygon) {
        double[] ret = new double[2];
        try{
            String ss = projectRequest(polygon);
            String cs = buildPolygonStr(ss);
            String re = arealengthRequest(cs);
            re = re.substring(12, re.length() - 2);
            String[] sss = re.split("\\],\"lengths\" : \\[");
            ret[0] = Math.abs(Double.parseDouble(sss[0]));
            ret[1] = Math.abs(Double.parseDouble(sss[1]));
        }catch(Exception e){
            
        }
        return ret;
    }
    
    private String buildPolygonStr(String s){
        if(s.startsWith("{\"geometries\"")){
            s = s.substring(16, s.length() - 1);
        }
        try {
            s = URLEncoder.encode(s, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return s;
    }
    
    private String getPolygon(Polygon polygon){
        String target_map_srid = UtilFactory.getConfigUtil().getConfig("target_map_srid");
        String ret = "";
        int ri = polygon.getRingCount();
        StringBuffer sb = new StringBuffer("{\"geometryType\":\"esriGeometryPolygon\",\"geometries\":[{\"rings\":[[");
        Point p = null;
        for(int i = 0; i < ri; i++){
            Ring ring = polygon.getRing(i);
            int pi = ring.getPointCount();
            for(int j = 0; j < pi; j++){
                p = ring.getPoint(j);
                sb.append("[").append(p.getX()).append(",").append(p.getY()).append("],");
            }
            sb.append("nextring");
        }
        sb.append("geometryend").append("],\"spatialReference\":{\"wkid\":" + target_map_srid + "}}]}");
        ret = sb.toString().replaceAll(",nextring", "],[");
        ret = ret.replaceAll(",\\[geometryend", "");
        try {
            ret = URLEncoder.encode(ret, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return ret;
    }
    
    private String projectRequest(Polygon polygon){
        String geourl = UtilFactory.getConfigUtil().getConfig("geometry_service");
        String local_map_srid = UtilFactory.getConfigUtil().getConfig("local_map_srid");
        String target_map_srid = UtilFactory.getConfigUtil().getConfig("target_map_srid");
        StringBuffer sb = new StringBuffer(geourl);
        sb.append("/project?f=json&inSR=").append(local_map_srid).append("&outSR=").append(target_map_srid).append("&geometries=").append(getPolygon(polygon));
        return sendHttpRequest(sb.toString());
    }
    
    private String arealengthRequest(String pol){
        String geourl = UtilFactory.getConfigUtil().getConfig("geometry_service");
        String target_map_srid = UtilFactory.getConfigUtil().getConfig("target_map_srid");
        StringBuffer sb = new StringBuffer(geourl);
        sb.append("/areasAndLengths?f=json&sr=").append(target_map_srid).append("&polygons=").append(pol);
        return sendHttpRequest(sb.toString());
    }
    
    private String sendHttpRequest(String para) {
        HttpURLConnection connet = null;
        URL url;
        try {
            url = new URL(para);
            connet = (HttpURLConnection) url.openConnection();
            if (connet.getResponseCode() != 200) {
                throw new IOException(connet.getResponseMessage());
            }
            BufferedReader brd = new BufferedReader(new InputStreamReader(connet.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = brd.readLine()) != null) {
                sb.append(line);
            }
            brd.close();
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            if(connet != null){
                connet.disconnect();
            }
        }  
        return null;
    }

    public static void main(String[] args) {
        CalculateAreasAndLengths c = new CalculateAreasAndLengths();
        String wkt = "MULTIPOLYGON  ((( 38.90968257 121.43689989, 38.90968257 121.42039350, 38.92131208 121.42151893, 38.92168722 121.43652474, 38.91606004 121.43089756, 38.90968257 121.43689989)),(( 38.89733840 121.46007605, 38.89992880 121.45153055, 38.91080801 121.45153055, 38.91080801 121.46053403, 38.89733840 121.46007605)),(( 38.92543867 121.46015889, 38.92543867 121.45153055, 38.93444216 121.45153055, 38.93369187 121.46015889, 38.92543867 121.46015889)))";
        //String wkt = "POLYGON  (( 38.90968257 121.43689989, 38.90968257 121.42039350, 38.92131208 121.42151893, 38.92168722 121.43652474, 38.91606004 121.43089756, 38.90968257 121.43689989))";
        Polygon pol = new Polygon(wkt);
        /*Ring ring = new Ring();
        Point p1 = new Point(112.32421969885138,32.23120904516664);
        Point p2 = new Point(112.32886800503152,32.22786226471693);
        Point p3 = new Point(112.32421969885138,32.227629849407926);
        Point p4 = new Point(112.32421969885138,32.23120904516664);
        ring.putPoint(p1);
        ring.putPoint(p2);
        ring.putPoint(p3);
        ring.putPoint(p4);
        pol.addRing(ring);
        pol.addRing(ring);*/
        double[] dd = c.getAreasAndLengths(pol);
        System.out.println(dd[0]);
        System.out.println(dd[1]);
    }
}
