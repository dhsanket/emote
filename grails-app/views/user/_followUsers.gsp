
<g:each in="${emoteUsersList}" var="emoteUser">
<p>
<div class="user-image">
<facebook:picture facebookId="${emoteUser.facebookId}" linkEnabled="true" /> </div>
<div class="user-meta">
<a href="${createLink(controller:'emote', action:'feed')}" class="btn-block"> Invite </a> </div>	
</p>
</g:each>


<g:each in="${userFriends}" var="friend">
<p>
<facebook:picture facebookId="${friend.id}" linkEnabled="true" />
	<%--<img src="https://graph.facebook.com/${friend.id}/picture">--%>
<a href="${createLink(controller:'emote', action:'feed')}" class="btn-block"> Invite </a>	
</p>
</g:each>
	
