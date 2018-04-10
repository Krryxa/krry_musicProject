package com.krry.entity;

public class MVList {
	private int mvId;
	private String name;
	private String author;
	private String src;
	private String img;
	private String album;
	public String getAlbum() {
		return album;
	}
	public void setAlbum(String album) {
		this.album = album;
	}
	public int getMvId() {
		return mvId;
	}
	public void setMvId(int mvId) {
		this.mvId = mvId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	@Override
	public String toString() {
		return "MVList [mvId=" + mvId + ", name=" + name + ", author=" + author
				+ ", src=" + src + ", img=" + img + ", album=" + album + "]";
	}
	
	
}
