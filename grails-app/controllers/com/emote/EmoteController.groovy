package com.emote

class EmoteController {
	
	EmoteService emoteService

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
			//render view:'create', model:[emote:emote]
			return
		}
		
		emoteService.create(emote, user)
		//redirect(actio)
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
