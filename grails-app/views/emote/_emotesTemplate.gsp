<%@ page import="com.emote.GroupByTitle; com.emote.UserDoing; com.emote.UserFavourite;" %>

<r:script>
    $(function(){
        $('div[data-edit-feed]').click(function(){
            quick_emote($(this).attr('data-complete-title'),$(this).attr('data-first-category'), $(this).attr('data-emote-id'), $(this));
            _gaq.push(['_trackEvent', 'Quick-emote', $('#category').val() + 'Quick-emote', 'Quick-emote label', 1, false]);
        });
    });

    var doingNowUrl = '${createLink(controller: 'userAction', action: 'addDoing')}';
    var addToFavouriteUrl = '${createLink(controller: 'userAction', action: 'addFavouriteTitle')}';
    var removeFavouriteUrl = '${createLink(controller: 'userAction', action: 'removeFavouriteTitle')}';
</r:script>

<g:set var="loggedInClass" value="${session.user ? 'logged' : ''}"/>

<g:if test="${titles != null}">
    <g:each status="i" in="${titles}" var="title">

        <div data-post-id="${i}"  class="emote-v2" id="emote-v2-${i}">
            <div class="emote-v2-header swiper-container silver-gradient gradient clearfix">
                <div class="slide-indicator clearfix" data-emote-id="${title.id}"></div>
                <!-- @TODO: Maybe we should URLENCODE URLS -->
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <h3 class=""><a href="/zen/${title.completeTitle}" onClick="_gaq.push(['_trackEvent', 'Feed page', 'Clicks title page link', 'Link to title page: '+${title.completeTitle}, 1, false]);">${title.completeTitle}</a></h3>
                    </div>
                </div>
                <g:if test="${title.pictureId!= null}">
                    <span class="view-picture-icon"
                          data-title="${title.completeTitle}"
                          data-first-category="${title.firstCategory}"
                          data-comments-count="${title.titleObj.commentsCount} Comments"></span>
                </g:if>
                <g:if test="${session.user}">
                    <div class="gallery-contain silver-gradient gradient">
                         <a class="gallery-open" href="#"><i class="glyphicon glyphicon-fullscreen"></i></a>
                    </div>
                    <div class="feeds-contain silver-gradient gradient"
                         data-edit-feed
                         data-complete-title="${title.completeTitle}"
                         data-first-category="${title.firstCategory}"
                         data-emote-id="emote-v2-${i}">
                        <span class="feeds-sprite feeds-edit-icon"></span>
                    </div>
                </g:if>
                <span class="type">${title.firstCategory}</span>
                <g:if test="${showComments}">
                    <span class="comments-count" data-bind="text: commentsCountMsg"></span>
                </g:if>
                <g:else>
                    <g:if test="${(title.titleObj.commentsCount ?: 0) > 0}">
                        <span class="comments-count">${title.titleObj.commentsCount ?: 0} Comments</span>
                    </g:if>
                </g:else>
            </div> <!-- /.emote-v2-header -->

            <div class="emote-v2-body clearfix">

                <%-- If media is present --%>
                <g:if test="${title.pictureId!= null}">
                    <div class="emote-v2-media" data-media-type="image" >
                        <r:img uri="/picture/index/${title.pictureId}" />
                    </div> <!-- /.emote-v2-media -->
                </g:if>
                <g:else>
                    <div class="emote-v2-media no-media" data-media-type="image" ></div>
                </g:else>
                <%--// If media is present --%>

                <div class="emote-v2-content">
                    <div class="swiper-container" data-emote-id="${title.id}">
                        <div class="slide-indicator clearfix"></div>
                        <div class="swiper-wrapper">

                            <div class="emote-friends swiper-slide">

                                <h4>Friend's emotes:
                                    <a class="user-feed" href="#"><span class="current-user"></span></a> <a class="gradient silver-gradient button icon-button user-follow" href="#"><i class="glyphicon glyphicon-link"></i> Follow</a>
                                </h4>

                                <ul class="friend-container clearfix">
                                    <g:if test="${title.followingUsers}">
                                        <g:each in="${title.followingUsers}" var="user">
                                            <li class="user-thumb clearfix" data-post-id="${i}" data-user-id="${user.uid}">
                                                <img style="height: 30px;" src="http://graph.facebook.com/${user.facebookId}/picture?">
                                                <span class="emote-user-name">${user.username}</span>
                                                <span class="user-active"></span>
                                            </li>
                                        </g:each>
                                    </g:if>
                                    <g:each in="${title.users}" var="user">
                                        <li class="user-thumb clearfix" data-post-id="${i}" data-user-id="${user.uid}">
                                            <img style="height: 30px;" src="http://graph.facebook.com/${user.facebookId}/picture?">
                                            <span class="emote-user-name">${user.username}</span>
                                            <span class="user-active"></span>
                                        </li>
                                    </g:each>
                                </ul>

                                <ul data-post-id="${i}" class="friend-emotes-container" >
                                    <g:each in="${title.followingUsers}" var="user">
                                        <li class="friend-emotes clearfix" data-user-id="${user.uid}"  style="display : list-item;">
                                            <ul class="clearfix">
                                                <g:each in="${title.getFollowed(user.uid).expressions}" var="exp">
                                                    <g:if test="${(exp.text.trim().length()>0)}">
                                                        <li><a href="" onClick="re_emote('${title.completeTitle}', '${exp.text}'); _gaq.push(['_trackEvent', 'Re-emote', 'Re-emote action: '+${title.completeTitle}, 'Re-emote-label: from other persons emote', 1, false]);"> ${exp.text} </a></li>
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
                                                        <li><a href="" onClick="re_emote('${title.completeTitle}', '${exp.text}'); _gaq.push(['_trackEvent', 'Re-emote', 'Re-emote action: '+${title.completeTitle}, 'Re-emote-label: from other persons emote', 1, false]);"> ${exp.text} </a></li>
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
                                                    <li><a href="" onClick="re_emote('${title.completeTitle}', '${emote.expression}' ); _gaq.push(['_trackEvent', 'Re-emote', 'Re-emote action: '+${title.completeTitle} , 'Re-emote-label: popular emotes', 1, false]);"> ${emote.expression} </a></li>
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
                    <li class="feeds-sprite feeds-report-icon ${loggedInClass}" data-emote-title="${title.completeTitle}"></li>
                    <li class="feeds-sprite feeds-camera-icon ${loggedInClass}" data-emote-title="${title.completeTitle}"></li>
                    <li class="feeds-sprite feeds-share-icon last ${loggedInClass}"></li>
                    %{--<emoteapp:facebookpost completeTitle="${title.completeTitle}" popularEmotesList="${title.popularEmotes}"/>--}%
                </ul>
                <span class="feeds-sprite feeds-knob-icon ${loggedInClass} ${doingNow.contains(title.completeTitle) ? 'active' : ''}" data-emote-title="${title.completeTitle}"></span>
                <ul class="clearfix pull-right">
                    <li class="feeds-sprite feeds-list-icon ${loggedInClass} ${inToDoList.contains(title.completeTitle) ? 'active' : ''}" data-emote-title="${title.completeTitle}"></li>
                    <li class="feeds-sprite feeds-fav-icon last ${loggedInClass} ${favourites.contains(title.completeTitle) ? 'active' : ''}" data-emote-title="${title.completeTitle}"></li>
                </ul>
            </div> <!-- /emote-v2-footer -->
        </div> <!-- /.emote-v2 -->

        <div id="socialsharepopup" class="popupzen" style="position:static;">
            <div id="popup-container" class="socialsharepopup">
                <div id="fullscreen-dialog">
                    <div class="social-share-links">
                        <div class="error"></div>
                        <a href="#/" class="shareToFb" onclick="FB.ui({method: 'feed', 
                            name: '#${title.completeTitle}', 
                            link: 'www.emote-app.com/zen/${title.completeTitle}',
                            caption: 'Share via Emote', 
                            picture: 'http://www.emote-app.com/img/emote-defaultLogo.png',              
                            description: 'emote-app users think #${title.completeTitle} is ${title.popularEmotes.expression}'
                          }, function(response){ console.log(response);});"></a>

                          <a href="https://twitter.com/share?text=@ www.emote-app.com/zen/${title.completeTitle} via emote" class="twitter-share-button shareToTw" data-url="www.emote-app.com/zen/${title.completeTitle}" data-related="anywhereTheJavascriptAPI" data-lang="en" data-size="large" data-count="none">Tweet</a>
                        <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="https://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

                        
                    </div>
                    <button value="Cancel" class="cancel-button" >Back</button>
                </div> <!-- /#fullscreen-dialog -->
            </div> <!-- /#popup-container -->
        </div> <!-- /#socialsharepopup -->

        <g:if test="${showComments}">
            <g:render template="/common/comment/commentsList" model="[title: titles.empty ? null : titles.first(), comments: comments]"/>
        </g:if>
    </g:each>
</g:if>
