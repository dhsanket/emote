package com.emote

import java.util.Arrays;

class Title {
	String id
	String text
    static constraints = {
		text blank:false
    }
	@Override
	public String toString() {
		return "Title [id=" + id + ", text=" + text + "]";
	}
	
	
}


