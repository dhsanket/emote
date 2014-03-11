<div id="nav-menu">
    <section class="user-section clearfix">
		<g:if test="${session.user != null}">

		<div class="user-image">
			<a href="${createLink(controller:'Emote',action:'userFeed', absolute:true)}"><facebook:picture facebookId="${session.user.facebookId}" /></a>
        </div> <!-- /.user-image -->

		<div class="user-meta">
			<h1 class="user-name"><a href="${createLink(controller:'Emote',action:'userFeed', absolute:true)}">${session.user.firstName} ${session.user.lastName}</a></h1>
			<span class="user-email">${session.user.email}</span>
        </div><!-- /.user-meta -->

		</g:if>
    </section><!-- /.user-section -->
	
	
	<span class="list-sub-title">Search</span>

	<section id="search-section">
		<g:form action="search" controller="emote" onsubmit="_gaq.push(['_trackEvent', 'Search', 'Submit', jQuery(this).attr('action')]);">
			<input id="searchField" name="keyword" type="search" placeholder="Type to search..." />
		</g:form>
    </section> <!-- /#search-section -->
	
	<span class="list-sub-title">Menu</span>
	<section id="menu-section">
		<ul>
			<li><a href="${createLink(controller:'emote',action:'feed', absolute:true)}"><i class="icon-home icon-white"></i> Home</a></li>
			<li><a href="${createLink(controller:'user',action:'displayUsers', absolute:true)}"><i class="icon-user"></i> Follow emote users</a></li>
			<li><a href="javascript:showTutorialPopup();"><i class="icon-question-sign"></i> Help </a></li>
            <g:if test="${session.user}">
                <li><a href="${createLink(controller:'user',action:'signout', absolute:true)}"><i class="icon-cog"></i> Signout </a></li>
            </g:if>
            <g:else>
                <li><a href="${createLink(controller:'user',action:'signin', absolute:true)}"><i class="icon-cog"></i> Login </a></li>
            </g:else>
		</ul>
    </section> <!-- /#menu-section -->
	<span class="list-sub-title">Notifications</span>
	<g:render template="/common/notifications" />

</div> <!-- /#nav-menu -->