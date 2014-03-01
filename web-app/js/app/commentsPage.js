function CommentsPage(getCommentsUrl, titleId, commentsCount) {
    var self = this;
    self.getCommentsUrl = getCommentsUrl;
    self.commentsCount = ko.observable(commentsCount);
    self.titleId = titleId;
    self.comments = ko.observableArray();
    self.pagingData = ko.observable({hasMoreResults: true, pageNbr: -1});

    self.commentsCountMsg = ko.computed(function() {
        return self.commentsCount() + " Comments";
    });

    self.profilePicture = function(comment) {
        return "http://graph.facebook.com/" + comment.facebookUserId + "/picture?";
    };

    self.showCommentDialog = function(comment) {
        showCommentDialog(comment.id, 'reply');
    };

    self.loadRootComments = function() {
        $.get(self.getCommentsUrl, {page: self.pagingData().pageNbr + 1, id: self.titleId, mode: 'title'}, function(result){
            self.pagingData(result.pagingData);

            $.each(result.comments, function(i, val) {
                val.children = ko.observableArray(val.children);
                val.pagingData = ko.observable(val.pagingData);

                self.comments.push(val);
            });
        });
    };

    self.loadNestedComments = function() {
        var comment = this;

        $.get(self.getCommentsUrl, {page: self.pagingData().pageNbr + 1, id: comment.id, mode: 'reply'}, function(result){
            comment.pagingData(result.pagingData);
            $.each(result.comments, function(index, reply) {
                comment.children.push(reply);
            });
        });
    };

    self.saveComment = function () {
        var form = $('form#commentSave');
        var targetUrl = form.attr('action');

        $.post(targetUrl, form.serialize(), function(comment) {
            if(!comment.parentCommentId) {
                // It is a root comment
                comment.children = ko.observableArray();
                comment.pagingData = ko.observable(comment.pagingData);
                self.comments.unshift(comment);
            } else {
                // It is a reply
                $.each(self.comments(), function(index, rootComment) {
                    if(rootComment.id == comment.parentCommentId) {
                        rootComment.children.unshift(comment);
                    }
                });
            }

            self.commentsCount(self.commentsCount() + 1);

            hideCommentDialog();
        });
    };

    self.loadRootComments();
}