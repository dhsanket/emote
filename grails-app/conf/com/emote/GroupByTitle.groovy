package com.emote;

public class GroupByTitle implements Comparable  {
	
	Date lastEmoteTime;
	
	
	
	List<Emote> emotes = []
	

	@Override
	public int compareTo(Object o) {
		if(o == null) return -1;
		if(!(o instanceof GroupByTitle) ) return -1;
		GroupByTitle other = (GroupByTitle) o;
		// TODO Auto-generated method stub
		return lastEmoteTime.compareTo(other.lastEmoteTime)
	}
	

}
