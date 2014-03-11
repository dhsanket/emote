function CommentsPage(getCommentsUrl, voteUrl, titleId, commentsCount, loggedIn) {
    var self = this;
    self.getCommentsUrl = getCommentsUrl;
    self.commentsCount = ko.observable(commentsCount);
    self.titleId = titleId;
    self.comments = ko.observableArray();
    self.pagingData = ko.observable({hasMoreResults: true, pageNbr: -1});
    self.loggedIn = loggedIn;
    self.voteUrl = voteUrl;

    self.commentsCountMsg = ko.computed(function() {
        return self.commentsCount() + " Comments";
    });

    self.profilePicture = function(comment) {
        return "http://graph.facebook.com/" + comment.facebookUserId + "/picture?";
    };

    self.showCommentDialog = function(comment) {
        if(self.loggedIn) {
            showCommentDialog(comment.id, 'reply');
        }
    };

    var bindComment = function(comment) {
        if(comment.children) {
            var wrappedChildren = ko.observableArray();
            $.each(comment.children, function(j, child) {
                child.votesCount = ko.observable(child.votesCount);
                child.vote = ko.observable(child.vote);
                wrappedChildren.push(ko.observable(child));
            });
            comment.children = wrappedChildren;
        }
        comment.votesCount = ko.observable(comment.votesCount);
        comment.vote = ko.observable(comment.vote);
        comment.pagingData = ko.observable(comment.pagingData);
        return ko.observable(comment);
    };

    self.loadRootComments = function() {
        $.get(self.getCommentsUrl, {page: self.pagingData().pageNbr + 1, id: self.titleId, mode: 'title'}, function(result){
            self.pagingData(result.pagingData);

            $.each(result.comments, function(i, val) {
                self.comments.push(bindComment(val));
            });
        });
    };

    self.loadNestedComments = function() {
        var comment = this;

        $.get(self.getCommentsUrl, {page: self.pagingData().pageNbr + 1, id: comment.id, mode: 'reply'}, function(result){
            comment.pagingData(result.pagingData);
            $.each(result.comments, function(index, reply) {
                comment.children.push(bindComment(reply));
            });
        });
    };

    self.saveComment = function () {
        var form = $('form#commentSave');
        var targetUrl = form.attr('action');

        $.post(targetUrl, form.serialize(), function(comment) {
            if(!comment.parentCommentId) {
                // It is a root comment
                self.comments.unshift(bindComment(comment));
            } else {
                // It is a reply
                $.each(self.comments(), function(index, rootComment) {
                    if(rootComment.id == comment.parentCommentId) {
                        rootComment.children.unshift(bindComment(comment));
                    }
                });
            }

            self.commentsCount(self.commentsCount() + 1);

            hideCommentDialog();
        });
    };

    self.canVote = function(comment) {
        return self.loggedIn && (comment.vote() ? false : true);
    };

    self.updateCommentWithVote = function(data, commentId, isUpVote) {
        if(data.status == 'error') {
            return;
        }

        $.each(self.comments(), function(i, rc) {
            var rootComment = rc();
            if(rootComment.id == commentId) {
                rootComment.votesCount(data.votesCount);
                rootComment.vote(data.vote);
                return;
            }

            $.each(rootComment.children(), function(j, cc) {
                var childComment = cc();
                if(childComment.id == commentId) {
                    childComment.votesCount(data.votesCount);
                    childComment.vote(data.vote);
                    return;
                }
            });
        });
    };

    self.upVote = function(comment) {
        $.post(self.voteUrl, {commentId: comment.id, mode: 'upVote'}, function(data){self.updateCommentWithVote(data, comment.id)});
    };

    self.downVote = function(comment) {
        $.post(self.voteUrl, {commentId: comment.id, mode: 'downVote'}, function(data){self.updateCommentWithVote(data, comment.id)});
    };

    self.loadRootComments();
}