package com.emote

class Comment {

    String id
    String userId
    String parentEmoteId
    Date dateCreated
    String comment
    String parentCommentId
    /**
     * Child comments indicator
     */
    Boolean hasChild = false

    static constraints = {
        userId blank: false
        comment blank: false
        hasChild nullable: false
    }
    static mapping = {
        dateCreated index: true
        parentEmoteId index: true
        parentCommentId index: true
        userId index: true
    }
}
