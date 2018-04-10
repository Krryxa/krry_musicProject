var sigleclose = true;
			var nowTime3 = 0;
			$(".r_right").click(function(){
				if(new Date() - nowTime3 > 600){
					nowTime3 = new Date();
					$(".e_musiclist").animate({"marginLeft":-795,},600);
					setTimeout(function(){
						$(".r_left").css({color:"#6D6B6B"});
						$(".r_right").css({color:"#C7C5C5"});
					},600);
					sigleclose = false;
				}
			});
			$(".r_left").click(function(){
				if(new Date() - nowTime3 > 600){
					nowTime3 = new Date();
					$(".e_musiclist").animate({"marginLeft":0,},600);
					setTimeout(function(){
						$(".r_right").css({color:"#6D6B6B"});
						$(".r_left").css({color:"#C7C5C5"});
					},600);
					sigleclose = true;
				}
			});

			function TimeSlid(){
				setInterval(function(){
					if(sigleclose){
						$(".r_right").trigger("click");
					}else{
						$(".r_left").trigger("click");
					}
				},7000);
			}
			TimeSlid();