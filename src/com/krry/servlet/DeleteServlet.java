package com.krry.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.krry.dao.MusicDao;

public class DeleteServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("html/text;charset=utf-8");
		
		PrintWriter out = response.getWriter();
		//获取要删除文件的路径
		String src = request.getParameter("info");
		int num = MusicDao.deleteFile(src);
		out.println(num);
	}

}
