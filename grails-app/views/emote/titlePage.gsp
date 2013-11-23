<html>
    <head>
     <title>emote-app: ${emotePost.title}</title>
    </head>
    <body>
    	<g:render template="/common/header" />
    	    	<g:render template="/common/signin_header"></g:render>
    	<g:render template="/common/create_emote" />
    	<g:render template="/common/menu_bar" />
    	
        <g:render template="/common/picture_crop" />
        <g:render template="/common/imageupload/web_search" />
        <g:render template="/common/flag_inappropriate" />
        
        

        <div id="titlePage">
        	<div id="title">

        		<h1> ${emotePost.title} </h1>

        	</div>
        
        </div>
        
        
        
        
    </body>
    
</html>