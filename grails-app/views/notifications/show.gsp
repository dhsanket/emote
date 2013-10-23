<g:if test="${notifications != null}">
	<g:each  in="${notifications}" var="notification">
		${notification.message} 
	</g:each>
</g:if>