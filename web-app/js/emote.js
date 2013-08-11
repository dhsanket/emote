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
		$('.current-user', this).text(firstUser);
		var userId = $('.user-thumb:first-child ', this).attr('data-user-id');
		$('a', this).attr('href', '/emote/userFeed?userId='+userId)
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
		$('.emote-v2[data-post-id="' + parentPostID + '"] a').attr('href', '/emote/userFeed?userId='+friendID)
		
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

function emoteCreateButton() {
		if($('#emote-creation-container').hasClass('active')) {
			$('#emote-creation-container').removeClass('active');
			$('#feed-container').removeClass('active');
			$('#createEmote').removeClass('active');
			$('#user-header').toggleClass('create-emote');
			$('#photo-feed').toggleClass('create-emote');

            //ZEN to hide the image cropper popup if visible
            if($('#picture_crop_container').hasClass('active')) {
                $('#picture_crop_container').toggleClass('active');
            }
        }
		else {		
				$('#feed-container').addClass('active');
				$('#emote-creation-container').addClass('active');
				$('#createEmote').addClass('active');
				$('#user-header').toggleClass('create-emote');
				$('#photo-feed').toggleClass('create-emote');

				// Scroll to top functionality
				scrollToTop(800);
		}		
	
}

//automatically adds title to the createEmote form
function quick_emote(title){
		
		$('#obj-title').val(title);
		emoteCreateButton();
}

// user can easily click another users emote and submit as his own 
function re_emote(title, tag){
/*	   $('#obj-title').val(title);
	   $('#tag').val(tag);
	   $('#submit-button').click();*/
	
	emoteSubmit(title, tag);
}

function emoteCreate() {
	//Submit-button click event has occured
	
	//check if category is selected
    var selectBox = document.getElementById('category');
    var a = selectBox.selectedIndex;
	if (a == 0){	
		$("#category").css({'border': '2px solid red'});
	}
	else
	{
	//if user selects a category; remove red category border (if he made mistake in first attempt
	$("#category").css({'border': '1px solid #ccc'});
	// Grab the values of the form
	var tags = $('#tag').val();
	var title = $('#obj-title').val();
	var e = document.getElementById("category");
	var category = e.options[e.selectedIndex].value;
	//close the createEmote form 
	emoteCreateButton();
	emoteSubmit();
	}
}

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
		'maxChars' : 50
	});
}

//ajax submit createEmote form action
function emoteSubmit() {

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
        }
    }).done(function(){
            // Reset the form
            emoteCreateReset();
            // Reload
            location.reload();
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

// convert bytes into friendly format
function bytesToSize(bytes) {
    var sizes = ['Bytes', 'KB', 'MB'];
    if (bytes == 0) return 'n/a';
    var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
    return (bytes / Math.pow(1024, i)).toFixed(1) + ' ' + sizes[i];
};

function closePictureCropPopup(){
    $('#picture_crop_container').toggleClass('active');
}

//this variable must be declared in global scope  so that everytime before creating new one we can destroy the existing one
var jcrop_api;
var jcrop_coordinates=null; // variable is used store the coordinates for the selection;

function fileSelectHandler() {
    // get selected file
    var oFile = $('#pic')[0].files[0];

    // hide all errors
    $('.error').hide();

    // check for image type (jpg and png are allowed)
    var rFilter = /^(image\/jpeg|image\/png)$/i;
    if (! rFilter.test(oFile.type)) {
        $('.error').html('Please select a valid image file (jpg and png are allowed)').show();
        return;
    }

    // check for file size
    if (oFile.size > 2500 * 1024) {
        $('.error').html('You have selected too big file, please select a one smaller image file').show();
        return;
    }

    // reset the style attributes assigned by JCrop API so that newly/next selected image will get correct one
    /*$('#upload_preview_img').removeAttr('style');
    $('#upload_preview_img').css('height','330px');*/

    // preview element
    var oImage = document.getElementById('upload_preview_img');

    // prepare HTML5 FileReader
    var oReader = new FileReader();
    oReader.onload = function(e) {

        // e.target.result contains the DataURL which we can use as a source of the image

        //oImage.src ="http://stutzen.co/emb.png";
            oImage.src = e.target.result;

        oImage.onload = function () { // onload event handler

            // display step 2
            //$('#picture_crop_container').fadeIn(500);
            $('#picture_crop_container').toggleClass('active');

            $('#upload_preview_img').removeAttr('style');
            if(this.height>this.width){
                $('#upload_preview_img').css('height',($(window).height()-140)+"px"); //140 is the size occupied by app header, title of cropping window, bottom buttons
            }else{
                $('#upload_preview_img').css('width','100%');
            }
            // Create variables (in this scope) to hold the Jcrop API and image size
            var  boundx, boundy;

            // destroy Jcrop if it is existed
            if (typeof jcrop_api != 'undefined')
                jcrop_api.destroy();

            // initialize Jcrop
            $('#upload_preview_img').Jcrop({
                minSize: [32, 32], // min crop size
                aspectRatio : 1.5, // keep aspect ratio 1:1
                bgFade: true, // use fade effect
                bgOpacity: .3, // fade opacity
                onChange: updateJcropSelectionInfo,
                onSelect: updateJcropSelectionInfo,
                onRelease: clearJcropSelectionInfo
            }, function(){

                // use the Jcrop API to get the real image size
                var bounds = this.getBounds();
                boundx = bounds[0];
                boundy = bounds[1];

                // Store the Jcrop API in the jcrop_api variable
                jcrop_api = this;
            });

        };
    };

    // read selected file as DataURL
    oReader.readAsDataURL(oFile);
}
var updateJcropSelectionInfo=function(c){
    jcrop_coordinates=c;
};

var clearJcropSelectionInfo=function(){
    jcrop_coordinates=null;
};