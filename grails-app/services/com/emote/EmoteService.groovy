package com.emote

class EmoteService {

	def create(EmoteCommand emoteCmd, User user) {
		def username = user.firstName+" "+user.lastName
		
		Emote emote = new Emote(
			userId:user.id, creator:user, username:username, topics:emoteCmd.topics, 
			expressions:emoteCmd.expressions, title:emoteCmd.title, facebookId:user.facebookId 
			)
		
		//TODO with new approch there is no null topics so we may not need this check
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
		
		// save title if does not exist else update time
		Title title = Title.findByTextIlike(emote.title)
		if(title == null){
			title = new Title(text:emote.title)
			log.info "Saving title ${title}"
			title.save(validate:true)
		}else{
			title.refreshUpdateTime()
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
		def titles = Title.list(max:30, sort:"lastUpdateTime", order:"desc")
		def titleTexts  = []
		titles.each{t ->
			titleTexts.add(t.text)
		}
		def emotes = Emote.findAllByTitleInList(titleTexts, [sort:"creationTime", order:"desc"])
		return emotes;
	}
	
	def userFeed(String userId){
		def userEmotes = Emote.findAllByUserId(userId, [max:30, sort:"creationTime", order:"desc"])
		return userEmotes;
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
	
	def findTitles(String text){
		log.info("searching title by $text")
		return Title.findAllByTextIlike(text+"%")
	}
}
