<div class="popupzen" id="imgchooserpopup" style="position:static;">
<%--    <div id="feed-container" class="feed-container">--%>
    <div id="popup-container">
		
        <div id="fullscreen-dialog">
        <div class="error">
        </div>
        
        <input form="emoteSave" type="file" id="pic" name="photo" title="Device" onClick="emptyImageFileElement();_gaq.push(['_trackEvent', 'Picture', 'Add', 'Local Storage', 1, false]);" onchange="fileSelectHandler()" >
        
        <button id="img_search_button" value="Web" onClick="_gaq.push(['_trackEvent', 'Picture', 'Add', 'Web', 1, false]);"> Image from web</button>
        
        <button value="Cancel" class="cancel-button" >Back</button>
    	</div>
    </div>
    </div>
</div>