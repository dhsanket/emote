<!-- HTML -->
<form id="commentSave" method="post" class="hidden">
    <input type="hidden" id="parentId" name="parentId">
    <input type="hidden" id="mode" name="mode">
    <div id="comment-creation-container">
        <div class="data-set clearfix">
            <img class="comment-author-pic" src="http://graph.facebook.com/${session.user.facebookId}/picture?">
            <div class="comment-dialog-body">
                <textarea id="commentMsg" name="commentMsg" placeholder="${message(code: 'emote.comment.msg.placeholder')}"></textarea>
            </div>
            <button type="submit" id="post-emote" class="button icon-button grey-gradient long gradient pull-right" value="Save"><span class="edit-button"></span>${message(code: 'emote.comment.post.btn.label')}</button>
            <button type="button" class="button icon-button grey-gradient long gradient pull-right" value="Cancel" onclick="toggleCommentDialog();">${message(code: 'emote.comment.cancel.btn.label')}</button>
        </div> <!-- /.data-set -->
    </div> <!-- /#comment-creation-container -->
</form>