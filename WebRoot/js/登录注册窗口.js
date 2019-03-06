function loginres(obj){
		$("#"+obj).show();
		$("#"+obj).find(".box").addClass("animated bounceInDown");
		setTimeout(function(){
			$("#"+obj).find(".box").removeClass("animated bounceInDown");
		},1000);
	}
	$(".Close").click(function(){
		$(".box").addClass("animated bounceOutUp");
		setTimeout(function(){
			$(".login").hide();
			$(".box").removeClass("animated bounceOutUp");
		},500);
	});
	$(".l_set").click(function(){
		var _this = $(this);
		_this.parents(".box").addClass("animated bounceOutRight");
		setTimeout(function(){
			_this.parents(".login").hide().siblings().show().find(".box").addClass("animated bounceInLeft");
			setTimeout(function(){
				$(".box").removeClass("animated bounceInLeft");
				$(".box").removeClass("animated bounceOutRight");
			},1000);
		},500);
	});
	$(window).resize(changeLogin);
	changeLogin();
	function changeLogin(){
		var $box = $(".box");
		//盒子的宽高
		var width = $box.width();
		var height = $box.height();
		//可视区域的宽高
		var H = $(window).height();
		var W = $(window).width();
		//盒子的位置
		var top = H/2 - height/2;
		var left = W/2 - width/2;
		$box.css({
			top:top,
			left:left
		});
	}