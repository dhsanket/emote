package com.emote

class PictureController {
	
	PictureService pictureService
    def index() { 
		Picture pic = pictureService.getImage(params.id)
		response.setContentLength(pic.content.length)
		response.setContentType(pic.contetType)
		response.outputStream << pic.content
		response.outputStream.flush()
	}
	

	
	def upload(){
	}
	
	def save(){
//		params.entrySet().each {p ->
//			log.info " param -  $p"
//		}
		log.info params.content.contentType
		
		def img = new Picture(params)
		img.contetType = params.content.contentType
		def id = pictureService.store(img)
		render(model:[pic:id], view:'show')
	}
}
