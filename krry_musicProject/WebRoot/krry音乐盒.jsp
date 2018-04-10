<%@page import="com.krry.dao.MusicDao"%>
<%@page import="com.krry.entity.MusicList"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	//判断是否登录krry账号
	Object obj = request.getSession().getAttribute("username");
	//如果当前页面不存在用户的session，说明还没有登录，则跳转到首页
	if(obj == null){
		response.sendRedirect("Krry.jsp");
	}
	//从数据库获得歌曲列表
	List<MusicList> listMusic = MusicDao.getMusic();
	//将歌曲列表设置进作用域
	request.getSession().setAttribute("ListMusic", listMusic);
%>
<!doctype html>
<html>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="Keywords" content="关键词,关键词">
  <meta name="Description" content="">
  <meta name="viewport" content="width=device-width; initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="css/sg.css" />
  <link rel="stylesheet" href="css/krry音乐系统.css"/>
  <title>krry音乐盒 --krry</title>
  <style type="text/css"></style>
 </head>
 <body>

	<!--top start-->
	<div class="top">
		<div class="t_header">
			<div class="t_logo">
				<a href="#"><img src="images/music_album/logo.png" alt="我的logo" width="103" height="55"/></a>
			</div>
			<a href="index.jsp" class="t_backs">返回首页</a>
			<div class="t_desc">krry音乐盒</div>
		</div>
	</div>

	<!--end top-->
	<div class="content">
		<div class="c_box">

			<!--c_select start-->
			<div class="c_select">
				<div class="c_menu">
					<ul>
						<li class="c_sel">正在播放</li>
						<li>播放历史</li>
						<li>收藏列表</li>
					</ul>
				</div>
				<div class="c_add">
					<span class="c_mymusic">我创建的精选集</span>
					<a href="#" class="c_create"></a>
					<div class="c_title"><img src="images/music_album/01.png" alt="创建选集" width="185" height="89"/></div>
				</div>
			</div>
			<!--end c_select-->

			<!--c_list start-->
			<div class="c_list">
				<div class="c_music">
					<div class="m_title">
						<a href="#" class="m_check">
							<input type="checkbox"/>
						</a>
						<div class="m_info">
							<div class="m_t">歌曲<span>(30)</span></div>
							<div class="m_t">演唱者</div>
							<div class="m_t">专辑</div>
						</div>
					</div>
					<div class="m_song">
						<c:forEach items="${sessionScope.ListMusic}" var="music">
							<div class="s_list" title="${music.name}" data-src="${music.src}">
								<p class="l_choose">
									<input type="checkbox"/>
								</p>
								<div class="s_push">
									<p class="l_number"><span>${music.musicId}</span></p>
									<div class="l_info">
										<div class="l_t">${music.name}</div>
										<div class="l_t">${music.author}</div>
										<div class="l_t">《<span>${music.album}</span>》</div>
									</div>
								</div>
								<div class="l_love">
									<a href="#" class="l_icon l_like"></a>
									<a href="#" class="l_icon l_more"></a>
									<a href="#" class="l_icon l_del"></a>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<!--end c_list-->

			<!--c_lrc start-->
			<div class="c_lrc">
				<div class="l_img">
					<img src="images/music_album/123.jpg" width="175" height="175" alt="专辑图片"/>
				</div>
				<a href="#">亲亲我^_^</a>
				<div class="l_con">
					<ul id="lyrics">
						<li style="line-height:255px;height:255px;text-align:center;font-weight:bold;font-size:18px;color:#ce2062;">krry音乐，发现心之美</li>
					</ul>
				</div>
			</div>
			<!--end c_lrc-->
		</div>
		<div class="clear"></div>
	</div>
	<!--end content-->

	<!--c_player start-->
	<div class="c_player">
		<!--p_left start-->
		<div class="p_left">
			<a href="#" class="p_icon p_pre" title="上一首"></a>
			<a href="#" class="p_icon p_play" title="播放"></a>
			<a href="#" class="p_icon p_stop" title="暂停"></a>
			<a href="#" class="p_icon p_next" title="下一首"></a>
			<div class="p_tool">
				<a href="#" class="t_t t_list" title="列表循环"></a>
				<a href="#" class="t_t t_single" title="单曲循环"></a>
				<a href="#" class="t_t t_random" title="随机播放"></a>
			</div>
		</div>
		<!--end p_left-->

		<!--p_content start-->
		<div class="p_content">
			<div class="c_name">
				<a href="#" class="n_title">krry音乐&nbsp;发现心之美</a>
				<div class="n_group">
					<a href="#" class="g_g g_fav"></a>
					<a href="#" class="g_g g_share"></a>
					<a href="#" class="g_g g_more"></a>
				</div>
			</div>
			<div class="c_time">
				<div class="t_left">00:00</div>
				<div class="t_center">
					<div class="c_played"></div>
					<div class="c_futrue">
						<div class="c_current"></div>
					</div>
				</div>
				<div class="t_right">00:00</div>
			</div>
		</div>
		<!--end p_content-->

		<!--p_right start-->
		<div class="p_right">
			<a href="#" class="r_que">高品质</a>
			<div class="r_voice">
				<a href="#" class="v_trumpet voice"></a>
				<a href="#" class="v_trumpet quite"></a>
				<div class="t_box">
					<div class="b_ball">
						<div class="a_small"></div>
						<div class="a_big">
							<div class="a_current"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--end p_right-->
	</div>
	<!--end c_player-->
	<audio id="audio"></audio>

	<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
	<script src="js/sg.js"></script>
	<script src="js/sgutil.js"></script>
	<script src="js/krry音乐系统.js"></script>
	<script src="js/点击删除歌曲文件.js"></script>
 </body>
</html>

