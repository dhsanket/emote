<html>
    <head>
     <title>www.emote-app.com</title>
		<script type="text/javascript">
		var fb_param = {};
		fb_param.pixel_id = '6010473097304';
		fb_param.value = '0.00';
		fb_param.currency = 'GBP';
		(function(){
		  var fpw = document.createElement('script');
		  fpw.async = true;
		  fpw.src = '//connect.facebook.net/en_US/fp.js';
		  var ref = document.getElementsByTagName('script')[0];
		  ref.parentNode.insertBefore(fpw, ref);
		})();
		</script>
		<noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/offsite_event.php?id=6010473097304&amp;value=0&amp;currency=GBP" /></noscript>

    </head>
    <body>
        <browser:choice>
			<browser:isMobile>
				        <g:javascript>
		                    window.location.href = '<g:createLink url="${createLink(controller:'emote',action:'feed', absolute:true)}"/>';
		                </g:javascript>
			</browser:isMobile>
	        <browser:otherwise>
	            <g:if test="${grailsApplication.config.emote.desktopBrowser.redirect.url?.length()}">
	                <g:javascript>
	                    window.location.href = '<g:createLink url="${createLink(controller:'user',action:'landingPage', absolute:true)}"/>';
	                </g:javascript>
	            </g:if>
	        </browser:otherwise>
	    </browser:choice>
    </body>
    
</html>