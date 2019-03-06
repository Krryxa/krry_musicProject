package com.krry.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.krry.entity.MusicList;
import com.krry.entity.SingleList;
import com.tanzhou.jdbc.util.MJdbcTemplate;
import com.tanzhou.jdbc.util.MRowMapper;

/**
 * 我的歌单里的歌曲
 * ListDao
 * @author krry
 * @version 1.0.0
 *
 */
public class ListDao {
static MJdbcTemplate mj = new MJdbcTemplate();
	
	public static List<SingleList> getSingle(){
		List <SingleList> list = mj.queryForList(new MRowMapper<SingleList>() {

			@Override
			public SingleList mappingRow(ResultSet rs, int row)
					throws SQLException {
				//读取数据库的数据。存进实体类
				SingleList ml = new SingleList();
				ml.setName(rs.getString("LIST_NAME"));
				ml.setSrc(rs.getString("LIST_SRC"));
				ml.setAuthor(rs.getString("LIST_AUTHOR"));
				ml.setAlbum(rs.getString("LIST_ALBUM"));
				ml.setMusicId(rs.getInt("LIST_ID"));
				ml.setTimer(rs.getString("LIST_TIMER"));
				ml.setImg(rs.getString("LIST_IMG"));
				
				return ml;
			}
			
		}, "SELECT * FROM MUSIC_LIST", null);
		return list;
	}
	
	public static void main(String[] args) {
		System.out.println(getSingle());
	}
}
