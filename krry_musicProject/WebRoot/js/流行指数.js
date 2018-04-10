$(".desc_list li a").click(function(){
	var index = $(this).parent().index();
	$(this).addClass("sellr").parent().siblings().find("a").removeClass("sellr");
	$(".s_listtram ul").eq(index).show().siblings().hide();
});