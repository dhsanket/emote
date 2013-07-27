<html>
    <head>



    </head>
    <body>
    	<g:render template="/common/header" />
<g:render template="/common/signin_header"></g:render>
    	<g:render template="/common/create_emote" />
		<g:render template="/common/menu_bar" />
    	<div id="feed-container" class="feed-container">
    	<g:render template="displayUsers" model="[userFriends: userFriends, emoteUsersList: emoteUsersList]"/>
    	</div>
    	
    	
    	
    </body>
    
</html>