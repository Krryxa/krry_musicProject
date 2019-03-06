package com.krry.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.krry.entity.MusicList;
import com.tanzhou.jdbc.util.MJdbcTemplate;
import com.tanzhou.jdbc.util.MRowMapper;

/**
 * 歌曲列表
 * MusicDao
 * @author krry
 * @version 1.0.0
 *
 */
public class MusicDao {
	static MJdbcTemplate mj = new MJdbcTemplate();
	
	/**
	 * 读取数据库音乐数据
	 * com.krry.dao 
	 * 方法名：getMusic
	 * @author krry 
	 * @return List<MusicList>
	 * @exception 
	 * @since  1.0.0
	 */
	public static List<MusicList> getMusic(){
		List <MusicList> list = mj.queryForList(new MRowMapper<MusicList>() {

			@Override
			public MusicList mappingRow(ResultSet rs, int row)
					throws SQLException {
				//读取数据库的数据。存进实体类
				MusicList ml = new MusicList();
				ml.setName(rs.getString("MUSIC_NAME"));
				ml.setSrc(rs.getString("MUSIC_SRC"));
				ml.setAuthor(rs.getString("MUSIC_AUTHOR"));
				ml.setAlbum(rs.getString("MUSIC_ALBUM"));
				ml.setMusicId(rs.getInt("MUSIC_LIST"));
				ml.setTimer(rs.getString("MUSIC_TIMER"));
				
				return ml;
			}
			
		}, "SELECT * FROM KRRY_MUSIC", null);
		return list;
	}
	
	/**
	 * 添加本地歌曲
	 * com.krry.dao 
	 * 方法名：addMusic
	 * @author krry 
	 * @param name
	 * @param src
	 * @param author
	 * @param album
	 * @param timer
	 * @return int
	 * @exception 
	 * @since  1.0.0
	 */
	public static int addMusic(String name,String src,String author,String album,String timer){
		
		String sql = "INSERT INTO KRRY_MUSIC VALUES(?,?,?,?,KRRY_MUSIC_SEQ.Nextval,?)";
		Object[] obj = new Object[]{name,src,author,album,timer};
		int num = mj.executeUpdate(sql, obj);
		
		return num;
	}
	
	/**
	 * 检查上传时音乐文件是否重复，是就返回1，否则返回0
	 * com.krry.dao 
	 * 方法名：searchMusic
	 * @author krry 
	 * @param src
	 * @return int
	 * @exception 
	 * @since  1.0.0
	 */
	public static int searchMusic(String src){
		String sql = "SELECT * FROM KRRY_MUSIC WHERE MUSIC_SRC = ?";
		Object[] obj = new Object[]{src};
		int num = mj.queryForList(sql, obj).size();
		return num;
	}
	
	/**
	 * 根据文件路径(包括文件名和后缀名)删除一条数据
	 * com.krry.dao 
	 * 方法名：deleteFile
	 * @author krry 
	 * @param fileName void
	 * @exception 
	 * @since  1.0.0
	 */
	public static int deleteFile(String fileSrc){
		String sql = "DELETE FROM KRRY_MUSIC WHERE MUSIC_SRC = ?";
		Object[] obj = new Object[]{fileSrc};
		int mun = mj.executeUpdate(sql, obj);
		return mun;
	}
	
}




