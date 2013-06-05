package com.klspta.model.wsdl;

public interface ICoordinateWSDL {
	
    /**
     * <br>Description: 根据参考坐标系对经纬度坐标进行转换
     * <br>Author:李如意
     * <br>DateTime:2013-4-24 下午03:00:11
     * @param x			经度
     * @param y			纬度
     * @param changetype		参考坐标系
     * @return
     */
    public String changeMe(Double x,Double y,String changetype);
    
}
