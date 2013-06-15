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
			render view:'create', model:[emote:emote]
			return
		}
		
		emoteService.create(emote, user)
		
		redirect(controller:'user',action:'feed')
	}
	
	def feed(){
		flash.emotes = emoteService.feed()
	}
	
	
	def search(){
		def emotes = emoteService.search(params.keyword)
		flash.emotes = emotes
		render view:'feed'
	}
}
