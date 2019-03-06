package com.krry.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.krry.dao.MusicDao;
import com.krry.dao.UserDao;
import com.krry.entity.MusicList;

public class LoginServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//设置编码一定要最先设置
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		//查找用户是否存在
		Map<String, Object> map = UserDao.findUser(username);
		//这里无需判断用户是否存在，因为在验证.js中已经设置了，如果用户名格式正确且存在此用户名，才会进来这个sevlet
//		if(map != null){
			//判断密码
			if(map.get("MUSIC_PASSWORD").equals(password)){
				//把用户名设进session作用域
				request.getSession().setAttribute("username", username);
				//从数据库获得歌曲列表
				List<MusicList> listMusic = MusicDao.getMusic();
				//将歌曲列表设置进作用域
				request.getSession().setAttribute("ListMusic", listMusic);
			}else{
				out.println(1);
			}
//		}else{
//			out.println(2);
//		}
	}

}







