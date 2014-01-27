<body class="landingBody">


	<div id="landingLogo"><img src="../img/landingPage/landingLogo.jpg"/></div>
	<div id="landingContainer">
		<div id="landingContent">
			
		</div>
		<div id="landingFooter">
			<ul>
				<li>
					<div id="fb-root"></div>
					<script>(function(d, s, id) {
					  var js, fjs = d.getElementsByTagName(s)[0];
					  if (d.getElementById(id)) return;
					  js = d.createElement(s); js.id = id;
					  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
					  fjs.parentNode.insertBefore(js, fjs);
					}(document, 'script', 'facebook-jssdk'));</script>				
					<div class="fb-like" data-href="http://www.facebook.com/EmoteApp" data-width="The pixel width of the plugin" data-height="The pixel height of the plugin" data-colorscheme="light" data-layout="button_count" data-action="like" data-show-faces="false" data-send="true"></div>				
				</li>
				<li>
			        <!-- Place this tag where you want the share button to render. -->
			        <!-- tag where you want Google +1 button to render. -->
					<div class="g-plusone" data-size="medium"></div>
			    	<div class="g-plus" data-action="share" data-size="small" data-annotation="none"></div>
			    	<!-- Place this tag after the last share tag. -->
			    	<script type="text/javascript">
			      		window.___gcfg = {lang: 'en-GB'};
			      		(function() {
			        		var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
			        		po.src = 'https://apis.google.com/js/plusone.js';
			        		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
			      		})();
			    	</script>	
				</li>
			</ul>
			<div id="landingLogin">
				<!-- <a href="https://www.facebook.com/dialog/oauth?redirect_uri=http%3A%2F%2Flocalhost%3A8080%2F&amp;client_id=498699006889199&amp;scope=email&amp;state=3a0f51b6909195ddf2e6c885898f33e6" onclick="_gaq.push(['_trackEvent', 'Facebook Registration', 'Facebook Signin', 'Emote App', 1, false]);"><img src="/static/CnWCagyeEk6A7lvu2LBooHsn0gJ9t5xOP1YJluGUn7W.png"></a> -->
				<!-- <a href="${facebookContext.getLoginURL(redirect_uri:createLink(controller:'user', action:'findUserInDB', absolute:true))}"
			onClick="_gaq.push(['_trackEvent', 'Facebook Registration', 'Facebook Signin', 'Emote App', 1, false]);"><r:img uri= "img/fb-login.png" width="100%" /></a> -->
				<a href="${facebookContext.getLoginURL(redirect_uri:createLink(controller:'user', action:'findUserInDB', absolute:true))}" onclick="_gaq.push(['_trackEvent', 'Facebook Registration', 'Facebook Signin', 'Emote App', 1, false]);"><img src="/static/CnWCagyeEk6A7lvu2LBooHsn0gJ9t5xOP1YJluGUn7W.png"></a>
			</div>
		</div>
		<div class="clearfix"></div>
		<div id="landingDisclaimer">emote-app will not publish any content to your facebook without your explicit permission. By signing in with Facebook, you are agreeing to the <a href="/Terms.html">Terms of Service</a> and <a href="/Privacy.html">Privacy Policy</a></div>		
	</div>
</body>