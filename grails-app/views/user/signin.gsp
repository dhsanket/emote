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
				<ul class="authentication">
                    <li>
                        <facebook:logoutLink elementClass="btn pull-right" nextUrl="${createLink(action:'signout')}">Logout</facebook:logoutLink>
                        Log out via Facebook JavaScript SDK:
                    </li>
                    <li>
                        <a href="${facebookContext.getLogoutURL(next:createLink(action:'signout', absolute:true))}" class="btn pull-right">
                            Logout 
                        </a>
                        Log out Facebook.com server side redirect:
                    </li>
                </ul>
			</g:if>
			<g:else>
				<ul class="authentication">
                    <li>
                        <facebook:loginLink appPermissions="${facebookContext.app.permissions}" elementClass="large primary btn pull-right">Login</facebook:loginLink>
                        Log in via Facebook JavaScript SDK:<br />
                        (<i>client-side, with Facebook Grails SDK handling authorization code from cookie on reload</i>)
                    </li>
                    <li>
						<div class="emote">
								
								<div class="btn"> 
									<a href="${facebookContext.loginURL}" class="pull-right large btn">Login via Facebook</a>
									
									Facebook.com server side redirect:<br />
			                        (<i>server-side, with Facebook Grails SDK handling authorization code from url on return</i>)
												
 												<script type="text/javascript">
												function facebookLogin() {
													FB.getLoginStatus(function(response) {
														if (response.status === 'connected') {
															// logged in and connected user, redirect to feed
															window.location ="${createLink(controller:'user', action:'storeFBUser')}";
														}else{
															window.location ="${createLink(controller:'user', action:'signin')}";			
														}
													});
												}
												</script>  
 
								</div>
								 		By tapping on "Sign in" above, you are agreeing to the Terms of Service and Privacy Policy.
						</div>                    
					</li>
                </ul>
			</g:else>
			<p>&nbsp;</p>

			
			<g:if test="${user}">
				<h2 class="tab">Your data</h2>
				<p>
					<facebook:picture facebookId="${user.facebookid}" linkEnabled="true" />
					${user.firstname}<br />
				</p>
				<h3>Your friends</h3>
				<p>
					<g:each in="${userFriends}" var="friend">
						<img src="https://graph.facebook.com/${friend.id}/picture">
					</g:each>
				</p>
			</g:if>
			<g:else>
				<strong><em>You are not Connected.</em></strong>
			</g:else>
			<p>&nbsp;</p>
		</g:else>
		<h2 class="tab">Public data</h2>
		<h3>Profile pic + name</h3>
		<p>
            <facebook:picture facebookId="benorama" linkEnabled="true" />
			${benorama?.name}
		</p>
        <p>&nbsp;</p>
        <h2 class="tab">Facebook Dialogs</h2>
        <r:script>
            function addToPage_callback(response) {alert(response && response.tabs_added.length + ' app added')}
            function invite_callback(response) {console.log(response)}
            function publish_callback(response) {if (response && response.success) alert('Published successfully')}
            function send_callback(response) {if (response && response.success) alert('Sent successfully')}
        </r:script>
        <facebook:addToPageLink callback="addToPage_callback" elementClass="btn">Add to page</facebook:addToPageLink>
        <facebook:inviteLink callback="invite_callback" elementClass="btn" message="Check this app!">Invite</facebook:inviteLink>
        <facebook:publishLink callback="publish_callback" elementClass="btn">Publish</facebook:publishLink>
        <facebook:sendLink callback="send_callback" elementClass="btn" link="http://www.google.com" to="594317994">Send a link to a friend</facebook:sendLink>
	
		<br />
		<br />
		<br />
    
    	    <div class="emote">
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