package com.emote


class UserActionController {

    def userActionService

    def notification(){
        User user = session.user
        if(!user){
            return
        }
        def notifications = NotificationQueue.findAllByUserIdAndNotified(user.id,false)
        notifications.each {it.notified = true}
        NotificationQueue.saveAll(notifications)
        render(contentType: "text/json"){
            [notifications:notifications]
        }
    }

    def addDoing(){
        User user = session.user
        if(!user){
            redirect controller: 'user', action: 'signin'
            return
        }
        String title = params.title
        if(title){
            userActionService.addDoing user.id, title
            render(contentType: "text/json"){
                [success:"true"]
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
            userActionService.addFavouriteTitle user, title
            render(contentType: "text/json"){
                [success:"true"]
            }
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
            userActionService.removeFavouriteTopic user, title
            render(contentType: "text/json"){
                [success:"true"]
            }
        }
    }

    def emotePoint(){
        User user = session.user
        if(!user){
            redirect controller: 'user', action: 'signin'
            return
        }
        String emoteId = params.emote
        String point = params.point
        if(emoteId && point){
            userActionService.changePointToEmote(user, emoteId, UserEmotePoint.Point.valueOf(point))
            render(contentType: "text/json"){
                [success:"true"]
            }
        }
    }
}