package com.klspta.base.util.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.api.IConfigUtil;

public final class ConfigUtil extends AbstractBaseBean implements IConfigUtil {
    private static String SHAPE_FILE_TEMP_FLODER;

    private static String SECURITY_USEABLE;

    private static String SECURITY_verifyURL;

    private static String SECURITY_passIPs;

    private static String app_path;

    public String getApppath() {
        return app_path;
    }

    Properties props = null;

    Properties sqlprops = null;

    private ConfigUtil() {
        try {
            InputStream basepath = getClass().getResourceAsStream("/config.properties");
            app_path = getClass().getResource("/").getPath();
            props = new Properties();
            props.load(basepath);
            SHAPE_FILE_TEMP_FLODER = props.getProperty("SHAPEFILE_PATH");
            File file = new File(SHAPE_FILE_TEMP_FLODER);
            if (!file.exists()) {
                file.mkdirs();
            }
            SECURITY_USEABLE = props.getProperty("SECURITY_USEABLE");
            SECURITY_verifyURL = props.getProperty("SECURITY_verifyURL");
            SECURITY_passIPs = props.getProperty("SECURITY_passIPs");

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static IConfigUtil instance;

    public static IConfigUtil getInstance(String key) throws Exception {
        if (!key.equals("NEW WITH UTIL FACTORY!")) {
            throw new Exception("请从UtilFacoory获取工具.");
        }
        if (instance == null) {
            return new ConfigUtil();
        } else {
            return instance;
        }
    }

    public String getShapefileTempPathFloder() {
        return SHAPE_FILE_TEMP_FLODER;
    }

    public boolean isSecurityUseable() {
        return SECURITY_USEABLE.equals("true") ? true : false;
    }

    public String getSecurityVerifyURL() {
        return SECURITY_verifyURL;
    }

    public String getSecurityPassIPs() {
        return SECURITY_passIPs;
    }

    public String getSQL(String key) {
        return this.getSqlValue(sqlprops.getProperty(key));
    }

    public String getConfig(String key) {
        return props.getProperty(key);
    }

    public double getConfigDouble(String key) {
        try {
            return Double.parseDouble(props.getProperty(key));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public String getSqlValue(String sqlporperties) {
        String[] value = sqlporperties.split("@");
        String sql = value[0];
        if (value.length == 2) {
            String querySrid = sqlprops.getProperty("querySrid");
            Object[] arg = { value[1].toUpperCase() };
            List<Map<String, Object>> list = query(querySrid, SDE, arg);
            if (list.size() > 0) {
                Map<String, Object> map = list.get(0);
                sql = sql.replace("#srid", (String) map.get("srid"));
            }
        }
        return sql;
    }

}
