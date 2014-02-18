<%@ page import="com.emote.GroupByTitle; com.emote.UserDoing; com.emote.UserFavourite;" %>

<r:script>
    $(function(){
        $('span.feeds-edit-icon').click(function(){
            quick_emote($(this).attr('data-complete-title'),$(this).attr('data-first-category'), $(this).attr('data-emote-id'));
            _gaq.push(['_trackEvent', 'Quick Emotes', $('#category').val(), 'Add', 1, false]);
        });
    });
</r:script>

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
                <span class="feeds-sprite feeds-edit-icon"
                    data-complete-title="${title.completeTitle}"
                    data-first-category="${title.firstCategory}"
                    data-emote-id="emote-v2-${i}"></span>
                <span class="type">${title.firstCategory}</span><span class="comments-count">201 Comments</span>
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
            <g:render template="/common/comment/commentsList" model="[title: titles.empty ? null : titles.first(), comments: comments]"/>
        </g:if>
    </g:each>
</g:if>	

<g:if test="${params.action == 'singleTitle' && session.user}">
    <g:render template="/common/comment/commentDialog"/>
</g:if>
