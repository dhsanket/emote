<%@ page import="com.emote.UserDoing; com.emote.UserFavourite;" %>

<g:set var="loggedInClass" value="${session.user ? 'active' : ''}"/>

<g:if test="${titles != null}">
    <g:if test="${session.user}">
        <g:set var="favourites" value="${UserFavourite.findByUserId(session.user.id)?.favouriteTitles}"/>
    </g:if>

    <g:each status="i" in="${titles}" var="title">

        <div data-post-id="${i}"  class="emote-v2" id="emote-v2-${i}">
            <div class="emote-v2-header silver-gradient gradient clearfix">
                <!-- @TODO: Maybe we should URLENCODE URLS -->
                <h3><a href="/zen/${title.completeTitle}">${title.completeTitle}</a></h3>
                <span class="feeds-sprite feeds-edit-icon"></span>
                <span class="type">${title.firstCategory}</span><span class="comments-count">201 Comments</span>

                <div id="qemote_${i}" class="quickEmote emote-v2-action-button" onclick="javascript:quick_emote('${title.completeTitle}','${title.firstCategory}', 'emote-v2-${i}');_gaq.push(['_trackEvent', 'Quick Emotes', document.getElementById('category').options[document.getElementById('category').selectedIndex].value, 'Add', 1, false]);">
                    <a href="#"><i class="icon-edit"></i></a>
                </div> <!-- /#qemote_0 -->

                <ul class="emote-v2-actions">
                    <li>
                        <button id="qemote_${i}" class="emote-v2-action-button" onclick="javascript:flag_emote('${title.completeTitle}')">
                            <i class="icon-flag icon-white"></i>
                        </button>
                    </li>

                    <li>
                        <emoteapp:facebookpost popularEmotesList="${title.popularEmotes}" />
                    </li>

                    <li>
                        <button id="fav_emote_${i}" class="emote-v2-action-button" onclick="javascript:favouriteSubmit(this.id,'${title.completeTitle}')">
                            <i class="icon-star-empty icon-white"></i>
                        </button>
                    </li>

                    <li>
                        <button id="fav_emote_${i}" class="emote-v2-action-button" onclick="javascript:doingNow(this.id,'${title.completeTitle}')">
                            <i class="icon-time icon-white"></i>
                        </button>
                    </li>
                </ul> <!-- /.emote-v2-actions -->
            </div> <!-- /.emote-v2-header -->

            <div class="emote-v2-body clearfix">

                <%-- If media is present --%>
                <div class="emote-v2-media" data-media-type="image" >
                    <g:if test="${title.pictureId!= null}">
                        <div class="emote-v2-media" data-media-type="image" >
                            <r:img uri="/picture/index/${title.pictureId}" />
                        </div> <!-- /.emote-v2-media -->
                    </g:if>
                </div>
                <%--// If media is present --%>

                <div class="emote-v2-content">
                    <div class="swiper-container">
                        <div class="slide-indicator clearfix"></div>
                        <div class="swiper-wrapper">
                            <div class="emote-friends swiper-slide">

                                <h4>Friend's emotes:
                                    <a class="user-feed" href="#"><span class="current-user"></span></a>
                                </h4>

                                <ul class="friend-container clearfix">
                                    <g:if test="${title.followingUsers}">
                                        <g:each in="${title.followingUsers}" var="user">
                                            <li class="user-thumb clearfix" data-post-id="${i}" data-user-id="${user.uid}">
                                                <img style="height: 30px;" src="http://graph.facebook.com/${user.facebookId}/picture?">
                                                <span class="emote-user-name">${user.username}</span>
                                            </li>
                                        </g:each>
                                    </g:if>
                                    <g:each in="${title.users}" var="user">
                                        <li class="user-thumb clearfix" data-post-id="${i}" data-user-id="${user.uid}">
                                            <img style="height: 30px;" src="http://graph.facebook.com/${user.facebookId}/picture?">
                                            <span class="emote-user-name">${user.username}</span>
                                        </li>
                                    </g:each>
                                </ul>

                                <ul data-post-id="${i}" class="friend-emotes-container" >
                                    <g:each in="${title.followingUsers}" var="user">
                                        <li class="friend-emotes clearfix" data-user-id="${user.uid}"  style="display : list-item;">
                                            <ul class="clearfix">
                                                <g:each in="${title.getFollowed(user.uid).expressions}" var="exp">
                                                    <g:if test="${(exp.text.trim().length()>0)}">
                                                        <li><a href="javascript:re_emote('${title.completeTitle}', '${exp.text}')" onClick="_gaq.push(['_trackEvent', 'Re Emotes', 'Edit', 'Successful', 1, false]);">${exp.text}</a></li>
                                                    </g:if>
                                                </g:each>
                                            </ul>
                                        </li>
                                    </g:each>
                                    <g:each in="${title.users}" var="user">
                                        <li class="friend-emotes clearfix" data-user-id="${user.uid}"  style="display : list-item;">
                                            <ul>
                                                <g:each in="${title.getUserEmotes(user.uid).expressions}" var="exp">
                                                    <g:if test="${(exp.text.trim().length()>0)}">
                                                        <li><a href="javascript:re_emote('${title.completeTitle}', '${exp.text}' )">${exp.text}</a></li>
                                                    </g:if>
                                                </g:each>
                                            </ul>
                                        </li>
                                    </g:each>
                                </ul>
                            </div> <!-- /.emote-friends swiper-slide -->

                            <div class="emote-friends swiper-slide">
                                <h4>Popular emotes: </h4>
                                <ul class="friend-emotes-container" >
                                    <div class="friend-emotes clearfix">
                                        <ul>
                                            <g:each in="${title.popularEmotes}" var="emote">
                                                <g:if test="${(emote.expression.trim().length()>0)}">
                                                    <li><a href="javascript:re_emote('${title.completeTitle}', '${emote.expression}' )">${emote.expression}</a></li>
                                                </g:if>
                                            </g:each>
                                        </ul>
                                    </div> <!-- /.friend-emotes -->
                                </ul>
                            </div> <!-- /.emote-friends swiper-slide -->
                        </div> <!-- /.swiper-wrapper -->
                    </div> <!-- /.swiper-container -->
                </div> <!-- /.emote-v2-content -->
            </div>  <!-- /.emote-v2-body -->

            <div class="emote-v2-footer silver-gradient gradient clearfix">
                <ul class="clearfix pull-left">
                    <li class="feeds-sprite feeds-report-icon"></li>
                    <li class="feeds-sprite feeds-camera-icon ${loggedInClass}" data-emote-title="${title.completeTitle}"></li>
                    <li class="feeds-sprite feeds-share-icon last ${loggedInClass}" <emoteapp:facebookpost completeTitle="${title.completeTitle}" popularEmotesList="${title.popularEmotes}"/>></li>
                </ul>
                <span class="feeds-sprite feeds-knob-icon"></span>
                <ul class="clearfix pull-right">
                    <li class="feeds-sprite feeds-list-icon"></li>
                    <li class="feeds-sprite feeds-fav-icon last"></li>
                </ul>
            </div> <!-- /emote-v2-footer -->
        </div> <!-- /.emote-v2 -->

        <g:if test="${showComments}">
        <div class="comments-container clearfix">
            <div class="comments-header clearfix">
                <span class="comments-heading">Top comments</span>
                <button class="button grey-gradient gradient long pull-right"><strong>Post a comment</strong></button>
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
        </g:if>
    </g:each>
</g:if>	
       
