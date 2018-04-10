package com.krry.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.krry.entity.MVList;
import com.tanzhou.jdbc.util.MJdbcTemplate;
import com.tanzhou.jdbc.util.MRowMapper;

public class MVdao {
static MJdbcTemplate mj = new MJdbcTemplate();
	
	public static List<MVList> getMV(){
		List <MVList> list = mj.queryForList(new MRowMapper<MVList>() {

			@Override
			public MVList mappingRow(ResultSet rs, int row)
					throws SQLException {
				//读取数据库的数据。存进实体类
				MVList ml = new MVList();
				ml.setName(rs.getString("KRRY_MV_NAME"));
				ml.setSrc(rs.getString("KRRY_MV_SRC"));
				ml.setAuthor(rs.getString("KRRY_MV_AUTHOR"));
				ml.setMvId(rs.getInt("KRRY_MV_INDEX"));
				ml.setImg(rs.getString("KRRY_MV_IMG"));
				ml.setAlbum(rs.getString("KRRY_MV_ALBUM"));
				return ml;
			}
			
		}, "SELECT * FROM KRRY_MV", null);
		return list;
	}
	
	public static void main(String[] args) {
		System.out.println(getMV());
	}
}
