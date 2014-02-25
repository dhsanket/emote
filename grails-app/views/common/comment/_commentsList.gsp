<div class="comments-container clearfix">
    <div class="comments-header clearfix">
        <span class="comments-heading">Top comments</span>
        <g:if test="${session.user}">
            <button class="button grey-gradient gradient long pull-right" onclick="showCommentDialog('${title.id}', 'title')">
                <strong>${message(code: 'emote.new.comment.btn.label')}</strong>
            </button>
        </g:if>
    </div>
    <ul class="comments">
        %{--<g:each in="${comments.list}" var="comment">--}%
            %{--<g:render template="/common/comment/rootComment" model="[comment: comment]"/>--}%
        %{--</g:each>--}%
    </ul>
</div>

<script id="rootCommentTmpl" type="text/x-jquery-tmpl">
    {%each comments%}
    <li class="comment {%if children.length > 0 %} has-reply {%/if%}" data-comment-id="{%= id%}">
        <div class="user-photo-comment">
            <img class="comment-author-photo" src="http://graph.facebook.com/{%= facebookUserId%}/picture?">
        </div>
        <div class="comment-body clearfix">
            <r:img class="commment-arrow" uri="/img/comment-arrow.png"/>
            <div class="comment-details clearfix"><span class="commentee-name">{%= username%}</span><span class="comment-time pull-right">{%= dateCreated%}</span></div>
            <p>{%= comment%}</p>
            <ul class="comment-toolbar pull-left clearfix silver-gradient gradient">
                <li class="comment-vote-count"><a href="#/">{%= votesCount%}</a></li>
                <li class="comment-up-vote ir"><a class="feeds-sprite" href="#/"></a></li>
                <li class="comment-down-vote ir"><a class="feeds-sprite" href="#/"></a></li>
                <li class="pull-right"><a href="#" class="reply-button" onclick="showCommentDialog('{%= id%}', 'comment')">Reply</a></li>
            </ul>
        </div>
        <ul class="replies" data-nested-for="{%= id%}">
            %{--<g:each in="${pagedChildren.list}" var="nestedComm">--}%
            %{--<g:render template="/common/comment/nestedComment" model="[comment: nestedComm]"/>--}%
            %{--</g:each>--}%
        </ul>
    </li>
    {%/each%}
</script>

<script id="replyCommentTmpl" type="text/x-jquery-tmpl">
    {%each comments%}
    <li class="reply" data-comment-id="{%= id%}">
        <img class="comment-author-photo" src="http://graph.facebook.com/{%= facebookUserId%}/picture?">

        <div class="comment-body clearfix">
            <r:img class="commment-arrow" uri="/img/comment-arrow.png"/>
            <p>{%= comment%}</p>
            <ul class="comment-toolbar pull-left clearfix silver-gradient gradient">
                <li class="comment-vote-count"><a href="#/">{%= votesCount%}</a></li>
                <li class="comment-up-vote ir"><a class="feeds-sprite" href="#/"></a></li>
                <li class="comment-down-vote ir"><a class="feeds-sprite" href="#/"></a></li>
            </ul>
        </div>
    </li>
    {%/each%}
</script>

<r:script>
    $(function() {
        $.get('<g:createLink controller="comment" action="get" params="[page: 0, id: title.id, mode: 'title']"/>', function(result){
            $('#rootCommentTmpl').tmpl( result ).appendTo('ul.comments');
        });
    });
</r:script>