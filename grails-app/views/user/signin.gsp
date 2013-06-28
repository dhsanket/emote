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
					<a href="${facebookContext.getLoginURL(redirect_uri:createLink(controller:'user', action:'storeFBUser', absolute:true))}" class="large btn">
									Login via Facebook</a>
					<p>By tapping on "Login via Facebook" above, you are agreeing to the Terms of Service and Privacy Policy.</p>				
                 	<%-- <g:if test="${session.user}">
                        
	                        <g:link  controller="emote" action="feed" class="large btn-block"> Go to emote\o/ feed </g:link>  
	                       OR
	                        <p><a href="${createLink(controller:'emote', action:'feed')}" class="btn-block"> Go to emote\o/ feed </a> </p>
	                       Give Error: JS does not load with above method
	                     
	                        
	                        <p><a href="emote/feed" class="btn-block"> Go to emote\o/ feed </a> </p>
	                        <p><a href="${facebookContext.getLogoutURL(next:createLink(action:'signout', absolute:true))}" class="btn-block">
	                        Logout of facebook & emote </a> </p>
	                         <p>FBToken: ${facebookContext.user.token}</p>
	                            
                        </g:if>
                        <g:else>
							<g:link  controller="user" action="storeFBUser" class="large btn-block"> Signin to emote-app </g:link>
                        </g:else> --%>
                </div>
			</g:if>
			<g:else>
				<div class="authentication">
						<div class="emote">								
								<div class="btn"> 
									<a href="${facebookContext.getLoginURL(redirect_uri:createLink(controller:'user', action:'storeFBUser', absolute:true))}" class="large btn">
									Login via Facebook</a>
									
										<%--
									   <facebook:loginLink appPermissions="${facebookContext.app.permissions}" elementClass="large primary btn pull-right">Login</facebook:loginLink>
				                        Log in via Facebook JavaScript SDK:<br />
				                        (<i>client-side, with Facebook Grails SDK handling authorization code from cookie on reload</i>)
										--%>
								
								</div>
								By tapping on "Login via Facebook" above, you are agreeing to the Terms of Service and Privacy Policy.
						</div>
				</div>                    
			</g:else>
			<br />	
			<br />
			<br />	
			
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