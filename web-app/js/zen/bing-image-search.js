var bing_img_accountKey = "yKMkJwJ88+Yv7HAtUH1HyNYIZOQKrwu7i5aClgRNH8w";
var bing_img_accountKeyEncoded = base64_encode(":" + bing_img_accountKey);

jQuery.support.cors = true;
/*
$(document).ready(function(){
//    $("#popupcontent").css('height', ($(window).height()-45)+"px");
    $("#preview_ok_btn").click(storeImage);
    $("#reject").click(function(){
        $( "#popup" ).dialog( "close" );
    });
});*/
/*var storeImage= function(){
    alert($( "#popupimg" ).attr('src'));
    var url=$( "#popupimg" ).attr('src');
    var requestStr = "http://www.stutzen.me/addPhoto?title=emotedemo&url="+url;
    $.ajax({
        url: requestStr,
        error: function (jqXHR, textStatus, errorThrown) {
            alert (textStatus);
        },success: function (data, status) {
            window.location = "http://www.stutzen.me/lab/emote/feed-v2.html"
        }
    });
}*/
function bing_img_setHeader(xhr) {
    xhr.setRequestHeader('Authorization', "Basic " + bing_img_accountKeyEncoded);
}

function bing_img_send_request() {
//Build up the URL for the request
    var  query = $("#img_search_query_text").val();
    if(query.length<1) return;
//https://api.datamarket.azure.com/Bing/Search/Composite?Sources=%27Web%2BNews%27&Query=
    var requestStr = "https://api.datamarket.azure.com/Data.ashx/Bing/Search/v1/Image?Query=%27"+query+"%27&$top=20&$format=json&ImageFilters=%27Aspect%3aWide%2bSize%3aMedium%27";

    $.ajax({
        url: requestStr,
        beforeSend: bing_img_setHeader,
        dataType:'json',
        context: this,
        type: 'GET',
        success: function (data, status) {
            var results = data;
            var tbl="";//<table cellspacing=5 cellpadding=5 style=\"width:100%;border 1px solid black\">";
            var imgwidth= $(document).width()/3;
            $.each(data.d.results, function (i) {
                   /* if(i%3==0){
                        tbl+="</tr><tr>";
                    }
                    tbl+="<td>" +
                        "<img class='img_search_result_image' src='" + data.d.results[i].Thumbnail.MediaUrl + "' imageurl="+data.d.results[i].MediaUrl+" />" +
                        "</td>";
*//**/
                    tbl+="<div class='img_search_result_div'>" +
                        "<img  style='width:"+imgwidth+";height:"+imgwidth+";' class='img_search_result_image' src='" + data.d.results[i].Thumbnail.MediaUrl + "' imageurl="+data.d.results[i].MediaUrl+" />" +
                        "</div>";
                }
            );
            tbl+="";
            $("#img_search_results").append(tbl);
            $(".img_search_result_image").click(onWebImageResultClick);
           /* $( ".imag" ).click(function(e) {
                $( "#popupimg" ).attr('src', this.attributes['imageurl'].value );
                $( "#popup" ).dialog( "open" );
            });*/
            /*recalc();*/
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert (textStatus);
        }
    });
}

function recalc()
{
    var box = $('.box').width();
    $('.box').css('height', box);
}
  /*

$(window).resize(function(){
    recalc();
});*/



/*
function showResults(item){
    var p=document.createElement('p');
    var a=document.createElement('a');
    var i=document.createElement('img');
    a.href=item.MediaUrl;
    i.src=item.Thumbnail.MediaUrl;
    $(a).append(i);
    $(p).append(item.Title);
//$('#Results').append(a,p);
}
*/

function base64_encode(data) {

    var b64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    var o1, o2, o3, h1, h2, h3, h4, bits, i = 0,
        ac = 0,
        enc = "",
        tmp_arr = [];

    if (!data) {
        return data;
    }

    do { // pack three octets into four hexets
        o1 = data.charCodeAt(i++);
        o2 = data.charCodeAt(i++);
        o3 = data.charCodeAt(i++);

        bits = o1 << 16 | o2 << 8 | o3;

        h1 = bits >> 18 & 0x3f;
        h2 = bits >> 12 & 0x3f;
        h3 = bits >> 6 & 0x3f;
        h4 = bits & 0x3f;

        // use hexets to index into b64, and append result to encoded string
        tmp_arr[ac++] = b64.charAt(h1) + b64.charAt(h2) + b64.charAt(h3) + b64.charAt(h4);
    } while (i < data.length);

    enc = tmp_arr.join('');

    var r = data.length % 3;

    return (r ? enc.slice(0, r - 3) : enc) + '==='.slice(r || 3);
}