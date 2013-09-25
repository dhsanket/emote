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
}
