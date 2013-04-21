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
				              <li><a href="feed.html"><i class="icon-home"></i></a></li>
				              <li><a href="search.html"><i class="icon-search"></i></a></li>
				              <li class="navbaro"><a href="emote.html"><img src="../img/emote.png"></a></li>
				              <li><a href="profile.html"><i class="icon-user"></i></a></li>
				              <li><a href="settings.html"><i class="icon-cog"></i></a></li>
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