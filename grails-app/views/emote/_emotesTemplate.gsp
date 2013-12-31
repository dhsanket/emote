<%@ page import="com.emote.UserDoing; com.emote.UserFavourite;" %>

<g:if test="${titles != null}">
<g:if test="${session.user}">
	<g:set var="favourites" value="${UserFavourite.findByUserId(session.user.id)?.favouriteTitles}"/> 
</g:if>
<g:each status="i" in="${titles}" var="title">
<div data-post-id="${i}"  class="emote-v2" id="emote-v2-${i}">
	<div class="emote-v2-header silver-gradient gradient clearfix">
        <div class="header-container">
        <div class="header-swiper"><a class="clearfix" href="/zen/${title.completeTitle}"><h3>${title.completeTitle}</h3></a></div>
        <span class="feeds-sprite feeds-edit-icon"></span>
        <span class="type">${title.firstCategory}</span><span class="comments-count">201 Comments</span>

        <div id="qemote_${i}" class="quickEmote emote-v2-action-button" onclick="javascript:quick_emote('${title.completeTitle}','${title.firstCategory}', 'emote-v2-${i}');_gaq.push(['_trackEvent', 'Quick Emotes', document.getElementById('category').options[document.getElementById('category').selectedIndex].value, 'Add', 1, false]);">
            <a href="#"><i class="icon-edit"></i></a>
        </div>
        </div>

		<ul class="swipe-location"><li class="screen1"></li><li class="screen2"></li></ul>
	</div>
	
	<div class="emote-v2-body clearfix">
	
		<%-- If media is present --%>
					<div class="emote-v2-media" data-media-type="image" >
						<g:if test="${title.pictureId!= null}">
							<r:img uri="/picture/index/${title.pictureId}" />
						</g:if>
					</div>
		<%--// If media is present --%>					
		<div class="emote-v2-content">
		<div class="swiper-container">
            <div class="slide-indicator clearfix"></div>
		<div class="swiper-wrapper">
			<div class="emote-friends swiper-slide">
				<h4>Friend's emotes: <a class="user-feed" href="#"><span class="current-user"></span></a></h4>
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
							<ul>
								<g:each in="${title.getFollowed(user.uid).expressions}" var="exp">
									<g:if test="${(exp.text.trim().length()>0)}">
										<li><a href="javascript:re_emote('${title.completeTitle}', '${exp.text}' )" onClick="_gaq.push(['_trackEvent', 'Re Emotes', 'Edit', 'Successful', 1, false]);">${exp.text}</a></li>
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
			</div>	
			<div class="emote-friends swiper-slide">
			<h4>Popular emotes: </h4>
				<ul class="friend-emotes-container" >
				<div class="friend-emotes clearfix">
				<ul>
				<g:each in="${title.popularEmotes}" var="emote">
						<g:if test="${(emote.expression.trim().length()>0)}">
							<li><a href="javascript:re_emote('${title.completeTitle}', '${emote.expression}')"> ${emote.expression} </a></li>
						</g:if>
				</g:each>					
				</ul>
				</div>
				</ul>
			</div>
		</div>
		</div>
		</div>			
	</div>
	<div class="emote-v2-footer silver-gradient gradient clearfix">
        <ul class="clearfix pull-left">
            <li id="remote_${i}" class="feeds-sprite feeds-report-icon" onclick="javascript:flag_emote('${title.completeTitle}')"></li>
            <li id="emote_camera_${i}" class="feeds-sprite feeds-camera-icon" onclick="javascript:"></li>
            <li class="feeds-sprite feeds-share-icon last"> <emoteapp:facebookpost popularEmotesList="${title.popularEmotes}" />

            %{--<button class="emote-v2-actions-last"><facebook:publishLink name="#${title.completeTitle}"  link="www.emote-app.com/zen/${title.completeTitle}" display="touch" picture="http://www.emote-app.com/img/emote-defaultLogo.png" description="emote-app users think #${title.completeTitle} is ${title.popularEmotes.expression}" callback="facebookPublishCallbackFunction" ><img src="/img/share_small.png"/></facebook:publishLink></button>--}%
            %{--<li class="emote-v2-actions-last"><facebook:publishLink name="#${title.completeTitle}"  link="www.emote-app.com/zen/${title.completeTitle}" display="touch" picture="http://www.emote-app.com/img/emote-defaultLogo.png" description="emote-app users think #${title.completeTitle} is ${title.popularEmotes.expression}" callback="facebookPublishCallbackFunction" ><img src="/img/share_small.png"/></facebook:publishLink></li>--}%

            </li>
        </ul>
        <g:if test="${UserDoing.isDoing(session.user.id,title.title)}">
        <span id="fav_emote_${i}" class="feeds-sprite feeds-knob-icon:hover"></span>
        </g:if> <g:else>
        <span id="fav_emote_${i}" class="feeds-sprite feeds-knob-icon" onclick="javascript:doingNow(this.id,'${title.title}')" ></span>
        </g:else>

        <ul class="clearfix pull-right">
            <li id="fav_emote_${i}" class="feeds-sprite feeds-list-icon"></li>

            <g:if test="${favourites && favourites.contains(title.title)}">
            <li id="fav_emote_${i}" class="feeds-sprite feeds-fav-icon last" onclick="javascript:removeFromFavourite(this.id,'${title.title}')"></li>
            </g:if> <g:else>
            <li id="fav_emote_${i}" class="feeds-sprite feeds-fav-icon last" onclick="javascript:favouriteSubmit(this.id,'${title.title}')"></li>
            </g:else>
         </ul>

		
	</div>
</div>		
</g:each>
</g:if>	
       
