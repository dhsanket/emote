<html>
    <head>
	 <title>emote-app userfeed page</title>
    	

    </head>
    <body>
    	<g:render template="/common/header" />
    	<g:render template="/common/create_emote" />
    	<g:render template="/common/menu_bar"/>
    	<g:render template="/common/user_header" />
    	<div id="feed-container" class="feed-container">
 	    	<g:render template="/common/pagination_prev"/>
    		<g:render template="emotesTemplate" model="[titles: flash.titles, favourites: flash.favourites, doingNow: flash.doingNow, inToDoList: flash.inToDoList]" />
	    	<g:render template="/common/pagination_next"/>
    	</div>
        <g:render template="/emote/picturesDialog"/>
    </body>
    
</html>