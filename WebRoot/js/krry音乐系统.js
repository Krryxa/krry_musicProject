
	//全选
	var m_check = document.getElementsByClassName("m_check");
	var checkff = m_check[0].getElementsByTagName("input");
	var msong = document.getElementsByClassName("m_song");
	var check = msong[0].getElementsByTagName("input");
	$(".m_check input").click(function(){
		if(checkff[0].checked){ //如果选中，则全部选中
			for(var i = 0;i < $(".m_song .s_list").length;i++){
				check[i].checked = true;
			}
		}else{  
			for(var i = 0;i < $(".m_song .s_list").length;i++){
				check[i].checked = false;
			}
		}
	});

	sizeSong();
	$(window).resize(sizeSong);
	function sizeSong(){
		$(".content .c_box .c_list .c_music .m_song").height($(window).height()-190);
		$(".content .c_box .c_lrc .l_con").height($(window).height()-380);
	}

	//也可以直接创建播放器，不用写上面的<audio>标签
	//var audioDom = document.createElement("audio");
	var audioDom = document.getElementById("audio");
	//设置音乐播放地址
	//audioDom.src="mp3/卓依婷 - 亲爱的你.mp3";
	/*audioDom.autoplay="autoplay";设置自动播放*/
	//设置初始音量
	audioDom.volume = 0.5;

	//获得音乐播放列表
	var children = $(".m_song").children();
	//获得音乐列表长度
	var len = children.length;
	//定义音乐列表,(存储音乐播放地址)
	var musicArr = [];
	//定义数组下标
	var playIndex = -1;
	//做一把锁，控制装载最后一行歌词
	var lrcClose = true;

	children.each(function(){
		musicArr.push($(this).data("src"));//把音乐地址push到音乐列表中
	}).find(".s_push").on("click",function(){
		playIndex = $(this).parent().index();//获得当前点击的下标，取得音乐播放地址
		audioDom.src = musicArr[playIndex]; //取得这首歌的地址复制给音乐播放器的地址属性
		playMusic(playIndex);
	});

	//播放音乐的方法
	function playMusic(playIndex){
		//播放
		audioDom.play();
		//添加歌曲选中效果
		children.eq(playIndex).addClass("selected").siblings().removeClass("selected");
		//播放按钮隐藏，暂停按钮显示
		$(".p_play").hide();
		$(".p_stop").show();
		//设置当前歌曲前面有gif图，同时删除其他歌曲的gif图
		children.eq(playIndex).find(".l_number span").addClass("n_num").parents(".s_list").siblings().find(".l_number span").removeClass("n_num");
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
		$(".n_title").text(musicName);
		return musicName;
	}
	//设置这首歌的专辑图片
	function setImg(imgIndex){
		//获得专辑《亲爱的你》
		var al = children.eq(imgIndex).find(".l_info").find(".l_t").eq(2).text();
		//以“《”分割，获得["","亲爱的你》"]
		var alArr = al.split("《");
		//第二次以1为下标,以“》”分割，获得["亲爱的你","》"]
		var buarr = alArr[1].split("》");
		//取下标为0的专辑名称“亲爱的你”
		var album = buarr[0];
		$(".l_img img").attr("src","images/music_album/"+album+".jpg");
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
			"style='line-height:261px;height:261px;text-align:center;" +
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
					}
					if(ms >= 0){
						if(!isNaN(bofo)){ //如果是数字
							var classeName = "l_"+bofo;
							var concon = bofo;//bofo会自增，所以下面for循环条件用这个变量来代替
							for(var j = 0;j < ms-concon-1;j++){
								classeName += " l_"+ ++bofo;
							}
							if(lrclast.indexOf("\r")==0 || lrclast.indexOf("\r")==1 || lrclast=="\n"){
								html += "<li class='"+classeName+"' style='height:29px;'>"+lrclast+"</li>";
							}else{
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
		$(".t_right").text(ftime);
	}

	$(".p_play").on("click",function(){
		if(playIndex == -1){
			playIndex = 0;  //当一开始点击播放按钮，则默认播放第一首歌
			audioDom.src = musicArr[playIndex];
		}
		playMusic(playIndex);
	});

	$(".p_stop").on("click",function(){
		stopMusic();
	});

	function stopMusic(){
		audioDom.pause();
		$(".p_play").show();
		$(".p_stop").hide();
		children.removeClass("selected");
		children.eq(playIndex).find(".l_number span").removeClass("n_num");
	}

	$(".p_next").on("click",function(){
		//边界判断
		playIndex = (playIndex == (len-1) ? 0 : ++playIndex);
		//赋值给播放地址
		audioDom.src = musicArr[playIndex];
		//播放
		playMusic(playIndex);
	});

	$(".p_pre").on("click",function(){
		//边界判断
		playIndex = (playIndex == (0) ? 0 : --playIndex);
		//赋值给播放地址
		audioDom.src = musicArr[playIndex];
		//播放
		playMusic(playIndex);
	});

	// 联动音乐播放歌词
	audioDom.addEventListener("timeupdate",function(){
		//获取当前播放时间,获得的是秒数
		var time = this.currentTime;
		//解析音乐对应的时间
		var m = parseInt(time / 60);//获取此时的分钟
		var s = parseInt(time); //转换int类型，获取此时的秒数
		$(".l_"+s).addClass("sel").siblings().removeClass("sel");
		var heipix = $(".content .c_box .c_lrc .l_con").height()/2+29/2;
		$(".l_con").stop().animate({
			scrollTop:(($(".sel").index()+1)*29 - heipix)//减去偏差，使当前歌词在中间
		},200);
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
	$(".voice").mousedown(function(){
		$(".quite").show();
		$(".voice").hide();
		currentVolume = audioDom.volume;//储存当前的音量，为恢复音量做准备
		currentWidth = $(".a_small").width();  //储存当前音量条的长度
		//设置音量条长度为0
		$(".a_small").width(0 + "px");
		$(".a_current").css("left",0 + "px");
		audioDom.volume = 0;
	});

	//点击音量图标恢复原来音量
	$(".quite").mousedown(function(){
		$(".voice").show();
		$(".quite").hide();
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
		$(".t_left").text(ftime);
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
		$(".p_next").trigger("click"); //自动点击下一首
	};