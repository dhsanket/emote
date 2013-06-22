<html>
    <head>
		<script type="text/javascript">
			function facebookLogin() {
				FB.getLoginStatus(function(response) {
					if (response.status === 'connected') {
						// logged in and connected user, redirect to feed
						window.location ="${createLink(controller:'emote', action:'feed')}";
					}else{
						window.location ="${createLink(controller:'user', action:'signin')}";			
					}
				});
			}
		</script>    
    </head>
    <body>
    <g:if test="${!facebookContext.app.id}">
			<g:render template="/website/configError" />
	</g:if>
	<g:else>
			<!--
			  We use the Facebook JavaScript SDK to provide a richer user experience. For more info,
			  look here: http://github.com/facebook/facebook-js-sdk
			-->
			<facebook:initJS appId="${facebookContext.app.id}">
				// Put here any JS code to be executed after Facebook JS initialization
			</facebook:initJS>
			
			<h2 class="tab">Authentication</h2>
			<g:if test="${facebookContext.authenticated}">
				<div class="authentication">
                        <g:link  controller="user" action="storeFBUser" class="pull-right large btn">signin</g:link>
                        
                </div>
			</g:if>
			<g:else>
				<div class="authentication">
						<div class="emote">								
								<div class="btn"> 
									<a href="${facebookContext.getLoginURL(redirect_uri:createLink(controller:'user', action:'storeFBUser', absolute:true))}" class="pull-right large btn">
									Login via Facebook</a>
								</div>
								<g:if test="${facebookContext.authenticated}"> 
			                    User is authenticated
			                    </g:if>
								By tapping on "Login via Facebook" above, you are agreeing to the Terms of Service and Privacy Policy.
						</div>
				</div>                    
			</g:else>
			<br />	
			<br />
			<br />	
			<g:if test="${session.user}">
				<h2 class="tab">Your data</h2>
				<p>
					<facebook:picture facebookId="${session.user.facebookId}" linkEnabled="true" />
					${session.user.firstName} ${session.user.lastName}<br />
				</p>
				<%--
				<h3>Your friends</h3>
				<p>
					<g:each in="${userFriends}" var="friend">
						<img src="https://graph.facebook.com/${friend.id}/picture">
					</g:each>
				</p>
				--%>
			</g:if>
			<g:else>
				<strong><em>You are not Connected.</em></strong>
			</g:else>
		<br />
		<br />
		<br />
		</g:else>
		<p>&nbsp;</p>
    	    <%--<div class="emote">
	       		<g:if test="${flash.message!= null} ">
	       		${flash.message} 
	      		</g:if>
	    		<g:form action="signinAction">
	    		Email: <g:textField name="email" placeholder="lowercase"/><br/>
	    		Passcode: <g:passwordField name="passcode" placeholder="lowercase"/><br/>
	    		Please do not discuss or share information about emote\o/ with others as we are still in early development and not ready for public release. We appreciate your feedback and cooperation. Press button below to agree and signin.
	    		<g:submitButton class="btn btn-primary btn-block" name="signin" value="Signin"/>
	    		</g:form>
	   		</div>--%>
    </body>
</html>