package com.klspta.base.util.impl;

import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.api.IGPGGAUtil;
import com.klspta.base.util.api.IGisBaseUtil;
import com.klspta.base.wkt.Point;

public final class GPGGAUtil implements IGPGGAUtil {

    private GPGGAUtil() {
    }

    public static IGPGGAUtil getInstance(String key) throws Exception {
        if (!key.equals("NEW WITH UTIL FACTORY!")) {
            throw new Exception();
        }
        return new GPGGAUtil();
    }

    private boolean isFix = false;

    @Override
    public void isFix(boolean isfix) {
        this.isFix = isfix;
    }

    @Override
    public void setGPGGA(String gpgga) {
        parseGPGGA(gpgga);
    }

    @Override
    public Point getPoint84() {
        return point84;
    }

    @Override
    public Point getPoint80() {
        return point80;
    }

    static String[] gpggas = null;

    static Point point84 = new Point(0, 0);

    static Point point80 = new Point(0, 0);

    private static final double FIX_X = UtilFactory.getConfigUtil().getConfigDouble("FIX_X");

    private static final double FIX_Y = UtilFactory.getConfigUtil().getConfigDouble("FIX_Y");

    private double x84 = 0.0;

    private double y84 = 0.0;

    private void parseGPGGA(String gpgga) {
        gpggas = gpgga.split(",");
        if (gpggas.length != 15 || gpggas[4] == null || gpggas[4].equals("")
                || gpggas[4].equals("00000.0000")) {
            System.out.println(gpgga);
            return;
        }
        if (isFix) {
            x84 = Double.parseDouble(gpggas[4]) + FIX_X;
            y84 = Double.parseDouble(gpggas[2]) + FIX_Y;
            point84.setPointXY(x84, y84);
        } else {
            point84.setPointXY(gpggas[4], gpggas[2]);
        }
        point80 = UtilFactory.getGisBaseUtil().changeMe(point84, IGisBaseUtil.GPS84_TO_BALIN80);
    }
}
