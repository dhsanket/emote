<html>
    <head>



    </head>
    <body>
    	<g:render template="/common/header" />
    	<g:if test="${session.user == null} || ${!facebookContext.authenticated}">
    			<g:render template="/common/signin_header"></g:render>
    	</g:if>
    	<g:render template="/common/create_emote" />
		<g:render template="/common/menu_bar" />
    	<div id="feed-container" class="feed-container">
    	<g:render template="followUsers" model="[userFriends: userFriends, emoteUsersList: emoteUsersList]"/>
    	</div>
    	
    	
    	
    </body>
    
</html>