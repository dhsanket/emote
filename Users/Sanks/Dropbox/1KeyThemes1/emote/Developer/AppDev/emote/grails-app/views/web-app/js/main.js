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
		$('#tag').tagsInput({
			'width' : 'auto',
			'height': 'auto',
			'defaultText':'Put your emotes \\o/ here'
		});
		
		$('#obj-title').typeahead({
			source: [
			'Iron Man 3',
			'Venice Beach',
			'Camden Town, London',
			'Milton Keynes'
			]
		});
		
		// Create emote
		$('#createEmote').click(function(){
            toggleCommentDialog();
            toggleCommentDialog();
			$('#feed-container').toggleClass('active');
			$('#emote-creation-container').toggleClass('active');
			$('#createEmote').toggleClass('active');
			$('#user-header').toggleClass('create-emote');
			$('#photo-feed').toggleClass('create-emote');
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
				autoPlay: 3000,
				speed: 300,
				resistance: true,
			});
		});
		
		
		
	});
});