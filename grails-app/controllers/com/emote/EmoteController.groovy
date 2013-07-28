package com.emote

import grails.plugin.facebooksdk.*;

class EmoteController {
	
	EmoteService emoteService
	
	FacebookContext facebookContext;
	FacebookGraphClient facebookGraphClient;
	

    def create() {
		
	}
	
	def save(EmoteCommand emote){
		User user = session.user
		if(user == null){
			//temp changes remove later
//			user = User.findByEmail('nkarmuse@gmail.com')
			redirect(controller:'user' , action:'signin')
			return;
		}
		log.info "logged user is ${user.id}"
		
		if(emote.hasErrors()){
			log.info "emote has errors"
			//render view:'create', model:[emote:emote]
			return
		}
		
		emoteService.create(emote, user)
		def titles = emoteService.groupByTitle(emoteService.feed(0))
		render(template:"emotesTemplate" , model:[titles: titles])
	}
	
	def feed(){
		int page = getPageIndex();
		def posts = emoteService.groupByTitle(emoteService.feed(page))
		int postCount = posts!=null ? posts.size():0
		 // not the best way to handle end of pages but we can live with it for now
		if(checkLastPageAndSetPaginationAttributes(page, postCount, "feed", [:])){
			posts = emoteService.groupByTitle(emoteService.feed(page-1))
		}
		flash.titles = posts 
	}
	
	def userFeed(){
		String userId = params.userId
		if(userId == null || userId.trim().length()== 0)
		{
			userId = session.user.facebookId
		}
		int page = getPageIndex();
		def posts = emoteService.groupByTitle(emoteService.userFeed(userId, page))
		int postCount = posts!=null ? posts.size():0
		 // not the best way to handle end of pages but we can live with it for now
		if(checkLastPageAndSetPaginationAttributes(page, postCount, "userFeed", [userId:params.userId])){
			posts = emoteService.groupByTitle(emoteService.userFeed(userId, page-1))
		}
		flash.titles = posts
	}
	
	
	
	def search(){
		int page = getPageIndex();
		def posts = emoteService.groupByTitle(emoteService.search(params.keyword, page))
		int postCount = posts!=null ? posts.size():0
		 // not the best way to handle end of pages but we can live with it for now
		if(checkLastPageAndSetPaginationAttributes(page, postCount, "search", [keyword:params.keyword])){
			posts = emoteService.groupByTitle(emoteService.search(params.keyword, page-1))
		}
		flash.titles = posts
		render view:'feed'
	}
	
	private int getPageIndex(){
		int page = 0;
		boolean morePages = true
		if(params.page){
			page = Integer.parseInt(params.page)
		}
		return page
	}
	
	private boolean checkLastPageAndSetPaginationAttributes(int page, int postsSize, String action, def extraParams){
		boolean morePages = true
		if(page > 0 && postsSize == 0){
			page = page-1
			morePages = false;
		}
		flash.morePages = morePages
		flash.page = page
		flash.action = action
		flash.extraParams = extraParams
		return !morePages
	}

}
