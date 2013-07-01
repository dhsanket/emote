(function($) {
		
		$.fn.refreshFeed = function (feedContents) {
			var titlePlaceHolder = "What is that you want to emote about?";
			document.getElementById("emoteSave").reset();	
			$('#tag').removeTag();
			//$('#tag').reset();
			$('#obj-title').prop('placeholder', titlePlaceHolder);
		
			$('#obj-title').focus(function(){
	    		$(this).prop('placeholder', "");
	    	});
			$('#obj-title').blur(function(){
    		$(this).prop('placeholder', titlePlaceHolder);
			});
			
		    // Fade out the feed container
		    $('#feed-container div.emote-v2').fadeOut(125);
	
		    // change content
		    $('#feed-container').html(feedContents.responseText);
		    
		    // Fade in
		    $('#feed-container').delay(125).fadeIn(125);
			// Resizing feed element when image loads
			$('.emote-v2-media').each(function(){
				var mediaHeight = $('img', this).outerHeight();
				$(this, '.emote-v2-content').parent().height(mediaHeight);
			});
			
			$('#feed-container').load(function(){
				// Resizing feed element when image loads
				$('.emote-v2-media').each(function(){
					var mediaHeight = $('img', this).outerHeight();
					$(this, '.emote-v2-content').parent().height(mediaHeight);
				});
			});
		
		};
		
		$.fn.prepareEmoteCreate = function () {
			var titlePlaceHolder = "What is that you want to emote about?";
			document.getElementById("emoteSave").reset();	
			//$('#tag').removeTag();
			//$('#tag').reset();
			$('#obj-title').prop('placeholder', titlePlaceHolder);
		
			$('#obj-title').focus(function(){
	    		$(this).prop('placeholder', "");
	    	});
			$('#obj-title').blur(function(){
    		$(this).prop('placeholder', titlePlaceHolder);
			});
			
		
		};
		
		
		
		
})(jQuery);		