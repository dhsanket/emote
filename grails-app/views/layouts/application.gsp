<!DOCTYPE html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
<!--[if IEMobile 7 ]>    <html class="no-js iem7"> <![endif]-->
<!--[if (gt IEMobile 7)|!(IEMobile)]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <title><g:layoutTitle default="emote-app" /></title>
	
		<meta charset="utf-8">
	    <meta name="description" content="">
        <meta name="HandheldFriendly" content="True">
        <meta name="MobileOptimized" content="320">
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
        <meta http-equiv="cleartype" content="on">

        <!-- For Facebook sharing -->
		<meta property="og:url"             content="http://www.emote-app.com" /> 
		<meta property="og:title"           content="emote-app: discover what your friends think about..." /> 
		<meta property="og:image"           content="http://www.emote-app.com/img/emote-defaultLogo.png" />

        <!-- For iOS web apps. Delete if not needed. https://github.com/h5bp/mobile-boilerplate/issues/94 -->       
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="apple-mobile-web-app-title" content="">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="img/touch/apple-touch-icon-144x144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="img/touch/apple-touch-icon-114x114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="img/touch/apple-touch-icon-72x72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="img/touch/apple-touch-icon-57x57-precomposed.png">

        <!-- For Android -->		
		<meta name="mobile-web-app-capable" content="yes">
		
        <%--for Google+--%>
        <link rel="canonical" href="http://www.emote-app.com" />
		

        <!-- Tile icon for Win8 (144x144 + tile color) -->
        <meta name="msapplication-TileImage" content="img/touch/apple-touch-icon-144x144-precomposed.png">
        <meta name="msapplication-TileColor" content="#222222">

        <!-- other necessities -->
		<a href="https://www.emote-app.com" rel="publisher" />
		<a href="https://plus.google.com/111094199736252097583" rel="publisher" />
        <link href='http://fonts.googleapis.com/css?family=Sorts+Mill+Goudy' rel='stylesheet' type='text/css'>

		<!-- This script prevents links from opening in Mobile Safari. https://gist.github.com/1042026 -->
        <script>(function(a,b,c){if(c in b&&b[c]){var d,e=a.location,f=/^(a|html)$/i;a.addEventListener("click",function(a){d=a.target;while(!f.test(d.nodeName))d=d.parentNode;"href"in d&&(d.href.indexOf("http")||~d.href.indexOf(e.host))&&(a.preventDefault(),e.href=d.href)},!1)}})(document,window.navigator,"standalone")</script>
		
		<r:require modules="mobileAndDesktop"/>
        <browser:choice>
            <browser:isMobile>
                <r:require modules="mobileTablet"/>
            </browser:isMobile>
            <browser:otherwise>
                <r:require modules="desktop"/>
            </browser:otherwise>
        </browser:choice>

        <r:layoutResources/>
        <g:layoutHead />
        
    </head>
    
    
	<body onload="${pageProperty(name:'body.onload')}" class="${pageProperty(name: 'body.class')}">

        <!--[if lt IE 10]>
                <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
            <![endif]-->
        <noscript>
            <img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/offsite_event.php?id=6010473097304&amp;value=0&amp;currency=GBP" />
        </noscript>
	
    	<div id="fb-root"></div>
        <div class="quick-create-overlay"></div>

    	<facebook:initJS appId="${facebookContext.app.id}" xfbml="${true}" />
			
    	
				<%--<script> 
				window.fbAsyncInit = function() {
					//Facebook JS SDK - http://developers.facebook.com/docs/reference/javascript/
					//https://developers.facebook.com/docs/facebook-login/getting-started-web/
					  // init the FB JS SDK
				  FB.init({
				    appId      : '${FacebookAppId}',                        // App ID from the app dashboard
				    channelUrl : '*.herokuapp.COM/channel.html', // Channel file for x-domain comms
				    status     : true,                                 // Check Facebook Login status
				    xfbml      : true                                  // Look for social plugins on the page
				  });
				
				  // Additional initialization code such as adding Event Listeners goes here				  
				};

				// Load the SDK asynchronously
				(function(d, s, id){
				   var js, fjs = d.getElementsByTagName(s)[0];
				   if (d.getElementById(id)) {return;}
				   js = d.createElement(s); js.id = id;
				   js.src = "//connect.facebook.net/en_US/all.js";
				   fjs.parentNode.insertBefore(js, fjs);
				 }(document, 'script', 'facebook-jssdk'));


				  // Here we run a very simple test of the Graph API after login is successful. 
				  // This testAPI() function is only called in those cases. 
				  function testAPI() {
				    console.log('Welcome!  Fetching your information.... ');
				    FB.api('/me', function(response) {
				      console.log('Good to see you, ' + response.name + '.');
				    });
				  }

				 
				</script>--%>

                <g:layoutBody />
                <r:layoutResources/>
                <fbg:resources/>

        <!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
		<script>
         var _gaq = [["_setAccount", "UA-43715253-1"], ["_trackPageview"]];
         (function(d, t){var g = d.createElement(t), s = d.getElementsByTagName(t)[0]; g.async = 1;
                 g.src = '//www.google-analytics.com/u/ga_debug.js';
                 s.parentNode.insertBefore(g, s)}(document, "script"));    
         </script>
        
        <script>
		  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		
		  ga('create', 'UA-43715253-1', 'emote-app.com');
		  ga('send', 'pageview');		
		</script>
		
		<!-- Place this tag after the last +1 button tag. -->
		<script type="text/javascript">
		  (function() {
		    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
		    po.src = 'https://apis.google.com/js/plusone.js';
		    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
		  })();
		</script>
		        
		<script> $(function() { $.scrollDepth();}); </script>
		
		    <!-- Place this tag after the last share tag. -->
    <script type="text/javascript">
      window.___gcfg = {lang: 'en-GB'};
      (function() {
        var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
        po.src = 'https://apis.google.com/js/plusone.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
      })();
    </script>
	
	
    </body>
</html>
