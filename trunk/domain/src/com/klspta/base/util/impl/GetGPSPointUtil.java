package com.klspta.base.util.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.DecimalFormat;
import java.util.Enumeration;
import java.util.TimerTask;
import javax.comm.CommPortIdentifier;
import javax.comm.PortInUseException;
import javax.comm.SerialPort;
import javax.comm.UnsupportedCommOperationException;
import com.klspta.base.util.UtilFactory;
import com.klspta.base.util.api.IGPGGAUtil;
import com.klspta.base.util.api.IGetGPSPointUtil;
import com.klspta.base.wkt.Point;

public class GetGPSPointUtil extends TimerTask implements IGetGPSPointUtil {

    static String com = UtilFactory.getConfigUtil().getConfig("GPSCOM");

    static Enumeration<?> portList;

    static CommPortIdentifier portId;

    static SerialPort serialPort;

    static Double _angle;

    static Double _speed;

    DecimalFormat a = new DecimalFormat("0.00");

    private GetGPSPointUtil() {
    }

    private static GetGPSPointUtil instance = null;

    public static GetGPSPointUtil getInstance(String key) throws Exception {
        if (!key.equals("NEW WITH UTIL FACTORY!")) {
            throw new Exception("请通过UtilFactory获取实例.");
        }
        if (instance == null) {
            instance = new GetGPSPointUtil();
        }
        return instance;
    }

    private static BufferedReader in = null;

    public boolean openCOM() {
        ggaUtil = UtilFactory.getGPGGAUtil();
        ggaUtil.isFix(true);
        portList = CommPortIdentifier.getPortIdentifiers();
        while (portList.hasMoreElements()) {
            portId = (CommPortIdentifier) portList.nextElement();
            if (portId.getPortType() == CommPortIdentifier.PORT_SERIAL) {
                if (portId.getName().equals(com)) {
                    try {
                        serialPort = (SerialPort) portId.open("GISLAND", 60);
                        serialPort.setSerialPortParams(4800, SerialPort.DATABITS_8, SerialPort.STOPBITS_1,
                                SerialPort.PARITY_NONE);
                        in = new BufferedReader(new InputStreamReader(serialPort.getInputStream()));
                    } catch (PortInUseException e) {
                        System.out.println("打开GPS模块出错.");
                        e.printStackTrace();
                        return false;
                    } catch (UnsupportedCommOperationException e) {
                        System.out.println("打开GPS模块出错.");
                        e.printStackTrace();
                        return false;
                    } catch (IOException e) {
                        System.out.println("打开GPS模块出错.");
                        e.printStackTrace();
                        return false;
                    }
                }
            }
        }
        return true;
    }

    public void closeCOM() {
        if (serialPort != null) {
            serialPort.close();
        }
    }

    private static String gpgga = "";

    private static IGPGGAUtil ggaUtil = null;

    public void run() {
        try {
            if (in == null) {
                return;
            }
            while (true) {
                gpgga = in.readLine();
                if (gpgga.startsWith("$GPGGA")) {
                    ggaUtil.setGPGGA(gpgga);
                }
                if (gpgga.startsWith("$GPRMC")) {
                    try {
                        String[] lineArr = gpgga.split(",");
                        if (lineArr[8].equals("")) {
                            _angle = Double.parseDouble("-1");
                        } else {
                            _angle = Double.parseDouble(lineArr[8]);
                        }
                        if (lineArr[7].equals("")) {
                            _speed = Double.parseDouble("0");
                        } else {
                            _speed = Double.parseDouble(lineArr[7]);
                        }
                    } catch (Exception e) {
                        continue;
                    }
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static Point point = null;

    @Override
    public String[] getXY() {
        point = ggaUtil.getPoint80();//new Point(40447571, 3590411);;
        return new String[] { "" + point.getX(), "" + point.getY() };
    }

    @Override
    public String direction() {
        String _direction = "";
        if (_angle <= 0) {
            _direction = "停止";
        } else if (_angle < 90) {
            _direction = "东偏北 " + (a.format(90 - _angle)) + "°";
        } else if (_angle > 90 && _angle < 180) {
            _direction = "东偏南 " + (a.format(_angle - 90)) + "°";
        } else if (_angle > 180 && _angle < 270) {
            _direction = "西偏南 " + (a.format(_angle - 180)) + "°";
        } else if (_angle > 270) {
            _direction = "西偏北 " + (a.format(_angle - 270)) + "°";
        } else if (_angle == 0) {
            _direction = "正北 0°";
        } else if (_angle == 90) {
            _direction = "正东 90°";
        } else if (_angle == 180) {
            _direction = "正南 180°";
        } else if (_angle == 270) {
            _direction = "正西 270°";
        }
        return _direction;
    }

    @Override
    public String speed() {
        return a.format(_speed * 1.852) + "";
    }

}
