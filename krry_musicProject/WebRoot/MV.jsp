<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	String name = request.getParameter("name");
	String src = request.getParameter("src");
	request.setAttribute("Name", name);
	request.setAttribute("Src", src);
	
	if(name == null){
		response.sendRedirect("Krry.jsp");
	}
%>
<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta name="Keywords" content="关键词,关键词">
		<meta name="Description" content="网页描述">
		<link type="text/css" rel="stylesheet" href="css/sg.css"/>
		<title>${requestScope.Name}</title>
		<style type="text/css">
			*{margin:0;padding:0}
			body{background:url("images/back.jpg");background-size:cover;}
			/*top start*/
			.top{height:50px;width:100%;background:#333;}
			.top .t_cen{width:94%;height:50px;margin:0 auto;}
			.top .shou{transition:.6s;color:#C7C7C7;text-decoration:none;line-height:50px;position:absolute;margin-left:180px;font-family:"微软雅黑";}
			.top .shou:hover{color:red;transition:.6s;}
			.top .t_title{color:#fff;font-family:"微软雅黑";font-size:28px;line-height:50px;text-align:center;}
			.top .t_cen .t_left img{position:absolute;margin:3px 0px 0 0;}
			/*end top*/

			.video{width:768px;height:500px;margin:20px auto;position:relative;}
			.video .vi{margin-top:15px;}
			.video .vi_btn{width:100%;height:40px;background:#fff;position:relative;margin-top:-5px;}
			.video .start_dm{width:65px;height:30px;background:#F66;display:block;bottom:5px;right:111px;text-decoration:none;position:absolute;color:#fff;border-radius:4px;transition:.6s;border:0;cursor:pointer;}
			.video .start_dm:hover{background:red;color:#fff;transition:.6s;}
			.video .dm{width:100%;height:86%;position:absolute;top:0;left:0;background:rgba(0,0,0,0.1);display:none;overflow:hidden;margin-top:15px;}
			.video .dm .dm_show{font-size:20px;color:#fff;}
			.video .dm .dm_show div{position:absolute;top:40px;right:0;}
			/*发表区域*/
			.video .send{width:100%;display:none;}
			.video .send .input_text{width:89%;height:40px;padding-left:5px;float:left;border:2px solid #FF6018;}
			.video .send .btn{display:block;text-decoration:none;color:#000;border:none;transition:.6s;width:75px;height:44px;background:#ff6820;float:right;cursor:pointer;}
			.video .send .btn:hover{color:#fff;background:red;transition:.6s;}
			
			::-webkit-scrollbar{width:5px;height:6px;background:#ccc;}
			::-webkit-scrollbar-button{background-color:#333;}
			::-webkit-scrollbar-track{background:#999;}
			::-webkit-scrollbar-track-piece{background:#ccc}
			::-webkit-scrollbar-thumb{background:#666;}
			::-webkit-scrollbar-corner{background:#82AFFF;}
			::-webkit-scrollbar-resizer{background:#FF0BEE;}
			scrollbar{-moz-appearance:none !important;background:rgb(0,255,0) !important;}
			scrollbarbutton{-moz-appearance:none !important;background-color:rgb(0,0,255) !important;}
			scrollbarbutton:hover{-moz-appearance:none !important;background-color:rgb(255,0,0) !important;}
		</style>
	</head>
	<body>
		<!--top start-->
		<div class="top">
			<div class="t_cen">
				<div class="t_left">
					<a href="javascript:void(0);"><img src="images/logo.png" width="82" height="44" alt="Krry"/></a>
					<a href="index.jsp" class="shou">返回Krry首页</a>
					<p class="t_title">${requestScope.Name}</p>
				</div>
			</div>
		</div>
		<!--end top-->
		<div class="video">
			<video class="vi" controls="controls" autoplay="autoplay" width="768">
				<source src="${requestScope.Src}" type="video/mp4"></source>
			</video>
			<!--弹幕开始-->
			<div class="vi_btn">
				<input type="button" class="start_dm" value="开启弹幕"/>
			</div>
			<div class="dm">
				<div class="dm_show"></div>
			</div>
			<!--发送区域-->
			<div class="send">
				<input type="text" class="input_text" value="简直就是屌炸了，帅爆了"/>
				<input type="button" class="btn" value="来一波" />
			</div>
		</div>
		<script src="js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
			$(function(){
				init_screent();
				var flag = true;
				var nowTime = 0;
				$(".start_dm").click(function(){
					if(new Date() - nowTime > 700){
						if(flag){
						   $(".dm").show();
						   $(".start_dm").val("关闭弹幕");
						   $(".send").removeClass("animated rotateOutDownRight");
						   $(".send").show().addClass("animated rotateInDownLeft");
						   flag = false;
						}else{
							$(".dm").hide();
							$(".start_dm").val("开启弹幕");
							$(".send").removeClass("animated rotateInDownLeft");
							$(".send").addClass("animated rotateOutDownRight");
							setTimeout(function(){
								$(".send").hide();
							},1000);
							flag = true;
						}
						nowTime = new Date();
					}
				});
			});
			$(".btn").click(function(){
				var content = $(".input_text").val();
				$(".input_text").val("");
				var _label = $("<div class='animated rotateInUpLeft'>"+content+"</div>");
				$(".dm_show").append(_label);
				init_screent();
			});

			var _top = 0;
			function init_screent(){
				var _this = $(".dm_show").find("div:last");
				var _left = $(".dm").width() - _this.width();
				var _height = $(".dm").height();
				_top = _top + 40;
				if(_top >= _height-50){  //弹幕不会超出视频区域
					_top=0;
				}
				//设置文字位置
				_this.css({left:_left,top:_top,color:getRandomColor()});
				//文字移动
				_this.animate({left:-_this.width()},5000,function(){
					_this.remove();
				});
			}
			//获取随机色
			function getRandomColor(){
				var str = Math.ceil(Math.random()*16777215).toString(16);
				while(str.length<6){
					str = "0"+str;
				}
				return "#"+str;
			}
	</script>
	</body>
</html>
