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
        <g:each in="${comments.list}" var="comment">
            <g:render template="/common/comment/rootComment" model="[comment: comment]"/>
        </g:each>
    </ul>
</div>