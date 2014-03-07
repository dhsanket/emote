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
        User user = session.user
        PagedResult<Comment> comments

        if("title".equalsIgnoreCase(mode)) {
            comments = commentService.getRootComments(page, id)
        } else {
            comments = commentService.getNestedComments(page, id)
        }

        Map<String, PagedResult<Comment>> rootCommentsMap = [:]

        comments.list.each {
            rootCommentsMap << [comment: it, children: commentService.getNestedComments(0, it.id)]
        }

        List<String> commentIds = []

        rootCommentsMap.keySet().each { String commentId ->
            commentIds << commentId

            rootCommentsMap.get(commentId).list.each { Comment childComment ->
                commentId << childComment.id
            }
        }

        Set<String> alreadyVotedCommentIds = new HashSet<String>()

        UserCommentVote.withTransaction {
            alreadyVotedCommentIds.addAll(UserCommentVote.createCriteria().list {
                projections {
                    property('commentId')
                }
                eq('userId', user.id)
                inList('commentId', commentIds)
            })
        }

        def result = [
            pagingData: [
                hasMoreResults: comments.moreResults,
                pageNbr: comments.page
            ],
            comments: comments.list.collect {
                PagedResult<Comment> childrenResult = rootCommentsMap.get(it.id)

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
                        votesCount: child.votesCount,
                        canVote: alreadyVotedCommentIds.contains(child.id)
                    ]},
                    username: it.username,
                    facebookUserId: it.facebookUserId,
                    dateCreated: emoteapp.friendlyTime(timestamp: it.dateCreated),
                    votesCount: it.votesCount,
                    canVote: alreadyVotedCommentIds.contains(it.id),
                    pagingData: [
                        hasMoreResults: childrenResult.moreResults,
                        pageNbr: childrenResult.page
                    ]
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
            pagingData: [
                hasMoreResults: false,
                pageNbr: -1
            ]
        ]

        render(result as JSON)
    }

    /**
     * Method to vote on a comment
     * @param commentId Id of a {@linkplain Comment} to vote on
     * @param mode Should be one of 'upVote' or 'downVote'
     */
    def vote(String commentId, String mode) {
        User user = session.user as User
        Comment comment = Comment.get(commentId)
        UserCommentVote vote = UserCommentVote.findByUserIdAndCommentId(user.id, comment.id)
        String errorMsg = null

        if(vote) {
            errorMsg = message(code: 'emote.comment.vote.error.already.voted')
        } else {
            UserCommentVote.withTransaction {
                vote = new UserCommentVote(userId: user.id, commentId: comment.id, upVote: 'upVote'.equalsIgnoreCase(mode)).save()
                comment.votesCount += (vote.upVote ? 1 : -1)
                comment.save()
            }
        }

        def result = [
            status: errorMsg ? 'error' : 'success',
            msg: errorMsg ?: null,
            votesCount: comment.votesCount
        ]

        render(result as JSON)
    }
}
