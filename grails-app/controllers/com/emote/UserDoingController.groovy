package com.emote


class UserDoingController {

    def userDoingService

    def addDoing(){
        User user = session.user
        if(!user){
            redirect controller: 'user', action: 'signin'
            return
        }
        String title = params.title
        if(title){
            userDoingService.addDoing user.id, title
        }

    }

}
