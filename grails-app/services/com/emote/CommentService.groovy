package com.emote

import com.emote.util.PagedResult
import org.hibernate.criterion.Order

class CommentService {

    /**
     * Pagination size
     */
    static final int PAGE_SIZE = 10

    /**
     * Saves a comment as a root comment for an {@linkplain Emote}
     * @param user Owner of the comment
     * @param comment Message
     * @param emoteId {@linkplain Emote} to which attach the comment
     * @return The created {@linkplain Comment}
     */
    Comment saveRootComment(User user, String comment, String emoteId) {
        new Comment(userId: user.id, parentEmoteId: emoteId, comment: comment, hasChild: false).save(flush: true)
    }

    /**
     * Saves a comment as a nested comment for a {@linkplain Comment}
     * @param user Owner of the comment
     * @param comment Message
     * @param parentCommentId {@linkplain Comment} to which attach the comment
     * @return The created {@linkplain Comment}
     */
    Comment saveNestedComment(User user, String comment, String parentCommentId) {
        new Comment(userId: user.id, parentCommentId: parentCommentId, comment: comment).save(flush: true)
        Comment parent = Comment.get(parentCommentId)
        parent.hasChild = true
        parent.save(flush: true)
    }

    private PagedResult<Comment> getPagedComments(Closure criteria, int page) {
        List<Comment> list = Comment.withCriteria {
            criteria.delegate = this
            criteria()

            setFirstResult(page * PAGE_SIZE)
            setMaxResults(PAGE_SIZE + 1)
            addOrder(Order.desc('dateCreated'))
        }

        def hasMoreResults = list.size() > PAGE_SIZE

        if(hasMoreResults) {
            list.remove(list.last())
        }

        new PagedResult<Comment>(list: list, moreResults: hasMoreResults, page: page)
    }

    /**
     * Gets paged root comments for an {@linkplain Emote}
     * @param page Number of page to retrieve. It's zero based.
     * @param emoteId Parent emote id to retrieve root comments from
     * @return Paged root comments for the emote
     */
    PagedResult<Comment> getRootComments(int page, String emoteId) {
        getPagedComments({
            eq('parentEmoteId', emoteId)
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
