$(function(){
	
	$(window).load(function(){
	    
		// Resizing feed element when image loads
		resizeFeedElements();

		// resize images when user resizes browser
		$(window).resize(function(){
			resizeFeedElements();
		});
		
		// Emote rendering
		swipeInit();
		
		// Friend formatting
		friendRender();
		
		// Menu Toggle
		$('#toggleMenu').click(function(){
			navSlider();
		});
		
		loadTags();
		
		// Create emote button toggle
		$('#createEmote').click(function(){
			emoteCreateButton();
		});
		
		// Autocompletion on Emote create
		$('#obj-title').autocomplete({
			appendTo : '#obj-title-suggestion',
			minLength : 3,
			source: '/title/autocomplete',
			messages : {noResults: '',
				 results: function(){}
				}
		});	
		
		// Create emote 'SAVE' button
		$('#submit-button').click(function(){
			emoteCreate();
	 		// prevent default behaviour of button
	 		return false;
	 	});
	 	
	 	// Reformat emotes without Media
	 	emoteNoMediaFormat('#660000');

	});
});

