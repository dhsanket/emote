<%@ page import="com.emote.UserDoing; com.emote.UserFavourite;" %>

<g:if test="${titles != null}">
<g:if test="${session.user}">
	<g:set var="favourites" value="${UserFavourite.findByUserId(session.user.id)?.favouriteTitles}"/> 
</g:if>
<g:each status="i" in="${titles}" var="title">
<div data-post-id="${i}"  class="emote-v2" id="emote-v2-${i}">
	<div class="emote-v2-header clearfix">
		<div class="header-container">
		<div class="header-swiper"><a class="clearfix" href="/zen/${title.completeTitle}"><h3>${title.completeTitle}</h3></a></div>
		<ul class="header-comments" styl="float:left;"><li>${title.firstCategory}</li><li>&#183;&nbsp;&nbsp;201 comments</li></ul>
		</div>
				<%--<h3><g:link controller="emote" action="getTitle" params="[titleId: title.id]"> ${title.title} </g:link></h3> 		--%>
		<div id="qemote_${i}" class="quickEmote emote-v2-action-button" onclick="javascript:quick_emote('${title.completeTitle}','${title.firstCategory}', 'emote-v2-${i}');_gaq.push(['_trackEvent', 'Quick Emotes', document.getElementById('category').options[document.getElementById('category').selectedIndex].value, 'Add', 1, false]);">
		<a href="#" class="editEmoteLink"><i class="icon-edit"></i></a>
		</div>
<%--
<<<<<<< HEAD
 
<g:if test="${session.user}">       
        <ul class="emote-v2-actions">			
			<li><button id="qemote_${i}" class="emote-v2-action-button" onclick="javascript:flag_emote('${title.completeTitle}')"><i class="icon-flag icon-white"></i></button></li>
			<li><facebook:publishLink name="#${title.completeTitle}"  link="www.emote-app.com/zen/${title.completeTitle}" picture="http://www.emote-app.com/img/emote-defaultLogo.png" description="emote-app users think #${title.completeTitle} is ${title.popularEmotes.expression}" callback="facebookPublishCallbackFunction" >
    			<button>f</button></facebook:publishLink></li>
            <g:if test="${favourites && favourites.contains(title.title)}">
            <li><button id="fav_emote_${i}" class="emote-v2-action-button" onclick="javascript:removeFromFavourite(this.id,'${title.title}')"><i class="icon-star icon-white"></i></button></li>
            </g:if>
            <g:else>
            <li><button id="fav_emote_${i}" class="emote-v2-action-button" onclick="javascript:favouriteSubmit(this.id,'${title.title}')"><i class="icon-star-empty icon-white"></i></button> </li>
            </g:else>
            <g:if test="${UserDoing.isDoing(session.user.id,title.title)}">
            <li><button id="fav_emote_${i}" class="emote-v2-action-button"><i class="icon-refresh icon-white"></i></button></li>
            </g:if>
            <g:else>
            <li><button id="fav_emote_${i}" class="emote-v2-action-button" onclick="javascript:doingNow(this.id,'${title.title}')"><i class="icon-time icon-white"></i></button></li>
            </g:else>
		</ul>
</g:if>		
=======
--%>
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
							<li><a href="javascript:re_emote('${title.completeTitle}', '${emote.expression}' )">${emote.expression}</a></li>
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
	<div class="emote-v2-footer clearfix">
		<ul class="emote-v2-actions-left">
			<li>
				<button id="qemote_camera_${i}" class="emote-v2-action-button" onclick="javascript:"><img src="/img/add_photo.png"/></button>
			</li>
		</ul>
		<ul class="emote-v2-actions">
			<g:if test="${UserDoing.isDoing(session.user.id,title.title)}">
            <li class="emote-v2-actions-first"><button id="fav_emote_${i}" class="emote-v2-action-button"><img src="/img/doing_now_green.png"/></button></li>
            </g:if>
            <g:else>
            <li class="emote-v2-actions-first"><button id="fav_emote_${i}" class="emote-v2-action-button" onclick="javascript:doingNow(this.id,'${title.title}')"><img src="/img/doing_now_grey.png"/></button></li>
            </g:else>	
            
			<li><button id="fav_emote_${i}" class="emote-v2-action-button"><img src="/img/shortlist.png"/></button></li>
			<li><button id="qemote_${i}" class="emote-v2-action-button" onclick="javascript:flag_emote('${title.completeTitle}')"><img src="/img/report.png"/></button></li>
            <g:if test="${favourites && favourites.contains(title.title)}">
            <li><button id="fav_emote_${i}" class="emote-v2-action-button" onclick="javascript:removeFromFavourite(this.id,'${title.title}')"><img src="/img/favourite_icon_on.png"/></button></li>
            </g:if>
            <g:else>
            <li><button id="fav_emote_${i}" class="emote-v2-action-button" onclick="javascript:favouriteSubmit(this.id,'${title.title}')"><img src="/img/favourite.png"/></button> </li>
            </g:else>
			<li class="emote-v2-actions-last"><facebook:publishLink name="#${title.completeTitle}"  link="www.emote-app.com/zen/${title.completeTitle}" picture="http://www.emote-app.com/img/emote-defaultLogo.png" description="emote-app users think #${title.completeTitle} is ${title.popularEmotes.expression}" callback="facebookPublishCallbackFunction" ><img src="/img/share_small.png"/></facebook:publishLink></li>		
			

            
		</ul>
		
	</div>
</div>		
</g:each>
</g:if>	
       
