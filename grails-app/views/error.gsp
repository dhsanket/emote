<!DOCTYPE html>
<html>
	<head>
		<title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
		<meta name="layout" content="main">
		<g:if env="development"><link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css"></g:if>
	</head>
	<body>
		<g:if env="development">
			<g:renderException exception="${exception}" />
		</g:if>
		<g:else>
			<ul class="errors">
				<li><g:message code="default.error.message"/></li>
                <li><g:message code="default.error.back.url.message"
                               args="${[link(url: (grailsApplication.config.emote.error.retrieve.url)?:"/"){message(code:"default.error.link.message")}]}"/></li>
			</ul>
		</g:else>
	</body>
</html>
