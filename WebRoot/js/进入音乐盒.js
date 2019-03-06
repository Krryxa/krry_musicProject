$(".krrymusic").click(function(){
	if($(".krryName").text()){
		location.href = "krry音乐盒.jsp";
	}else{
		$.tmDialog.alert({title:"Krry的温馨提醒",content:"请您先登录Krry账号"});
	}
});