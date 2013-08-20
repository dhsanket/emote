
<div id="followUsers">



<g:each in="${emoteUsersList}" var="emoteUser">

<div class="user-section">
	<div class="user-image">
	<facebook:picture facebookId="${emoteUser.facebookId}" linkEnabled="true" /> 
	</div>
	
	<div class="user-meta">
	<h3 class="user-name">${emoteUser.firstName} ${emoteUser.lastName}</h3>
	</div>
	
	<div class="followButton" id="${emoteUser.id}">
		<a href="javascript:followUser('${emoteUser.id}')"> follow </a>
	</div>	 	
</div>

</g:each>


<g:each in="${userFriends}" var="friend">
<div class="user-section">
	<div class="user-image">
	<facebook:picture facebookId="${friend.id}" linkEnabled="true" />
	</div>
	
	<div class="user-meta">
	<h3 class="user-name">${friend.name}</h3>
	</div>		
<%--	<img src="https://graph.facebook.com/${friend.id}/picture">--%>
	
	<div class="followButton">
		<a href="${createLink(controller:'emote', action:'feed')}" > invite </a>
	</div>	 
	

</div>	
</g:each>

