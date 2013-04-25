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
	Set<String> topics = []
	Set<String> expressions = []
	String title
	Set<String> photos = []
	// geo-location
	String locationName = ""


}
