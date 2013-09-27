package com.emote

import java.util.Date;

class Picture {
	
	Date dateCreated
	Date lastUpdated
	String id
	String type
	String filename
	byte[] content;
     
    static constraints = {
		// Limit upload file size to 5MB
		content maxSize: 1024 * 1024 * 5
    }
}
