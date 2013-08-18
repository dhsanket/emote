<html>
    <head>
    </head>
    <body>
    	<g:render template="/common/header" />
    	    	<g:render template="/common/signin_header"></g:render>
    	<g:render template="/common/create_emote" />
    	<g:render template="/common/menu_bar" />
    	<div id="feed-container" class="feed-container">
	    	<g:render template="/common/pagination_prev"/>
    		<g:render template="emotesTemplate" model="[titles: flash.titles]" />
	    	<g:render template="/common/pagination_next"/>
    	</div>
        <g:render template="/common/picture_crop" />
    </body>
    
</html>