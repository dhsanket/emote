
<g:if test="${titles != null}">
	<g:each status="i" in="${titles}" var="title"> 
		<div data-post-id="${i}"  class="emote-v2">
			<div class="emote-v2-header clearfix">
				<h3>${title.title}</h3>
				<div id="qemote_${i}" class="quickEmote emote-v2-action-button" onclick="javascript:quick_emote('${title.title}')"><a href="#"><i class="icon-plus-sign icon-white"></i></a></div>
									<ul class="emote-v2-actions">		
						<!--<li><button class="emote-v2-action-button"><i class="icon-list icon-white"></i></button></li>
						<li><button class="emote-v2-action-button"><i class="icon-play-circle icon-white"></i></button></li>
						<li><button class="emote-v2-action-button"><i class="icon-ok icon-white"></i></button></li>
						<li><button class="emote-v2-action-button"><i class="icon-remove-sign icon-white"></i></button></li>-->
						<%--<li><button id="qemote_${i}" class="emote-v2-action-button" onclick="javascript:quick_emote('${title.title}', '#qemote_${i}')"><i class="icon-ok-sign icon-white" id="quick-createEmote"></i></button></li>--%>
					</ul>
			</div>
			<div class="emote-v2-body clearfix">
					<%-- If media is present --%>
					<div class="emote-v2-media" data-media-type="image">
						<!--   r:img uri="/img/positive-thinking.jpg"/ -->
					</div>
					<%--// If media is present --%>					
					<div class="emote-v2-content">
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<div class="emote-friends swiper-slide">
								<h4>Popular emotes: </h4>
								<ul data-post-id="${i}" class="friend-emotes-container" >
										<g:each in="${title.users}" var="user">
										<li class="friend-emotes clearfix" style="display : list-item;">
											<ul>
											<g:each in="${title.getUserEmotes(user.facebookId).emotes}" var="emote">
													
														<g:each in="${emote.expressions}" var="exp">
															<g:if test="${(exp.trim().length()>0)}">
																<li><a href="#" onclick="javascript:re_emote('${title.title}', '${exp}' )">${exp}</a></li>
															</g:if>
														</g:each>
													
											</g:each>
											</ul>
										</li>
										</g:each>					
									</ul>
								</div>
								<div class="emote-friends swiper-slide">
									<h4>Friend's emotes: <a href="#"><span class="current-user"></span></a></h4>
									<ul class="friend-container clearfix">
									<g:each in="${title.users}" var="user">
										<li class="user-thumb clearfix" data-post-id="${i}" data-user-id="${user.facebookId}_${i}">
											
											<img style="height: 30px;" src="http://graph.facebook.com/${user.facebookId}/picture?">
											<span class="emote-user-name">${user.username}</span>
										</li>
									</g:each>	
									</ul>
									<ul data-post-id="${i}" class="friend-emotes-container" >
										<g:each in="${title.users}" var="user">
										<li class="friend-emotes clearfix" data-user-id="${user.facebookId}_${i}"  style="display : list-item;">
											<ul>
											<g:each in="${title.getUserEmotes(user.facebookId).emotes}" var="emote">
													
														<g:each in="${emote.expressions}" var="exp">
															<g:if test="${(exp.trim().length()>0)}">
																<li><a href="#" onclick="javascript:re_emote('${title.title}', '${exp}' )">${exp}</a></li>
															</g:if>
														</g:each>
													
											</g:each>
											</ul>
										</li>
										</g:each>					
									</ul>
								</div>	
								<div class="emote-friends swiper-slide">
								<h4>Related Titles: </h4>
								
								</div>
							</div>
						</div>
					</div>			
			</div>
		</div>		
	</g:each>
</g:if>	
       