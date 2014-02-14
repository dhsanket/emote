package com.emote

import com.emote.util.PagedResult

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

        [result: comments]
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

        if("title".equalsIgnoreCase(mode)) {
            comment = commentService.saveRootComment(user, commentMsg, parentId)
        } else {
            comment = commentService.saveNestedComment(user, commentMsg, parentId)
        }

        [comment: comment, pagedChildren: new PagedResult<Comment>()]
    }
}
