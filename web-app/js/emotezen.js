function initImageEventHandlers(){

    // Cancel button handler for picture cropper popup
    $('#picturecropper-cancel-button').click(function(){
        $('#picture_crop_container').toggleClass('active');
        emptyImageFileElement();
        // stop default behaviour of button
        return false;
    });

    // Ok button handler for picture cropper popup
    $('#picturecropper-ok-button').click(function(){
        //$('#picture_crop_container').toggleClass('active');
        var imgObj=$('#upload_preview_img');
        alert("Width="+imgObj.width()+", Height"+imgObj.height()+", Jcrop info x="+jcrop_coordinates.x
            +",y="+jcrop_coordinates.y+",x2="+jcrop_coordinates.x2+",y2="+jcrop_coordinates.y2
            +",w="+jcrop_coordinates.w+",h="+jcrop_coordinates.h);
        $('#picture_crop_container').toggleClass('active');
        // stop default behaviour of button
        $('#imgchooserpopup').toggleClass('active');
        return false;
    });

    $('#addimage-button').click(function(){
        $('#imgchooserpopup').toggleClass('active');
    });


    $('#img_search_button').click(function(){
        $('#img_search_container').toggleClass('active');
        return false;
    });


    $('#imgchooserpopup .done-button').click(function(){
        $('#imgchooserpopup').toggleClass('active');
        return false;
    });

//Back button
    $('#imgchooserpopup .cancel-button').click(function(){
        $('#imgchooserpopup').toggleClass('active');
        return false;
    });

    //Hook up an onclick eventhandler to the Search button.
    $("#img_search_submit_button").click(bing_img_send_request);
}

function emptyImageFileElement(){
    /**In the code below I use the replaceWith jQuery method to replace the control with a clone of itself. In the event you have any handlers bound to events on this control, we'll want to preserve those as well. To do this we pass in true as the first parameter of the clone method. ref http://stackoverflow.com/questions/1043957/clearing-input-type-file-using-jquery*/
    //var fileElement = $("#pic");
    // fileElement.replaceWith( fileElement = fileElement .clone( true ) );
    //fileElement.val(null);
    document.getElementById('pic').value=null;
    document.getElementById('upload_preview_img').src="";
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
        emptyImageFileElement();
        return;
    }

    // check for file size
    if (oFile.size > 10000 * 1024) {
        $('.error').html('Image must be below 10MB').show();
        return;
    }


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

            resizeUploadImgPreview(this.width, this.height);
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

var resizeUploadImgPreview=function(imgWidth, imgHeight){
    // reset the style attributes assigned by JCrop API so that newly/next selected image will get correct one
    $('#upload_preview_img').removeAttr('style');

    var imgContainerRatio= $(window).width()/($(window).height()-IMAGE_CONTAINER_HEIGHT_EXCLUSION);
    var imgRatio= imgWidth/imgHeight;
    if(imgContainerRatio>imgRatio){
        $('#upload_preview_img').css('height',($(window).height()-IMAGE_CONTAINER_HEIGHT_EXCLUSION)+"px");
    }else{
        $('#upload_preview_img').css('width','100%');
    }
};

//Function will be called by Jcrop itself to assign the values to global variable jcrop_coordinates
var updateJcropSelectionInfo=function(c){
    jcrop_coordinates=c;
};

//Function will be called by Jcrop itself to null/empty values to global variable jcrop_coordinates
var clearJcropSelectionInfo=function(){
    jcrop_coordinates=null;
};