<!-- HTML -->
 <form method="post" id="emoteSave" method="post" enctype="multipart/form-data">
 <div id="emote-creation-container">

  <div class="data-set clearfix">
   <div class="edit-emote-header">
  <div></div>
  <h3></h3>
  <p></p>
  </div>     
		<div class="emote-create-content">
			<input type="hidden" name="topx" value="451">
			<input type="hidden" name="topy" value="445">
			<input type="hidden" name="bottomx" value="1080">
			<input type="hidden" name="bottomy" value="800">
			<input type="hidden" name="scaledImgWidth" value="800">
			<input type="hidden" name="scaledImgHeight" value="800">
			<input type="hidden" name="webSearchImageURL" value="">
			<div id="create-emote-field-container">
				<input required type="text" id="obj-title" class="emote-topic-input input-field" maxlength="50" placeholder="" name="title" />
				<div id="in-input-field"><span>&nbsp;</span></div>
				<input type="text" id="obj-title-location" class="emote-topic-input input-field" maxlength="50" placeholder="" name="location" />
				<div id="obj-title-suggestion"></div>
				<input required type="text" id="tag" class="emote-tags-input" maxlength="25" placeholder="" name="expression" />
				<button class="button-off" id="doing-now" type="button" value="Doing now"><span class="doing-now-off">Doing now</span></button>
				<input type="hidden" name="doingNow" id="doing-now-input" value="false"/>
				<div class="clearfix" id="emote-share-bar">
					<button class="button-off" id="pick-a-category" type="button" value="Pick a category"><span>-- Pick a category --</span></button>
					<ul id="category-list">
						<li>-- Pick a category --</li>
						<li>Event</li>
						<li>Movie</li>
						<li>Restaurant</li>
						<li>Food-item</li>
						<li>People</li>
						<li>Place</li>
						<li>Consumer-Product</li>
						<li>Other</li>
					</ul>
					<input type="hidden" name="category" id="category" required />
					<button class="button-off" id="post-emote" type="submit" value="Post" onClick="_gaq.push(['_trackEvent', 'Emotes', document.getElementById('category').value, 'Add', 1, false]);"><span>POST</span></button>
					<button class="button-off" id="share-emote" type="button" value="Share"><span>&nbsp;</span></button>
					<input type="hidden" name="share" id="share-input" value="false"/>
				</div>
			</div>
			
			<div id="photoBar"> <img id="file-preview" src="#" alt="your image" /> </div>
 			
			<div id="emote-bar" class="emote-v2-footer clearfix">
				<ul class="emote-v2-actions-left">
					<li>
						<button id="addimage-button"  ><img src="/img/add_photo.png"/></button>
					</li>
				</ul>				
			</div>
		</div>
  
  </div>
 </div>
 <g:render template="/common/img_selection" /> 
 </form>





