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
					<li><a href="#"><i class="icon-circle-arrow-up icon-white"></i> Popular</a></li>
					<li><a href="#"><i class="icon-star icon-white"></i> Favourites</a></li>
					<li><a href="#"><i class="icon-cog icon-white"></i> Settings</a></li>
				</ul>
			</section>
		</div>
