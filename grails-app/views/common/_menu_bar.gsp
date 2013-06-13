		<div id="nav-menu">
			<section id="user-section" class="clearfix">
				<div class="user-image">
					<a href="userfeed.html"><img src="http://lorempixel.com/48/48" /></a>
				</div>
				<div class="user-meta">
				<g:if test="${session.user != null}">
					<h1 class="user-name">${session.user.firstName}&nbsp; ${session.user.LastName}</h1>
					<span class="user-email">${session.user.email}</span>
				</g:if>
				</div>
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
