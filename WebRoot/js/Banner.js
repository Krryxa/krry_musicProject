var $li = $(".c_banner .boxBan ul li");
			var arrW = [],arrH = [],arrZ = [],arrT = [],arrL = [],arrO = [],arrD = [];
			var nowTime2 = 0;

			$li.append("<span></span>");
			$(".c_banner .boxBan li span").eq(0).css("display","none");

			$(".c_banner .right").click(function(){
				if(new Date() - nowTime2 > 500){
					nowTime2 = new Date();
					Banner(false);  //false代表右按钮
				}
			});

			$(".c_banner .left").click(function(){
				if(new Date() - nowTime2 > 500){
					nowTime2 = new Date();
					Banner(true);  //true代表左按钮
				}
			});

			var timerBanner = null;
			autoBanner();
			function autoBanner(){
				timerBanner = setInterval(function(){
					$(".c_banner .right").trigger("click");
				},4000);
			}

			function Banner(flag){
				$li.each(function(i){
					arrW[i] = $(this).css("width");
					arrH[i] = $(this).css("height");
					arrZ[i] = $(this).css("z-index");
					arrT[i] = $(this).css("top");
					arrL[i] = $(this).css("left");
					arrO[i] = $(this).css("opacity");
					arrD[i] = $(this).find("span").css("display");
				});
				$li.each(function(i){
					if(flag){  //true代表左按钮
						var a = i + 1;
						if(a == $li.length) a = 0;
					}else{   //false代表右按钮
						var a = i - 1;
						if(a < 0) a = $li.length - 1;
					}
					//把当前的div属性赋给下一个div，以此类推
					$(this).find("span").css("display",arrD[a]);
					$(this).css("zIndex",arrZ[a]).animate({
						"width":arrW[a],
						"height":arrH[a],
						"top":arrT[a],
						"left":arrL[a],
						"opacity":arrO[a]
					},500);
				});
			}