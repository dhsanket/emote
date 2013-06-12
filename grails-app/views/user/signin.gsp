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
					
					<div class="btn btn-primary btn-block"> 
						<a href="${facebookContext.loginURL}" class="pull-right large btn">Login</a>
                        Log in via Facebook.com server side redirect:<br />
                        (<i>server-side, with Facebook Grails SDK handling authorization code from url on return</i>)
					</div>
					 		By tapping on "Sign in" above, you are agreeing to the Terms of Service and Privacy Policy.
			</div>
    
    	    <div class="emote" style="background:#232323;">
	       <g:if test="${flash.message!= null} ">
	       		${flash.message} 
	       </g:if>
	    	<g:form action="signinAction">
	    		Email: <g:textField name="email" placeholder="lowercase"/><br/>
	    		Passcode: <g:passwordField name="passcode" placeholder="lowercase"/><br/>
	    		Please do not discuss or share information about emote\o/ with others as we are still in early development and not ready for public release. We appreciate your feedback and cooperation. Press button below to agree and signin.
	    		<g:submitButton class="btn btn-primary btn-block" name="signin" value="Signin"/>
	    	</g:form>
	    </div>
    
    </body>
</html>