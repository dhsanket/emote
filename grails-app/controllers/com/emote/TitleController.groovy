package com.emote

import grails.converters.JSON

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

    def addInToDoList(String title) {
        User user = session.user as User

        emoteService.addTitleInToDoList(title, user)

        render([success: true] as JSON)
    }

    def removeFromToDoList(String title) {
        User user = session.user as User

        emoteService.removeFromToDoList(title, user)

        render([success: true] as JSON)
    }
}
