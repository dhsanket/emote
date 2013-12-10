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
		$(this).swiper({
			// Options
			mode:'horizontal',
			loop: true,
			speed: 300,
			resistance: true,
			onTouchEnd: function(){
				$(".swipe-location li").css("backgroundColor", "#A7A29F");
				swipeScreen = swipeScreen + 1;
				if (swipeScreen > 2) { swipeScreen = 1;}
				$(".screen" + swipeScreen).css("backgroundColor", "#98041A");
				
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
		$("#emote-creation-container").removeClass("edit-emote");
		$('#emote-creation-container').css("top", "0px");
		$('#emote-creation-container').css("left", "0px");
		$('#emote-creation-container').css("width", "100%");
		$('#category').val("");
		$('#pick-a-category span').text("-- Pick a category --");
	}
	
		if($('#emote-creation-container').hasClass('active')) {
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
