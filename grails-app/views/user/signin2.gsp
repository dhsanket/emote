<html>
    <head>

    </head>
    <body>
	    <div id="signin">
	       <g:if test="${flash.message!= null} ">
	       		${flash.message} 
	       </g:if>
	    	<g:form action="doSignin">
	    		Email: <g:textField name="email" /><br/>
	    		passcode: <g:passwordField name="passcode" /><br/>
	    		<g:submitButton name="signin" value="Signin"/>
	    	</g:form>
	    <div id="signin">
    </body>
    
</html>