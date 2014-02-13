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
        <li class="comment has-reply">
            <div class="user-photo-comment"><img class="comment-author-photo" src="http://graph.facebook.com/193102033/picture?"></div>
            <div class="comment-body clearfix">
                <r:img class="commment-arrow" uri="/img/comment-arrow.png"/>
                <div class="comment-details clearfix"><span class="commentee-name">Sanket Deshpande</span><span class="comment-time pull-right">12 minutes ago</span></div>
                <p>Alternately a poetic tale of personal affirmation and a plainspoken metaphor for tenacity in the face of meager hope, "Nebraska" is not just a beautiful or great film but an essential one for our time.</p>
                <ul class="comment-toolbar pull-left clearfix silver-gradient gradient">
                    <li class="comment-vote-count"><a href="#/">12</a></li>
                    <li class="comment-up-vote ir"><a class="feeds-sprite" href="#/"></a></li>
                    <li class="comment-down-vote ir"><a class="feeds-sprite" href="#/"></a></li>
                    <li class="pull-right"><a href="#" class="reply-button">Reply</a></li>
                </ul>

            </div>
            <ul class="replies">
                <li class="reply"><img class="comment-author-photo" src="http://graph.facebook.com/193102033/picture?"><div class="comment-body clearfix"><r:img class="commment-arrow" uri="/img/comment-arrow.png"/><p>Alternately a poetic tale of personal affirmation and a plainspoken metaphor for tenacity in the face of meager hope, "Nebraska" is not just a beautiful or great film but an essential one for our time.</p>
                    <ul class="comment-toolbar pull-left clearfix silver-gradient gradient">
                        <li class="comment-vote-count"><a href="#/">12</a></li>
                        <li class="comment-up-vote ir"><a class="feeds-sprite" href="#/"></a></li>
                        <li class="comment-down-vote ir"><a class="feeds-sprite" href="#/"></a></li>
                        <li class="pull-right"><a href="#" class="reply-button">Reply</a></li>
                    </ul></div></li>
                <li class="reply"><img class="comment-author-photo" src="http://graph.facebook.com/193102033/picture?"><div class="comment-body clearfix"><r:img class="commment-arrow" uri="/img/comment-arrow.png"/><p>I doubt it!</p></div></li>
            </ul>
        </li>
    </ul>
</div>