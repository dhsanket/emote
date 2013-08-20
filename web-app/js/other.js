 

//https://gist.github.com/kellishaver/2426977
//http://stackoverflow.com/questions/4459379/preview-an-image-before-it-is-uploaded

function readURL(input) {

    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#file-preview').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
}

$("#pic").change(function(){
    readURL(this);
    $('#photoBar').addClass('active');
});
