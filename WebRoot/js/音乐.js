//player
	$(".p_packup").click(function(){
		var width = $(".player").width() - 22;
		var left = $(".player").offset().left;
		var n = 1;
		if(left < 0){
			n = 0;
			$(this).removeClass("p_packdown").addClass("p_packme");
		}
		$(".player").animate({left:-width*n},500,function(){
			if(n == 0){
				$(this).find(".p_packup").removeClass("p_packdown").removeClass("p_packme");
			} else{
				$(this).find(".p_packup").addClass("p_packdown");

			}
		});
		$(".playcontain").animate({
			left:-width*n
		},500);
	});

	$(".b_list").click(function(){
		$(".playcontain").animate({
			height:"462"
		},400);
		$(".list").animate({
			bottom:"115"
		},400);
	});
	$(".p_down").click(function(){
		$(".list").animate({
			bottom:"-232"
		},400);
		$(".playcontain").animate({
			height:"115"
		},400);
	});

	$(".con_song").mousemove(function(){
		$(this).find(".t_hidden").show();
	}).mouseleave(function(){
		$(this).find(".t_hidden").hide();
	});

	$(".t_hidden").click(function(){
		return false; //阻止冒泡
	});
	$(".t_dele").click(function(){
		return false; //阻止冒泡
	});

	//点击歌词按钮
	var lrcLrc = true;
	var nowTime = 0;
	$(".b_lrc").click(function(){
		if(new Date() - nowTime > 700){
			nowTime = new Date();
			if(lrcLrc){
				$(".l_con").removeClass("animated rollOut").show().addClass("animated rollIn");
				lrcLrc = false;
			}else{
				$(".l_con").removeClass("animated rollIn").addClass("animated rollOut");
				setTimeout(function(){
					$(".l_con").hide();
				},700);
				lrcLrc = true;
			}
		}
	});

	//点击歌词屏幕的×
	$(".con_close").click(function(){
		$(".l_con").removeClass("animated rollIn").addClass("animated rollOut");
		setTimeout(function(){
			$(".l_con").hide();
		},700);
		lrcLrc = true;
	});

	//直接创建播放器，不用写<audio>标签
	var audioDom = document.createElement("audio");
	//设置音乐播放地址
	//audioDom.src="mp3/卓依婷 - 亲爱的你.mp3";
	/*audioDom.autoplay="autoplay";设置自动播放*/
	//设置初始音量
	audioDom.volume = 0.5;

	//获得音乐播放列表
	var children = $(".l_list").children();
	//获得音乐列表长度
	var musiclen = children.length;
	//定义音乐列表,(存储音乐播放地址)
	var musicArr = [];
	//定义数组下标
	var playIndex = -1;
	//做一把锁，控制装载最后一行歌词
	var lrcClose = true;

	children.each(function(){
		musicArr.push($(this).data("src"));//把音乐地址push到音乐列表中
	}).on("click",function(){
		playIndex = $(this).index();//获得当前点击的下标，取得音乐播放地址
		//赋值给播放地址
		audioDom.src = musicArr[playIndex];
		playMusic(playIndex);
	});

	//播放音乐的方法
	function playMusic(playIndex){
		//播放
		audioDom.play();
		//添加歌曲选中效果
		children.eq(playIndex).find(".m_sel").addClass("selected").parent().siblings().find(".m_sel").removeClass("selected");
		//播放按钮隐藏，暂停按钮显示
		$(".b_play").hide();
		$(".b_stop").show();
		//获取并设置这首歌的名字
		setCurrentTitle(playIndex);
		//设置这首歌的专辑图片
		setImg(playIndex);
		//加载歌词
		getLrc(playIndex);

		lrcClose = true; //解锁，装载最后一行歌词
	}

	//设置当前音乐的标题
	function setCurrentTitle(playIndex){
		//获取当前音乐的地址
		var musicSrc = musicArr[playIndex];
		//分割"/" 获得["mp3","亲爱的你 - 卓依婷.mp3"]
		var musicTitleArr = musicSrc.split("/");
		//取下标为1的音乐title(亲爱的你 - 卓依婷.mp3)
		var musicTitle = musicTitleArr[1];
		//第二次分割"." 获得["亲爱的你 - 卓依婷","mp3"]
		var musicNameArr = musicTitle.split(".");
		//取下标为0的歌曲title(亲爱的你 - 卓依婷)
		var musicName = musicNameArr[0];
		//设置当前播放音乐的title
		$(".p_name").text(musicName);
		$(".con_title").text(musicName);
		return musicName;
	}
	//设置这首歌的专辑图片
	function setImg(imgIndex){
		//获得歌手卓依婷
		var al = children.eq(imgIndex).find(".author").text();
		$(".p_pic img").attr("src","images/播放列表歌手图片/"+al+".jpg");
		$(".l_con img").attr("src","images/播放列表歌手图片/"+al+".jpg");
	}
	//获取并设置这首歌的歌词
	function getLrc(srcIndex){
		//var lrc = $("#lrc_"+srcIndex).val();
		var MusicTitle = setCurrentTitle(srcIndex); //获取歌曲标题
		$.ajax({  //异步请求获取本地歌词
			url:"lrc/"+MusicTitle+".lrc",
			type:"post",
			error:function(req,msg){
				$("#lyrics").html("");
				$("#lyrics").html("<li " +
			"style='line-height:255px;height:255px;text-align:center;" +
			"font-size:18px;color:#FB2727;font-weight:bold;'>" +
			"暂无歌词，敬请期待"+
			"</li>");
			},
			success:function(data){
				//第一次分离歌词
				var lrcArr = data.split("[");
				//存放分离后的歌词
				var html = "";
				var lrclast = null; //记录上一行的歌词
				var lrcmes = null; //记录当前行的歌词
				var bofo = -1; //记录上一行歌词的秒数
				var ms = -1; //当前这一行的秒数
				for(var i = 0;i < lrcArr.length;i++){
					//第二次分割歌词，变成["03:01.08","这个世界变得更加美丽"],数组以逗号分隔
					var arr = lrcArr[i].split("]");
					//取到数组arr下标为1的歌词部分
					//将上一行的歌词赋值给lrclast
					lrclast = lrcmes; 
					//得到当前歌词
					lrcmes = arr[1];
					//取到时间
					var time = arr[0].split("."); //变成["03:01","08"]
					//取到time下标为0的分钟和秒
					var ctime = time[0].split(":"); //变成["03","01"];
					//将上一行的秒数赋值给bofo
					bofo = ms;
					//转化成秒数
					ms = ctime[0]*60 + ctime[1]*1;
					//如果上一行和当前行秒数相同，则当前行秒数++ ,解决秒数相同的办法
					if(bofo == ms){
						ms++;
					}else if(ms >= 0){
						if(!isNaN(bofo)){ //如果是数字
							var classeName = "l_"+bofo;
							var concon = bofo;//bofo会自增，所以下面for循环条件用这个变量来代替
							for(var j = 0;j < ms-concon-1;j++){
								classeName += " l_"+ ++bofo;
							}
							if(ms>=0 && lrclast != null){
								html += "<li class='"+classeName+"'>"+lrclast+"</li>";
							}
						}
					}
				}
				//装载最后一行歌词的机制，先获取歌曲总时间
				setTimeout(function(){
					var allall = audioDom.duration;
					var classlaName = "l_"+ms;
					var conben = ms; //ms会自增，所以下面for循环条件必须用这个变量来代替
					for(var j = 0;j < allall-conben-1;j++){
						classlaName += " l_"+ ++ms;
					}
					html += "<li class='"+classlaName+"'>"+lrcmes+"</li>";
					//把解析好的歌词放入歌词展示区中
					$("#lyrics").html(html);
				},200);	
			}
		});
	}
	//播放器已经开始播放音乐的事件
	audioDom.oncanplay = allTimer;
	function allTimer(){
		//获取音乐文件总时间
		ALLtime = audioDom.duration;
		//格式化时间
		var ftime = formartTime(ALLtime);
		//设置这个时间 //这首歌的总时间
		$(".c_time .t_right .tt_right").text(ftime);
	}

	$(".b_play").on("click",function(){
		//判断有没有登录
		if($(".krryName").text()){
			if(playIndex == -1){
				playIndex = 0;  //当一开始点击播放按钮，则默认播放第一首歌
				//赋值给播放地址
				audioDom.src = musicArr[playIndex];
			}
			playMusic(playIndex);
		}else{
			$.tmDialog.alert({title:"Krry的温馨提醒",content:"请您先登录Krry账号"});
		}
	});

	$(".b_stop").on("click",function(){
		stopMusic();
	});

	function stopMusic(){
		audioDom.pause();
		$(".b_play").show();
		$(".b_stop").hide();
		children.removeClass("selected");
	}

	$(".b_next").on("click",function(){
		if($(".krryName").text()){
			//边界判断
			playIndex = (playIndex == (musiclen-1) ? 0 : ++playIndex);
			//赋值给播放地址
			audioDom.src = musicArr[playIndex];
			//播放
			playMusic(playIndex);
		}else{
			$.tmDialog.alert({title:"Krry的温馨提醒",content:"请您先登录Krry账号"});
		}
	});

	$(".b_pre").on("click",function(){
		if($(".krryName").text()){
			//边界判断
			playIndex = (playIndex == 0 ? 0 : --playIndex);
			if(playIndex < 0)
				playIndex = 0;
			//赋值给播放地址
			audioDom.src = musicArr[playIndex];
			//播放
			playMusic(playIndex);
		}else{
			$.tmDialog.alert({title:"Krry的温馨提醒",content:"请您先登录Krry账号"});
		}
	});

	// 联动音乐播放歌词
	audioDom.addEventListener("timeupdate",function(){
		//获取当前播放时间,获得的是秒数
		var time = this.currentTime;
		//解析音乐对应的时间
		var m = parseInt(time / 60);//获取此时的分钟
		var s = parseInt(time); //转换int类型，获取此时的秒数
		$(".l_"+s).addClass("sel").siblings().removeClass("sel");
		//歌词滚动条，使歌词在中间的计算公式：
		//第n行歌词*li的高度-歌词区域中间的li（包括这个li）以上的li的总高度
		$("#lyrics").stop().animate({
			scrollTop:(($(".sel").index()+1)*24 - 168)//减去168的偏差，使当前歌词在中间
		},240);
	});
	
	//点击和拖动改变进度条
	$(".t_center").mousedown(function(e){
		//获取点击的位置
		var _this = $(this);
		//获取起点位置
		var left = _this.offset().left;
		//获取进度条总宽度
		var maxWidth = _this.width();

		/*这是点击改变进度条*/
		//获取鼠标点击位置
		var x1 = e.clientX || e.pageX;
		//获取当前的进度
		var width1 = x1 - left;
		// 根据点击位置除以最大的位置得到百分比
		var percent1 = (width1 / maxWidth)*100;
		if(percent1 < 0) percent1 = 0;
		if(percent1 > 100) percent1 = 100;
		//根据进度条赋值
		$(".c_played").width(percent1+"%");
		$(".c_current").css("left",percent1+"%");
		// 点击进度条的进度百分比 同步 音乐文件当前播放的时间的百分比
		audioDom.currentTime = audioDom.duration * (width1 / maxWidth);

		$(document).mousemove(function(e){//点击后移动的时候
			/*这是点击后拖动改变进度条*/
			//暂停滚动歌词
			LrcCoo = false;
			//获取鼠标点击位置
			var x = e.clientX || e.pageX;
			//获取当前的进度
			var width = x - left;
			// 根据点击位置除以最大的位置得到百分比
			var percent = (width / maxWidth)*100;
			if(percent < 0) percent = 0;
			if(percent > 100) percent = 100;
			//根据进度条赋值
			$(".c_played").width(percent+"%");
			$(".c_current").css("left",percent+"%");
			// 点击进度条的进度百分比 同步 音乐文件当前播放的时间的百分比
			audioDom.currentTime = audioDom.duration * (width / maxWidth);
		}).mouseup(function(){//当鼠标弹起的时候，取消绑定这几个事件
			$(document).unbind("mousemove");
			$(document).unbind("mouseup");
			LrcCoo = true; //开启滚动歌词
		});
		
	});

	//单击和拖动控制音量
	$(".b_ball").mousedown(function(e){
		$(".quite").hide();
		$(".voice").show();
		//获取点击的位置
		var _this = $(this);
		//获取起点x轴坐标
		var begin = _this.offset().left;
		//获取音量条总宽度
		var fin = _this.width();
		//获取当前音量的宽度

		/*这是点击改变音量*/
		//获取鼠标点击的x轴坐标
		var x1 = e.clientX || e.pageX;
		var width1 = x1 - begin;
		// 判断边界
		if(width1 < 0) width1 = 0;
		if(width1 > fin) width1 = fin; //总长度fin
		$(".a_small").width(width1 + "px");
		$(".a_current").css("left",width1 + "px");
		//根据当前音量条赋值
		audioDom.volume = width1 / fin;//[0-1]之间
		
		$(document).mousemove(function(e){//点击后移动的时候
			//获取鼠标点击的x轴坐标
			var x = e.clientX || e.pageX;
			var width = x - begin;
			// 判断边界
			if(width < 0) width = 0;
			if(width > fin) width = fin; //总长度fin
			$(".a_small").width(width + "px");
			$(".a_current").css("left",width + "px");
			//根据当前音量条赋值
			audioDom.volume = width / fin;//[0-1]之间
		}).mouseup(function(){ //当鼠标弹起的时候，取消绑定这几个事件
			$(document).unbind("mousemove");
			$(document).unbind("mouseup");
		});
	});

	var currentVolume = 0;   //储存当前的音量，为恢复音量做准备
	var currentWidth = 0;  //储存当前音量条的长度
	//点击音量图标设置静音
	$(".b_voice").mousedown(function(){
		$(".b_muit").show();
		$(".b_voice").hide();
		currentVolume = audioDom.volume;//储存当前的音量，为恢复音量做准备
		currentWidth = $(".a_small").width();  //储存当前音量条的长度
		//设置音量条长度为0
		$(".a_small").width(0 + "px");
		$(".a_current").css("left",0 + "px");
		audioDom.volume = 0;
	});

	//点击音量图标恢复原来音量
	$(".b_muit").mousedown(function(){
		$(".b_voice").show();
		$(".b_muit").hide();
		//恢复之前音量条长度
		$(".a_small").width(currentWidth + "px");
		$(".a_current").css("left",currentWidth + "px");
		audioDom.volume = currentVolume;//恢复当前音量
	});

	audioDom.ontimeupdate = function(){
		//获取总时长
		var time = this.duration;
		//获取播放时长
		var stime = this.currentTime;
		//格式化时间
		var ftime = formartTime(stime);
		//赋值给左侧当前播放时间
		$(".tt_left").text(ftime);
		//获取播放进度
		var scurrent = stime / time;
		//转换成百分比
		var percent = scurrent * 100;
		//根据歌曲进度赋值
		$(".c_played").width(percent+"%");
		$(".c_current").css("left",percent+"%");
	};
	
	//定义格式化日期的函数
	function formartTime(time){
		var m = Math.floor(time / 60); //获取分钟数
		var s = Math.floor(time % 60); //获取秒数
		return (m < 10 ? "0"+m : m) + ":" + (s < 10 ? "0"+s : s);
	}

	//音乐播放结束
	audioDom.onended = function(){
		$(".b_next").trigger("click"); //自动点击下一首
	};
	
	//点击歌单里的歌曲的时候
	$(".e_musiclist a").click(function(){
		if($(".krryName").text()){
			var musicsrc = $(this).data("src");
			var musicauthor = $(this).find(".c_author").text();
			var musicAlbum = $(this).find(".hide_album").text();
			var musicname = $(this).find(".c_muscititle").text();
			var musictimer = $(this).find(".hide_timer").text();
			//循环遍历查看播放列表有没有刚点击的歌曲
			var lenn = musicArr.length;//用一个临时变量代替，防止下面出错
			for(var i = 0;i < lenn;i++){
				if(musicArr[i] === musicsrc){ //如果播放列表有，则直接播放
					playIndex = i;
					audioDom.src = musicArr[playIndex];
					playMusic(playIndex);
					break;
				}
				if(i == musicArr.length - 1 && musicArr[i] != musicsrc){ //如果播放列表找不到，就追加
					$(".l_list").append("<div class='con_song' data-src='"+musicsrc+"'>"+
						"<a href='javascript:void(0);' class='musictitle m_sel'>"+musicname+"</a>"+
						"<p class='author m_sel'>"+musicauthor+"</p>"+
						"<p class='album_single'>"+musicAlbum+"</p>"+
						"<div class='t_hidden'>"+
							"<span class='t_love' title='我的最爱'></span>"+
							"<span class='t_share' title='分享'></span>"+
							"<span class='t_down' title='下载'></span>"+
						"</div>"+
						"<p class='timermusic'>"+musictimer+"</p>"+
						"<span class='t_dele' title='删除'></span>"+
					"</div>");
					
					loading("歌曲 "+musicname+" 已添加到播放列表",5);
					
					//添加音乐到列表后要刷新一些内容
					children = $(".l_list").children();
					//重新定义音乐列表长度
					musiclen = children.length;
					musicArr.push(musicsrc);
					playIndex = musiclen-1;
					//赋值给播放地址
					audioDom.src = musicArr[playIndex];
					playMusic(playIndex);
					
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
			}
		}else{
			$.tmDialog.alert({title:"Krry的温馨提醒",content:"请您先登录Krry账号"});
		}
		
	});
	
	//点击添加本地歌曲的时候
	$("#p_native").click(function(){
		if(!$(".krryName").text()){
			$.tmDialog.alert({title:"Krry的温馨提醒",content:"请您先登录Krry账号"});
		}
	});
	
	
	
	
	
	
	