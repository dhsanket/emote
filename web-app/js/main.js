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
		
		//prepare title placeholder for auto-display
		emoteCreateReset();
		
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
	 	
	 	//If user-header active Push FeedContainer further down
	 	if($('#user-header').hasClass('userActive')){
	 		$('#feed-container').addClass('userActive');
	 	}
	 	
	 	//If user not signed into facebook, show signin header
	 	if ($('#signinHeader').hasClass('ignored')){
			 $('#signinHeader').removeClass('active');
 		  }
	 	else { 
	 		FB.getLoginStatus(function(response) {
	 		  if (response.status === 'connected') {
		 		    // the user is logged in and has authenticated your
		 		    // app, and response.authResponse supplies
		 		    // the user's ID, a valid access token, a signed
		 		    // request, and the time the access token 
		 		    // and signed request each expire
		 		    var uid = response.authResponse.userID;
		 		    var accessToken = response.authResponse.accessToken;
		 		   $('#signinHeader').removeClass('active');
		 		  } else if (response.status === 'not_authorized') {
		 		    // the user is logged in to Facebook, 
		 		    // but has not authenticated your app
			 			 $('#signinHeader').removeClass('active');
		 		  } else {
		 		    // the user isn't logged in to Facebook.
		 			 $('#signinHeader').addClass('active');
		 		  }
		 		 });
	 	}
	 		
	 	if($('#signinHeader').hasClass('active')){
	 		$('#feed-container').addClass('userActive');
	 	}
	 	
	 	FB.Event.subscribe('auth.authResponseChange', function(response) {
	 		  if (response.status === 'connected') {
		 		   $('#signinHeader').removeClass('active');
	 		    window.top.location = '#';
	 		  }
	 		});

	});
});

