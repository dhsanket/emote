function mapFunction() {
	var lt = $(this).attr('data-lat');
	var lg = $(this).attr('data-long');
	
	// Insert image
	$(this).css({
		'background-image' : 'url(http://maps.googleapis.com/maps/api/staticmap?center='+lt+','+lo+'&zoom=14&size=800x800&sensor=false)'
	});
}

function scrollToTop(speed) {
	$('body,html').animate({
		scrollTop: 0
	},speed);
}

function resizeFeedElements() {
	$('.emote-v2-media').each(function(){
		var mediaHeight = $('img', this).outerHeight();
		$(this, '.emote-v2-content').parent().height(mediaHeight);
	});
}

// Reformat emotes without media
function emoteNoMediaFormat(color) {
	$('.emote-v2-body').each(function(){
		var height = $(this).height();
		if (height < 250) {
			$(this).css({'background-color' : color});
		}
	});
}

// Menu Function
function navSlider() {
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
}

// Emote Slider Functions
function swipeInit() {
	var mySwiper = $('.swiper-container').each(function(){
		$(this).swiper({
			// Options
			mode:'horizontal',
			loop: true,
			speed: 300,
			resistance: true
		});
	});
}

function friendRender() {
	// Hide them all
	$('.friend-emotes-container li.friend-emotes').hide();
	// Display first set
	$('.friend-emotes-container li.friend-emotes:first-child').show();
	// Highlight first user thumbnail
	$('.friend-container .user-thumb:first-child').addClass('active');
	
	// Display text name in 'Friend's emotes: ' field
	$('.emote-friends').each(function(){
		var firstUser = $('.user-thumb:first-child .emote-user-name', this).html();
		$('.currentUser', this).text(firstUser);
		
	});
	
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
}

// Feed rendering with no photo
function preserveSizeWithoutMedia() {
	
}

// Emote Creation Functions

function emoteCreateButton() {
	$('#feed-container').toggleClass('active');
	$('#emote-creation-container').toggleClass('active');
	$('#createEmote').toggleClass('active');
	$('#user-header').toggleClass('create-emote');
	$('#photo-feed').toggleClass('create-emote');
			
	// Scroll to top functionality
	scrollToTop(800);
}

function emoteCreate() {
	
	// Grab the values of the form
	var tags = $('#tag').val();
	var emoteTitle = $('#obj-title').val();
	
	// Create an Object and store these values
	var data = {};
	
	data.tags = tags;
	data.emoteTitle = emoteTitle;
	
	// Test values came through correctly (disable comments on lines below to test fields are outputting properly, into console.)
	// console.log(data.tags);
	// console.log(data.emoteTitle);
	
	// Perform the request
	var feedContents = $.ajax({
		type: 'POST',
		url: '/emote/save',
		data: {
			title: data.emoteTitle,
			expression: data.tags
		},
		error: function(){
			// Error function goes here
			console.log("Error, your request was not sent");
		},
	}).done(function(){
		// Reset the form
		emoteCreateReset();
		
		// Reload
		// location.reload();
	});
}

function emoteCreateReset() {
	$('#obj-title').val('');
	$('#tag').importTags('');
}

// Load tags
function loadTags() {
	$('#tag').tagsInput({
		'width' : 'auto',
		'height': 'auto',
		'defaultText':'A few short words (an emote) to tell us what you thought...',
		'placeholderColor' : '#999999',
		'maxChars' : 50
	});
}
