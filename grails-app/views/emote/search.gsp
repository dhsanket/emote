<html>
    <head>

    </head>
    <body>
        <div class="grid_22 emote-howto">
		    <div class="item-section grid_23 omega">
		    
	          <g:form class="form-search" action="doSearch" controller="emote" >
		          <div class="input-append">
		          <g:textField name="keyword" class="span2 search-query"/>
		          <g:submitButton name="submit" class="btn" />
		          </div>
	          </g:form>
			
			<g:if test="${flash.emotes != null}">
				<g:each in="${flash.emotes}" var="emote">
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
				          	 <a class="emote"> ${exp } </a>
				          </g:each>
          			 </div>
			         <div class="topic-section">
            			Topics:
            			<g:each in="${ emote.topics}" var="topic">
			            	 <a class="topic"> ${topic } </a>
			            </g:each>
           			</div>
					<div class="item-pic">
          			</div>
		          <div class="item-gps">
		          </div>
		          <div class="item-timestamp">${emote.creationTime}
          			</div>
					
				</g:each>
			</g:if>	
       	</div>
       </div>
    </body>
    
</html>