<%@page import="com.krry.dao.MusicDao"%>
<%@page import="com.krry.entity.MusicList"%>
<%@page import="com.krry.dao.MVdao"%>
<%@page import="com.krry.entity.MVList"%>
<%@page import="com.krry.dao.ListDao"%>
<%@page import="com.krry.entity.SingleList"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	Object obj = request.getSession().getAttribute("username");
	//如果当前页面的存在用户的session，说明还没有退出登录，则从数据库重新刷新歌曲信息
	if(obj != null){
		List<MusicList> listMusic = MusicDao.getMusic();	
		request.getSession().setAttribute("ListMusic", listMusic);
	}else{  //防止未登录的时候就出现歌曲列表(可能出现的差错，比如在另外点击了音乐盒)
		request.getSession().removeAttribute("ListMusic");
	}

	List<SingleList> Listlist = ListDao.getSingle();
	List<MVList> mvList = MVdao.getMV();
	
	request.setAttribute("mvlist", mvList);
	request.setAttribute("List", Listlist);
%>
<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta name="Keywords" content="关键词,关键词">
		<meta name="Description" content="网页描述">
		<link rel="stylesheet" href="css/animate.css"/>
		<link rel="stylesheet" type="text/css" href="css/sg.css" />
		<link type="text/css" rel="stylesheet" href="js/sg/css/sg.css" />
		<link rel="stylesheet" href="js/upload/upload.css"/>
		<link rel="stylesheet" href="css/Krry.css"/>
		<title>Krry音乐</title>
		<style type="text/css">
			
		</style>
	</head>
	<body>
		<!--top start-->
		<div class="top">
			<div class="t_cen">
				<div class="t_left">
					<a href="Krry.jsp"><img src="images/logo.png" width="82" height="44" alt="Krry"/></a>
					<ul>
						<li><a href="index.jsp">首页</a></li>
						<li class="t_li"></li>
						<li><a href="javascript:void(0);">做我的女主角</a></li>
						<li class="t_li"></li>
						<li><a href="javascript:void(0);">更多</a></li>
					</ul>
				</div>
				<div class="t_right">
					<ul>
						<li class="Nameuser">欢迎，<a href="javascript:void(0);" class="krryName">${sessionScope.username }</a></li>
						<li><a href="javascript:void(0);" class="krrylogin" onclick="loginres('log');">登录</a></li>
						<li><a href="javascript:void(0);" class="krryexit" onclick="">退出</a></li>
						<li class="t_li"></li>
						<li><a href="javascript:void(0);" class="krryres" onclick="loginres('register');">注册</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!--end top-->

		<!--LoginRegister start-->
		<div class="LoginRegister">
			<!--登录-->
			<div class="login" id="log">
				<div class="box">
					<div class="title" id="title">
						<a href="javascript:void(0)" class="Close"></a>
					</div>
					<div class="l_login">
						<h3>Krry账号登录</h3>
						<span>用户名：</span>
						<input type="text" class="loginUser" onblur="prove1(this,true);" placeholder="邮箱/手机号" name="username"/><p class="nameDesc"></p>
						<span>密码：</span>
						<input type="password" class="loginPass" onblur="prove2(this);" placeholder="密码" name="password"/><p class="passDesc"></p>
						<input type="button" value="登&nbsp;&nbsp;&nbsp;&nbsp;录" class="sub sub_login"/>
						<a href="javascript:void(0);" class="l_set">没有Krry账号?点击注册</a>
					</div>
					<div class="moreLogin">
						使用社会化帐号登录：
						<a href="javascript:void(0);" class="sinA"></a>
						<a href="javascript:void(0);" class="tenCent"></a>
						<a href="javascript:void(0);" class="weiXin"></a>
					</div>
				</div>
			</div>
			<!--注册-->
			<div class="login" id="register" style="display:none;">
				<div class="box">
					<div class="title" id="title">
						<a href="javascript:void(0)" class="Close"></a>
					</div>
					<form action="AddUserServlet" method="post">
						<div class="l_login">
							<h3>Krry账号注册</h3>
							<span>用户名：</span>
							<input type="text" class="ResUser" onblur="prove1(this,false);" placeholder="邮箱/手机号" name="username"/><p class="nameDesc"></p>
							<span>密码：</span>
							<input type="password" class="ResPass" onblur="prove2(this);" placeholder="密码长度6~16" name="password"/><p class="passDesc"></p>
							<input type="button" value="注&nbsp;&nbsp;&nbsp;&nbsp;册" class="sub sub_res"/>
							<input type="submit" id="res_submit" style="display:none;"/>
							<a href="javascript:void(0);" class="l_set">已有Krry账号?点击登录</a>
						</div>
					</form>
					<div class="moreLogin">
						使用社会化帐号登录：
						<a href="javascript:void(0);" class="sinA"></a>
						<a href="javascript:void(0);" class="tenCent"></a>
						<a href="javascript:void(0);" class="weiXin"></a>
					</div>
				</div>
			</div>
		</div>
		<!--end LoginRegister-->

		<!--playcontain start-->
		<div class="playcontain">
			<div class="player">
				<div class="p_pic">
					<img src="images/播放列表歌手图片/123.jpg" alt="k" width="90" height="90" />
					<p class="p_krry">KRRY音乐</p>
				</div>
				<p class="p_name">发现心之美</p>
				<div class="p_list">
					<a href="javascript:void(0);" class="b_set"></a>
					<a href="javascript:void(0);" class="b_list"></a>
					<a href="javascript:void(0);" class="b_lrc"></a>
				</div>
				<!--控制按钮-->
				<div class="p_btn">
					<a href="javascript:void(0);" class="b_pre"></a>
					<a href="javascript:void(0);" class="b_play"></a>
					<a href="javascript:void(0);" class="b_stop"></a>
					<a href="javascript:void(0);" class="b_next"></a>
					<a href="javascript:void(0);" class="b_voice"></a>
					<a href="javascript:void(0);" class="b_muit"></a>
					<!--音量控制-->
					<div class="b_ball">
						<div class="a_small"></div>
						<div class="a_big">
							<div class="a_current"></div>
						</div>
					</div>
				</div>
				<!--进度条控制-->
				<div class="c_time">
					<div class="t_right"><span class="tt_left">00:00</span><span>/</span><span class="tt_right">00:00</span></div>
					<div class="t_center">
						<div class="c_played"></div>
						<div class="c_futrue">
							<div class="c_current"></div>
						</div>
					</div>
				</div>
				<div class="p_packup"></div>
			</div>
			<!--播放列表-->
			<div class="list">
				<div class="l_top">
					<p>播放列表</p>
					<a href="javascript:void(0);" id="p_native" title="添加本地歌曲"></a>
					<div class="p_down"></div>
					<a href="javascript:void(0);" class="p_clear">清空列表</a>
				</div>
				<div class="l_list">
					<c:forEach items="${sessionScope.ListMusic}" var="music">
						<div class="con_song" data-src="${music.src}">
							<a href="javascript:void(0);" class="musictitle m_sel">${music.name}</a>
							<p class="author m_sel">${music.author}</p>
							<p class="album_single">${music.album}</p>
							<div class="t_hidden">
								<span class="t_love" title="我的最爱"></span>
								<span class="t_share" title="分享"></span>
								<span class="t_down" title="下载"></span>
							</div>
							<p class="timermusic">${music.timer}</p>
							<span class="t_dele" title="删除"></span>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<!--end playcontain-->

		<!--l_con start-->
		<div class="l_con">
			<span class="con_close">×</span>
			<img src="images/播放列表歌手图片/123.jpg" width="200" height="200" alt="专辑"/>
			<p class="con_title">Krry-世界的美，只因有你 </p>
			<ul id="lyrics">
				<li style="line-height:255px;height:255px;text-align:center;font-size:18px;color:#FB2727;font-weight:bold;">Krry音乐，发现心之美</li>
			</ul>
		</div>
		<!--end l_con-->

		<!--navtop start-->
		<div class="navtop">
			<div class="n_cen">
				<div class="c_logo">
					<img src="images/mulogo.png"/>
				</div>
				<div class="c_cen">
					<a href="javascript:void(0);">音乐流</a>
					<a href="javascript:void(0);"><span>MV</span></a>
					<a href="javascript:void(0);">我的收藏</a>
					<a href="javascript:void(0);" class="krrymusic"><span>Krry</span>音乐盒</a>
				</div>
				<div class="c_inp">
					<input type="text" placeholder="找到好音乐"/>
					<a class="sub" href="javascript:void(0);"></a>
				</div>
			</div>
		</div>
		<!--end navtop-->

		<!--container start-->
		<div class="container">
			<!--Banner-->
			<div class="c_banner">
				<div class="boxBan">
					<ul>
						<li class="l1"><a href="javascript:void(0);"><img src="images/Banner/1.jpg"/></a></li>
						<li class="l2"><a href="javascript:void(0);"><img src="images/Banner/2.jpg"/></a></li>
						<li class="l3"><a href="javascript:void(0);"><img src="images/Banner/3.jpg"/></a></li>
						<li><a href="javascript:void(0);"><img src="images/Banner/4.jpg"/></a></li>
						<li><a href="javascript:void(0);"><img src="images/Banner/5.jpg"/></a></li>
						<li><a href="javascript:void(0);"><img src="images/Banner/6.jpg"/></a></li>
						<li><a href="javascript:void(0);"><img src="images/Banner/7.jpg"/></a></li>
						<li><a href="javascript:void(0);"><img src="images/Banner/8.jpg"/></a></li>
						<li class="l9"><a href="javascript:void(0);"><img src="images/Banner/9.jpg"/></a></li>
						<li class="l10"><a href="javascript:void(0);"><img src="images/Banner/10.jpg"/></a></li>
					</ul>
				</div>
				<div class="ear">
					<a href="javascript:void(0);" class="left"></a>
					<a href="javascript:void(0);" class="right"></a>
				</div>
			</div>
			<!--con_left start-->
			<div class="con_left">
				<!--我的歌单-->
				<div class="c_online">
					<div class="con_Toptitle">
						<p class="e_title e_online"></p>
						<a class="e_more" href="javascript:void(0);"></a>
						<div class="m_right">
							<div class="rr_r r_left">&lt;</div>
							<div class="rr_r r_right">&gt;</div>
						</div>
					</div>
					<div class="e_musiclist">
						<ul>
							<c:forEach items="${requestScope.List}" var="list">
								<li>
									<a href="javascript:void(0);" data-src="${list.src}">
										<img src="${list.img}" width="145" height="145"/>
										<div class="t_hiden_msg">
											<p class="hide_album">${list.album}</p>
											<p class="hide_timer">${list.timer}</p>
										</div>
										<div class="tt_back">
											<div class="t_desc">
												<p class="c_muscititle">${list.name}</p>
												<p class="c_author">${list.author}</p>
											</div>
										</div>
										<div class="tt_play t_muplay"><img src="images/cover_play.png" width="40";height="40";/></div>
									</a>
								</li>
							</c:forEach>
						</ul>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
				<!--MV热播-->
				<div class="MV">
					<div class="con_Toptitle">
						<p class="e_title e_MV"></p>
						<a class="e_more" href="javascript:void(0);"></a>
					</div>
					<div class="m_mvlist">
						<ul>
							<c:forEach items="${requestScope.mvlist}" var="mv">
								<li data-src="${mv.src}">
									<a href="javascript:void(0);" class="mv_a">
										<img src="${mv.img}" width="180" height="140"/>
										<div class="tt_play t_MVpl"><img src="images/cover_play.png" width="50";height="50";/></div>
										<div class="mv_back"></div>
									</a>
									<a href="javascript:void(0);" class="mv_musicTitle mv_a">${mv.name}<span> - ${mv.author}</span></a>
									<p class="mv_al">${mv.album}</p>
								</li>
							</c:forEach>
						</ul>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
				<!--推荐-->
				<div class="new_hot">
					<!--最新推荐-->
					<div class="hot_left">
						<div class="con_Toptitle">
							<div class="titnewhot">
								<p class="new_title e_newhot"></p>
							</div>
							<div class="new_play">
								<a href="javascript:void(0);" class="p_auto"></a>
								<a href="javascript:void(0);" class="p_add"></a>
							</div>
							<div class="new_list">
								<ul>
									<li><a href="javascript:void(0);" class="new_sel">华语</a><span>|</span></li>
									<li><a href="javascript:void(0);">韩语</a><span>|</span></li>
									<li><a href="javascript:void(0);">欧美</a></li>
								</ul>
							</div>
						</div>
						<div class="l_contain r_dinfin">
							<ul class="chinese">
								<li><a href="javascript:void(0);">我的光芒《非童小可》 <span>-童可可</span></a></li>
								<li><a href="javascript:void(0);">小光芒《小光芒》 <span>-童可可</span></a></li>
								<li><a href="javascript:void(0);">醉西楼《醉西楼》 <span>-魏新雨</span></a></li>
								<li><a href="javascript:void(0);">红衣《红衣》 <span>-魏新雨</span></a></li>
								<li><a href="javascript:void(0);">恋人心《恋人心》 <span>-魏新雨</span></a></li>
								<li><a href="javascript:void(0);">2016最新单曲--愿《愿》 <span>-魏新雨</span></a></li>
								<li><a href="javascript:void(0);">亲爱的你《亲爱的你》 <span>-卓依婷</span></a></li>
								<li><a href="javascript:void(0);">我只在乎你《我只在乎你》 <span>-邓丽君</span></a></li>
								<li><a href="javascript:void(0);">萌萌哒《白砂糖女孩》 <span>-童可可</span></a></li>
								<li><a href="javascript:void(0);">漫步人生路《漫步人生路》 <span>-邓丽君</span></a></li>
								<li><a href="javascript:void(0);">多莉宝贝《多莉宝贝》 <span>-童可可</span></a></li>
								<li><a href="javascript:void(0);">现代爱情故事《现代爱情故事》 <span>-张智霖、许秋怡</span></a></li>
							</ul>
							<ul class="hanyu" style="display:none;">
								<li><a href="javascript:void(0);">韩语歌《韩语歌-----*》 <span>-韩语歌星</span></a></li>
								<li><a href="javascript:void(0);">韩语歌《韩语歌-----*》 <span>-韩语歌星</span></a></li>
								<li><a href="javascript:void(0);">韩语歌《韩语歌-----*》 <span>-韩语歌星</span></a></li>
								<li><a href="javascript:void(0);">韩语歌《韩语歌-----*》 <span>-韩语歌星</span></a></li>
								<li><a href="javascript:void(0);">韩语歌《韩语歌-----*》 <span>-韩语歌星</span></a></li>
								<li><a href="javascript:void(0);">韩语歌《韩语歌-----*》 <span>-韩语歌星</span></a></li>
								<li><a href="javascript:void(0);">韩语歌《韩语歌-----*》 <span>-韩语歌星</span></a></li>
								<li><a href="javascript:void(0);">韩语歌《韩语歌-----*》 <span>-韩语歌星</span></a></li>
								<li><a href="javascript:void(0);">韩语歌《韩语歌-----*》 <span>-韩语歌星</span></a></li>
								<li><a href="javascript:void(0);">韩语歌《韩语歌-----*》 <span>-韩语歌星</span></a></li>
								<li><a href="javascript:void(0);">韩语歌《韩语歌-----*》 <span>-韩语歌星</span></a></li>
								<li><a href="javascript:void(0);">韩语歌《韩语歌-----*》 <span>-韩语歌星</span></a></li>
							</ul>
							<ul class="english" style="display:none;">
								<li><a href="javascript:void(0);">I could be the one <span>-gril</span></a></li>
								<li><a href="javascript:void(0);">pretty boy <span>-M2M</span></a></li>
								<li><a href="javascript:void(0);">Shining Friends <span>-2R</span></a></li>
								<li><a href="javascript:void(0);">I could be the one <span>-gril</span></a></li>
								<li><a href="javascript:void(0);">pretty boy <span>-M2M</span></a></li>
								<li><a href="javascript:void(0);">Shining Friends <span>-2R</span></a></li>
								<li><a href="javascript:void(0);">I could be the one <span>-gril</span></a></li>
								<li><a href="javascript:void(0);">pretty boy <span>-M2M</span></a></li>
								<li><a href="javascript:void(0);">Shining Friends <span>-2R</span></a></li>
								<li><a href="javascript:void(0);">I could be the one <span>-gril</span></a></li>
								<li><a href="javascript:void(0);">pretty boy <span>-M2M</span></a></li>
								<li><a href="javascript:void(0);">Shining Friends <span>-2R</span></a></li>
							</ul>
						</div>
					</div>
					<!--最热推荐-->
					<div class="hot_right">
						<div class="con_Toptitle">
							<div class="titnewhot">
								<p class="new_title e_newgive"></p>
							</div>
							<div class="new_play">
								<a href="javascript:void(0);" class="p_auto"></a>
								<a href="javascript:void(0);" class="p_add"></a>
							</div>
						</div>
						<div class="r_contain">
							<div class="l_contain" style="padding-top:10px;">
								<ul>
									<li><a href="javascript:void(0);">我的光芒《非童小可》 <span>-童可可</span></a></li>
									<li><a href="javascript:void(0);">眼泪之作《非童小可》 <span>-童可可</span></a></li>
									<li><a href="javascript:void(0);">小光芒《小光芒》 <span>-童可可</span></a></li>
									<li><a href="javascript:void(0);">醉西楼《醉西楼》 <span>-魏新雨</span></a></li>
									<li><a href="javascript:void(0);">红衣《红衣》 <span>-魏新雨</span></a></li>
									<li><a href="javascript:void(0);">恋人心《恋人心》 <span>-魏新雨</span></a></li>
									<li><a href="javascript:void(0);">2016最新单曲--愿《愿》 <span>-魏新雨</span></a></li>
									<li><a href="javascript:void(0);">亲爱的你《亲爱的你》 <span>-卓依婷</span></a></li>
									<li><a href="javascript:void(0);">我只在乎你《我只在乎你》 <span>-邓丽君</span></a></li>
									<li><a href="javascript:void(0);">萌萌哒《白砂糖女孩》 <span>-童可可</span></a></li>
									<li><a href="javascript:void(0);">漫步人生路《漫步人生路》 <span>-邓丽君</span></a></li>
									<li><a href="javascript:void(0);">多莉宝贝《多莉宝贝》 <span>-童可可</span></a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
				<!--精选集-->
				<div class="senior">
					<div class="con_Toptitle">
						<div class="titnewhot s_whot">
							<p class="new_title e_senior"></p>
						</div>
					</div>
					<div class="s_contain">
						<ul>
							<li style="margin-left:0;">
								<div class="s_3d">
									<div class="s_img">
										<a href="javascript:void(0);"><img src="images/精选集/4.jpg" width="289" height="314"/></a>
									</div>
									<div class="s_font">
										<div class="t_confont">
											<p>那年夏天</p><p>相遇的缘分</p>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="s_3d">
									<div class="s_img">
										<a href="javascript:void(0);"><img src="images/精选集/1.jpg" width="150" height="150"/></a>
									</div>
									<div class="s_font">
										<div class="t_confont">
											<p>周氏中国风</p><p>天涯过客</p>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="s_3d">
									<div class="s_img">
										<a href="javascript:void(0);"><img src="images/精选集/2.jpg" width="150" height="150"/></a>
									</div>
									<div class="s_font">
										<div class="t_confont">
											<p>那年夏天</p><p>相遇的缘分</p>
										</div>
									</div>
								</div>
							</li>
							<li style="margin-right:0;">
								<div class="s_3d">
									<div class="s_img">
										<a href="javascript:void(0);"><img src="images/精选集/3.jpg" width="150" height="150"/></a>
									</div>
									<div class="s_font">
										<div class="t_confont">
											<p>那年夏天</p><p>相遇的缘分</p>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="s_3d">
									<div class="s_img">
										<a href="javascript:void(0);"><img src="images/精选集/5.jpg" width="150" height="150"/></a>
									</div>
									<div class="s_font">
										<div class="t_confont">
											<p>那年夏天</p><p>相遇的缘分</p>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="s_3d">
									<div class="s_img">
										<a href="javascript:void(0);"><img src="images/精选集/6.jpg" width="150" height="150"/></a>
									</div>
									<div class="s_font">
										<div class="t_confont">
											<p>那年夏天</p><p>相遇的缘分</p>
										</div>
									</div>
								</div>
							</li>
							<li style="margin-right:0;">
								<div class="s_3d">
									<div class="s_img">
										<a href="javascript:void(0);"><img src="images/精选集/7.jpg" width="150" height="150"/></a>
									</div>
									<div class="s_font">
										<div class="t_confont">
											<p>那年夏天</p><p>相遇的缘分</p>
										</div>
									</div>
								</div>
							</li>
						</ul>
						<div class="clear"></div>
					</div>
				</div>
			</div>
			<!--end con_left-->
			<!--con_right start-->
			<div class="con_right">
				<div class="r_topto">
					<div class="real_top"></div>
					<div class="new_play">
						<a href="javascript:void(0);" class="p_auto"></a>
						<a href="javascript:void(0);" class="p_add"></a>
					</div>
					<div class="clear"></div>
				</div>
				<!--Banner-->
				<div class="Banner">
					<ul></ul>
					<div class="btn">
						<a href="javascript:void(0);" class="selll">1</a>
						<a href="javascript:void(0);">2</a>
						<a href="javascript:void(0);">3</a>
						<a href="javascript:void(0);">4</a>
					</div>
				</div>
				<!--流行指数-->
				<div class="stream">
					<div class="navv_star">
						<p class="s_descc">流行指数</p>
						<div class="desc_list">
							<ul>
								<li><a href="javascript:void(0)" class="sellr">内地</a><span>|</span></li>
								<li><a href="javascript:void(0)">港台</a><span>|</span></li>
								<li><a href="javascript:void(0)">欧美</a><span>|</span></li>
								<li><a href="javascript:void(0)">韩国</a></li>
							</ul>
						</div>
						<div class="clear"></div>
					</div>
					<div class="s_listtram">
						<ul class="str_chinese">
							<li>
								<span>01</span>
								<a href="javascript:void(0)" class="l_musictt">醉西楼</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
							<li>
								<span>02</span>
								<a href="javascript:void(0)" class="l_musictt">现代爱情故事</a>
								<a href="javascript:void(0)" class="l_authorr">张智霖、许秋怡</a>
							</li>
							<li>
								<span>03</span>
								<a href="javascript:void(0)" class="l_musictt">天涯过客</a>
								<a href="javascript:void(0)" class="l_authorr">周杰伦</a>
							</li>
							<li>
								<span>04</span>
								<a href="javascript:void(0)" class="l_musictt">kiss the rain</a>
								<a href="javascript:void(0)" class="l_authorr">哎哟~~</a>
							</li>
							<li>
								<span>05</span>
								<a href="javascript:void(0)" class="l_musictt">夏天的风</a>
								<a href="javascript:void(0)" class="l_authorr">温岚</a>
							</li>
							<li>
								<span>06</span>
								<a href="javascript:void(0)" class="l_musictt">多莉宝贝</a>
								<a href="javascript:void(0)" class="l_authorr">童可可</a>
							</li>
							<li>
								<span>07</span>
								<a href="javascript:void(0)" class="l_musictt">小光芒</a>
								<a href="javascript:void(0)" class="l_authorr">童可可</a>
							</li>
							<li>
								<span>08</span>
								<a href="javascript:void(0)" class="l_musictt">我的光芒</a>
								<a href="javascript:void(0)" class="l_authorr">童可可</a>
							</li>
							<li>
								<span>09</span>
								<a href="javascript:void(0)" class="l_musictt">红衣</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
							<li>
								<span>10</span>
								<a href="javascript:void(0)" class="l_musictt">最美中国</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
							<li>
								<span>11</span>
								<a href="javascript:void(0)" class="l_musictt">书画中国</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
							<li>
								<span>12</span>
								<a href="javascript:void(0)" class="l_musictt">恋人心</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
						</ul>
						<ul class="str_winae">
							<li>
								<span>01</span>
								<a href="javascript:void(0)" class="l_musictt">现代爱情故事</a>
								<a href="javascript:void(0)" class="l_authorr">张智霖、许秋怡</a>
							</li>
							<li>
								<span>02</span>
								<a href="javascript:void(0)" class="l_musictt">现代爱情故事</a>
								<a href="javascript:void(0)" class="l_authorr">张智霖、许秋怡</a>
							</li>
							<li>
								<span>03</span>
								<a href="javascript:void(0)" class="l_musictt">可惜我是水瓶座</a>
								<a href="javascript:void(0)" class="l_authorr">杨千嬅</a>
							</li>
							<li>
								<span>04</span>
								<a href="javascript:void(0)" class="l_musictt">现代爱情故事</a>
								<a href="javascript:void(0)" class="l_authorr">张智霖、许秋怡</a>
							</li>
							<li>
								<span>05</span>
								<a href="javascript:void(0)" class="l_musictt">逝去日子</a>
								<a href="javascript:void(0)" class="l_authorr">黄家驹</a>
							</li>
							<li>
								<span>06</span>
								<a href="javascript:void(0)" class="l_musictt">现代爱情故事</a>
								<a href="javascript:void(0)" class="l_authorr">张智霖、许秋怡</a>
							</li>
							<li>
								<span>07</span>
								<a href="javascript:void(0)" class="l_musictt">现代爱情故事</a>
								<a href="javascript:void(0)" class="l_authorr">张智霖、许秋怡</a>
							</li>
							<li>
								<span>08</span>
								<a href="javascript:void(0)" class="l_musictt">现代爱情故事</a>
								<a href="javascript:void(0)" class="l_authorr">张智霖、许秋怡</a>
							</li>
							<li>
								<span>09</span>
								<a href="javascript:void(0)" class="l_musictt">红衣</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
							<li>
								<span>10</span>
								<a href="javascript:void(0)" class="l_musictt">最美中国</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
							<li>
								<span>11</span>
								<a href="javascript:void(0)" class="l_musictt">书画中国</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
							<li>
								<span>12</span>
								<a href="javascript:void(0)" class="l_musictt">恋人心</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
						</ul>
						<ul class="str_oumei">
							<li>
								<span>01</span>
								<a href="javascript:void(0)" class="l_musictt">jeck</a>
								<a href="javascript:void(0)" class="l_authorr">mencignev krry</a>
							</li>
							<li>
								<span>02</span>
								<a href="javascript:void(0)" class="l_musictt">jeck</a>
								<a href="javascript:void(0)" class="l_authorr">mencignev krry</a>
							</li>
							<li>
								<span>03</span>
								<a href="javascript:void(0)" class="l_musictt">jeck</a>
								<a href="javascript:void(0)" class="l_authorr">mencignev krry</a>
							</li>
							<li>
								<span>04</span>
								<a href="javascript:void(0)" class="l_musictt">who let the dog out</a>
								<a href="javascript:void(0)" class="l_authorr">krry</a>
							</li>
							<li>
								<span>05</span>
								<a href="javascript:void(0)" class="l_musictt">夏天的风</a>
								<a href="javascript:void(0)" class="l_authorr">温岚</a>
							</li>
							<li>
								<span>06</span>
								<a href="javascript:void(0)" class="l_musictt">多莉宝贝</a>
								<a href="javascript:void(0)" class="l_authorr">童可可</a>
							</li>
							<li>
								<span>07</span>
								<a href="javascript:void(0)" class="l_musictt">小光芒</a>
								<a href="javascript:void(0)" class="l_authorr">童可可</a>
							</li>
							<li>
								<span>08</span>
								<a href="javascript:void(0)" class="l_musictt">我的光芒</a>
								<a href="javascript:void(0)" class="l_authorr">童可可</a>
							</li>
							<li>
								<span>09</span>
								<a href="javascript:void(0)" class="l_musictt">红衣</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
							<li>
								<span>10</span>
								<a href="javascript:void(0)" class="l_musictt">最美中国</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
							<li>
								<span>11</span>
								<a href="javascript:void(0)" class="l_musictt">书画中国</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
							<li>
								<span>12</span>
								<a href="javascript:void(0)" class="l_musictt">恋人心</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
						</ul>
						<ul class="str_hanuo">
							<li>
								<span>01</span>
								<a href="javascript:void(0)" class="l_musictt">韩语的歌</a>
								<a href="javascript:void(0)" class="l_authorr">Hanukkah</a>
							</li>
							<li>
								<span>02</span>
								<a href="javascript:void(0)" class="l_musictt">韩语的歌</a>
								<a href="javascript:void(0)" class="l_authorr">Hanukkah</a>
							</li>
							<li>
								<span>03</span>
								<a href="javascript:void(0)" class="l_musictt">韩语的歌</a>
								<a href="javascript:void(0)" class="l_authorr">Hanukkah</a>
							</li>
							<li>
								<span>04</span>
								<a href="javascript:void(0)" class="l_musictt">韩语的歌</a>
								<a href="javascript:void(0)" class="l_authorr">Hanukkah</a>
							</li>
							<li>
								<span>05</span>
								<a href="javascript:void(0)" class="l_musictt">韩语的歌</a>
								<a href="javascript:void(0)" class="l_authorr">Hanukkah</a>
							</li>
							<li>
								<span>06</span>
								<a href="javascript:void(0)" class="l_musictt">韩语的歌</a>
								<a href="javascript:void(0)" class="l_authorr">Hanukkah</a>
							</li>
							<li>
								<span>07</span>
								<a href="javascript:void(0)" class="l_musictt">韩语的歌</a>
								<a href="javascript:void(0)" class="l_authorr">Hanukkah</a>
							</li>
							<li>
								<span>08</span>
								<a href="javascript:void(0)" class="l_musictt">韩语的歌</a>
								<a href="javascript:void(0)" class="l_authorr">Hanukkah</a>
							</li>
							<li>
								<span>09</span>
								<a href="javascript:void(0)" class="l_musictt">韩语的歌</a>
								<a href="javascript:void(0)" class="l_authorr">Hanukkah</a>
							</li>
							<li>
								<span>10</span>
								<a href="javascript:void(0)" class="l_musictt">韩语的歌</a>
								<a href="javascript:void(0)" class="l_authorr">Hanukkah</a>
							</li>
							<li>
								<span>11</span>
								<a href="javascript:void(0)" class="l_musictt">韩语的歌</a>
								<a href="javascript:void(0)" class="l_authorr">Hanukkah</a>
							</li>
							<li>
								<span>12</span>
								<a href="javascript:void(0)" class="l_musictt">恋人心</a>
								<a href="javascript:void(0)" class="l_authorr">魏新雨</a>
							</li>
						</ul>
					</div>
				</div>
				<!--榜-->
				<div class="bang">
					<ul>
						<li><a href="javascript:void(0)">iTunes榜</a></li>
						<li><a href="javascript:void(0)">美国公告牌</a></li>
						<li><a href="javascript:void(0)">英国UK榜</a></li>
						<li><a href="javascript:void(0)">香港新城榜</a></li>
						<li><a href="javascript:void(0)">日本公信榜</a></li>
						<li><a href="javascript:void(0)">韩国MNET</a></li>
						<li><a href="javascript:void(0)">Krry世界榜</a></li>
						<li><a href="javascript:void(0)">香港电台榜</a></li>
						<li><a href="javascript:void(0)">MTV光荣</a></li>
					</ul>
					<div class="clear"></div>
				</div>
				<!--热门歌手-->
				<div class="hot_singer">
					<div class="r_topto">
						<div class="real_top sin-top"></div>
						<a href="javascript:void(0)" class="sin_more"></a>
						<div class="clear"></div>
					</div>
					<ul>
						<li style="margin-left:0;">
							<a href="javascript:void(0)">
								<img src="images/热门歌手/卓依婷.jpg" width="86" height="86"/>
							</a>
							<p class="sin_desc">卓依婷</p>
						</li>
						<li>
							<a href="javascript:void(0)">
								<img src="images/热门歌手/魏新雨.jpg" width="86" height="86"/>
							</a>
							<p class="sin_desc">魏新雨</p>
						</li>
						<li>
							<a href="javascript:void(0)">
								<img src="images/热门歌手/邓丽君.jpg" width="86" height="86"/>
							</a>
							<p class="sin_desc">邓丽君</p>
						</li>
						<li style="margin-left:0;">
							<a href="javascript:void(0)">
								<img src="images/热门歌手/温岚.jpg" width="86" height="86"/>
							</a>
							<p class="sin_desc">温岚</p>
						</li>
						<li>
							<a href="javascript:void(0)">
								<img src="images/热门歌手/krry.jpg" width="86" height="86"/>
							</a>
							<p class="sin_desc">krry</p>
						</li>
						<li>
							<a href="javascript:void(0)">
								<img src="images/热门歌手/玲.jpg" width="86" height="86"/>
							</a>
							<p class="sin_desc">玲</p>
						</li>
						<div class="clear"></div>
					</ul>
					<div class="more_single">
						<a href="javascript:void(0)">华语男歌手</a>
						<a href="javascript:void(0)">华语女歌手</a>
						<a href="javascript:void(0)">华语组合</a>
						<a href="javascript:void(0)">欧美歌手</a>
						<a href="javascript:void(0)">KRRY歌手</a>
						<a href="javascript:void(0)">台湾歌手</a>
						<div class="clear"></div>
					</div>
				</div>
				<!--精彩活动-->
				<div class="createacti">
					<div class="r_topto">
						<div class="real_top crea-top"></div>
						<a href="javascript:void(0)" class="crea_more"></a>
						<div class="clear"></div>
					</div>
					<div class="crea_one crea_img">
						<a href="javascript:void(0)"><img src="images/精彩活动/1.jpg"/></a>
						<span class="crea_desc">这是一场精彩的活动</span>
					</div>
					<div class="crea_sen crea_img">
						<a href="javascript:void(0)"><img src="images/精彩活动/2.jpg"/></a>
						<span class="crea_desc">这是一场精彩的活动</span>
					</div>
				</div>
			</div>
			<!--end con_right-->
			<div class="clear"></div>
		</div>
		<!--end container-->
		<!--foot start-->
		<div class="foot">
			联系电话：13420112408
		</div>
		<!--end foot-->

		<script src="js/jquery-1.11.3.min.js"></script>
		<script src="js/sg.js"></script>
		<script src="js/sgutil.js"></script>
		<script src="js/登录注册窗口.js"></script>
		<script src="js/验证.js"></script>
		<script src="js/进入音乐盒.js"></script>
		<script src="js/搜索框.js"></script>
		<script src="js/音乐.js"></script>
		<script src="js/upload/tz_upload.js"></script>
		<script src="js/sg/tz_util.js"></script>
		<script src="js/sg/sg.js"></script>
		<script src="js/MV热播.js"></script>
		<script src="js/Banner.js"></script>
		<script src="js/我的歌单.js"></script>
		<script src="js/最新推荐.js"></script>
		<script src="js/小Banner.js"></script>
		<script src="js/流行指数.js"></script>
		<script src="js/上传歌曲文件.js"></script>
		<script src="js/点击删除歌曲文件.js"></script>
		<script type="text/javascript">
			/*open:left/top/slide/other/fade*/
			if(!$(".krryName").text()){
				$.tzAlert({content:"已完成的模块：<br/><br/>登录&注册<br/>点击进入Krry音乐盒<br/>默认音乐列表播放<br/>歌词联动<br/>上传本地音乐<br/>删除音乐<br/>模块：我的歌单<br/>模块：MV热播(视频弹幕)<br/><br/>所有功能需要注册登录后方可使用<br/>谢谢您的谅解，<br/>祝您生活愉快！",title:"Krry的温馨提示",callback:function(ok){
					loading("欢迎进入Krry音乐官网~~~",5);		
				}});
			}
			$(".tzui-dialog").css("top","90px");
		</script>
		
	</body>
</html>
