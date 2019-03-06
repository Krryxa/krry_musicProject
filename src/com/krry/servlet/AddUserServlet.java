package com.krry.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.krry.dao.MusicDao;
import com.krry.dao.UserDao;
import com.krry.entity.MusicList;
import com.sun.mail.handlers.message_rfc822;

/**
 * 注册新用户
 * AddUserServlet
 * @author krry
 * @version 1.0.0
 *
 */
public class AddUserServlet extends HttpServlet {

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
		
//		String  reg = "^[A-Za-z0-9]{6,15}$"; //验证密码的正则表达式
//		Pattern pattern = Pattern.compile(reg);
//		Matcher matcher = pattern.matcher(password);
		
		//得到受影响的行数
		int num = UserDao.userName(username);
		//这里无需判断，因为在验证.js中，已经用ajax判断了
		//如果用户名重复或者格式不正确是点击不了提交表单的
		//存入数据库
		int usernum = UserDao.addUser(username, password);
		//如果添加成功
		if(usernum>0){
			//把名字放session进作用域 在jsp页面中用${sessionScope.username }获取
			request.getSession().setAttribute("username", username);
			//从数据库获得歌曲列表
			List<MusicList> listMusic = MusicDao.getMusic();
			//将歌曲列表设置进作用域
			request.getSession().setAttribute("ListMusic", listMusic);
			//转发到注册成功界面
			request.getRequestDispatcher("regsuccess.jsp").forward(request, response);
			//out.println("欢迎，"+username);
			//response.sendRedirect("regsuccess.jsp");
		}
	}

}



