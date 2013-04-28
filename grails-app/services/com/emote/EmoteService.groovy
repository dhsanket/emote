package com.emote

class EmoteService {

    def create(Emote emote) {
		emote.save(true)
    }
	
	List<Emote> search(String keyword){
		
		println keyword
		List<Emote> results = []
		
		def query = Emote.where{
			topics == keyword
		}
		def qresults = query.findAll()
		log.info "found emotes by topic ${qresults}"
		
		if(qresults != null)
			results.addAll(qresults)
		
		query = Emote.where{
			title == keyword
		}
		qresults = query.findAll()
		
		log.info "found emotes by title ${qresults}"
		if(qresults != null)
			results.addAll(qresults)
		
		return results

		
	}
	
	def feed(){
		
	}
}
