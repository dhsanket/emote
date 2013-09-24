<%@ page import="com.emote.UserDoing; com.emote.UserFavourite" %>

<g:if test="${titles != null}">
<g:set var="favourites" value="${UserFavourite.findByUserId(session.user.id)?.favouriteTitles}"/>
<g:each status="i" in="${titles}" var="title">
<div data-post-id="${i}"  class="emote-v2">
	<div class="emote-v2-header clearfix">

		<a href="/zen/${title.title}"><h3>${title.title}</h3></a>
				<%--<h3><g:link controller="emote" action="getTitle" params="[titleId: title.id]"> ${title.title} </g:link></h3> 		--%>
		<div id="qemote_${i}" class="quickEmote emote-v2-action-button" onclick="javascript:quick_emote('${title.title}');_gaq.push(['_trackEvent', 'Quick Emotes', document.getElementById('category').options[document.getElementById('category').selectedIndex].value, 'Add', 1, false]);">
		<a href="#"><i class="icon-edit"></i></a>
		</div>
        
        <ul class="emote-v2-actions">
<<<<<<< HEAD
			<li>
                <button id="qemote_${i}" class="emote-v2-action-button" onclick="javascript:flag_emote('${title.title}')"><i class="icon-flag icon-white"></i></button>
                <g:if test="${favourites && favourites.contains(title.title)}">
                    <button id="fav_emote_${i}" class="emote-v2-action-button" onclick="javascript:removeFromFavourite(this.id,'${title.title}')"><i class="icon-flag icon-arrow-up"></i></button>
                </g:if>
                <g:else>
                    <button id="fav_emote_${i}" class="emote-v2-action-button" onclick="javascript:favouriteSubmit(this.id,'${title.title}')"><i class="icon-flag icon-arrow-down"></i></button>
                </g:else>
                <g:if test="${UserDoing.isDoing(session.user.id,title.title)}">
                    <button id="fav_emote_${i}" class="emote-v2-action-button"><i class="icon-flag icon-arrow-left"></i></button>
                </g:if>
                <g:else>
                    <button id="fav_emote_${i}" class="emote-v2-action-button" onclick="javascript:doingNow(this.id,'${title.title}')"><i class="icon-flag icon-arrow-right"></i></button>
                </g:else>
            </li>
=======
			<li><button id="qemote_${i}" class="emote-v2-action-button" onclick="javascript:flag_emote('${title.title}')"><i class="icon-flag icon-white"></i></button></li>
			<li><button><facebook:publishLink name="#${title.title}"  link="www.emote-app.com/zen/${title.title}" picture="http://www.emote-app.com/img/emote-defaultLogo.png" description="emote-app users think #${title.title} is ${title.popularEmotes.expression}" >
    			f</facebook:publishLink></button></li>
>>>>>>> remotes/upstream/master
		</ul>
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
				<g:each in="${title.followingUsers}" var="user">
					<li class="user-thumb clearfix" data-post-id="${i}" data-user-id="${user.uid}">	
						<img style="height: 30px;" src="http://graph.facebook.com/${user.facebookId}/picture?">
						<span class="emote-user-name">${user.username}</span>
					</li>
				</g:each>	
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
								<g:each in="${title.getFollowed(user.uid).emotes}" var="emote">
									<g:each in="${emote.expressions}" var="exp">
											<g:if test="${(exp.trim().length()>0)}">
												<li><a href="javascript:re_emote('${title.title}', '${exp}' )" onClick="_gaq.push(['_trackEvent', 'Re Emotes', 'Edit', 'Successful', 1, false]);">${exp}</a></li>
											</g:if>
									</g:each>
								</g:each>
							</ul>
						</li>
					</g:each>					
				
				
					<g:each in="${title.users}" var="user">
						<li class="friend-emotes clearfix" data-user-id="${user.uid}"  style="display : list-item;">
							<ul>
								<g:each in="${title.getUserEmotes(user.uid).emotes}" var="emote">
									<g:each in="${emote.expressions}" var="exp">
											<g:if test="${(exp.trim().length()>0)}">
												<li><a href="javascript:re_emote('${title.title}', '${exp}' )">${exp}</a></li>
											</g:if>
									</g:each>
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
							<li><a href="javascript:re_emote('${title.title}', '${emote.expression}' )">${emote.expression}</a></li>
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
	
</div>		
</g:each>
</g:if>	
       
