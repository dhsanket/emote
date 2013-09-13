
<g:if test="${titles != null}">
<g:each status="i" in="${titles}" var="title"> 
<div data-post-id="${i}"  class="emote-v2">
	<div class="emote-v2-header clearfix">
		<a href="/zen/${title.title}"><h3>${title.title}</h3></a> 
		<div id="qemote_${i}" class="quickEmote emote-v2-action-button" onclick="javascript:quick_emote('${title.title}')">
		<a href="#"><i class="icon-edit"></i></a>
		</div>
        
        <ul class="emote-v2-actions">
			<li><button id="qemote_${i}" class="emote-v2-action-button" onclick="javascript:flag_emote('${title.title}')"><i class="icon-flag icon-white"></i></button></li>
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
												<li><a href="javascript:re_emote('${title.title}', '${exp}' )">${exp}</a></li>
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
       