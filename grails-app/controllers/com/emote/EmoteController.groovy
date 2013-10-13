package com.emote

import grails.plugin.facebooksdk.*;

class EmoteController {
	
	EmoteService emoteService
	
	UserService userService
	
	FacebookContext facebookContext;
	FacebookGraphClient facebookGraphClient;
	
	PictureService pictureService;
	

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
			StringBuilder errors = new StringBuilder()
			emote.errors.allErrors.each{
				errors.append(it).append("\n")
			}
			log.warn "emote post errors $errors"
			render(errors.toString())
			return
		}
		Picture pic = null; 
		if(emote.photo != null && emote.photo.bytes.size() >0){
			//log.info "got a picture of size $emote.photo.bytes.size()"
			pic = pictureService.crop(emote.photo, emote.topx, emote.topy, emote.bottomx, emote.bottomy,
				emote.scaledImgWidth, emote.scaledImgHeight)
		}else if(emote.webSearchImageURL != null && emote.webSearchImageURL.size() > 0){
			log.info "got a web picture  $emote.webSearchImageURL"
			pic = pictureService.crop(emote.webSearchImageURL, emote.topx, emote.topy, emote.bottomx, emote.bottomy,
				emote.scaledImgWidth, emote.scaledImgHeight)
	
		}
		emoteService.create(emote,  user, pic)
		def titles = emoteService.groupByTitle(emoteService.feed(0), 
			session.user.followingUsers , session.user.id)
		flash.titles = titles
		render view:'feed'

	}
	
	def feed(){
		int page = getPageIndex();
		def posts = emoteService.groupByTitle(emoteService.feed(page), 
												session.user)
		int postCount = posts!=null ? posts.size():0
		 // not the best way to handle end of pages but we can live with it for now
		if(checkLastPageAndSetPaginationAttributes(page, postCount, "feed", [:])){
			posts = emoteService.groupByTitle(emoteService.feed(page-1), 
													session.user)
		}
		flash.titles = posts 
	}
	
	
	def userFeed(){
		String userId = params.userId
		if(userId == null || userId.trim().length()== 0)
		{
			userId = session.user.id
		}
		int page = getPageIndex();
		def posts = emoteService.groupByTitle(emoteService.userFeed(userId, page), null)
		int postCount = posts!=null ? posts.size():0
		 // not the best way to handle end of pages but we can live with it for now
		if(checkLastPageAndSetPaginationAttributes(page, postCount, "userFeed", [userId:params.userId])){
			posts = emoteService.groupByTitle(emoteService.userFeed(userId, page-1), null)
		}
		flash.user = userService.findById(userId)
		flash.titles = posts
	}
	
	
	
	def search(){
		User user = session.user
		int page = getPageIndex();
		String searchTerm = params.keyword.toLowerCase();
		log.info "lowercase ofthe keyword: $searchTerm"
		def posts = emoteService.groupByTitle(emoteService.search(searchTerm, page), null)
		int postCount = posts!=null ? posts.size():0
		 // not the best way to handle end of pages but we can live with it for now
		if(checkLastPageAndSetPaginationAttributes(page, postCount, "search", [keyword:searchTerm])){
			posts = emoteService.groupByTitle(emoteService.search(searchTerm, page-1), null)
		}
		flash.titles = posts
		render view:'feed'
	}
		
	def singleTitle(){
		User user = session.user
		def emotes = emoteService.getSingleEmote(params.titleString);
		if(emotes!= null && emotes.size() >0){
			flash.titles =  emoteService.groupByTitle(emotes, user)
		}
		render view:"feed"
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
