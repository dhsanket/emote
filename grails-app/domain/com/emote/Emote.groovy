package com.emote

import java.util.Set;


class Emote {

    static constraints = {
    }
	static mapping = {
		topics index:true
	}
	
	String id
	String userId
	String username;
	Set<String> topics = []
	Set<String> expressions = []
	String title
	Set<String> photos = []
	// geo-location
	String locationName = ""
	
	//todo use joda time
	Date creationTime = new Date()


}
