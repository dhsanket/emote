<!DOCTYPE html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
<!--[if IEMobile 7 ]>    <html class="no-js iem7"> <![endif]-->
<!--[if (gt IEMobile 7)|!(IEMobile)]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <title><g:layoutTitle default="emote\\o/" /></title>
	
		<meta charset="utf-8">
	    <meta name="description" content="">
        <meta name="HandheldFriendly" content="True">
        <meta name="MobileOptimized" content="320">
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
        <meta http-equiv="cleartype" content="on">

        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="img/touch/apple-touch-icon-144x144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="img/touch/apple-touch-icon-114x114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="img/touch/apple-touch-icon-72x72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="img/touch/apple-touch-icon-57x57-precomposed.png">
        <link rel="shortcut icon" href="img/touch/apple-touch-icon.png">

        <!-- Tile icon for Win8 (144x144 + tile color) -->
        <meta name="msapplication-TileImage" content="img/touch/apple-touch-icon-144x144-precomposed.png">
        <meta name="msapplication-TileColor" content="#222222">


        <!-- For iOS web apps. Delete if not needed. https://github.com/h5bp/mobile-boilerplate/issues/94 -->
        <!--
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="apple-mobile-web-app-title" content="">
        -->

        <!-- This script prevents links from opening in Mobile Safari. https://gist.github.com/1042026 -->
        <!--
        <script>(function(a,b,c){if(c in b&&b[c]){var d,e=a.location,f=/^(a|html)$/i;a.addEventListener("click",function(a){d=a.target;while(!f.test(d.nodeName))d=d.parentNode;"href"in d&&(d.href.indexOf("http")||~d.href.indexOf(e.host))&&(a.preventDefault(),e.href=d.href)},!1)}})(document,window.navigator,"standalone")</script>
        -->

	
		<r:require modules="core"/>
		<r:layoutResources/>		
        
        <g:layoutHead />
    </head>
    <body onload="${pageProperty(name:'body.onload')}" >
		<header>
			<a href="feed.html"><h1 id="logo" class="pull-left">emote</h1></a>
			<a href="#" id="toggleMenu" class="header-icon pull-left"><r:img uri="/img/menu-icon.png" width="100%" /></a>
			<a href="#" id="createEmote" class="header-icon pull-right"><r:img uri="/img/plus-icon.png" width="100%" /></a>
		</header>
		
		<div id="emote-creation-container">
			<div class="data-set clearfix">
				<div class="emote-create-content">
					<input required type="text" id="obj-title" class="emote-topic-input" placeholder="What is the emote topic?" />
					<input required type="text" id="tag" class="emote-tags-input" placeholder="put your emotes \o/ here" />
				</div>
			</div>
		</div>

		<div id="nav-menu">
			<section id="user-section" class="clearfix">
				<div class="user-image">
					<a href="userfeed.html"><img src="http://lorempixel.com/48/48" /></a>
				</div>
				<div class="user-meta">
				<g:if test="${session.user != null}">
					<h1 class="user-name">${session.user.firstName}&nbsp; ${session.user.LastName}</h1>
					<span class="user-email">${session.user.email}</span>
				</g:if>
				</div>
			</section>
			<span class="list-sub-title">Search</span>
			<section id="search-section">
				<form>
					<input type="search" placeholder="Type to search..." />
				</form>
			</section>
			<span class="list-sub-title">Menu</span>
			<section id="menu-section">
				<ul>
					<li><a href="feed.html"><i class="icon-home icon-white"></i> Home</a></li>
					<li><a href="#"><i class="icon-circle-arrow-up icon-white"></i> Popular</a></li>
					<li><a href="#"><i class="icon-star icon-white"></i> Favourites</a></li>
					<li><a href="#"><i class="icon-cog icon-white"></i> Settings</a></li>
				</ul>
			</section>
		</div>
			    
	        <g:layoutBody />
            		
		<r:layoutResources/>		
            
        <fbg:resources/>
        <!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
        <script>
            var _gaq=[["_setAccount","UA-XXXXX-X"],["_trackPageview"]];
            (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];g.async=1;
            g.src='//www.google-analytics.com/ga.js';
            s.parentNode.insertBefore(g,s)}(document,"script"));
        </script>
        
    </body>
</html>