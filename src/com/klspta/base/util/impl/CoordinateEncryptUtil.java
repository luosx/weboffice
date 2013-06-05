package com.klspta.base.util.impl;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;
import com.klspta.base.util.api.ICoordinateEncryptUtil;

public class CoordinateEncryptUtil implements ICoordinateEncryptUtil {
    private CoordinateEncryptUtil() {
    }

    private static CoordinateEncryptUtil instance = null;

    public static CoordinateEncryptUtil getInstance(String key) throws Exception {
        if (!key.equals("NEW WITH UTIL FACTORY!")) {
            throw new Exception("请通过UtilFactory获取实例.");
        }
        if (instance == null) {
            instance = new CoordinateEncryptUtil();
        }
        return instance;
    }

    @Override
    public String GetDecryptData(String jmzb) {
        ActiveXComponent app = new ActiveXComponent("CoordinateEncrypt.Encrypt.1");
        Dispatch mycom = (Dispatch) app.getObject();
        if (mycom != null) {
            Variant result = Dispatch.callN(mycom, "GetDecryptData", jmzb);
            return result.toString();
        }
        return null;
    }

    @Override
    public String GetEncryptData(double x, double y) {
        ActiveXComponent app = new ActiveXComponent("CoordinateEncrypt.Encrypt.1");
        Dispatch mycom = (Dispatch) app.getObject();
        if (mycom != null) {
            Variant result = Dispatch.callN(mycom, "GetEncryptData", new Object[] { x + "", y + "" });
            return result.toString();
        }
        return null;
    }

}
