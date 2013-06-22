package com.emote

import grails.plugin.facebooksdk.FacebookContext;

class EmoteController {
	
	EmoteService emoteService
	
	FacebookContext facebookContext;
	

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
	}
	
	
	def search(){
		def emotes = emoteService.groupByTitle(emoteService.search(params.keyword))
		flash.titles = emotes
		render view:'feed'
	}
}
