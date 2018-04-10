$(".new_list li").click(function(){
				var index = $(this).index();
				$(this).find("a").addClass("new_sel").parent().siblings().find("a").removeClass("new_sel");
				$(".r_dinfin ul").eq(index).show().siblings().hide();
			});