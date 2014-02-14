package com.emote

class Comment {

    String id
    String userId
    String facebookUserId
    String username
    String titleId
    Date dateCreated
    String comment
    String parentCommentId
    Integer votesCount = 0

    /**
     * Child comments indicator
     */
    Boolean hasChildren = false

    static constraints = {
        parentCommentId nullable: true
        userId blank: false
        facebookUserId blank: false
        comment blank: false
        hasChildren nullable: false
        titleId blank: false
        username blank: false
    }
    static mapping = {
        dateCreated index: true
        titleId index: true
        parentCommentId index: true
        userId index: true
        votesCount index: true
    }
}
