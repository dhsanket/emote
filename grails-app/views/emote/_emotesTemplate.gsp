
<g:if test="${titles != null}">
	<g:each in="${titles}" var="title"> 
		<div class="emote-v2">
			<div class="emote-v2-header clearfix">
				<h3>${title.title}</h3>
									<ul class="emote-v2-actions">
						<!--<li><button class="emote-v2-action-button"><i class="icon-list icon-white"></i></button></li>
						<li><button class="emote-v2-action-button"><i class="icon-play-circle icon-white"></i></button></li>
						<li><button class="emote-v2-action-button"><i class="icon-ok icon-white"></i></button></li>
						<li><button class="emote-v2-action-button"><i class="icon-remove-sign icon-white"></i></button></li>-->
						<li><button class="emote-v2-action-button"><i class="icon-ok-sign icon-white"></i></button></li>
					</ul>
			</div>
			<div class="emote-v2-body clearfix">
					<%-- If media is present --%>
					<div class="emote-v2-media" data-media-type="image">
						<img src="http://lorempixel.com/500/500" />
					</div>
					<%--// If media is present --%>					
					<div class="emote-v2-content">
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<div class="emote-friends swiper-slide">
									<h4>Friend's emotes: <span class="current-user"></span></h4>
									<ul class="friend-container clearfix">
									<g:each in="${title.emotes}" var="emote">
										<li class="user-thumb clearfix">
											
											<img style="height: 30px;" src="http://graph.facebook.com/${emote.facebookId}/picture?">
											<span class="emote-user-name">${emote.username}</span>
										</li>
									</g:each>	
									</ul>
									<ul class="friend-emotes-container">
									<g:each in="${title.emotes}" var="emote">
										<li class="friend-emotes clearfix">
												
														<ul>
															<g:each in="${emote.expressions}" var="exp">
															<g:if test="${(exp.trim().length()>0)}">
															<li><a href="#">${exp}</a></li>
															</g:if>
															</g:each>
														</ul>
													
										</li>
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
       