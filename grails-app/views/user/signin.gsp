<html>
    <head>
    <title>emote-app signin</title>
  
    </head>
    
    <body>
		<div id="splash-container">
		<div id="splash-logo">
			<r:img uri="img/splash-logo.png" width="80%" style="text-align: center; margin:0 auto;" />
			
			<span class="splash-description"><p>Beta version</p>
			emote-app is a new platform to express what you think and discover whether others agree with you!</span>
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