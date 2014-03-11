package com.emote

import grails.plugin.facebooksdk.FacebookContext
import grails.plugin.facebooksdk.FacebookGraphClient

class EmoteController {
	
	EmoteService emoteService
	UserService userService

	FacebookContext facebookContext;
	FacebookGraphClient facebookGraphClient;

	PictureService pictureService;
    CommentService commentService
    TitleService titleService
	

    def create() {
		
	}
	
    def index(){
		
	} 
	
	
	def save(EmoteCommand emote){
		User user = session.user
		if(user == null){
			//temp changes remove later
//			user = User.findByEmail('nkarmuse@gmail.com')
			redirect(controller:'user' , action:'signin')
			return;
		}
		log.info "logged user is ${user.id}"
		
		if(emote.hasErrors()){
			log.info "emote has errors"
			//render view:'create', model:[emote:emote]
			StringBuilder errors = new StringBuilder()
			emote.errors.allErrors.each{
				errors.append(it).append("\n")
			}
			log.warn "emote post errors $errors"
			render(errors.toString())
			return
		}

		emoteService.create(emote,  user)
		def titles = emoteService.groupByTitle(emoteService.feed(0), session.user as User)
        fillUserStatusVars(titles.collect {it.completeTitle}, session.user?.id as String)
		flash.titles = titles
		render view:'feed'

	}

    def savePhoto(PhotoCommand photoCommand) {
        Picture pic = null;

        if(photoCommand.photo != null && photoCommand.photo.bytes.size() >0){
            //log.info "got a picture of size $emote.photo.bytes.size()"
            pic = pictureService.crop(photoCommand.photo, photoCommand.topxInt, photoCommand.topyInt, photoCommand.bottomxInt,
                    photoCommand.bottomyInt, photoCommand.scaledImgWidthInt, photoCommand.scaledImgHeightInt)
        }else if(photoCommand.webSearchImageURL != null && photoCommand.webSearchImageURL.size() > 0){
            log.info "got a web picture  $photoCommand.webSearchImageURL"
            pic = pictureService.crop(photoCommand.webSearchImageURL, photoCommand.topxInt, photoCommand.topyInt,
                    photoCommand.bottomxInt, photoCommand.bottomyInt, photoCommand.scaledImgWidthInt, photoCommand.scaledImgHeightInt) as Picture
        }

        emoteService.addPicture(photoCommand.title, pic)

        redirect(action: 'feed')
    }

    private fillUserStatusVars(Collection<String> titles, String userId) {
        Set<String> favourites = []

        if(userId) {
            def userFav = UserFavourite.findByUserId(userId)

            if(userFav) {
                favourites = userFav.favouriteTitles
            }
        }

        flash.favourites = favourites
        flash.doingNow = titleService.filterDoingNow(titles, userId)
        flash.inToDoList = titleService.filterInToDoList(titles, userId)
    }
	
	def feed(){
		int page = getPageIndex();
		def posts = emoteService.groupByTitle(emoteService.feed(page),session.user as User)
		int postCount = posts!=null ? posts.size():0
		 // not the best way to handle end of pages but we can live with it for now
		if(checkLastPageAndSetPaginationAttributes(page, postCount, "feed", [:])){
			posts = emoteService.groupByTitle(emoteService.feed(page-1),session.user as User)
		}

        fillUserStatusVars(posts.collect {it.completeTitle}, session.user?.id as String)
		flash.titles = posts 
	}

	def userFeed(){
		String userId = params.userId
		if(userId == null || userId.trim().length()== 0)
		{
			userId = session.user.id
		}
		int page = getPageIndex();
		def posts = emoteService.groupByTitle(emoteService.userFeed(userId, page), null)
		int postCount = posts!=null ? posts.size():0
		 // not the best way to handle end of pages but we can live with it for now
		if(checkLastPageAndSetPaginationAttributes(page, postCount, "userFeed", [userId:params.userId])){
			posts = emoteService.groupByTitle(emoteService.userFeed(userId, page-1), null)
		}

        fillUserStatusVars(posts.collect {it.completeTitle}, userId)
        flash.user = userService.findById(userId)
        flash.titles = posts
	}

    def showToDoList(){
        int page = getPageIndex();
        def posts = emoteService.groupByTitle(emoteService.toDoFeed(page), session.user as User)
        int postCount = posts!=null ? posts.size():0
        // not the best way to handle end of pages but we can live with it for now
        if(checkLastPageAndSetPaginationAttributes(page, postCount, "showToDoList", [:])){
            posts = emoteService.groupByTitle(emoteService.toDoFeed(page-1),session.user as User)
        }

        fillUserStatusVars(posts.collect {it.completeTitle}, session.user?.id as String)
        flash.titles = posts

        render(view: 'feed')
    }
	
	def search(){
		int page = getPageIndex();
		String searchTerm = params.keyword.toLowerCase();
		log.info "lowercase ofthe keyword: $searchTerm"
		def posts = emoteService.groupByTitle(emoteService.search(searchTerm, page), null)
		int postCount = posts!=null ? posts.size():0
		 // not the best way to handle end of pages but we can live with it for now
		if(checkLastPageAndSetPaginationAttributes(page, postCount, "search", [keyword:searchTerm])){
			posts = emoteService.groupByTitle(emoteService.search(searchTerm, page-1), null)
		}
		flash.titles = posts
		render view:'feed'
	}
		
	def singleTitle(){
		User user = session.user
		def emotes = emoteService.getSingleEmote(params.titleString as String);
		if(emotes!= null && emotes.size() >0){
            List<GroupByTitle> titles = emoteService.groupByTitle(emotes, user)
			flash.titles = titles
            flash.showComments = true
            fillUserStatusVars(titles.collect {it.completeTitle}, user?.id)

//            if(titles.size() > 0) {
//                flash.comments = commentService.getRootComments(0, titles.first().id)
//            }
		}
		render view:"feed"
	}
	
	private int getPageIndex(){
		int page = 0;
		if(params.page){
			page = Integer.parseInt(params.page as String)
		}
		return page
	}
	
	private boolean checkLastPageAndSetPaginationAttributes(int page, int postsSize, String action, def extraParams){
		boolean morePages = true
		if(page > 0 && postsSize == 0){
			page = page-1
			morePages = false;
		}
		flash.morePages = morePages
		flash.page = page
		flash.action = action
		flash.extraParams = extraParams
		return !morePages
	}
	

}
