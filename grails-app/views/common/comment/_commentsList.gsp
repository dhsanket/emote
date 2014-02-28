<r:require module="commentsPage"/>

<div class="comments-container clearfix">
    <div class="comments-header clearfix">
        <span class="comments-heading">Top comments</span>
        <g:if test="${session.user}">
            <button class="button grey-gradient gradient long pull-right" onclick="showCommentDialog('${title.id}', 'title')">
                <strong>${message(code: 'emote.new.comment.btn.label')}</strong>
            </button>
        </g:if>
    </div>
    <ul class="comments" data-bind="foreach: comments">
        <li class="comment" data-bind="css: {'has-reply': children.length > 0}">
            <div class="user-photo-comment">
                <img class="comment-author-photo" data-bind="attr: {src: $parent.profilePicture($data)}">
            </div>
            <div class="comment-body clearfix">
                <r:img class="commment-arrow" uri="/img/comment-arrow.png"/>
                <div class="comment-details clearfix">
                    <span class="commentee-name" data-bind="text: username"></span>
                    <span class="comment-time pull-right" data-bind="text: dateCreated"></span>
                </div>
                <p data-bind="text: comment"></p>
                <ul class="comment-toolbar pull-left clearfix silver-gradient gradient">
                    <li class="comment-vote-count"><a href="#/" data-bind="text: votesCount"></a></li>
                    <li class="comment-up-vote ir"><a class="feeds-sprite" href="#/"></a></li>
                    <li class="comment-down-vote ir"><a class="feeds-sprite" href="#/"></a></li>
                    <li class="pull-right"><a href="#" class="reply-button" data-bind="click: $parent.showCommentDialog">Reply</a></li>
                </ul>
            </div>
            <ul class="replies" data-bind="foreach: children">
                <li class="reply">
                    <img class="comment-author-photo" data-bind="attr: {src: $parent.profilePicture($data)}">

                    <div class="comment-body clearfix">
                        <r:img class="commment-arrow" uri="/img/comment-arrow.png"/>
                        <p data-bind="text: comment"></p>
                        <ul class="comment-toolbar pull-left clearfix silver-gradient gradient">
                            <li class="comment-vote-count"><a href="#/" data-bind="text: votesCount"></a></li>
                            <li class="comment-up-vote ir"><a class="feeds-sprite" href="#/"></a></li>
                            <li class="comment-down-vote ir"><a class="feeds-sprite" href="#/"></a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </li>
    </ul>
</div>

<r:script>
    var controller;

    $(function() {
        // Activates knockout.js
        controller = new CommentsPage('<g:createLink controller="comment" action="get"/>', '${title.id}');
        ko.applyBindings(controller);
    });
</r:script>