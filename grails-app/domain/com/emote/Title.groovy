package com.emote

import java.util.Arrays;
import java.util.Date;
import java.util.Set;

class Title {
	String id
	String text
	Set<String> category = []
	Date lastUpdateTime = new Date()
	List<String> pictures = []
	
	static mapping = {
		text index:true
		category index:true
	}
	
    static constraints = {
		text blank:false
    }
	@Override
	public String toString() {
		return "Title [id=" + id + ", text=" + text + "]";
	}
	
	public refreshUpdateTime(){
		lastUpdateTime = new Date()
	}
	
	public addCategory(def cats){
		if(category == null)
			category = []
		cats.each {c ->
			category.add(c)
		}
	}
	
	public addPicture(String picId){
		pictures.add(picId)
	}
	

}


