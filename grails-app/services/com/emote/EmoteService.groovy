package com.emote

class EmoteService {

	def create(Emote emote) {
		
		def nonEmptyTopics = []
		emote.topics.each{ topic ->
			if(topic.trim().length()> 0){
				nonEmptyTopics.add(topic)
			}
		}
		
		def nonEmptyExpression = []
		emote.expressions.each{ exp ->
			if(exp.trim().length()> 0){
				nonEmptyExpression.add(exp)
			}
		}
		emote.expressions = nonEmptyExpression

		emote.topics = nonEmptyTopics
		
		emote.save(true)
	}
	
	Set<Emote> search(String keyword){
		
		log.info "searching for $keyword"
		Set<Emote> results = []
		def qresults = Emote.findAllByTopicsIlike(keyword +"%")
		log.info "found emotes by topic ${qresults}"
		if(qresults != null)
			results.addAll(qresults)
		
		qresults = Emote.findAllByTitleIlike(keyword+"%")
		log.info "found emotes by title ${qresults}"
		if(qresults != null)
			results.addAll(qresults)
		
		return results
	}
	
	def feed(){
		return Emote.list(max:10, sort:"creationTime", order:"desc")
		
	}
}
