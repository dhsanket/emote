<html>
<head>
    <r:require modules="landing"/>
</head>

<body class="landingBody">

<!-- ../img/landingPage/landingLogo.jpg -->
<div id="heade_wrapper">
    <div id="header">
        <r:img uri="img/landingPage/landingLogo.png"/>
        <h1>The first micro-review mobile app</h1>
        <h2><a href="http://www.emote-app.com/">www.emote-app.com</a> will allow you to spend less time trawling through page long
        reviews while still giving you a better understanding than a rating system!</h2>
    </div>
    <div id="landingContainer">
        <div id="landingContent"><br><br><div id="landingLogin">

            <a href="${facebookContext.getLoginURL(redirect_uri:createLink(controller:'user', action:'findUserInDB', absolute:true))}"
               onClick="_gaq.push(['_trackEvent', 'Facebook Registration', 'Facebook Signin', 'Emote App', 1, false]);">

                <r:img uri="img/landingPage/fb_login.png" />

            </a>


        </div>

            <r:img uri="img/landingPage/emote-app.jpg" />

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
