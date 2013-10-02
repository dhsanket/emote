package com.emote

import java.util.Date;

class Topic {
	
	Date dateCreated
	Date lastUpdated
	String text
    static constraints = {
		text blank:false
    }
}
