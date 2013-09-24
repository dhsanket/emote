<html>
    <head>
    <title>emote-app signin</title>
    		<a href="https://plus.google.com/111094199736252097583" rel="publisher" />
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
			<span class="splash-description">Write a review in as little as one click & discover what interesting stuff your friends are doing!</span>
		</div>
		
		<div id="splash-login">
			<a href="${facebookContext.getLoginURL(redirect_uri:createLink(controller:'emote', action:'feed', absolute:true))}"
			onClick="_gaq.push(['_trackEvent', 'Facebook Registration', 'Facebook Signin', 'Emote App', 1, false]);"><r:img uri= "img/fb-login.png" width="100%" /></a>
			<span class="splash-disclaimer">
				emote-app will not publish any content to your facebook without your explicit permission. </br> 
				By signing in with Facebook, you are agreeing to the <a href="/Terms.html">Terms of Service</a> and <a href="/Privacy.html">Privacy Policy</a>
			</span>
		</div>
		
		</div>

		<p>&nbsp;</p>
    </body>
</html>