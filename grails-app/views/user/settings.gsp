<html>
<head>
<script type="text/javascript"></script>
<g:javascript library="jquery" />
</head>
<body>

	 <div id="message">
	<g:remoteLink controller='user' action="signout" update="message">
		Logout
	</g:remoteLink>
	</div>
	
</body>
</html>