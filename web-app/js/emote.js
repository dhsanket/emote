var IMAGE_CONTAINER_HEIGHT_EXCLUSION=140; //140 is the size occupied by app header, title of cropping window, bottom buttons
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

	if ($('#signinHeader_emote').length == 0) {

		// Move standard content
		$('#feed-container').toggleClass('navactive');
		$('#user-header').toggleClass('navactive');
		$('header').toggleClass('active');
		$('#photo-feed').toggleClass('navactive');


		// Move in Nav menu
		$('#nav-menu').toggleClass('active');

	}
}

var swipeScreen = 1;
// Emote Slider Functions
function swipeInit() {
	var mySwiper = $('.swiper-container').each(function(){
		var that = this;
		var slider = $(this).swiper({
			// Options
			mode:'horizontal',
			loop: true,
			speed: 300,
			resistance: true,
			createPagination: true,
			pagination: '.slide-indicator',
			paginationAsRange: true,
			onTouchEnd: function(){
				$('.swipe-location li').css('backgroundColor', '#A7A29F');
				swipeScreen = swipeScreen + 1;
				if (swipeScreen > 2) { swipeScreen = 1;}
				$('.screen' + swipeScreen).css('backgroundColor', '#98041A');
			},
			onSlideChangeEnd: function(){
				$(that).find('.swiper-pagination-switch').toggleClass('swiper-visible-switch swiper-active-switch');
			}
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
		$('.current-user', this).text(firstUser);
		var userId = $('.user-thumb:first-child ', this).attr('data-user-id');
		$('a.user-feed', this).attr('href', '/emote/userFeed?userId='+userId)
	});

	$('.friend-container .user-thumb').click(function(){

		// add username
		$('.friend-container .user-thumb').removeClass('active');
		$(this).addClass('active');

		// grab which position in list
		var whichFriend = $(this).index();
		var parentPostID = $(this).attr('data-post-id');
		var friendID = $(this).attr('data-user-id');
//		console.log(parentPostID)
//		console.log(friendID)
		// add User's name to top bar
		var currentUserTextString = $('.emote-user-name', this).html();
		$('.emote-v2[data-post-id="' + parentPostID + '"] .current-user').html(currentUserTextString);
		console.log($('.emote-v2[data-post-id="' + parentPostID + '"] a'))
		$('.emote-v2[data-post-id="' + parentPostID + '"] a.user-feed').attr('href', '/emote/userFeed?userId='+friendID)

		// hide all
		$('.friend-emotes-container[data-post-id="' + parentPostID + '"] li.friend-emotes').hide();
		// show correct friend emotes

		$('.friend-emotes-container[data-post-id="' + parentPostID + '"] li.friend-emotes[data-user-id="'+friendID+'"]').show();
	});
}

// Feed rendering with no photo
function preserveSizeWithoutMedia() {

}

// Emote Creation Functions

function emoteCreateButton(doNotResetForm) {

	if ($("#emote-creation-container").hasClass("edit-emote")){
		$('.quick-create-overlay').addClass('active');
		$("#emote-creation-container").removeClass("edit-emote");
		$('#emote-creation-container').css("top", "0px");
		$('#emote-creation-container').css("left", "0px");
		$('#emote-creation-container').css("width", "100%");
		$('#category').val("");
		$('#pick-a-category span').text("-- Pick a category --");
	}

		if($('#emote-creation-container').hasClass('active')) {
			$(".quick-create-overlay").removeClass('active');
			$('#emote-creation-container').removeClass('active');
			$('#feed-container').removeClass('emoteCreateActive');
			$('#createEmote').removeClass('active');
			$('#user-header').toggleClass('create-emote');
			$('#photo-feed').toggleClass('create-emote');
			if(doNotResetForm){
				// don't do any reset business
			}else{
				emoteCreateReset();
			}
            //ZEN to hide the image cropper popup if visible
            if($('#picture_crop_container').hasClass('active')) {
                $('#picturecropper-cancel-button').click();
                //$('#picture_crop_container').toggleClass('active');
            }
            //ZEN to hide the image chooser popup
            if($('#imgchooserpopup').hasClass('active')) {
                $('#imgchooserpopup .cancel-button').click();
            }
            //ZEN to hide the image chooser popup
            if($('#img_search_container').hasClass('active')) {
                $('#img_search_container').toggleClass('active');
            }
            $("#loadingOverlay").hide();

        }
		else {
			$("#loadingOverlay").width($(window).width());
			$("#loadingOverlay").height($(window).height());
			$("#loadingOverlay").css("zIndex",10);
			$("#loadingOverlay").show();
			$(".quick-create-overlay").addClass('active');

			$('#feed-container').addClass('emoteCreateActive');
				$('#emote-creation-container').addClass('active');
				//$('#createEmote').addClass('active');
				$('#user-header').toggleClass('create-emote');
				$('#photo-feed').toggleClass('create-emote');

				//-- every time when create popup opens we are reseting the picture related components
				//this code to reset both jcrop and file element
				emptyImageFileElement();
				//remove the preview panel
				destroyImgPreview();
				//--

				// Scroll to top functionality
				scrollToTop(800);

		}

}

//automatically adds title to the createEmote form
function quick_emote(title,category,id){
	$("#obj-title-location").hide();
	$("#loadingOverlay").width($(window).width());
	$("#loadingOverlay").height($(window).height());
	$("#loadingOverlay").css("zIndex",10);
	$("#loadingOverlay").show();

		$('#obj-title').val(title);
		$('.edit-emote-header h3').text(title);
		$('.edit-emote-header p').text(category);
		$('#category').val(category);
		$('#pick-a-category span').text(category);
		//alert($(document).scrollTop());
		var posTop = ($(document).scrollTop() == 0 ? $("#"+id).position().top : ($("#"+id).position().top - $(document).scrollTop()));

		//alert($(document).scrollTop() + "\n" + $("#"+id).position().top);
		$('#emote-creation-container').css("top", posTop);
		$('#emote-creation-container').css("left", $("#"+id).position().left);
		var contWidth = $("#"+id).width();
		$('#emote-creation-container').css("width", contWidth + 2);
		$('#emote-creation-container').addClass("edit-emote");
		$('#emote-creation-container').addClass('active');
		//$('#createEmote').addClass('active');
		$('#user-header').toggleClass('create-emote');
		$('#photo-feed').toggleClass('create-emote');
		//emoteCreateButton(true);
}

// user can easily click another users emote and submit as his own
function re_emote(title, tag){
	$('#obj-title').val(title);
	$('#tag').val(tag);
	emoteSubmit();
}

function emoteCreate() {
	//Submit-button click event has occured
	var invalidFieldArr = new Array();
	var isValid = true;
	if ($('#tag').val().length <1 ){
		$("#tag_tagsinput").css({'border': '2px solid red'});
		invalidFieldArr.push("#tag_tagsinput");
	}else{
		$("#tag_tagsinput").css({'border': ''});
	}

	if ( $('#obj-title').val().length< 1 ){
		$("#obj-title").css({'border': '2px solid red'});
		invalidFieldArr.push("#obj-title");
	}else{
		$("#obj-title").css({'border': ''});
	}

	//check if category is selected
    var selectBox = document.getElementById('category').value;
    var a = (selectBox == "" ? 0 : 1);
	if (a == 0){
		$("#pick-a-category").css({'border': '2px solid red'});
		invalidFieldArr.push("#pick-a-category");
	}
	else
	{
		//if user selects a category; remove red category border (if he made mistake in first attempt
		$("#pick-a-category").css({'border': '1px solid #ccc'});
	}

	if(invalidFieldArr.length > 0 ){
		return false;
	}

	emoteCreateButton(true);
	emoteSubmit();
}

//ajax submit createEmote form action
function emoteSubmit() {


//	displayLoadingOverlay();
	// Test values came through correctly (disable comments on lines below to test fields are outputting properly, into console.)
	// console.log(data.tags);
	// console.log(data.emoteTitle);
	var form = $('#emoteSave')
	var formData = new FormData(form[0]);
	//console.log(formData)
	// Perform the request

	var feedContents = $.ajax({

		type: 'POST',
		url: '/emote/save',
        cache: false,
        contentType: false,
        processData : false,
		data: formData,
		error: function(){
			// Error function goes here
			console.log("Error, your request was not sent");
		},
	}).done(function(){
		// Reset the form
		emoteCreateReset();
		// Reload
		location.reload();
	});
}

function displayLoadingOverlay()
{

	$("#loadingOverlay").css("zIndex",1000);

	$("#loadingOverlay").width($(window).width());
	$("#loadingOverlay").height($(window).height());
	$("#overlayMessage").css("top",($(window).height()/2)-($("#overlayMessage").height()/2)-50)
	$("#overlayMessage").css("left",($(window).width()/2)-($("#overlayMessage").width()/2))
	$("#loadingOverlay").show();
	$("#overlayMessage").show();
}

var favouriteSubmit = function (id, title) {
    var feedContents = $.ajax({
        type: 'POST',
        url: 'userAction/addFavouriteTitle',
        cache: false,
        data: {title: title},
        error: function () {
            console.log("Error, The request was not sent");
        },
        success: function(){
            //todo maybe Icon should change and be disabled
        }

    });

};

var removeFromFavourite = function (id, title) {
    var feedContents = $.ajax({
        type: 'POST',
        url: 'userAction/removeFavouriteTitle',
        cache: false,
        data: {title: title},
        error: function () {
            console.log("Error, The request was not sent");
        },
        success: function(){
            //todo maybe Icon should change and be disabled
        }

    });

};

var doingNow = function (id, title) {
    var feedContents = $.ajax({
        type: 'POST',
        url: 'userAction/addDoing',
        cache: false,
        data: {title: title},
        error: function () {
            console.log("Error, The request was not sent");
        },
        success: function(){
            //todo maybe Icon should change and be disabled
        }

    });

};
//prepare title placeholder for auto-display; resets tag field
function emoteCreateReset() {
	$('#obj-title').val('');
	$('#tag').importTags('');

	//unique easy to find location for title placeholder
	var titlePlaceHolder = "title (what you want to emote about) goes here...";


    $('#obj-title').attr('placeholder', titlePlaceHolder);


	//clear title placeholder when input in use
    $('#obj-title').focus(function(){
        $(this).attr('placeholder', "");
      });

    //bring title placeholder back if input not in use
    $('#obj-title').blur(function(){
      $(this).attr('placeholder', titlePlaceHolder);
    });

    // select none in category
   // console.log()
	$("#category").prop("selectedIndex", 0);
	$("#category").css({'border': '1px solid #ccc'});


}

// Load tags
function loadTags() {

	//unique easy to find location for tag placeholder
	var tagPlaceHolder = "your micro-reviews (emotes) go here...";

	//init tag field
	$('#tag').tagsInput({
		'width' : 'auto',
		'height': 'auto',
		'defaultText': tagPlaceHolder,
		'placeholderColor' : '#999999',
		'maxChars' : 50,
		'unique': false
	});


}
//Geolocation stuff
function getLocation() {
	if (navigator.geolocation)
	{
		navigator.geolocation.getCurrentPosition(showPosition);
	}
}

function showPosition(position) {
	var latitude = position.coords.latitude;
	var longitude = position.coords.longitude;

	console.log("Latitude: " + latitude);
	console.log("Longitude: " + longitude);
}
//ajax submit follow user action
function followUser(userId) {
	console.log(userId);
	$.ajax({
		type: 'POST',
		url: '/user/follow',
		data: {friendId:userId},
		error: function(){
			// Error function goes here
			console.log("Error, your request was not sent");
			$('#'+userId).css({'font':'red'});
		},
	}).done(function(){
		// disalbe button
		$('#'+userId).css({'font':'green'});
	});
}

function validationMarkers(){
	$( "input[type='text']" ).keyup(function() {
		// Check input( $( this ).val() ) for validity here
		if($( this ).val().length==0 ){
			$(this).css({'border': '2px solid red'});
		}else{
			$(this).css({'border': ''});
		}
	});
}

var canvas = document.getElementById("spotlight_canvas");
var ctx = canvas.getContext("2d");
ctx.canvas.width  = window.innerWidth;
ctx.canvas.height = window.innerHeight;

function createCanvasOverlay() {
    ctx.globalCompositeOperation = "source-over";
    ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
    ctx.fillStyle = "rgba(0,0,0,0.8)";
    ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
}

$('.divShowClick').each(function(){
	if($(this).hasClass('active')) {
		canvas.width = canvas.width;
		createCanvasOverlay();
	}
});
function resizeStuff() {
    canvas.width = canvas.width;
    ctx.canvas.width  = window.innerWidth;
    ctx.canvas.height = window.innerHeight;
    createCanvasOverlay();
    if($('#slide-2').hasClass("active")) {
		var createEmoteX = $('#createEmote').offset().left-2;
		var createEmoteY = $('#createEmote').offset().top-2;
		var tag_tagsinputX = $('#obj-title').offset().left;
		var tag_tagsinputY = $('#obj-title').offset().top+45;
		var tag_tagsinputWidth = $('#obj-title').width()+52;
		var shareLinkX = $('#feeds-share-icon-link').offset().left-3;
		var shareLinkY = $('#feeds-share-icon-link').offset().top-2;
		createSpotlight(createEmoteX, createEmoteY, 40, 40);
		createSpotlight(tag_tagsinputX, tag_tagsinputY, tag_tagsinputWidth, 40);
		createSpotlight(shareLinkX, shareLinkY, 36, 40);
    }
    if($('#slide-3').hasClass("active")) {
		var smallUserimageX = $('.friend-container .user-thumb').offset().left-2;
		var smallUserimageY = $('.friend-container .user-thumb').offset().top-2;
		var friendEmoteX = $('#feed-container [data-post-id=0] .swiper-slide-visible .friend-emotes-container').offset().left-5;
		var friendEmoteY = $('#feed-container [data-post-id=0] .swiper-slide-visible .friend-emotes-container').offset().top-5;
		var friendEmoteWidth = $('#feed-container [data-post-id=0] .swiper-slide-visible .friend-emotes-container').width();
		var emoteSliderX = $('#feed-container [data-post-id=1] .swiper-slide-visible').offset().left;
		var emoteSliderY = $('#feed-container [data-post-id=1] .swiper-slide-visible').offset().top;
		var emoteSliderWidth = $('#feed-container [data-post-id=1] .swiper-slide-visible').width();
		var emoteSliderHeight = $('#feed-container [data-post-id=1] .swiper-slide-visible').height();
		createSpotlight(smallUserimageX, smallUserimageY, 38, 38);
		createSpotlight(friendEmoteX, friendEmoteY, friendEmoteWidth, 30);
		createSpotlight(emoteSliderX, emoteSliderY, emoteSliderWidth, emoteSliderHeight);
    }
    if($('#slide-4').hasClass("active")) {
		var doingNowX = $('#doing-now').offset().left-2;
		var doingNowY = $('#doing-now').offset().top-2;
		var doingNowWidthY = $('#doing-now').width()+40;
		createSpotlight(doingNowX, doingNowY, doingNowWidthY, 40);
    }
    if($('#slide-5').hasClass("active")) {
		var toggleMenuX = $('#toggleMenu').offset().left-2;
		var toggleMenuY = $('#toggleMenu').offset().top-2;
		var smallUserimageX = $('.friend-container .user-thumb').offset().left-2;
		var smallUserimageY = $('.friend-container .user-thumb').offset().top-2;
		var emoteActionsX = $('#feed-container [data-post-id=0] .emote-v2-footer').offset().left-2;
		var emoteActionsY = $('#feed-container [data-post-id=0] .emote-v2-footer').offset().top-5;
		var emoteActionsWidthY = $('#feed-container [data-post-id=0] .emote-v2-footer').width()+4;
		var emoteActionsHeightY = $('#feed-container [data-post-id=0] .emote-v2-footer').height()+10;
		createSpotlight(smallUserimageX, smallUserimageY, 38, 38);
		createSpotlight(toggleMenuX, toggleMenuY, 40, 40);
		createSpotlight(emoteActionsX, emoteActionsY, emoteActionsWidthY, emoteActionsHeightY);
    }
}

var timeout = false;
$(window).resize(function(){
    if(timeout !== false){
        clearTimeout(timeout);
    }
    timeout = setTimeout(resizeStuff, 200); //200 is time in miliseconds
});

function createSpotlight(x,y,w,h) {
    ctx.fillStyle = "rgba(255,255,255,.8)";
    ctx.globalCompositeOperation = "destination-out";
    ctx.shadowColor = '#ffffff';
    ctx.shadowBlur = 10;
    ctx.shadowOffsetX = 0;
    ctx.shadowOffsetY = 0;
    ctx.beginPath();
    ctx.rect(x,y,w,h);
    ctx.fill();
}
$('.divShowClick').click(function(e){
    e.preventDefault();
    if($(this).attr('id') == 'slide-2-click' || $(this).attr('id') == 'slide-4-click' ) {
        if($('#emote-creation-container').attr('class') != 'active'){
            $('#createEmote').trigger('click');
        }
    }
    if($(this).attr('id') == 'slide-1-click' || $(this).attr('id') == 'slide-3-click' || $(this).attr('id') == 'slide-5-click' ) {
         if($('#emote-creation-container').attr('class') == 'active'){
            $('#createEmote').trigger('click');
        }
    }
    var divId = $(this).attr('data-div-id');
    $('.divShowClick.active').removeClass('active');
    $(this).addClass('active');
    $('.slide-tut.active').removeClass('active');
    $('#'+divId).addClass('active');
    resizeStuff();
});
