package com.emote

class FlagController {
    FlagService flagService
    def index() {}
    def save(Flag flag){
        log.warn("working?")
        flagService.create(flag);
        def results=[flag]
        render(contentType: "text/json"){results}
        /*render(contentType: "text/json") {
            array {
                for (t in results) {
                    element(t.text)
                }
            }

        }*/
    }
}
