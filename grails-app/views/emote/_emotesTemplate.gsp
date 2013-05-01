<g:if test="${emotes != null}">
	<g:each in="${emotes}" var="emote">
		    <div class="item-section grid_23 omega">
		          <div class="user grid_5 omega">
			            <img class= "avatar" src="../img/e5.png" href="http://www.emote-lol.com"> 
			            <a class="username"> ${emote.username}</a>
		          </div>
		          <div class="item-title">
		            	<q>${emote.title}</q>
		          </div>
		          <div class="emote-section">
            		<img class="avatar" src="../img/e5.png">:
			          <g:each in="${emote.expressions }" var="exp">
				          <g:if test="${(exp.trim().length()>0)}">
				          	 <a class="emote">${exp}</a>
				          </g:if>
			          </g:each>
         			</div>
		         <div class="topic-section">
           			Topics:
           			<g:each in="${ emote.topics}" var="topic">
           				<g:if test="${(topic.trim().length()>0)}">
		            		 <a class="topic">${topic}</a>
		            	 </g:if>
		            </g:each>
          		</div>
				 <div class="item-pic"></div>
		         <div class="item-gps"></div>
		         <div class="item-timestamp pull-right">${emote.creationTime}</div>
			</div>	
	</g:each>
</g:if>	
       