<li class="reply" data-comment-id="${comment.id}">
    <img class="comment-author-photo" src="http://graph.facebook.com/${comment.facebookUserId}/picture?">

    <div class="comment-body clearfix">
        <r:img class="commment-arrow" uri="/img/comment-arrow.png"/>
        <p>${comment.comment}</p>
        <ul class="comment-toolbar pull-left clearfix silver-gradient gradient">
            <li class="comment-vote-count"><a href="#/">${comment.votesCount}</a></li>
            <li class="comment-up-vote ir"><a class="feeds-sprite" href="#/"></a></li>
            <li class="comment-down-vote ir"><a class="feeds-sprite" href="#/"></a></li>
            <li class="pull-right"><a href="#" class="reply-button">Reply</a></li>
        </ul>
    </div>
</li>