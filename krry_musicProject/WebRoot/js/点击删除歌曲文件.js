//首页的点击删除歌曲
$(".t_dele").click(function(){
	var _this = $(this);
	var title = _this.parent().find(".musictitle").text();
	$.tmDialog.confirm({content:"您确定要删除《"+title+"》吗？",callback:function(ok){
		if(ok){
			//获取要删除的文件路径
			var src = _this.parent().data("src");
			$.ajax({
				url:"deleteServlet",
				type:"post",
				data:{info:src},
				success:function(data){
					if(data>0){ //如果受影响的行数大于0，说明删除成功
						_this.parent().fadeOut(1000,function(){
							_this.remove();
						});
					}else{
						$.tmDialog.alert({content:"删除失败"});
					}
				}
			});
		}
	}});
});

//音乐盒的点击删除歌曲
$(".l_del").click(function(){
	var _this = $(this);
	var title = _this.parents(".s_list").find(".l_info .l_t:first").text();
	$.tmDialog.confirm({content:"您确定要删除《"+title+"》吗？",callback:function(ok){
		if(ok){
			//获取要删除的文件路径
			var src = _this.parents(".s_list").data("src");
			$.ajax({
				url:"deleteServlet",
				type:"post",
				data:{info:src},
				success:function(data){
					alert(data);
					if(data>0){ //如果受影响的行数大于0，说明删除成功
						_this.parents(".s_list").fadeOut(1000,function(){
							_this.parents(".s_list").remove();
						});
					}else{
						$.tmDialog.alert({content:"删除失败"});
					}
				}
			});
		}
	}});
});
