package com.krry.entity;

public class MusicList {
	private String name;
	private String src;
	private String author;
	private String album;
	private int musicId;
	private String timer;

	public void setTimer(String timer) {
		this.timer = timer;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getAlbum() {
		return album;
	}
	public void setAlbum(String album) {
		this.album = album;
	}
	public int getMusicId() {
		return musicId;
	}
	public void setMusicId(int musicId) {
		this.musicId = musicId;
	}
	public String getTimer() {
		return timer;
	}
	@Override
	public String toString() {
		return "MusicList [name=" + name + ", src=" + src + ", author="
				+ author + ", album=" + album + ", musicId=" + musicId
				+ ", timer=" + timer + "]";
	}
	
}
