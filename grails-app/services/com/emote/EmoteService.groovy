package com.emote

class EmoteService {

    private int feedPageSize = 10;
    def grailsApplication
	
	NotificationService notificationService

    def create(EmoteCommand emoteCmd, User user, Picture pic) {
        def username = user.firstName + " " + user.lastName
        def parentTitle = null
        String emoteTitle = emoteCmd.title
        String connector
        (emoteTitle, connector, parentTitle) = extractTitles(emoteCmd.title, emoteTitle, parentTitle)
        LinkedHashSet<ExpressionIdea> ideas = new LinkedHashSet<>()
        prepareExpressionIdeas(emoteCmd, ideas)
        Emote emote = new Emote(
                userId: user.id, creator: user, username: username, topics: emoteCmd.category, parentTitle: parentTitle,
                connector: connector, expressionIdeas: ideas, title: emoteTitle, facebookId: user.facebookId
        )

        emote.populateKeywords()
        emote.save(validate: true)
        // save title if does not exist else update time
        Title title = saveTitle(emoteTitle, emote, pic, user)
        if (parentTitle) {
            parentTitle = saveTitle(parentTitle, emote, pic, user)
        }
        // save topics
        emote.topics.each { topicText ->
            Topic topic = Topic.findByText(topicText.toLowerCase())
            if (topic == null) {
                topic = new Topic(text: topicText.toLowerCase())
                topic.save(validate: true)
            }
        }
//		notificationService.notifyTitleUpdate(title, parentTitle, user)
    }


    def saveTitle(String emoteTitle, Emote emote, Picture pic, User user) {
        Title title = Title.findByTextIlike(emoteTitle)
		boolean created = false;
        if (title == null) {
            title = new Title(text: emoteTitle, category: emote.topics)
			created = true
            log.info "Saving title ${title}"
        } else {
            title.refreshUpdateTime()
            title.addCategory(emote.topics)
        }
        if (pic != null && pic.content.length > 0) {
            pic.save(flush: true)
            log.info("saved picture $pic.id for title $title.text of length $pic.content.length")
            if (pic.id != null)
                title.addPicture(pic.id)
        }
        title.save(validate: true, flush: true)
		if(created){
			//log.info "Registering author interest for title ${title}"
//			notificationService.registerInterest(emoteTitle, user, TitleInterest.Type.AUTHOR)
		}
		return title
    }

    def prepareExpressionIdeas(emote, ideas) {
        def expressions = emote.expressions
        def goodOrBads = emote.goodOrBads
        expressions.eachWithIndex{ it, index ->
			if(it != null && it.trim().size()> 0){
				log.info("adding expression"+it)
				ideas.add(new ExpressionIdea(text: it, goodOrBad: goodOrBads[index]))
			}
        }
        ideas
    }

    Set<Emote> search(String searchTerm, int pageIndex){
        log.info "searching for $searchTerm"
        Set<Emote> results = []
        def qresults = Emote.findAllByKeywords(searchTerm)
        log.info "search results $qresults"
        if (qresults != null) {results.addAll(qresults)}
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
		def userEmotes = Emote.findAllByUserId(userId, [max:feedPageSize, sort:"creationTime", order:"desc" , offset:feedPageSize*pageIndex])
		return userEmotes;
	}
	
	def groupByTitle (def emotes, User user){
		def followingUsers
		String currentUserId
		if (user != null) {
			followingUsers = user.followingUsers
			currentUserId = user.id
		}
		def groupedByTitle =  [:] 
		if(followingUsers != null && followingUsers.size()> 0){
			followingUsers = followingUsers + currentUserId
		}
		//log.info("emotes following usees $followingUsers, + $currentUserId")
		
		emotes.each {emote ->
			boolean canShow = false
			if(followingUsers == null || followingUsers.size() == 0 || followingUsers.contains(emote.userId) ||
				groupedByTitle.containsKey(emote.completeTitle.toUpperCase())){
				canShow = true
			}
	
			if(canShow){
				GroupByTitle title = groupedByTitle.get(emote.completeTitle.toUpperCase())
				if(title == null){
					Title titleObj = Title.findByText(emote.title)
					String picId = null	
					if(titleObj != null)	
						picId = titleObj.pictures != null && titleObj.pictures.size() > 0 ? titleObj.pictures[titleObj.pictures.size()-1]:null
					title = new GroupByTitle(title:emote.title, pictureId:picId, followingUsers:followingUsers, completeTitle:emote.completeTitle)
					groupedByTitle.put(emote.completeTitle.toUpperCase(), title)
				}
                title.completeTitle = emote.completeTitle
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
    def getSingleEmote(String title){
        String mainTitle= title
        String parentTitle= null
        String connector


        (mainTitle, connector, parentTitle) = extractTitles(title, mainTitle, parentTitle)
        Emote.findAllByTitleAndConnectorAndParentTitle(mainTitle, connector, parentTitle)
    }

    def extractTitles(String title, String mainTitle, String parentTitle) {
        mainTitle = title
        String connector= null
        if (grailsApplication.config.emote.title.connectors) {
            for (String it : grailsApplication.config.emote.title.connectors) {
                if (title.contains(" ${it} ")) {
                    parentTitle = title.substring(mainTitle.indexOf(" ${it} ") + " ${it} ".length(), mainTitle.length())
                    mainTitle = mainTitle.substring(0, mainTitle.indexOf(" ${it} "))
                    connector = it
                    return [mainTitle, connector, parentTitle]
                }
            }
        }
        [mainTitle, connector, parentTitle]
    }
	
	
	
}
