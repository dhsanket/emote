package com.emote

import com.emote.util.PagedResult

class CommentController {

    CommentService commentService

    /**
     * Load comments for an {@linkplain Emote} or a {@linkplain Comment}
     * @param page Page number to get paged results
     * @param id Id of {@linkplain Emote} or {@linkplain Comment} to retrieve comments from
     * @param mode "emote" or "comment", where to load comments from
     */
    def get(int page, String id, String mode) {
        PagedResult<Comment> comments

        if("emote".equalsIgnoreCase(mode)) {
            comments = commentService.getRootComments(page, id)
        } else {
            comments = commentService.getNestedComments(page, id)
        }

        [result: comments]
    }

    /**
     * Saves a new comment
     * @param commentMsg Message for the comment
     * @param id Id of the {@linkplain Title} or {@linkplain Comment} that this comment will be added to
     * @param mode "title" or "comment" that the id identifies
     */
    def save(String commentMsg, String id, String mode) {

    }
}
