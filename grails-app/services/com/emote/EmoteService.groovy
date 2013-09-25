package com.emote

import java.util.Set;

class EmoteService {
	
	private int feedPageSize = 10;

	def create(EmoteCommand emoteCmd, User user, Picture pic) {
		def username = user.firstName+" "+user.lastName
		
		Emote emote = new Emote(
			userId:user.id, creator:user, username:username, topics:emoteCmd.category, 
			expressions:emoteCmd.expressions, title:emoteCmd.title, facebookId:user.facebookId 
			)
		
		
		def nonEmptyExpression = []
		emote.expressions.each{ exp ->
			if(exp.trim().length()> 0){
				nonEmptyExpression.add(exp)
			}
		}
		emote.expressions = nonEmptyExpression
		
		Set<String> keywords = []
		def k = emote.title.toLowerCase()
		keywords.addAll(k)
		def u = emote.username.toLowerCase()
		keywords.addAll(u)
		emote.topics.each {topicText ->
			keywords.add(topicText.toLowerCase())
			}
			
		emote.save(validate: true)
		
		// save title if does not exist else update time
		Title title = Title.findByTextIlike(emote.title)
		if(title == null){
			title = new Title(text:emote.title, category: emote.topics)
			log.info "Saving title ${title}"
		}else{
			title.refreshUpdateTime()
			title.addCategory(emote.topics)
		}
		if(pic != null && pic.content.length > 0){
			pic.save(flush:true)
			log.info("saved picture $pic.id for title $title.text of length $pic.content.length")
			if(pic.id != null)
				title.addPicture(pic.id)
		}
		title.save(validate:true)
		
		
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
		def qresults = Emote.findAllByKeywordsIlike("%"+keyword+"%", [max:feedPageSize, sort:"creationTime", order:"desc" , offset:feedPageSize*pageIndex], [hint:[keywords:1]] )
		log.info "found emotes by title ${qresults}"
		if (qresults != null) {results.addAll(qresults)}
		return results
	}
	
/*	Set<Emote> search(String keyword, int pageIndex){
		log.info "searching for $keyword"
		Set<Emote> results = []
		def qresults = Emote.findAllByTitleIlike("%"+keyword+"%", [max:feedPageSize, sort:"creationTime", order:"desc" , offset:feedPageSize*pageIndex], [hint:[title:1]] )
		log.info "found emotes by title ${qresults}"
		def eresults = Emote.findAllByUsernameIlike("%"+keyword+"%", [max:feedPageSize, sort:"creationTime", order:"desc" , offset:feedPageSize*pageIndex], [hint:[username:1]] )
		log.info "found emotes by title ${eresults}"
		def dresults = Emote.findAllByTopicsIlike("%"+keyword+"%", [max:feedPageSize, sort:"creationTime", order:"desc" , offset:feedPageSize*pageIndex], [hint:[topics:1]] )
		if (qresults != null) {results.addAll(qresults)}
		if (qresults != null) {results.addAll(eresults)}
		if (qresults != null) {results.addAll(dresults)}
		return results
	}*/
	
	
/*	Set<Emote> search(String keyword, int pageIndex){
		log.info "searching for $keyword"
		Set<Emote> results = []
		def c = Emote.createCriteria()
		def qresults = c {
			or {
				like("title", "%"+keyword+"%")
				like("username", "%"+keyword+"%")
				like("topics", "%"+keyword+"%")
			}
			maxResults feedPageSize
			firstResult feedPageSize*pageIndex
			order("creationTime", "desc")
			arguments hint:["title":1]
		}
		if (qresults != null) {results.addAll(qresults)}
		return results
		
	}*/

	
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
		def userEmotes = Emote.findAllByUserId(userId, [max:feedPageSize, sort:"creationTime", order:"desc" , offset:feedPageSize*pageIndex])
		return userEmotes;
	}
	
	def groupByTitle (def emotes, Set<String> followingUsers, String currentUserId){
		def groupedByTitle =  [:] 
		if(followingUsers != null && followingUsers.size()> 0){
			followingUsers = followingUsers + currentUserId
		}
		log.info("emotes following usees $followingUsers, + $currentUserId")
		
		emotes.each {emote ->
			boolean canShow = false
			if(followingUsers == null || followingUsers.size() == 0 || followingUsers.contains(emote.userId) ||
				groupedByTitle.containsKey(emote.title.toUpperCase())){
				canShow = true
			}
	
			if(canShow){
				GroupByTitle title = groupedByTitle.get(emote.title.toUpperCase())
				if(title == null){
					Title titleObj = Title.findByText(emote.title)
					String picId = null	
					if(titleObj != null)	
						picId = titleObj.pictures != null && titleObj.pictures.size() > 0 ? titleObj.pictures[titleObj.pictures.size()-1]:null
					title = new GroupByTitle(title:emote.title, pictureId:picId, followingUsers:followingUsers)
					groupedByTitle.put(emote.title.toUpperCase(), title)
				}
				title.add(emote);
			}
			
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
