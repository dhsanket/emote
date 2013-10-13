$(function(){
	
	$(window).load(function(){
	    
		
		$('#pick-a-category').click(function(){
			if ($(this).hasClass("button-on"))
			{
				$(this).addClass("button-off");
				$(this).removeClass("button-on");
				$('#category-list').hide();				
			}else{
				$(this).addClass("button-on");
				$(this).removeClass("button-off");
				$('#category-list').show();				
			}

		});
		
		$('#share-emote').click(function(){
			if ($(this).hasClass("button-on"))
			{
				$(this).addClass("button-off");
				$(this).removeClass("button-on");
			}else{
				$(this).addClass("button-on");
				$(this).removeClass("button-off");
			}

		});		
		
		
		
		$('#doing-now').click(function(){
			if ($(this).hasClass("button-on"))
			{
				$('#doing-now').addClass("button-off");
				$('#doing-now span').addClass("doing-now-off");
				$('#doing-now').removeClass("button-on");
				$('#doing-now span').removeClass("doing-now-on");
				$("#doing-now-input").attr("value","false");
				
			}else{
				$('#doing-now').addClass("button-on");
				$('#doing-now span').addClass("doing-now-on");
				$('#doing-now').removeClass("button-off");
				$('#doing-now span').removeClass("doing-now-off");
				$("#doing-now-input").attr("value","true");
			}
		});
		
		$('#category-list li').click(function(){
			if ($(this).text().indexOf("Pick") > -1)
			{
				$("#category").attr("value", "");
			}else{
				$("#category").attr("value", $(this).text());
			}
			$('#pick-a-category span').text($(this).text());
			$('#pick-a-category').addClass("button-off");
			$('#pick-a-category').removeClass("button-on");
			$('#category-list').hide();
		});
		
		validationMarkers();
		// Geolocation
	    $('#geoLocation').click(function(){
	    	getLocation();
	    });
		
		
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

        initImageEventHandlers();

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
		$('#post-emote').click(function(){
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

