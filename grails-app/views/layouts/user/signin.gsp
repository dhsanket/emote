<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
    <head>
        <title><g:layoutTitle default="emote-app" /></title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="viewport" content="width=device-width, height=device-height, inital-scale=1.0, user-scalable = no">
	
	    <meta name="description" content="">
        <meta name="HandheldFriendly" content="True">
        <meta name="MobileOptimized" content="320">

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

		
        <%--for Google+--%>
        <link rel="canonical" href="http://www.emote-app.com" />
		

        <!-- Tile icon for Win8 (144x144 + tile color) -->
        <meta name="msapplication-TileImage" content="img/touch/apple-touch-icon-144x144-precomposed.png">
        <meta name="msapplication-TileColor" content="#222222">

		<a href="https://www.emote-app.com" rel="publisher" />
		<a href="https://plus.google.com/111094199736252097583" rel="publisher" />

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
        
		<script type="text/javascript">
			function facebookLogin() {
				FB.getLoginStatus(function(response) {
					if (response.status === 'connected') {
						// logged in and connected user, redirect to feed
						window.location ="${createLink(controller:'Emote', action:'feed')}";
					}else{
						window.location ="${createLink(controller:'user', action:'signin')}";			
					}
				});
			}
		</script>  
       
        
    </head>
    
    
    <body onload="${pageProperty(name:'body.onload')}" class="clearfix">
    <browser:choice>
        <browser:isMobile></browser:isMobile>
        <browser:otherwise>
            <g:if test="${grailsApplication.config.emote.desktopBrowser.redirect.url?.length()}">
                <g:javascript>
                    window.location.href = '<g:createLink url="${grailsApplication.config.emote.desktopBrowser.redirect.url}"/>';
                </g:javascript>
            </g:if>
        </browser:otherwise>
    </browser:choice>
    
        <div id="fb-root"></div>
    	<facebook:initJS appId="${facebookContext.app.id}" xfbml="${true}" />
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

