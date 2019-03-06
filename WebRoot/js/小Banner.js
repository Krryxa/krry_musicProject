	var z = 0; //设定每个方块的层级
	var index = 0;
	var len = $(".Banner .btn a").length; //共四个按钮

	$(".Banner .btn a").hover(function(){
		index = $(this).index();
		$(this).addClass("selll").siblings().removeClass("selll");
		$(".Banner .ul").css({
			transform:"translateZ(-100px) rotateX("+index*-90+"deg)",
		});
	});

	function change(){
		index = (index<len-1) ? ++index : 0;
		$(".Banner .ul").css({
			transform:"translateZ(-100px) rotateX("+index*-90+"deg)",
		});
		$(".Banner .btn a").eq(index).addClass("selll").siblings().removeClass("selll");
	}

	number(5);
	//动态生成方块数
	function number(num){
		var BanWidth = $(".Banner").width() / num; //获取每个方块的宽度
		for(var i = 0;i < num;i++){
			if(i == 0) $(".Banner ul").html(""); //每次调用的时候，先清空
			$(".Banner ul").append(
			"<div class='ul'><a href='javascript:void(0);'><li></li></a><a href='javascript:void(0);'><li></li></a><a href='javascript:void(0);'><li></li></a><a href='javascript:void(0);'><li></li></a></div>");
			//设置每个方块动画执行的时间，动画延迟执行时间
			$(".Banner .ul").eq(i).css({
				transition:"0.8s "+0.5*i/num+"s"
			});
			//设置每个方块的图片的位置
			$(".Banner .ul").eq(i).find("li").css({
				backgroundPosition:-(i)*BanWidth+"px 0",
			});
			//设置一半方块后的层级
			if(i > num/2){
				z--;
				$(".Banner .ul").eq(i).css({
					zIndex:z
				});
			}
		}

		$(".Banner .ul").css({
			transform:"translateZ(-100px) rotateX("+index*-90+"deg)",
		});

		//设置方块和每个面的宽度
		$(".Banner .ul").css({
			width:BanWidth
		});
		$(".Banner ul li").css({
			width:BanWidth
		});
	}
	var timerq = null;
	timerer();
	function timerer(){
		timerq = setInterval(function(){
			change();
		},3000);
	}

	$(".Banner").mouseover(function(){
		clearInterval(timerq);
	}).mouseout(function(){
		timerer();
	});