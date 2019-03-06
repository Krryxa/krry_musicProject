if($(".krryName").text()){
	$.tmUpload({
		btnId:"p_native",
		url:"/krry_musicProject/data.jsp",
		limitSize:"1000 MB",
		fileTypes:"*.mp3;*.wma;*.aac;",
		multiple : true,
		callback:function(serverData,file){
			var jsonData = eval("("+serverData+")");//eval函数里面必须是个小括号，能把String类型转变成json对象

			$(".l_list").append("<div class='con_song' data-src='"+jsonData.src+"'>"+
									"<a href='javascript:void(0);' class='musictitle m_sel'>"+jsonData.name+"</a>"+
									"<p class='author m_sel'>"+jsonData.author+"</p>"+
									"<p class='album_single'>"+jsonData.album+"</p>"+
									"<div class='t_hidden'>"+
										"<span class='t_love' title='我的最爱'></span>"+
										"<span class='t_share' title='分享'></span>"+
										"<span class='t_down' title='下载'></span>"+
									"</div>"+
									"<p class='timermusic'>"+jsonData.timer+"</p>"+
									"<span class='t_dele' title='删除'></span>"+
								"</div>");
			//添加音乐到列表后要刷新一些内容
			children = $(".l_list").children();
			//重新定义音乐列表长度
			musiclen = children.length;
			//将音乐播放地址push进数组
			musicArr.push(jsonData.src);
			//设置点击事件
			$(".l_list .con_song:last").click(function(){
				playIndex = $(this).index();
				audioDom.src = musicArr[playIndex];
				playMusic(playIndex);
			});
		
			//重新监听鼠标移入移出歌曲列表事件
			$(".con_song").mousemove(function(){
				$(this).find(".t_hidden").show();
			}).mouseleave(function(){
				$(this).find(".t_hidden").hide();
			});
		}
	});
}