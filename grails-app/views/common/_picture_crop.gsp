<div id="picture_crop_container" style="position:static;">
    <div style="width: 100%;overflow: hidden;height:100%;position:fixed;left:0px;top:30px;z-index:19;background-color:black;">
        <br>
        <h5 style="color:#f5f5f5;">Select a region to crop</h5>
        <img id="upload_preview_img"/>
        <div style="width:100%;position:absolute;bottom:30px;text-align: center;">
            <span>
                <button style="width: 45%;" type="button" id="picturecropper-ok-button" value="Ok" onClick="_gaq.push(['_trackEvent', 'Picture', 'Add', 'Successful', 1, false]);"> Ok </button>
            </span>
            <span>
                <button style="width: 45%;" type="button" id="picturecropper-cancel-button" value="Cancel"> Cancel </button>
            </span>
        </div>
    </div>
</div> <!-- /#picture_crop_container -->