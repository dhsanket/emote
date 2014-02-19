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

		$('#feeds-share-icon-link').click(function(){
			if ($(this).hasClass("button-on"))
			{
				$(this).addClass("button-off");
				$(this).removeClass("button-on");
				$("#share-input").attr("value","false");
			}else{
				$(this).addClass("button-on");
				$(this).removeClass("button-off");
				$("#share-input").attr("value","true");
			}
		});

		$('.feeds-fav-icon.logged').click(function(){
            var title = $(this).attr('data-emote-title');

			if($(this).hasClass('active')) {
                removeFromFavourite(title)
            } else {
                favouriteSubmit(title);
            }
			$(this).toggleClass('active');

		});

		$('.feeds-knob-icon.logged').click(function(){
			$(this).toggleClass('active');
            doingNow($(this).attr('data-emote-title'));
		});

		$('.feeds-list-icon').click(function(){
			$(this).toggleClass('active');
		});

		$('.feeds-camera-icon.logged').click(function(){
            var title = $(this).attr('data-emote-title');
            $('input[name=title]').val(title);
			$('#imgchooserpopup').toggleClass('active');
		});

        $('.feeds-report-icon.logged').click(function(){
            var title = $(this).attr('data-emote-title');
            flag_emote(title);
		});

        $('.feeds-share-icon.logged').click(function(){
            postToFacebook($(this));
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

        $("#in-input-field").click(function(){
			$("#obj-title-location").show();
        });

        $(".editEmoteLink").click(function(event){
			event.preventDefault();
        });

		// Create emote button toggle
		$('#createEmote').click(function(){
            hideCommentDialog();
			emoteCreateButton();
		});

		// feed page search header-icon action
		$('#searchIcon').click(function(){
			navSlider();
			$('#searchField').focus();
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
		$('#post-emote').click(function(e){
			// prevent default behaviour of button
			e.preventDefault();
			emoteCreate();
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
		} else {
			FB.getLoginStatus(function(response) {
				if (response.status === 'connected') {
					// the user is logged in and has authenticated your
					// app, and response.authResponse supplies
					// the user's ID, a valid access token, a signed
					// request, and the time the access token
					// and signed request each expire
					var uid = response.authResponse.userID,
						accessToken = response.authResponse.accessToken;
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

$( ".comment-toolbar li" ).hover(
  function() {
    $( this ).addClass( "silver-gradient-reverse" );
  }, function() {
    $( this ).removeClass( "silver-gradient-reverse" );
  }
);

$('#createEmote').click(function(){
	var windowheight = $('#feed-container').height();
	//var quickoverlayheight = $('.quick-create-overlay').height();
	var quickoverlayheight = $('.quick-create-overlay').height();
	//alert(windowheight);
	//alert(quickoverlayheight);
	if (quickoverlayheight < windowheight) {
		//quickoverlayheight = windowheight;
		//alert('hii');
		$('.quick-create-overlay').css('height',windowheight);
	}
});


