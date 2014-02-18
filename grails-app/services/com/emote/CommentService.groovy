package com.emote

import com.emote.util.PagedResult

class CommentService {

    static transactional = 'mongo'

    /**
     * Pagination size
     */
    static final int PAGE_SIZE = 10

    /**
     * Saves a comment as a root comment for a {@linkplain Title}
     * @param user Owner of the comment
     * @param comment Message
     * @param parentId {@linkplain Title} to which attach the comment
     * @return The created {@linkplain Comment}
     */
    Comment saveRootComment(User user, String comment, String parentId) {
        new Comment(userId: user.id, facebookUserId: user.facebookId, username: "$user.firstName $user.lastName",
                titleId: parentId, comment: comment, hasChildren: false).save()
    }

    /**
     * Saves a comment as a nested comment for a {@linkplain Comment}
     * @param user Owner of the comment
     * @param comment Message
     * @param parentCommentId {@linkplain Comment} to which attach the comment
     * @return The created {@linkplain Comment}
     */
    Comment saveNestedComment(User user, String comment, String parentCommentId) {
        Comment parent = Comment.get(parentCommentId)
        parent.hasChildren = true
        parent.save()
        new Comment(userId: user.id, facebookUserId: user.facebookId, username: "$user.firstName $user.lastName",
                titleId: parent.titleId,parentCommentId: parentCommentId, comment: comment).save()
    }

    private PagedResult<Comment> getPagedComments(Closure criteria, int page) {
        List<Comment> list = Comment.withCriteria(offset: page * PAGE_SIZE, max: PAGE_SIZE + 1) {
            criteria.delegate = delegate
            criteria()

            order('dateCreated', 'desc')
        }

        def hasMoreResults = list.size() > PAGE_SIZE

        if(hasMoreResults) {
            list.remove(list.last())
        }

        new PagedResult<Comment>(list: list, moreResults: hasMoreResults, page: page)
    }

    /**
     * Gets paged root comments for a {@linkplain Title}
     * @param page Number of page to retrieve. It's zero based.
     * @param titleId Title id to retrieve root comments from
     * @return Paged root comments for the emote
     */
    PagedResult<Comment> getRootComments(int page, String titleId) {
        getPagedComments({
            eq('titleId', titleId)
        }, page)
    }

    /**
     * Gets paged nested comments for a {@linkplain Comment}
     * @param page Number of page to retrieve. It's zero based.
     * @param emoteId Parent comment id to retrieve comments from
     * @return Paged comments for the comment
     */
    PagedResult<Comment> getNestedComments(int page, String parentCommentId) {
        getPagedComments({
            eq('parentCommentId', parentCommentId)
        }, page)
    }
}
