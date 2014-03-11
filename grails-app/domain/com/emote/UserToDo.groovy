package com.emote

class UserToDo {

    Date dateCreated
    String userId
    String title;

    static constraints = {
        userId nullable: false
        title nullable: false
    }

    static mapping = {
        userId index: true
        title index: true
        dateCreated index: true
    }
}
