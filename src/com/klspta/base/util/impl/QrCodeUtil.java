package com.klspta.base.util.impl;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

import com.klspta.base.AbstractBaseBean;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.api.IQrCodeUtil;
import com.swetake.util.Qrcode;

public final class QrCodeUtil extends AbstractBaseBean implements IQrCodeUtil {

    private static QrCodeUtil instance;

    private QrCodeUtil() {
    };

    public static QrCodeUtil getInstance(String key) throws Exception {
        if (!key.equals("NEW WITH UTIL FACTORY!")) {
            throw new Exception("请通过UtilFactory获取实例.");
        }
        if (instance == null) {
            instance = new QrCodeUtil();
        }
        return instance;
    }

    @Override
    public String create(String str) {
        File f = null;
        try {
            Qrcode testQrcode = new Qrcode();
            testQrcode.setQrcodeErrorCorrect('M');
            testQrcode.setQrcodeEncodeMode('B');
            testQrcode.setQrcodeVersion(7);
            byte[] d = str.getBytes("gbk");
            System.out.println(d.length);
            BufferedImage bi = new BufferedImage(98, 98, BufferedImage.TYPE_BYTE_BINARY);
            Graphics2D g = bi.createGraphics();
            g.setBackground(Color.WHITE);
            g.clearRect(0, 0, 98, 98);
            g.setColor(Color.BLACK);

            boolean[][] s = testQrcode.calQrcode(d);
            for (int i = 0; i < s.length; i++) {
                for (int j = 0; j < s.length; j++) {
                    if (s[j][i]) {
                        g.fillRect(j * 2 + 3, i * 2 + 3, 2, 2);
                    }
                }
            }
            g.dispose();
            bi.flush();
            String temp = UtilFactory.getConfigUtil().getShapefileTempPathFloder();
            String guid = UtilFactory.getStrUtil().getGuid();
            f = new File(temp + guid + ".jpg");
            if (!f.exists()) {
                f.createNewFile();
            }
            //创建图片
            ImageIO.write(bi, "jpg", f);

        } // end try
        catch (Exception e) {
            e.printStackTrace();
        } // end catch
        return f.getPath().toString();
    }

}
