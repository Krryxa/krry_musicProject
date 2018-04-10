	var flag1 = false;
	var flag2 = false;
	//登录和注册验证
	var $email = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
	var $phone = /^1[3|4|5|7|8]\d{9}$/;
	var $password = /^[A-Za-z0-9]{6,15}$/;
	
	//用户名失焦会调用
	//用户名的验证
	function prove1(obj,objflag){
		var name = $(obj).val();
		if(name == ""){
			$(obj).parent().find(".nameDesc").text("请输入邮箱地址或手机号码");
			flag1 = false;
		}else if(!$email.test(name) && !$phone.test(name)){
			$(obj).parent().find(".nameDesc").text("邮箱地址或手机号码格式不正确");
			flag1 = false;
		}else{
			//判断用户名是否重复
			if(objflag){ //true代表是登录窗口的用户名调用
				UserRepeat(true,name);
			}else{
				UserRepeat(false,name);
			}
		}
	}
	
	//密码失焦会调用
	//密码的验证
	function prove2(obj){
		if($(obj).val()==""){
			$(obj).parent().find(".passDesc").text("请输入密码");
			flag2 = false;
		}else if(!$password.test($(obj).val())){
			$(obj).parent().find(".passDesc").text("密码中不可带有特殊字符");
			if($(obj).val().length < 6 || $(obj).val().length > 16)
			$(obj).parent().find(".passDesc").append("请设置密码长度为6~16");
			flag2 = false;
		}else{
			flag2 = true;
			$(obj).parent().find(".passDesc").text("");
		}
	}
	
	//利用ajax判断用户名是否重复  obj判断登录或注册窗口调用，true就是登录窗口调用，false是注册窗口调用
	function UserRepeat(obj,name){
		$.ajax({
			url:"resgServlet",
			data:{username:name},
			type:"post",
			success:function(data){
				if(obj){ //如果正确，说明是登录窗口调用的
					if(data == 0){
						flag1 = false;
						$('#log').find('.nameDesc').text("用户名不存在");
					}else{
						flag1 = true;
						$('#log').find(".nameDesc").text("");
					}
				}else{//否则就是注册窗口调用的
					if(data>0){
						flag1 = false;//确保提交表单的时候必须格式完全正确，并且用户名没有重复
						$('#register').find('.nameDesc').text("用户名已存在");
					}else{
						flag1 = true;
						$('#register').find('.nameDesc').text("");
					}
				}
			}
		});
	}
	
	//判断一开始浏览器存在的session储存的用户名
	if($(".krryName").text()){
		$(".Nameuser").show();
		$(".krryexit").show();
		$(".krrylogin").hide();
		$(".krryres").hide();
	}
	
	//点击登录
	$(".sub_login").click(function(){
		prove1(".loginUser",true);
		prove2(".loginPass");
		setTimeout(function(){
			if(flag1 && flag2){
				var name = $(".loginUser").val();
				var pass = $(".loginPass").val();
				$.ajax({
					url:"loginServlet",
					data:{username:name,password:pass},
					type:"post",
					success:function(data){
						if(data == 1){
							$('#log').find('.passDesc').text("密码错误");
						}else{
							//登录成功，信息已经存入session，只需要刷新页面
							location.href="index.jsp";
						}
					}
				});
			}
		},500);
		
	});
	
	//点击注册
	$(".sub_res").click(function(){
		prove1(".ResUser",false);
		prove2(".ResPass");
		setTimeout(function(){
			if(flag1 && flag2){
				$("#res_submit").click();
			}
		},500);
		
	});
	
	//退出Krry账号
	$(".krryexit").click(function(){
		$.tmDialog.confirm({title:"Krry的温馨提醒",content:"您确定要退出Krry账号吗？",callback:function(ok){
			if(ok){
				location.href="exitUserServlet";
			}
		}});
	});
	