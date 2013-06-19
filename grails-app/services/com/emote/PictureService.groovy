package com.emote

class PictureService {

    def getImage(String id) {
		return Picture.findById(id)
    }
	
	def store(Picture image){
		log.info "saved image of type $image.contentType"
		image.save()
		log.info "saved image of size $image.content.length and id = $image.id"
		return image.id
	}
}
