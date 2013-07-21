<html>
    <head>
		<script type="text/javascript">
			function facebookLogin() {
				FB.getLoginStatus(function(response) {
					if (response.status === 'connected') {
						// logged in and connected user, redirect to feed
						window.location ="${createLink(controller:'Emote', action:'feed')}";
					}else{
						window.location ="${createLink(controller:'user', action:'signin')}";			
					}
				});
			}
		</script>    
    </head>
    <body>
		<div id="splash-container">
		<div id="splash-logo">
			<r:img uri="img/splash-logo.png" width="80%" style="text-align: center; margin:0 auto;" />
			<span class="splash-description">Discover great things, and be heard.</span>
		</div>
		
		<div id="splash-login">
			<a href="${facebookContext.getLoginURL(redirect_uri:createLink(controller:'emote', action:'feed', absolute:true))}"><r:img uri= "img/fb-login.png" width="100%" /></a>
			<span class="splash-disclaimer">
				By signing in with Facebook, you are agreeing to the <a href="/Terms.html">Terms of Service</a> and <a href="/Privacy.html">Privacy Policy</a>
			</span>
		</div>
		
		</div>

		<p>&nbsp;</p>
    </body>
</html>