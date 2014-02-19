<li class="comment ${comment.hasChildren ? 'has-reply' : ''}" data-comment-id="${comment.id}">
    <div class="user-photo-comment">
        <img class="comment-author-photo" src="http://graph.facebook.com/${comment.facebookUserId}/picture?">
    </div>
    <div class="comment-body clearfix">
        <r:img class="commment-arrow" uri="/img/comment-arrow.png"/>
        <div class="comment-details clearfix"><span class="commentee-name">${comment.username}</span><span class="comment-time pull-right"><emoteapp:friendlyTime timestamp="${comment.dateCreated}"/></span></div>
        <p>${comment.comment}</p>
        <ul class="comment-toolbar pull-left clearfix silver-gradient gradient">
            <li class="comment-vote-count"><a href="#/">${comment.votesCount}</a></li>
            <li class="comment-up-vote ir"><a class="feeds-sprite" href="#/"></a></li>
            <li class="comment-down-vote ir"><a class="feeds-sprite" href="#/"></a></li>
            <li class="pull-right"><a href="#" class="reply-button">Reply</a></li>
        </ul>
    </div>
    <g:if test="${comment.hasChildren}">
    <ul class="replies" data-nested-comments="${comment.id}">
        %{--<g:each in="${pagedChildren.list}" var="nestedComm">--}%
            %{--<g:render template="/common/comment/nestedComment" model="[comment: nestedComm]"/>--}%
        %{--</g:each>--}%
    </ul>
    </g:if>
</li>