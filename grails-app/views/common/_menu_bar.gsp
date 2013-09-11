<div id="nav-menu">
	<section class="user-section" class="clearfix">
		<g:if test="${session.user != null}">
		<div class="user-image">
			<a href="${createLink(controller:'Emote',action:'userFeed', absolute:true)}"><facebook:picture facebookId="${session.user.facebookId}" /></a>
		</div>
		<div class="user-meta">
			<h1 class="user-name"><a href="${createLink(controller:'Emote',action:'userFeed', absolute:true)}">${session.user.firstName} ${session.user.lastName}</a></h1>
			<span class="user-email">${session.user.email}</span>
		</div>
		</g:if>
	</section>
	<span class="list-sub-title">Search</span>
	<section id="search-section">
		<g:form action="search" controller="emote" onsubmit="_gaq.push(['_trackEvent', 'Search', 'Submit', $(this).attr('action')]);">
			<input name="keyword" type="search" placeholder="Type to search..." />
		</g:form>
	</section>
	<span class="list-sub-title">Menu</span>
	<section id="menu-section">
		<ul>
			<li><a href="${createLink(controller:'emote',action:'feed', absolute:true)}"><i class="icon-home icon-white"></i> Home</a></li>
			<li><a href="${createLink(controller:'user',action:'displayUsers', absolute:true)}"><i class="icon-user icon-white"></i> Follow emote users</a></li>
			<li><a href="/help.html"><i class="icon-question-sign icon-white"></i> Help </a></li>
			<li><a href="${createLink(controller:'user',action:'signout', absolute:true)}"><i class="icon-cog icon-white"></i> Signout </a></li>
		</ul>
	</section>
	<span class="list-sub-title">Notifications</span>
	 <g:render template="/common/notifications" />

</div>

