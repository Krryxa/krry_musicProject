Krry音乐项目

后台jar包及class:
所需的jar包:
	MyJdbc.jar
	c3p0-0.9.1.2.jar
	ojdbc6.jar
	
class:
	servlet:注册：AddUserServlet.java、ResgServlet.java
			登录：LoginServlet.java
			退出登录：ExitUserServlet.java
			删除歌曲：DeleteServlet.java
			
	entity:	歌曲列表：MusicList.java
			我的歌单：SingleList.java
			MV热播：MVList.java
			
	dao:	用户：UserDao.java
			歌曲列表：MusicDao.java
			我的歌单：ListDao.java
			MV热播：MVDao.java
	
	util:	上传本地歌曲：UploadMusic.java

后台实现功能：
1.登录注册				 数据库：KRRY_USER
	1.1.表单验证
	1.2.用户名失焦后验证数据库
	1.3.利用ajax在后台servlet验证数据库判断用户名是否重复，前台提示信息
	1.4.根据数据库判断密码是否正确
	1.5.成功注册的用户信息储存到数据库KRRY_USER
	1.6.成功登录以及成功注册后自动登录的用户信息储存到session
	1.7.根据session读取用户信息在前台显示（EL表达式）
	1.8.退出登录，清除session储存的用户信息
	
2.列表音乐播放	 		 数据库：KRRY_MUSIC
	2.1.成功登录后，也将歌曲信息的数据库KRRY_MUSIC储存到session，前台用EL表达式获取显示
	2.2.进度条、进度控制、音量条、音量控制、获取歌手图片、歌曲名称、歌曲总时间、歌曲当前播放时间
	2.3.利用ajax动态显示歌词
	2.4.歌词每行选中的样式动画，利用算法动态显示在中间区域（第n行歌词*li的高度-歌词区域中间的li（包括这个li）以上的li的总高度）
	2.5.点击进度条动态实时滚动歌词(监听时间差0.1s)
	
3.我的歌单音乐点击播放		 数据库：MUSIC_LIST
	3.1.Krry首页读取数据库MUSIC_LIST的信息，储存到request
	3.2.前台利用JSTL标签库的FOREACH标签循环此request的歌单信息，显示出来
	3.3.点击歌单时，先循环查看列表音乐里有无此此歌曲，若无就动态添加上去播放，若有则直接播放
	
4.点击krry音乐盒		 数据库：KRRY_MUSIC
	4.1.Krry音乐盒初始化，FOREACH标签循环将列表音乐存进去session的信息，显示出来
	4.2.点击跳转krry音乐盒
	
5.MV热播				 数据库：KRRY_MV
	5.1.Krry首页读取数据库KRRY_MV的信息，储存到request
	5.2.FOREACH标签循环将MV信息读取显示在前台
	5.3.点击获取MV名称和路径
	5.4.利用多个参数传参方式，location.href = "MV.jsp?name="+name+"&src="+src;跳转到MV.jsp页面
	5.5.MV.jsp页面通过获取参数，将名称和路径设置进request作用域
	5.6.video标签通过EL表达式获取信息，前台通过此信息播放MV，设置窗口大小为宽度固定765px，可全屏
	
6.上传本地歌曲			 数据库：KRRY_MUSIC
	6.1.只能上传mp3、wma、aac格式的歌曲文件
	6.2.上传进度条显示，批量上传，上传到服务器的upload文件目录，并且同步到数据库KRRY_MUSIC
	6.3.通过上传ajax异步刷新歌曲区域
	
7.删除列表的歌曲			数据库：KRRY_MUSIC
	7.1.通过歌曲文件路径异步请求deleteServlet
	7.2.删除数据库中的歌曲数据，服务器的歌曲文件暂不删除
	7.3.自动异步刷新歌曲区域


所有功能必须在登录后方可使用





