$(function(){
	
	$('.emote.map').each(function(){
		
		var lt = $(this).attr('data-lat');
		var lo = $(this).attr('data-long');
		
		// init mapfeed function
		$(this).css({
		'background-image': 'url(http://maps.googleapis.com/maps/api/staticmap?center='+lt+','+lo+'&zoom=14&size=800x800&sensor=false)'
		});
	});
	
	$(window).load(function(){
		
		$().prepareEmoteCreate();
	    
		$('#tag').tagsInput({
			'width' : 'auto',
			'height': 'auto',
			'defaultText':'A few short words (an emote) to tell us what you thought...',
			'placeholderColor' : '#999999'	
		});
		
		$('#obj-title').autocomplete({
			appendTo : '#obj-title-suggestion',
			minLength : 3,
			source: '/title/autocomplete',
			messages : {noResults: '',
				 results: function(){}
				}
		});		
		
		
		// Create emote
		$('#createEmote').click(function(){
			$('#feed-container').toggleClass('active');
			$('#emote-creation-container').toggleClass('active');
			$('#createEmote').toggleClass('active');
			$('#user-header').toggleClass('create-emote');
			$('#photo-feed').toggleClass('create-emote');
		});
		
		// Resizing feed element when image loads
		$('.emote-v2-media').each(function(){
			var mediaHeight = $('img', this).outerHeight();
			$(this, '.emote-v2-content').parent().height(mediaHeight);
		});
		
		// Menu Toggle
		$('#toggleMenu').click(function(){
			
			// Move standard content
			$('#feed-container').toggleClass('navactive');
			$('#user-header').toggleClass('navactive');
			$('header').toggleClass('active'); 
			$('#photo-feed').toggleClass('navactive');
			
			// Hide Emote Creation if active
			if($('#emote-creation-container').hasClass('active')) {
				$('#emote-creation-container').removeClass('active');
				$('#feed-container').removeClass('active');
				$('#createEmote').removeClass('active');
				$('#user-header').toggleClass('create-emote');
				$('#photo-feed').toggleClass('create-emote');
			}
			
			// Move in Nav menu
			$('#nav-menu').toggleClass('active');
		});
		
		// Sharing Tags (uses jQuery Mobile taphold event)
		$('.emote').taphold(function(){
			$(this).toggleClass('active');
		});
		
		// jQuery Masonry
		$('#photo-feed').masonry({
			itemSelector : '.photo-feed-photo',
			isResizable : true,
			containerStyle: {
				position: 'absolute',
				top : '60px'
			}
		});
		
			/* Profile Switching Buttons */
			$('#profile-emotes').click(function(){
				$('#photo-feed').removeClass('active');
				$('#feed-container').fadeIn(125);
			});
			
			$('#profile-images').click(function(){
				$('#photo-feed').addClass('active');
				$('#feed-container').fadeOut(250);
			});
			
		// Emote rendering
		var mySwiper = $('.swiper-container').each(function(){
			$(this).swiper({
				//Your options here:
				mode:'horizontal',
				loop: true,
				speed: 300,
				resistance: true,
			});
		});
		
		// Friend emote sets
		// automagically hide all friend emotes
		$('.friend-emotes-container li.friend-emotes').hide();
		// display only first set of friend emotes
		$('.friend-emotes-container li.friend-emotes:first-child').show();
		$('.friend-container .user-thumb:first-child').addClass('active');
		
		
			$('.emote-friends').each(function(){
				var firstUser = $('.user-thumb:first-child .emote-user-name', this).html();
				$('.current-user', this).text(firstUser);
			});
		
		
		
		// set up click event-handler for each user
		$('.friend-container .user-thumb').click(function(){
			
			// add username
			$('.friend-container .user-thumb').removeClass('active');
			$(this).addClass('active');
			
				// grab which position in list
			var whichFriend = $(this).index();
			var parentPostID = $(this).attr('data-post-id');
			
			
			// add User's name to top bar
			var currentUserTextString = $('.emote-user-name', this).html();
			$('.emote-v2[data-post-id="' + parentPostID + '"] .current-user').text(currentUserTextString);
			
			
		
			// hide all
			$('.friend-emotes-container[data-post-id="' + parentPostID + '"] li.friend-emotes').hide();
			// show correct friend emotes
			$('.friend-emotes-container[data-post-id="' + parentPostID + '"] li.friend-emotes:eq('+ whichFriend +')').show();
			
		});
		
		// resize images when user resizes browser
		$(window).resize(function(){
			$('.emote-v2-media').each(function(){
			var mediaHeight = $('img', this).outerHeight();
			$(this, '.emote-v2-content').parent().height(mediaHeight);
			});
		});
		
		
	});
});


$(function(){

	 // Listen for submit event on form
	 $('#submit-button').click(function(){

	  // grab values of form
	  var tags = $('#tag').val();
	  var emoteTitle = $('#obj-title').val();

	  // create an object
	  var data = {};

	  data.tags = tags;
	  data.emoteTitle = emoteTitle;

	  // check to see if object is outputting correctly and data is captured
	  // console.log(data['emoteTitle']);
	  // console.log(data['tags']);

	  // perform the request
	  var feedContents = $.ajax({
	   type: 'POST',
	   url: '/emote/emote/save',
	   data: {
		     title: data.emoteTitle,
		     expression: data.tags
		    },
	   success: function(){
	   },
	   error: function(){
	   }
	  }).done(function(){
		  $('#createEmote').click(); 
		  $().refreshFeed(feedContents);

	  });;

	  // Stop default behaviour of the button
	  return false;
	 });

	});

