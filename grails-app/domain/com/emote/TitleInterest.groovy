package com.emote

class TitleInterest {
    String titleId
    String userId
	Type type
	
	static enum Type {FAVOURITE,AUTHOR,FOLLOWER};

    static constraints = {
    }

	@Override
	public String toString() {
		return "TitleInterest [titleId=" + titleId + ", userId=" + userId+ ", type=" + type + "]";
	}
	
	
}
