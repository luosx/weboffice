package com.klspta.web.xiamen.device.job;

import java.io.StringReader;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.springframework.jdbc.core.support.AbstractLobCreatingPreparedStatementCallback;
import org.springframework.jdbc.support.lob.LobCreator;
import org.springframework.jdbc.support.lob.LobHandler;

public class InsertToSDE extends AbstractLobCreatingPreparedStatementCallback{
    
    private InsertToSDEBean _bean = null;

    public InsertToSDE(LobHandler lobHandler, InsertToSDEBean bean) {
        super(lobHandler);
        this._bean = bean;
    }

    @Override
    protected void setValues(PreparedStatement ps, LobCreator lobCreator) throws SQLException {
        //create or replace procedure GJSAVE (gps_id in VARCHAR2,gps_y in VARCHAR2,gps_m in VARCHAR2,gps_d in VARCHAR2,
        //gps_h in VARCHAR2,line in clob,srid in integer,xzq in VARCHAR2) is
        //geo sde.st_geometry;
        //begin
        // geo := sde.st_geometry(line,srid);
        //insert into device_track(objectid,gps_id,year,month,day,hour,track_length,xzq,shape) values((select nvl(max(OBJECTID)+1,1) from device_track),gps_id,gps_y,gps_m,gps_d,gps_h,sde.st_length(geo),xzq,geo);
        //end GJSAVE;

        ps.setString(1, _bean.getBh());
        ps.setString(2, _bean.getYear());
        ps.setString(3, _bean.getMonth());
        ps.setString(4, _bean.getDay());
        ps.setString(5, _bean.getHour());
        lobCreator.setClobAsCharacterStream(ps, 6, new StringReader(_bean.getWktString()), _bean.getWktString().getBytes().length);
        ps.setInt(7, _bean.getSrid());
        ps.setString(8, _bean.getXzqString());
        //ps.setTimestamp(9, _bean.getBeginDate());
        //ps.setTimestamp(10, _bean.getEndDate());
    }

}
