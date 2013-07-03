(function($) {
	
	$.fn.refreshFeed = function (feedContents) {
		$().prepareEmoteCreate();
		
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
		var tagPlaceHolder = "A few short words (an emote) to tell us what you thought...";
		
		//try reset whole emoteSave form
		document.getElementById("emoteSave").reset();	
		$('#obj-title').attr('placeholder', titlePlaceHolder);
		
		//clear title placeholder when input in use
		$('#obj-title').focus(function(){
    		$(this).attr('placeholder', "");
    	});
		
		//bring title placeholder back if input not in use 
		$('#obj-title').blur(function(){
			$(this).attr('placeholder', titlePlaceHolder);
		});
		
		//Tag input area not reset by emoteSave reset; so manual code to try reset below
		$('#tag').importTags('');

		$('#tag').attr('placeholder',tagPlaceHolder);
		
		//clear tag placeholder when input in use
		$('#tag').focus(function(){
    		$(this).attr('placeholder', "");
    	});
		
		//bring tag placeholder back if input not in use 
		$('#tag').blur(function(){
			$(this).attr('placeholder', tagPlaceHolder);
		});

	};	
})(jQuery);			