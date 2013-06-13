<html>
    <head>

    </head>
    <body>
    	<g:render template="/common/header" />
    	<g:render template="/common/create_emote" />
    	<g:render template="/common/menu_bar" />
    	<g:render template="emotesTemplate" model="[emotes: flash.emotes]" />
    </body>
    
</html>