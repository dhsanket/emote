package com.emote

class EmoteService {
	
	private int feedPageSize = 10;

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
			title = new Title(text:emote.title, category: emote.topics)
			log.info "Saving title ${title}"
			title.save(validate:true)
		}else{
			title.refreshUpdateTime()
			title.addCategory(emote.topics)
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
	
	Set<Emote> search(String keyword, int pageIndex){
		log.info "searching for $keyword"
		Set<Emote> results = []
		def qresults = Emote.findAllByTitleIlike("%"+keyword+"%", [max:feedPageSize, sort:"creationTime", order:"desc" , offset:feedPageSize*pageIndex])
		log.info "found emotes by title ${qresults}"
		if(qresults != null)
			results.addAll(qresults)
		return results
	}
	
	def feed(int pageIndex){
		def titles = Title.list(max:feedPageSize, sort:"lastUpdateTime", order:"desc" , offset:feedPageSize*pageIndex)
		def titleTexts  = []
		titles.each{t ->
			titleTexts.add(t.text)
		}
		def emotes = Emote.findAllByTitleInList(titleTexts, [sort:"creationTime", order:"desc"])
		return emotes;
	}
	
	def userFeed(String userId, int pageIndex){
		def userEmotes = Emote.findAllByFacebookId(userId, [max:feedPageSize, sort:"creationTime", order:"desc" , offset:feedPageSize*pageIndex])
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
