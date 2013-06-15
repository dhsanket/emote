package com.emote;

public class GroupByTitle implements Comparable  {
	
	
	
	Date lastEmoteTime;
	
	String title;
	
	List<Emote> emotes = []
	

	@Override
	public int compareTo(Object o) {
		if(o == null) return -1;
		if(!(o instanceof GroupByTitle) ) return -1;
		GroupByTitle other = (GroupByTitle) o;
		// TODO Auto-generated method stub
		return other.lastEmoteTime.compareTo(lastEmoteTime)
	}
	
	void add(Emote emote){
		emotes.add(emote);
		if(lastEmoteTime == null || lastEmoteTime.getTime()< emote.creationTime.getTime()){
			lastEmoteTime = emote.creationTime
		}
	}

}
