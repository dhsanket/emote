package com.emote

class EmoteController {
	
	EmoteService emoteService

    def create() {
		
	}
	
	def save(){
		User user = session.user
		if(user == null){
			redirect(controller:'user' , action:'signin2')
			return;
		}
		log.info "logged user is ${user.id}"
		def topics = params.topic.split("/")
		def expressions = params.expression.split("\\\\")
		def username = user.firstName+" "+user.lastName
		Emote emote = new Emote(userId:user.id, username:username, topics:topics, expressions:expressions, title:params.title )
		emoteService.create(emote)
		
		redirect(action:'feed')
	}
	
	def feed(){
		def emotes = Emote.list(max:10, sort:"creationTime", order:"desc")
		flash.emotes = emotes
	}
	
	def search(){
	}
	
	def doSearch(){
		def emotes = emoteService.search(params.keyword)
		flash.emotes = emotes
		redirect(action:'search')

	}
}
