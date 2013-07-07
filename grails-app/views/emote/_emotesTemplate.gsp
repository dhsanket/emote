
<g:if test="${titles != null}">
	<g:each status="i" in="${titles}" var="title"> 
		<div class="emote-v2">
			<div class="emote-v2-header clearfix">
				<h3>${title.title}</h3>
									<ul class="emote-v2-actions">
						<!--<li><button class="emote-v2-action-button"><i class="icon-list icon-white"></i></button></li>
						<li><button class="emote-v2-action-button"><i class="icon-play-circle icon-white"></i></button></li>
						<li><button class="emote-v2-action-button"><i class="icon-ok icon-white"></i></button></li>
						<li><button class="emote-v2-action-button"><i class="icon-remove-sign icon-white"></i></button></li>-->
						<li><button id="qemote_${i}" class="emote-v2-action-button" onclick="javascript:quick_emote('${title.title}', '#qemote_${i}')"><i class="icon-ok-sign icon-white" id="quick-createEmote"></i></button></li>
					</ul>
			</div>
			<div class="emote-v2-body clearfix">
					<%-- If media is present --%>
					<div class="emote-v2-media" data-media-type="image">
						<r:img uri="/img/positive-thinking.jpg"/>
					</div>
					<%--// If media is present --%>					
					<div class="emote-v2-content">
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<div class="emote-friends swiper-slide">
									<h4>Friend's emotes: <span class="current-user"></span></h4>
									<ul class="friend-container clearfix">
									<g:each in="${title.users}" var="user">
										<li class="user-thumb clearfix" data-post-id="${i}" data-user-id="${user.facebookId}">
											
											<img style="height: 30px;" src="http://graph.facebook.com/${user.facebookId}/picture?">
											<span class="emote-user-name">${user.username}</span>
										</li>
									</g:each>	
									</ul>
									<ul class="friend-emotes-container" data-post-id="${i}">
									<g:each in="${title.users}" var="user">
										<g:each in="${title.getUserEmotes(user.facebookId).emotes}" var="emote">
											<li class="friend-emotes clearfix" data-user-id="${user.facebookId}">
													
															<ul>
																<g:each in="${emote.expressions}" var="exp">
																<g:if test="${(exp.trim().length()>0)}">
																<li><a href="#">${exp}</a></li>
																</g:if>
																</g:each>
															</ul>
														
											</li>
										</g:each>
									</g:each>					
									</ul>
								</div>	

					
							</div>
						</div>
					</div>			
			</div>
		</div>		
	</g:each>
</g:if>	
       