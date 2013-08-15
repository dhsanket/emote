package com.emote

class PictureController {
	
	static layout = 'upload'
	
	PictureService pictureService
    def index() {
		cache neverExpires:true, shared:true 
		Picture pic = pictureService.getImage(params.id)
		response.setContentLength(pic.content.length)
		response.setContentType(pic.type)
		response.outputStream << pic.content
		response.outputStream.flush()
	}
	

	
	def upload(){
	}
	
	def save(){
		String type = params.content.contentType
		String filename = params.content.originalFilename
		def img = new Picture(params)
		img.type = type
		img.filename = filename
		
		log.info "image content type is $img.type"
		def id = pictureService.store(img)
		render(model:[pic:id], view:'show')
	}
}
