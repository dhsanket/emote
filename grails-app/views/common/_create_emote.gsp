<!-- HTML -->
 <form method="post" id="emoteSave">
 <div id="emote-creation-container">
  
  <div class="data-set clearfix">
      
		<div class="emote-create-content">
			<input required type="text" id="obj-title" class="emote-topic-input" maxlength="50" placeholder="" name="title" />
			<div id="obj-title-suggestion"></div>
			<input required type="text" id="tag" class="emote-tags-input" maxlength="25" placeholder="" name="expression" />
			<div id="emote-bar">
				<div id="emote-bar-container">
			<select required id="category" name="categoryList" form="emoteSave">
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
			<button type="submit" id="submit-button" value="Save"> publish emote </button>
			</div>
			</div>
		</div>
  
  </div>
 </div>
 </form>




