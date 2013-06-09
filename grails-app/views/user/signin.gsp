<html>
    <head>
		<script type="text/javascript">
			function facebookLogin() {
				FB.getLoginStatus(function(response) {
					if (response.status === 'connected') {
						// logged in and connected user, someone you know
						window.location ="${createLink(controller:'user', action:'signinAndInvite')}";
					}else{
						window.location ="${createLink(controller:'user', action:'error')}";			
					}
				});
			}
		</script>    
    </head>
    <body>
			<div class="emote" style="background:#232323;">
					<img src="../img/emote-splash.png" >
					<div class="btn btn-primary btn-block"> 
						<fb:login-button scope="email,publish_stream" onlogin="facebookLogin();" >
							<g:message default="Sign in with Facebook"   code="auth.login.facebook"/>
						</fb:login-button>
					</div>
					 		By tapping on "Sign in" above, you are agreeing to the Terms of Service and Privacy Policy.
			</div>
    </body>
</html>