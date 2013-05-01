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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Emote other = (Emote) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	

}
