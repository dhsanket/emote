package com.emote;

import java.util.Set;

import com.sun.org.apache.bcel.internal.generic.RETURN;

public class GroupByTitle implements Comparable  {
	
	
	
	Date lastEmoteTime;
	
	String title;
	String id;
	String pictureId;
    String completeTitle
	
	Map<String, GroupByUser> emotesByUsers = [:]
	
	Map<String, GroupByUser> emotesByFollowing = [:]
	
	Set<String> followingUsers = []
	
	List<PopularEmote> popEmotes = []
	
	Set<String> categories = []
	
	@Override
	public int compareTo(Object o) {
		if(o == null) return -1;
		if(!(o instanceof GroupByTitle) ) return -1;
		GroupByTitle other = (GroupByTitle) o;
		// TODO Auto-generated method stub
		return other.lastEmoteTime.compareTo(lastEmoteTime)
	}
	
	void add(Emote emote){
		GroupByUser userGrouped = emotesByUsers.get(emote.userId)
		if(userGrouped == null) userGrouped = emotesByFollowing.get(emote.userId)
		if(userGrouped == null){
			userGrouped = new GroupByUser(username:emote.username, uid:emote.userId, facebookId:emote.facebookId)
			if(followingUsers != null && followingUsers.contains(emote.userId)){
				emotesByFollowing.put(emote.userId, userGrouped)
			}else{
				emotesByUsers.put(emote.userId, userGrouped)
			}
		}
		userGrouped.add(emote)
		
		if(lastEmoteTime == null || lastEmoteTime.getTime()< emote.creationTime.getTime()){
			lastEmoteTime = emote.creationTime
		}
		emote.topics.each {category ->
			categories.add(category) //line added to get anyone category for the title and display it in quick emote page.
		}
		addPopularEntry(emote)
	}
	
	GroupByUser getUserEmotes(String uid){
		return emotesByUsers.get(uid)
	}
	
	GroupByUser getFollowed(String uid){
		return emotesByFollowing.get(uid)
	}

	
	def getUsers(){
		return emotesByUsers.values()
	}
	
	def getFollowingUsers(){
		return emotesByFollowing.values()
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
	
	def getFirstCategory(){
		String rtnCategory;
		categories.each { category ->
			if(category!=null && category.length()>0){
				rtnCategory=category;
				return true
			}
		}
		return rtnCategory;
	}


}
