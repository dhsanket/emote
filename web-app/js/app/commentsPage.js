function CommentsPage(getCommentsUrl, titleId) {
    this.getCommentsUrl = getCommentsUrl;
    this.comments = ko.observableArray();

    this.profilePicture = function(comment) {
        return "http://graph.facebook.com/" + comment.facebookUserId + "/picture?";
    };

    this.showCommentDialog = function(comment) {
        showCommentDialog(comment.id, 'reply');
    };

    $.get(this.getCommentsUrl, {page: 0, id: titleId, mode: 'title'}, function(result){
        $.each(result.comments, function(i, val) {
            controller.comments.push(val);
        });
    });
}