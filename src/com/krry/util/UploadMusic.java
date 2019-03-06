package com.krry.util;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.krry.dao.MusicDao;

/**
 * 上传本地音乐工具类
 * UploadMusic
 * @author krry
 * @version 1.0.0
 *
 */
public class UploadMusic {

	public static HashMap<String, Object> uploadMusic(HttpServletRequest request, HttpServletResponse response){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		try {
			//设置编码集
			request.setCharacterEncoding("utf-8");
			response.setContentType("html/text;charset=utf-8");
			//获取文件上传的目录
			String realPath = request.getRealPath("/");
			//定义上传目录
			String dirPath = realPath + "/uploadMusic";
			
			File dirFile = new File(dirPath);
			//如果此文件不存在
			if(!dirFile.exists()){
				dirFile.mkdirs();//创建此文件夹
			}
			//上传操作
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List items = upload.parseRequest(request);
			if(null != items){
				Iterator itr = items.iterator();
				while(itr.hasNext()){
					FileItem item = (FileItem) itr.next();
					//判断是否是表单类型是普通表单域还是文件上传域
					if(item.isFormField()){//如果是普通表单域,则结束当前循环
						continue;
					}else{ //如果是文件上传域
						//获取文件名
						String name = item.getName();
						File fileName = new File(dirPath,name);
						//从后面往前找.
						int i = name.lastIndexOf(".");
						//截取歌曲文件名，不包含后缀名
						String musicName = name.substring(0, i);
						
						//将普通字符串的反斜杠\变成正斜杠/
//						dirPath = dirPath.replace("\\", "");
						//获取歌曲上传包括文件名的路径
						String musicPath = "uploadMusic/" + name;
						
//						//检查音乐是否重复
//						int num = MusicDao.searchMusic(musicPath);
//						if(num > 0){//说明重复，不需上传
//							continue;
//						}else{
							//上传文件
							item.write(fileName);
							
							//存入map集合
							map.put("name", musicName);
							map.put("src", musicPath);
							map.put("author", "Krry");
							map.put("album", "Key");
							map.put("timer", "04:00");
							//存入数据库
							MusicDao.addMusic(musicName, musicPath, "Krry", "Key", "04:00");
//						}
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
	public static void main(String[] args) {
		String s = "1545\\454\\87\\545\\";
		s = s.replace("\\", "/");
		System.out.println(s);
	}
	
}






