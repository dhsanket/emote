package com.emote

class EmoteService {

	def create(EmoteCommand emoteCmd, User user) {
		def username = user.firstName+" "+user.lastName
		
		Emote emote = new Emote(
			userId:user.id, creator:user, username:username, topics:emoteCmd.topics, 
			expressions:emoteCmd.expressions, title:emoteCmd.title, facebookId:user.facebookId 
			)
		
		
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
		
		emote.save(validate: true)
		
		// save title if does not exist
		Title title = Title.findByText(emote.title.toLowerCase())
		if(title == null){
			title = new Title(text:emote.title.toLowerCase())
			log.info "Saving title ${title}"
			title.save(validate:true)
		}
		
		// save topics
		emote.topics.each {topicText ->
			Topic topic = Topic.findByText(topicText.toLowerCase())
			if(topic == null){
				topic = new Topic(text:topicText.toLowerCase())
				topic.save(validate:true)
			}
		}
		
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
		return Emote.list(max:30, sort:"creationTime", order:"desc")
		
	}
	
	def userFeed(String userId){
		return Emote.findAllByUserId(userId, [max:30, sort:"creationTime", order:"desc"])
	}
	
	def groupByTitle (def emotes){
		def groupedByTitle =  [:] 
		emotes.each {emote ->
			GroupByTitle title = groupedByTitle.get(emote.title.toUpperCase())
			if(title == null){
				title = new GroupByTitle(title:emote.title)
				groupedByTitle.put(emote.title.toUpperCase(), title)
			}
			title.add(emote);
			
		}
		List<GroupByTitle> sorted = new ArrayList<GroupByTitle>()
		groupedByTitle.each{key, value -> 
			sorted.add(value)
		}
		 Collections.sort(sorted);
		 return sorted;
	}
}
