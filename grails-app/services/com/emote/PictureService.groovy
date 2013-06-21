package com.emote

class PictureService {

    def getImage(String id) {
		return Picture.findById(id)
    }
	
	def store(Picture image){
		image.save()
		log.info "saved image of size $image.content.length and id = $image.id type= $image.type"
		return image.id
	}
}
