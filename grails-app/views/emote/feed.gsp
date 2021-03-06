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
        <div id="appContainer">
            <g:render template="/common/header" />
            <g:render template="/common/create_emote" />
        </div> <!-- #appContainer -->
    	<g:render template="/common/menu_bar" />
    	<div id="feed-container" class="feed-container">
	    	<g:render template="/common/pagination_prev"/>
    		<g:render template="emotesTemplate"
                      model="[titles: flash.titles, showComments: flash.showComments, comments: flash.comments, favourites: flash.favourites, doingNow: flash.doingNow, inToDoList: flash.inToDoList]" />
	    	<g:render template="/common/pagination_next"/>
        </div><!-- /#feed-container -->
        <g:render template="/common/picture_crop" />
        <g:render template="/common/imageupload/web_search" />
        <g:render template="/common/flag_inappropriate" />
        <g:render template="/common/popup_tutorial" />
        <g:render template="/emote/picturesDialog"/>

         <div id="loadingOverlay"></div>
		 <div id="overlayMessage">&nbsp;</div>
    </body>
    
</html>