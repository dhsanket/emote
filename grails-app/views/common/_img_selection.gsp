<g:uploadForm controller="emote" action="savePhoto" name="photoSaveForm">
    <input type="hidden" name="title">
    <input type="hidden" name="topx" value="451">
    <input type="hidden" name="topy" value="445">
    <input type="hidden" name="bottomx" value="1080">
    <input type="hidden" name="bottomy" value="800">
    <input type="hidden" name="scaledImgWidth" value="800">
    <input type="hidden" name="scaledImgHeight" value="800">
    <input type="hidden" name="webSearchImageURL" value="">

    <div id="imgchooserpopup" class="popupzen" style="position:static;">
        <div id="popup-container">
            <div id="fullscreen-dialog">
                <div class="error"></div>
                <input type="file" id="pic" name="photo" title="Device" onClick="emptyImageFileElement();_gaq.push(['_trackEvent', 'Picture', 'Add', 'Local Storage', 1, false]);" onchange="fileSelectHandler()" >

                <button id="img_search_button" value="Web" onClick="_gaq.push(['_trackEvent', 'Picture', 'Add', 'Web', 1, false]);"> Image from web</button>

                <button value="Cancel" class="cancel-button" >Back</button>
            </div> <!-- /#fullscreen-dialog -->
        </div> <!-- /#popup-container -->
    </div> <!-- /#imgchooserpopup -->

    
</g:uploadForm>