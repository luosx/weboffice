package com.klspta.base;

import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.jbpm.api.ProcessEngine;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.AbstractLobCreatingPreparedStatementCallback;
import org.springframework.jdbc.support.lob.DefaultLobHandler;
import org.springframework.jdbc.support.lob.LobCreator;
import org.springframework.jdbc.support.lob.LobHandler;
import org.springframework.stereotype.Component;

/**
 * 
 * <br>
 * Title:REST入口三层框架之一，用于提供数据库连接 <br>
 * Description:TODO 类功能描述 <br>
 * Author:王瑛博 <br>
 * Date:2011-5-3
 */
@Component
public abstract class AbstractDataBaseSupport extends BaseLogSupport {

    public static final String GIS = "GISTemplate";

    public static final String YW = "YWTemplate";

    public static final String SDE = "SDETemplate";

    public static final String CORE = "CORETemplate";

    public static final String KQ = "KQTemplate";

    public static final String PHJG = "PHJGTemplate";

    public static final String GTZF = "GTZFTemplate";

    public static final String ZFCF = "ZFCFTemplate";

    public static final String WORKFLOW = "WORKFLOWTemplate";

    // 济南正元数据
    public static final String GTJC = "GTJCTemplate";

    public static final String DTJG = "DTJGTemplate";

    // OA
    public static final String OA = "OATemplate";

    private JdbcTemplate opTemplate = null;

    /**
     * 
     * <br>
     * Description:查找指定的数据连接 <br>
     * Author:王瑛博 <br>
     * Date:2011-5-3
     * 
     * @param type
     * @return
     */
    public JdbcTemplate findTemplate(String type) {
        JdbcTemplate jt = (JdbcTemplate) ContextHelper.getContext().getBean(type);
        return jt;
    }

    public ProcessEngine getProcessEngine() {
        ProcessEngine jt = (ProcessEngine) ContextHelper.getContext().getBean("processEngine");
        return jt;
    }

    public List<Map<String, Object>> query(String sql, String type) {
        opTemplate = findTemplate(type);
        return opTemplate.queryForList(sql);
    }

    public List<Map<String, Object>> query(String sql, String type, Object[] args) {
        opTemplate = findTemplate(type);
        return opTemplate.queryForList(sql, args);
    }

    public List<Object> query(String sql, String type, Object[] args, RowMapper<Object> r) {
        opTemplate = findTemplate(type);
        return opTemplate.query(sql, args, r);
    }

    public int update(String sql, String type) {
        if (!checkDeleteSQL(sql)) {
            return -1;
        }
        opTemplate = findTemplate(type);
        return opTemplate.update(sql);
    }

    public int update(String sql, String type, Object[] args) {
        if (!checkDeleteSQL(sql)) {
            return -1;
        }
        opTemplate = findTemplate(type);
        return opTemplate.update(sql, args);
    }

    public void updateBlob(String sql, String type, final InputStream inputstream) {
        final LobHandler lobHandler = new DefaultLobHandler();
        opTemplate = findTemplate(type);
        opTemplate.execute(sql, new AbstractLobCreatingPreparedStatementCallback(lobHandler) {
            @Override
            protected void setValues(PreparedStatement ps, LobCreator lobCreator) throws SQLException {
                try {
                    lobCreator.setClobAsAsciiStream(ps, 3, inputstream, inputstream.available());
                    lobCreator.setClobAsAsciiStream(ps, 4, inputstream, inputstream.available());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        });
    }

    public void insertBlob(String sql, String type, String guid, String srid, String textClob) {
        //final String clob=textClob;
        final String yw_guid = guid;
        final String sde_srid = srid;
        final StringReader sr = new StringReader(textClob);
        final int length = textClob.getBytes().length;
        final LobHandler lobHandler = new DefaultLobHandler();
        opTemplate = findTemplate(type);
        opTemplate.execute(sql, new AbstractLobCreatingPreparedStatementCallback(lobHandler) {
            @Override
            protected void setValues(PreparedStatement ps, LobCreator lobCreator) throws SQLException {
                ps.setString(1, yw_guid);
                lobCreator.setClobAsCharacterStream(ps, 2, sr, length);
                ps.setString(3, sde_srid);
            }
        });
        sr.close();
    }

    
    /**
     * 
     * <br>Description:外业图层上图
     * <br>Author:陈强峰
     * <br>Date:2014-3-8
     * @param sql
     * @param type
     * @param args
     * @param objectId
     * @param srid
     * @param textClob
     */
    public void insertBlobForWyxc(String sql, String type, String[] args, String objectId, String srid,
            String textClob) {
        final String[] fieldsValue = args;
        final String objId = objectId;
        final String sde_srid = srid;
        final StringReader sr = new StringReader(textClob);
        final int length = textClob.getBytes().length;
        final LobHandler lobHandler = new DefaultLobHandler();
        opTemplate = findTemplate(type);
        opTemplate.execute(sql, new AbstractLobCreatingPreparedStatementCallback(lobHandler) {
            @Override
            protected void setValues(PreparedStatement ps, LobCreator lobCreator) throws SQLException {
                ps.setString(1, fieldsValue[0]);
                ps.setString(2, fieldsValue[1]);
                ps.setString(3, fieldsValue[2]);
                ps.setString(4, fieldsValue[3]);
                ps.setString(5, fieldsValue[4]);
                ps.setString(6, fieldsValue[5]);
                ps.setString(7, objId);
                lobCreator.setClobAsCharacterStream(ps,8, sr, length);
                ps.setString(9, sde_srid);
            }
        });
        sr.close();
    }

    private boolean checkDeleteSQL(String sql) {
        if (sql.toUpperCase().indexOf("DELETE") >= 0) {
            if (sql.indexOf("where") < 0) {
                Exception e = new Exception("没有where条件的sql语句 ! ==>   " + sql);
                e.printStackTrace();
                return false;
            } else {
                return true;
            }
        } else {
            return true;
        }
    }
}

final class ContextHelper {
    private static FileSystemXmlApplicationContext _ctx;
    static {
        _ctx = new FileSystemXmlApplicationContext("file:"
                + Thread.currentThread().getContextClassLoader().getResource("").getPath()
                + "com/klspta/base/datasource/ApplicationContext-jdbc.xml");
    }

    private ContextHelper() {
    }

    public static FileSystemXmlApplicationContext getContext() {
        return _ctx;
    }
}
