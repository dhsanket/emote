<html>
    <head>

    </head>
    <body>
	    <div id="signin">
	       <img src="img/signin-logo.png" >
	       <g:if test="${flash.message!= null} ">
	       		${flash.message} 
	       </g:if>
	    	<g:form action="doSignin">
	    		Email: <g:textField name="email" placeholder="lowercase"/><br/>
	    		passcode: <g:passwordField name="passcode" placeholder="lowercase"/><br/>
	    		<g:submitButton class="btn btn-block btn-primary" name="signin" value="Signin"/>
	    	</g:form>
	    <div id="signin">
    </body>
    
</html>