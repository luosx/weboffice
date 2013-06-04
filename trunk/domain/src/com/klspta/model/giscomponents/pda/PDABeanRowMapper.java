package com.klspta.model.giscomponents.pda;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

public class PDABeanRowMapper implements RowMapper<PDABean>{
    /**
     * 
     * <br>Description:从结果集中封装PDABean
     * <br>Author:王雷
     * <br>Date:2012-2-7
     * @see org.springframework.jdbc.core.RowMapper#mapRow(java.sql.ResultSet, int)
     */
	@Override
	public PDABean mapRow(ResultSet rs, int arg1) throws SQLException {
		PDABean pdaBean=new PDABean();
		pdaBean.setPDAId(rs.getString("pda_id"));
		pdaBean.setPDAName(rs.getString("pda_name"));
		pdaBean.setPDAType(rs.getString("pda_type"));
		pdaBean.setPDAUnit(rs.getString("pda_unit"));
		pdaBean.setPDAPerson(rs.getString("pda_person"));
		pdaBean.setFlag(rs.getString("flag"));
		pdaBean.setPDAPersonPhone(rs.getString("pda_person_phone"));
		pdaBean.setPDAPhone(rs.getString("pda_phone"));
		pdaBean.setPDACantonCode(rs.getString("pda_cantoncode"));
	    return pdaBean;
	}

}
