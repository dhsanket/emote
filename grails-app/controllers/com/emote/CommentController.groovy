package com.emote

import com.emote.util.PagedResult
import grails.converters.JSON

class CommentController {

    CommentService commentService

    /**
     * Load comments for a {@linkplain Title} or a {@linkplain Comment}
     * @param page Page number to get paged results
     * @param id Id of {@linkplain Title} or {@linkplain Comment} to retrieve comments from
     * @param mode "title" or "comment", where to load comments from
     */
    def get(int page, String id, String mode) {
        PagedResult<Comment> comments

        if("title".equalsIgnoreCase(mode)) {
            comments = commentService.getRootComments(page, id)
        } else {
            comments = commentService.getNestedComments(page, id)
        }

        def result = [
            pagingData: [
                hasMoreResults: comments.moreResults,
                pageNbr: comments.page
            ],
            comments: comments.list.collect {
                PagedResult<Comment> childrenResult = commentService.getNestedComments(0, it.id)

                [
                    id: it.id,
                    parentCommentId: it.parentCommentId,
                    comment: it.comment,
                    children: childrenResult.list.collect {Comment child -> [
                        id: child.id,
                        parentCommentId: child.parentCommentId,
                        comment: child.comment,
                        username: child.username,
                        facebookUserId: child.facebookUserId,
                        dateCreated: emoteapp.friendlyTime(timestamp: child.dateCreated),
                        votesCount: child.votesCount
                    ]},
                    username: it.username,
                    facebookUserId: it.facebookUserId,
                    dateCreated: emoteapp.friendlyTime(timestamp: it.dateCreated),
                    votesCount: it.votesCount,
                    hasMoreReplies: childrenResult.moreResults
                ]
            }
        ]

        render(result as JSON)
    }

    /**
     * Saves a new comment
     * @param commentMsg Message for the comment
     * @param parentId Id of the {@linkplain Title} or {@linkplain Comment} that this comment will be added to
     * @param mode "title" or "comment" that the id identifies
     */
    def save(String commentMsg, String parentId, String mode) {
        User user = session.user
        Comment comment

        if('title'.equalsIgnoreCase(mode)) {
            comment = commentService.saveRootComment(user, commentMsg, parentId)
        } else {
            comment = commentService.saveNestedComment(user, commentMsg, parentId)
        }

        def result = [
            id: comment.id,
            parentCommentId: comment.parentCommentId,
            comment: comment.comment,
            children: [],
            username: comment.username,
            facebookUserId: comment.facebookUserId,
            dateCreated: emoteapp.friendlyTime(timestamp: comment.dateCreated),
            votesCount: comment.votesCount,
            hasMoreReplies: false
        ]

        render(result as JSON)
    }
}
