<g:if test="${titles != null}">
	<g:each in="${titles}" var="title">
		    <div class="emote" style="background:#232323;">
		        <h3 class="emote-title" style="background:none;">${title.title}</h3>
				<h4 class="emote-geo"></h4>
				
					
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<g:each in="${title.emotes}" var="emote">
								<!-- Slides Content -->
								<g:each in="${emote.expressions }" var="exp">
									<div class="swiper-slide">
											 <facebook:picture facebookId="${emote.facebookId}" /> 
											<h1 style="background-color:rgba(255,255,255,0.1);color:#FFFFFF;">
											
											<g:if test="${(exp.trim().length()>0)}">
											${exp}
											</g:if>
											</h1>
									</div>
								</g:each>
							<!--// Slides Content -->
							</g:each>
						</div>
					</div>
					<div class="share-tags">
						<ul>
							<li><a href="#"><i class="icon-share"></i><br />Share to Facebook</a></li>
							<li><a href="#"><i class="icon-envelope"></i><br />Send to a Friend</a></li>
							<li><a href="#"><i class="icon-flag"></i><br />Flag as Inappropriate</a></li>
						</ul>
					</div>
					<div class="emote-specific-profiles-container">
					<!-- put emoters profile image -->
						<ul>
							<li class="emote-specific-user-image"><img src="http://lorempixel.com/32/32" /></li>
							<li class="emote-specific-user-image"><img src="http://lorempixel.com/32/32" /></li>
							<li class="emote-specific-user-image"><img src="http://lorempixel.com/32/32" /></li>
							<li class="emote-specific-user-image"><img src="http://lorempixel.com/32/32" /></li>
						</ul>
					</div>
				
		</div>	
	</g:each>
</g:if>	
       