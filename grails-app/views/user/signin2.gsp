<html>
    <head>

    </head>
    <body>
	    <div id="signin">
	       <img src="img/signin-logo.png" >
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