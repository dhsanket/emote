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
        <li class="comment" data-bind="css: {'has-reply': children().length > 0}">
            <div class="user-photo-comment">
                <img class="comment-author-photo" data-bind="attr: {src: controller.profilePicture($data)}">
            </div>
            <div class="comment-body clearfix">
                <r:img class="commment-arrow" uri="/img/comment-arrow.png"/>
                <div class="comment-details clearfix">
                    <span class="commentee-name" data-bind="text: username"></span>
                    <span class="comment-time pull-right" data-bind="text: dateCreated"></span>
                </div>
                <p data-bind="text: comment"></p>
                <ul class="comment-toolbar pull-left clearfix silver-gradient gradient">
                    %{--<li class="comment-vote-count"><a href="#/" data-bind="text: votesCount"></a></li>--}%
                    %{--<li class="comment-up-vote ir"><a class="feeds-sprite" href="#/"></a></li>--}%
                    %{--<li class="comment-down-vote ir"><a class="feeds-sprite" href="#/"></a></li>--}%
                    <li class="pull-right"><a href="#" class="reply-button" data-bind="click: controller.showCommentDialog">Reply</a></li>
                </ul>
            </div>
            <ul class="replies" data-bind="foreach: children">
                <li class="reply">
                    <img class="comment-author-photo" data-bind="attr: {src: controller.profilePicture($data)}">

                    <div class="comment-body clearfix">
                        <r:img class="commment-arrow" uri="/img/comment-arrow.png"/>
                        <p data-bind="text: comment"></p>
                        %{--<ul class="comment-toolbar pull-left clearfix silver-gradient gradient">--}%
                            %{--<li class="comment-vote-count"><a href="#/" data-bind="text: votesCount"></a></li>--}%
                            %{--<li class="comment-up-vote ir"><a class="feeds-sprite" href="#/"></a></li>--}%
                            %{--<li class="comment-down-vote ir"><a class="feeds-sprite" href="#/"></a></li>--}%
                        %{--</ul>--}%
                    </div>
                </li>
            </ul>

            <div data-bind="if: $data.pagingData().hasMoreResults" style="margin-bottom: 10px; margin-left: 44px;">
                <button class="button grey-gradient gradient long" style="width: 100%" data-bind="click: controller.loadNestedComments">
                    <strong>Load more replies</strong>
                </button>
            </div>
        </li>
    </ul>
    <div data-bind="if: pagingData().hasMoreResults">
        <button class="button grey-gradient gradient long" style="width: 100%" data-bind="click: controller.loadRootComments">
            <strong>Load more comments</strong>
        </button>
    </div>
</div>

<!-- Comment Dialog -->
<g:form controller="comment" action="save" name="commentSave" class="hidden" data-bind="submit: controller.saveComment">
    <input type="hidden" id="parentId" name="parentId">
    <input type="hidden" id="mode" name="mode">
    <div id="comment-creation-container">
        <div class="data-set clearfix">
            <img class="comment-author-pic" src="http://graph.facebook.com/${session.user.facebookId}/picture?">
            <div class="comment-dialog-body">
                <textarea id="commentMsg" name="commentMsg" placeholder="${message(code: 'emote.comment.msg.placeholder')}"></textarea>
            </div>
            <button type="submit" id="post-emote" class="button icon-button grey-gradient big gradient pull-right" value="Save"><span class="edit-button"></span>${message(code: 'emote.comment.post.btn.label')}</button>
            <button type="button" class="button grey-gradient big gradient pull-right" value="Cancel" onclick="hideCommentDialog();">${message(code: 'emote.comment.cancel.btn.label')}</button>
        </div> <!-- /.data-set -->
    </div> <!-- /#comment-creation-container -->
</g:form>

<r:script>
    var controller;

    $(function() {
        // Activates knockout.js
        controller = new CommentsPage('<g:createLink controller="comment" action="get"/>', '${title.id}', ${title.titleObj.commentsCount});
        ko.applyBindings(controller);
    });
</r:script>