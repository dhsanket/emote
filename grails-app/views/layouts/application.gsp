 <html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
    <head>
        <title><g:layoutTitle default="emote\\o/" /></title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="viewport" content="width=device-width, height=device-height, inital-scale=1.0, user-scalable = no">
		<link rel="icon" href="img/e5.png" type="image/x-icon">
		
		<meta name="apple-mobile-web-app-capable" content="yes">
		
		<link href="../css/normalize.css" rel="stylesheet" type="text/css">
		<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
		<link href="../css/grid.css" rel="stylesheet" type="text/css" />
		<link href="../css/style.css" rel="stylesheet" type="text/css" />

		<link href='http://fonts.googleapis.com/css?family=Sorts+Mill+Goudy' rel='stylesheet' type='text/css'>
        
        <g:layoutHead />
    </head>
    <body onload="${pageProperty(name:'body.onload')}" class="clearfix">
			<div id="container">
			    
				  <div id="global-nav" class=" grid_23 omega">
				      <ul class="grid_23 omega">
				              <li><g:link controller="emote" action="feed"><i class="icon-home"></i></g:link></li>
				              <li><a href="search.html"><g:link controller="emote" action="search"><i class="icon-search"></i></g:link></li>
				              <li class="navbaro"><g:link controller="emote" action="create"><img src="../img/emote.png"></g:link></li>
				              <li><g:link controller="user" action="profile"><i class="icon-user"></i></g:link></li>
				              <li><g:link controller="user" action="settings"><i class="icon-cog"></i></g:link></li>
				      </ul>
				  </div>
	             <div class="feed grid_23 omega">
	                <g:layoutBody />
	             </div>
	             <div class="copywright grid_23">All rights reserved - emote\o/&copy 2013</div>
              
            </div>
        <fbg:resources/>
    </body>
</html>