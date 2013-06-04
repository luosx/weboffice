package com.klspta.base.util;

import java.util.TimerTask;

import org.apache.commons.httpclient.util.DateUtil;

import com.klspta.base.util.api.ICalculateAreasAndLengths;
import com.klspta.base.util.api.IChangeCoordsSysUtil;
import com.klspta.base.util.api.IConfigUtil;
import com.klspta.base.util.api.ICoordinateEncryptUtil;
import com.klspta.base.util.api.IDateUtil;
import com.klspta.base.util.api.IFileUtil;
import com.klspta.base.util.api.IFtpUtil;
import com.klspta.base.util.api.IGPGGAUtil;
import com.klspta.base.util.api.IGetGPSPointUtil;
import com.klspta.base.util.api.IGisGridUtil;
import com.klspta.base.util.api.IJSONUtil;
import com.klspta.base.util.api.IQrCodeUtil;
import com.klspta.base.util.api.IQueryUtil;
import com.klspta.base.util.api.IShapeUtil;
import com.klspta.base.util.api.IStrUtil;
import com.klspta.base.util.api.IWKTUtil;
import com.klspta.base.util.api.IXzqhUtil;
import com.klspta.base.util.api.IZIPUtil;
import com.klspta.base.util.impl.CalculateAreasAndLengths;
import com.klspta.base.util.impl.ChangeCoordsSysUtil;
import com.klspta.base.util.impl.ConfigUtil;
import com.klspta.base.util.impl.CoordinateEncryptUtil;
import com.klspta.base.util.impl.FileUtil;
import com.klspta.base.util.impl.FtpUtil;
import com.klspta.base.util.impl.GPGGAUtil;
import com.klspta.base.util.impl.GetGPSPointUtil;
import com.klspta.base.util.impl.GisGridUtil;
import com.klspta.base.util.impl.JSONUtil;
import com.klspta.base.util.impl.QrCodeUtil;
import com.klspta.base.util.impl.QueryUtil;
import com.klspta.base.util.impl.ShapeUtil;
import com.klspta.base.util.impl.StrUtil;
import com.klspta.base.util.impl.WKTUtil;
import com.klspta.base.util.impl.XzqhUtil;
import com.klspta.base.util.impl.ZIPUtil;




/**
 * 
 * <br>Title:工具工厂类
 * <br>Description:所有全局工具类实例均通过此工厂获取
 * <br>Author:王瑛博
 * <br>Date:2011-5-3
 */
public final class UtilFactory {

    /**
     * 
     * <br>Description:构造私有化
     * <br>Author:王瑛博
     * <br>Date:2011-5-3
     */
    private UtilFactory() {
    }

    /**
     * 
     * <br>Description:获取json工具类实例
     * <br>Author:王瑛博
     * <br>Date:2011-5-3
     * @return
     */
    public static IJSONUtil getJSONUtil() {
        return JSONUtil.getInstance("NEW WITH UTIL FACTORY!");
    }
    
    /**
     * 
     * <br>Description:获取FTP工具类实例
     * <br>Author:王瑛博
     * <br>Date:2011-5-3
     * @return
     */
    public static IFtpUtil getFtpUtil(){
	    try {
			return FtpUtil.getInstance("NEW WITH UTIL FACTORY!");
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }
    
    /**
     * 
     * <br>Description:获取全局配置工具类实例
     * <br>Author:王瑛博
     * <br>Date:2011-5-3
     * @return
     */
    public static IConfigUtil getConfigUtil() {
        try {
            return ConfigUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 
     * <br>Description:获取ZIP工具类实例
     * <br>Author:王瑛博
     * <br>Date:2011-5-3
     * @return
     */
    public static IZIPUtil getZIPUtil() {
        try {
            return ZIPUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 
     * <br>Description:获取WKT工具类实例
     * <br>Author:王瑛博
     * <br>Date:2011-5-3
     * @return
     */
    public static IWKTUtil getWKTUtil() {
        try {
            return WKTUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 
     * <br>Description:获取GPS工具类实例
     * <br>Author:王瑛博
     * <br>Date:2011-5-3
     * @return
     */
    public static IGetGPSPointUtil getGPSPointUtil() {
        try {
            return GetGPSPointUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 
     * <br>Description:获取GPS守护进程工具类实例
     * <br>Author:王瑛博
     * <br>Date:2011-5-3
     * @return
     */
    public static TimerTask getGPSPointUtilTimerTask() {
        try {
            return GetGPSPointUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 
     * <br>Description:获取字符串工具类实例
     * <br>Author:王瑛博
     * <br>Date:2011-5-3
     * @return
     */
    public static IStrUtil getStrUtil() {
        try {
            return StrUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 
     * <br>Description:获取GPGGA字符串解析工具类实例
     * <br>Author:王瑛博
     * <br>Date:2011-5-3
     * @return
     */
    public static IGPGGAUtil getGPGGAUtil() {
        try {
            return GPGGAUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * 
     * <br>Description:获取GPGGA字符串解析工具类实例
     * <br>Author:王瑛博
     * <br>Date:2011-5-3
     * @return
     */
    public static IChangeCoordsSysUtil getChangeCoordsSysUtil() {
        try {
            return ChangeCoordsSysUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * <br>Description:获取字符串加密解密工具实例
     * <br>Author:郭润沛
     * <br>Date:2011-8-29
     * @return
     */
    public static ICoordinateEncryptUtil getCoordinateEncryptUtil() {
        try {
            return CoordinateEncryptUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * 
     * <br>Description:shp文件操作工具
     * <br>Author:王瑛博
     * <br>Date:2011-10-19
     * @return
     */
    public static IShapeUtil getShapeUtil() {
        try {
            return ShapeUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static ICalculateAreasAndLengths getCalculateAreasAndLengthsUtil() {
        try {
            return CalculateAreasAndLengths.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static IXzqhUtil getXzqhUtil(){
    	try {
            return XzqhUtil.getInstance("NEW WITH UTIL FACTORY!");
         } catch (Exception e) {
             e.printStackTrace();
             return null;
         }
    }
    
    public static IQueryUtil getQueryUtil() {
        try {
            return QueryUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public static IQrCodeUtil getQrCodeUtil() {
        try {
            return QrCodeUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static IFileUtil getFileUtil() {
        try {
            return FileUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public static IDateUtil getDateUtil() {
        try {
            return com.klspta.base.util.impl.DateUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public static IGisGridUtil getGisGridUtil() {
        try {
            return GisGridUtil.getInstance("NEW WITH UTIL FACTORY!");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}