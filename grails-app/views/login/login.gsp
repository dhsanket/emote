<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
<script type="text/javascript">
	function facebookLogin() {
        alert("After facebook login");
		FB.getLoginStatus(function(response) {
			if (response.status === 'connected') {
				// logged in and connected user, someone you know
				window.location ="${createLink(controller:'login', action:'friends')}";
			}else {
			    window.location ="${createLink(controller:'login', action:'fail')}";
			}
		});
	}
</script>
</head>
<body>
 "Welcome to emots \\o/"



<fbg:resources/>

<fb:login-button scope="email,publish_stream" onlogin="javascript:facebookLogin();" size="large">
	<g:message code="auth.login.facebook"/>
</fb:login-button>
</body>
 </html>