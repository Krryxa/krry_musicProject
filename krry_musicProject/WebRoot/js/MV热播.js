$(".m_mvlist li .mv_a").click(function(){
	if($(".krryName").text()){
		var src = $(this).parent().data("src");
		var name = $(this).parent().find(".mv_musicTitle").text();
		location.href = "MV.jsp?name="+name+"&src="+src;
	}else{
		$.tmDialog.alert({title:"Krry的温馨提醒",content:"请您先登录Krry账号"});
	}
});