package com.emote

import java.util.Date;
import java.util.List;

class GroupByUser  implements Comparable {
	
	String username
	String facebookId
	String uid
	
	Date lastEmoteTime;
	
	private LinkedHashSet<ExpressionIdea> expressions = []
	
	
	void add(Emote emote){
		emote.expressionIdeas.each {expression -> 
			expressions.add(expression)
		}
	}
	
	@Override
	public int compareTo(Object o) {
		if(o == null) return -1;
		if(!(o instanceof GroupByTitle) ) return -1;
		GroupByTitle other = (GroupByTitle) o;
		// TODO Auto-generated method stub
		return other.lastEmoteTime.compareTo(lastEmoteTime)
	}


}
