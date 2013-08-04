package com.emote

class Picture {
	
	String id
	String type
	String filename
	byte[] content;
     
    static constraints = {
		// Limit upload file size to 2MB
		content maxSize: 1024 * 1024 * 5
    }
}
