<div id="user-header">
	<section id="user-profile-header" class="clearfix">
		<div id="user-profile-picture">
			<facebook:picture facebookId="${session.user.facebookId}" />
		</div>
		<div id="user-profile-info">
			<h1 class="user-profile-name">${session.user.firstName} ${session.user.lastName}</h1>
			<span class="user-profile-location">${session.user.email}</span>
		</div>
		<div id="user-profile-switcher">
			<ul>
				<li><a id="profile-emotes" href="#"><i class="icon-tag icon-white"></i></a></li>
				<li><a id="profile-images" href="#"><i class="icon-camera icon-white"></i></a></li>
			</ul>
		</div>
	</section>
</div>