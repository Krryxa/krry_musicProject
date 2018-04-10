package com.krry.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import com.tanzhou.jdbc.util.MJdbcTemplate;

public class UserDao {
	static MJdbcTemplate mJdbcTemplate = new MJdbcTemplate();
	/**
	 * 
	 * 用户名的验证,数据库有这个名字，就返回1，否则返回0
	 * com.krry.dao 
	 * 方法名：userName
	 * @author krry 
	 * @param name
	 * @return int
	 * @exception 
	 * @since  1.0.0
	 */
	public static int userName(String name){
		String sql = "SELECT * FROM KRRY_USER WHERE MUSIC_EMAILPHONE = ?";
		Object[] obj = new Object[]{name};
		int num = mJdbcTemplate.queryForList(sql, obj).size();
		return num;
	}
	
	/**
	 * 
	 * 注册用户
	 * com.krry.dao 
	 * 方法名：addUser
	 * @author krry 
	 * @param name
	 * @param password
	 * @return int
	 * @exception 
	 * @since  1.0.0
	 */
	public static int addUser(String name,String password){
		String sql = "INSERT INTO KRRY_USER VALUES(null,?,?,?,SEQUSER.Nextval)";
		//格式化时间类型
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowTime = sdf.format(new Date());
		
		Object[] obj = new Object[]{password,name,nowTime};
		int num = mJdbcTemplate.executeUpdate(sql, obj);
		return num;
	}
	
	/**
	 * 检查用户名是否存在
	 * com.krry.dao 
	 * 方法名：findUser
	 * @author krry 
	 * @param name
	 * @return Map<String,Object>
	 * @exception 
	 * @since  1.0.0
	 */
	public static Map<String, Object> findUser(String name){
		Object[] obj = new Object[]{name};
		Map<String,Object> map = mJdbcTemplate.queryForObject("SELECT * FROM KRRY_USER WHERE MUSIC_EMAILPHONE=?", obj);
		return map;
	}

}





