<html>
    <head>



    </head>
    <body>
    	<g:render template="/common/header" />
    	    	<g:render template="/common/signin_header"></g:render>
    	<g:render template="/common/create_emote" />
    	<g:render template="/common/menu_bar" />
    	<div id="feed-container" class="feed-container">
    		<g:render template="emotesTemplate" model="[titles: flash.titles]" />
    	</div>
    	
    	
    	
    </body>
    
</html>