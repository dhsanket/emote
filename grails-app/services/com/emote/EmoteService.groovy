package com.emote

class EmoteService {

    private int feedPageSize = 10;
    def grailsApplication

    def create(EmoteCommand emoteCmd, User user, Picture pic) {
        def username = user.firstName + " " + user.lastName
        def parentTitle = null
        String emoteTitle = emoteCmd.title
        String connector
        (emoteTitle, connector, parentTitle) = extractTitles(emoteCmd.title, emoteTitle, parentTitle)
        Set<ExpressionIdea> ideas = new HashSet<>()
        prepareExpressionIdeas(emoteCmd, ideas)
        Emote emote = new Emote(
                userId: user.id, creator: user, username: username, topics: emoteCmd.category, parentTitle: parentTitle,
                connector: connector, expressionIdeas: ideas, title: emoteTitle, facebookId: user.facebookId
        )


        def nonEmptyExpression = []
        emote.expressions.each { exp ->
            if (exp.trim().length() > 0) {
                nonEmptyExpression.add(exp)
            }
        }
        emote.expressions = nonEmptyExpression

        emote.populateKeywords()

        emote.save(validate: true)
        // save title if does not exist else update time
        saveTitle(emoteTitle, emote, pic)
        if (parentTitle) {
            saveTitle(parentTitle, emote, pic)
        }
        notifyOtherUsers(emoteTitle, parentTitle,"", user)

        // save topics
        emote.topics.each { topicText ->
            Topic topic = Topic.findByText(topicText.toLowerCase())
            if (topic == null) {
                topic = new Topic(text: topicText.toLowerCase())
                topic.save(validate: true)
            }
        }


    }

    def notifyOtherUsers(String title, String parentTitle, String message, User currentUser) {
        def interestList = []
        def userFavouriteTitle = []
        def userFavouriteParentTitle = []
        interestList += TitleInterest.findAllByTitleAndUserIdNotEqual(title, currentUser.id)
        if (parentTitle) {
            interestList += TitleInterest.findAllByTitleAndUserIdNotEqual(parentTitle, currentUser.id)
        }
        interestList.each {
            new NotificationQueue(title: it.title, userId: it.userId, message: message).save()
        }
        userFavouriteTitle = UserFavourite.findAll { userId != currentUser.id && inList('favouriteTitles', title) }
        userFavouriteTitle.each {
            new NotificationQueue(title: title, userId: it.userId, message: message).save()
        }
        if(parentTitle){
            userFavouriteParentTitle = UserFavourite.findAll { userId != currentUser.id && inList('favouriteTitles', parentTitle) }
            userFavouriteParentTitle.each {
                new NotificationQueue(title: parentTitle, userId: it.userId, message: message).save()
            }
        }
    }

    def saveTitle(String emoteTitle, Emote emote, Picture pic) {
        Title title = Title.findByTextIlike(emoteTitle)
        if (title == null) {
            title = new Title(text: emoteTitle, category: emote.topics)
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
        title.save(validate: true)
    }

    def prepareExpressionIdeas(emote, ideas) {
        def expressions = emote.expressions
        def goodOrBads = emote.goodOrBads
        expressions.eachWithIndex { it, index ->
            ideas.add(new ExpressionIdea(text: it, goodOrBad: goodOrBads[index]))
        }
        ideas
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

	def groupByTitle (def emotes, Set<String> followingUsers, String currentUserId){
		def groupedByTitle =  [:]
		if(followingUsers != null && followingUsers.size()> 0){
			followingUsers = followingUsers + currentUserId
		}
		log.info("emotes following usees $followingUsers, + $currentUserId")

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
