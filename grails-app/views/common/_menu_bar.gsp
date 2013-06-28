<div id="nav-menu">
	<section id="user-section" class="clearfix">
		<g:if test="${session.user != null}">
		<div class="user-image">
			<a href="emote/emote/feed.html"><facebook:picture facebookId="${session.user.facebookId}" /></a>
		</div>
		<div class="user-meta">
			<h1 class="user-name">${session.user.firstName} ${session.user.lastName}</h1>
			<span class="user-email">${session.user.email}</span>
		</div>
		</g:if>
	</section>
	<span class="list-sub-title">Search</span>
	<section id="search-section">
		<g:form action="doSearch" controller="emote">
			<input name="keyword" type="search" placeholder="Type to search..." />
		</g:form>
	</section>
	<span class="list-sub-title">Menu</span>
	<section id="menu-section">
		<ul>
			<li><g:link controller="emote" action="feed"><i class="icon-home icon-white"></i> Home</g:link></li>
			<li><a href="#"><i class="icon-pencil icon-white"></i> Add a review</a></li>
			<li><a href="#"><i class="icon-circle-arrow-up icon-white"></i> Popular</a></li>
			<%--<li><a href="${createLink(controller:'emote', action:'userFeed(session.user.userId)')}"><i class="icon-star icon-white"></i> My emotes and favorites</a></li>--%>
			<li><g:link  controller="emote" action="userFeed" params: "[userId: session.user.userId]" class="large btn-block"> <i class="icon-star icon-white"></i> My emotes and favorites </g:link> </li>
			<li><a href="#"><i class="icon-list icon-white"></i> To-do</a></li>
			<li><a href="#"><i class="icon-cog icon-white"></i> Settings</a></li>
			<li><a href="${facebookContext.getLogoutURL(next:createLink(controller:'user',action:'signout', absolute:true))}"><i class="icon-cog icon-white"></i> Signout (facebook & emote)</a></li>
		</ul>
	</section>
	<span class="list-sub-title">Notifications</span>
	<section id="menu-section">	
	<%--
			<g:if test="${session.user}">
				<h3>Follow/Invite fb friends</h3>
				<p>
				<g:render template="/common/fbfriends" model="[userFriends: userFriends]" />
				<g:render template="/common/fbfriends" model="[userFriends: userFriends]"/>
				</p>
			</g:if>
			<g:else>
				<strong><em>You are not Connected.</em></strong>
			</g:else>
	--%>

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
	
	
	
	
	</section>
</div>

