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
			redirect(controller:'user' , action:'signin')
			return;
		}
		log.info "logged user is ${user.id}"
		
		if(emote.hasErrors()){
			log.info "emote has errors"
			//render view:'create', model:[emote:emote]
			render ""
			return
		}
		
		emoteService.create(emote, user)
		def titles = emoteService.groupByTitle(emoteService.feed())
		render(template:"emotesTemplate" , model:[titles: titles])
	}
	
	def feed(){
		flash.titles = emoteService.groupByTitle(emoteService.feed())
		redirect (action:'fbfriends')
	}
	
	def userFeed(String userId){
		flash.titles = emoteService.groupByTitle(emoteService.userFeed(userId))
		redirect (action:'fbfriends')
	}
	
	
	def fbfriends(){
		String token = facebookContext.user.token  			// For private data
		facebookGraphClient = new FacebookGraphClient(token)
		
		List emoteUsersList = []
		List userFriends = []
		if (facebookContext.authenticated)
		{
			emoteUsersList = User.list()
			userFriends = facebookGraphClient.fetchConnection("${facebookContext.user.id}/friends", [limit:10])
			// log.info "user friends in ${userFriends[1]},${userFriends[2] }"
			flash.titles = emoteService.groupByTitle(emoteService.feed())
			render (view:'feed', model: [userFriends: userFriends, emoteUsersList: emoteUsersList])
		}
		else
			redirect (controller:'user', action: 'signin')
	}
	
	def search(){
		def emotes = emoteService.groupByTitle(emoteService.search(params.keyword))
		flash.titles = emotes
		render view:'feed'
	}
}
