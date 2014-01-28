<!-- HTML -->
<form id="emoteSave" method="post" enctype="multipart/form-data">
    <div id="emote-creation-container">
        <div class="data-set clearfix">
            <div class="emote-create-content">
                <input type="hidden" name="topx" value="451">
                <input type="hidden" name="topy" value="445">
                <input type="hidden" name="bottomx" value="1080">
                <input type="hidden" name="bottomy" value="800">
                <input type="hidden" name="scaledImgWidth" value="800">
                <input type="hidden" name="scaledImgHeight" value="800">
                <input type="hidden" name="webSearchImageURL" value="">

                <input required type="text" id="obj-title" class="emote-topic-input hash" maxlength="50" value="" placeholder="" name="title" />
                <div id="obj-title-suggestion"></div>
                <input required type="text" id="tag" class="emote-tags-input" maxlength="25" placeholder="" name="expression" />
                <input type="hidden" id="goodOrBad" name="goodOrBad"/>
                <div id="photoBar"><img id="file-preview" src="#" alt="your image" /></div>
                <a href="#" id="doing-now" class="gradient silver-gradient button big icon-button"><span class="indicator"></span>Doing now</a>

                <div id="emote-bar">
                    <div id="emote-bar-container">
                        <select required id="category" name="category" >
                            <option value="">--Pick Category--</option>
                            <option value="Event">Event</option>
                            <option value="Movie">Movie</option>
                            <option value="Restaurant">Restaurant</option>
                            <option value="Food-item">Food item</option>
                            <option value="People">People</option>
                            <option value="Place">Place</option>
                            <option value="Consumer-Product">Consumer Product</option>
                            <option value="Other">Other</option>
                        </select>
                        <!-- <a href="#" id="addimage-button" ><i class="icon icon-camera"></i></a> -->
                        <div class="pull-right">
                            <a href="#" class="button silver-gradient gradient" id="feeds-share-icon-link"><span class="feeds-sprite feeds-share-icon ir ib">Share</span></a>
                            <button type="submit" id="post-emote" class="button icon-button big grey-gradient gradient" value="Save" onClick="_gaq.push(['_trackEvent', 'Emotes', document.getElementById('category').options[document.getElementById('category').selectedIndex].value, 'Add', 1, false]);"><span class="edit-button"></span>POST</button>
                        </div>
                    </div> <!-- /#emote-bar-container -->
                </div> <!-- /#emote-bar -->
            </div> <!-- /.emote-create-content -->
        </div> <!-- /.data-set -->
    </div> <!-- /#emote-creation-container -->
    <g:render template="/common/img_selection" />
 </form>