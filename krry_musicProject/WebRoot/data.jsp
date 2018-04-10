<%@page import="org.apache.struts2.json.JSONUtil"%>
<%@page import="com.krry.util.UploadMusic"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	HashMap<String, Object> map = UploadMusic.uploadMusic(request, response);
	out.println(JSONUtil.serialize(map));
%>