package com.emote

class Picture {
	
	String id
	String contetType
	byte[] content;
     
    static constraints = {
		// Limit upload file size to 1MB
		content maxSize: 1024 * 1024 
    }
}
