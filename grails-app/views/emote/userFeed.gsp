<html>
    <head>

    	<g:render template="/common/user_header" />

    </head>
    <body>
    	<g:render template="/common/header" />
    	<g:if test="${session.user == null}">
    		<g:render template="/common/signin"></g:render>
    	</g:if>
    	<g:render template="/common/create_emote" />
    	<g:render template="/common/menu_bar" model="[userFriends: userFriends, emoteUsersList: emoteUsersList]"/>
    	<div id="feed-container" class="feed-container">
    		<g:render template="emotesTemplate" model="[titles: flash.titles]" />
    	</div>
    	
    	
    	
    </body>
    
</html>