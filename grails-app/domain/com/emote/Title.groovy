package com.emote

import java.util.Arrays;
import java.util.Date;

class Title {
	String id
	String text
	Date lastUpdateTime = new Date()
	
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
	
}


