<html>
    <head>

    </head>
    <body>
		    <br>
		    <br>
	          <g:form align="center" class="form-search" action="doSearch" controller="emote" >
		          <div class="input-append">
		          <g:textField name="keyword" class="span2 search-query"/>
		          <g:submitButton name="submit" class="btn" />
		          </div>
	          </g:form>
			<g:render template="emotesTemplate" model="[emotes: flash.emotes]" />
    </body>
    
</html>