package com.emote;

public class GroupByTitle implements Comparable  {
	
	
	
	Date lastEmoteTime;
	
	String title;
	String id;
	String pictureId;
	
	Map<String, GroupByUser> emotesByUsers = [:]
	
	List<PopularEmote> popEmotes = []
	
	
	

	@Override
	public int compareTo(Object o) {
		if(o == null) return -1;
		if(!(o instanceof GroupByTitle) ) return -1;
		GroupByTitle other = (GroupByTitle) o;
		// TODO Auto-generated method stub
		return other.lastEmoteTime.compareTo(lastEmoteTime)
	}
	
	void add(Emote emote){
		GroupByUser userGrouped = emotesByUsers.get(emote.facebookId)
		if(userGrouped == null){
			userGrouped = new GroupByUser(username:emote.username, facebookId:emote.facebookId)
			emotesByUsers.put(emote.facebookId, userGrouped)
		}
		userGrouped.add(emote)
		
		if(lastEmoteTime == null || lastEmoteTime.getTime()< emote.creationTime.getTime()){
			lastEmoteTime = emote.creationTime
		}
		addPopularEntry(emote)
	}
	
	GroupByUser getUserEmotes(String fbId){
		return emotesByUsers.get(fbId)
	}
	
	def getUsers(){
		return emotesByUsers.values()
	}
	
	def addPopularEntry(Emote emote){
		
		emote.expressions.each { exp ->
			PopularEmote pe = new PopularEmote(exp)
			if(popEmotes.contains(pe)){
				PopularEmote e = popEmotes.get(popEmotes.indexOf(pe))
				e.incrementCount();
			}else{
				popEmotes.add(pe);
				
			}
		}
	}
	
	def getPopularEmotes(){
		Collections.sort(popEmotes)
		return popEmotes.take(10);
	}


}
