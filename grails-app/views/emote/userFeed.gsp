<html>
    <head>

    	

    </head>
    <body>
    	<g:render template="/common/header" />
    	<g:if test="${session.user == null}">
    		<g:render template="/common/signin"></g:render>
    	</g:if>
    	<g:render template="/common/create_emote" />
    	<g:render template="/common/menu_bar"/>
    	<g:render template="/common/user_header" />
    	<div id="feed-container" class="feed-container">
 	    	<g:render template="/common/pagination_prev"/>
    		<g:render template="emotesTemplate" model="[titles: flash.titles]" />
	    	<g:render template="/common/pagination_next"/>
    	</div>
    	
    	
    	
    </body>
    
</html>