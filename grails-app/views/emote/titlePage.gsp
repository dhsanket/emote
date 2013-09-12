<html>
    <head>
    </head>
    <body>
    	<g:render template="/common/header" />
    	    	<g:render template="/common/signin_header"></g:render>
    	<g:render template="/common/create_emote" />
    	<g:render template="/common/menu_bar" />
    	
        <g:render template="/common/picture_crop" />
        <g:render template="/common/imageupload/web_search" />
        <g:render template="/common/flag_inappropriate" />
        
        
        <g:if test="${titles != null}">
        <div id="titlePage">
        	<div id="title">
<%--        	<g:each status="i" in="${titles}" var="title"> --%>
        		<h1> ${title} </h1>
<%--        	</g:each>--%>
        	</div>
        
        </div>
        
        </g:if>
        
        
        
    </body>
    
</html>