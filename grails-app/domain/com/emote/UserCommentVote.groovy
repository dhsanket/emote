package com.emote

class UserCommentVote {

    String id
    String userId
    String commentId
    Boolean upVote = true

    static constraints = {
        userId nullable: false
        commentId nullable: false
        upVote nullable: false
    }

    static mapping = {
        userId index: true
        commentId index: true
        upVote index: true
    }
}
