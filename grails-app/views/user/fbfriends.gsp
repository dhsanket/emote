<html>
    <head>



    </head>
    <body>
    	<g:render template="/common/header" />
    	<g:if test="${session.user == null}">
    		<g:render template="/common/signin"></g:render>
    	</g:if>
    	<g:render template="/common/create_emote" />

    	<div id="feed-container" class="feed-container">
    	<g:render template="/common/followUsers" model="[userFriends: userFriends, emoteUsersList: emoteUsersList]"/>
    	</div>
    	
    	
    	
    </body>
    
</html>