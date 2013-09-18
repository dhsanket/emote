package com.emote

class TitleController {
	EmoteService emoteService
    TitleService titleService
    def autocomplete() {
		def results = emoteService.findTitles(params.term)
		log.info results
		render(contentType: "text/json") {
			 array {
				for (t in results) {
					element(t.text)
				}
			}
		}
	}

    def addFavouriteTitle(){
        User user = session.user
        if(!user){
            redirect controller: 'user', action: 'signin'
            return
        }
        String title = params.title
        if(title){
            titleService.addFavouriteTitle user, title
        }
    }

    def removeFavouriteTitle(){
        User user = session.user
        if(!user){
            redirect controller: 'user', action: 'signin'
            return
        }
        String title = params.title
        if(title){
            titleService.removeFavouriteTopic user, title
        }
    }

}
