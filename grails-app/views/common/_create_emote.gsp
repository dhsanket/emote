<!-- HTML -->
 <form method="post" id="emoteSave" method="post" enctype="multipart/form-data">
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
			<input required type="text" id="obj-title" class="emote-topic-input" maxlength="50" placeholder="" name="title" />
			<div id="obj-title-suggestion"></div>
			<input required type="text" id="tag" class="emote-tags-input" maxlength="25" placeholder="" name="expression" />
			<div id="photoBar"> <img id="file-preview" src="#" alt="your image" /> </div>
			
<%--            <input type="file" id="pic" name="photo" title="Upload photo" onchange="fileSelectHandler()" >--%>
			
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
					
		<%--			<a href="#" id="geoLocation" class="header-icon"><i class="icon icon-screenshot"></i></a>--%>
		<%--			<a href="#" id="cameraInit" class="header-icon"><i class="icon icon-camera"></i></a>--%>
                    <a href="#" id="addimage-button" ><i class="icon icon-camera"></i></a>
					<button type="submit" id="submit-button" value="Save"> <i class="icon icon-check"></i> </button>
				</div>
			</div>
		</div>
  
  </div>
 </div>
 <g:render template="/common/img_selection" />
 </form>




