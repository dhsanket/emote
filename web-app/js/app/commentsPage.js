function CommentsPage(getCommentsUrl, titleId) {
    this.getCommentsUrl = getCommentsUrl;
    this.titleId = titleId;
    this.comments = ko.observableArray();
    this.pagingData = ko.observable({hasMoreResults: true, pageNbr: -1});

    this.profilePicture = function(comment) {
        return "http://graph.facebook.com/" + comment.facebookUserId + "/picture?";
    };

    this.showCommentDialog = function(comment) {
        showCommentDialog(comment.id, 'reply');
    };

    this.loadRootComments = function() {
        $.get(this.getCommentsUrl, {page: this.pagingData().pageNbr + 1, id: this.titleId, mode: 'title'}, function(result){
            controller.pagingData(result.pagingData);

            $.each(result.comments, function(i, val) {
                var originalChildrens = val.children;
                val.children = ko.observableArray();
                $.each(originalChildrens, function(j, child) {
                    val.children().push(child);
                });
                controller.comments.push(val);
            });
        });
    };

    this.saveComment = function () {
        var form = $('form#commentSave');
        var targetUrl = form.attr('action');

        $.post(targetUrl, form.serialize(), function(comment) {
            if(!comment.parentCommentId) {
                // It is a root comment
                comment.children = ko.observableArray();
                controller.comments().unshift(comment);
            } else {
                // It is a reply
                $.each(controller.comments(), function(index, rootComment) {
                    if(rootComment.id == comment.parentCommentId) {
                        rootComment.children().unshift(comment);
                    }
                });
            }

            hideCommentDialog();
        });
    };

    this.loadRootComments();
}