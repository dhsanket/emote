<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
    <head>
        <title><g:layoutTitle default="emote\\o/" /></title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="viewport" content="width=device-width, height=device-height, inital-scale=1.0, user-scalable = no">
		
		<meta name="apple-mobile-web-app-capable" content="yes">
		
		<meta property="og:url"             content="http://www.emote-app.com/user/signin" /> 
		<meta property="og:title"           content="emote-app - find out what your friends think about..." /> 
		<meta property="og:image"           content="http://www.emote-app.com/img/emote-defaultLogo.png" />
		
		<r:require modules="core"/>
		<r:layoutResources/>
        <g:layoutHead />
    </head>
    <body onload="${pageProperty(name:'body.onload')}" class="clearfix">
    <browser:choice>
        <browser:isMobile></browser:isMobile>
        <browser:otherwise>
            <g:if test="${grailsApplication.config.emote.desktopBrowser.redirect.url?.length()}">
                <g:javascript>
                    window.location.href = '<g:createLink url="${grailsApplication.config.emote.desktopBrowser.redirect.url}"/>';
                </g:javascript>
            </g:if>
        </browser:otherwise>
    </browser:choice>
	                <g:layoutBody />
	                <r:layoutResources/>
      <fbg:resources/>  
    </body>
</html>

