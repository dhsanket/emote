<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<!--[if IEMobile 7 ]>    <html class="no-js iem7"> <![endif]-->
<!--[if (gt IEMobile 7)|!(IEMobile)]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <title>emote-app</title>
	
		<meta charset="utf-8">
	    <meta name="description" content="">

		<link href="css/landing.css" rel="stylesheet" type="text/css">
		
		<link href='http://fonts.googleapis.com/css?family=Sorts+Mill+Goudy' rel='stylesheet' type='text/css'>

        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
        <meta http-equiv="cleartype" content="on">

        <!-- For Facebook sharing -->
		<meta property="og:url"             content="http://www.emote-app.com" /> 
		<meta property="og:title"           content="emote-app: discover what your friends think about..." /> 
		<meta property="og:image"           content="http://www.emote-app.com/img/emote-defaultLogo.png" />

        <!-- For iOS web apps. Delete if not needed. https://github.com/h5bp/mobile-boilerplate/issues/94 -->

        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="img/touch/apple-touch-icon-144x144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="img/touch/apple-touch-icon-114x114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="img/touch/apple-touch-icon-72x72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="img/touch/apple-touch-icon-57x57-precomposed.png">

        <link rel="canonical" href="http://www.emote-app.com" />
		
        <!-- Tile icon for Win8 (144x144 + tile color) -->
        <meta name="msapplication-TileImage" content="img/touch/apple-touch-icon-144x144-precomposed.png">
        <meta name="msapplication-TileColor" content="#222222">

        <!-- This script prevents links from opening in Mobile Safari. https://gist.github.com/1042026 -->

        <script>(function(a,b,c){if(c in b&&b[c]){var d,e=a.location,f=/^(a|html)$/i;a.addEventListener("click",function(a){d=a.target;while(!f.test(d.nodeName))d=d.parentNode;"href"in d&&(d.href.indexOf("http")||~d.href.indexOf(e.host))&&(a.preventDefault(),e.href=d.href)},!1)}})(document,window.navigator,"standalone")</script>

</head>

<body class="landingBody">

<!-- ../img/landingPage/landingLogo.jpg -->
<div id="heade_wrapper">
    <div id="header">
        <img src="images/landingPage/landingLogo.png"/>
        <h1>The first micro-review mobile app</h1>
        <h2><a href="http://www.emote-app.com/">www.emote-app.com</a> will allow you to spend less time trawling through page long
        reviews while still giving you a better understanding than a rating system!</h2>
    </div>
    <div id="landingContainer">
        <div id="landingContent"><br><br><div id="landingLogin">

            <a href="${facebookContext.getLoginURL(redirect_uri:createLink(controller:'user', action:'findUserInDB', absolute:true))}"
               onClick="_gaq.push(['_trackEvent', 'Facebook Registration', 'Facebook Signin', 'Emote App', 1, false]);">

                <img src="images/landingPage/fb_login.png" />

            </a>


        </div>

                <img src="images/landingPage/emote-app.jpg" />

        </div>
        <div id="landingFooter">
            <ul id="social_icons">
                <li>
                    <!-- Place this tag where you want the share button to render. -->
                    <!-- tag where you want Google +1 button to render. -->
                    %{--<a href="https://plus.google.com/111094199736252097583">  </a>--}%
                    <div class="g-plusone" data-size="medium"></div>
                    <div class="g-plus" data-action="share" data-size="small" data-annotation="none"></div>
                    <!-- Place this tag after the last share tag. -->
                    <script type="text/javascript">
                        window.___gcfg = {lang: 'en-GB'};
                        (function() {
                            var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
                            po.src = 'https://apis.google.com/js/plusone.js';
                            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
                        })();
                    </script>

                </li>
                <li>
                    <div id="fb-root"></div>
                    <script>(function(d, s, id) {
                        var js, fjs = d.getElementsByTagName(s)[0];
                        if (d.getElementById(id)) return;
                        js = d.createElement(s); js.id = id;
                        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
                        fjs.parentNode.insertBefore(js, fjs);
                    }(document, 'script', 'facebook-jssdk'));</script>
                    <div class="fb-like" data-href="http://www.facebook.com/EmoteApp" data-width="The pixel width of the plugin" data-height="The pixel height of the plugin" data-colorscheme="light" data-layout="button_count" data-action="like" data-show-faces="false" data-send="true"></div>
                </li>

                <li>

                </li>
            </ul>

            <div id="landingDisclaimer">emote-app will not publish any content to your facebook without your explicit permission. By signing in with Facebook, you are agreeing to the <a href="/Terms.html">Terms of Service</a> and <a href="/Privacy.html">Privacy Policy</a>
            </div>

        </div>


    </div>
</div>
<p class="clear">&copy; Copyright  <a href="http://www.emote-app.com/">emote.com </a>. All rights reserved. </p>

</body>
</html>
