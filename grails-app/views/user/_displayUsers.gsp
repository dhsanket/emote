
<div id="followUsers">


<input type="checkbox" value="sanket.deshpande" onchange="addFriendToInvite(this)" /> Sanket
<input type="checkbox" value="nitin.karmuse"  onchange="addFriendToInvite(this)"  /> Nitin

<g:each in="${emoteUsersList}" var="emoteUser">

<div class="user-section">
	<span class="user-image">
	<facebook:picture facebookId="${emoteUser.facebookId}" linkEnabled="true" /> 
	</span>
	
	<span class="user-meta">
	<h3 class="user-name">${emoteUser.firstName} ${emoteUser.lastName}</h3>
	</span>
	
	<span class="followButton" id="${emoteUser.id}">
		<a href="javascript:followUser('${emoteUser.id}');" > follow </a>
	</span>
</div>
</g:each>

<g:each in="${userFriends}" var="friend">
<div class="user-section">
	<span class="user-image">
	<facebook:picture facebookId="${friend.id}" linkEnabled="true" />
	</span>
	
	<span class="user-meta">
	<h3 class="user-name">${friend.name}</h3>
	</span>
<%--	<img src="https://graph.facebook.com/${friend.id}/picture">--%>
	<input type="checkbox" onchange="addFriendToInvite(this)"   value="${friend.id}" />
	<span class="followButton">
		<a href="${createLink(controller:'emote', action:'feed')}" > invite </a>
	</span>
	

</div>	
</g:each>